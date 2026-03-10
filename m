Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C28CFD88C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05dG-0001MQ-MD; Tue, 10 Mar 2026 18:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05ct-0001FN-Ia
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:32 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cr-00073E-4v
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:31 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 cf41c046de2e4ac6d2e28fe40b63b649f3ff6681802e10b99dcc74867cec17c1 with SMTP id
 69b09bf4cc25e8f3d6d4211b; Tue, 10 Mar 2026 22:32:20 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181939;
 bh=he+OIHsDL4Cpi2icki8c89iO5oTPNbgi5gcs6FRKda8=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=jLYV8RIEJuDwllrb3fdPqyrpJdimCQbT0QmiOhz8tu9M3jkqZJRd0tKh99z8+BHzi
 3qAyiP0qk9fNlNhzrJef6DdSjIzTTIoXSUbzv+QDuQcT7Z48rqQ8azfuL2XLtL4vOw
 TVpXm3t9Gy3G3gpw3A27CNz3iqG/vsXYuykRzDbcw+K3fFTzBXRIjBCWYZrFbZTj8I
 W5BYdMkXgdzVYVA8ygvsaC7+C4i3S25fmQFi9TOAUNddhRfhhzsQcPy9utrnMhoFOe
 9fHdrYpp1R9LfYdSQfhQwMMeuNcq4jz0inlh/faoeVF5dRqlHMp23xMNCK3En/j+He
 2IUhO+7Z8gPMA==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:42 -0500
Subject: [PATCH 02/15] hw/alpha/dp264: Fix block comment style problems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-2-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=gBdfph73//0K5zUt1GbBAKSuO1D7OanoH0ObpHGVyG4=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP74ccPi6x/9A3q0b15Sd47/E7hW/pTC0iMJxVKV4
 crB+9OtO0pZGMS4GGTFFFkun5U465C7uytt5Y/7MHNYmUCGMHBxCsBEFDIZGfamqv+90TdlSWL2
 ydlsxvPt3mh85vvVsvXu4x1H4kpmhykx/LN2c1VbF5ZieT1fwPhzkJT++VS/iham7Sqiq34Ybp4
 UzAcA
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

Use leading "/*", internal "*", and trailing "*/" for block comments.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/dp264.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 98219f0456..27fbcee637 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -26,12 +26,14 @@ static uint64_t cpu_alpha_superpage_to_phys(void *opaque, uint64_t addr)
     return addr;
 }
 
-/* Note that there are at least 3 viewpoints of IRQ numbers on Alpha systems.
-    (0) The dev_irq_n lines into the cpu, which we totally ignore,
-    (1) The DRIR lines in the typhoon chipset,
-    (2) The "vector" aka mangled interrupt number reported by SRM PALcode,
-    (3) The interrupt number assigned by the kernel.
-   The following function is concerned with (1) only.  */
+/*
+ * Note that there are at least 3 viewpoints of IRQ numbers on Alpha systems.
+ *  (0) The dev_irq_n lines into the cpu, which we totally ignore,
+ *  (1) The DRIR lines in the typhoon chipset,
+ *  (2) The "vector" aka mangled interrupt number reported by SRM PALcode,
+ *  (3) The interrupt number assigned by the kernel.
+ * The following function is concerned with (1) only.
+ */
 
 static int clipper_pci_map_irq(PCIDevice *d, int irq_num)
 {
@@ -132,9 +134,11 @@ static void clipper_init(MachineState *machine)
     pci_dev = pci_create_simple(pci_bus, -1, "cmd646-ide");
     pci_ide_create_devs(pci_dev);
 
-    /* Load PALcode.  Given that this is not "real" cpu palcode,
-       but one explicitly written for the emulation, we might as
-       well load it directly from and ELF image.  */
+    /*
+     * Load PALcode.  Given that this is not "real" cpu palcode,
+     * but one explicitly written for the emulation, we might as
+     * well load it directly from and ELF image.
+     */
     palcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
                                       machine->firmware ?: "palcode-clipper");
     if (palcode_filename == NULL) {

-- 
2.53.0


