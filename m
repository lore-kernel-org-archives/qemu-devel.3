Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D43CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 04:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO6HK-00049L-7B; Sat, 16 May 2026 00:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clintdotphillips@gmail.com>)
 id 1wO3Kn-0006Nv-7c
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:56:53 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <clintdotphillips@gmail.com>)
 id 1wO3Kl-0005UO-Ga
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:56:52 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7c04749d739so448587b3.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778893010; x=1779497810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DmXFxKJHlYSSz2uJUVWRz50r83KPF8jEWkiMXenqcSw=;
 b=NGUM2Q/tyiwq23X7MvMDWtAn9zV6W/j14DZ2ZeVBDvv+iqa3npkP2pWH7tAaFBPE9t
 hMHwUnVmtFdakXh2CKHXq9cExagOpRnCdbJLScfjE+wmhQ0kXoge2LVavCWKCNdAPH97
 9MY4bF1J4oEPfSTeEMYg/tp34WQL52KILCbdd7kiIjjgLoGYKb/tkBuDH9O8S/owNWmy
 wI9RVfEvBayKHU6+VwSzOS+X5Y2dsfYgmGdSP2aXCf+yiOEW9zhuWFKs4jQwtM+EIPHD
 ceEHpbE+ksiRWfhgLfSqMxEn0iPKijm+V4+0JsiwhgZf7O2wSpJdu4uS6Tvz6gY4IpUt
 Fzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778893010; x=1779497810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmXFxKJHlYSSz2uJUVWRz50r83KPF8jEWkiMXenqcSw=;
 b=LGDAcvQ+amEpvxbGHqnoMBgI/ON7nYJ6lE2ixAlNtCI0ihdNJEoALkHCvYr4m4f6Lo
 qM0MUd3jp1uXFDSpo0v4vfhVBzoDtjyVDlavNWcwS5VGPD5hsbED98y6u40YbhGhBzCD
 B8GyraN/GozAis4FSeUu0JX/BqGd+f/62AyaIcLyoKphYC9L7gOHPQE5ETdGlWl35rB6
 FpFeJaTEktcVgC4WEY1ZhDSoIao7AhYsedt38Ng8yAcRv5RIqIYFnbDMVWpvCWrYtJG9
 A1A0rtztAbV6Fa19AH5kDboo0e6Y1q3tsRMxeM9i8TZVL4dk9ljXfos5JxxbxKxFtgbH
 NfSA==
X-Gm-Message-State: AOJu0YyrDMwAzvXphtH83YAwwN/VWM9jqpgltz8BdeZvd4YYRI4e1hE9
 AaabJV8bEUBHIvBTbA5wBbLAvWrk96q5+eNx6gOK0DUMVqsK3+xKcIQTnfebv/tV
X-Gm-Gg: Acq92OGHf73ir+hZQRvdD8GYO83kedp8zE7yEu08kHPBSh0DiPIoTVmDHOBh9TKO8zJ
 uyIHIIfaHIVSU86TMtX9ulV10t5zJRTl+gDY2ewn26imXAKrnAEmRkUGXgCYM/l7AezJatoH2t4
 Ei4OHHy2UMVj0I7tpprX04uDW3tBkaMCpc9K3G/jSoV5prTLdzeP7rZRBNbnvSh6cCJxOmnsC48
 hgFg0EPqemXyYYy3738HDO96XbMZ9bZmkSUydMXVXPzh1ac9EqrcI7dMIo4syE/CErIXbk8U0QH
 FfO1wS6RYeaIhZvoqFNsAonLycm+RRNGNF8Crdw5k2+OwWOBFks4aaqXuwcYm2WhN2SkCjfChvt
 eVDYA2rB6q1amrd8MVudUQ06lVw9CR0efmdP1CzK0AKizhjeX6L8hLpfXnVrh+QILVod6knP1p2
 q2uwCcgA+3m3cqziBQEcrqSrIaMQwMC5KXNQs2Y4ThwgX4S7TjRRL4AEWzLWKopg==
X-Received: by 2002:a05:690c:6c0a:b0:7bb:c0f:19d4 with SMTP id
 00721157ae682-7c958fbeef1mr72693817b3.4.1778893010203; 
 Fri, 15 May 2026 17:56:50 -0700 (PDT)
Received: from localhost.localdomain ([24.196.231.228])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7c7f5c962c2sm37781427b3.48.2026.05.15.17.56.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 17:56:50 -0700 (PDT)
From: Clinton Phillips <clintdotphillips@gmail.com>
To: qemu-devel@nongnu.org
Cc: Clinton Phillips <clintdotphillips@gmail.com>
Subject: [PATCH] treewide: fix typos in source comments
Date: Fri, 15 May 2026 20:56:49 -0400
Message-ID: <20260516005649.92717-1-clintdotphillips@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=clintdotphillips@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 16 May 2026 00:05:26 -0400
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

Pure typo fixes in code comments and doxygen documentation,
no behavior change.

