Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE05CFD88C7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05cz-0001GQ-Bw; Tue, 10 Mar 2026 18:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cs-0001F3-DC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:30 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cq-00073F-84
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:29 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 bc612f78922d94fa27e3162e0bc8f509a3bf8f7e4f8bc9b874baf8e8c9b336d3 with SMTP id
 69b09bf4409f4d8a2bbedc6c; Tue, 10 Mar 2026 22:32:20 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181939;
 bh=jmxb10JNM//QK7j3a9BnIxAB7QAjpcueDbi6qwM/er8=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=fXUnapdC2OKsevGs1PELtA9iydBjYOFVmpgjktpNzJny2wGx/Z/qQBwkgBOxzSDBQ
 shYB9zTEnTLvvvH+xQZQ6MHBybcXuSLQfCEClB8b8zcdUxZDkVB5OETjaOdN+veJ5b
 xd/3OAXEp/Y9ZWHixNEODz/21hy7NTvdo7cj0A5DTlpZdd9pwyezXzmSkE/U+9JyXD
 /WCRimYKnUhClZX0S971hf2i7UolQ2dbd9WJ9cWw8WV5mLikGXx/7ULpuqVS1QAsx3
 8UNJlmMnW6MC21OYQIsYEgMqycchTekS3mECsQ4Lsj83NvA8sWR2eKXnFJg01TtbR+
 6pE81i2arezCA==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:41 -0500
Subject: [PATCH 01/15] hw/alpha/typhoon: Fix whitespace and block comment
 style problems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-1-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7914; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=KWafmBoA76UrvsYyUnBmR+n2TgtLcqfuwMs5FcJxfIE=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP6YvZ3RLOWRScAnXYmyc0YLY3KOX7k496Byk3Jm+
 949L6Z2dZSyMIhxMciKKbJcPitx1iF3d1fayh/3YeawMoEMYeDiFICJvFrOyDBdSXXWo7+SFZcT
 +8tqrua3rJaLCzne+DTOnT09+Zb6zSkM//SuKKSqnHT7l74mTu9rvaPyBpcWd1t1nsNzA343zHW
 MYQAA
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HELO_STATIC_HOST=-0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Eliminate trailing whitespaces.

Use leading "/*", internal "*", and trailing "*/" for block comments.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/typhoon.c | 84 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 32 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 7722d4fd00..f392772500 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -34,7 +34,7 @@ typedef struct TyphoonWindow {
     uint64_t wsm;
     uint64_t tba;
 } TyphoonWindow;
