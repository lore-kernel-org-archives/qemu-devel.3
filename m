Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78795C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwm-00053J-HQ; Thu, 27 Jun 2024 06:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwj-00052u-Vm
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:41 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwi-0001f9-Bh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:41 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-25c9786835eso3962064fac.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482498; x=1720087298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mwf6ZQFn6phEZgcwA7tImzDlpbG5FD6Mkg1OZw2C/gI=;
 b=mjpYXJQrOodd4UJ2nxyBpG7IBHHiCDmw32CYT6T9hG/A6DGINW4ghWp+P+L9UNOi/6
 VIk2vrILZWgwcgfoAR92QrTOt3FGlEekKKxFfaCqHe6BDFhDRi+GD+Q1AgQS7ndyB1Cj
 EwsapugBp6dV6YLVu7hmo6O35JPMxSXq3TLhZ/oSF7kMqBQpoPQ89Nqj9mnH6fm8UmHv
 X7AIg2IlZLI3k9CLl414X7oqYuT3LPYgEpwqtXkjXd5Ex0PChqycgl9bw6NAZONDKBMQ
 4Js5DtVaJ3KDSV9EUyF2AZruFXfGrQCWzolA8UApMTE4Z7HqDNQkkp+fKbNH76rtP5Pe
 UN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482498; x=1720087298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mwf6ZQFn6phEZgcwA7tImzDlpbG5FD6Mkg1OZw2C/gI=;
 b=JjYQbXju843hAmojxIDp36L7ExgPaoh5zqNw3p2NfjkqYsDJBOWVCtf0sxo7mdgcgz
 A1Yv1JKORcHCDySPoKNuFvoKxgeV4xeiDdxihSzk3oy3yoLS3dtkox9f27bLfz87OmG/
 eWTBbTIL7uwL0EcypWPH941exF2K09iKMvjpcy1DFoun1znMZNwlKwZhGecLi4VkZbJa
 rqzax8TqvPh+mMtJaWjBnDL33omuxsTlMa4OT655ZMYJ+vWEZkEV4lP4z1KNy2PpoFwy
 9wVQYY5spvgC17KSyRQFZO1V8mq4RoksWjfRVXHaBYx+XVikpli+Wgx/CXCOAkI005M5
 kNKw==
X-Gm-Message-State: AOJu0Yw7o7hSlePWsYW+1L5Xnd/psAOF0P3HYqcfRjA6G2VQwVwGaj97
 1sPiNFAxXqIw32e3f0PcO3VC3cJ+x8oeZeP8MxpoGWcdDAbN8r2wtX7CLiLv
X-Google-Smtp-Source: AGHT+IE0Hgjo3Hk5c21CeGSve8WUJ+SeQA364qxrTBKUhliq3RfleWPXm2KlkFfxeoz/oPUkIoFmFA==
X-Received: by 2002:a05:6870:4208:b0:25a:6d14:f84a with SMTP id
 586e51a60fabf-25d06e37917mr13307074fac.42.1719482498485; 
 Thu, 27 Jun 2024 03:01:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:38 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/32] hw/riscv/virt.c: imsics DT: add '#msi-cells'
Date: Thu, 27 Jun 2024 20:00:32 +1000
Message-ID: <20240627100053.150937-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x2b.google.com
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

The DT docs for riscv,imsics [1] requires a 'msi-cell' property. Add one
and set it zero.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: 28d8c281200f ("hw/riscv: virt: Add optional AIA IMSIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240531202759.911601-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e1ecf79551..9b648540e6 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -552,6 +552,7 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
                           FDT_IMSIC_INT_CELLS);
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#msi-cells", 0);
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
                      imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
     qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
-- 
2.45.2


