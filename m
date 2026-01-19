Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D404C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 02:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vheaF-00030g-Ol; Sun, 18 Jan 2026 21:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vheaE-0002yD-2Q
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 21:01:34 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vheaC-0001XO-3b
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 21:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Ckto5iO/ESpTeAUExBDfU5cRcP1v1nSTfW4PnnWP4NU=; b=OYUuh5C94K1SjYhL
 mPq2rTxA1AUmzdYxjwKszJupiWtJwv9sBdZ771dt/TcvMAUTzVfO2HFfFUuBS1R0mhq/ry/UMA2ip
 /s/PftU2Ltn0SYAZwmmbysfwVOKLyHx7ynSJTm3Sc/qDgmK1Na5KH5z2DIsr6uls0h93Be5w6ecad
 i/tcpRUEFp7OLB0RpytTByS94PL2dW4HAJkfb9SVPOPNumOnqBzsT5iE9gU5qAMZP49iksezV6oxR
 NrplN0yhZaOTIR5JdFQs6ec43Hhehedq47W0bM796wyGyIFVBAqKHcHFS6msFw8CLODTUax1Wiw/c
 6+BWAuf4+ZSPv6ETzw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vhea9-0000000Ff5O-49lF;
 Mon, 19 Jan 2026 02:01:29 +0000
Date: Mon, 19 Jan 2026 02:01:29 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 7/8] monitor: Reduce target-specific methods further
Message-ID: <aW2QeSBhCzoYKKMN@gallifrey>
References: <20260117162926.74225-1-philmd@linaro.org>
 <20260117162926.74225-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260117162926.74225-8-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 02:01:25 up 84 days,  1:37,  3 users,  load average: 0.00, 0.00, 0.00
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
> get_monitor_def() doesn't use any target-specific declaration
> anymore, move it to hmp.c to compile it once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  monitor/monitor-internal.h |  1 -
>  monitor/hmp-target.c       | 49 -----------------------------------
>  monitor/hmp.c              | 52 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+), 50 deletions(-)
> 
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 8dc88963630..3ecd394ecf6 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -181,7 +181,6 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
>  void coroutine_fn monitor_qmp_dispatcher_co(void *data);
>  void qmp_dispatcher_co_wake(void);
>  
> -int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name);
>  void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
>  int hmp_compare_cmd(const char *name, const char *list);
>  
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 01be0a0b426..a3306b69c93 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -23,7 +23,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/bswap.h"
>  #include "monitor-internal.h"
>  #include "monitor/qdev.h"
>  #include "net/slirp.h"
> @@ -60,54 +59,6 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
>      return info_command ? hmp_info_cmds : hmp_cmds;
>  }
>  
> -/*
> - * Set @pval to the value in the register identified by @name.
> - * return 0 if OK, -1 if not found
> - */
> -int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
> -{
> -    const unsigned length = target_long_bits() / 8;
> -    const MonitorDef *md = target_monitor_defs();
> -    CPUState *cs = mon_get_cpu(mon);
> -    uint64_t tmp = 0;
> -    int ret;
> -
> -    if (cs == NULL || md == NULL) {
> -        return -1;
> -    }
> -
> -    for(; md->name != NULL; md++) {
> -        if (hmp_compare_cmd(name, md->name)) {
> -            if (md->get_value) {
> -                *pval = md->get_value(mon, md, md->offset);
> -            } else {
> -                CPUArchState *env = mon_get_cpu_env(mon);
> -                void *ptr = (uint8_t *)env + md->offset;
> -
> -                switch(md->type) {
> -                case MD_I32:
> -                    *pval = *(uint32_t *)ptr;
> -                    break;
> -                case MD_TLONG:
> -                    *pval = ldn_he_p(ptr, length);
> -                    break;
> -                default:
> -                    *pval = 0;
> -                    break;
> -                }
> -            }
> -            return 0;
> -        }
> -    }
> -
> -    ret = target_get_monitor_def(cs, name, &tmp);
> -    if (!ret) {
> -        *pval = ldn_he_p(&tmp, length);
> -    }
> -
> -    return ret;
> -}
> -
>  static int
>  compare_mon_cmd(const void *a, const void *b)
>  {
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index eee8b7e964e..82d2bbdf77d 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -27,8 +27,10 @@
>  #include "hw/core/qdev.h"
>  #include "monitor-internal.h"
>  #include "monitor/hmp.h"
> +#include "monitor/hmp-target.h"
>  #include "qobject/qdict.h"
>  #include "qobject/qnum.h"
> +#include "qemu/bswap.h"
>  #include "qemu/config-file.h"
>  #include "qemu/ctype.h"
>  #include "qemu/cutils.h"
> @@ -311,6 +313,8 @@ void hmp_help_cmd(Monitor *mon, const char *name)
>  static const char *pch;
>  static sigjmp_buf expr_env;
>  
> +static int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name);
> +
>  static G_NORETURN G_GNUC_PRINTF(2, 3)
>  void expr_error(Monitor *mon, const char *fmt, ...)
>  {
> @@ -1552,3 +1556,51 @@ void monitor_register_hmp_info_hrt(const char *name,
>      }
>      g_assert_not_reached();
>  }
> +
> +/*
> + * Set @pval to the value in the register identified by @name.
> + * return 0 if OK, -1 if not found
> + */
> +static int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
> +{
> +    const unsigned length = target_long_bits() / 8;
> +    const MonitorDef *md = target_monitor_defs();
> +    CPUState *cs = mon_get_cpu(mon);
> +    uint64_t tmp = 0;
> +    int ret;
> +
> +    if (cs == NULL || md == NULL) {
> +        return -1;
> +    }
> +
> +    for(; md->name != NULL; md++) {
> +        if (hmp_compare_cmd(name, md->name)) {
> +            if (md->get_value) {
> +                *pval = md->get_value(mon, md, md->offset);
> +            } else {
> +                CPUArchState *env = mon_get_cpu_env(mon);
> +                void *ptr = (uint8_t *)env + md->offset;
> +
> +                switch(md->type) {
> +                case MD_I32:
> +                    *pval = *(uint32_t *)ptr;
> +                    break;
> +                case MD_TLONG:
> +                    *pval = ldn_he_p(ptr, length);
> +                    break;
> +                default:
> +                    *pval = 0;
> +                    break;
> +                }
> +            }
> +            return 0;
> +        }
> +    }
> +
> +    ret = target_get_monitor_def(cs, name, &tmp);
> +    if (!ret) {
> +        *pval = ldn_he_p(&tmp, length);
> +    }
> +
> +    return ret;
> +}
> -- 
> 2.52.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

