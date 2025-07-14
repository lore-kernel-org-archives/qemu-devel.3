Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4309C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSH0-0005ns-8l; Mon, 14 Jul 2025 19:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGc-0003oH-KK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGZ-0005Vx-EA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fR2Rjmec6t5246rVdjtiSBzuumKeTZiDjKCEbittM+Y=;
 b=TEa9QKRrIp6CujgLZTNUtfqAcuGpF22e2BBLQ1drKS6D8+jmRqB9WqkcFhLvu6OKfKV0Ab
 5sCllbcRxsS/wG5n9NBgfGNxZfmDEKDwPRpoWEfDiLrqP669YY6jxVTTwFXxLZ3TY2WlwY
 nzr0D/CVdd3IsZUeglGXZLLZgKxyBbE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-6p8HqpE_PgaKGTByFj4nxg-1; Mon, 14 Jul 2025 19:07:21 -0400
X-MC-Unique: 6p8HqpE_PgaKGTByFj4nxg-1
X-Mimecast-MFC-AGG-ID: 6p8HqpE_PgaKGTByFj4nxg_1752534440
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45597cc95d5so18205135e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534440; x=1753139240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fR2Rjmec6t5246rVdjtiSBzuumKeTZiDjKCEbittM+Y=;
 b=Rk+sHJ3YEyOMoKi+8UI9hyQLJbDNwW7KulwEB15GJdYBZBxKYx5O5ODbaseBPyYGIR
 kx2yiQrm/h+/54eiEgwLHrV3x2Br8gOIl355AmD+O22z4KPpJsInTM8xhUBsctyW6G+v
 oLzS2fE2XGq7Ry1fPNCYuK3JBHPsjJ9iAhAuc4TyWboZreizXWBtU6QTSAhniDwlmJKf
 EFwOrDIK07xT3T4UpFLtTB3Xt7XCdy1Q3Ar2x+dVYCQgG/kFcfAVZRaBs2upYjxxmKer
 anaBeAEpT0Q6sw3/RRLdDz0Jhw9PSk/Ny+fiNCilR5kFYHp7OrgL2Wvvwh/s1ZBdAZy2
 TLPQ==
X-Gm-Message-State: AOJu0YxtWCfmyeJo5Cmtq/36rTMZkra886D9ddqoFhDQWf+rano+FHXB
 0Ocu+hcRNQnK2HFxmmc6tHzBsBoYfL8Wt+lewNIyLzVmMdQSTXdF658Kl/5aIeymCN6+PwgCzae
 mubBC/HD1MKVhZaAVN4iurgjcFpT85swMzpElQd/HW2G4NN3k/NT09Ag4ksu+aOSdn5nVDzwqyG
 KLM73R0lpYo6kk8Am+zJWzki5P3kGQ8cVR5g==
X-Gm-Gg: ASbGnctwgjSnd9QW0y9a3XPUBqMvU1rvg641j9ItkmwosimOD+bQ2JRDVr1AJdP38Lj
 ZQd7zMUIIm0EaA8W6G7Rsy7F4Qon8eczssq87Z+4Yt9XLHzOEhabD0BhS5x+JnsAm74iHz7C3xq
 Izkd/2+pBtTEmgScggazpoLTBW/G5XvmfBYW0szVJrVJ/TmhZ8jDqeKII4KpPfZ8cDdlpeqOXjG
 i/ixCXb4si940u4zZ5lLUqtzaxVLoBXmJ1wFRCxGXAq5F2g9+SPTMHHexv+gY6Djo2q0XclOCZe
 Yd7TWth7yrE+fNYZ3dmteQ8fGSJHqr55
X-Received: by 2002:a05:600c:348e:b0:456:24db:2efb with SMTP id
 5b1f17b1804b1-45624db321dmr17130795e9.15.1752534439805; 
 Mon, 14 Jul 2025 16:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI4aREeHWW+WF/WHiBOoCLF6P2lSeCGErMgOCsa7UTPWDkVtHttogsmk4H6B3iEYd5CDWBiA==
X-Received: by 2002:a05:600c:348e:b0:456:24db:2efb with SMTP id
 5b1f17b1804b1-45624db321dmr17130415e9.15.1752534439322; 
 Mon, 14 Jul 2025 16:07:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562797b956sm2053405e9.17.2025.07.14.16.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:18 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Chen <chenl311@chinatelecom.cn>, Bibo Mao <maobibo@loongson.cn>,
 Gavin Shan <gshan@redhat.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PULL 25/97] acpi: Add machine option to disable SPCR table
