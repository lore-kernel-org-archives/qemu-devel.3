Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD17C9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 01:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdp3-00042q-D1; Sun, 18 Jan 2026 20:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vhdp1-00042A-OG
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:12:47 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vhdoz-0002Xm-9E
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=dJJ2DBurGOUBL1jiR2YLOEFL4O4UimDydNeEGfPlkf8=; b=aUvtAGkvPmg75P7F
 g1JxHi8Qy5xJ781n+tSJoUUF+O2gNBF818ctnhuivisOQJ1LADSa6IAY8uySkJcw03vPhT49FzIie
 pbCmuDLqIdKs7k9ateuRA6JV4mdfjMoqF1DJ7UjIgU1OYMsA/vzQLXTK7q+GwkPSpJA8lXHGmcdun
 k131eYSjpr4FvU3D5HWm56dq6DoOHsGLUyn8fGaNRg4UQfhKYH3GqsoIwFMvsbNeZL9QdldJ5cjCt
 Qh2b2prvBbnYSIXJVZK4uU+EdPjp1rKmlYcyPSEEusRL0K9fq19t5bL0mliq77dRMC/uUz7jZ3iEN
 E+sugXBgXHN5mC7rGg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vhdox-0000000Fesu-0awh;
 Mon, 19 Jan 2026 01:12:43 +0000
Date: Mon, 19 Jan 2026 01:12:43 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 5/8] monitor: Have *get_monitor_def() fill an unsigned
 value
Message-ID: <aW2FC51tR0k8ZR8O@gallifrey>
References: <20260117162926.74225-1-philmd@linaro.org>
 <20260117162926.74225-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260117162926.74225-6-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 01:06:44 up 84 days, 43 min,  2 users,  load average: 0.00, 0.01,
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
> target_get_monitor_def() fills an unsigned value.
> Have get_monitor_def() fill an unsigned value too.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  monitor/monitor-internal.h | 2 +-
>  monitor/hmp-target.c       | 4 ++--
>  monitor/hmp.c              | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index feca111ae31..8dc88963630 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -181,7 +181,7 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
>  void coroutine_fn monitor_qmp_dispatcher_co(void *data);
>  void qmp_dispatcher_co_wake(void);
>  
> -int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
> +int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name);
>  void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
>  int hmp_compare_cmd(const char *name, const char *list);
>  
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 3fb4fb12508..ead195f5616 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -63,7 +63,7 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
>   * Set @pval to the value in the register identified by @name.
>   * return 0 if OK, -1 if not found
>   */
> -int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
> +int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
>  {
>      const MonitorDef *md = target_monitor_defs();
>      CPUState *cs = mon_get_cpu(mon);
> @@ -100,7 +100,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>  
>      ret = target_get_monitor_def(cs, name, &tmp);
>      if (!ret) {
> -        *pval = (target_long) tmp;
> +        *pval = (target_ulong)tmp;
>      }
>  
>      return ret;
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 0a5bbf82197..eee8b7e964e 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -376,7 +376,7 @@ static int64_t expr_unary(Monitor *mon)
>      case '$':
>          {
>              char buf[128], *q;
> -            int64_t reg = 0;
> +            uint64_t reg = 0;

I'm a bit surprised the 'n = reg' where n is an int64_t doesn't
generate a warning.  Mind you, the 'n = strtoull(..)' has
been there for ages.
But, if it doesn't, then I'm hmm, ok, as you say above all the
data started out unsigned anyway.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>


>              pch++;
>              q = buf;
> -- 
> 2.52.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

