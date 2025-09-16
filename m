Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83B0CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya6E-0005ni-Q3; Tue, 16 Sep 2025 14:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya59-0003VZ-EO
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:18 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4w-0001eR-0s
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:04 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3e98c5adbbeso1450881f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046012; x=1758650812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4dqb0NZE3YDP33SsalYcTuCfe7e9JX4x4Z6Cv8SAzRA=;
 b=bqNe3VtHi9VSduTy3DOeRfn6EasrzU/e3+KIhX2T4X0rRE3FWnyL1/JScsB1Cv9Y/s
 EcIyBVJfO15jggkYvlc26goX+QOgzvZ9OnUY5lnCn7XvCRlQuDShwsZ1A5Q4zLVJo/Qj
 RcgdP/853S71cWaDb5xBH/X4w2CUZSEtinut+wMvi+Ci8/KeCracBkQL4WvtSBBj0Svz
 lyJDIT6sVTu1aEqrnmaCIL64FpJBd/gyQqY0sECgD7hBZnCuR3YCW/xCxJczZKQMjVWh
 Kuap8odWmzDwgyOwP7YpluI5Y6upUUnlDh4ib55eAbjwLbMHiB3zG6oonxUhvIHnW5tE
 QFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046012; x=1758650812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dqb0NZE3YDP33SsalYcTuCfe7e9JX4x4Z6Cv8SAzRA=;
 b=c/kGNAchC3CUBJrq917l77Ma0zO+RZcmsI5VFLLjQ9yILILeom2/RbOvGv2W3VEDSS
 dhUdDkjJSGvYKtB+656xxUU3+u5d+Cgursw8LLZT2Kjl+3WbpVzNicdu2NHh+Je58rhN
 m+LPu1hI4S9LaXydcf9+Jfp0bRca8vwcDft5FUYQuJKI41/Oe7gx4jQD00BBDaUeEX3F
 M4NoJx/unqmrPhaGgo6ANOih4AH+elkOYMel29M/78/abhA8lXMSvV4f9pd6Jl9DlmU3
 1M1DhjQyHRLVvok+mPxo9rQ1ORJZ1AWqPbHR4b5ft1RPIMHFfudvA63VnueFrTVLbNhC
 GKyA==
X-Gm-Message-State: AOJu0Yy0ojzbZAsituyMdgAby3OHzaG8q+hqEEhmszbJcoTtdYcfKTtp
 IoPy64j26AmulhQ3mhZmmfFOQPvuLQnrKbBx8Nfj8jUOF1/05pRHBk0/xzQE84Ecd9llO1wKm94
 GmVPI
X-Gm-Gg: ASbGncsQ6A+sXVbUKlKsS9gJHgcUy273ZkoV+Ng1DM34DmPhNYXD5M/Alrx3vO5jJ10
 gWLwDxAMncH1Y2XWXs6umpMjO+TiFrBmgSVDHzYSoLzSPl75nK5YWZ1e3JAkl+9nMtmKUssy/ZQ
 yqA40XUsti3w89BOmTAe0Nq9OrjxYAewjwurtYgJaipb1T8YkKGw6B+0DD5PbDlnufehfg+X4bc
 IP6j5ViB0mQGcI6y7ARwsegZa2jE2vGWwLmxZWRmGqUEuHg+EYfhEHDWkK2CR6FsHqqryKbMkfE
 hqlfpskHv0NvlbKJL/bRj0CiM+GEfEIH3W/58ozEp5nA/he9rJdqDwnP+8EQxMb3ktoGRjcI2Jn
 +/K/vCSHtaDL9bj5lptV8yVS6ECAu
X-Google-Smtp-Source: AGHT+IFcrl5LWaDdwAFuWOLHgURIe6d03ve/2+fXA+BdXn406aClxbHvbzKUnSbU9wsQAJnd2SFRhA==
X-Received: by 2002:a05:6000:2dc2:b0:3eb:4681:acbc with SMTP id
 ffacd0b85a97d-3eb4681b0c9mr7037204f8f.23.1758046012120; 
 Tue, 16 Sep 2025 11:06:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/36] qtest/bios-tables-test: Add tests for legacy smmuv3 and
 smmuv3 device
