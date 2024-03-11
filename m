Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8091AC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjfr-0006In-6Z; Mon, 11 Mar 2024 13:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjjfn-0005zZ-Mm; Mon, 11 Mar 2024 13:42:51 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjjfl-0007W9-Qd; Mon, 11 Mar 2024 13:42:51 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e5eb3dd2f8so3336585b3a.2; 
 Mon, 11 Mar 2024 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178966; x=1710783766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJYmS7//KWqwEUzntf/7pcjsXnd3DRaeR+mHw8GRlas=;
 b=XLgJLyZTgLL3dJgOO0vZ6LZKegh2SUg2zr4VZjCWUV1C3gPqfhy8YjzoO7ZvdEcaHl
 gRIDaQSLY9oK1KOdlf+LvCRyYWu8/kqivhYhK8ji0pH5GB2H6rPe6pvFBeaApEL8d+YP
 MM0baCr3HDSRaEWIif7FF7gu0a9ShYi69pcn/b8gQgDwanlS3uxKOpjdGr7T//bZVqn8
 389DgGM0PHQyL7OJRdn4R/bD0R2ChczL8hfmqzx1T9YsHjiiNFzmVjxYoUKaLvr7SI/2
 5TKX8tag50VVvNMMxuVWoSl7Id1AHUGo60MwsrOuB+pVWPCJ0gIk3BdPkSLwmQcqXZXj
 m7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178966; x=1710783766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJYmS7//KWqwEUzntf/7pcjsXnd3DRaeR+mHw8GRlas=;
 b=jLKWkqMdeGrfkbTsO6Xy7fGqJCpvw/EkIDNCiuGYMWJbs2/BqqtCzDVLqdCyrxHYMd
 kt/gQPzy1FUX/NfBRicdJHxzuvSbS4jGhqxsaApPk75q+WqOHsDynyuMobmLuxAdjF2j
 0lmzfmNizdJH/MdL8R7qQBXyCdIIPlIuI98lywZGKr/VyV7D3Af5AJRHWzECWGpA87z8
 YVzQUMK+TLmt8LyfIgePraiC9tuoVxe8YaOnggx7E493yi9kps/XW/STj8/af7WbcyaF
 dsylE2RacaM3ctmXspH68EhlSyDXsr10xD54355tRsfL9ycIVNowLK4Zm8Ke7ex4WCWz
 5LFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Rd11U9KSUYNHacGk9GTcNR9ZLcSBXJRCJkgyqBjOolaOSgGMXef1LAdL5iqgbJ035O/uHSsG2hInVi6X3g0B2rG7
X-Gm-Message-State: AOJu0YzelVHyzd/d+IXBGI0QkfYAKPKBNfHwy6qIs8Z5WxZBjIbqr9Nf
 30iFQvfUMT4o9uQ7u4PdST078cl6CqCo50yx7Fmkov6aZlUAFCTXoIyvbHKZaYo=
X-Google-Smtp-Source: AGHT+IEuu6OMiP1EpBRtnn7qfNBbuxCvPVJwjj8e5BkI/v/tyS+D/utoINnLeC5mM6WfM1e9siMTPA==
X-Received: by 2002:a05:6a20:3553:b0:1a1:82fc:94e2 with SMTP id
 f19-20020a056a20355300b001a182fc94e2mr3627211pze.44.1710178965704; 
 Mon, 11 Mar 2024 10:42:45 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:42:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-ppc@nongnu.org
Subject: [PATCH v4 24/24] tests/avocado: replay_linux.py add ppc64 pseries test
Date: Tue, 12 Mar 2024 03:40:26 +1000
Message-ID: <20240311174026.2177152-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add a ppc64 pseries test. IO in SLOF is very slow when running in
record-replay modes, so this this uses guestfish to extract the
kernel and initrd and boot them directly.

Cc: qemu-ppc@nongnu.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
The test takes about double the length of time of aarch64 and
x86 tests (800s to 400s) for some reason. Not profiled it yet.

 tests/avocado/replay_linux.py | 78 ++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index c0e50bb52b..1c11e48043 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -11,8 +11,9 @@
 import os
 import logging
 import time
+import subprocess
 
