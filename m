Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59009C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOf1-0008PH-E6; Fri, 09 Feb 2024 06:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOd7-0006uq-Bx
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:14 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcu-0000qG-8e
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:11 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5dc13cbce45so601990a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476458; x=1708081258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFMNQVYSj3JmsAY5zowmVJht6YkGb2y2yywXB+6zt8g=;
 b=T3ETrBhuoPSrJmfLKxqLm+XvFPy5eXBw6FFeBTbK65IsXKJDcty6Se1v9Gnx4c6ViP
 BFK6LGkl3sqUfvItu96h6M7xVJkfwbSSn/K0z7Nyh+nPkK94Mkie8+gLLF8MkNZG/FRc
 qCISUifNgE0aw65DTNmSEwA0iroAb0AK5i3kxysWThDprfUai6xFxl89I7LL7JBAP1LQ
 ZQeCB5QQqDSXf6SxGdw1Gu4Vrq8MorX5QSQBA3v7LaVtiTejID8DW+FD8FjSvt8i6SOn
 4KLB7tovcNZtTJMvj3iBoDuz3AQJUblD61kzkzjxxkBzKciH/oOeON64YO5+n4rieojR
 OfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476458; x=1708081258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFMNQVYSj3JmsAY5zowmVJht6YkGb2y2yywXB+6zt8g=;
 b=vSkbAIVeYEpLDdjJv7JsKd/+rPy2VHui888/songYzFAkkVLG8BQIfJ6s1wBF3b0L0
 M5TD6FX6Yz4qo7m88+vXMf3PxNhYz1GpAaRuOpDlipQ1IbSLgzU+WPC7ChkF4uPEAdMB
 hVUcxUPyLwmFR4nPtVBUiWoFWLHnmTlGwCqoqhZmBOo+bd4G0KhgU+btxVd/+s3fEwFT
 gMn5FirdpeskemtYZvfyBzIXeEAnh2TuBiY8PTFGKhyR+4UDvVfF6NfKloDXH8ST7Ent
 +n6wnBFivR2P7tiOE6pBa3nKmWFtmDCqY+IfQo8UKt7IFF1FP2ZFTOW17hIW/C2anGLN
 wC5A==
X-Gm-Message-State: AOJu0YylS6xN0phQBZPpiYb5qoG+Per9QRnvzgeLJ6FaJKor69CCVa7W
 ZSyeoTB58EBeVwP1k1McJ8M5008/rOq9sB5saFaTKDNk4X5lCjDQAJWZgZo9h5r60w==
X-Google-Smtp-Source: AGHT+IHTEeS51xXF9TvWpvDnmwYGl1cbjQhHzEBUKkaaM3z1Sms5Y1p9absLzutbMwV9WETR3DHJMg==
X-Received: by 2002:a17:90a:ce14:b0:296:2d01:ed47 with SMTP id
 f20-20020a17090ace1400b002962d01ed47mr995013pju.35.1707476458637; 
 Fri, 09 Feb 2024 03:00:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUCsZ6KqkGNPqBTRtQl6x+jG9P80EXla5H4DWs5pYpQ7LNZWvIkJpYh9Msd1EjqvHoKVBEpYmS1TFOHxfoIJUHVKvgp8avGG57Lw/M5W5RwXMNI50FdxOWUBJ2HNeUBjMCw9QztLItEq/NkoHyUaTwqZUhRujZZ
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:58 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 47/61] hw/riscv/virt.c: use g_autofree in create_fdt_virtio()
Date: Fri,  9 Feb 2024 20:57:59 +1000
Message-ID: <20240209105813.3590056-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Put 'name' declaration inside the loop, with g_autofree, to avoid
manually doing g_free() in each iteration.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240122221529.86562-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d0f402e0d5..f8278df83f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -820,12 +820,12 @@ static void create_fdt_virtio(RISCVVirtState *s, const MemMapEntry *memmap,
                               uint32_t irq_virtio_phandle)
 {
     int i;
-    char *name;
     MachineState *ms = MACHINE(s);
 
     for (i = 0; i < VIRTIO_COUNT; i++) {
-        name = g_strdup_printf("/soc/virtio_mmio@%lx",
+        g_autofree char *name =  g_strdup_printf("/soc/virtio_mmio@%lx",
             (long)(memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size));
+
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
         qemu_fdt_setprop_cells(ms->fdt, name, "reg",
@@ -840,7 +840,6 @@ static void create_fdt_virtio(RISCVVirtState *s, const MemMapEntry *memmap,
             qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
                                    VIRTIO_IRQ + i, 0x4);
         }
-        g_free(name);
     }
 }
 
-- 
2.43.0