- hw/xen/xen-pvh-common.c: "accomodate" -> "accommodate"
- hw/net/npcm_gmac.c: "being transfered" -> "being transferred"
- hw/display/dm163.c: "stored accross" -> "stored across"
- target/arm/cpu.h: "physical adress space" -> "physical address space"
- target/arm/tcg/gengvec64.c: "saturation occured" -> "saturation occurred"
- include/migration/register.h: "error occured" -> "error occurred"
- tests/qtest/pnv-host-i2c-test.c: "Recieve len bytes" -> "Receive len bytes"
- migration/multifd.c: "other thread writting" -> "other thread writing"

Signed-off-by: Clinton Phillips <clintdotphillips@gmail.com>
---
 hw/display/dm163.c              | 2 +-
 hw/net/npcm_gmac.c              | 2 +-
 hw/xen/xen-pvh-common.c         | 2 +-
 include/migration/register.h    | 2 +-
 migration/multifd.c             | 2 +-
 target/arm/cpu.h                | 2 +-
 target/arm/tcg/gengvec64.c      | 2 +-
 tests/qtest/pnv-host-i2c-test.c | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/display/dm163.c b/hw/display/dm163.c
index afade0b..04e59b2 100644
--- a/hw/display/dm163.c
+++ b/hw/display/dm163.c
@@ -152,7 +152,7 @@ static void dm163_en_b_gpio_handler(void *opaque, int line, int new_state)
 static uint8_t dm163_bank0(const DM163State *s, uint8_t led)
 {
     /*
-     * Bank 0 uses 6 bits per led, so a value may be stored accross
+     * Bank 0 uses 6 bits per led, so a value may be stored across
      * two uint64_t entries.
      */
     const uint8_t low_bit = 6 * led;
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index d9902d9..b85a37f 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -278,7 +278,7 @@ static int gmac_rx_transfer_frame_to_buffer(uint32_t rx_buf_len,
 {
     uint32_t to_transfer;
     /*
-     * Check that buffer is bigger than the frame being transfered
+     * Check that buffer is bigger than the frame being transferred
      * If bigger then transfer only whats left of frame
      * Else, fill frame with all the content possible
      */
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index cca3720..1141930 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -443,7 +443,7 @@ do {                                                                      \
 
     /*
      * We provide memmap properties to allow Xen to move things to other
-     * addresses for example when users need to accomodate the memory-map
+     * addresses for example when users need to accommodate the memory-map
      * for 1:1 mapped devices/memory.
      */
     OC_MEMMAP_PROP(oc, "ram-low", ram_low);
diff --git a/include/migration/register.h b/include/migration/register.h
index 5e5e0ee..257ecfc 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -205,7 +205,7 @@ typedef struct SaveVMHandlers {
      * @opaque: Data pointer passed to register_savevm_live()
      * @errp:   Error** used to report error message
      *
-     * Returns: true if succeeded, false if error occured.  When false is
+     * Returns: true if succeeded, false if error occurred.  When false is
      * returned, @errp must be set.
      */
     bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
diff --git a/migration/multifd.c b/migration/multifd.c
index 035cb70..e9c933a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -440,7 +440,7 @@ static void multifd_send_error_propagate(Error *err)
  *
  * A successful migration also guarantees multifd sender threads are
  * properly flushed and halted.  It is only safe to send BYE in the
- * migration thread here when we know there's no other thread writting to
+ * migration thread here when we know there's no other thread writing to
  * the channel, because GnuTLS doesn't support concurrent writers.
  */
 static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 15a13b9..8fb06b8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1281,7 +1281,7 @@ typedef struct ARMGranuleProtectionConfig {
  * @ss: security state for access
  * @fi: fault information in case a fault is detected
  *
- * Checks if @paddress can be accessed in physical adress space @pspace
+ * Checks if @paddress can be accessed in physical address space @pspace
  * for @ss secure state, following granule protection setup with @config.
  * If a fault is detected, @fi is set accordingly.
  * See GranuleProtectionCheck() in A-profile manual.
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
index c7bdd1e..20e5953 100644
--- a/target/arm/tcg/gengvec64.c
+++ b/target/arm/tcg/gengvec64.c
@@ -191,7 +191,7 @@ void gen_gvec_bcax(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
 
 /*
  * Set @res to the correctly saturated result.
- * Set @qc non-zero if saturation occured.
+ * Set @qc non-zero if saturation occurred.
  */
 void gen_suqadd_bhs(TCGv_i64 res, TCGv_i64 qc,
                     TCGv_i64 a, TCGv_i64 b, MemOp esz)
diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 51e613e..6aa3c72 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -100,7 +100,7 @@ static void pnv_i2c_send(PnvI2cDev *dev, const uint8_t *buf, uint16_t len)
                     I2C_STAT_CMD_COMP);
 }
 
-/* Recieve len bytes into buf from i2c device with given addr and port */
+/* Receive len bytes into buf from i2c device with given addr and port */
 static void pnv_i2c_recv(PnvI2cDev *dev, uint8_t *buf, uint16_t len)
 {
     int byte_num;
-- 
2.49.0


