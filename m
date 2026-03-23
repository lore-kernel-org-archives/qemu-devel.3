Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE92EC01C4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cvl-0001v6-Ro; Mon, 23 Mar 2026 06:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvk-0001uI-DW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvi-00066d-KY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so25526865e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263281; x=1774868081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k5Z763d6X03vG3iJc5sKRc8GlONoknrUoOK/ogdPcDo=;
 b=k0JZDnxgiJGfxTb7u0u4Z9rXQ7chzhaKTDQVcoGC4HsgDn3+0dWkzQ28gIS/xOauQ5
 fW99uOgWM4dG+lNk8OcBbo7iGF7Rsu32Zuv2k6QPqLlAgPm88w/fGeB2ck1lsxD4Ap6s
 Hyy0/SkzmYcCPkC5j8u2usidwyQ3LxErUYsRHE8Ha0K9VEJYgpkiJF4U3z34V/bbTRuJ
 oV2CnDNlPQEMQv/H6VflQlc8Xo/Bp+gp/ovZG5KEuho4eAQRqb4T6AVn/BZMqeiBhtE4
 0Zyyg4NNfZrhYmtPZLyA7XUMMHcyGvLOR8FZ26ExjQgPPUbzRwrF4/KJdqNqPGhuKKmw
 ZqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263281; x=1774868081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k5Z763d6X03vG3iJc5sKRc8GlONoknrUoOK/ogdPcDo=;
 b=UIia/C0abMsTQy9XLsifyqVcQeS4vGTSzPvYwiXM67YZK1d1KVor5aMS5K8QnTnSdV
 KIcMa24tN+IrqBrpMWpz48FVXjT8pwya3IKKXJojJkrz8OKFMMjOjKhoef/O+dikxfxv
 huM8nGToIDlKs+pMTR5VPrq/sGSYaoLsWtVY8+Lesw6S27U1X1e38cVM4MPnjYtYyRZH
 arroQwTd+v326Hn2v8C5P6yThdeSuqt7AW3rxbAz2z/Hc20dv5FMRdoJ59A5cBS1JjnQ
 vRm+jaKotWDwU8mSiKj8m2BeBjGQsnsMMw9fZwkbsLOKnbCelQjJImWokl+3mB+uJ9dY
 S0VA==
X-Gm-Message-State: AOJu0YyXPxCjSBF4wDn2yEFcvQsd5qC8raKXmmUY5PSShLk06CByksIJ
 /j46FRR1C6NbXUaNS4Pmd6cErbICKtXSWbyCaJOJP9otP24gS9Gh8O42ZX+w0wQoN55GKMY4PKc
 LgoFwNNk=
X-Gm-Gg: ATEYQzwoNXwOFy4Ocr/2oyFjCpcGrCe5G8lZ2vAZSwpwvIqyjlnpgUbo7QpTUnJ/ql9
 NE0XgtDRSUZX0/7WDGsit+vFvD6XXUvKa/yvinDTERKvO1gbpqolBxJpGoVbS9AUhu/FS4CrO+1
 k431TAp4F21iBWaLY2FbbswnSi/R8yxEmmNeR0tEiynUKcZskbcrSuRwQwdOR8PUK4D3w6OqzO0
 0YEeX1OLcmx3B+8sQD/me0Orfz/blYOrIclFBzcULyqTDtjNDe7c2G6RhGtvKNAjOC3rFdTcJ3/
 Wo2b1T9PkY8KUJ1wsoaBt37+ySD0oGJv6rnNT30ue1HGBlyEOtTysMVmpWJVYolTwIhj796GbTn
 pOInfb4Q/EpxC2weP84FMmeCyaWxeYGezRHNvmAt1xGZMwMRvlMoCIe8mxsM8h9qvcGVvxiO5fG
 UH3rgntvFY5HPYXYEq6aiFc2KluQscnUIg/EwqFw8odM3jxQi07DVjzxNorsAYXBa/wljQcQV6x
 YvbILtocGKA90h1brqj2uUuTT+iUZM=
