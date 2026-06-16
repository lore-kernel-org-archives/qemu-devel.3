Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569C3CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQk7-0001M7-5z; Tue, 16 Jun 2026 06:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQk5-00016J-7H
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:01 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQk3-0004Bt-HO
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:00 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36da8439078so3693460a91.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604598; x=1782209398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgVeXNJdbBixXrfneznZx6ETuUsk7Hx2xz1yrOHPSrA=;
 b=j/SWzlGbb7go4iG+C88TOhChNdtjmOigx/KOCRLLd2/f6iCrKZneSZbczgTGgAlMno
 KsEleGOMoPw/GxG/eZl/kmpBlM3lDDw4tWV2mOrk7CXgPqkvk8nCFXIyNqYPytcXDVoq
 jDi2P9lX01ar17k8j2akSYbUr9NcIoDPOlHlj1chpUIkE/o/NdCubTulcJmEn9kdS27i
 pI4nG0sXKbmKQit0Rcamn9cDot6IFhK2XHZIQn0JzkyWZGUT1XpX1PqUDiCrV1MBIItz
 ALNan03vjWlIRMltCk3kIJ0h2Bxnt/A4+zv25wsOuicI25Ox2JYph46LKqASst7Iq6Fz
 IBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604598; x=1782209398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hgVeXNJdbBixXrfneznZx6ETuUsk7Hx2xz1yrOHPSrA=;
 b=YUtwcT7QEannY6UswY7tT+OZDPmuJPiiTDsK/eE7rkYrc/VaILDyUKg0RdKhK2cRZ3
 UsjaSrcuh6GleaUkUlLSnZ8NQWxk3kNuCyU3wgg9nr9ZsyH63IOC9rAyQOp/q7hTJGOC
 P+Cg65ZkRq8B/6llqtURrms+SFUCKE2uOx0W+SN7+ycmfAGRm8HtK4PHb/pV346kc0o3
 1ADZXLpL7f3f1Bi7b6zsAxL4d/BT9VzHIPd5ZP8zlNeeKyipbmxaIzeN/9n2Bd+5hHwN
 umWt2GAvrlCQHut1vgbrEzxSa5fWNevNWxgbMEOnwhQygIOU7StPeAdUTDbIKEpuc+6a
 //vg==
X-Gm-Message-State: AOJu0YyBDTWCb5A/wjQ7QUrzfgQtxeFpw0/YTUqaN+1VggXw7qZA+qKJ
 aX7InQYI2VHlN5LR2r3v7RZ0SAQlSKPn8tzo3nRLiJweMsJmlzzo2/uumVrKSfO2
X-Gm-Gg: Acq92OErJfSF0mNPaJHLEYhHv4170uK8KWGk04ki7eRXfUxIxyvWc3tdoQ7x6whfvpH
 RqIyPhrqncE46eFS2LqacKenlSrFxc4JjMfRXGQlpekkkZm6WLsR5LkWQWout4CRn0XThd32KkY
 gPiNWmmNy7Xdkwe+tsnZjX1bxafEwrBP/WHtdoS09cBWDECaQUrGnje1k1m+MVQwMFgnvqsnCD4
 R7KfqVX8qL8B0vHNXFdcZfRiaUGjl/h2iOOgNUXxP6RfappkpSZgNVIkdx4IfS5czkVYr3nRWFU
 03Ro/ES5cla1XCSkrOY1MtYhDiAQsaTOvPvEsOkgf2qUkQAo4EB3+6G3p0LSVVEKnWrhx9V1x0V
 Ctgg5uZpdDazUhBxqTRTAnIN625U9ofjPkadGvjaFWBQTMfh+6mlSt4NeuY1gBr6r4QBJRcE74b
 wGqlY9Q6JY7Lv+Fp1HL5wkMz20dFoi6QMNhR8X4cwj
X-Received: by 2002:a17:90b:538d:b0:36b:a0fa:ff96 with SMTP id
 98e67ed59e1d1-37c528e0a69mr3013973a91.12.1781604597748; 
 Tue, 16 Jun 2026 03:09:57 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 75/83] hw/riscv/sifive_u.c: add intc_phandles array
Date: Tue, 16 Jun 2026 20:05:18 +1000
Message-ID: <20260616100527.1939565-76-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

Store the intc phandles in an 'intc_phandles' array, like the 'virt'
board does, instead of re-creating the interrupt-controller FDT string
and using qemu_fdt_get_phandle() to fetch it.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-6-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a00cfd08a7..ce86989bc8 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -111,6 +111,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     static const char * const plic_compat[2] = {
         "sifive,plic-1.0.0", "riscv,plic0"
     };
+    g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
 
     fdt = ms->fdt = create_board_device_tree("SiFive HiFive Unleashed A00",
         "sifive,hifive-unleashed-a00", &s->fdt_size);
@@ -168,8 +169,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
         qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
 
+        intc_phandles[cpu] = phandle++;
+
         qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", phandle++);
+        qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandles[cpu]);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
@@ -179,14 +182,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
 
     cells =  g_new0(uint32_t, ms->smp.cpus * 4);
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        nodename =
-            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
-        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
         cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
+        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
         cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-        g_free(nodename);
     }
     nodename = g_strdup_printf("/soc/clint@%lx",
         (long)memmap[SIFIVE_U_DEV_CLINT].base);
-- 
2.54.0


