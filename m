Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A0EE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 17:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCuY-0002oc-PV; Tue, 07 Jan 2025 11:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCu3-0002AE-TM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:58:05 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCtx-0006ux-7Y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:58:03 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso11745610f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736269075; x=1736873875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFfG/GhyJtenhyLEVTE3AVP5mUk8/FfquvKMuCtf9bQ=;
 b=v+LKh1mpX0aUlJ5kD3m/Yfpjrk18zEu03oCIxC/i1M2NdMZEwnSTdhql5EcN41JESH
 gxFL462q91sFmC4lZFIUZCF17/TF5KVDS5hWoGP6bjAJP3ojVfEItaknCcGDrlOIR4Gw
 hmnPhKRggXcPDFg0SRAQ18RWoHBZ85/3U+0qF8cjsHexDnVdS56cSQLN4UTszB5Tok/F
 NDTxvcxg+MmK477zSF4HHRM7et3L83+WHSXMHOvbslrDfa7uErFzrOnGLr7ZDeWhR7hc
 7qyFTl/E1WhLGVXdq0s7fI26J6NCxjJiqDdgS0SJO0wls3idmWBtWAEwIwxddkgNjYJK
 soJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736269075; x=1736873875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFfG/GhyJtenhyLEVTE3AVP5mUk8/FfquvKMuCtf9bQ=;
 b=aY/j/QDFeg8OBnohpcbp291mwKDED9udmZ5z415l8wtNOkXZg0WHJ/OGCE3NzYuC25
 ECuizeykCy8odszvu/NwrLGiKdhCRHfU1wzAk7FvWh9TaXYewIPijk285DvIJnkFTOgf
 nPL55igMXmQgOwnhCfwRpUZGq5EC5NyCFe9oosPA1zPvZQRHaiKD/a+mEiSqScWArcbc
 eMB4YcgCf94m2zpzSy46rChJzxJhM7iV+2uqOt4x/Ul/FNttnEVVLufmx3nHeknMBnxU
 4Ch7uTWlzu4aryHzuGCPR/s3kV0lAB/h1Q3rBQvfCqdcgZPvNuRklrkHXVafm+X0NjWg
 2fCw==
X-Gm-Message-State: AOJu0YzVZnxjODFr9NcJ3FDxRFU9Jp6tlixVx7FGUulFI7SfFv5NQynL
 z8FI1ZYKeLikQBShebRHdw2gzEWZvBOhbDqEJiGwWY8eh8ePqez2RAfZrlZQl6c=
X-Gm-Gg: ASbGncvcqC99IhuJ9LWWY+o0387fVOMiRf9F3++LOUfhiAs8bs+UXmDnmtvr+wSRr/y
 aiGJ0am8Tb/PM+KP87AhNCltSA5nxvAikB1pEhDFZHIgsYTJbWNV1g7bHoyxzPHDQFBd34aXjWy
 GCiwLhQrFJD7ZNMDS5rTWaZmHH8qcZjBbXrRCqC8Amuwvq0oNFlaPhBOUQtQ5zhoghosBbzxkeD
 lzKuduU7y5P8SO+fXdcmdw8qmx9KPSr8S1nmQ5wUTVYbgEdtANim0c=
X-Google-Smtp-Source: AGHT+IE3ohtUbgRkaCW6ztb9H0NCoIYXv9QnP50PvzDAGEDJXZLSpd7/OQoX8BbLH2HoVO0GfGRyOw==
X-Received: by 2002:a05:6000:4816:b0:386:37af:dd9a with SMTP id
 ffacd0b85a97d-38a22201ac8mr57952980f8f.35.1736269075441; 
 Tue, 07 Jan 2025 08:57:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c829015sm50843202f8f.13.2025.01.07.08.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:57:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D2DEB5FD97;
 Tue,  7 Jan 2025 16:52:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Beraldo Leal <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Weiwei Li <liwei1518@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 20/29] tests/functional: extend test_aarch64_virt with
 vulkan test
Date: Tue,  7 Jan 2025 16:51:58 +0000
Message-Id: <20250107165208.743958-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107165208.743958-1-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Now we have virtio-gpu Vulkan support lets add a test for it.
Currently this is using images build by buildroot:

  https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.html

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use decorator for has_cmd(zstd)
  - un-handled->unhandled
  - drop extra - from --snapshot
  - drop unneeded virtualization=on
  - only show 1s of each scene
  - fix long lines
