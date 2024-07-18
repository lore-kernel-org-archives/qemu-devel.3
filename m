Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FE4C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMgZ-0008Hb-TU; Thu, 18 Jul 2024 04:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgS-0007bw-43
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:17 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgO-00050P-T0
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4266f535e82so458285e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721292010; x=1721896810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fEZNDPPoxKFs7H+NykCV578N/mSSTlQ4AcK8WKF7wg=;
 b=uTZ4wTLczI+btDEFXH4SXV9IEsLHPUZqWWTBHAG93UP01dp4gycuezrcpYBNrnxFNR
 RmwdBDHoqSgT9PXRrBPCUdyJUQleMzlr9bfGKkaV+9G3Cuv1rhw1KIXesD7Iw+LWxWUE
 6LT+1qRNFaUJfxGFAqfK4+SjUkqpwpVpdkY6I7DXkR9RYS/SN5GQGoQnn84LvlyorzxJ
 ROmyPQ4cqSJgbjPymp3X2OJro6VLPPrw7PSBVIV4tD4/sQKs5GhXBw2dz1z+3XoL2gTw
 cx4Tcd7W0pQQGn2cwThu76T9iBnmpqUdWyxXF8a+cRcfzbxnS31GKaaxsQltX/JB31Uc
 +JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721292010; x=1721896810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fEZNDPPoxKFs7H+NykCV578N/mSSTlQ4AcK8WKF7wg=;
 b=vTImp92B/Xcmv6tltedz2FJI2CzEZdMCeERbZRyvoYtHyIOSUZdBEqK9nFCc7I/7Ij
 RjhAx0/dwTwoLKeDTIon1eQm4l7KVnnCTmbFrOwbYZwxDHT0tmttbkYICnUtLG0fsWHw
 nDTgTH1k56tFSiqo+ocxsmn4Y/toOCq7ViUZb1qmKaWXI8nAYy+6LZflob1Nmal9J2Ld
 XLm1dYEjB9HTfjOKx5x2TqaQ2kRx+i/QQ+37/wQxoEHVrYXxU+EmBckJ0YGoFyeP4iBB
 qTi+xHZ6pYmipnEGxg7wdJHhMLxzmn9xVLcBoAXp/lHhxkLVx9GKp+M8zJbJngFw0ZOd
 Luxw==
X-Gm-Message-State: AOJu0Yz7mPIKH2E6YmLmtQim0exx3q/0Cakuoq1U0+aP1XXEfXDasvK5
 GkJwZxzJ3DOH/JcUgslN71RCR1xcD0MbhjzCld0jHPzbtjWb+H9Nsc2c6+pm3U+M5XeLutVwc21
 lWC0=
X-Google-Smtp-Source: AGHT+IETt/9CLcL8QmyIs0SmXiVmuUwkvY+JRiZ5SfN54Iu4VBGTYmdZ7aS5pdr/oujY4KkmEAQTHA==
X-Received: by 2002:a05:600c:4f56:b0:426:6f17:531 with SMTP id
 5b1f17b1804b1-427c2cb15cbmr36424125e9.13.1721292010081; 
 Thu, 18 Jul 2024 01:40:10 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b133bdsm1495305e9.10.2024.07.18.01.40.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:40:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 11/18] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::get_iocsr_as handler
Date: Thu, 18 Jul 2024 10:38:35 +0200
Message-ID: <20240718083842.81199-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Allow Loongson IPI implementations to have their own get_iocsr_as()
handler.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
---
 include/hw/intc/loongson_ipi_common.h |  2 ++
 hw/intc/loongson_ipi.c                | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index 891b43644d..e49c156db3 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -39,6 +39,8 @@ struct LoongsonIPICommonState {
 
 struct LoongsonIPICommonClass {
     SysBusDeviceClass parent_class;
+
+    AddressSpace *(*get_iocsr_as)(CPUState *cpu);
 };
 
 /* Mainy used by iocsr read and write */
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index a54db87638..2c8829c3cc 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -75,24 +75,30 @@ static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
     return loongson_ipi_core_readl(s, addr, data, size, attrs);
 }
 
-static AddressSpace *get_cpu_iocsr_as(CPUState *cpu)
-{
 #ifdef TARGET_LOONGARCH64
+static AddressSpace *get_iocsr_as(CPUState *cpu)
+{
     return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
+}
 #endif
+
 #ifdef TARGET_MIPS
+static AddressSpace *get_iocsr_as(CPUState *cpu)
+{
     if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
         return &MIPS_CPU(cpu)->env.iocsr.as;
     }
-#endif
+
     return NULL;
 }
+#endif
 
 static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
                                  uint64_t val, hwaddr addr, MemTxAttrs attrs)
 {
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
     int i, mask = 0, data = 0;
-    AddressSpace *iocsr_as = get_cpu_iocsr_as(cpu);
+    AddressSpace *iocsr_as = licc->get_iocsr_as(cpu);
 
     if (!iocsr_as) {
         return MEMTX_DECODE_ERROR;
@@ -338,9 +344,11 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongsonIPIClass *lic = LOONGSON_IPI_CLASS(klass);
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
 
     device_class_set_parent_realize(dc, loongson_ipi_realize,
                                     &lic->parent_realize);
+    licc->get_iocsr_as = get_iocsr_as;
 }
 
 static void loongson_ipi_finalize(Object *obj)
-- 
2.41.0


