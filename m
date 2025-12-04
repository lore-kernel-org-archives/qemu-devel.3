Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B69D216A6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 15:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRBTx-0006TJ-09; Thu, 04 Dec 2025 10:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRBTi-0006Q1-0R
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:42:49 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRBTf-0007E0-SG
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:42:45 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E63C8808EF;
 Thu, 04 Dec 2025 18:42:39 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:83c::1:2e])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id agnhnW0F9Gk0-RcEBHlgU; Thu, 04 Dec 2025 18:42:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764862959;
 bh=0bVYM7rWhtCrQE5xXJ+dC/t0pw9aBDSSht1E51ZPaCg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=hcw5LcRpIAMaRKtgxcxQzQfeT3YeKg5uI5A2KxrRuYAZIlib96D8/qpe/hu/Kkrvr
 Meqzp7WCJ9U0LfWlPQ1J9oXg5mhY1QwyJP2eaqFkiGuZqO+dFx34CqihTGrOshsJJ8
 Du8z9dyzQrhNMwdLxXjSIrTDN4SV/RVkhOIsL7AQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v2 02/10] ui/spice: drop SPICE_HAS_ATTACHED_WORKER macro
Date: Thu,  4 Dec 2025 18:42:26 +0300
Message-ID: <20251204154235.149575-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251204154235.149575-1-vsementsov@yandex-team.ru>
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since previous commit it is always 1. Let's just drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/display/qxl.c        | 12 ------------
 include/ui/qemu-spice.h |  2 --
 ui/spice-display.c      | 11 -----------
 3 files changed, 25 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 0fa8a3204d..a06395fb8a 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -530,13 +530,6 @@ static void interface_attached_worker(QXLInstance *sin)
     trace_qxl_interface_attach_worker(qxl->id);
 }
 
-#if !(SPICE_HAS_ATTACHED_WORKER)
-static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_worker)
-{
-    interface_attached_worker(sin);
-}
-#endif
-
 static void interface_set_compression_level(QXLInstance *sin, int level)
 {
     PCIQXLDevice *qxl = container_of(sin, PCIQXLDevice, ssd.qxl);
@@ -1131,12 +1124,7 @@ static const QXLInterface qxl_interface = {
     .base.major_version      = SPICE_INTERFACE_QXL_MAJOR,
     .base.minor_version      = SPICE_INTERFACE_QXL_MINOR,
 
-#if SPICE_HAS_ATTACHED_WORKER
     .attached_worker         = interface_attached_worker,
-#else
-    .attache_worker          = interface_attach_worker,
-#endif
-
     .set_compression_level   = interface_set_compression_level,
     .get_init_info           = interface_get_init_info,
 
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 8e5e6b2a74..111a09ceca 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -34,8 +34,6 @@ int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
                             const char *subject);
 
-#define SPICE_HAS_ATTACHED_WORKER 1
-
 #else  /* CONFIG_SPICE */
 
 #include "qemu/error-report.h"
diff --git a/ui/spice-display.c b/ui/spice-display.c
index f2304bb0ce..28399f8a81 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -507,17 +507,10 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
 
 /* spice display interface callbacks */
 
-#if SPICE_HAS_ATTACHED_WORKER
 static void interface_attached_worker(QXLInstance *sin)
 {
     /* nothing to do */
 }
-#else
-static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_worker)
-{
-    /* nothing to do */
-}
-#endif
 
 static void interface_set_compression_level(QXLInstance *sin, int level)
 {
@@ -707,11 +700,7 @@ static const QXLInterface dpy_interface = {
     .base.major_version      = SPICE_INTERFACE_QXL_MAJOR,
     .base.minor_version      = SPICE_INTERFACE_QXL_MINOR,
 
-#if SPICE_HAS_ATTACHED_WORKER
     .attached_worker         = interface_attached_worker,
-#else
-    .attache_worker          = interface_attach_worker,
-#endif
     .set_compression_level   = interface_set_compression_level,
     .get_init_info           = interface_get_init_info,
 
-- 
2.48.1


