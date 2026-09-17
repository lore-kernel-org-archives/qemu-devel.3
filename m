Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7D0C982D6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7D8C-0001rH-Ij; Thu, 17 Sep 2026 10:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D83-0001nq-0E
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:23 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D7z-0007fG-GU
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 2511CC0A24;
 Thu, 17 Sep 2026 17:30:17 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b33::1:33])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id DUXfb20WRqM0-QwkI9Off; Thu, 17 Sep 2026 17:30:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789655416;
 bh=JhzSinP7fyD6Ftn7j0lcOm2RHltzwWjqlGDzAyQEdGw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=DUdHD5KLh0eG5zw4If7zBOHAOkkpIIDszmkuQX5HyEgMc4kll+O2autXkIyCXtc6S
 U3899pd3CZ0yl5ol74ROKxNRcb8lXW1r2oMHtKAbMh6ieWEyPST3DyjHg2dyWdstMn
 Cac643uNVJ00N1eGkNWVYhGWA64DtCT3aCZRj9sg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 5/8] vhost-user: vhost_user_add_remove_regions(): drop extra
 reg variable
Date: Thu, 17 Sep 2026 17:30:08 +0300
Message-ID: <20260917143011.881361-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917143011.881361-1-vsementsov@yandex-team.ru>
References: <20260917143011.881361-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Feature: vhost-user-blk-fd-mig
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 4492374eab0..40f247a355e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -823,7 +823,7 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev)
     int nr_add_reg, nr_rem_reg;
     int ret;
     bool found[VHOST_USER_MAX_RAM_SLOTS] = {};
-    struct vhost_memory_region *reg, *shadow_reg;
+    struct vhost_memory_region *shadow_reg;
     int i, j, add_idx = 0, rm_idx = 0;
     bool matching;
 
@@ -841,9 +841,7 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev)
         matching = false;
 
         for (j = 0; j < dev->mem->nregions; j++) {
-            reg = &dev->mem->regions[j];
-
-            if (reg_equal(shadow_reg, reg)) {
+            if (reg_equal(shadow_reg, &dev->mem->regions[j])) {
                 matching = true;
                 found[j] = true;
                 break;
@@ -867,7 +865,6 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev)
      * file descriptors.
      */
     for (i = 0; i < dev->mem->nregions; i++) {
-        reg = &dev->mem->regions[i];
         /*
          * If the region was in both the shadow and device state we don't
          * need to send a VHOST_USER_ADD_MEM_REG message for it.
@@ -876,7 +873,7 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev)
             continue;
         }
 
-        add_reg[add_idx].region = reg;
+        add_reg[add_idx].region = &dev->mem->regions[i];
         add_reg[add_idx].reg_idx = i;
         add_idx++;
     }
-- 
2.43.0