v3
  - move set_machine/require_accelerator to top of test
  - use uncompress utility function
  - remove extra ()'s from ASSETS
---
 tests/functional/test_aarch64_virt.py | 84 +++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 2d9995a95d..bb68048537 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -13,11 +13,14 @@
 import logging
 from subprocess import check_call, DEVNULL
 
+from qemu.machine.machine import VMLaunchFailure
+
+from qemu_test import BUILD_DIR
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
 from qemu_test import get_qemu_img
-
+from qemu_test import skipIfMissingCommands, get_qemu_img
 
 class Aarch64VirtMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
@@ -73,15 +76,16 @@ def common_aarch64_virt(self, machine):
         Common code to launch basic virt machine with kernel+initrd
         and a scratch disk.
         """
+        self.set_machine('virt')
+        self.require_accelerator("tcg")
+
         logger = logging.getLogger('aarch64_virt')
 
         kernel_path = self.ASSET_KERNEL.fetch()
 
-        self.set_machine('virt')
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyAMA0')
-        self.require_accelerator("tcg")
         self.vm.add_args('-cpu', 'max,pauth-impdef=on',
                          '-machine', machine,
                          '-accel', 'tcg',
@@ -102,7 +106,9 @@ def common_aarch64_virt(self, machine):
 
         # Add the device
         self.vm.add_args('-blockdev',
-                         f"driver=qcow2,file.driver=file,file.filename={image_path},node-name=scratch")
+                         "driver=qcow2,file."
+                         "driver=file,file."
+                         f"filename={image_path},node-name=scratch")
         self.vm.add_args('-device',
                          'virtio-blk-device,drive=scratch')
 
@@ -131,5 +137,73 @@ def test_aarch64_virt_gicv2(self):
         self.common_aarch64_virt("virt,gic-version=2")
 
 
+    ASSET_VIRT_GPU_KERNEL = Asset(
+        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
+        'download?path=%2F&files='
+        'Image',
+        '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462f6')
+
+    ASSET_VIRT_GPU_ROOTFS = Asset(
+        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
+        'download?path=%2F&files='
+        'rootfs.ext4.zstd',
+        '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
+
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_gpu(self):
+        # This tests boots with a buildroot test image that contains
+        # vkmark and other GPU exercising tools. We run a headless
+        # weston that nevertheless still exercises the virtio-gpu
+        # backend.
+
+        self.set_machine('virt')
+        self.require_accelerator("tcg")
+
+        kernel_path = self.ASSET_VIRT_GPU_KERNEL.fetch()
+        image_path = self.uncompress(self.ASSET_VIRT_GPU_ROOTFS, format="zstd")
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0 root=/dev/vda')
+
+        self.vm.add_args("-accel", "tcg")
+        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=on")
+        self.vm.add_args("-machine", "virt,gic-version=max",
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.add_args("-smp", "2", "-m", "2048")
+        self.vm.add_args("-device",
+                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
+        self.vm.add_args("-display", "egl-headless")
+        self.vm.add_args("-display", "dbus,gl=on")
+        self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
+        self.vm.add_args("-blockdev",
+                         "driver=raw,file.driver=file,"
+                         "node-name=hd0,read-only=on,"
+                         f"file.filename={image_path}")
+        self.vm.add_args("-snapshot")
+
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as excp:
+            if "old virglrenderer, blob resources unsupported" in excp.output:
+                self.skipTest("No blob support for virtio-gpu")
+            elif "old virglrenderer, venus unsupported" in excp.output:
+                self.skipTest("No venus support for virtio-gpu")
+            else:
+                self.log.info("unhandled launch failure: {excp.output}")
+                raise excp
+
+        self.wait_for_console_pattern('buildroot login:')
+        exec_command(self, 'root')
+        exec_command(self, 'export XDG_RUNTIME_DIR=/tmp')
+        exec_command_and_wait_for_pattern(self,
+                                          "weston -B headless "
+                                          "--renderer gl "
+                                          "--shell kiosk "
+                                          "-- vkmark -b:duration=1.0",
+                                          "vkmark Score")
+
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.39.5


