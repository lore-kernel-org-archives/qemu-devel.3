Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E870C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeDa-00053e-Bb; Tue, 02 Jul 2024 10:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDJ-0004mD-JZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDF-0000KY-Sg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tLYMiEpSTV+muhM/St/OMTi5MMjd/r9xWUNm5/42vJU=;
 b=IllD2l1dGEIAV/bYKvIvLR1Ig/QnRPL3mlG5BIkuXFHucmEbWq9NgnjnIZ+435kT507mfR
 tNRUgsioNPLwfMSQ7QPMGR5LSUHgINAF1oZiNzxK62E8QBZDAISNEQoUkWZgcsWCpq2XPN
 RPz0oc5iGyxF8o+DRLkxR1S9OQiY7x4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-B1K8QCvfMHqWvVLP96Kcag-1; Tue, 02 Jul 2024 10:10:28 -0400
X-MC-Unique: B1K8QCvfMHqWvVLP96Kcag-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-425897358f0so6728665e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929426; x=1720534226;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLYMiEpSTV+muhM/St/OMTi5MMjd/r9xWUNm5/42vJU=;
 b=veWq3XQohJJl4+mrc/8Eronm8O4E1GsRa3rQf2TPmZmaRkwG97xFcd2rAL90JVA4pk
 8UBO+V5qhv6CdXRI6PSVT08Nv1n8mGzJQ9MrY1Aweu3xC6WIOJ4oQ2GIGv27W4Q8LeUZ
 F/gshKb5v6XRbgDCu8iG9gFYYSyjciLqQKIOxGasKnNULG0UCYa+hHp07bOtgF4Rgd8Y
 Y0jJ+IxVxU5fFJ5UjnALpBon/laCiVM1+O2pNPq8kf4/FThbgTTjUAMfLeSoSo5XnJor
 TL8uEtzcuuh51pFamRYF1H4QNkLfFdkYv3r/j7mslL/d6cB6YKtWoiaAjcAad5vH89zk
 Ln+Q==
X-Gm-Message-State: AOJu0YxOViSSu7/eKBYrpfNTqWiFtTPIE+ZTq7O8UlH5velvIpYx8dIC
 xjHmota51xzuUqrkbPVGzWlT+AY1Vbbao74JOBlQVgA+83HbsiI3OlakQQ5yItaWjZgamHUppQA
 cyjqwqQoprec4rxNWqAkO9kbL4MjJ9AAckIRN/4GO4SMcdlI0SKzqKv2zTPEYODdbZDYNFmZH3o
 gDz/Mse5RxhcnftxUGNltzYNW5VKga4w==
X-Received: by 2002:a05:6000:1fab:b0:367:4e05:bb7b with SMTP id
 ffacd0b85a97d-36775721674mr6742101f8f.53.1719929426482; 
 Tue, 02 Jul 2024 07:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcAUiENVIUR6dFsMf9AJhHAAqsNXctS2BiGfMuDex+cdjte0I5Bjq/JSkrZAaNAFokoryiAA==
X-Received: by 2002:a05:6000:1fab:b0:367:4e05:bb7b with SMTP id
 ffacd0b85a97d-36775721674mr6742067f8f.53.1719929425905; 
 Tue, 02 Jul 2024 07:10:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb9c1sm13428079f8f.74.2024.07.02.07.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:25 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 66/91] qtest: bios-tables-test: Rename aarch64 tests with
 aarch64 in them
Message-ID: <5171618ee509fd1ab2c35cb4a9612d3925a18ecb.1719929191.git.mst@redhat.com>
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

Existing AARCH64 virt test functions do not have AARCH64 in their name.
To add RISC-V virt related test cases, better to rename existing
functions to indicate they are ARM only.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-6-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 35 ++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index d1ff4db7a2..c4a4d1c7bf 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1570,7 +1570,7 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
     test_acpi_tcg_dimm_pxm(MACHINE_PC);
 }
 
-static void test_acpi_virt_tcg_memhp(void)
+static void test_acpi_aarch64_virt_tcg_memhp(void)
 {
     test_data data = {
         .machine = "virt",
@@ -1663,7 +1663,7 @@ static void test_acpi_microvm_ioapic2_tcg(void)
     free_test_data(&data);
 }
 
-static void test_acpi_virt_tcg_numamem(void)
+static void test_acpi_aarch64_virt_tcg_numamem(void)
 {
     test_data data = {
         .machine = "virt",
@@ -1685,7 +1685,7 @@ static void test_acpi_virt_tcg_numamem(void)
 
 }
 
-static void test_acpi_virt_tcg_pxb(void)
+static void test_acpi_aarch64_virt_tcg_pxb(void)
 {
     test_data data = {
         .machine = "virt",
@@ -1758,7 +1758,7 @@ static void test_acpi_piix4_tcg_acpi_hmat(void)
     test_acpi_tcg_acpi_hmat(MACHINE_PC);
 }
 
-static void test_acpi_virt_tcg_acpi_hmat(void)
+static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
 {
     test_data data = {
         .machine = "virt",
@@ -1914,7 +1914,7 @@ static void test_acpi_microvm_acpi_erst(void)
 }
 #endif /* CONFIG_POSIX */
 
-static void test_acpi_virt_tcg(void)
+static void test_acpi_aarch64_virt_tcg(void)
 {
     test_data data = {
         .machine = "virt",
@@ -1933,7 +1933,7 @@ static void test_acpi_virt_tcg(void)
     free_test_data(&data);
 }
 
-static void test_acpi_virt_tcg_topology(void)
+static void test_acpi_aarch64_virt_tcg_topology(void)
 {
     test_data data = {
         .machine = "virt",
@@ -2016,7 +2016,7 @@ static void test_acpi_q35_cxl(void)
 }
 #endif /* CONFIG_POSIX */
 
-static void test_acpi_virt_viot(void)
+static void test_acpi_aarch64_virt_viot(void)
 {
     test_data data = {
         .machine = "virt",
@@ -2192,7 +2192,7 @@ static void test_acpi_microvm_oem_fields(void)
     g_free(args);
 }
 
-static void test_acpi_virt_oem_fields(void)
+static void test_acpi_aarch64_virt_oem_fields(void)
 {
     test_data data = {
         .machine = "virt",
@@ -2364,16 +2364,19 @@ int main(int argc, char *argv[])
         }
     } else if (strcmp(arch, "aarch64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
-            qtest_add_func("acpi/virt", test_acpi_virt_tcg);
+            qtest_add_func("acpi/virt", test_acpi_aarch64_virt_tcg);
             qtest_add_func("acpi/virt/acpihmatvirt",
-                            test_acpi_virt_tcg_acpi_hmat);
-            qtest_add_func("acpi/virt/topology", test_acpi_virt_tcg_topology);
-            qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
-            qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
-            qtest_add_func("acpi/virt/pxb", test_acpi_virt_tcg_pxb);
-            qtest_add_func("acpi/virt/oem-fields", test_acpi_virt_oem_fields);
+                           test_acpi_aarch64_virt_tcg_acpi_hmat);
+            qtest_add_func("acpi/virt/topology",
+                           test_acpi_aarch64_virt_tcg_topology);
+            qtest_add_func("acpi/virt/numamem",
+                           test_acpi_aarch64_virt_tcg_numamem);
+            qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
+            qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
+            qtest_add_func("acpi/virt/oem-fields",
+                           test_acpi_aarch64_virt_oem_fields);
             if (qtest_has_device("virtio-iommu-pci")) {
-                qtest_add_func("acpi/virt/viot", test_acpi_virt_viot);
+                qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
         }
     }
-- 
MST


