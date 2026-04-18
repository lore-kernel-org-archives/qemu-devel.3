Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25BCF99C89
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 17:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wE9Oi-0001oe-EY; Sat, 18 Apr 2026 13:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wE9Og-0001oS-93
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 13:23:58 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wE9Oe-0002bD-FH
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 13:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=3t+fy2EL4xXM00RrefsohQy4j3KLnHQ9yjTAw65Ve0M=; b=dORqS86PvUL2c1df
 3xXw0/3E54Lce2zmSsRV0sZke4Q+cycnZQcMloQibgnDYrYczE0yXgQPQhsWIRERjEN/UtQlXEIie
 UN+RnqRNi5w/nfBNUtWGbsUM9wv79rax1Lcmgobk2CtNCg4j17Cc+k0ZTd6/sdFlqwFIkxM0X0NKf
 hrtyWrIM2lAXpSroGo/zGVw8FSWRDpx5OaEhcs3Zp+7G20vhmMX3r+35LQnREX/QSJR7v4tgvcyur
 5NXyrHEcA9OxNyKFps4O0weSHjMkPtKgI0JcliyJvBHY+zbIcoS9ZIaAnwf7WbsN7K6P1VuhLv39X
 F4m+ixf5ch0eJas2Fw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wE9OU-000000099C1-3ZlI;
 Sat, 18 Apr 2026 17:23:46 +0000
Date: Sat, 18 Apr 2026 17:23:46 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: AlanoSong@163.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] monitor: Add `clear` command
Message-ID: <aeO-IqKqBwtKfW8P@gallifrey>
References: <20260418133927.43012-1-AlanoSong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260418133927.43012-1-AlanoSong@163.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 17:23:23 up 36 days, 18:36,  2 users,  load average: 0.17, 0.05, 0.01
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

Does typing ctrl-l not do it for you in your terminal?

Dave

> ---
>  hmp-commands.hx       | 14 ++++++++++++++
>  include/monitor/hmp.h |  1 +
>  monitor/hmp-cmds.c    |  5 +++++
>  3 files changed, 20 insertions(+)
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
> index bc26b39d70..3e9485478e 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -218,6 +218,11 @@ void hmp_help(Monitor *mon, const QDict *qdict)
>      hmp_help_cmd(mon, qdict_get_try_str(qdict, "name"));
>  }
>  
> +void hmp_clear(Monitor *mon, const QDict *qdict)
> +{
> +    monitor_printf(mon, "\x1b[3J\x1b[2J\x1b[H");
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

