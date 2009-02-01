{include file='header.tpl' menu='talk'}

			<script type="text/javascript" src="{$DIR_STATIC_SKIN}/js/comments.js"></script>
			
			<div class="topic talk">				
				<h1 class="title">{$oTalk->getTitle()|escape:'html'}</h1>				
				<ul class="action">
					<li><a href="{$DIR_WEB_ROOT}/{$ROUTE_PAGE_TALK}/">Почтовый ящик</a></li>
					<li class="delete"><a href="{$DIR_WEB_ROOT}/{$ROUTE_PAGE_TALK}/delete/{$oTalk->getId()}/"  onclick="return confirm('Действительно удалить переписку?');">Удалить переписку</a></li>
				</ul>				
				<div class="content">
					{$oTalk->getText()}				
				</div>				
				<ul class="voting">
					<li class="date">{date_format date=$oTalk->getDate()}</li>
					<li class="author"><a href="{$DIR_WEB_ROOT}/{$ROUTE_PAGE_PROFILE}/{$oTalk->getUserLogin()}/">{$oTalk->getUserLogin()}</a></li>
				</ul>
			</div>
			
			<div class="comments">
							
				<!-- Comments Header -->
				<div class="header">
					{if $oTalk->getCountComment()}<h3>Переписка ({$oTalk->getCountComment()}){/if}</h3>					
				</div>
				<!-- /Comments Header -->
				
				<!-- Comment -->

				{assign var="nesting" value="-1"}
				{foreach from=$aCommentsNew item=aComment name=rublist}
   					{if $nesting < $aComment.level}        
    				{elseif $nesting > $aComment.level}    	
        				{section name=closelist1  loop=`$nesting-$aComment.level+1`}</div></div>{/section}
    				{elseif not $smarty.foreach.rublist.first}
        				</div></div>
    				{/if}    
    				<div class="comment" id="comment_id_{$aComment.obj->getId()}">    					
							<img src="{$DIR_STATIC_SKIN}/images/close.gif" alt="+" title="Свернуть ветку комментариев" class="folding" />
							<a name="comment{$aComment.obj->getId()}" ></a>													
							<div id="comment_content_id_{$aComment.obj->getId()}" class="content {if $oUserCurrent and $aComment.obj->getUserId()==$oUserCurrent->getId()}self{else}{if $oTalk->getDateLastRead()<=$aComment.obj->getDate()}new{/if}{/if}">																							
								<div class="tb"><div class="tl"><div class="tr"></div></div></div>								
								<div class="text">
									{$aComment.obj->getText()}
								</div>				
								<div class="bl"><div class="bb"><div class="br"></div></div></div>
							</div>							
							<div class="info">
								<a href="{$DIR_WEB_ROOT}/{$ROUTE_PAGE_PROFILE}/{$aComment.obj->getUserLogin()}/"><img src="{$aComment.obj->getUserProfileAvatarPath(24)}" alt="avatar" class="avatar" /></a>
								<p><a href="{$DIR_WEB_ROOT}/{$ROUTE_PAGE_PROFILE}/{$aComment.obj->getUserLogin()}/" class="author">{$aComment.obj->getUserLogin()}</a></p>
								<ul>
									<li class="date">{date_format date=$aComment.obj->getDate()}</li>									
									<li><a href="javascript:lsCmtTree.toggleCommentForm({$aComment.obj->getId()});" class="reply-link">Ответить</a></li>																		
									<li><a href="#comment{$aComment.obj->getId()}" class="imglink link"></a></li>																		
								</ul>
							</div>							
							<div class="reply" id="reply_{$aComment.obj->getId()}" style="display: none;"></div>									
							<div class="comment-children" id="comment-children-{$aComment.obj->getId()}">    
    				{assign var="nesting" value="`$aComment.level`"}    
    				{if $smarty.foreach.rublist.last}
        				{section name=closelist2 loop=`$nesting+1`}</div></div>{/section}    
    				{/if}
				{/foreach}
				
				<span id="comment-children-0"></span>				
				<br>				
						<h3 class="reply-title"><a href="javascript:lsCmtTree.toggleCommentForm(0);">Ответить</a></h3>
						<div style="display: block;" id="reply_0" class="reply">				
						<form action="" method="POST" id="form_comment"  enctype="multipart/form-data">
    						<textarea name="comment_text" id="form_comment_text" style="width: 100%; height: 100px;"></textarea>    	
    						<input type="submit" name="submit_comment" value="добавить">    	
    						<input type="hidden" name="reply" value="0" id="form_comment_reply">    						
    					</form>					
						</div>
					
				<!-- /Comments -->
			</div>



{include file='footer.tpl'}