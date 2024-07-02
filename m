Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599F9C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeED-0005vc-Ff; Tue, 02 Jul 2024 10:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDU-00057r-4j
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDR-0000OT-Oo
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H0Zx9hcjCb8TTX+fknLAFuiiboZn7NyIn2VBiJnNZQk=;
 b=XEPfhv//EIrVxqv8Zl+9j3ZVf2TMEBZ/uH1IMjZH09c3wl4bI76hUbhlOg5cMy7aQCVoIx
 MOYwaDFbj18xtPMCy0Cjg5KXN/W21fAQduOgnBZL+xqmRamGu4NUoXJO6SqoAnQeN1TuQd
 6QQwVg8xldJovJnWpebWn15ixqkpiyY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-VdknvXfhOdOzvk0l9lIVOQ-1; Tue, 02 Jul 2024 10:10:38 -0400
X-MC-Unique: VdknvXfhOdOzvk0l9lIVOQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a724d8c38d3so271837266b.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929437; x=1720534237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0Zx9hcjCb8TTX+fknLAFuiiboZn7NyIn2VBiJnNZQk=;
 b=m/xfkfjj+2nO2plPJ9KN4Im8pSbMvSdsGKJgrzdbadDGyeCpZVpzF8eim+bvSZIU/H
 NYwrP+Yp1nlwBex/Mc3hyUY4ZAp91IQrNf2cBjKhox0euDD0QiFHXVEVxdikabDiEFVI
 qBV0eHzOObkbKwwhantco0B08edW+N6Gyp5Z06p5wLwgdrfqFQoPxOTcuULpCZ+Qu0+z
 9vTQhWVyx0DsBh+CYpUZS4KplWqTVS1UGFC5+i5/jRLSWHEgd4ZuRVAj5vzM8SvGLL1X
 bRjyGdymm0eXfS6xcItYSdiXROLNuqi8Gu6WAz1tYaDIm3JO8p/5gVBpuVADJzZVMYsR
 BGcQ==
X-Gm-Message-State: AOJu0Yyn5TrOXQwvSPbGyUpy0pBq1iV9W6TDm0Zz7yrelzai8My/ajuP
 EkEZtpnuhViYoMl3hXWIVICyFN5Uxqx/o95PpT6F4O6mRQEIirdyh0/GjUS1T6/t7HdL7xeCvuQ
 jiqP42a/HOLV/y0fcOSbeKlKPCIJgRFDen8QNUtTtVYZfv9FRl40K3eWXvjxaI/bm6s0FUxcPTH
 47krS25T/4rCnjdzr2g7YyuiCmrKHzVg==
X-Received: by 2002:a17:906:d202:b0:a75:410c:ecb0 with SMTP id
 a640c23a62f3a-a75410cedd3mr116935066b.67.1719929436839; 
 Tue, 02 Jul 2024 07:10:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLAenNl69KM30pIiU0bvU7Uxc5sMqwnA8SXben1pdrd6dqMlEm4BtP+CiEeLN9C8wOaKLpBg==
X-Received: by 2002:a17:906:d202:b0:a75:410c:ecb0 with SMTP id
 a640c23a62f3a-a75410cedd3mr116931466b.67.1719929436053; 
 Tue, 02 Jul 2024 07:10:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab06511fsm426469166b.102.2024.07.02.07.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:35 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 69/91] tests/qtest/bios-tables-test.c: Set "arch" for x86 tests
Message-ID: <7ec0c03b4d8744f0e06800f2e9b1254d0b578830.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sunil V L <sunilvl@ventanamicro.com>

To search for expected AML files under ${arch}/${machine} path, set this
field for X86 related test cases.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-9-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 77 ++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 007c281c9a..f4c4704bab 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -933,6 +933,7 @@ static void test_acpi_piix4_tcg(void)
      * This is to make guest actually run.
      */
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
     test_acpi_one(NULL, &data);
