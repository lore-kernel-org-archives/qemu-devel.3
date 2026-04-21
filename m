Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABDCF94CA1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFFHn-0004o2-8K; Tue, 21 Apr 2026 13:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wFFHZ-0004kv-0O
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:53:09 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wFFHU-0005t0-CM
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=TW5jHW/KOJebUl7hjW49Ydia9tEBvWCgVMPDUCI1vCg=; b=phGVos0owXA3ZD7S
 6kOAtJ5rSoEQHE5OBZND2nxNeEfUm/X8PZwnz9WqtE381iZxuJk8QYxJeaOXPwu7z1SGxX+Gzociq
 hSKqZvSmh/6ghHNpx1eFzBAzm9bgCvUH8peLQbmAhs8M1fmr273A6lN37yNjHALNSr3AJVlZyoK0B
 4mRJq5DwCS8lrXmDNEUqgceCmrZORYECLdf+FWuIHl1V00IvnCJZwfambqjpOttxccIBrbTFSfG1S
 C5ALfz9DqyAKQZuaXnrRJ4DDbrOZrpQXEbl/HnwtCKU+jiVHJ445ioS4TMgGctIYSMECiOgT8yJwV
 vWOrT0oD5AaE2KltRw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wFFHK-00000009mM7-1ivs;
 Tue, 21 Apr 2026 17:52:54 +0000
Date: Tue, 21 Apr 2026 17:52:54 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Alano Song <alanosong@163.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] monitor: Add `clear` command
Message-ID: <aee5drWmWZ3Mnw3A@gallifrey>
References: <20260418133927.43012-1-AlanoSong@163.com>
 <aeO-IqKqBwtKfW8P@gallifrey>
 <142c6c8b.11e3.19da4b172c4.Coremail.alanosong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <142c6c8b.11e3.19da4b172c4.Coremail.alanosong@163.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 17:37:01 up 39 days, 18:50,  3 users,  load average: 0.09, 0.03, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Alano Song (alanosong@163.com) wrote:
> At 2026-04-19 01:23:46, "Dr. David Alan Gilbert" <dave@treblig.org> wrote:
> >* AlanoSong@163.com (AlanoSong@163.com) wrote:
> >> The monitor screen can be cluttered after executing commands
> >> like `info qtree`. It is useful to have a command to clear
> >> current screen, just like linux `clear` command do.
> >> 
> >> This patch has been tested under monitors using stdio, vc,
> >> tcp socket, unix socket and serial interfaces.
> >> 
> >> Signed-off-by: Alano Song <AlanoSong@163.com>
> >
> >Does typing ctrl-l not do it for you in your terminal?
> >
> >Dave
> >

Hi Alano,

> Yes, you are correct that ctrl-l provides basic screen clear,
> but the new `clear` command clears both visible screen and
> scrollback buffer, just like `clear` command does on my Ubuntu terminal.

> I still believe that this patch is useful:
> 1) Many linux users like me instinctively type `clear`
> when we want to tidy up the terminal.
> 2) Not everyone is aware of or remembers the ctrl-l shortcut.
>    A typed command is more discoverable, especially for new users
>    or those who don't use terminal shortcuts regularly.

OK, mainly because of the difference with the scrollback buffer which I
see is different. (Ctrl-l is a great one to know, it works in almost
everything, not just qemu, it's a basic ASCII control code going
back about 60 years)

Now to get to the magic line:

> >> +void hmp_clear(Monitor *mon, const QDict *qdict)
> >> +{
> >> +    monitor_printf(mon, "\x1b[3J\x1b[2J\x1b[H");

Firstly it would be great to comment this; as I read it,
this is:
   clear scrollback
   clear screen
   cursor back to top-left

But, this has a problem - for me on both mate-terminal and
terminator (but not konsole), this doesn't completely clear
the scrollback; it clears most of the scrollback, but leaves
about one page; my guess is what happens here is you clear
the scrollback, but then the current screen goes into it
after/when you clear it.

Looking at the output of the ncurses 'clear' command:

dg@dalek:~$ clear|xxd -g 1
00000000: 1b 5b 48 1b 5b 32 4a 1b 5b 33 4a                 .[H.[2J.[3J

it's got them in the opposite order, cursor, clear screen, clear scrollback
and that's fine in both mate-terminal/terminator & konsole.
(This is Fedora 44 with vte291-0.84.0-1.fc44.x86_64 being used by mate-terminal).
[I can't tell you if that's a bug in one or both of the terminals]

So please, flip the output around, and add a comment.

Thanks,

Dave
> >> +}
> >> +
> >>  void hmp_info_help(Monitor *mon, const QDict *qdict)
> >>  {
> >>      hmp_help_cmd(mon, "info");
> >> -- 
> >> 2.43.0
> >> 
> >-- 
> > -----Open up your eyes, open up your mind, open up your code -------   
> >/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> >\        dave @ treblig.org |                               | In Hex /
> > \ _________________________|_____ http://www.treblig.org   |_______/
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

