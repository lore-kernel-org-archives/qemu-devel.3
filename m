Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71670C83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMP-0002Xd-K7; Mon, 14 Jul 2025 19:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJ0-0004pX-5F
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIx-0005x0-EK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QqTJ16m3W94kcOoIuD8eqXOCXfhNBwJpPqGbqHsBKLU=;
 b=fPlHT2haEIS6HpqcsLpjC68S3ZTBvfn+CRzYpdhqA1qIHI3KJLQn6g7U8CrwQXYrgP8sNr
 Wch2wQCeFSWVGcv/3FXzaTKH7YmO48YmKKs5kIUKzjNcqgxhzrpCzbERi5dvEXmxu8qik3
 bX5/g3EeAperrEJhVCnuRljQel8jIZE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-fGaD2fZYM5au_GhMthOB3Q-1; Mon, 14 Jul 2025 19:09:49 -0400
X-MC-Unique: fGaD2fZYM5au_GhMthOB3Q-1
X-Mimecast-MFC-AGG-ID: fGaD2fZYM5au_GhMthOB3Q_1752534588
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso30883875e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534587; x=1753139387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqTJ16m3W94kcOoIuD8eqXOCXfhNBwJpPqGbqHsBKLU=;
 b=t/M9SRghVfJopPcdVhGUJAdr/o4LalCKFMDqC1GwdzzQhsItfVvobu5TqfCffVUtmw
 hONGXca3rwr9e+KVCqYApG3V0FGSeYZcWEnUizNmoBvJhcoq5BS0PEAjCORL8E7ovl9F
 hcAEpTjEP+5krVLPmqmP98HbZHixj7/qmHUnAv1LW7t6suymSx8xjplQGYMX9xaTXUw6
 OZ2oEpN+eNuGVLiaGezrlzpLjLEgIW5T+rxjflDs/VzmbpkgcbzaoHH/gWZeXhdOVIB4
 qRqoC8H/rLEQOMFbmvevsE9zOQ1LC4BtoYdvm3zfIcwAfGlhN3o6vH8TUbJNtDv3TegX
 nYWg==
X-Gm-Message-State: AOJu0Yw0wBOZ/ISJD9J6z0YfJyo1Oa8VruOUgVqPU20u4G3JM0hQKCvm
 mmmrxvhh4Y7oFvVmAcvyNJT3o9YAyEV2q8ZQ9I+cGZ8zskL5dPtaL4UHqgp3GRKv9mMJH+8w/dS
 PDfKr7WhSCh4woDrOtK5Vd9y0Op6PMfJy4HjLcVUj4oGvfNuq6kZyMO1KGEr0ACVKg6NbBh09hN
 T0noqkvfwtezT1S/wJ3Ayj6sT0JwBGP00CgA==
X-Gm-Gg: ASbGncuCCQ11q/YHz8W9EZR6UMQyciV2zUnYJW/svs345GDCoCQD/zDhyVxiiii2Ik9
 O4v6RhBwvke2ys2h6MG2h/EJLBlFMxgYeEpnegPe050k/id1vM6lXb3lnQyvZ/TQe7MqZZEXpD5
 oNI+tqsZLBQ/hhqOf54roPfySYhiBcdJUBF6aOpGLCJ2fiiZPGTZmJey/VLzqLGgw5M3S52UeC/
 kJ/w/IVqCe50ysCvRn8OWnK49l6+Yrv88bpFOlK88Z2AyeC6T99bMFxVJM72VzZvxoBF+p3tzFc
 WJ/x5An3vSUgjYEatPpIkf/mB4Gdn9JT
X-Received: by 2002:a05:600c:1e04:b0:456:c48:491f with SMTP id
 5b1f17b1804b1-4560c484fbbmr105519465e9.10.1752534587555; 
 Mon, 14 Jul 2025 16:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsoPaJGvE6lvlB6QXLaHNsv2urzMPx770IGVf42omrNkzGIp9onEx5jfb7qH2r2ms9kZSlgw==
X-Received: by 2002:a05:600c:1e04:b0:456:c48:491f with SMTP id
 5b1f17b1804b1-4560c484fbbmr105519235e9.10.1752534587046; 
 Mon, 14 Jul 2025 16:09:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560394e061sm87585675e9.31.2025.07.14.16.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:46 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 80/97] tests/qtest/bios-tables-test: Add aarch64 ACPI PCI
 hotplug test
Message-ID: <9b25d58455d7a78c4e58ce1401c9ee7f84c0e51b.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add 2 new tests:
- test_acpi_aarch64_virt_acpi_pci_hotplug tests the acpi pci hotplug
  using -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
- test_acpi_aarch64_virt_pcie_root_port_hpoff tests static-acpi index
  on a root port with disabled hotplug

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-35-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 4701975c05..6aec68decc 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1643,6 +1643,54 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
 
 }
 
+static void test_acpi_aarch64_virt_acpi_pci_hotplug(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 256ULL * MiB,
+        .variant = ".acpipcihp",
+    };
+
+   /* Use ACPI PCI Hotplug */
+   test_acpi_one(" -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on"
+                 " -cpu cortex-a57"
+                 " -device pcie-root-port,id=pcie.1,bus=pcie.0,chassis=0,slot=1,addr=7.0"
+                 " -device pci-testdev,bus=pcie.1",
+                 &data);
+
+    free_test_data(&data);
+}
+
+static void test_acpi_aarch64_virt_pcie_root_port_hpoff(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 256ULL * MiB,
+        .variant = ".hpoffacpiindex",
+    };
+
+   /* turn hotplug off on the pcie-root-port and use static acpi-index*/
+   test_acpi_one(" -device pcie-root-port,id=pcie.1,chassis=0,"
+                                          "slot=1,hotplug=off,addr=7.0"
+                 " -device pci-testdev,bus=pcie.1,acpi-index=12"
+                 " -cpu cortex-a57",
+                 &data);
+
+    free_test_data(&data);
+}
+
 static void test_acpi_microvm_prepare(test_data *data)
 {
     data->machine = "microvm";
@@ -2708,6 +2756,10 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_aarch64_virt_tcg_numamem);
             qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
+            qtest_add_func("acpi/virt/acpipcihp",
+                           test_acpi_aarch64_virt_acpi_pci_hotplug);
+            qtest_add_func("acpi/virt/hpoffacpiindex",
+                          test_acpi_aarch64_virt_pcie_root_port_hpoff);
             qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
             qtest_add_func("acpi/virt/oem-fields",
                            test_acpi_aarch64_virt_oem_fields);
-- 
MST


