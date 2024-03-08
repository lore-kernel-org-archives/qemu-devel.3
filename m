Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83690C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYA1-00070K-Hz; Fri, 08 Mar 2024 06:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9u-0006l9-Ch
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:03 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9s-0001eN-SN
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:02 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d944e8f367so16289435ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896379; x=1710501179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfK/Tg8g8bWnCRQD1V8j+GApjyIZdSkHfnDU96BAKhE=;
 b=CM0VO7TxKyFABUhVEedtzZ6otHFikFUvWRL4pPV3yi9K113C7qM7le4Z1/wG2Jibmx
 tqE46DeEGqhV08MujgMIJ+pPJRQRDJ35ogjr6y1T+Tr1FPXQKnrhEODiiIj5hipB135n
 tJSxxpkBFT6f5AVSXDXmt67J6nbTbcLiyBbssU5R+cXY65tP0yZlydmFchPRTJTZfAw0
 iithz/k8RPPSTSD5eodKHrTSi8LC9J1LkVZMyLzyDH+edZjwGMonbkcymhYAUWfjsc02
 uWjUDa/msDP0rNrFH4MYTxTBpwsnSUOleRu2oS19r/Lyezg1igfAIe3N2ahS0UQ/oE2B
 WwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896379; x=1710501179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfK/Tg8g8bWnCRQD1V8j+GApjyIZdSkHfnDU96BAKhE=;
 b=n4tc/jQbHG1b7m9yZIlRWjT/5ym/hCD0fDqRWIPgUVga7TNKbd0VwIhs++uuPRXGOV
 VXMptPbSHpXNQJpOQjrBqRwepkA8VBcxSHqOT5fsaTH0icjClowJLfYhnxRye20nMAkG
 dYWjPUi43k3CVc7Mn4h30tLZftqmGnRpUdyLd/CQlmHUDhOglukHKcufpjUKvQeDjAjU
 cfvvrdEr4+wb3T7MYKbdwzwWsH23AB9vYa9XPPjNoDG8Z1GhjdryTP1XgWQlOI4FdbOZ
 EsLT8m5DArYXFzxqHOvnSF6ZI56f6PTrdq3xvcHlnJjC1xY7lr/Wh/wkKIvPAkVOl4kA
 zKGw==
X-Gm-Message-State: AOJu0YyAx1qKH1GGqM2hxjwKLkEDb7lPGfsfdaeZFfP3RpN57L9KdfQV
 CNJlLX6dQVMUXtl4FjJe5sTkxUIf6LNKZB7vSGHjcLxoeWEWMJGSU8qzwBBnV04Ivw==
X-Google-Smtp-Source: AGHT+IH/1XSpCs50hwZ0OTvHP3MrKaQMFj2385rUnXc6I3Txl78OOWHvBU79dZFfVhDVFwPBHxLg1w==
X-Received: by 2002:a17:902:6f16:b0:1dd:651d:cc3d with SMTP id
 w22-20020a1709026f1600b001dd651dcc3dmr2202159plk.4.1709896379313; 
 Fri, 08 Mar 2024 03:12:59 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:58 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/34] hw/riscv/virt.c: create '/soc/pci@...' fdt node earlier
Date: Fri,  8 Mar 2024 21:11:35 +1000
Message-ID: <20240308111152.2856137-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

Hotplugged FDT nodes will attempt to write this node that, at this
moment, is being created only in create_fdt_pcie() during
finalize_fdt().

Create it earlier.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240217192607.32565-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.44.0


