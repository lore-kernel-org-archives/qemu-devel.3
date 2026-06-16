Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7AFCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQk0-0000As-1x; Tue, 16 Jun 2026 06:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjs-0008CO-ER
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:48 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjq-000491-VT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:48 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36d8b644473so3795131a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604585; x=1782209385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6olje7UD96sdnIFEA78G6UfFtJlFCB5r0kXRgWZric=;
 b=XUqoBpxa9LqdFDaIWjEU0XSZbc21AeF+vM/9UoK6SAtDcjtOwSkmHq7r346oKe6fAN
 +O5IfHu78P223mfUH0TpGMYpw7Sbd/bG/TW5Qw51j1r+M+yQPGUhFJK4hHkWLXEBIUho
 ZMnigjoU7GPw62umk08fnf+6xnGUn5cf6g23GR8ZkFfGWQUrOQabj3WUwWjMY8FujDSm
 w+zIZohS+wdmbJxaJLb5noTKMCrz2DxwvMP22EBmCtAkW7G97/xLivnczD8hYkjamy3n
 5IezHtpD+oU79q1seQ4pwx7RZWKSdiqnUjztre6LY5crrLhOZty3qm33f9bQLShalP+C
 YuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604585; x=1782209385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s6olje7UD96sdnIFEA78G6UfFtJlFCB5r0kXRgWZric=;
 b=q5WRe2728HXMCrgleJSEHcRBbv7b4qyDGrvZ2mYqU4kGsMXuSPKhP0zgAJZz+m2puY
 2thKLX1ahXkNpj3I9su14KL8yHZxxpjYcFBeREgWp8d/gQwkco/wCZJ/Wuy0xl79Sejl
 9wpwtEt9pw3Lu+URUctxWoqIJ9H4xUkZwjeqdfSCUYOTcTA2iO5RwHvY+KiJ5IfM3AcV
 hQ6IIf5IR4ymeSj1lqsayjFaEMj+8OskN1uWCQLoLL78wC2MvHvQplCdsQYH9AobADMQ
 ACXPJ9SzxvPLbz3lkX5Pp0dzRNhV/2ErIJVUpZyH0zlG7i4fznsfNuIxfk7bHI9luBL/
 OfdA==
X-Gm-Message-State: AOJu0YycyjXawQc3/5ouB0bbCKtx8squxsa5jnihfR6DzUr7BOpEJ9Es
 F7i9fVyzdqyRcw2Uc7nKEmctLdHSbPB80EUCpoQHpXmz05SL7slbOLJUqqFfl4Gp
X-Gm-Gg: Acq92OH0gs+XmX03RhLawCGfmB+MK5c48+ZAhfuMgAeIrZO2lw4DXnOhoPa2FJk6sit
 hNXfDSsTTmhkA3R0DXT81duVNFiECDZ4OAZZ1yKVJEwl/I/eXMYMOJRbGU3Ne3kLwsh4dyinYHI
 cWBGjhhudXhB3dufaWVL/M8ieSeoSk49eKTDbZw/Zf8fUgJl0DnwQhYhfumaOxzQeHS/JvvY16Y
 pFGv9m7/Eppg0gVA+5WrCYQf8nE6XuOoUhuE9MX6/qONndsXPGMiIX1SKfF4q2iR5ZeHQn9RFTn
 uSyHGCSZy8fTFU1d0qcW+DdoO9HiCzF0hylkbYA2lEuq5o/xnR64utznqrEBRsHYMngqr3MWZST
 VXmveRUpWdU3C1sFM6fHHYPjqok8EC84xroCPyzfTBMrnjpqCalse/hiyhKjXJcN3Qx+wxNZX8o
 sGLsnTqMdeQvdY7R5wAWRsxoVyK3LHUqRF2EGBCU8X
X-Received: by 2002:a17:90b:4d0b:b0:36d:8e6f:8d9e with SMTP id
 98e67ed59e1d1-37c52916f59mr3016887a91.20.1781604585465; 
 Tue, 16 Jun 2026 03:09:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 71/83] hw/riscv/sifive_u.c: add a FDT phandle to cpu-intc
Date: Tue, 16 Jun 2026 20:05:14 +1000
Message-ID: <20260616100527.1939565-72-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We're assigning a 'cpu_phandle' phandle to the cpu-intc phandle field.
Make it more in line with the other boards by assigning both a
cpu_phandle and a intc phandle.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6a637e3b86..3abbd6c823 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -187,8 +187,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
         qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
+        qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
+
         qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", cpu_phandle);
+        qemu_fdt_setprop_cell(fdt, intc, "phandle", phandle++);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
-- 
2.54.0


