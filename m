Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30613C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmp2-0002HJ-3g; Mon, 27 May 2024 22:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmp0-0002AT-2x
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:18 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmoy-0003it-Gi
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:17 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f47f07aceaso3207125ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864255; x=1717469055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgusDoAaCqNHbDW44NpiNn7tTNG1jLHTtJSGtoAQOwc=;
 b=lXL2Q1iukQLE1ZECD9gEi7I2IJ1Aw1+VeT2YkFccdAvZj0EhpFAbvOnGWfMqYgbVQY
 ZBkRV8FcSz1KGBsZzp+lQXVseo0YQ9ZUXcSfNnil6MAKZGIm2INg7MufGudRG0oc/+pG
 k3XiLJw0qgEAUoGp4CH4d/FQsFBFxsMn0uu5QealvjsKNd3P9sGy0FaVChFjMW0L9Lm8
 1YVp8hHvUVJ9Mi55y/4zvmYQY976ELm5JpGlDpKdiMLXf0VKhm4vT071UT4UqlfLX9Uh
 +Y2LzIihq0inQICyBbmhUnADlNZYkKhk0x73KaQusGgykN1FxuYjYmRm7NJ0G2ZLmCMT
 gzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864255; x=1717469055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgusDoAaCqNHbDW44NpiNn7tTNG1jLHTtJSGtoAQOwc=;
 b=DH9Qmba+JiTQp40Q9iPptDXeGsp+r38FpF/Y0e+ig6tWeTnY8oQj7ucj4HxCJUNrxF
 6X9/df2c2UDsc5PBpKPsk3aaGuA8/4pOD1iQaZB+6hBy4lOizFmlqASpuX3NoUEvmEzc
 H8qtWS7e/XKowXllx7JzHjskcSzfYylzpxA/aJYvL0oCK3RrPtFIkpwtnk2qmFMe+Gu9
 tcydDpo5mMtia+jTC/BtDBTvjh2DaUNKoOKPXWJG0oBrAjlqf0rpPFx7spAnPbKt/FU2
 BBaRYpsv8MRQGmbiOvX2nU7WQ6uPopWc2xHffI0j1cSHakBq6AO8gaIJistNGkQ5XUt6
 BU+w==
X-Gm-Message-State: AOJu0YweJX2kItNZipkViMr4rZZGaEqLmFD8V/JOHEFmy8Z4NrUbtKxE
 1X6nAyL6iGYXWXPi4Yu9WdoaF+vuFIdE4QMZIRJfYhfVuHoIO+JqNSRMbQ==
X-Google-Smtp-Source: AGHT+IGbIm+Pge6JRsUkCa74zAvjBvMs2a2g38/hM0YBtvo35bJvU5yO0rCsZF87hyzc+HKP61aS5A==
X-Received: by 2002:a17:902:e852:b0:1f4:8b81:9889 with SMTP id
 d9443c01a7336-1f48b819b3amr54534875ad.7.1716864254782; 
 Mon, 27 May 2024 19:44:14 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Cheng Yang <yangcheng.work@foxmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/28] hw/riscv/boot.c: Support 64-bit address for initrd
Date: Tue, 28 May 2024 12:43:05 +1000
Message-ID: <20240528024328.246965-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: Cheng Yang <yangcheng.work@foxmail.com>

Use qemu_fdt_setprop_u64() instead of qemu_fdt_setprop_cell()
to set the address of initrd in FDT to support 64-bit address.

Signed-off-by: Cheng Yang <yangcheng.work@foxmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <tencent_A4482251DD0890F312758FA6B33F60815609@qq.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 09878e722c..47281ca853 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -209,8 +209,8 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
     /* Some RISC-V machines (e.g. opentitan) don't have a fdt. */
     if (fdt) {
         end = start + size;
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start", start);
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end", end);
+        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-start", start);
+        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-end", end);
     }
 }
 
-- 
2.45.1


