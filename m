Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61753C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwh5v-0006cY-E4; Wed, 19 Aug 2026 10:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wwh5u-0006cL-5s
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:16:42 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wwh5s-0007fS-3h
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=HYGmfmrUVFvDFVTCMOlxN6ZBdtoDRmdMzAYSpdYJ2MY=; b=N0n0SNfqJwJkFIge
 1Y+GSjOMH/mVxmTMpQX/fTciv++/Ls3U6mZXcMbCPQFlP/cFmyyO2pWLm/76mnCdLAmbZnrjvt9q+
 8aeJ0UTYG41LXGNM58prxTHg09XzxWqacyaa4n0qgauOsdj9IUltCjSwo5Z4nnOafRMCesiIbJEWV
 t5gcEgRZJRwV2WomCaOJo3/KAn0jixFTPoQRHAKv/RXWzczcBmGZUSFeNay88d9OqfZyZ/Qh4607S
 tcRnVT8g9gw24e7fZbolFGAfhzRzPjudPqG6BpM4o5SWtJBDVWr0tL/IuZOWsmGDeIsQkpdJhktC4
 Uwuq1xLBLeLz7Ols/Q==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wwh5p-000000039xQ-1Fzg;
 Wed, 19 Aug 2026 14:16:37 +0000
Date: Wed, 19 Aug 2026 14:16:37 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 47/49] monitor: move monitor_hmp_print*() functions to
 hmp.c
Message-ID: <aoW6xf9zfnua4_-O@gallifrey>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-47-e53fc35bc550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-47-e53fc35bc550@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.101+deb13-amd64 (x86_64)
X-Uptime: 14:16:23 up 12 days, 17:54,  3 users,  load average: 0.00, 0.01, 0.00
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

* Marc-André Lureau (marcandre.lureau@redhat.com) wrote:
> Those functions are only used when CONFIG_HMP, compile them out, and add
> conditions for the calling code.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> # The commit message #2 will be skipped:
> 
> # fixup! monitor: move monitor_hmp_print*() functions to hmp.c

!


> ---
>  monitor/hmp.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  monitor/monitor.c   | 49 -------------------------------------------------
>  util/error-report.c |  3 ++-
>  util/qemu-print.c   |  4 ++++
>  4 files changed, 55 insertions(+), 50 deletions(-)
> 
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 10bcbe2a33cb..e3fc05f521a8 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1754,3 +1754,52 @@ static int get_monitor_def(MonitorHMP *hmp, int64_t *pval, const char *name)
>      }
>      return cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
>  }
> +
> +int monitor_hmp_vprintf(MonitorHMP *hmp, const char *fmt, va_list ap)
> +{
> +    g_autofree char *buf = g_strdup_vprintf(fmt, ap);
> +
> +    if (!hmp) {
> +        return -1;
> +    }
> +
> +    return monitor_puts(MONITOR(hmp), buf);
> +}
> +
> +int monitor_hmp_printf(MonitorHMP *hmp, const char *fmt, ...)
> +{
> +    int ret;
> +
> +    va_list ap;
> +    va_start(ap, fmt);
> +    ret = monitor_hmp_vprintf(hmp, fmt, ap);
> +    va_end(ap);
> +    return ret;
> +}
> +
> +void monitor_hmp_printc(MonitorHMP *hmp, int c)
> +{
> +    monitor_hmp_printf(hmp, "'");
> +    switch (c) {
> +    case '\'':
> +        monitor_hmp_printf(hmp, "\\'");
> +        break;
> +    case '\\':
> +        monitor_hmp_printf(hmp, "\\\\");
> +        break;
> +    case '\n':
> +        monitor_hmp_printf(hmp, "\\n");
> +        break;
> +    case '\r':
> +        monitor_hmp_printf(hmp, "\\r");
> +        break;
> +    default:
> +        if (c >= 32 && c <= 126) {
> +            monitor_hmp_printf(hmp, "%c", c);
> +        } else {
> +            monitor_hmp_printf(hmp, "\\x%02x", c);
> +        }
> +        break;
> +    }
> +    monitor_hmp_printf(hmp, "'");
> +}
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index da0c8eda86b0..7979cd1cbcfd 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -272,55 +272,6 @@ int monitor_puts(Monitor *mon, const char *str)
>      return monitor_puts_locked(mon, str);
>  }
>  
> -int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
> -{
> -    g_autofree char *buf = g_strdup_vprintf(fmt, ap);
> -
> -    if (!mon) {
> -        return -1;
> -    }
> -
> -    return monitor_puts(MONITOR(mon), buf);
> -}
> -
> -int monitor_hmp_printf(MonitorHMP *mon, const char *fmt, ...)
> -{
> -    int ret;
> -
> -    va_list ap;
> -    va_start(ap, fmt);
> -    ret = monitor_hmp_vprintf(mon, fmt, ap);
> -    va_end(ap);
> -    return ret;
> -}
> -
> -void monitor_hmp_printc(MonitorHMP *mon, int c)
> -{
> -    monitor_hmp_printf(mon, "'");
> -    switch(c) {
> -    case '\'':
> -        monitor_hmp_printf(mon, "\\'");
> -        break;
> -    case '\\':
> -        monitor_hmp_printf(mon, "\\\\");
> -        break;
> -    case '\n':
> -        monitor_hmp_printf(mon, "\\n");
> -        break;
> -    case '\r':
> -        monitor_hmp_printf(mon, "\\r");
> -        break;
> -    default:
> -        if (c >= 32 && c <= 126) {
> -            monitor_hmp_printf(mon, "%c", c);
> -        } else {
> -            monitor_hmp_printf(mon, "\\x%02x", c);
> -        }
> -        break;
> -    }
> -    monitor_hmp_printf(mon, "'");
> -}
> -
>  static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>      /* Limit guest-triggerable events to 1 per second */
>      [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
> diff --git a/util/error-report.c b/util/error-report.c
> index c20e157780fa..68471d8055a1 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -35,12 +35,13 @@ const char *error_guest_name;
>  static int G_GNUC_PRINTF(1, 0)
>  error_vprintf_mon(const char *fmt, va_list ap)
>  {
> +#ifdef CONFIG_HMP
>      MonitorHMP *hmp = monitor_cur_hmp();
>  
>      if (hmp) {
>          return monitor_hmp_vprintf(hmp, fmt, ap);
>      }
> -
> +#endif
>      return vfprintf(stderr, fmt, ap);
>  }
>  
> diff --git a/util/qemu-print.c b/util/qemu-print.c
> index aabe670fda01..f4a7ce4c0682 100644
> --- a/util/qemu-print.c
> +++ b/util/qemu-print.c
> @@ -21,10 +21,12 @@
>   */
>  int qemu_vprintf(const char *fmt, va_list ap)
>  {
> +#ifdef CONFIG_HMP
>      MonitorHMP *hmp = monitor_cur_hmp();
>      if (hmp) {
>          return monitor_hmp_vprintf(hmp, fmt, ap);
>      }
> +#endif
>      return vprintf(fmt, ap);
>  }
>  
> @@ -52,10 +54,12 @@ int qemu_printf(const char *fmt, ...)
>   */
>  int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
>  {
> +#ifdef CONFIG_HMP
>      if (!stream) {
>          MonitorHMP *hmp = monitor_cur_hmp();
>          return hmp ? monitor_hmp_vprintf(hmp, fmt, ap) : -1;
>      }
> +#endif
>      return vfprintf(stream, fmt, ap);
>  }
>  
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