@@ -944,6 +945,7 @@ static void test_acpi_piix4_tcg_bridge(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".bridge";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -981,6 +983,7 @@ static void test_acpi_piix4_no_root_hotplug(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".roothp";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -997,6 +1000,7 @@ static void test_acpi_piix4_no_bridge_hotplug(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".hpbridge";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -1013,6 +1017,7 @@ static void test_acpi_piix4_no_acpi_pci_hotplug(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".hpbrroot";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -1034,6 +1039,7 @@ static void test_acpi_q35_tcg(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch = "x86";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
     test_acpi_one(NULL, &data);
@@ -1049,6 +1055,7 @@ static void test_acpi_q35_kvm_type4_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".type4-count",
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
@@ -1065,6 +1072,7 @@ static void test_acpi_q35_kvm_core_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".core-count",
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
@@ -1082,6 +1090,7 @@ static void test_acpi_q35_kvm_core_count2(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".core-count2",
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
@@ -1099,6 +1108,7 @@ static void test_acpi_q35_kvm_thread_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".thread-count",
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
@@ -1116,6 +1126,7 @@ static void test_acpi_q35_kvm_thread_count2(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".thread-count2",
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
@@ -1134,6 +1145,7 @@ static void test_acpi_q35_tcg_bridge(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".bridge";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -1148,6 +1160,7 @@ static void test_acpi_q35_tcg_no_acpi_hotplug(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".noacpihp";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -1176,6 +1189,7 @@ static void test_acpi_q35_multif_bridge(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".multi-bridge",
     };
     test_vm_prepare("-S"
@@ -1225,6 +1239,7 @@ static void test_acpi_q35_tcg_mmio64(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".mmio64",
         .tcg_only = true,
         .required_struct_types = base_required_struct_types,
@@ -1245,6 +1260,7 @@ static void test_acpi_piix4_tcg_cphp(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".cphp";
     test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
                   " -object memory-backend-ram,id=ram0,size=64M"
@@ -1260,6 +1276,7 @@ static void test_acpi_q35_tcg_cphp(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".cphp";
     test_acpi_one(" -smp 2,cores=3,sockets=2,maxcpus=6"
                   " -object memory-backend-ram,id=ram0,size=64M"
@@ -1279,6 +1296,7 @@ static void test_acpi_q35_tcg_ipmi(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".ipmibt";
     data.required_struct_types = ipmi_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(ipmi_required_struct_types);
@@ -1293,6 +1311,7 @@ static void test_acpi_q35_tcg_smbus_ipmi(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".ipmismbus";
     data.required_struct_types = ipmi_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(ipmi_required_struct_types);
@@ -1310,6 +1329,7 @@ static void test_acpi_piix4_tcg_ipmi(void)
      * This is to make guest actually run.
      */
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".ipmikcs";
     data.required_struct_types = ipmi_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(ipmi_required_struct_types);
@@ -1324,6 +1344,7 @@ static void test_acpi_q35_tcg_memhp(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".memhp";
     test_acpi_one(" -m 128,slots=3,maxmem=1G"
                   " -object memory-backend-ram,id=ram0,size=64M"
@@ -1339,6 +1360,7 @@ static void test_acpi_piix4_tcg_memhp(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".memhp";
     test_acpi_one(" -m 128,slots=3,maxmem=1G"
                   " -object memory-backend-ram,id=ram0,size=64M"
@@ -1354,6 +1376,7 @@ static void test_acpi_piix4_tcg_nosmm(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".nosmm";
     test_acpi_one("-machine smm=off", &data);
     free_test_data(&data);
@@ -1364,6 +1387,7 @@ static void test_acpi_piix4_tcg_smm_compat(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".smm-compat";
     test_acpi_one("-global PIIX4_PM.smm-compat=on", &data);
     free_test_data(&data);
@@ -1374,6 +1398,7 @@ static void test_acpi_piix4_tcg_smm_compat_nosmm(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".smm-compat-nosmm";
     test_acpi_one("-global PIIX4_PM.smm-compat=on -machine smm=off", &data);
     free_test_data(&data);
@@ -1384,6 +1409,7 @@ static void test_acpi_piix4_tcg_nohpet(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.machine_param = ",hpet=off";
     data.variant = ".nohpet";
     test_acpi_one(NULL, &data);
@@ -1395,6 +1421,7 @@ static void test_acpi_q35_tcg_numamem(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".numamem";
     test_acpi_one(" -object memory-backend-ram,id=ram0,size=128M"
                   " -numa node -numa node,memdev=ram0", &data);
@@ -1406,6 +1433,7 @@ static void test_acpi_q35_kvm_xapic(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".xapic";
     test_acpi_one(" -object memory-backend-ram,id=ram0,size=128M"
                   " -numa node -numa node,memdev=ram0"
@@ -1418,6 +1446,7 @@ static void test_acpi_q35_tcg_nosmm(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".nosmm";
     test_acpi_one("-machine smm=off", &data);
     free_test_data(&data);
@@ -1428,6 +1457,7 @@ static void test_acpi_q35_tcg_smm_compat(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".smm-compat";
     test_acpi_one("-global ICH9-LPC.smm-compat=on", &data);
     free_test_data(&data);
@@ -1438,6 +1468,7 @@ static void test_acpi_q35_tcg_smm_compat_nosmm(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".smm-compat-nosmm";
     test_acpi_one("-global ICH9-LPC.smm-compat=on -machine smm=off", &data);
     free_test_data(&data);
@@ -1448,6 +1479,7 @@ static void test_acpi_q35_tcg_nohpet(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.machine_param = ",hpet=off";
     data.variant = ".nohpet";
     test_acpi_one(NULL, &data);
@@ -1459,6 +1491,7 @@ static void test_acpi_q35_kvm_dmar(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".dmar";
     test_acpi_one("-machine kernel-irqchip=split -accel kvm"
                   " -device intel-iommu,intremap=on,device-iotlb=on", &data);
@@ -1470,6 +1503,7 @@ static void test_acpi_q35_tcg_ivrs(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".ivrs";
     data.tcg_only = true,
     test_acpi_one(" -device amd-iommu", &data);
@@ -1481,6 +1515,7 @@ static void test_acpi_piix4_tcg_numamem(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".numamem";
     test_acpi_one(" -object memory-backend-ram,id=ram0,size=128M"
                   " -numa node -numa node,memdev=ram0", &data);
@@ -1489,8 +1524,9 @@ static void test_acpi_piix4_tcg_numamem(void)
 
 uint64_t tpm_tis_base_addr;
 
-static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
-                              uint64_t base, enum TPMVersion tpm_version)
+static void test_acpi_tcg_tpm(const char *machine, const char *arch,
+                              const char *tpm_if, uint64_t base,
+                              enum TPMVersion tpm_version)
 {
     gchar *tmp_dir_name = g_strdup_printf("qemu-test_acpi_%s_tcg_%s.XXXXXX",
                                           machine, tpm_if);
@@ -1517,6 +1553,7 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
     tpm_emu_test_wait_cond(&test);
 
     data.machine = machine;
+    data.arch = arch;
     data.variant = variant;
 
     args = g_strdup_printf(
@@ -1540,19 +1577,20 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
 
 static void test_acpi_q35_tcg_tpm2_tis(void)
 {
-    test_acpi_tcg_tpm("q35", "tis", 0xFED40000, TPM_VERSION_2_0);
+    test_acpi_tcg_tpm("q35", "x86", "tis", 0xFED40000, TPM_VERSION_2_0);
 }
 
 static void test_acpi_q35_tcg_tpm12_tis(void)
 {
-    test_acpi_tcg_tpm("q35", "tis", 0xFED40000, TPM_VERSION_1_2);
+    test_acpi_tcg_tpm("q35", "x86", "tis", 0xFED40000, TPM_VERSION_1_2);
 }
 
-static void test_acpi_tcg_dimm_pxm(const char *machine)
+static void test_acpi_tcg_dimm_pxm(const char *machine, const char *arch)
 {
     test_data data = {};
 
     data.machine = machine;
+    data.arch    = arch;
     data.variant = ".dimmpxm";
     test_acpi_one(" -machine nvdimm=on,nvdimm-persistence=cpu"
                   " -smp 4,sockets=4"
@@ -1579,12 +1617,12 @@ static void test_acpi_tcg_dimm_pxm(const char *machine)
 
 static void test_acpi_q35_tcg_dimm_pxm(void)
 {
-    test_acpi_tcg_dimm_pxm(MACHINE_Q35);
+    test_acpi_tcg_dimm_pxm(MACHINE_Q35, "x86");
 }
 
 static void test_acpi_piix4_tcg_dimm_pxm(void)
 {
-    test_acpi_tcg_dimm_pxm(MACHINE_PC);
+    test_acpi_tcg_dimm_pxm(MACHINE_PC, "x86");
 }
 
 static void test_acpi_aarch64_virt_tcg_memhp(void)
@@ -1621,6 +1659,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
 static void test_acpi_microvm_prepare(test_data *data)
 {
     data->machine = "microvm";
+    data->arch = "x86";
     data->required_struct_types = NULL; /* no smbios */
     data->required_struct_types_len = 0;
     data->blkdev = "virtio-blk-device";
@@ -1737,11 +1776,12 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
     free_test_data(&data);
 }
 
-static void test_acpi_tcg_acpi_hmat(const char *machine)
+static void test_acpi_tcg_acpi_hmat(const char *machine, const char *arch)
 {
     test_data data = {};
 
     data.machine = machine;
+    data.arch    = arch;
     data.variant = ".acpihmat";
     test_acpi_one(" -machine hmat=on"
                   " -smp 2,sockets=2"
@@ -1770,12 +1810,12 @@ static void test_acpi_tcg_acpi_hmat(const char *machine)
 
 static void test_acpi_q35_tcg_acpi_hmat(void)
 {
-    test_acpi_tcg_acpi_hmat(MACHINE_Q35);
+    test_acpi_tcg_acpi_hmat(MACHINE_Q35, "x86");
 }
 
 static void test_acpi_piix4_tcg_acpi_hmat(void)
 {
-    test_acpi_tcg_acpi_hmat(MACHINE_PC);
+    test_acpi_tcg_acpi_hmat(MACHINE_PC, "x86");
 }
 
 static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
@@ -1841,6 +1881,7 @@ static void test_acpi_q35_tcg_acpi_hmat_noinitiator(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86";
     data.variant = ".acpihmat-noinitiator";
     test_acpi_one(" -machine hmat=on"
                   " -smp 4,sockets=2"
@@ -1884,13 +1925,14 @@ static void test_acpi_q35_tcg_acpi_hmat_noinitiator(void)
 }
 
 #ifdef CONFIG_POSIX
-static void test_acpi_erst(const char *machine)
+static void test_acpi_erst(const char *machine, const char *arch)
 {
     gchar *tmp_path = g_dir_make_tmp("qemu-test-erst.XXXXXX", NULL);
     gchar *params;
     test_data data = {};
 
     data.machine = machine;
+    data.arch    = arch;
     data.variant = ".acpierst";
     params = g_strdup_printf(
         " -object memory-backend-file,id=erstnvram,"
@@ -1905,12 +1947,12 @@ static void test_acpi_erst(const char *machine)
 
 static void test_acpi_piix4_acpi_erst(void)
 {
-    test_acpi_erst(MACHINE_PC);
+    test_acpi_erst(MACHINE_PC, "x86");
 }
 
 static void test_acpi_q35_acpi_erst(void)
 {
-    test_acpi_erst(MACHINE_Q35);
+    test_acpi_erst(MACHINE_Q35, "x86");
 }
 
 static void test_acpi_microvm_acpi_erst(void)
@@ -1978,6 +2020,7 @@ static void test_acpi_q35_viot(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".viot",
     };
 
@@ -2002,6 +2045,7 @@ static void test_acpi_q35_cxl(void)
 
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".cxl",
     };
     /*
@@ -2067,6 +2111,7 @@ static void test_acpi_q35_slic(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".slic",
     };
 
@@ -2081,6 +2126,7 @@ static void test_acpi_q35_applesmc(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".applesmc",
     };
 
@@ -2094,6 +2140,7 @@ static void test_acpi_q35_pvpanic_isa(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".pvpanic-isa",
     };
 
@@ -2106,6 +2153,7 @@ static void test_acpi_pc_smbios_options(void)
     uint8_t req_type11[] = { 11 };
     test_data data = {
         .machine = MACHINE_PC,
+        .arch    = "x86",
         .variant = ".pc_smbios_options",
         .required_struct_types = req_type11,
         .required_struct_types_len = ARRAY_SIZE(req_type11),
@@ -2120,6 +2168,7 @@ static void test_acpi_pc_smbios_blob(void)
     uint8_t req_type11[] = { 11 };
     test_data data = {
         .machine = MACHINE_PC,
+        .arch    = "x86",
         .variant = ".pc_smbios_blob",
         .required_struct_types = req_type11,
         .required_struct_types_len = ARRAY_SIZE(req_type11),
@@ -2169,6 +2218,7 @@ static void test_acpi_piix4_oem_fields(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
 
@@ -2187,6 +2237,7 @@ static void test_acpi_q35_oem_fields(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
 
-- 
MST


