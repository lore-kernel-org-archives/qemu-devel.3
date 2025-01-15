Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567A8C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7rn-0003sR-In; Wed, 15 Jan 2025 13:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7q0-00076z-PJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7py-0006h6-E2
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Utl+OxasX6fue59CsOg8gVr62uZ9JLK5ALR2hXp0wVc=;
 b=DKGhusBa7RjoG/0zWiQkaTmFiADfbtiP3sbSQARohYp+FTC/kODohiANOcsYChyFP6QFP2
 D+3ngruXsTOfIys6BNd1gAJ+CQPnYY/BG/qyOJdfShUNX8VDEy/rLH6nrIRgCzTlj1ZHgT
 06x99i1z6PTTfr+GWCDqqt3GeTCrdds=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-kdr7SepoPIiAvKYVuq6OmA-1; Wed, 15 Jan 2025 13:09:52 -0500
X-MC-Unique: kdr7SepoPIiAvKYVuq6OmA-1
X-Mimecast-MFC-AGG-ID: kdr7SepoPIiAvKYVuq6OmA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so39258925e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964591; x=1737569391;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Utl+OxasX6fue59CsOg8gVr62uZ9JLK5ALR2hXp0wVc=;
 b=ohCzpUILvX5sTSk64M3ZswM8OpenM04jwVzjYzvRpvnl1r1yFNZkRFeb2pPpZl0PG7
 j1P4jnXSaxO9Sj8KpTYhZocQ3SmCGXNm4qcYuvEhF788oSnLdz2Ni7/XzOMcFRvRmZyu
 bHqZxbhbs/soT4LJapehK/8yjJ/uYz/bu3IN/VLke2lIQT7wFVS91Cv+b3Qm3dpnE7Hj
 YrcFfX+gfOXuLCbSA0WQaIL80siWkFsnPpEsY6QPeOXOIf2oZuXOD04SkB36IqrabQRc
 1sXpgLkZNiRK0x2EcsKtrVCT2RORqy3B1F1Hqt4jsSosW2xvlHUrH7GbINdx+UMpF+ZU
 5DGQ==
X-Gm-Message-State: AOJu0YwPyCRM80ReCEVEu5+1XoRYC2hSRXYDkf/rBvfuVoEEz5oDWPJF
 vizhooMf8VYdUKZTLKkWPPQdJ4WWXonp1vC8rUypuN0I3ykS5Qnmp4VOJL8nSW+Cc3l2fJk0TX/
 ZxDWiXevk6Ic+j00n+49A7eP3sZa2CZ85j85gEKDTZlzkqX1LjOdyiKL8H/GNZ2TLOfk7+fmaXA
 Zx1a7Kr87pE3LtmAT1TxE+5VZ8JnnQZQ==
X-Gm-Gg: ASbGnctMrat1URZ3Wrlc47lrUlewPahCKTEcSXtTLlyi1BM5a6zbvPRyYJitQPnKmGz
 Z4Hb/B11I1Y2Hd2zQo029P9Sm1OZ3EP9NxIA2ENhQJkofQ3+XsRMcv59uRMkLF7zkM6P1E2dyGi
 cVbFKIgdX1sZuXsKGg4nm/ezucT/2lcc6QTEQjfRcdDmfjreaHMsXaEGwGiyjrm5AZLcvTZwjpI
 dbQKOBuBF+wegnAn9FIJPHfXeye16vt/nby5CSiuQeGA/ZhOo0Y
X-Received: by 2002:a05:600c:5125:b0:434:eb73:b0c0 with SMTP id
 5b1f17b1804b1-436e266f994mr308196255e9.5.1736964591028; 
 Wed, 15 Jan 2025 10:09:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXa3m7zzPj005EoNBu8kHSWDeQuicEbzxPasdw01/usLnXGJeoJdba3feMu6rDusDkNorIKg==
X-Received: by 2002:a05:600c:5125:b0:434:eb73:b0c0 with SMTP id
 5b1f17b1804b1-436e266f994mr308195935e9.5.1736964590617; 
 Wed, 15 Jan 2025 10:09:50 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ab449sm31397065e9.10.2025.01.15.10.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:49 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 25/48] tests/qtest: Add intel-iommu test