X-Received: by 2002:a05:600c:45c7:b0:485:3fd1:9936 with SMTP id
 5b1f17b1804b1-486fede721amr150941555e9.5.1774263281183; 
 Mon, 23 Mar 2026 03:54:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm115483185e9.8.2026.03.23.03.54.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 03:54:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] hw/isa/piix: Embed i8259 irq in device state instead of
 allocating
Date: Mon, 23 Mar 2026 10:54:29 +0000
Message-ID: <20260323105429.4059580-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323105429.4059580-1-peter.maydell@linaro.org>
References: <20260323105429.4059580-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The pci_piix_realize() function's use of qemu_allocate_irqs()
results in a memory leak:

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x61045c7a1a43 in malloc (/home/pm215/qemu/build/san/qemu-system-mips+0x16f8a43) (BuildId: aa43d3865e0f1991b1fc04422b5570fe522b6fa7)
    #1 0x724cc3095ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x61045db72134 in qemu_extend_irqs /home/pm215/qemu/build/san/../../hw/core/irq.c:77:51
    #3 0x61045cd7bf49 in pci_piix_realize /home/pm215/qemu/build/san/../../hw/isa/piix.c:318:35
    #4 0x61045cf4533e in pci_qdev_realize /home/pm215/qemu/build/san/../../hw/pci/pci.c:2308:9
    #5 0x61045db6cbca in device_set_realized /home/pm215/qemu/build/san/../../hw/core/qdev.c:523:13
    #6 0x61045db86bd9 in property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:2376:5
    #7 0x61045db81c5e in object_property_set /home/pm215/qemu/build/san/../../qom/object.c:1450:5
    #8 0x61045db8e2fc in object_property_set_qobject /home/pm215/qemu/build/san/../../qom/qom-qobject.c:28:10
    #9 0x61045db8258f in object_property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:1520:15
    #10 0x61045db687aa in qdev_realize_and_unref /home/pm215/qemu/build/san/../../hw/core/qdev.c:283:11
    #11 0x61045d892e21 in mips_malta_init /home/pm215/qemu/build/san/../../hw/mips/malta.c:1239:5

(The i386 PC sets the has-pic property to 'false', so this only
affects the MIPS Malta board.)

Fix this by embedding the i8259 irq in the device state instead of
allocating it.  This is a similar fix to the one we used for vt82c686
in commit 2225dc562a93dc, except that we use qemu_init_irq_child()
instead of qemu_init_irq().  The behaviour is identical except that
the _child() version avoids what would be a leak if we ever
unrealized the device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20260309171258.1905205-1-peter.maydell@linaro.org
---
 hw/isa/piix.c                 | 11 ++++++-----
 include/hw/southbridge/piix.h |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 04b2be2cc3..31fa53e6a4 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -315,12 +315,13 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
 
     /* PIC */
     if (d->has_pic) {
-        qemu_irq *i8259_out_irq = qemu_allocate_irqs(piix_request_i8259_irq, d,
-                                                     1);
-        qemu_irq *i8259 = i8259_init(isa_bus, *i8259_out_irq);
-        size_t i;
+        qemu_irq *i8259;
 
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
+        qemu_init_irq_child(OBJECT(dev), "i8259-irq", &d->i8259_irq,
+                            piix_request_i8259_irq, d, 0);
+        i8259 = i8259_init(isa_bus, &d->i8259_irq);
+
+        for (size_t i = 0; i < ISA_NUM_IRQS; i++) {
             d->isa_irqs_in[i] = i8259[i];
         }
 
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 86709ba2e4..a296b1205a 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -17,6 +17,7 @@
 #include "hw/ide/pci.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/usb/hcd-uhci.h"
+#include "hw/core/irq.h"
 
 /* PIRQRC[A:D]: PIRQx Route Control Registers */
 #define PIIX_PIRQCA 0x60
@@ -52,6 +53,8 @@ struct PIIXState {
     qemu_irq cpu_intr;
     qemu_irq isa_irqs_in[ISA_NUM_IRQS];
 
+    IRQState i8259_irq;
+
     /* This member isn't used. Just for save/load compatibility */
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
 
-- 
2.43.0