-from avocado import skipUnless
+from avocado import skipIf, skipUnless
 from avocado_qemu import BUILD_DIR
 from avocado.utils import cloudinit
 from avocado.utils import network
@@ -55,11 +56,14 @@ def vm_add_disk(self, vm, path, id, device):
             '%s,drive=disk%s-rr%s' % (device, id, bus_string))
 
     def vm_add_cdrom(self, vm, path, id, device):
+        vm.add_args('-device',
+            '%s,drive=disk%s' % (device, id))
         vm.add_args('-drive', 'file=%s,id=disk%s,if=none,media=cdrom' % (path, id))
 
     def launch_and_wait(self, record, args, shift):
         self.require_netdev('user')
         vm = self.get_vm()
+        vm.add_args('-s')
         vm.add_args('-smp', '1')
         vm.add_args('-m', '1024')
         vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
@@ -207,3 +211,75 @@ def test_virt_gicv3(self):
         self.run_rr(shift=3,
                     args=(*self.get_common_args(),
                           "-machine", "virt,gic-version=3"))
+
+# ppc64 pseries test.
+#
+# This machine tends to fail replay and hang very close to the end of the
+# trace, with missing events, which is still an open issue.
+#
+# spapr-scsi IO driven by SLOF/grub is extremely slow in record/replay mode,
+# so jump through some hoops to boot the kernel directly. With this, the test
+# runs in about 5 minutes (modulo hang), which suggests other machines may
+# have similar issues and could benefit from bypassing bootloaders.
+#
+ppc_deps = ["guestfish"] # dependent tools needed in the test setup/box.
+
+def which(tool):
+    """ looks up the full path for @tool, returns None if not found
+        or if @tool does not have executable permissions.
+    """
+    paths=os.getenv('PATH')
+    for p in paths.split(os.path.pathsep):
+        p = os.path.join(p, tool)
+        if os.path.exists(p) and os.access(p, os.X_OK):
+            return p
+    return None
+
+def ppc_missing_deps():
+    """ returns True if any of the test dependent tools are absent.
+    """
+    for dep in ppc_deps:
+        if which(dep) is None:
+            return True
+    return False
+
+class ReplayLinuxPPC64(ReplayLinux):
+    """
+    :avocado: tags=arch:ppc64
+    :avocado: tags=accel:tcg
+    """
+
+    hdd = 'virtio-blk-pci'
+    cd = 'scsi-cd'
+    bus = None
+
+    def setUp(self):
+        super().setUp()
+
+        if not ppc_missing_deps():
+            # kernel, initramfs, and kernel cmdline are all taken by hand from
+            # the Fedora image.
+            self.kernel="vmlinuz-5.3.7-301.fc31.ppc64le"
+            self.initramfs="initramfs-5.3.7-301.fc31.ppc64le.img"
+            cmd = "guestfish --ro -a %s run " ": mount /dev/sda2 / " ": copy-out /boot/%s %s " ": copy-out /boot/%s %s " % (self.boot_path, self.kernel, self.workdir, self.initramfs, self.workdir)
+            subprocess.run(cmd.split())
+
+    @skipIf(ppc_missing_deps(), 'dependencies (%s) not installed' % ','.join(ppc_deps))
+    def test_pseries(self):
+        """
+        :avocado: tags=machine:pseries
+        """
+        kernel=os.path.normpath(os.path.join(self.workdir, self.kernel))
+        initramfs=os.path.normpath(os.path.join(self.workdir, self.initramfs))
+        cmdline="root=UUID=8a409ee6-3cb3-4b06-a266-39e2dae3e5fa ro no_timer_check net.fnames=0 console=tty1 console=ttyS0,115200n8"
+        self.run_rr(shift=3, args=("-device", "spapr-vscsi",
+                                   "-machine", "x-vof=on",
+                                   "-kernel", kernel,
+                                   "-initrd", initramfs,
+                                   "-append", cmdline))
+
+    # minimise the number of tests run by default because they are slow
+    # SLOF block IO is extremely slow when going through the blkreplay driver
+    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
+    def test_pseries_slof(self):
+        self.run_rr(shift=3, args=("-device", "spapr-vscsi"))
-- 
2.42.0


