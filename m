Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E4606A329
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mjcLJPUw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSOQE-0008KC-U3; Sat, 14 Nov 2026 19:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQC-0008JA-Dl
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:40 -0500
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQA-00016t-Gj
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:40 -0500
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-36e795af1d4so1655674eec.1
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 16:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794703717; x=1795308517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oo2Dv8f31XI0b7mmm/DDkDg0DE0c4E8icbaWAEEMlO8=;
 b=mjcLJPUwQjH6GH/wg52Ps+RtxqVBmo7OZvSBY3+s0EKbNkYxawNWKy3p7KHEuIrKfR
 xOeqWMca/VwajR6E/jmu1CXSl1He/D8ocnnBFpdSACXtZXjD+qknHEJ0GXO/yWUVDatU
 qWbxWEjIQ3VH+Auw6iEW80uDmLTou+w6rYFGZqbP5qNPkYWGK/8LEeafKlvadK3uoHLN
 oZEpwbWMpOgBSTaY35JjIuvyyxAKyRgFvUFu/HVv9QInYO55mG22xDFJffEvs//JfCEv
 f6j9sJ7kwWsvdQbvDCfA8tuE+g0rnfSHWyfkT79HFVzL9rt85pvBOuAV+ouoIDUN9Sw3
 HhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794703717; x=1795308517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oo2Dv8f31XI0b7mmm/DDkDg0DE0c4E8icbaWAEEMlO8=;
 b=mKBZQUoMgrd3eZoxyts3WU5RC62tOUtNgV7o8CxPKYI/4TJWejmdLhba55//OIOj7v
 2hjmyU9nyuXIcIfEn1McPys8STKrXaTw3fpQ/Chp/7NNQ7LHBVNJ3uGxLLwzV7VCO3wL
 ey8qe0ukmFF2ATZRffioxhgDDus0H6eqPKj1I4O5GMyxk+3KvquHPx3to4stBBxj7xTA
 FaXs4wI9aTbg54fQdFmt0o7PLpgkknmFJbmofqpoJM11IhDwR+GaRke0nhr7K3zXkn9+
 Zyn2qbmy5fCD2aZ9ljSwKJWWhJbqPhzjAWO5/VBMhMKuQsxITSyl/wizV7oSOc14bvSV
 Am3w==
X-Gm-Message-State: APuU4Z9xjR2P6OOVSdchkIjNheH1sHPdtHx0xDBB3UFh+ubvQeh58XR4
 4AIP7CL4sc2X76OKWJjFrCWtvIXWAAOTOrcURcEksuX8yIyXLsPdCH7O0vaIAQ==
X-Gm-Gg: AYBFou1ZqfN3PGqpwfLZjmgORjUpxkpqoR4n1SIpZSThxSX+S0W1yQ2vhh7HYGTbixQ
 utNGuCoRgMfdYfd82RclcFR0qpnhBScblSgEmSnprvGa+i01Gt89wVha+lYaMgDaKxCk09haLXx
 MgY6suNEx7bZZKwJigJuWXAckcv1/cj2V811u25+ivuSmgMPpgoSHK8ZV6zThr8S+Z7SOj+Y/9H
 p9ewPGBqj9IuAzLF572iIoXfvgkQUf1jx9FK4VpdFsxRpTBeOBBvFM91etX89MfzuwBy/TRMHG/
 IxiQtpCLSmNtwMYUdMxqhC1QsBaUMhlD0I36jQhrfbVELGGEyL+sFi4rayX+SkNw1kvflprE1Tj
 Hf2DsTerVRofWk5jHlS/pz2LetVJlf2u6as8NB0JSL2E+1DVdl25XbJGHTVaQpZ7HPK93bF09WS
 AnLeLm6KFVqhnkyv7qMhxlHxyKUIQiusAmdc5Vbyd84gDGQA+FAlpeA7FhInp271vQ56kwnEH2A
 NjndH4gTDI8glA+yedwCUpWvsfbLsK8+mFCvv9DX3aQecOqK9Wdf3a9q2w4giog54+Ch8mrqCcu
 C4hkYamaGYN7b/HXzFc6FqiOY4MqBJVV3CeOI9VLwCK6qguHcE0HJ95OprRf49K4nhPR
X-Received: by 2002:a05:693c:60c1:b0:36a:2473:9b2f with SMTP id
 5a478bee46e88-377e1af6414mr9654312eec.23.1794703716492; 
 Sat, 14 Nov 2026 16:48:36 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316f2sm21102926eec.9.2026.11.14.16.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 16:48:35 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tan Chi <tanchi25@mails.ucas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 3/8] hw/riscv: Move platform bus FDT creation to machine code
Date: Sun, 15 Nov 2026 10:48:14 +1000
Message-ID: <20261115004819.2586336-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261115004819.2586336-1-alistair.francis@wdc.com>
References: <20261115004819.2586336-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=alistair23@gmail.com; helo=mail-dy1-x1336.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tan Chi <tanchi25@mails.ucas.ac.cn>

riscv_create_fdt_socket_aplic() contains a direct reference to
platform_bus_add_all_fdt_nodes(), even though fdt-common.c is
built unconditionally and CONFIG_PLATFORM_BUS may be disabled.

This causes an undefined reference in minimal RISC-V builds
without platform bus support.

Move platform bus FDT creation to the virt and server reference
machines, which both select CONFIG_PLATFORM_BUS. Export a helper
to obtain the APLIC node name and remove the platform bus fields
from APLICFdtProps.

