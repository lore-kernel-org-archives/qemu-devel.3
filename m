Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7147BC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 00:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvlXW-0002Dr-GH; Sun, 16 Aug 2026 20:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wvlXU-0002DZ-Qk
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 20:49:20 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wvlXT-0000mQ-4E
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 20:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=xTa/lMM6NcYMcL/p1+hXN5jvAniSOAw3m/JH/kUfEUE=; b=VKMVqQf+y2A+WFXw
 0vU2roTg/OM+y1qy2Tt0j9whA0eg2PLv9I3BzJyqo4ILDRgGnFfkeFMBE/bCA2ZrTlqhbWZAzgYtx
 f07B3mJ3jLFQRGJsOtyxuD6ogBiasoNuEqnHyekrWDsJ0X4CnATHbDCwYS5Td263CZLW0ZcVDqFBV
 zYb8L7AWknbyrVdqL1RhzKHTSKMIUcOv4nuz7ZFrdEFZU23YQ621ThXex1RhHw46fbHkRqz0Dhmib
 58YxYnNKbDsipVseAVAWg8QO7PIYR2FdB6DOFPx7W8Lj+iVve9xciMI/d9g7IELJSIktGhyx10fIm
 2A95JpCbU5L4U12hxA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wvlXQ-00000002QDX-24hP;
 Mon, 17 Aug 2026 00:49:16 +0000
Date: Mon, 17 Aug 2026 00:49:16 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 33/49] monitor: add monitor_cur_hmp() helper
Message-ID: <aoJajGaO3uOQ7OmA@gallifrey>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-33-e53fc35bc550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-33-e53fc35bc550@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.101+deb13-amd64 (x86_64)
X-Uptime: 00:49:12 up 10 days,  4:26,  2 users,  load average: 0.00, 0.00, 0.00
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
> This will help to simplify the code in the following changes.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  include/monitor/hmp.h |  2 ++
>  monitor/hmp.c         | 10 ++++++++++
>  stubs/meson.build     |  1 +
>  stubs/monitor-hmp.c   |  9 +++++++++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 827a56144824..6aa562ddbaa2 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -36,6 +36,8 @@ struct MonitorDef {
>  void monitor_new_hmp(const char *id, const char *chardev_id,
>                       bool use_readline, Error **errp);
>  
> +MonitorHMP *monitor_cur_hmp(void);
> +
>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
>      G_GNUC_PRINTF(2, 0);
>  int monitor_printf(Monitor *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 57c4127641ac..47fb7cef6de2 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -47,6 +47,16 @@
>  
>  OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
>  
> +MonitorHMP *monitor_cur_hmp(void)
> +{
> +    Monitor *mon = monitor_cur();
> +    if (mon) {
> +        return (MonitorHMP *)object_dynamic_cast(OBJECT(mon),
> +                                                 TYPE_MONITOR_HMP);
> +    }
> +    return NULL;
> +}
> +
>  static void monitor_hmp_finalize(Object *obj)
>  {
>      MonitorHMP *hmp = MONITOR_HMP(obj);
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 3b2f2680b193..7e15687a62b7 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -7,6 +7,7 @@ stub_ss.add(files('fdset.c'))
>  stub_ss.add(files('iothread-lock.c'))
>  stub_ss.add(files('is-daemonized.c'))
>  stub_ss.add(files('monitor-core.c'))
> +stub_ss.add(files('monitor-hmp.c'))
>  stub_ss.add(files('replay-mode.c'))
>  stub_ss.add(files('trace-control.c'))
>  
> diff --git a/stubs/monitor-hmp.c b/stubs/monitor-hmp.c
> new file mode 100644
> index 000000000000..9452a3f0c2c8
> --- /dev/null
> +++ b/stubs/monitor-hmp.c
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "monitor/hmp.h"
> +
> +MonitorHMP *monitor_cur_hmp(void)
> +{
> +    return NULL;
> +}
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

