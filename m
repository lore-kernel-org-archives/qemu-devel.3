Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96417CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 17:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOfsh-0004U0-KV; Thu, 27 Nov 2025 12:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsb-0004Rq-UX
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:05 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsX-0001GD-Dz
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:03 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 448DD80DEE;
 Thu, 27 Nov 2025 20:33:56 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:834::1:7])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rXiJgL0F7Os0-nKkrkL6N; Thu, 27 Nov 2025 20:33:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764264835;
 bh=21bOsdj8Db2Anq8WOkQGn/n5zY4kVb5bAQZaJlGVSSI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=1hVeVE77GNWGI2qNR8WR98AF8wtVXR3eUvkw0xQ4N39a0BGAJxRZWAhnJN5+09TEg
 d0Es3kHlrmDpr9xsxemX0op+U+hsF2iJO/+aIbuX0jCiqTqILNeMZOlVmIStlQroPe
 wSyIC+rBIa8nmwCKBu+Lp3DzD5T5To1aAf4tdtVs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: dave@treblig.org,
	armbru@redhat.com
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Subject: [PATCH 2/5] monitor: remove unused error_printf_unless_qmp() function
Date: Thu, 27 Nov 2025 20:33:49 +0300
Message-ID: <20251127173352.283731-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251127173352.283731-1-vsementsov@yandex-team.ru>
References: <20251127173352.283731-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/monitor/monitor.h |  3 ---
 monitor/monitor.c         | 24 ------------------------
 stubs/error-printf.c      |  5 -----
 3 files changed, 32 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c3740ec616..296690e1f1 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -59,7 +59,4 @@ void monitor_register_hmp(const char *name, bool info,
 void monitor_register_hmp_info_hrt(const char *name,
                                    HumanReadableText *(*handler)(Error **errp));
 
-int error_vprintf_unless_qmp(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
-int error_printf_unless_qmp(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
-
 #endif /* MONITOR_H */
diff --git a/monitor/monitor.c b/monitor/monitor.c
index c5a5d30877..b5007c1851 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -281,30 +281,6 @@ int error_vprintf(const char *fmt, va_list ap)
     return vfprintf(stderr, fmt, ap);
 }
 
-int error_vprintf_unless_qmp(const char *fmt, va_list ap)
-{
-    Monitor *cur_mon = monitor_cur();
-
-    if (!cur_mon) {
-        return vfprintf(stderr, fmt, ap);
-    }
-    if (!monitor_cur_is_qmp()) {
-        return monitor_vprintf(cur_mon, fmt, ap);
-    }
-    return -1;
-}
-
-int error_printf_unless_qmp(const char *fmt, ...)
-{
-    va_list ap;
-    int ret;
-
-    va_start(ap, fmt);
-    ret = error_vprintf_unless_qmp(fmt, ap);
-    va_end(ap);
-    return ret;
-}
-
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
diff --git a/stubs/error-printf.c b/stubs/error-printf.c
index 0e326d8010..1afa0f62ca 100644
--- a/stubs/error-printf.c
+++ b/stubs/error-printf.c
@@ -16,8 +16,3 @@ int error_vprintf(const char *fmt, va_list ap)
     }
     return vfprintf(stderr, fmt, ap);
 }
-
-int error_vprintf_unless_qmp(const char *fmt, va_list ap)
-{
-    return error_vprintf(fmt, ap);
-}
-- 
2.48.1