- 
+
 typedef struct TyphoonPchip {
     MemoryRegion region;
     MemoryRegion reg_iack;
@@ -84,8 +84,10 @@ static MemTxResult cchip_read(void *opaque, hwaddr addr,
     switch (addr) {
     case 0x0000:
         /* CSC: Cchip System Configuration Register.  */
-        /* All sorts of data here; probably the only thing relevant is
-           PIP<14> Pchip 1 Present = 0.  */
+        /*
+         * All sorts of data here; probably the only thing relevant is
+         * PIP<14> Pchip 1 Present = 0.
+         */
         break;
 
     case 0x0040:
@@ -188,7 +190,7 @@ static MemTxResult cchip_read(void *opaque, hwaddr addr,
     case 0x0780:
         /* PWR: Power Management Control.   */
         break;
-    
+
     case 0x0c00: /* CMONCTLA */
     case 0x0c40: /* CMONCTLB */
     case 0x0c80: /* CMONCNT01 */
@@ -440,7 +442,7 @@ static MemTxResult cchip_write(void *opaque, hwaddr addr,
     case 0x0780:
         /* PWR: Power Management Control.   */
         break;
-    
+
     case 0x0c00: /* CMONCTLA */
     case 0x0c40: /* CMONCTLB */
     case 0x0c80: /* CMONCNT01 */
@@ -605,8 +607,10 @@ static const MemoryRegionOps pchip_ops = {
     },
 };
 
-/* A subroutine of typhoon_translate_iommu that builds an IOMMUTLBEntry
-   using the given translated address and mask.  */
+/*
+ * A subroutine of typhoon_translate_iommu that builds an IOMMUTLBEntry
+ * using the given translated address and mask.
+ */
 static bool make_iommu_tlbe(hwaddr taddr, hwaddr mask, IOMMUTLBEntry *ret)
 {
     *ret = (IOMMUTLBEntry) {
@@ -618,8 +622,10 @@ static bool make_iommu_tlbe(hwaddr taddr, hwaddr mask, IOMMUTLBEntry *ret)
     return true;
 }
 
-/* A subroutine of typhoon_translate_iommu that handles scatter-gather
-   translation, given the address of the PTE.  */
+/*
+ * A subroutine of typhoon_translate_iommu that handles scatter-gather
+ * translation, given the address of the PTE.
+ */
 static bool pte_translate(hwaddr pte_addr, IOMMUTLBEntry *ret)
 {
     uint64_t pte = address_space_ldq_le(&address_space_memory, pte_addr,
@@ -633,8 +639,10 @@ static bool pte_translate(hwaddr pte_addr, IOMMUTLBEntry *ret)
     return make_iommu_tlbe((pte & 0x3ffffe) << 12, 0x1fff, ret);
 }
 
-/* A subroutine of typhoon_translate_iommu that handles one of the
-   four single-address-cycle translation windows.  */
+/*
+ * A subroutine of typhoon_translate_iommu that handles one of the
+ * four single-address-cycle translation windows.
+ */
 static bool window_translate(TyphoonWindow *win, hwaddr addr,
                              IOMMUTLBEntry *ret)
 {
@@ -668,8 +676,10 @@ static bool window_translate(TyphoonWindow *win, hwaddr addr,
 }
 
 /* Handle PCI-to-system address translation.  */
-/* TODO: A translation failure here ought to set PCI error codes on the
-   Pchip and generate a machine check interrupt.  */
+/*
+ * TODO: A translation failure here ought to set PCI error codes on the
+ * Pchip and generate a machine check interrupt.
+ */
 static IOMMUTLBEntry typhoon_translate_iommu(IOMMUMemoryRegion *iommu,
                                              hwaddr addr,
                                              IOMMUAccessFlags flag,
@@ -773,10 +783,12 @@ static void typhoon_set_timer_irq(void *opaque, int irq, int level)
     TyphoonState *s = opaque;
     int i;
 
-    /* Thankfully, the mc146818rtc code doesn't track the IRQ state,
-       and so we don't have to worry about missing interrupts just
-       because we never actually ACK the interrupt.  Just ignore any
-       case of the interrupt level going low.  */
+    /*
+     * Thankfully, the mc146818rtc code doesn't track the IRQ state,
+     * and so we don't have to worry about missing interrupts just
+     * because we never actually ACK the interrupt.  Just ignore any
+     * case of the interrupt level going low.
+     */
     if (level == 0) {
         return;
     }
@@ -787,14 +799,16 @@ static void typhoon_set_timer_irq(void *opaque, int irq, int level)
         if (cpu != NULL) {
             uint32_t iic = s->cchip.iic[i];
 
-            /* ??? The verbage in Section 10.2.2.10 isn't 100% clear.
-               Bit 24 is the OverFlow bit, RO, and set when the count
-               decrements past 0.  When is OF cleared?  My guess is that
-               OF is actually cleared when the IIC is written, and that
-               the ICNT field always decrements.  At least, that's an
-               interpretation that makes sense, and "allows the CPU to
-               determine exactly how mant interval timer ticks were
-               skipped".  At least within the next 4M ticks...  */
+            /*
+             * ??? The verbage in Section 10.2.2.10 isn't 100% clear.
+             * Bit 24 is the OverFlow bit, RO, and set when the count
+             * decrements past 0.  When is OF cleared?  My guess is that
+             * OF is actually cleared when the IIC is written, and that
+             * the ICNT field always decrements.  At least, that's an
+             * interpretation that makes sense, and "allows the CPU to
+             * determine exactly how mant interval timer ticks were
+             * skipped".  At least within the next 4M ticks...
+             */
 
             iic = ((iic - 1) & 0x1ffffff) | (iic & 0x1000000);
             s->cchip.iic[i] = iic;
@@ -852,13 +866,17 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
     *p_isa_irq = qemu_allocate_irq(typhoon_set_isa_irq, s, 0);
     *p_rtc_irq = qemu_allocate_irq(typhoon_set_timer_irq, s, 0);
 
-    /* Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
-       but the address space hole reserved at this point is 8TB.  */
+    /*
+     * Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
+     * but the address space hole reserved at this point is 8TB.
+     */
     memory_region_add_subregion(addr_space, 0, ram);
 
     /* TIGbus, 0x801.0000.0000, 1GB.  */
-    /* ??? The TIGbus is used for delivering interrupts, and access to
-       the flash ROM.  I'm not sure that we need to implement it at all.  */
+    /*
+     * ??? The TIGbus is used for delivering interrupts, and access to
+     * the flash ROM.  I'm not sure that we need to implement it at all.
+     */
 
     /* Pchip0 CSRs, 0x801.8000.0000, 256MB.  */
     memory_region_init_io(&s->pchip.region, OBJECT(s), &pchip_ops, s, "pchip0",
@@ -916,9 +934,11 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
     memory_region_add_subregion(addr_space, 0x801fe000000ULL,
                                 &s->pchip.reg_conf);
 
-    /* For the record, these are the mappings for the second PCI bus.
-       We can get away with not implementing them because we indicate
-       via the Cchip.CSC<PIP> bit that Pchip1 is not present.  */
+    /*
+     * For the record, these are the mappings for the second PCI bus.
+     * We can get away with not implementing them because we indicate
+     * via the Cchip.CSC<PIP> bit that Pchip1 is not present.
+     */
     /* Pchip1 PCI memory, 0x802.0000.0000, 4GB.  */
     /* Pchip1 CSRs, 0x802.8000.0000, 256MB.  */
     /* Pchip1 PCI special/interrupt acknowledge, 0x802.F800.0000, 64MB.  */

-- 
2.53.0


