Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A56C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 20:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVFHS-0000At-0Z; Fri, 27 Jun 2025 16:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVFHQ-0000Ah-KC
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:02:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVFHO-0006yz-8n
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:02:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so569772b3a.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 13:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751054552; x=1751659352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1CP3VFeutsQ8kdHBjH51SAo3wzrsLPxyX9v1ZUFaWTs=;
 b=FHLTFNCdbXk6q1T0mKPFRUpuTztIMOr3TFBstcqD5aUhglXPJlSvjIhl13AWaIqT+w
 KSpnihVz3cBB7pmSee2X8G4lr7scy8Fw7flcYCXncPz/rxkQMwn2MO2pwMZaARkz91PK
 puS4HwS0qAkeBwOgHzh11gEsPxVQ80KTc75N6qFmJcYPcxtgE6ogopEyYkR4dvGiMMuU
 gDufFuaBfRJU6wAM2nbilFJm027zvj7hoAyZeThF/o0GDjoxDY/EDMTgiJL3L5QXPMcy
 YGYKOX48JJTN3m+uLWFCTLRd6q54xjNaOO7/J4aOI3GeALz54baHChget0VqnlpzEIWR
 7Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751054552; x=1751659352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1CP3VFeutsQ8kdHBjH51SAo3wzrsLPxyX9v1ZUFaWTs=;
 b=lslpMYOHuBjrmflnfNCm8E4GvOYfNEdLi44GhZUTb7IM22e4nwKamlhpqgoUBanuG8
 E+TuBqV3TqTZcf6Gqdqho0lKX8GdCtPwdsnWG31XjWc0ClJjTiakcC2mJSLB6b1Gcwix
 xVL91bJcLTtrM2494WA1D9ukvynj/NSdQK4p5v+Prah2oPNQg4FtrPOdDrWtyk9HJX89
 ezIw400yl5ePSQ9mQYAm90H3V6c1ZM2lFFLyGGXlwOTqRSn2L/n6ySyBgTMPvAhdgFAk
 gYIQ24ggC8QKqFab3sQG5H7gZffOGukJ/4loCBFUXDTMmGICUJH2Sgs8m2l9qZ8jQXAH
 tmMQ==
X-Gm-Message-State: AOJu0Yy0zFX1h4p8bVccnElKZ5RwbAtiKUHPdDVFfS/9wh6Gi/rYnfTN
 UCtiONkX6MeBDN8X/5iko2riff0jN0849//j1mFQzvSvBtNUmIRcSwVOAxk7guNdzuMV9DrunVT
 vw2eV
X-Gm-Gg: ASbGncvvrs2O1NdcagjMwgKFpJ5Z9ynQpS/X9Biu/yqHGprvkkN+SVhlKCSA3shcvSS
 d0sB8JVm/Ia0DRlWua6hqkJnStr3GxRJ5ujPWRNl1oyF3zpD2kNqabqz3qISESIpgKXkasRi3X/
 QxwJcuUJh/SUcshcWwB1bd1LRpD7iZczzXNM7gqJ0cBOBqbw7hoNH6bXMzB/SX6YtkWTts9WqO5
 yqk6E0CdTYJwoCuXcygxL+cBFa4H18CweHTiF1ChowricceIP6sHfnCqJYfhw/8H/jHjmiKZ0qX
 HwMRgEjkOsjx30DGgjNqr64x3psRvEH1NfGovIZ4Oz6c9/Nk2vpbKxm687Q/zA==
X-Google-Smtp-Source: AGHT+IGJ5hHEY51jYzFz3THYYgIcXea1uHwbgOYiz03mHuCE6eauYj5vpcGORD7fJCox28DiMM+ZKQ==
X-Received: by 2002:a05:6a00:3a04:b0:740:5927:bb8b with SMTP id
 d2e1a72fcca58-74af6cc48ddmr5788798b3a.0.1751054551874; 
 Fri, 27 Jun 2025 13:02:31 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af540ae2bsm2713188b3a.26.2025.06.27.13.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 13:02:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com, jean-philippe@linaro.org,
 alex.bennee@linaro.org, eric.auger@redhat.com, smostafa@google.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] tests/functional: test device passthrough on aarch64
