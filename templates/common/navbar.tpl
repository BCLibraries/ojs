{**
 * templates/common/navbar.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Navigation Bar
 *
 *}
<div id="navbar">
	<ul class="menu">
		<li id="home"><a href="{url page="index"}">{translate key="navigation.home"}</a></li>
		<li id="about"><a href="{url page="about"}">{translate key="navigation.about"}</a></li>

		{if $isUserLoggedIn}
			<li id="userHome"><a href="{url page="user"}">{translate key="navigation.userHome"}</a></li>
		{else}
			{** BEGIN Suppress login for Jesuits *}
                        {if $currentJournal && $currentJournal->getJournalId() == 11}
                                <li id="login"><a href="{url page="notification"}/subscribeMailList">Subscribe</li>
                        {else}
                                <li id="login"><a href="{url page="login"}">{translate key="navigation.login"}</a></li>
                        {/if}
                        {**END *}
                        {** BEGIN Change Register text for IHE 20140609 *}
                        {if !$hideRegisterLink}
                            {if $currentJournal}
                                {if $currentJournal->getJournalId() == 16}
                                        <li id="register"><a href="{url page="user" op="register"}">{translate key="navigation.registerihe"}</a></li>
                                {else}
                                        <li id="register"><a href="{url page="user" op="register"}">{translate key="navigation.register"}</a></li>
                                {/if}
                            {else}
                                   <li id="register"><a href="{url page="user" op="register"}">{translate key="navigation.register"}</a></li>
                            {/if}
                        {/if}
                        {**END *}
		{/if}{* $isUserLoggedIn *}

		{if $siteCategoriesEnabled}
			<li id="categories"><a href="{url journal="index" page="search" op="categories"}">{translate key="navigation.categories"}</a></li>
		{/if}{* $categoriesEnabled *}

		{if !$currentJournal || $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
			{** BEGIN Suppress search for BBAGT *}
			{if $currentJournal && $currentJournal->getJournalID() == 20}

			{else}
				<li id="search"><a href="{url page="search"}">{translate key="navigation.search"}</a></li>

			{/if}
			{** END **}
		{/if}

		{if $currentJournal && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
                {** BEGIN Suppress Current link for Integritas 20131101 *}
			{if $currentJournal && $currentJournal->getJournalID() == 20}
				<li id="current"><a href="{url page="issue" op="current"}">Current&nbsp;Issue</a></li>
			{elseif $currentJournal && $currentJournal->getJournalId() == 12}
			{else}
				<li id="current"><a href="{url page="issue" op="current"}">{translate key="navigation.current"}</a></li>
			{/if}
		{** END *}
			<li id="archives"><a href="{url page="issue" op="archive"}">{translate key="navigation.archives"}</a></li>
		{/if}

		{if $enableAnnouncements}
			<li id="announcements"><a href="{url page="announcement"}">{translate key="announcement.announcements"}</a></li>
		{/if}{* enableAnnouncements *}

		{call_hook name="Templates::Common::Header::Navbar::CurrentJournal"}

		{foreach from=$navMenuItems item=navItem key=navItemKey}
			{if $navItem.url != '' && $navItem.name != ''}
				<li class="navItem" id="navItem-{$navItemKey|escape}"><a href="{if $navItem.isAbsolute}{$navItem.url|escape}{else}{$baseUrl}{$navItem.url|escape}{/if}">{if $navItem.isLiteral}{$navItem.name|escape}{else}{translate key=$navItem.name}{/if}</a></li>
			{/if}
		{/foreach}
	</ul>
</div>
