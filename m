Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B2CC3065B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 04:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMgW9-00069Z-Ds; Thu, 27 Jun 2024 00:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMgW6-00069I-S9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:13:50 -0400
Received: from wfhigh6-smtp.messagingengine.com ([64.147.123.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMgW4-00006O-VR
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:13:50 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.west.internal (Postfix) with ESMTP id 4B87418000BD;
 Thu, 27 Jun 2024 00:13:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 27 Jun 2024 00:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719461626;
 x=1719548026; bh=oWYIZgaj1QVubjdIVuzqdy0JTqC1HeZlWQN39wMLyNI=; b=
 oAXflzGzK1QDWD7QJT8n+26NJLtmuf7zU/AQR/scg2wx5hrP1CPy03kvwwmoj58g
 nuM52WJxxI6KrLO4PKxGfOmgUS+JUgfGwJy74+3tF23LqMNKhMi4hSMQBEJZrot6
 U05SPJwr4kz80p1M6hwTs5ozZjgEbtkC5Kt68t9+KJthhj4af4BIcQGT+XQKSghQ
 swpCX0wLdBaDalbKKYZoI2AXha651o+3vJcbWmrYVm3Tr1bBBE/4KfHu2UXekgAr
 49uRtI/iAQVj+EbF0+qSpx6eHngxsKXfmFIydaGOlmqmz+xrhtJRjrpH4ABq4c37
 Ikk15Tte/PIyt5Kjv9LN2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719461626; x=
 1719548026; bh=oWYIZgaj1QVubjdIVuzqdy0JTqC1HeZlWQN39wMLyNI=; b=F
 jDxc2qk5WdDXDbZpTxgRcCzZAdQ86uCWAiXLOpgiCfrzasv33pGcyYw2cjXz7oXd
 dunGCJ+yPf8NP7t2WO2IXGDIQWdETiLwrFn1aSXwPTkN5dNGGu6v4F8ggA3CWeFf
 up+zPI0cX4wXr7ovPVrn/QUhyNsNuD92Kb3Omg3sWbF4vdxj0pJdbkGoSsTEvy3p
 X5e6jHWDvAJ25/4IMYRCA3jqKd2xFkaEZYUdMNjupcFpBInal+nxbG+j0S+jTAtJ
 EOdaiv84yaLVFBiE0tTDOnWVceqJXFFNMrEDL6o8CF2JrwQVtNeiZvx6JqqJSMdB
 +dzQ7S9MOtwyR0J4Z11YQ==
X-ME-Sender: <xms:-uZ8ZqWb8PwBjvOLzNg1EqcVxSo9mnmyIpYWSK1cnQab5XC36nmXEQ>
 <xme:-uZ8ZmmfWrjqkQusaMYR81A4IOeZ-qkO91dt1yzcww7jMnIIum1ScCBZhlOlI_WiQ
 pWj-1IyILZcyPqtasg>
X-ME-Received: <xmr:-uZ8ZuaN-uNGpJWlhndGQTKjM016MFR2yQHXbyeIS0DmsZMO_ApzfMQpQrGSqDwJ74-EREgJu2oq6JtAi1cnXTj8Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdefgdekudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
 geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:-uZ8ZhV7FrYddddrwam0QhgEBDsRewZ8lFRtLZgHwbrh1EDBEpPa8Q>
 <xmx:-uZ8ZkkKx6Pl6Kg6AqSaNXkLaVlS9HkTVurTUbflYloDLQYEJrI5Bw>
 <xmx:-uZ8ZmeTL9nGAUqu-FsxAx_C_KvxP5Z0rdSNQVK3NkCteP-zIPyOJQ>
 <xmx:-uZ8ZmHeQd-DnatWYHtGlAkI9BmjnGT-G6VjIfCxjKsjHfveT_gilg>
 <xmx:-uZ8ZiY0gCzSUc6nplh5U4YF9dntON9LLfzxMW0aiFfeS7jbJZZOtU1n>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jun 2024 00:13:43 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 27 Jun 2024 05:13:27 +0100
Subject: [PATCH 1/2] hw/intc/loongson_ipi: Gate MMIO regions creation with
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-ipi-fixes-v1-1-9b061dc28a3a@flygoat.com>
References: <20240627-ipi-fixes-v1-0-9b061dc28a3a@flygoat.com>
In-Reply-To: <20240627-ipi-fixes-v1-0-9b061dc28a3a@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, maobibo <maobibo@loongson.cn>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3536;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=6Ifi0LX/Hzl5xVmPFwnzHajrPekTKq8WhVhlqGtVBH4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSaZ597K5VL3/E8v21uIBTjWz53dlGlqcR0Xa4zjDrV+
 mJNt3d2lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwET+GDD8lVjSefeVYvbNfe0X
 nKK139wsm7fQRsp+i0jmmxMNPk838zP8L4m03hW1g5v90CNOS5l5YZe/mn64elN2+Vm3Kd6br3d
 +YQMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 49eba52a52fe ("hw/intc/loongson_ipi: Provide per core MMIO address
spaces") implemented per core MMIO spaces for IPI registers.

However on LoongArch system emulation with high core count it may exhaust
QDEV_MAX_MMIO and trigger assertion.

Given that MMIO region is unused for LoongArch system emulation (we do have
it on hardware but kernel is in favor of IOCSR), gate MMIO regions creation
with "has-mmio" property and only set if for loongson3-virt machine to avoid
such limitation on LoongArch.

Reported-by: maobibo <maobibo@loongson.cn>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/intc/loongson_ipi.c         | 23 ++++++++++++++---------
 hw/mips/loongson3_virt.c       |  1 +
 include/hw/intc/loongson_ipi.h |  1 +
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index e6a7142480c6..6e92a503499a 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -305,15 +305,19 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    for (i = 0; i < s->num_cpu; i++) {
-        s->cpu[i].ipi = s;
-        s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
-        g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
-        memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
-                              &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
-        sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
-
-        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+    if (s->has_mmio) {
+        for (i = 0; i < s->num_cpu; i++) {
+            s->cpu[i].ipi = s;
+            s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
+            g_autofree char *name =
+                        g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
+            memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
+                                  &loongson_ipi_core_ops, &s->cpu[i],
+                                  name, 0x48);
+            sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
+
+            qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+        }
     }
 }
 
@@ -344,6 +348,7 @@ static const VMStateDescription vmstate_loongson_ipi = {
 
 static Property ipi_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", LoongsonIPI, num_cpu, 1),
+    DEFINE_PROP_BOOL("has-mmio", LoongsonIPI, has_mmio, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4ad36f0c5b64..a27b30ab318c 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -537,6 +537,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     if (!kvm_enabled()) {
         ipi = qdev_new(TYPE_LOONGSON_IPI);
         qdev_prop_set_uint32(ipi, "num-cpu", machine->smp.cpus);
+        qdev_prop_set_bit(ipi, "has-mmio", true);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
         memory_region_add_subregion(iocsr, SMP_IPI_MAILBOX,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 3f795edbf3cd..0e35674e7aaf 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -50,6 +50,7 @@ struct LoongsonIPI {
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
     uint32_t num_cpu;
+    bool has_mmio;
     IPICore *cpu;
 };
 

-- 
2.43.0


