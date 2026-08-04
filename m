Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07114C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrAJ6-0004Fa-Ig; Tue, 04 Aug 2026 04:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wrAIt-0004Eo-Nw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 04:15:17 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wrAIq-0006hz-6R
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 04:15:13 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c1fbe461f59so612169266b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785831310; x=1786436110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l1ywmDlSnsyVnFY+j1dUg7E6denwEEGi/Oe/GulMPr8=;
 b=HQU3y45SeJu7RjZcOuPy7u8ZtcUNlESBhb1HhAHV35waMt560Pdg9H4RI5hRO1n3c4
 RRc98ygBP5tsLSBf1Rz2zXo8y/yLzupXic7hC1FWHe6Hs+sOPpO5dsXF7SU05YQiHjQa
 zyf5IZVEd3OpRIiU8yrqmivAY5eP4581N9LMQ02kEz9R2jSj8R5E3JTDcNE/44MrolbA
 jvLdBPvSd4ZxTcrI2EcI3kLMVl0+R4GdFmyDXE6ckqzuoWg1/Qr6dUzAKodOh+CtLzO6
 K58kz+39iOMm/Qu0I8BMI2BtcPElB67xZ3TGBlypIKuupWVKSGBCp+yogoTO1GRY0MZ/
 h5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785831310; x=1786436110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l1ywmDlSnsyVnFY+j1dUg7E6denwEEGi/Oe/GulMPr8=;
 b=n5aCNPK2NwlCmbU63DZPzOlGPbgjYZhvjBTGoA7MzqiXDuIPGbL/K2vSdr7o9rXjbL
 /4i0jzUI3iO01CnTTthlQ2KxiMR/cUJQ/vDShogsWzsbxiv3pUm7TXaUHG9FPoi/UH39
 AZ7EhxL+L6/T6qX5/hFomi11KItYlp89FhkEtEEH6Z8PnYXv3TphVAzk6SpCo4vlGDvz
 ZMYPXBDNjZL7FmP9X7p0QQtUGci3w54r7YJLrgxhNgIHMpcE2W+LcqE8AgrVlhOfgUC6
 6BLUM+Ao2MurLVe4GMiFrtqqPylfcUCOrS6nws0C2KDJk02uuWoStykH6TGy6VvZlei4
 bWnQ==
X-Gm-Message-State: AOJu0YwiagEuZhM2gHBArY4FOVPFVPfmZim50aDK4tL+vcUnEj+uA7a4
 AA34yrGHj0Ccmo2AFp39Yj6EfVtmQkFhhfVu620uXgE7XVtDL2sYo6E2gihDfwAC
X-Gm-Gg: AR+sD11uwtOQ+HlWDgFUK6g1V19lNrbSkMl5HU1P5zT38L8AVJULWel6wu4W+DxO3qF
 aibU4goQkg6D3SW0rfu6utAuM4UgkZI1XltkcxT6nsi7ddvl0GL4rW5BYEEQkkwE9WI/yBj/1vW
 YsOxmOho60wbDq/uaXg/+DkeJuy2E4GFizAuCfsDjzI1OQIg1khVQLfeBPW6t9siJCDC4Dk9/71
 VbeSGLD3C9DjfVLra+q+Dw+k8dGlLpylZTwUUBzMhr1UIbw+3FvQLls5tKHN+i2fCh5C+/9Sv5q
 UgOzloe7zDl4Nu3WofzgM++o+8UKvQ1AhlO/YsL0CHIYKgjtEi9g6bJ69KApeFpVUYWQp7bfHgN
 1du995KuFgCKPjHAf+2mZyyMD9YBj4BZWmofOGnRrdK9tKu35HYbj0na8Syh6EoTyRX/ZQqsuW2
 nwzpl0zH/SjrnGF5Yl6KP0xskqRhFzJnLH3hv+ZduhNlPiCu2c4Zsrm4YlJiB4FdAwfIRqU3knp
 d1lvVHXphQ=
X-Received: by 2002:a17:907:fd0b:b0:c1c:332b:74a1 with SMTP id
 a640c23a62f3a-c1fe7f59914mr1053443566b.28.1785831309886; 
 Tue, 04 Aug 2026 01:15:09 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c201265eb75sm204521566b.3.2026.08.04.01.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 01:15:09 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, bmeng.cn@gmail.com, qemu-block@nongnu.org,
 Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH] hw/sd/sdhci: complete non-interrupt ADMA descriptor chains in
 one pass
