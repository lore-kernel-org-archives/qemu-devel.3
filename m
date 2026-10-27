Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF487606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EJGxu3Os
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLag7-0001tK-VG; Tue, 27 Oct 2026 02:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafz-0001s6-TC
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:52 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafy-0008A5-8G
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:51 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ac7842c17dso2132114a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082529; x=1793687329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lyTAbKKelFsHvBAZKXGTTlcNG3b6HkNaMhPtW/7lBSc=;
 b=EJGxu3Os6w9WQFVMezcsZxDsOS8bODbiPLHM7a52O9oeX96c5H/IdFi79mMDzPN994
 WEH8+zTeHKJcSxXMbKMerLIQLRDxJJq6xa19tmafmDsCv8VKj4I1uauItp73fAojcmuB
 9oOU2sPHnkMdRJy/VznE/hhmtKk1bRLGXJspo48MBKXAbwnnzkKpCT7zG3Xdwu1wWoNY
 Q6IXUlhef3kDCj0TbuGW/5tzWKN30/Yb6KnvMYA6CVuDsYe6dpEpGPMDa71IMd8zWyK1
 aKQmqgSZfPipEV42+7pq/EmbO/D1Y7pbduv8MaV+CHCzRMf4xdT7IX1Zvnq7HjJclA9h
 SJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082529; x=1793687329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lyTAbKKelFsHvBAZKXGTTlcNG3b6HkNaMhPtW/7lBSc=;
 b=paQsSdykgcAEdabl6Wya4qgQLASUFB02xrkyRGjBw4PT9Zzg7vj8BSFWiiVOO+UqP5
 GArSN2aM/Wlv6sDTNOF1pyLmzo+mPm5DnUhhk7WBQRJZmq02BtQ8LNwDT8iXBBNGhtWY
 IOoOhF78U+1L01g5sFuauyDahXcbY/UVqLaRjXBULMyMToXXsMEyiHSduZ3QtvnJnbMD
 ap61gBooMxVPvOD700FTyRmpUaWyxHv4YVQAmI5EiD33cK0NACCnGwoV/z6BJN9MnC75
 PArR3TTTs9RxTE/h9GxKOTHaGs4M/QFdTWxKCBtwKhKF1hTGXzA4ERsEIs4SaWzW76it
 DU+A==
X-Gm-Message-State: AFq9FYKDfqd+pIL0mamIROKn1hDMDo3q5HRsJN2T85sk8VJHwhRLtg45
 DYYiiCbh78IMjmXWkOsb83/OQRXTiKlozLsByjNGuY02ll0hQFK7gf3Er5nDew==
X-Gm-Gg: AYBFou2C9WVAcVkGhjIaIUHVuv9ygup6wQAPBT/WRntwE0k06Z59ihpYn+Bc5L0tVMO
 48zXxp+NLvGGGaIQK/o6REKsxZG8uk8tEFeV0CYN9RI1Kn4Ss5ki1kIWbocGpsmWvNDHGUnS5mq
 KqrEKyKRT3W5vU6cGj0PeUIOp4aGvmhF8/2tW+QtkHHOAUJ/xbb6HZMjwZGKVahNSsKQS6A/K+S
 C8Xs15raFy4ojWoGc8SJuiHgsKXXN8V0UOGBYQkBIPLU9/ySlNZWOZ2pR9LF1nYeGqMlQLvhqOe
 eGi1FsV/hufqG6C8zjGMyQtysv2Ay83bzxQ3iIotvRPlgLChibuYDG4dWKAD37VgRJ2Nb/cdAgo
 FmSgiy0O2l3ktgMGAvAAWzCQK8YnTkoS9yCp+TOIdpmXnCLn5A4Xyyujj33Tg5ZZzzVNqTmzjsQ
 6TCdzrlTYnpH4/NPy35p9p8Owywvj1+8RxF2YTDCxt6Bvxj/Ow768XD0vlVqNq04xJSC3MMBndw
 ptTpT/hXq1J67HSX/pLGRbKNr2Ut5WFuZ9StH5PiZ0+xL+s+qMA16cCibTfcyS5n2uRKQToiQ==
X-Received: by 2002:a17:90b:5744:b0:3a6:f1d2:57f3 with SMTP id
 98e67ed59e1d1-3adeafaead2mr6964901a91.58.1793082528897; 
 Mon, 26 Oct 2026 23:28:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:28:48 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Portia Stephens <portias@oss.tenstorrent.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/29] hw/riscv/atlantis: Add all UARTs for Atlantis SoC
