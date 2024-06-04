Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9A6C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 14:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVNt-0003dl-LH; Tue, 04 Jun 2024 10:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEVNr-0003d2-9S
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEVNp-0008Tw-FZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717512208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MljoZq4BH8QxLlBqtWXVKGqv4ZMUGgELH/ir9Z89O2U=;
 b=Czx/HoTVWTG4UbJ9X6ndqhuHYkNOZ9qwNS82ZOUhjVW4p7xOtoeYFmYOs80Q9dBFIBCTQB
 LTn3dUnoWvLuQwXgbcDv7baz27FPHr3llsO2Xx6Y4ZHlV3yFeEUdtO5lJSfTeBNeCP3jzg
 0w9Gh70VaIV8JcUCAqy3cGXPi/hLh/w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-3se5XxUJNLG2KMiP_InRMw-1; Tue, 04 Jun 2024 10:43:26 -0400
X-MC-Unique: 3se5XxUJNLG2KMiP_InRMw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a68c70ab413so298459366b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717512204; x=1718117004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MljoZq4BH8QxLlBqtWXVKGqv4ZMUGgELH/ir9Z89O2U=;
 b=hhk3KqUo29uHLFNH5ElDEbZ6nXxf1oek3oreCYVUgh1TjWYbDbCUTZaGuvBhH6V/Ro
 EhowrZUw319ZqnGVbxSmmolIlWfU+ZbHSvHAEgL4S+MkpllNZ3p2CwgC9RJP8o1/z6Cv
 jX9F5BOyd1e/ZQ23bCYQQ5vhq042+c1yCgPpTSgrClBAYYmvm0PdzbOC/L7L2uHwJfjs
 V9Vsm7WboXuxf5x4eMvO1ah+D47k99iQ33XATtQNeDvzNs3ZFvhLFzlPgl9KZN7v0Qrv
 DC1gllJ4WsZ3oFJXekwoTCM3npOtUeZ3tFRwRsjXybk5zIu/OAVHF4HEdaj2UYuDN4Cp
 5qew==
X-Gm-Message-State: AOJu0Yw5wnRysz0L0vpDYDCpHIB55d2s86bMyddOo0tztYMzTprNPdWW
 zNGaCagkLjnRY4azoJPY2TSOj/3fUC2taSyMrKAuuydMq54KUI3DPq8G149rGW52D+aa6m4w9r6
 2LIzAqsS/9jF1W0QtO1s7s3fhls4cyP15gKBtjj/BKvTQXv+c7YNQfZmfDCRujzJekWQgN+uSVP
 HwgfvDub2SwsJoIyTeS0cIC791ddWP7DYnb44V
X-Received: by 2002:a17:906:1919:b0:a66:4045:2c52 with SMTP id
 a640c23a62f3a-a695441f1ccmr206653866b.28.1717512204552; 
 Tue, 04 Jun 2024 07:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0VAy0cSj3CRhfb6/CRki8ckd1Hg2EIIEacizAPns/Pd28gKUbmpALy9Mz72usRS8KAoaoqQ==
X-Received: by 2002:a17:906:1919:b0:a66:4045:2c52 with SMTP id
 a640c23a62f3a-a695441f1ccmr206651966b.28.1717512204001; 
 Tue, 04 Jun 2024 07:43:24 -0700 (PDT)
Received: from [192.168.10.116] ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a690d29f52csm294503166b.44.2024.06.04.07.43.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 07:43:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs, tests: do not specify scsi=off for virtio-blk-pci
Date: Tue,  4 Jun 2024 16:43:20 +0200
Message-ID: <20240604144320.1044464-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This has been the default forever.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/pci_expander_bridge.txt      | 2 +-
 docs/specs/tpm.rst                | 2 +-
 tests/avocado/intel_iommu.py      | 2 +-
 tests/avocado/smmu.py             | 2 +-
 tests/avocado/tuxrun_baselines.py | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/pci_expander_bridge.txt b/docs/pci_expander_bridge.txt