Date: Tue,  4 Aug 2026 10:14:59 +0200
Message-ID: <20260804081459.8007-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=wafgo01@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

sdhci_do_adma() processes at most SDHC_ADMA_DESCS_PER_DELAY descriptors
per invocation and then reschedules itself SDHC_TRANSFER_DELAY ns later
on QEMU_CLOCK_VIRTUAL.  For a large bulk transfer this spreads the DMA
across hundreds of virtual-clock round-trips, advancing the guest's
virtual time between descriptor batches.

A guest that bounds the transfer with its own data/status timeout
(counted in guest time) can then see that timeout expire mid-transfer.
Concretely, U-Boot on a TI AM64x reading a ~28 MiB image with a single
CMD18 multi-block ADMA2 read intermittently aborts with "Timeout for
status update" and falls back to (failing) distro boot.  The transfer
itself is correct; only the artificial per-batch pacing triggers the
guest timeout.

Run a descriptor chain that carries no SDHC_ADMA_ATTR_INT attribute to
completion within a single call.  Chains that do request a DMA-boundary
interrupt still deliver it and reschedule exactly as before, so a guest
relying on that pacing is unaffected.

Now that the per-call bound is gone, cap the number of descriptors
processed per call so that a malformed or circular descriptor list (a
self-referencing link, or a persistently faulting non-END/non-INT
descriptor) cannot spin the calling thread forever; on overflow, break
to the existing reschedule path so the main loop stays responsive.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/sd/sdhci-internal.h |  9 +++++++++
 hw/sd/sdhci.c          | 23 +++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 9f768c418e..bb586a9666 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -278,6 +278,15 @@ FIELD(SDHC_MAXCURR, V18_VDD2,         32, 8); /* since v4.20 */
 #define SDHC_INSERTION_DELAY            (NANOSECONDS_PER_SECOND)
 #define SDHC_TRANSFER_DELAY             100
 #define SDHC_ADMA_DESCS_PER_DELAY       5
+/*
+ * Upper bound on ADMA2 descriptors handled in a single sdhci_do_adma()
+ * call, as a safety valve against a malformed or circular descriptor
+ * list. A well-formed transfer terminates far below this via END or
+ * blkcnt == 0 (even a 4 GiB transfer built from 64 KiB TRAN descriptors
+ * is only ~64K descriptors); the bound merely guarantees the loop makes
+ * a decision instead of spinning forever.
+ */
+#define SDHC_ADMA_MAX_DESCRIPTORS       (1 << 20)
 #define SDHC_CMD_RESPONSE               (3 << 0)
 
 enum {
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 89b595ce4a..e8e8928b4f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -779,7 +779,6 @@ static void sdhci_do_adma(SDHCIState *s)
     const MemTxAttrs attrs = { .memory = true };
     ADMADescr dscr = {};
     MemTxResult res = MEMTX_ERROR;
-    int i;
 
     if (s->trnmod & SDHC_TRNS_BLK_CNT_EN && !s->blkcnt) {
         /* Stop Multiple Transfer */
@@ -787,7 +786,27 @@ static void sdhci_do_adma(SDHCIState *s)
         return;
     }
 
-    for (i = 0; i < SDHC_ADMA_DESCS_PER_DELAY; ++i) {
+    /*
+     * Process the descriptor chain to completion (END or blkcnt == 0),
+     * yielding to the guest only for a descriptor carrying the INT
+     * attribute (a DMA-boundary interrupt, handled at the end of the loop).
+     *
+     * Historically at most SDHC_ADMA_DESCS_PER_DELAY descriptors were
+     * handled per call before rescheduling SDHC_TRANSFER_DELAY ns later on
+     * QEMU_CLOCK_VIRTUAL. That pacing is only needed so a guest can observe
+     * the intermediate DMA-interrupt state; a bulk transfer that requests
+     * no interrupt does not need slicing, and throttling it across many
+     * virtual-clock round-trips can make it race a guest-side transfer
+     * timeout. Run such chains to completion in one call instead.
+     *
+     * SDHC_ADMA_MAX_DESCRIPTORS bounds the loop so a malformed or circular
+     * chain cannot spin here forever; on overflow, break to the reschedule
+     * path so the main loop stays responsive.
+     */
+    for (unsigned int adma_descs = 0; ; adma_descs++) {
+        if (adma_descs >= SDHC_ADMA_MAX_DESCRIPTORS) {
+            break;
+        }
         s->admaerr &= ~SDHC_ADMAERR_LENGTH_MISMATCH;
 
         get_adma_description(s, &dscr);
-- 
2.43.0