Message-ID: <2c746dfe1c69896b0e434d37efe014654f0a3a65.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Add the framework to test the intel-iommu device.

Currently only tested cap/ecap bits correctness when x-flts=on in scalable
mode. Also tested cap/ecap bits consistency before and after system reset.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20241212083757.605022-21-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/intel_iommu.h  |  1 +
 tests/qtest/intel-iommu-test.c | 64 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                    |  1 +
 tests/qtest/meson.build        |  1 +
 4 files changed, 67 insertions(+)
 create mode 100644 tests/qtest/intel-iommu-test.c

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 9e92bffd5a..e95477e855 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -47,6 +47,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
 #define VTD_HOST_AW_48BIT           48
 #define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_48BIT
 #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
+#define VTD_MGAW_FROM_CAP(cap)      ((cap >> 16) & 0x3fULL)
 
 #define DMAR_REPORT_F_INTR          (1)
 
diff --git a/tests/qtest/intel-iommu-test.c b/tests/qtest/intel-iommu-test.c
new file mode 100644
index 0000000000..c521b3796e
--- /dev/null
+++ b/tests/qtest/intel-iommu-test.c
@@ -0,0 +1,64 @@
+/*
+ * QTest testcase for intel-iommu
+ *
+ * Copyright (c) 2024 Intel, Inc.
+ *
+ * Author: Zhenzhong Duan <zhenzhong.duan@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/i386/intel_iommu_internal.h"
+
+#define CAP_STAGE_1_FIXED1    (VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | \
+                              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS)
+#define ECAP_STAGE_1_FIXED1   (VTD_ECAP_QI |  VTD_ECAP_IR | VTD_ECAP_IRO | \
+                              VTD_ECAP_MHMV | VTD_ECAP_SMTS | VTD_ECAP_FLTS)
+
+static inline uint64_t vtd_reg_readq(QTestState *s, uint64_t offset)
+{
+    return qtest_readq(s, Q35_HOST_BRIDGE_IOMMU_ADDR + offset);
+}
+
+static void test_intel_iommu_stage_1(void)
+{
+    uint8_t init_csr[DMAR_REG_SIZE];     /* register values */
+    uint8_t post_reset_csr[DMAR_REG_SIZE];     /* register values */
+    uint64_t cap, ecap, tmp;
+    QTestState *s;
+
+    s = qtest_init("-M q35 -device intel-iommu,x-scalable-mode=on,x-flts=on");
+
+    cap = vtd_reg_readq(s, DMAR_CAP_REG);
+    g_assert((cap & CAP_STAGE_1_FIXED1) == CAP_STAGE_1_FIXED1);
+
+    tmp = cap & VTD_CAP_SAGAW_MASK;
+    g_assert(tmp == (VTD_CAP_SAGAW_39bit | VTD_CAP_SAGAW_48bit));
+
+    tmp = VTD_MGAW_FROM_CAP(cap);
+    g_assert(tmp == VTD_HOST_AW_48BIT - 1);
+
+    ecap = vtd_reg_readq(s, DMAR_ECAP_REG);
+    g_assert((ecap & ECAP_STAGE_1_FIXED1) == ECAP_STAGE_1_FIXED1);
+
+    qtest_memread(s, Q35_HOST_BRIDGE_IOMMU_ADDR, init_csr, DMAR_REG_SIZE);
+
+    qobject_unref(qtest_qmp(s, "{ 'execute': 'system_reset' }"));
+    qtest_qmp_eventwait(s, "RESET");
+
+    qtest_memread(s, Q35_HOST_BRIDGE_IOMMU_ADDR, post_reset_csr, DMAR_REG_SIZE);
+    /* Ensure registers are consistent after hard reset */
+    g_assert(!memcmp(init_csr, post_reset_csr, DMAR_REG_SIZE));
+
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/q35/intel-iommu/stage-1", test_intel_iommu_stage_1);
+
+    return g_test_run();
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 8b9d9a7cac..a928ce3e41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3711,6 +3711,7 @@ F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
 F: include/hw/i386/intel_iommu.h
 F: tests/functional/test_intel_iommu.py
+F: tests/qtest/intel-iommu-test.c
 
 AMD-Vi Emulation
 S: Orphan
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index bf4d5c268b..edd53ec995 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -93,6 +93,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
   (host_os != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
-- 
MST


