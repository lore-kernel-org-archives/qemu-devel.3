Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F089CFF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGd4s-0006JP-H8; Sat, 25 Apr 2026 09:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wGd4j-0006J9-LK
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:29:39 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wGd4h-0003lT-QA
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=pbB/29eORXBUy7oT1d4HmyVaXCPX+4ZkEIWYyYq8G8Q=; b=hL9lyOd8w1jSpAhE
 ypzW2yqM7+mNhL8gd2W9fy8aPQmbVySS6ITFoJNTut2bScbIdFRR9yaGjrcWgduwUcePRoQvPfv/c
 NaVtbIwHLtIFfXuR/lB8D2k4rwnHJdnhYd2klFjhG5tgXx4ohMw+dPYVqqgrUHekojEbrxRDgPAYG
 c8smsUbutOoiaFaRhr5PiePhL8iS7hW4saMEJPrxlXxn9MBd2sYeGXxlM7YxM9BY+sdfXroaekIs/
 xh6ySeNUM/M8W9hhBORYB8iY5swd/dd5IEPy2Gn8Eo6bK998cXMlXt66Bops+6WfNoZVl4sdpZaX0
 6DgT9LjSeNlqmpppBg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wGd4b-0000000AiUt-3ziF;
 Sat, 25 Apr 2026 13:29:29 +0000
Date: Sat, 25 Apr 2026 13:29:29 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: AlanoSong@163.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH v2 1/1] monitor: Add `clear` command
Message-ID: <aezBuTRxnq90ClOg@gallifrey>
References: <20260425125113.37341-1-AlanoSong@163.com>
 <20260425125113.37341-2-AlanoSong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260425125113.37341-2-AlanoSong@163.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 13:29:19 up 43 days, 14:42,  2 users,  load average: 0.02, 0.02, 0.00
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

* AlanoSong@163.com (AlanoSong@163.com) wrote:
> The monitor screen can be cluttered after executing commands
> like `info qtree`. It is useful to have a command to clear
> current screen, just like linux `clear` command do.
> 
> This patch has been tested under monitors using stdio, vc,
> tcp socket, unix socket and serial interfaces.
> 
> Signed-off-by: Alano Song <AlanoSong@163.com>

Thanks for fixing that.


Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  hmp-commands.hx       | 14 ++++++++++++++
>  include/monitor/hmp.h |  1 +
>  monitor/hmp-cmds.c    | 11 +++++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 5cc4788f12..95f9166732 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -20,6 +20,20 @@ SRST
>    Show the help for all commands or just for command *cmd*.
>  ERST
>  
> +    {
> +        .name       = "clear",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "clear the monitor screen",
> +        .cmd        = hmp_clear,
> +        .flags      = "p",
> +    },
> +
> +SRST
> +``clear``
> +  Clear the monitor screen.
> +ERST
> +
>      {
>          .name       = "commit",
>          .args_type  = "device:B",
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index e222bea60c..9b66458d21 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -165,6 +165,7 @@ void hmp_trace_event(Monitor *mon, const QDict *qdict);
>  void hmp_trace_file(Monitor *mon, const QDict *qdict);
>  void hmp_info_trace_events(Monitor *mon, const QDict *qdict);
>  void hmp_help(Monitor *mon, const QDict *qdict);
> +void hmp_clear(Monitor *mon, const QDict *qdict);
>  void hmp_info_help(Monitor *mon, const QDict *qdict);
>  void hmp_info_sync_profile(Monitor *mon, const QDict *qdict);
>  void hmp_info_history(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index bc26b39d70..608a208c6e 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -218,6 +218,17 @@ void hmp_help(Monitor *mon, const QDict *qdict)
>      hmp_help_cmd(mon, qdict_get_try_str(qdict, "name"));
>  }
>  
> +void hmp_clear(Monitor *mon, const QDict *qdict)
> +{
> +    /*
> +     * Send an ANSI escape sequence:
> +     * "\x1b[H" - move cursor to top-left
> +     * "\x1b[2J" - clear visible screen
> +     * "\x1b[3J" - clear scrollback
> +     */
> +    monitor_printf(mon, "\x1b[H\x1b[2J\x1b[3J");
> +}
> +
>  void hmp_info_help(Monitor *mon, const QDict *qdict)
>  {
>      hmp_help_cmd(mon, "info");
> -- 
> 2.43.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

