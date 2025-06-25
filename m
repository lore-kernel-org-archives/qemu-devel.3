Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96A2C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 21:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUXxB-0005YV-Lf; Wed, 25 Jun 2025 17:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUXxA-0005Y5-4A
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 17:46:48 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUXx8-0005UL-0Y
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 17:46:47 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3122368d7cfso243567a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750888003; x=1751492803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X0Hachg+K9xKjdYKIMHKGq2PMHMa+phMyYUxIczfxzk=;
 b=VJjp1xkGXb/GegvqqAT560LXwSrdx1Z0T9qZ1zTsxGpFlylna8/DJVf76M253NLFNN
 ls8EIw3GqI/ff/lyyy+Kg3SWM0u7Tyw8QVbAZ+MnnGtSiae7NERtV/WXDgz2SVMXl+nu
 Bhq/Y/bhOW3k7b2qy46DqVC+EttNdfSRswSQ5oJMsL/2bgK4QUK44rFxQ2+Q6lmY4zsV
 tvhYGVkDGK25yxfFrsyMwzkzZjSBleZy4P4wa7px1OEI7j0KCYhDM9GRWAZlKMqCgW1/
 4nQ9rTmdFABMvI2u97BECpqRHa/CGVm4Uqj3/PHU0gUSzVqkfi6NrNYETiYQ6XlgInOV
 Rq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750888003; x=1751492803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X0Hachg+K9xKjdYKIMHKGq2PMHMa+phMyYUxIczfxzk=;
 b=YnEbllTLk12DpjtRgGSBYiy5/QcJrSpO6sQ3HVJV+S6yCDFeW5LMPJM8eXqiWiEmwJ
 8165Igtcl2mOHcvwEBaLGd/d6faPtEADJM5xa/d5w3OYPriwAaUXAYCiFEtP29Nt4WfK
 YZ7UaRWIq4tO670jbr+Z2rCWM9u+tY10gY8bWTMzPF9wcu3NmYrYb2lJ19ZCRfLsVhBy
 bpl1KwuCgoHSFjsW/mDWGDiq5nHajyzdC7jIgpKULVvb63JJvbP75+9VeI56gDp5hhLS
 5zkmSigaR55nRnU6FfH9QwbWt10aqmXQ4S4Epir0goxc4LuLd8ZM6IOspgW4pGFzwlaZ
 xpaA==
X-Gm-Message-State: AOJu0YydphPRwP+nI7otETjXzoM7xbDGNfy/zKqxBWn/NxqVJUKD8DVy
 BlJz31lRMH3jMaCltLjk9gIkO3ihSaTu8OeznvmQpFAoWUaJqaK0tMO8q6m2YyR6dKr4M55tv4b
 WRty0xKw=
X-Gm-Gg: ASbGncutk9kN3Ap+Eb/ubTY4+ZE96KhrMyI5E/ugcbckxxqd5eTYvj2uyHKluvHrFTu
 cEfk9yQNWERiv8mUz/oEfi7tK/8Lu/4d3pJjKhiNU+BEMtB9b4eXmYjSghWeyM/0d20HINiWDSb
 lfOl4X8tijIhY/JGvJA37rdaAYHBj7q0tES/f1soBJMMG4kDHCD/buhQZLV+rMxe5abcGA0sgsU
 bWRIz7WcS3Foxml/xt52ySQ/rL7kIABK9aVgmqVEAhwjOJt5TCmw0IqeXKFpq8aGQm2DrYxEHcw
 fkNna+14NtM6RPqtlQ5owwxtJ0lDYCqJ+auduVGDpVB5z4hArwkUt0NQPwCdew==
X-Google-Smtp-Source: AGHT+IFrwu6xTCheWSmCzhJBVO0pPeIz1PUbhi+fo1kzUeLWQbMC2dtX6JiQg2raVBkl3aiQIWWIWw==
X-Received: by 2002:a17:90b:1848:b0:313:f9fc:7213 with SMTP id
 98e67ed59e1d1-315f269adecmr5899006a91.21.1750888003020; 
 Wed, 25 Jun 2025 14:46:43 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f51d7913sm2508313a91.0.2025.06.25.14.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 14:46:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, smostafa@google.com, berrange@redhat.com,
 jean-philippe@linaro.org, eric.auger@redhat.com, alex.bennee@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] tests/functional: Test device passthrough on aarch64
Date: Wed, 25 Jun 2025 14:46:33 -0700
Message-ID: <20250625214633.939709-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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
index 00000000000..4e7587584fc
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
+    echo $p > /sys/bus/pci/drivers/nvme/unbind || bash
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
+-kernel /host/Image \
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
+        ('https://fileserver.linaro.org/s/smKfzEFfGqRWPzg/'
+         'download/device-passthrough-stack.tar.gz'),
+         'a954926019dab45e5de7a45e5abd263784307851afb1fd4e2fee57c769018aeb')
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
+        kernel = os.path.join(stack, 'Image')
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