Message-ID: <54401d5abd13c7f2ff5d1cb65e73a067743230e3.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Li Chen <chenl311@chinatelecom.cn>

The ACPI SPCR (Serial Port Console Redirection) table allows firmware
to specify a preferred serial console device to the operating system.
On ARM64 systems, Linux by default respects this table: even if the
kernel command line does not include a hardware serial console (e.g.,
"console=ttyAMA0"), the kernel still register the serial device
referenced by SPCR as a printk console.

While this behavior is standard-compliant, it can lead to situations
where guest console behavior is influenced by platform firmware rather
than user-specified configuration. To make guest console behavior more
predictable and under user control, this patch introduces a machine
option to explicitly disable SPCR table exposure:

    -machine spcr=off

By default, the option is enabled (spcr=on), preserving existing
behavior. When disabled, QEMU will omit the SPCR table from the guest's
ACPI namespace, ensuring that only consoles explicitly declared in the
kernel command line are registered.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Message-Id: <20250528105404.457729-2-me@linux.beauty>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/boards.h            |  1 +
 hw/arm/virt-acpi-build.c       |  5 ++++-
 hw/core/machine.c              | 22 ++++++++++++++++++++++
 hw/loongarch/virt-acpi-build.c |  4 +++-
 hw/riscv/virt-acpi-build.c     |  5 ++++-
 qemu-options.hx                |  5 +++++
 6 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f424b2b505..f94713e6e2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -443,6 +443,7 @@ struct MachineState {
     SmpCache smp_cache;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
+    bool acpi_spcr_enabled;
 };
 
 /*
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0dfb8ec2c3..782b17b966 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1023,7 +1023,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     }
 
     acpi_add_table(table_offsets, tables_blob);
-    spcr_setup(tables_blob, tables->linker, vms);
+
+    if (ms->acpi_spcr_enabled) {
+        spcr_setup(tables_blob, tables->linker, vms);
+    }
 
     acpi_add_table(table_offsets, tables_blob);
     build_dbg2(tables_blob, tables->linker, vms);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index e869821b22..ceee058cad 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -577,6 +577,20 @@ static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
     ms->nvdimms_state->is_enabled = value;
 }
 
+static bool machine_get_spcr(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->acpi_spcr_enabled;
+}
+
+static void machine_set_spcr(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->acpi_spcr_enabled = value;
+}
+
 static bool machine_get_hmat(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1281,6 +1295,14 @@ static void machine_initfn(Object *obj)
                                         "Table (HMAT)");
     }
 
+    /* SPCR */
+    ms->acpi_spcr_enabled = true;
+    object_property_add_bool(obj, "spcr", machine_get_spcr, machine_set_spcr);
+    object_property_set_description(obj, "spcr",
+                                   "Set on/off to enable/disable "
+                                   "ACPI Serial Port Console Redirection "
+                                   "Table (spcr)");
+
     /* default to mc->default_cpus */
     ms->smp.cpus = mc->default_cpus;
     ms->smp.max_cpus = mc->default_cpus;
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 2cd2d9d842..8c2228a772 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -557,7 +557,9 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     build_srat(tables_blob, tables->linker, machine);
     acpi_add_table(table_offsets, tables_blob);
-    spcr_setup(tables_blob, tables->linker, machine);
+
+    if (machine->acpi_spcr_enabled)
+        spcr_setup(tables_blob, tables->linker, machine);
 
     if (machine->numa_state->num_nodes) {
         if (machine->numa_state->have_numa_distance) {
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 8b5683dbde..ee1416d264 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -894,7 +894,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     }
 
     acpi_add_table(table_offsets, tables_blob);
-    spcr_setup(tables_blob, tables->linker, s);
+
+    if (ms->acpi_spcr_enabled) {
+        spcr_setup(tables_blob, tables->linker, s);
+    }
 
     acpi_add_table(table_offsets, tables_blob);
     {
diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a6..9b2d5f4b7a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
     "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
+    "                spcr=on|off controls ACPI SPCR support (default=on)\n"
 #ifdef CONFIG_POSIX
     "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
 #endif
@@ -105,6 +106,10 @@ SRST
         Enables or disables ACPI Heterogeneous Memory Attribute Table
         (HMAT) support. The default is off.
 
+    ``spcr=on|off``
+        Enables or disables ACPI Serial Port Console Redirection Table
+        (SPCR) support. The default is on.
+
     ``aux-ram-share=on|off``
         Allocate auxiliary guest RAM as an anonymous file that is
         shareable with an external process.  This option applies to
-- 
MST


