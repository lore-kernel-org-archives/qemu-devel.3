Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47518C9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 00:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdUg-0003pu-MT; Sun, 18 Jan 2026 19:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vhdTu-0003aw-Nz
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:51:05 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vhdTq-0007L7-Po
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=NDigq1LK0rR4uYH//Em4zAT3WceKTgcxIZcQGZALPK8=; b=CzdB7yo+ZgvcnR5m
 JimABfCx2wmG4MW7crc6Od571tmGUSbQKZnvZRzou1bxq45kNjm95eYX0RuWEbFWSJajgk72Mteg8
 IJ8yvfztvIzsgEruZ+cz94SptqAGRWPYm4Zh3z6urU2QMzUBCyRrmzchAHy2QvR06NgtEcdpMSSmV
 I5KVQbQSRXbLoh8hSw6YLi+8LoZTGYVuICX5bO+Oom0eOf9S6vs/PLntCNDcGfIq+jm8RkUGWvT/u
 XyG6L0aYoJYa7zmTK4fxflcBeAQMSxRfGqyrYJiv9bSRBkMM26qtC8iFmATI4xKKcRL1shDQxiyA6
 K0Hz6fmdE89oTY5xHQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vhdTm-0000000FepZ-2MaQ;
 Mon, 19 Jan 2026 00:50:50 +0000
Date: Mon, 19 Jan 2026 00:50:50 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 3/8] monitor: Reduce target-specific methods
Message-ID: <aW1_6lacDJaXHCFj@gallifrey>
References: <20260117162926.74225-1-philmd@linaro.org>
 <20260117162926.74225-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260117162926.74225-4-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 00:50:40 up 84 days, 26 min,  2 users,  load average: 0.00, 0.00,
 0.00
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

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> The following methods don't use target-specific code anymore:
> - hmp_compare_cmd()
> - monitor_register_hmp()
> - monitor_register_hmp_info_hrt()
> Move them to hmp.c which is target-agnostic, being built once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  monitor/hmp-target.c | 57 --------------------------------------------
>  monitor/hmp.c        | 55 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 57 deletions(-)
> 
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 59c60d13b52..420969bd6eb 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -33,8 +33,6 @@
>  #include "qapi/qapi-commands-control.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qapi-commands-machine.h"
> -#include "qapi/error.h"
> -#include "qemu/cutils.h"
>  
>  #if defined(TARGET_S390X)
>  #include "hw/s390x/storage-keys.h"
> @@ -44,29 +42,6 @@
>  /* Make devices configuration available for use in hmp-commands*.hx templates */
>  #include CONFIG_DEVICES
>  
> -/**
> - * Is @name in the '|' separated list of names @list?
> - */
> -int hmp_compare_cmd(const char *name, const char *list)
> -{
> -    const char *p, *pstart;
> -    int len;
> -    len = strlen(name);
> -    p = list;
> -    for (;;) {
> -        pstart = p;
> -        p = qemu_strchrnul(p, '|');
> -        if ((p - pstart) == len && !memcmp(pstart, name, len)) {
> -            return 1;
> -        }
> -        if (*p == '\0') {
> -            break;
> -        }
> -        p++;
> -    }
> -    return 0;
> -}
> -
>  /* Please update hmp-commands.hx when adding or changing commands */
>  static HMPCommand hmp_info_cmds[] = {
>  #include "hmp-commands-info.h"
> @@ -147,35 +122,3 @@ static void __attribute__((__constructor__)) sortcmdlist(void)
>            sizeof(*hmp_info_cmds),
>            compare_mon_cmd);
>  }
> -
> -void monitor_register_hmp(const char *name, bool info,
> -                          void (*cmd)(Monitor *mon, const QDict *qdict))
> -{
> -    HMPCommand *table = hmp_cmds_for_target(info);
> -
> -    while (table->name != NULL) {
> -        if (strcmp(table->name, name) == 0) {
> -            g_assert(table->cmd == NULL && table->cmd_info_hrt == NULL);
> -            table->cmd = cmd;
> -            return;
> -        }
> -        table++;
> -    }
> -    g_assert_not_reached();
> -}
> -
> -void monitor_register_hmp_info_hrt(const char *name,
> -                                   HumanReadableText *(*handler)(Error **errp))
> -{
> -    HMPCommand *table = hmp_cmds_for_target(true);
> -
> -    while (table->name != NULL) {
> -        if (strcmp(table->name, name) == 0) {
> -            g_assert(table->cmd == NULL && table->cmd_info_hrt == NULL);
> -            table->cmd_info_hrt = handler;
> -            return;
> -        }
> -        table++;
> -    }
> -    g_assert_not_reached();
> -}
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 17e5756986f..0a5bbf82197 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1497,3 +1497,58 @@ void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
>                               monitor_event, NULL, &mon->common, NULL, true);
>      monitor_list_append(&mon->common);
>  }
> +
> +/**
> + * Is @name in the '|' separated list of names @list?
> + */
> +int hmp_compare_cmd(const char *name, const char *list)
> +{
> +    const char *p, *pstart;
> +    int len;
> +    len = strlen(name);
> +    p = list;
> +    for (;;) {
> +        pstart = p;
> +        p = qemu_strchrnul(p, '|');
> +        if ((p - pstart) == len && !memcmp(pstart, name, len)) {
> +            return 1;
> +        }
> +        if (*p == '\0') {
> +            break;
> +        }
> +        p++;
> +    }
> +    return 0;
> +}
> +
> +void monitor_register_hmp(const char *name, bool info,
> +                          void (*cmd)(Monitor *mon, const QDict *qdict))
> +{
> +    HMPCommand *table = hmp_cmds_for_target(info);
> +
> +    while (table->name != NULL) {
> +        if (strcmp(table->name, name) == 0) {
> +            g_assert(table->cmd == NULL && table->cmd_info_hrt == NULL);
> +            table->cmd = cmd;
> +            return;
> +        }
> +        table++;
> +    }
> +    g_assert_not_reached();
> +}
> +
> +void monitor_register_hmp_info_hrt(const char *name,
> +                                   HumanReadableText *(*handler)(Error **errp))
> +{
> +    HMPCommand *table = hmp_cmds_for_target(true);
> +
> +    while (table->name != NULL) {
> +        if (strcmp(table->name, name) == 0) {
> +            g_assert(table->cmd == NULL && table->cmd_info_hrt == NULL);
> +            table->cmd_info_hrt = handler;
> +            return;
> +        }
> +        table++;
> +    }
> +    g_assert_not_reached();
> +}
> -- 
> 2.52.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