Date: Tue, 27 Oct 2026 16:27:46 +1000
Message-ID: <20261027062808.1995205-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Portia Stephens <portias@oss.tenstorrent.com>

Previously only the Ascalon console UART was enabled, this enables all 5
UARTs on the SoC. Only UART1 is added to the serial interface for now.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261015002849.1640109-3-portias@oss.tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/tt_atlantis.h | 11 ++++++++++-
 hw/riscv/tt_atlantis.c         | 36 ++++++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index fc7a4337cc21..f965bf23fcde 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -25,6 +25,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisSoCState, TT_ATLANTIS_SOC)
 
 #define TT_ATL_NUM_I2C 5
 #define TT_ATL_NUM_PRCM 4
+#define TT_ATL_NUM_UARTS 5
 
 struct TTAtlantisSoCState {
     /*< private >*/
@@ -41,7 +42,7 @@ struct TTAtlantisSoCState {
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
-    DW8250State uart1;
+    DW8250State uart[TT_ATL_NUM_UARTS];
     MemoryRegion bootrom;
     TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
 
@@ -66,7 +67,11 @@ enum {
     TT_ATL_I2C2_IRQ = 35,
     TT_ATL_I2C3_IRQ = 36,
     TT_ATL_I2C4_IRQ = 37,
+    TT_ATL_UART0_IRQ = 38,
     TT_ATL_UART1_IRQ = 39,
+    TT_ATL_UART2_IRQ = 40,
+    TT_ATL_UART3_IRQ = 41,
+    TT_ATL_UART4_IRQ = 42,
 };
 
 enum {
@@ -83,7 +88,11 @@ enum {
     TT_ATL_MIMSIC,
     TT_ATL_SAPLIC,
     TT_ATL_SIMSIC,
+    TT_ATL_UART0,
     TT_ATL_UART1,
+    TT_ATL_UART2,
+    TT_ATL_UART3,
+    TT_ATL_UART4,
     TT_ATL_PRCM_RCPU,
     TT_ATL_PRCM_HSIO,
     TT_ATL_PRCM_PCIE,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index dfd6bc6ba6ec..311de64eda55 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -64,7 +64,11 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_I2C2] =             { 0xd4060000,       0x10000 },
     [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
     [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
+    [TT_ATL_UART0] =            { 0xd4100000,       0x10000 },
     [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
+    [TT_ATL_UART2] =            { 0xd4120000,       0x10000 },
+    [TT_ATL_UART3] =            { 0xd4130000,       0x10000 },
+    [TT_ATL_UART4] =            { 0xd4140000,       0x10000 },
     [TT_ATL_PRCM_PCIE] =        { 0xd8000000,         0x100 },
     [TT_ATL_PRCM_MM] =          { 0xdc000000,        0x1000 },
     [TT_ATL_PRCM_HSIO] =        { 0xe00c0000,         0x510 },
@@ -531,13 +535,21 @@ static void tt_atlantis_machine_done(Notifier *n, void *data)
                               fdt_load_addr);
 }
 
+static inline int tt_atlantis_uart_index(int uart_dev)
+{
+    return uart_dev - TT_ATL_UART0;
+}
+
 static void tt_atlantis_soc_init(Object *obj)
 {
     TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
 
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
 
-    object_initialize_child(obj, "uart1", &s->uart1, TYPE_DW8250);
+    for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
+        object_initialize_child(obj, "uart[*]", &s->uart[i],
+                                TYPE_DW8250);
+    }
 
     object_initialize_child(obj, "prcm-rcpu",
                             &s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU],
@@ -682,13 +694,21 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]), 0));
 
     /* UART1, the soc console (UART0 is for the boot microcontroller) */
-    qdev_prop_set_chr(DEVICE(&s->uart1), "chardev", serial_hd(0));
-    sysbus_realize(SYS_BUS_DEVICE(&s->uart1), &error_fatal);
-    memory_region_add_subregion(s->memory,
-                                s->memmap[TT_ATL_UART1].base,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart1), 0));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart1), 0,
-                       qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ));
+    qdev_prop_set_chr(DEVICE(&s->uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
+                      "chardev", serial_hd(0));
+
+    for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->uart[i]);
+        if (!sysbus_realize(sbd, errp)) {
+            return;
+        }
+
+        memory_region_add_subregion(s->memory,
+                                    s->memmap[TT_ATL_UART0 + i].base,
+                                    sysbus_mmio_get_region(sbd, 0));
+        sysbus_connect_irq(sbd, 0,
+                           qdev_get_gpio_in(s->irqchip, TT_ATL_UART0_IRQ + i));
+    }
 
     /* I2C */
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
-- 
2.55.0