Date: Fri, 27 Jun 2025 13:02:22 -0700
Message-ID: <20250627200222.5172-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

This test allows to document and exercise device passthrough, using a
nested virtual machine setup. Two disks are generated and passed to the
VM, and their content is compared to original images.

Guest and nested guests commands are executed through two scripts, and
init used in both system is configured to trigger a kernel panic in case
any command fails. This is more reliable and readable than executing all
commands through prompt injection and trying to guess what failed.

Initially, this test was supposed to test smmuv3 nested emulation
(combining both stages of translation), but I could not find any setup
(kernel + vmm) able to do the passthrough correctly, despite several
tries.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/functional/meson.build                  |   2 +
 .../test_aarch64_device_passthrough.py        | 142 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100755 tests/functional/test_aarch64_device_passthrough.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 3021928a9d4..6cc78abb123 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -13,6 +13,7 @@ endif
 test_timeouts = {
   'aarch64_aspeed_ast2700' : 600,
   'aarch64_aspeed_ast2700fc' : 600,
+  'aarch64_device_passthrough' : 720,
   'aarch64_imx8mp_evk' : 240,
   'aarch64_raspi4' : 480,
   'aarch64_reverse_debug' : 180,
@@ -84,6 +85,7 @@ tests_aarch64_system_quick = [
 tests_aarch64_system_thorough = [
   'aarch64_aspeed_ast2700',
   'aarch64_aspeed_ast2700fc',
+  'aarch64_device_passthrough',
   'aarch64_imx8mp_evk',
   'aarch64_raspi3',
   'aarch64_raspi4',
diff --git a/tests/functional/test_aarch64_device_passthrough.py b/tests/functional/test_aarch64_device_passthrough.py
new file mode 100755
index 00000000000..1f3f158a9ff
--- /dev/null
+++ b/tests/functional/test_aarch64_device_passthrough.py
@@ -0,0 +1,142 @@
+#!/usr/bin/env python3
+#
+# Boots a nested guest and compare content of a device (passthrough) to a
+# reference image. Both vfio group and iommufd passthrough methods are tested.
+#
+# Copyright (c) 2025 Linaro Ltd.
+#
+# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command, wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from random import randbytes
+
+guest_script = '''
+#!/usr/bin/env bash
+
+set -euo pipefail
+set -x
+
+# find disks from nvme serial
+dev_vfio=$(lsblk --nvme | grep vfio | cut -f 1 -d ' ')
+dev_iommufd=$(lsblk --nvme | grep iommufd | cut -f 1 -d ' ')
+pci_vfio=$(basename $(readlink -f /sys/block/$dev_vfio/../../../))
+pci_iommufd=$(basename $(readlink -f /sys/block/$dev_iommufd/../../../))
+
+# bind disks to vfio
+for p in "$pci_vfio" "$pci_iommufd"; do
+    if [ "$(cat /sys/bus/pci/devices/$p/driver_override)" == vfio-pci ]; then
+        continue
+    fi
+    echo $p > /sys/bus/pci/drivers/nvme/unbind
+    echo vfio-pci > /sys/bus/pci/devices/$p/driver_override
+    echo $p > /sys/bus/pci/drivers/vfio-pci/bind
+done
+
+# boot nested guest and execute /host/nested_guest.sh
+# one disk is passed through vfio group, the other, through iommufd
+qemu-system-aarch64 \
+-M virt \
+-display none \
+-serial stdio \
+-cpu host \
+-enable-kvm \
+-m 1G \
+-kernel /host/Image.gz \
+-drive format=raw,file=/host/guest.ext4,if=virtio \
+-append "root=/dev/vda init=/init -- bash /host/nested_guest.sh" \
+-virtfs local,path=/host,mount_tag=host,security_model=mapped,readonly=off \
+-device vfio-pci,host=$pci_vfio \
+-object iommufd,id=iommufd0 \
+-device vfio-pci,host=$pci_iommufd,iommufd=iommufd0
+'''
+
+nested_guest_script = '''
+#!/usr/bin/env bash
+
+set -euo pipefail
+set -x
+
+image_vfio=/host/disk_vfio
+image_iommufd=/host/disk_iommufd
+
+dev_vfio=$(lsblk --nvme | grep vfio | cut -f 1 -d ' ')
+dev_iommufd=$(lsblk --nvme | grep iommufd | cut -f 1 -d ' ')
+
+# compare if devices are identical to original images
+diff $image_vfio /dev/$dev_vfio
+diff $image_iommufd /dev/$dev_iommufd
+
+echo device_passthrough_test_ok
+'''
+
+class Aarch64DevicePassthrough(QemuSystemTest):
+
+    # https://github.com/pbo-linaro/qemu-linux-stack
+    #
+    # Linux kernel is compiled with defconfig +
+    # IOMMUFD + VFIO_DEVICE_CDEV + ARM_SMMU_V3_IOMMUFD
+    # https://docs.kernel.org/driver-api/vfio.html#vfio-device-cde
+    ASSET_DEVICE_PASSTHROUGH_STACK = Asset(
+        ('https://fileserver.linaro.org/s/fx5DXxBYme8dw2G/'
+         'download/device_passthrough.tar.xz'),
+         '812750b664d61c2986f2b149939ae28cafbd60d53e9c7e4b16e97143845e196d')
+
+    # This tests the device passthrough implementation, by booting a VM
+    # supporting it with two nvme disks attached, and launching a nested VM
+    # reading their content.
+    def test_aarch64_device_passthrough(self):
+        self.set_machine('virt')
+        self.require_accelerator('tcg')
+
+        self.vm.set_console()
+
+        stack_path_tar_gz = self.ASSET_DEVICE_PASSTHROUGH_STACK.fetch()
+        self.archive_extract(stack_path_tar_gz, format="tar")
+
+        stack = self.scratch_file('out')
+        kernel = os.path.join(stack, 'Image.gz')
+        rootfs_host = os.path.join(stack, 'host.ext4')
+        disk_vfio = os.path.join(stack, 'disk_vfio')
+        disk_iommufd = os.path.join(stack, 'disk_iommufd')
+        guest_cmd = os.path.join(stack, 'guest.sh')
+        nested_guest_cmd = os.path.join(stack, 'nested_guest.sh')
+        # we generate two random disks
+        with open(disk_vfio, "wb") as d: d.write(randbytes(512))
+        with open(disk_iommufd, "wb") as d: d.write(randbytes(1024))
+        with open(guest_cmd, 'w') as s: s.write(guest_script)
+        with open(nested_guest_cmd, 'w') as s: s.write(nested_guest_script)
+
+        self.vm.add_args('-cpu', 'max')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-M', 'virt,'
+                         'virtualization=on,'
+                         'gic-version=max,'
+                         'iommu=smmuv3')
+        self.vm.add_args('-kernel', kernel)
+        self.vm.add_args('-drive', f'format=raw,file={rootfs_host}')
+        self.vm.add_args('-drive',
+                         f'file={disk_vfio},if=none,id=vfio,format=raw')
+        self.vm.add_args('-device', 'nvme,serial=vfio,drive=vfio')
+        self.vm.add_args('-drive',
+                         f'file={disk_iommufd},if=none,id=iommufd,format=raw')
+        self.vm.add_args('-device', 'nvme,serial=iommufd,drive=iommufd')
+        self.vm.add_args('-virtfs',
+                         f'local,path={stack}/,mount_tag=host,'
+                         'security_model=mapped,readonly=off')
+        # boot and execute guest script
+        # init will trigger a kernel panic if script fails
+        self.vm.add_args('-append',
+                         'root=/dev/vda init=/init -- bash /host/guest.sh')
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'device_passthrough_test_ok',
+                                 failure_message='Kernel panic')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.47.2


