Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA79C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XwZ-0004T2-Ld; Wed, 23 Apr 2025 07:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwW-0004R3-AP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:07:04 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwU-0000N3-FY
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:07:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227cf12df27so7963915ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745406420; x=1746011220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0P8ybX618Aj294TOjuqQa2ncsAqYRpABgmWLKho6DjQ=;
 b=Cqn5G49Cekv213eiRfan1DpthDc4at1fnR7mOxu8AQ8j1z5SOuFTtB31akmH68iH9d
 zYzQtgbgrKY/CP6oKjV7xWSoz4Od9OUi6gwtCQysYSjF+g+i9kU/EExMlQ6C4t4toQpq
 BIWfKonx70YKKubt7ACVD/XteQNfJ6/cqY2aSYl0PSdfbhWig+Wli97z9UKz3cqNpUw2
 VP8Dm36ZeofNjlt/2/8EDGbMlgJCiK0Thy7+pqFrP9CHWZsnULQ4XhBXIvVK2RR7aqKo
 AdCm4hX6WKTxdm95MLBxxAL+baVuHY5BBzKqQPMZNktUzQBGOW3N90r9luBBjnERoMjt
 UQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745406420; x=1746011220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0P8ybX618Aj294TOjuqQa2ncsAqYRpABgmWLKho6DjQ=;
 b=lB83x1xwsvxT2S50dPYK30gzz8tsGRf60EBn6Fb2mv/6EcC40xjBuuha65y1Zaxy9k
 IveU91gTkPclRQXplTfxSNDONisIXmz0frQfXjdUircjlnFMNRkKJG8Zh8+qOEpbieBz
 Sh1S4xYyTaDBptlSMD5VSnD/A+Q7jpR2LIyfsmhgR8s6jy3bfpXG0KV6cpmdltc6DOF6
 PEE07pUSmjddmN3yce23lGPiCjXpCJO/lxPgKuIuLLA62ZZ7xCIOMUxJ/+ZTkPoKiPpV
 xvXeul9W2xvqyh0UoaiD7t5aiMMs9rfqmkm+N92ABkATPekh0cJTbSRO/s8jJxmu+cxf
 BbfQ==
X-Gm-Message-State: AOJu0YwYWcdoapfIi1K82iLVrWzF4zehZVe+hb/SE1zSaplUM5cFXYgn
 4x0CNjpx1gYfIeLY5fpF9MuUKVZTakparycklEjIdJIadlGa+MD1YXEhROZGvyDVTGLRVnl+wLh
 l
X-Gm-Gg: ASbGncunERCNl9+ck/RDT2+UQXK9ZbP2B/CrQv1SFlgQiUwRCerCDQEZlCieVVNixuv
 03pdMy/rVB5/JS/hBzGppmBTBSQGbDa1b8gLc/nNQPVyEwK9f4idpetSgEikQpnNh/d7fn7rPXQ
 ZR+X0RoTymXpg+YLawOO5G3tKMRJY965H3D9n6V4GJpuH4kSTIQHW0lMs8PidVC+XYv+GC2eJJx
 m4gRnl9ZS00jY4hYDY25Gf5y+w1MPr2CEIGTOe78Fkc3ob9RdHVtfDZahXrR+ENJGVvK3OpPAyA
 4U3Ng2L21zfO0cqDOgLGuI/QqRDjqh2I3MFsi7WZJtekGmHsKQ24ddAuyhxWvcw=
X-Google-Smtp-Source: AGHT+IHt16bJywDUQ3OqWoWUohgNB3ccS8NxyHjbCbW7Iic13h+LgpyveCx5lGirX0qS+JfBKONaHQ==
X-Received: by 2002:a17:902:d585:b0:221:751f:cfbe with SMTP id
 d9443c01a7336-22da331ac37mr40139855ad.19.1745406420175; 
 Wed, 23 Apr 2025 04:07:00 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bcc0:89f4:3b90:a265:963d:8357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf3b1sm101509895ad.248.2025.04.23.04.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 04:06:59 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 7/9] hw/riscv/virt.c: use s->memmap in create_fdt_virtio()
Date: Wed, 23 Apr 2025 08:06:28 -0300
Message-ID: <20250423110630.2249904-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

create_fdt_virtio() can use s->memmap instead of having an extra
argument for it.

While we're at it rewrite it a little bit to avoid the clunky line in
'name' and code repetition:

- declare 'virtio_base' out of the loop since it never changes;
- declare a 'size' variable. Use it to calculate the address of the
  virtio device in an 'addr' variable;
- use 'addr' in the 'name' g_strdup_printf();
- use 'addr' and 'size' when creating the 'reg' property.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index dcaf28d1a4..07ee8e144f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -842,21 +842,24 @@ static void create_fdt_sockets(RISCVVirtState *s,
     riscv_socket_fdt_write_distance_matrix(ms);
 }
 
-static void create_fdt_virtio(RISCVVirtState *s, const MemMapEntry *memmap,
-                              uint32_t irq_virtio_phandle)
+static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
 {
     int i;
     MachineState *ms = MACHINE(s);
+    hwaddr virtio_base = s->memmap[VIRT_VIRTIO].base;
 
     for (i = 0; i < VIRTIO_COUNT; i++) {
-        g_autofree char *name =  g_strdup_printf("/soc/virtio_mmio@%lx",
-            (long)(memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size));
+        g_autofree char *name = NULL;
+        uint64_t size = s->memmap[VIRT_VIRTIO].size;
+        hwaddr addr = virtio_base + i * size;
+
+        name = g_strdup_printf("/soc/virtio_mmio@%"HWADDR_PRIx, addr);
 
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
         qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-            0x0, memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
-            0x0, memmap[VIRT_VIRTIO].size);
+                               0x0, addr,
+                               0x0, size);
         qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
             irq_virtio_phandle);
         if (s->aia_type == VIRT_AIA_TYPE_NONE) {
@@ -1135,7 +1138,7 @@ static void finalize_fdt(RISCVVirtState *s)
                        &irq_pcie_phandle, &irq_virtio_phandle,
                        &msi_pcie_phandle);
 
-    create_fdt_virtio(s, s->memmap, irq_virtio_phandle);
+    create_fdt_virtio(s, irq_virtio_phandle);
 
     if (virt_is_iommu_sys_enabled(s)) {
         create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
-- 
2.49.0