index 36750273bb8..540191f5e04 100644
--- a/docs/pci_expander_bridge.txt
+++ b/docs/pci_expander_bridge.txt
@@ -25,7 +25,7 @@ A detailed command line would be:
 -object memory-backend-ram,size=1024M,policy=bind,host-nodes=1,id=ram-node1 -numa node,nodeid=1,cpus=1,memdev=ram-node1
 -device pxb,id=bridge1,bus=pci.0,numa_node=1,bus_nr=4 -netdev user,id=nd -device e1000,bus=bridge1,addr=0x4,netdev=nd
 -device pxb,id=bridge2,bus=pci.0,numa_node=0,bus_nr=8 -device e1000,bus=bridge2,addr=0x3
--device pxb,id=bridge3,bus=pci.0,bus_nr=40 -drive if=none,id=drive0,file=[img] -device virtio-blk-pci,drive=drive0,scsi=off,bus=bridge3,addr=1
+-device pxb,id=bridge3,bus=pci.0,bus_nr=40 -drive if=none,id=drive0,file=[img] -device virtio-blk-pci,drive=drive0,bus=bridge3,addr=1
 
 Here you have:
  - 2 NUMA nodes for the guest, 0 and 1. (both mapped to the same NUMA node in host, but you can and should put it in different host NUMA nodes)
diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 68cb8cf7e65..1ad36ad7099 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -336,7 +336,7 @@ In case a pSeries machine is emulated, use the following command line:
     -tpmdev emulator,id=tpm0,chardev=chrtpm \
     -device tpm-spapr,tpmdev=tpm0 \
     -device spapr-vscsi,id=scsi0,reg=0x00002000 \
-    -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x3,drive=drive-virtio-disk0,id=virtio-disk0 \
+    -device virtio-blk-pci,bus=pci.0,addr=0x3,drive=drive-virtio-disk0,id=virtio-disk0 \
     -drive file=test.img,format=raw,if=none,id=drive-virtio-disk0
 
 In case an Arm virt machine is emulated, use the following command line:
diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
index f04ee1cf9d9..09e694bd403 100644
--- a/tests/avocado/intel_iommu.py
+++ b/tests/avocado/intel_iommu.py
@@ -32,7 +32,7 @@ class IntelIOMMU(LinuxTest):
 
     def set_up_boot(self):
         path = self.download_boot()
-        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,scsi=off,' +
+        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
                          'drive=drv0,id=virtio-disk0,bootindex=1,'
                          'werror=stop,rerror=stop' + self.IOMMU_ADDON)
         self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
diff --git a/tests/avocado/smmu.py b/tests/avocado/smmu.py
index 21ff030ca72..4ebfa7128c7 100644
--- a/tests/avocado/smmu.py
+++ b/tests/avocado/smmu.py
@@ -32,7 +32,7 @@ class SMMU(LinuxTest):
 
     def set_up_boot(self):
         path = self.download_boot()
-        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,scsi=off,' +
+        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
                          'drive=drv0,id=virtio-disk0,bootindex=1,'
                          'werror=stop,rerror=stop' + self.IOMMU_ADDON)
         self.vm.add_args('-drive',
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index a936a3b7809..736e4aa289c 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -235,7 +235,7 @@ def ppc64_common_tuxrun(self, sums, prefix):
             self.vm.add_args('-drive', 'file=' + qcow2.name +
                          ',format=qcow2,if=none,id='
                          'drive-virtio-disk1',
-                         '-device', 'virtio-blk-pci,scsi=off,bus=pci.0,'
+                         '-device', 'virtio-blk-pci,bus=pci.0,'
                          'addr=0xb,drive=drive-virtio-disk1,id=virtio-disk1'
                          ',bootindex=2')
             self.common_tuxrun(csums=sums, drive="scsi-hd")
-- 
2.45.1