This removes the dependency from the common APLIC FDT helper
while preserving the platform bus interrupt-parent configuration.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20261101031547.125591-4-tanchi25@mails.ucas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h  |  3 +--
 hw/riscv/fdt-common.c          | 13 ++-----------
 hw/riscv/server_platform_ref.c |  9 +++++++--
 hw/riscv/virt.c                | 11 +++++++++--
 4 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index eb9db8278d09..b3b14ada0aca 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -54,8 +54,6 @@ typedef struct IMSICFdtProps {
 typedef struct APLICFdtProps {
     const MemMapEntry *aplic_m;
     const MemMapEntry *aplic_s;
-    const MemMapEntry *platform_bus;
-    int platform_bus_irq;
     int socket;
     int num_harts;
     bool numa_enabled;
@@ -129,6 +127,7 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
 void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
                                     uint32_t *intc_phandles);
 /* Caller must free the returned string.  */
+char *riscv_fdt_get_aplic_nodename(hwaddr addr);
 char *riscv_fdt_get_uart_nodename(hwaddr addr);
 void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                            int uart_irq, int aia_type,
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index ce2dcb43b4fb..e90502b1bc65 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -11,7 +11,6 @@
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
 #include "hw/core/boards.h"
-#include "hw/core/sysbus-fdt.h"
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
 #include "hw/riscv/riscv-iommu-bits.h"
@@ -599,7 +598,7 @@ void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *props,
 }
 
 /* Caller must free string after use */
-static char *fdt_get_aplic_nodename(hwaddr aplic_addr)
+char *riscv_fdt_get_aplic_nodename(hwaddr aplic_addr)
 {
     return g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIx,
                            aplic_addr);
@@ -613,7 +612,7 @@ static void create_fdt_one_aplic(void *fdt, APLICFdtProps *props,
                                  uint32_t aplic_child_phandle,
                                  bool m_mode)
 {
-    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
+    g_autofree char *aplic_name = riscv_fdt_get_aplic_nodename(aplic_addr);
     g_autofree uint32_t *aplic_cells = g_new0(uint32_t, props->num_harts * 2);
     static const char * const aplic_compat[2] = {
         "qemu,aplic", "riscv,aplic"
@@ -695,14 +694,6 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
                          aplic_s_phandle, 0,
                          false);
 
-    if (!props->socket && props->platform_bus_irq) {
-        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
-        platform_bus_add_all_fdt_nodes(fdt, aplic_name,
-                                       props->platform_bus->base,
-                                       props->platform_bus->size,
-                                       props->platform_bus_irq);
-    }
-
     aplic_phandles[props->socket] = aplic_s_phandle;
 }
 
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 5f485b1c79cb..3526c80d7947 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -192,6 +192,7 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
 {
     int socket, phandle_pos;
     MachineState *ms = MACHINE(s);
+    g_autofree char *aplic_name = NULL;
     uint32_t msi_m_phandle = 0, msi_s_phandle = 0;
     uint32_t xplic_phandles[MAX_NODES];
     g_autofree uint32_t *intc_phandles = NULL;
@@ -251,8 +252,6 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
     aplic_fdt_props.aplic_m = !kvm_enabled()
                               ? &memmap[RVSERVER_APLIC_M] : NULL;
     aplic_fdt_props.aplic_s = &memmap[RVSERVER_APLIC_S];
-    aplic_fdt_props.platform_bus = &memmap[RVSERVER_PLATFORM_BUS];
-    aplic_fdt_props.platform_bus_irq = RVSERVER_PLATFORM_BUS_IRQ;
     aplic_fdt_props.num_harts = ms->smp.cpus;
     aplic_fdt_props.numa_enabled = numa_enabled;
     aplic_fdt_props.irqchip_num_sources = RVSERVER_IRQCHIP_NUM_SOURCES;
@@ -270,6 +269,12 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
                                       xplic_phandles);
     }
 
+    aplic_name = riscv_fdt_get_aplic_nodename(memmap[RVSERVER_APLIC_S].base);
+    platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
+                                   memmap[RVSERVER_PLATFORM_BUS].base,
+                                   memmap[RVSERVER_PLATFORM_BUS].size,
+                                   RVSERVER_PLATFORM_BUS_IRQ);
+
     for (socket = 0; socket < socket_count; socket++) {
         if (socket == 0) {
             *irq_mmio_phandle = xplic_phandles[socket];
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8bc5a7b0728c..ffd6e8868f70 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -296,8 +296,6 @@ static void create_fdt_sockets(RISCVVirtState *s,
     if (s->aia_type != VIRT_AIA_TYPE_NONE) {
         aplic_props.aplic_m = !kvm_enabled() ? &s->memmap[VIRT_APLIC_M] : NULL;
         aplic_props.aplic_s = &s->memmap[VIRT_APLIC_S];
-        aplic_props.platform_bus = &s->memmap[VIRT_PLATFORM_BUS];
-        aplic_props.platform_bus_irq = VIRT_PLATFORM_BUS_IRQ;
         aplic_props.socket = 0;
         aplic_props.num_harts = ms->smp.cpus;
         aplic_props.numa_enabled = numa_enabled;
@@ -353,6 +351,15 @@ static void create_fdt_sockets(RISCVVirtState *s,
         }
     }
 
+    if (s->aia_type != VIRT_AIA_TYPE_NONE) {
+        g_autofree char *aplic_name =
+            riscv_fdt_get_aplic_nodename(s->memmap[VIRT_APLIC_S].base);
+        platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
+                                       s->memmap[VIRT_PLATFORM_BUS].base,
+                                       s->memmap[VIRT_PLATFORM_BUS].size,
+                                       VIRT_PLATFORM_BUS_IRQ);
+    }
+
     riscv_socket_fdt_write_distance_matrix(ms);
 }
 
-- 
2.55.0


