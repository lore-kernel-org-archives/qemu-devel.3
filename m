Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D32CC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyI5-0000vc-2i; Tue, 13 Feb 2024 14:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyI2-0000v6-5M
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:17:58 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyI0-0001rO-I8
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:17:57 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d72f71f222so37221915ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 11:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707851875; x=1708456675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpHMplEVi3XeQv4jaff9gVGYse9F3EmQGoAF7pGdYRM=;
 b=RD9JYQFiNtpO0qrWmXv0K4bAsNg9bJxGJcHry502FwdVYiJBTA9gzibdQnpdIbAj+r
 ntRHJTWznxTJBr3fD57ihUJTmp9jpmwfWqAj1vI7E/AtyaxofemOk8Zz8HS0+8ZSZf3+
 yZUzum4PkTG0gD6XpWaS7hj0u9lpE+kkge8ha1Eqx1lb/SyLebvfzBLU4yYMZ99MQd8R
 IYOHub/EIAziEZf5iASIwOMVmUTguFPo7bqTF2CC9OHvabDEhGyGX4J60wa65Mfrctek
 ren/WtOqmyUqxwkB/a4poMg4yq5KHDJGDO+TQl8aQ7oDPUk2yvdlNr/WXT+D8XNT7qDv
 yqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707851875; x=1708456675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpHMplEVi3XeQv4jaff9gVGYse9F3EmQGoAF7pGdYRM=;
 b=YrClkqnAOuWwkF+fLwKg7vhNX2suL7b/xmMc/0aofmjrSLyblgcUcUoDwQtU5gqVO9
 QFJBaH5g2L82q9PpCavO++sR7msGtdENgfMfcPFr481OOp/241zhCE4dqT46+UI7pxqt
 B19iX/H2z91m00bADqfOykhlvKBOcZSW4yOHitw+P/13KpePY53YiFQ5wAryca6TAOOc
 XZLbIdgcAg6+awko6mV4Bp4Zo4D4X9N/zrMGr/IGJ1/zoLDZ0clFBADlLxuYSD9G3hMH
 HIrNhIAwISG8yOx9jyHbiwJx5DRAysukxK2+lkzVLE1pgAIE+iDbTOb/umXEiDh4bz5k
 LnvQ==
X-Gm-Message-State: AOJu0Yw1Vmey7N7vL9al2So9MDPXeuPkHpCoQT6tF+jcpyb/2hqrcuyA
 cfonJTBieSjTEElxQcTnCbmWJ6C49n8wdHkjLy1RyntR07ZI1eodael0/z7rANofWLFb88IHiGM
 i
X-Google-Smtp-Source: AGHT+IHtAM/5hs9UnoSNyxHIPAwBRZ/cHvzNBxCmjypF1Ll8ROT+nZzACAFJvRasRfQt4U/fenxBwQ==
X-Received: by 2002:a17:902:ecc5:b0:1d9:2cda:afe5 with SMTP id
 a5-20020a170902ecc500b001d92cdaafe5mr603825plh.31.1707851874989; 
 Tue, 13 Feb 2024 11:17:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVGJPD9Ccz9XmA/btMroaSlIcpHpRwx53YpW6ZUN8tGRV6m5u0IATq3cbSqbt/5Zo0Cl+82EQjKk3FHGVTDSHi91U0vbFY52W5cReQCNWVscCHM9w6iK5TuO7S1mLFmdhNgCH8cp/tfzMLLgyR6m3h1McrNbYenLcklEGT2qsW6OOnKfKHVTF7OnmMpbh1seCzkzW5YseaZ+esEN7JDhZWQtt8bj5cBMzJ36gBtSgi3PCV6SIAMfwTNgEF9J7elRx6eQ5eR2I6Hxb2IRAIxaGTYsyaVmo5BoOWX5su5YdOCrhlLivfLKLUMkoc8ialm1ZdOV1H+gUWFSQ3tMfxaKKssINuYFfFazTN+aetcsC1XjoUj38oaJsokyk5pJ2eDM8UoiAVdEUooJSP3
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d60500b001d8f81ecea1sm2416335plp.172.2024.02.13.11.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 11:17:54 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 ajones@ventanamicro.com, alex.bennee@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/6] hw/riscv/virt.c: create '/soc/pci@...' fdt node earlier
Date: Tue, 13 Feb 2024 16:17:33 -0300
Message-ID: <20240213191736.733334-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213191736.733334-1-dbarboza@ventanamicro.com>
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hotplugged FDT nodes will attempt to write this node that, at this
moment, is being created only in create_fdt_pcie() during
finalize_fdt().

Create it earlier.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index fd35c74781..b540f4d3da 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -826,7 +826,6 @@ static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
 
     name = g_strdup_printf("/soc/pci@%lx",
         (long) memmap[VIRT_PCIE_ECAM].base);
-    qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
         FDT_PCI_ADDR_CELLS);
     qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
@@ -996,6 +995,7 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
 {
     MachineState *ms = MACHINE(s);
     uint8_t rng_seed[32];
+    g_autofree char *name = NULL;
 
     ms->fdt = create_device_tree(&s->fdt_size);
     if (!ms->fdt) {
@@ -1014,6 +1014,13 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
     qemu_fdt_setprop_cell(ms->fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(ms->fdt, "/soc", "#address-cells", 0x2);
 
+    /*
+     * The "/soc/pci@..." node is needed for PCIE hotplugs
+     * that might happen before finalize_fdt().
+     */
+    name = g_strdup_printf("/soc/pci@%lx", (long) memmap[VIRT_PCIE_ECAM].base);
+    qemu_fdt_add_subnode(ms->fdt, name);
+
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
 
     /* Pass seed to RNG */
-- 
2.43.0


