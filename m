Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D666C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAdU-0006Fd-TQ; Tue, 12 Mar 2024 18:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcQ-0002te-KK
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcF-0004ck-85
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hNPO4kQBGY7YaJZTv5HNb+C3+l45QRRRyhlniT9lFxI=;
 b=K6PrVm6fQNfKcLi05X4SvFLWFddKg8Kdk54zKQmj+4SK8JUpn6fklc72f+Rgq6uvQJVd0K
 FsDdwUh57hjEYtooewrx00B0ZypEAuD0rD1H7MkXHaVxRtzMl63heBwWo9x1YGTvVOHvVa
 ZP7CE9aJaV3VMmCkMtAjvJgbIa7BC0U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-lZBMGBbvMEaxQ6igJ6Y3Lw-1; Tue, 12 Mar 2024 18:28:57 -0400
X-MC-Unique: lZBMGBbvMEaxQ6igJ6Y3Lw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a449be9db59so337138566b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282536; x=1710887336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNPO4kQBGY7YaJZTv5HNb+C3+l45QRRRyhlniT9lFxI=;
 b=ElDKVBhdiOSDihYsmJ5KSTxiw+sgHX7nezyW3997KGHMcDEOvLZADoKFPsJzpSnKmV
 B4k5pe930rqRGjid26nq8V/pJqtpYL3WfePxmkSk+U0yZBjkFgi34d0tXYr5GC79Ahty
 6swdZOPbbaP5kNuuWo6/2gyLpTEPPOJeHWNogne1Be5U2M2ObYC72MNQ1n3Zimsh9Jf2
 c2GDP9FRslWSaP3ADL0wSo/1cFYSooTYLrKpjZP2NwYDYjGBHcd/c6Py5udia89Tev7+
 oHenftDyv/nE7Ih1Alh3eklcGq9DBycmxrBKnPnN8pUq+Ig7vuWCXG5owojbuAoVZpm5
 F9/Q==
X-Gm-Message-State: AOJu0YzhlhPPOX9zZrBttrHNwVYiJEmahG2Ac3S4NGqGGqs4YEDUCoY7
 VCYTPFyP+UMlqGYAiECnMzJaEgfMnHqqB5a05iKLEqixPNKzcQ3KhdkgVp6piNcjYeP1QiP9w9H
 z1s23/hYa9UKTuULFMfA1jkBTnsj6j9dfOBCubPGBX+Tz9qDwbhcWMr1ZglT4g3xc+Zd2P1yZ4W
 swexL909Eo62d9WY7jOGInR11YlQ8WlC5S
X-Received: by 2002:a17:906:a013:b0:a46:2e54:43fb with SMTP id
 p19-20020a170906a01300b00a462e5443fbmr3773299ejy.70.1710282535760; 
 Tue, 12 Mar 2024 15:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAiURKDqc1NjT/2fHPHap0y/SwUUkVa+5iK/x5vmihfCzWhY/ICm2JQWBhOJKJtVDeuPc41g==
X-Received: by 2002:a17:906:a013:b0:a46:2e54:43fb with SMTP id
 p19-20020a170906a01300b00a462e5443fbmr3773281ejy.70.1710282535147; 
 Tue, 12 Mar 2024 15:28:55 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 dn18-20020a17090794d200b00a45f545beeesm4219220ejc.122.2024.03.12.15.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:54 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 62/68] hw/i386/q35: Set virtio-iommu aw-bits default value to 39
Message-ID: <9b588be373ad01e7ce09e25f69f66b811af0b799.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Currently the default input range can extend to 64 bits. On x86,
when the virtio-iommu protects vfio devices, the physical iommu
may support only 39 bits. Let's set the default to 39, as done
for the intel-iommu.

We use hw_compat_8_2 to handle the compatibility for machines
before 9.0 which used to have a virtio-iommu default input range
of 64 bits.

Of course if aw-bits is set from the command line, the default
is overriden.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240307134445.92296-8-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/core/machine.c               | 1 +
 hw/i386/pc_q35.c                | 9 +++++++++
 tests/qtest/virtio-iommu-test.c | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6bd09d4592..4b89172d1c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -35,6 +35,7 @@
 
 GlobalProperty hw_compat_8_2[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
+    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
 };
 const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1356c5d107..8a427c4647 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -45,6 +45,7 @@
 #include "hw/i386/pc.h"
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
+#include "hw/virtio/virtio-iommu.h"
 #include "hw/display/ramfb.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
@@ -63,6 +64,12 @@
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
 
+static GlobalProperty pc_q35_compat_defaults[] = {
+    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
+};
+static const size_t pc_q35_compat_defaults_len =
+    G_N_ELEMENTS(pc_q35_compat_defaults);
+
 struct ehci_companions {
     const char *name;
     int func;
@@ -354,6 +361,8 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
+    compat_props_add(m->compat_props,
+                     pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
 static void pc_q35_9_0_machine_options(MachineClass *m)
diff --git a/tests/qtest/virtio-iommu-test.c b/tests/qtest/virtio-iommu-test.c
index 068e7a9e6c..afb225971d 100644
--- a/tests/qtest/virtio-iommu-test.c
+++ b/tests/qtest/virtio-iommu-test.c
@@ -34,7 +34,7 @@ static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
     uint8_t bypass = qvirtio_config_readb(dev, 36);
 
     g_assert_cmpint(input_range_start, ==, 0);
-    g_assert_cmphex(input_range_end, ==, UINT64_MAX);
+    g_assert_cmphex(input_range_end, >=, UINT32_MAX);
     g_assert_cmpint(domain_range_start, ==, 0);
     g_assert_cmpint(domain_range_end, ==, UINT32_MAX);
     g_assert_cmpint(bypass, ==, 1);
-- 
MST


