Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B970AC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURH6-00005X-BF; Thu, 18 Jul 2024 09:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURH4-0008D4-Nr
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURH2-00004w-Qe
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368557c9e93so348393f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309659; x=1721914459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6Hx2eTtFNzw/hpMI15i/HZcqpokYYD9kQA6KJM/AwE=;
 b=Uwy4A7TLEgUxfYBnvnqCZOzCxHam+ZJN+9BEKEi8ssFto/ogq5FMcSoXReQhxfz00E
 TE7CpjlPqN2M9RZrw/cv66Hv+9o19zWEYn9mIE3Hs16SDxoXQK/G5dIB4VMld96hLZvn
 llDIsEQeunESA4KZ5siYhsu6qm4yLrZT3XZmwr3J2tEkSTrNwZu4eYWaF+GK/7ibvg9+
 c43o/9JOqWHWFllAxCykf12G/tRaL3J0tXJIo1f3H40w4aXREAyCCwV7gTox5Xlv1QJX
 YWLCK5fm2QRIFq9cRf15HPbXfcG38CaQWzTkGwqxtyhRVdpKDgwx3jPVJM1PgWNIsez7
 weIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309659; x=1721914459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6Hx2eTtFNzw/hpMI15i/HZcqpokYYD9kQA6KJM/AwE=;
 b=KzhI3PHTPe65AiclWnc5pFMxOlVzRuoGs8dGqcR9jEZ81S8tvqSjEjiWVdAkxZCsi5
 yY55F+Fa/Q8A5ZIwhX5hgkbaxtbRipkuJlzGcvm2rH44BOj8R9Ucoys99GBLKTwMzrwV
 S7YR7jiGmuTDM22+5GdiWLtnNO4oYIoCbq4tUHYRfH+oZm3JQtd12iFAo+Ln4afqXXpQ
 XiEOuUBOltOOny2EQySDHfrJGZA1beU/xhI8RQ1lMnh1Q9mVeHy/eweo5s0BQsEF2Zei
 DeBQZlijvSbsW02QeUK7k80NBzhLl8PxmWtmzMWoP+UnKdMweXlbdMYZuRgR5vqotwau
 rM1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG8oVct2qXJgv1cl74xg2uPuLp178UZhLjxbB1oflSsEq5BR1OnsS/4WYk9pzUbxspmq4kfAAQ/HJLdiCgVYmpX0Vsp+A=
X-Gm-Message-State: AOJu0YzSBLZI5XDgCCI/LWa+IBI9vt63FZXFJ92+Ywb4xT/8WkqXviK0
 GCxHz/HHBiH7KE9ryvOkfsMy/L4AShD+viwSlcw8ofHsXg9uKvUKFfY11r6L/sbqnUcaSlETPzz
 8
X-Google-Smtp-Source: AGHT+IHiVu0XLmxH93CmGYQ/PfpyjpBQUzoSJ2ttCsJAppCbk59j/aUYzhhboLH8cmRbk4Xiou8vvQ==
X-Received: by 2002:a5d:5547:0:b0:362:3cb8:cba with SMTP id
 ffacd0b85a97d-368317c88a8mr2893373f8f.67.1721309659003; 
 Thu, 18 Jul 2024 06:34:19 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabefa6sm14298504f8f.44.2024.07.18.06.34.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:34:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 11/19] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::get_iocsr_as handler
Date: Thu, 18 Jul 2024 15:33:03 +0200
Message-ID: <20240718133312.10324-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
Acked-by: Song Gao <gaosong@loongson.cn>
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


