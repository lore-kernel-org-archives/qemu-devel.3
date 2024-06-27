Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF563C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwc-0004zo-VN; Thu, 27 Jun 2024 06:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwU-0004xw-Hv
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:29 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwQ-0001aV-30
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:26 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-706683e5249so4122001b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482480; x=1720087280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5ID2rbibjMInT22rN33D3iPwNHGXHXZ0Ds9aS1mUWE=;
 b=IIwW7J0oFO2Ypk2fokrX5msUC+4J1nG2T+XyDpAKKFNCFu0cHIzZnCKh7kD5vFiaE/
 AhTGGpLiQofXyb7IKp8cAYY/TmJD+7GqQDvSzRHoxN3wKEHoGKYMfHJbFfLTx+3EdM7u
 UzDarUBnnw9FO346qoBlHLg4k50AO9wNXLRoguh34dyyo5L2kyCrRqTgg4z76q3hVNlQ
 /CBoSujkwcDL7+vUXI1LFf4NFyN7UsKAaZGR/mYDIOrQutbIP/bkalze16sxkO+6TFu2
 5C72eWKpHSanhoZ2yBWJbDuLtFehD1/AkM1U218m6iUnJCoVkTmhGSS58Iq5+56fc9w6
 b1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482480; x=1720087280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5ID2rbibjMInT22rN33D3iPwNHGXHXZ0Ds9aS1mUWE=;
 b=cqHH8IURnmsLsha2BUcV2LR0wL2QvzJN9r6sUPxzRqs5n9tOOBgCnQVUz4iX0kozwI
 fFTVdwHdeGbsv6YVTgww1PsPZM4nNlFBPpFOxxmGUFqm9Dn0guAcEZFzxLNMF+s60jc2
 p9c1bjAhpoixalgAJ7G2TFCuPeQJYvCq4yvHTUfk1dYYNLgycyrTPgTOTV5cZQcEEVYB
 7fipK+67jGFaR/haQmJl0UNxiiiQASnduo8ZtfoUS0sp90fON0inUj2KeTBjcY+WFnf4
 sloKET1zBJHvep2ZjFQAqgHkSPnbJ1TkFqcfipvxLkuki8B8v9CAsUDVE+kZ9qBATfl6
 FTVA==
X-Gm-Message-State: AOJu0YyKZXmTMaCdYvQd0dre8vJ3Tthpa5brN5AAu324brM0rsVCLPVH
 gGosdk7N/lIpbY+tdc4sknk4oylixjQ8RYN+YbwGNRw3UT43zJxEJUw/W59Q
X-Google-Smtp-Source: AGHT+IHs3VdUTvBR9DQAZMIQqQEGAS9aoS06IajRAyP+mTZpC2UoJNSAG68Kw5vlbqQRL/4d1CCzgQ==
X-Received: by 2002:a05:6a00:2289:b0:706:b179:dc5d with SMTP id
 d2e1a72fcca58-706b179de78mr2408270b3a.25.1719482480283; 
 Thu, 27 Jun 2024 03:01:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/32] hw/riscv/virt.c: add aplic nodename helper
Date: Thu, 27 Jun 2024 20:00:26 +1000
Message-ID: <20240627100053.150937-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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

We'll change the aplic DT nodename in the next patch and the name is
hardcoded in 2 different functions. Create a helper to change a single
place later.

While we're at it, in create_fdt_socket_aplic(), move 'aplic_name'
inside the conditional to avoid allocating a string that won't be used
when socket == NULL.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240531202759.911601-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e903f05851..569d9def24 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -588,6 +588,12 @@ static void create_fdt_imsic(RISCVVirtState *s, const MemMapEntry *memmap,
 
 }
 
+/* Caller must free string after use */
+static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
+{
+    return g_strdup_printf("/soc/aplic@%lx", aplic_addr);
+}
+
 static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
                                  unsigned long aplic_addr, uint32_t aplic_size,
                                  uint32_t msi_phandle,
@@ -597,7 +603,7 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
                                  bool m_mode, int num_harts)
 {
     int cpu;
-    g_autofree char *aplic_name = NULL;
+    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
     g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
     MachineState *ms = MACHINE(s);
 
@@ -606,7 +612,6 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
         aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
     }
 
-    aplic_name = g_strdup_printf("/soc/aplic@%lx", aplic_addr);
     qemu_fdt_add_subnode(ms->fdt, aplic_name);
     qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,aplic");
     qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
@@ -648,7 +653,6 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
                                     uint32_t *aplic_phandles,
                                     int num_harts)
 {
-    g_autofree char *aplic_name = NULL;
     unsigned long aplic_addr;
     MachineState *ms = MACHINE(s);
     uint32_t aplic_m_phandle, aplic_s_phandle;
@@ -674,9 +678,8 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
                          aplic_s_phandle, 0,
                          false, num_harts);
 
-    aplic_name = g_strdup_printf("/soc/aplic@%lx", aplic_addr);
-
     if (!socket) {
+        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
         platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
                                        memmap[VIRT_PLATFORM_BUS].base,
                                        memmap[VIRT_PLATFORM_BUS].size,
-- 
2.45.2


