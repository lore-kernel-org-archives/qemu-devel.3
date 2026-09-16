Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC86C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n4J-0001Bh-1J; Wed, 16 Sep 2026 06:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n2n-0006ia-Ut; Wed, 16 Sep 2026 06:39:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n2l-000212-FF; Wed, 16 Sep 2026 06:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554957; bh=iixBLL73uc5OtfdxxsGmNV4ZZNYXRKWkWF8drmx8Lbc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eVETSc684GFZ8LzvDF6D179vq5KQ0nlws1ZZgN6eN7vIDVj+41cBZNgtmkH4RTxKg
 K8AXEenZDwWXr4uQUPJLJAwnVk74DmD6xNI/ZAw3xpJDcK+mXJBTyrY91KwFc9Viu8
 kFWOkBBgd0fJOqNGiJmG2gLm1QDD++4RHYc68LrQioCAHRbx5DUy7EF5q5mVOa3F5H
 ORpfCFx+BVod1dWJY12RwynofWA33hLSh8Q8qHyy4kW6gUviJ4ZRadv1ks7Yc2w1hi
 YSSzMK3Zi751e8pYSigii7R+q6PcY95rC/BU9IGBEAqde0zMju60Y06+DWA+sIvORI
 7kld1RBThi7+w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1B0961D5812;
 Wed, 16 Sep 2026 13:35:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D8EA7429F70;
 Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BDBE95A81D; Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alberto Garcia <berto@igalia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 30/56] hw/sd/sdcard: Register device ops in drives
 without media
Date: Wed, 16 Sep 2026 13:35:48 +0300
Message-ID: <20260916103622.684817-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Alberto Garcia <berto@igalia.com>

Commit a362b19a39 ("hw/sd/sdcard: Fix size check for backing block
image") accidentally moved the blk_set_dev_ops() call into the new
'if (blk_size >= 0)' block in sd_realize().

Because of that, if a drive is attached without a medium then the
condition is false (blk_size == -ENOMEDIUM) and blk_set_dev_ops() is
never called, so the drive is registered as having non-removable
media:

  $QEMU -device sd-card,drive=sdcard0 -drive if=none,id=sdcard0
  (qemu) change sdcard0 sd-card.qcow2
  Error: Device 'sdcard0' is not removable

This patch moves the blk_set_perm() and blk_set_dev_ops() calls
outside of the 'if (blk_size >= 0)' block so the device ops and
permissions are registered when a drive is attached.

Cc: qemu-stable@nongnu.org
Fixes: a362b19a39 ("hw/sd/sdcard: Fix size check for backing block image")
Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260723205847.137001-1-berto@igalia.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 15d4bc75f81709f641ef1de6b9dbdac7f74ebdf7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a30c541df07..780e9f62953 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -3100,7 +3100,6 @@ static void sd_blk_size_error(SDState *sd, int64_t blk_size,
 static void sd_realize(DeviceState *dev, Error **errp)
 {
     SDState *sd = SDMMC_COMMON(dev);
-    int64_t blk_size = -ENOMEDIUM;
     int ret;
 
     switch (sd->spec_version) {
@@ -3118,32 +3117,32 @@ static void sd_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        blk_size = blk_getlength(sd->blk);
-    }
-    if (blk_size >= 0) {
-        blk_size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
-        if (blk_size > SDSC_MAX_CAPACITY) {
-            if (sd_is_emmc(sd) &&
-                !QEMU_IS_ALIGNED(blk_size, 1 << HWBLOCK_SHIFT)) {
-                int64_t blk_size_aligned =
-                    ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
-                sd_blk_size_error(sd, blk_size, blk_size_aligned,
-                                  "multiples of 512", errp);
+        int64_t blk_size = blk_getlength(sd->blk);
+        if (blk_size >= 0) {
+            blk_size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
+            if (blk_size > SDSC_MAX_CAPACITY) {
+                if (sd_is_emmc(sd) &&
+                    !QEMU_IS_ALIGNED(blk_size, 1 << HWBLOCK_SHIFT)) {
+                    int64_t blk_size_aligned =
+                        ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
+                    sd_blk_size_error(sd, blk_size, blk_size_aligned,
+                                      "multiples of 512", errp);
+                    return;
+                } else if (!sd_is_emmc(sd) &&
+                    !QEMU_IS_ALIGNED(blk_size, 512 * KiB)) {
+                    int64_t blk_size_aligned = ((blk_size >> 19) + 1) << 19;
+                    sd_blk_size_error(sd, blk_size, blk_size_aligned,
+                                      "multiples of 512K", errp);
+                    return;
+                }
+            } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
+                sd_blk_size_error(sd, blk_size, pow2ceil(blk_size),
+                                  "a power of 2", errp);
                 return;
-            } else if (!sd_is_emmc(sd) &&
-                !QEMU_IS_ALIGNED(blk_size, 512 * KiB)) {
-                int64_t blk_size_aligned = ((blk_size >> 19) + 1) << 19;
-                sd_blk_size_error(sd, blk_size, blk_size_aligned,
-                                  "multiples of 512K", errp);
+            } else if (blk_size < 0) {
+                error_setg(errp, "eMMC image smaller than boot partitions");
                 return;
             }
-        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
-            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a power of 2",
-                              errp);
-            return;
-        } else if (blk_size < 0) {
-            error_setg(errp, "eMMC image smaller than boot partitions");
-            return;
         }
 
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
-- 
2.47.3


