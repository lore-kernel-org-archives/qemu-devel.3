Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976D4C982D6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7D8C-0001rT-Uj; Thu, 17 Sep 2026 10:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D83-0001nr-1H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:23 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D7z-0007fo-OL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 4CF37C0A2A;
 Thu, 17 Sep 2026 17:30:18 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b33::1:33])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id DUXfb20WRqM0-da0rJY0l; Thu, 17 Sep 2026 17:30:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789655417;
 bh=yUsSov/yEw4rcKWYC9/ddrUYem8UiITdQiOBDA+BDq8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IPR6McwWMhC0P8DEoPLA+bGVkH7IKB+haWrFc9kXXnazg0H+WJbr4KnIYriwjn47S
 Ymqk4qZgWC8dtbsMofY8El86A5/pCktwoYn31Ry+QDPlQUmHpb5c6tAJAggFeBuwX+
 e2rEPB622VTET+bpcq8H0rS14hDbuvzId6tUafqk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 7/8] vhost-user: vhost_user_add_remove_regions(): final
 cosmetics
Date: Thu, 17 Sep 2026 17:30:10 +0300
Message-ID: <20260917143011.881361-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917143011.881361-1-vsementsov@yandex-team.ru>
References: <20260917143011.881361-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 hw/virtio/vhost-user.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 100621a4329..e677f1bd05d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -805,19 +805,18 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev)
     int ret;
     bool found[VHOST_USER_MAX_RAM_SLOTS] = {};
     VhostShadowRegion *shadow_reg, *next_reg;
-    int i, j;
-    bool matching;
+    int i;
 
     /* Ensure nregions fits the fixed-size array used below. */
     assert(dev->mem->nregions <= VHOST_USER_MAX_RAM_SLOTS);
 
     QLIST_FOREACH_SAFE(shadow_reg, &u->shadow_regions, next, next_reg) {
-        matching = false;
+        bool matching = false;
 
-        for (j = 0; j < dev->mem->nregions; j++) {
-            if (reg_equal(shadow_reg, &dev->mem->regions[j])) {
+        for (i = 0; i < dev->mem->nregions; i++) {
+            if (reg_equal(shadow_reg, &dev->mem->regions[i])) {
                 matching = true;
-                found[j] = true;
+                found[i] = true;
                 break;
             }
         }
-- 
2.43.0


