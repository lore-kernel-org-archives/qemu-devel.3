Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A2CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYj3s-0001pc-1M; Tue, 30 Jul 2024 05:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3q-0001lG-Tv
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:22:26 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3o-0005oI-Iv
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:22:26 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ef2c56da6cso51584791fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722331342; x=1722936142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNkJJhtqcxfGEvl8U9EJzFqc2LtYmhOZWYrWmgfKr40=;
 b=sqFd78I0QhwN3P/m/Sul+MmFaL7X+TKK4KDOBGpE0+qKlM9w01HYixRRhoy8DULc4B
 bD5g/xtxX3QPBwM2W2Y61cV3x6DuPiufYVymrYrbUqNFoK3NX3T6A3CzChsae63rin7Y
 qpRG6zQp7ZNbj0Uw8iODRsrPJChuQnXgQcWQuJF1g7gCqU4Sc0tKrXol+Dy+Ui/jQVdo
 TpFWU/32vrD6EylrlXhcmVYTL/1/2n4rYu3cFDUz0+7e2VDqm9c2E/B9Ub+XjBE+50TX
 2xvWzjo+HOYKxL3S+v5M+3uEwhhEib1EUjrG+wISC8nKT+EZWRPRQlVOAD1B4by80T3J
 oWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722331342; x=1722936142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNkJJhtqcxfGEvl8U9EJzFqc2LtYmhOZWYrWmgfKr40=;
 b=ZcZXOuE9oruflp/84yt4xDMe32GYSr3zGJ/yC5OtaxZAN8qFS3pXrVobEwwyEo66+X
 Bpg+PVY4VOXZ1pA2jc32LEi47qJgE3v+Spm4hc4vAkrMUOSGuIUWvhydrP/3ScpGV8pq
 9rrRJqg+WIqOK/n5hu0OIJviU4ezMy0YhslxCBE7PVA+miAz5LAypdAjR+4tqTc1fMrM
 EWldicf8i5BqBQDTcr3m24gOjZ2jIWci9LPDJVGAlxUp59OGoQ71tgGYZapwuUItUI1n
 VA2b+Nrxs4o2T8DUQm/0FSLlDtHYAVu4CL/kJvCo6gn1CyW9YYKAceukAE/dGI4z0I0J
 Z4qg==
X-Gm-Message-State: AOJu0YzkGBg+VcUm3wBZ9aLGuiOjPim5vDtQzAU43cIdfD+hI58PkEhS
 5sekzNAVQ5oc0RN3VsRR4uQ2G7ijPOGddxZ/IZIppFsBPAXrb87Mez4yjNNfOrBuQI6/rW36K+/
 nd9Y=
X-Google-Smtp-Source: AGHT+IEXmRZlm7i9STjSm0m4HcoPoH5PGsuk6ZyzSgN1qlDvC+p2ExfgyiMI5QK0XJRePPKuSB8FZA==
X-Received: by 2002:a2e:9608:0:b0:2ef:2f17:9edd with SMTP id
 38308e7fff4ca-2f12ee2f188mr65928521fa.44.1722331342158; 
 Tue, 30 Jul 2024 02:22:22 -0700 (PDT)
Received: from localhost.localdomain (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281dae1479sm59492875e9.44.2024.07.30.02.22.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 02:22:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-9.1 5/5] hw/sd/sdhci: Check ADMA descriptors can be
 accessed
Date: Tue, 30 Jul 2024 11:21:38 +0200
Message-ID: <20240730092138.32443-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730092138.32443-1-philmd@linaro.org>
References: <20240730092138.32443-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since malicious guest can write invalid addresses to
the ADMASYSADDR register, we need to check whether the
descriptor could be correctly filled or not.

Cc: qemu-stable@nongnu.org
Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c      | 86 ++++++++++++++++++++++++++--------------------
 hw/sd/trace-events |  2 +-
 2 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 66b9364e9e..eb0476b9aa 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -698,53 +698,62 @@ static void trace_adma_description(const char *type, const ADMADescr *dscr)
     trace_sdhci_adma_desc(type, dscr->addr, dscr->length, dscr->attr, dscr->incr);
 }
 
-static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
+static MemTxResult get_adma_description(SDHCIState *s, ADMADescr *dscr)
 {
     uint32_t adma1 = 0;
     uint64_t adma2 = 0;
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
+    MemTxResult res;
+
     switch (SDHC_DMA_TYPE(s->hostctl1)) {
     case SDHC_CTRL_ADMA2_32:
-        dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
-                        MEMTXATTRS_UNSPECIFIED);
-        adma2 = le64_to_cpu(adma2);
-        /* The spec does not specify endianness of descriptor table.
-         * We currently assume that it is LE.
-         */
-        dscr->addr = (hwaddr)extract64(adma2, 32, 32) & ~0x3ull;
-        dscr->length = (uint16_t)extract64(adma2, 16, 16);
-        dscr->attr = (uint8_t)extract64(adma2, 0, 7);
-        dscr->incr = 8;
-        trace_adma_description("ADMA2_32", dscr);
+        res = dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
+                              MEMTXATTRS_UNSPECIFIED);
+        if (res == MEMTX_OK) {
+            adma2 = le64_to_cpu(adma2);
+            /* The spec does not specify endianness of descriptor table.
+             * We currently assume that it is LE.
+             */
+            dscr->addr = (hwaddr)extract64(adma2, 32, 32) & ~0x3ull;
+            dscr->length = (uint16_t)extract64(adma2, 16, 16);
+            dscr->attr = (uint8_t)extract64(adma2, 0, 7);
+            dscr->incr = 8;
+            trace_adma_description("ADMA2_32", dscr);
+        }
         break;
     case SDHC_CTRL_ADMA1_32:
