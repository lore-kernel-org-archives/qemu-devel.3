Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF9EC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5gi-0003MC-II; Mon, 03 Jun 2024 07:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gW-0003E1-LW; Mon, 03 Jun 2024 07:17:04 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gR-00069c-0o; Mon, 03 Jun 2024 07:17:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7026ad046a2so622274b3a.2; 
 Mon, 03 Jun 2024 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413417; x=1718018217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2fI6nwAJXeFe1hxyMYDF/QLET3EtTO13tMnuGkb/Vs=;
 b=cSza6VZdQ+EaOp1JNPegF+7yiEy5JImzjs7Nf903l/4G5Awpvc31NHIB8Hft2oxf7h
 Dzh/Ex7boiBYSgbhsB/YfY3eyPbhDJZP0M/H8Fcqx2bvq3EXMxaYlnGpuu2fnSmntrfR
 2LDcfqmmVezZVQLjG35qq0OKZrlUhBCLK9NVS+6kyGLd5+pV+fEL+b4RiCJytzjza6ho
 SU7Xjbg5R9sJg7OxAa7fQyNYVgOsrgdRb3zXJ55KmJsk6isE6bIFxWfOUn+gILG7q/3x
 +yM5C1rWaVyxm8q/4OtNME2r+4u0dAsKlMRzgtvPYxo/eYdEakeCIZPC9H3iHgREo295
 qYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413417; x=1718018217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2fI6nwAJXeFe1hxyMYDF/QLET3EtTO13tMnuGkb/Vs=;
 b=CiOIzQRg8tkM0nNg5mTRHfJQ1rYoM+DAAQ8hUzok23CtcN54zRKh5w9yfSP4LJOYlB
 aHeN+8aBV7RUW1bW5krYxWIfzvR19JoSy5LnWU8Kow3BwybZBN+2X3qJFjGCP+HxORfr
 HoJqtapEedu8/CZ+eFXcMlYaJYEFMV6ByYkl+1QC8JRUrT5x9hciJbLJM7iqOfQNrlVx
 JckZJ7d2iaDdExD1NaqO0KunCaB7ehvKfRKW4mSX09IHWHN7794viU0rrpL29ymN2UIz
 Rdrfv7iUFDooRQy738GxkEwV3JJQxcmwLJWkbAPFdH/mL2eQ/+e7fUYwD9tE96upwIxr
 o2mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR6wBWzxKjIJxsksUZoWXkINtmcRJzNhVGyoKpZuIku6NhhOThPubcMM5SpXkjVn22ihge3V5coC1+NjaHzCVwbtZ7vgSk
X-Gm-Message-State: AOJu0YxtQeOv8+WCYKxaNkcev8ruxQV3Otdg/n0Tk99SFqa+A4g8sd7h
 pVc2N36XNcXMYYu2dCDQh5WslrjJboF0zrqzQCsFJKffJerja/oeZXByWg==
X-Google-Smtp-Source: AGHT+IFtlEScgxX0IALRTDBUEWCwikW6IgOTZQvS5/qI9OZXkvAJeqljLyUTVKu6WP3RJnjXn5H/LQ==
X-Received: by 2002:a05:6a20:158a:b0:1af:cc75:3f79 with SMTP id
 adf61e73a8af0-1b26f30e460mr9127997637.55.1717413416774; 
 Mon, 03 Jun 2024 04:16:56 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:16:56 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "yang.zhang" <yang.zhang@hexintek.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 01/27] hw/intc/riscv_aplic: APLICs should add child earlier
 than realize
Date: Mon,  3 Jun 2024 21:16:17 +1000
Message-ID: <20240603111643.258712-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