Date: Tue, 16 Sep 2025 19:06:08 +0100
Message-ID: <20250916180611.1481266-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

For the legacy SMMUv3 test, the setup includes three PCIe Root Complexes,
one of which has bypass_iommu enabled. The generated IORT table contains
a single SMMUv3 node, a Root Complex(RC) node and 1 ITS node.
RC node features 4 ID mappings, of which 2 points to SMMU node and the
remaining ones points to ITS.

       pcie.0 -> {SMMU0} -> {ITS}
{RC}   pcie.1 -> {SMMU0} -> {ITS}
       pcie.2            -> {ITS}
       [all other ids]   -> {ITS}

For the -device arm-smmuv3,... test, the configuration also includes three
Root Complexes, with two connected to separate SMMUv3 devices.
The resulting IORT table contains 1 RC node, 2 SMMU nodes and 1 ITS node.
RC node features 4 ID mappings. 2 of them target the 2 SMMU nodes while
the others targets the ITS.

        pcie.0 -> {SMMU0} -> {ITS}
{RC}    pcie.1 -> {SMMU1} -> {ITS}
        pcie.2            -> {ITS}
        [all other ids]   -> {ITS}

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Message-id: 20250829082543.7680-11-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test.c | 86 ++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index e7e6926c816..4fa8ac5096a 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2337,6 +2337,86 @@ static void test_acpi_aarch64_virt_viot(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_smmuv3_legacy(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * MiB,
+    };
+
+    /*
+     * cdrom is plugged into scsi controller to avoid conflict
+     * with pxb-pcie. See comments in test_acpi_aarch64_virt_tcg_pxb() for
+     * details.
+     *
+     * The setup includes three PCIe root complexes, one of which has
+     * bypass_iommu enabled. The generated IORT table contains a single
+     * SMMUv3 node and a Root Complex node with three ID mappings. Two
+     * of the ID mappings have output references pointing to the SMMUv3
+     * node and the remaining one points to ITS.
+     */
+    data.variant = ".smmuv3-legacy";
+    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
+                  " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
+                  " -drive file="
+                  "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
+                  "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
+                  " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
+                  "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
+                  " -cpu cortex-a57"
+                  " -M iommu=smmuv3"
+                  " -device pxb-pcie,id=pcie.1,bus=pcie.0,bus_nr=0x10"
+                  " -device pxb-pcie,id=pcie.2,bus=pcie.0,bus_nr=0x20,bypass_iommu=on",
+                  &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_aarch64_virt_smmuv3_dev(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * MiB,
+    };
+
+    /*
+     * cdrom is plugged into scsi controller to avoid conflict
+     * with pxb-pcie. See comments in test_acpi_aarch64_virt_tcg_pxb()
+     * for details.
+     *
+     * The setup includes three PCie root complexes, two of which are
+     * connected to separate SMMUv3 devices. The resulting IORT table
+     * contains two SMMUv3 nodes and a Root Complex node with ID mappings
+     * of which two of the ID mappings have output references pointing
+     * to two different SMMUv3 nodes and the remaining ones pointing to
+     * ITS.
+     */
+    data.variant = ".smmuv3-dev";
+    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
+                  " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
+                  " -drive file="
+                  "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
+                  "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
+                  " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
+                  "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
+                  " -cpu cortex-a57"
+                  " -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0"
+                  " -device pxb-pcie,id=pcie.1,bus=pcie.0,bus_nr=0x10"
+                  " -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1"
+                  " -device pxb-pcie,id=pcie.2,bus=pcie.0,bus_nr=0x20",
+                  &data);
+    free_test_data(&data);
+}
+
 #ifndef _WIN32
 # define DEV_NULL "/dev/null"
 #else
@@ -2768,6 +2848,12 @@ int main(int argc, char *argv[])
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
+            qtest_add_func("acpi/virt/smmuv3-legacy",
+                           test_acpi_aarch64_virt_smmuv3_legacy);
+            if (qtest_has_device("arm-smmuv3")) {
+                qtest_add_func("acpi/virt/smmuv3-dev",
+                               test_acpi_aarch64_virt_smmuv3_dev);
+            }
         }
     } else if (strcmp(arch, "riscv64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
-- 
2.43.0