-        dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1),
-                        MEMTXATTRS_UNSPECIFIED);
-        adma1 = le32_to_cpu(adma1);
-        dscr->addr = (hwaddr)(adma1 & 0xFFFFF000);
-        dscr->attr = (uint8_t)extract32(adma1, 0, 7);
-        dscr->incr = 4;
-        if ((dscr->attr & SDHC_ADMA_ATTR_ACT_MASK) == SDHC_ADMA_ATTR_SET_LEN) {
-            dscr->length = (uint16_t)extract32(adma1, 12, 16);
-        } else {
-            dscr->length = 4 * KiB;
+        res = dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1),
+                              MEMTXATTRS_UNSPECIFIED);
+        if (res == MEMTX_OK) {
+            adma1 = le32_to_cpu(adma1);
+            dscr->addr = (hwaddr)(adma1 & ~0xfff);
+            dscr->attr = (uint8_t)extract32(adma1, 0, 7);
+            dscr->incr = 4;
+            if ((dscr->attr & SDHC_ADMA_ATTR_ACT_MASK) == SDHC_ADMA_ATTR_SET_LEN) {
+                dscr->length = (uint16_t)extract32(adma1, 12, 16);
+            } else {
+                dscr->length = 4 * KiB;
+            }
+            trace_adma_description("ADMA1_32", dscr);
         }
-        trace_adma_description("ADMA1_32", dscr);
         break;
     case SDHC_CTRL_ADMA2_64:
-        dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1,
-                        MEMTXATTRS_UNSPECIFIED);
-        dma_memory_read(s->dma_as, entry_addr + 2, &dscr->length, 2,
-                        MEMTXATTRS_UNSPECIFIED);
-        dscr->length = le16_to_cpu(dscr->length);
-        dma_memory_read(s->dma_as, entry_addr + 4, &dscr->addr, 8,
-                        MEMTXATTRS_UNSPECIFIED);
-        dscr->addr = le64_to_cpu(dscr->addr);
-        dscr->attr &= (uint8_t) ~0xC0;
-        dscr->incr = 12;
-        trace_adma_description("ADMA2_64", dscr);
+        res = dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1,
+                              MEMTXATTRS_UNSPECIFIED);
+        res |= dma_memory_read(s->dma_as, entry_addr + 2, &dscr->length, 2,
+                               MEMTXATTRS_UNSPECIFIED);
+        res |= dma_memory_read(s->dma_as, entry_addr + 4, &dscr->addr, 8,
+                               MEMTXATTRS_UNSPECIFIED);
+        if (res == MEMTX_OK) {
+            dscr->length = le16_to_cpu(dscr->length);
+            dscr->addr = le64_to_cpu(dscr->addr);
+            dscr->attr &= (uint8_t) ~0xc0;
+            dscr->incr = 12;
+            trace_adma_description("ADMA2_64", dscr);
+        }
         break;
     }
+    return res;
 }
 
 /* Advanced DMA data transfer */
@@ -755,7 +764,6 @@ static void sdhci_do_adma(SDHCIState *s)
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
     const MemTxAttrs attrs = { .memory = true };
     ADMADescr dscr = {};
-    MemTxResult res;
     int i;
 
     if (s->trnmod & SDHC_TRNS_BLK_CNT_EN && !s->blkcnt) {
@@ -765,12 +773,14 @@ static void sdhci_do_adma(SDHCIState *s)
     }
 
     for (i = 0; i < SDHC_ADMA_DESCS_PER_DELAY; ++i) {
+        MemTxResult res;
+
         s->admaerr &= ~SDHC_ADMAERR_LENGTH_MISMATCH;
 
-        get_adma_description(s, &dscr);
-        trace_sdhci_adma_loop(dscr.addr, dscr.length, dscr.attr);
+        res = get_adma_description(s, &dscr);
+        trace_sdhci_adma_loop(dscr.addr, dscr.length, dscr.attr, res);
 
-        if ((dscr.attr & SDHC_ADMA_ATTR_VALID) == 0) {
+        if (res != MEMTX_OK || (dscr.attr & SDHC_ADMA_ATTR_VALID) == 0) {
             /* Indicate that error occurred in ST_FDS state */
             s->admaerr &= ~SDHC_ADMAERR_STATE_MASK;
             s->admaerr |= SDHC_ADMAERR_STATE_ST_FDS;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 3d3f5c1cb7..a802a717b9 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -29,7 +29,7 @@ sdhci_response4(uint32_t r0) "RSPREG[31..0]=0x%08x"
 sdhci_response16(uint32_t r3, uint32_t r2, uint32_t r1, uint32_t r0) "RSPREG[127..96]=0x%08x, RSPREG[95..64]=0x%08x, RSPREG[63..32]=0x%08x, RSPREG[31..0]=0x%08x"
 sdhci_end_transfer(uint8_t cmd, uint32_t arg) "Automatically issue CMD%02u 0x%08x"
 sdhci_adma(const char *desc, uint32_t sysad) "%s: admasysaddr=0x%" PRIx32
-sdhci_adma_loop(uint64_t addr, uint16_t length, uint8_t attr) "addr=0x%08" PRIx64 ", len=%d, attr=0x%x"
+sdhci_adma_loop(uint64_t addr, uint16_t length, uint8_t attr, uint32_t res) "addr=0x%08" PRIx64 ", len=%d, attr=0x%x, res=%" PRIu32
 sdhci_adma_transfer_completed(void) ""
 sdhci_access(const char *access, unsigned int size, uint64_t offset, const char *dir, uint64_t val, uint64_t val2) "%s%u: addr[0x%04" PRIx64 "] %s 0x%08" PRIx64 " (%" PRIu64 ")"
 sdhci_read_dataport(uint16_t data_count) "all %u bytes of data have been read from input buffer"
-- 
2.45.2


