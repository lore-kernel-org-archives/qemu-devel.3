Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180F8C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmor-0001s3-Ud; Mon, 27 May 2024 22:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmoq-0001ro-1i; Mon, 27 May 2024 22:44:08 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmom-0003hC-EJ; Mon, 27 May 2024 22:44:06 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70109d34a16so242220b3a.2; 
 Mon, 27 May 2024 19:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864242; x=1717469042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2fI6nwAJXeFe1hxyMYDF/QLET3EtTO13tMnuGkb/Vs=;
 b=Rd1c3Qmgh+TuIXaz1JkQZNmIwRD27g4Z9HamwBnzl8+9154jne47jzoXRb/VJtdL1C
 W1Zwa9NKef8jOGGdhrTs/qDpLSyx7wuaVdJj6h2Ew99xH5H1GjiY7TMkokNFPrkPOnWw
 J+ILOZHucpCU+3FknNjK9b5lFeNSyGpDngWzUbxkySxKO1V+9H4BzSM6pFyVS17TIfzz
 dt0FZl9IdFVW4wg1OV2ZCUr12DJd5jURTyty+t4xeKXavmldhhPcRk0uR+iHllRsHqMl
 p3uoUSgX7Xo2CnYMxJD1FgdkKCVit4WsB3EARkWjNIBVj0xZ2i38yev8eHs2c5+8bUfV
 ZD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864242; x=1717469042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2fI6nwAJXeFe1hxyMYDF/QLET3EtTO13tMnuGkb/Vs=;
 b=lQ1b5STv26tDTf78m3ZM52fF/Rnklh+k+mCTNuSP0rRvSy1RHkSpgRr782hD0OSETM
 e5oYLRL1ALjBKWWv5fXzPjptK47jMxol6eT3h+KNzz3d7ppoJXccJWAxFxgIzzYrPZHB
 FTAeJ3MmXBQoApOYif7EP5rXudKYokudk6LL8aDjnGMbnDFKPEU1MSln8GoQWNzQUPCY
 xBko/GYQDHRxFLhPDwX+kp5gpiqpaYXu4xi4PGkievMkpKpZW+FBp6JA0R0v+tNf/Ep+
 6GkrCKYHUU6r1+DB+K3MEkulAhbIUELRSQxf+sITV7CgteXNPHEfYrHEafzpHMkQd4f5
 Nslg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6ki0tqpb45TFssZNLG9+3rGO/vvM8kjd8KQYGty34VZv0xLqPkgln2K0u6AnmSe8dpYs05Ve+PaHGlXJv/uOLUnjV8gRQ
X-Gm-Message-State: AOJu0Yx/idQTmIdTdY6js1VdTHbAA/weAtbz24l9trKj9+c9+VGxbWNk
 7Bp65CPQJcA79JlxXVrSghNbSxKA56/Ap1+I2pIx4yl+OyWxyCoioSkHWg==
X-Google-Smtp-Source: AGHT+IEURWKJSnllvdHQtp1ADQBWCW53PlI5ryhsHlqVZgo2m3Z7/WUmlIy+cmLE5iTWf8KYXUMzhw==
X-Received: by 2002:a05:6a21:27a9:b0:1b1:f7a1:df97 with SMTP id
 adf61e73a8af0-1b212e3aa39mr10696527637.54.1716864241914; 
 Mon, 27 May 2024 19:44:01 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:01 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "yang.zhang" <yang.zhang@hexintek.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/28] hw/intc/riscv_aplic: APLICs should add child earlier
 than realize
Date: Tue, 28 May 2024 12:43:01 +1000
Message-ID: <20240528024328.246965-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
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

From: "yang.zhang" <yang.zhang@hexintek.com>

Since only root APLICs can have hw IRQ lines, aplic->parent should
be initialized first.

Fixes: e8f79343cf ("hw/intc: Add RISC-V AIA APLIC device emulation")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240409014445.278-1-gaoshanliukou@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index fc5df0d598..32edd6d07b 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -1000,16 +1000,16 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     qdev_prop_set_bit(dev, "msimode", msimode);
     qdev_prop_set_bit(dev, "mmode", mmode);
 
+    if (parent) {
+        riscv_aplic_add_child(parent, dev);
+    }
+
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     if (!is_kvm_aia(msimode)) {
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     }
 
-    if (parent) {
-        riscv_aplic_add_child(parent, dev);
-    }
-
     if (!msimode) {
         for (i = 0; i < num_harts; i++) {
             CPUState *cpu = cpu_by_arch_id(hartid_base + i);
-- 
2.45.1


