Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAF2C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 20:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvhOX-0004Mh-6H; Sun, 16 Aug 2026 16:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wvhOW-0004MX-1P
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 16:23:48 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wvhOU-0007ig-II
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 16:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=6sZhWQ64/IXck60AZKeSvOCeENYy5RfduB97ksIhQI4=; b=N1YGwjE91tj6tuhO
 0kDIam3BhFrvPfr9E8FNpqH8nE17FxsL9K9fiK9iRULycDAMR3/FccfP6VigBMY4RdwOaK2GWEf4S
 +Onn13BESoxmp92i4E7Epy+57QBhEWBFXBf0dpzPKJ4v81jjHF7wUyrEwLIVZg7Z4GLsVOQkcmjKB
 wn8dsgzCR4L+Vq3yLvjzUFel/NPzFXRZF6j8hdYGWrT1SnLGKPqusvMbJP6YWqt+4OzmtDC2KZUgT
 9kJ2LMtq1SSjZ6YUYS96jQq+kcz4HEI64KWR0yi1XXJATuonBBMQINLM7Jlk/DZoQ6aWaeNnJs5Ts
 mwjJtCpgcYj+lyHLnQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wvhOT-00000002ONf-23bq;
 Sun, 16 Aug 2026 20:23:45 +0000
Date: Sun, 16 Aug 2026 20:23:45 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 27/49] monitor: reject readline monitor when HMP is
 disabled
Message-ID: <aoIcUcXMOlmKiGYq@gallifrey>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-27-e53fc35bc550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-27-e53fc35bc550@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.101+deb13-amd64 (x86_64)
X-Uptime: 20:23:40 up 10 days, 1 min,  2 users,  load average: 0.00, 0.01, 0.00
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
> When QEMU is built without HMP support, reject '-monitor' (which
> requests readline/HMP mode) early in monitor_new_opts() with a
> clear error message directing users to '-qmp' instead.
> 
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  monitor/monitor.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 6d6ffbb0f78a..8528af6f79b8 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -776,6 +776,16 @@ int monitor_new_opts(QemuOpts *opts, Error **errp)
>      MonitorOptions *options;
>      int ret;
>  
> +#ifndef CONFIG_HMP
> +    const char *mode = qemu_opt_get(opts, "mode");
> +    /* readline is HMP..  */
> +    if (mode && g_str_equal(mode, "readline")) {
> +        error_setg(errp, "HMP monitor is not available,"
> +                   " use '-qmp' instead of '-monitor'");
> +        return -1;
> +    }
> +#endif
> +
>      v = opts_visitor_new(opts);
>      visit_type_MonitorOptions(v, NULL, &options, errp);
>      visit_free(v);
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

