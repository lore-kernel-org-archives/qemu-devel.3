Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5656EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs4I-0001dM-7m; Fri, 19 Jul 2024 14:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4G-0001Tl-M9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:10:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4D-0003g5-AU
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:10:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4266edee10cso13003065e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412651; x=1722017451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YFJ4F+v2FoWmOAeJ1TmNHGk/Gzzzixlx237F5Z9Ojzw=;
 b=VBETMt0H49QZlZi7ww/N4jyVRsKizfTYdwpwYRgrmaJqrP8aBh7sEADN0/nSIuf0Ve
 vRUXG+tQdAdrjFiPf1lwvLaAixfPdimGUgPjC8fZ2aKKofge7zaIsxREYjKvmhzAhblV
 uNV1WxnVoXWEz2ZM5jLjawToHeURHca/n7sfOLIlhSTEJnEw3hkSTtbL+TZayMLZbGE2
 DmFwnGMv5XmJebMnoXxXptDKDywqIHeI+cQrU5sNE0WZi+FLxKu+YmpxH8rYDUKSvCV8
 nPqTsZPpFbQ21wBYZSERdOgQl520P+jBbPHDAHCkCIOlhMSJB/5ZqWXlvIq69ubdJZ47
 BLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412651; x=1722017451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFJ4F+v2FoWmOAeJ1TmNHGk/Gzzzixlx237F5Z9Ojzw=;
 b=keofp2rbttagmwpaTYRfhgynVGcSGCHDDkPtQB4aJolIomlOVFUHFIVRjSLMK3f6Vz
 D+CO9eSJh6J5/XtwfHoPJJqBeCXDCl80+B4OuLju53PC/sl5/mnZRy4EitFYpncmweKT
 cqPNJLpU1D2fnW5mPy+q0AIrBi8JkPVLLUWuXSQubfDIIHfA6XZzER36iDleyuISMIDq
 Ni51MjnmEWpkotysekTzQWxdN3WUO536g0ZHO9aPUWNqFcSlcEABeFnezFyThI8G1anr
 KcatmbVIAMD/aDudib9XIKKiKsU1qYjQikzD2/mc+/4kiJg9bRLDG5zLV9aaoxCF2J58
 PNug==
X-Gm-Message-State: AOJu0YytvAmDTAR1T0gG174AKayP068JunLjdB88qW/mhmR93fHKInPx
 pA4VLUvYkOQ2TD4ujGHee2QBI98dl69MNjzcC/Pep2QflzVpFCAymrZHKqGn4zabB6U7f6faK/C
 T
X-Google-Smtp-Source: AGHT+IH8QQ3Q4WzhoLEmQnEVMenANYdfPsvxyv35s5ulBbkJX0659zA6WiSRoL8P2FAn1uN8VFvWUA==
X-Received: by 2002:a05:600c:1d96:b0:426:5ee3:728b with SMTP id
 5b1f17b1804b1-427daa28651mr1991465e9.13.1721412651427; 
 Fri, 19 Jul 2024 11:10:51 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a3c0fasm61914525e9.7.2024.07.19.11.10.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:10:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 01/16] tests/avocado: Add 'device:pl011' tag to tests
 exercising PL011 UART
Date: Fri, 19 Jul 2024 20:10:26 +0200
Message-ID: <20240719181041.49545-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the 'device:pl011' tag to various tests using the
PL011 UART, so we can run them all at once using:

  $ make check-avocado AVOCADO_TAGS='device:pl011'

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux.py              | 1 +
 tests/avocado/boot_linux_console.py      | 2 ++
 tests/avocado/boot_xen.py                | 1 +
 tests/avocado/machine_aarch64_sbsaref.py | 1 +
 tests/avocado/machine_aarch64_virt.py    | 1 +
 tests/avocado/smmu.py                    | 1 +
 tests/avocado/tuxrun_baselines.py        | 5 +++++
 7 files changed, 12 insertions(+)

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index df6cf209ef..6717f452eb 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -70,6 +70,7 @@ class BootLinuxAarch64(LinuxTest):
     def test_virt_kvm(self):
         """
         :avocado: tags=machine:virt
+        :avocado: tags=device:pl011
         :avocado: tags=accel:kvm
         :avocado: tags=cpu:host
         """
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index c35fc5e9ba..f595324979 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -362,6 +362,7 @@ def test_arm_virt(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:virt
+        :avocado: tags=device:pl011
         :avocado: tags=accel:tcg
         """
         kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
@@ -1380,6 +1381,7 @@ def test_arm_vexpressa9(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:vexpress-a9
+        :avocado: tags=device:pl011
         """
         tar_hash = '32b7677ce8b6f1471fb0059865f451169934245b'
         self.vm.add_args('-dtb', self.workdir + '/day16/vexpress-v2p-ca9.dtb')
diff --git a/tests/avocado/boot_xen.py b/tests/avocado/boot_xen.py
index 93bfb0c161..c4c01afa76 100644
--- a/tests/avocado/boot_xen.py
+++ b/tests/avocado/boot_xen.py
@@ -66,6 +66,7 @@ class BootXen(BootXenBase):
         :avocado: tags=accel:tcg
         :avocado: tags=cpu:cortex-a57
         :avocado: tags=machine:virt
+        :avocado: tags=device:pl011
         """
 
     def test_arm64_xen_411_and_dom0(self):
diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index e920bbf08c..f04ac2b11c 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -20,6 +20,7 @@ class Aarch64SbsarefMachine(QemuSystemTest):
     """
     :avocado: tags=arch:aarch64
     :avocado: tags=machine:sbsa-ref
+    :avocado: tags=device:pl011
     :avocado: tags=accel:tcg
 
     As firmware runs at a higher privilege level than the hypervisor we
diff --git a/tests/avocado/machine_aarch64_virt.py b/tests/avocado/machine_aarch64_virt.py
index 0ef6df4b0d..2d586c8459 100644
--- a/tests/avocado/machine_aarch64_virt.py
+++ b/tests/avocado/machine_aarch64_virt.py
@@ -23,6 +23,7 @@ class Aarch64VirtMachine(QemuSystemTest):
     """
     :avocado: tags=arch:aarch64
     :avocado: tags=machine:virt
+    :avocado: tags=device:pl011
     """
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
     timeout = 360
diff --git a/tests/avocado/smmu.py b/tests/avocado/smmu.py
index 4ebfa7128c..4b265e2435 100644
--- a/tests/avocado/smmu.py
+++ b/tests/avocado/smmu.py
@@ -21,6 +21,7 @@ class SMMU(LinuxTest):
     :avocado: tags=arch:aarch64
     :avocado: tags=machine:virt
     :avocado: tags=distro:fedora
+    :avocado: tags=device:pl011
     :avocado: tags=smmu
     :avocado: tags=flaky
     """
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 736e4aa289..98ab40bbb5 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -254,6 +254,7 @@ def test_arm64(self):
         :avocado: tags=arch:aarch64
         :avocado: tags=cpu:cortex-a57
         :avocado: tags=machine:virt
+        :avocado: tags=device:pl011
         :avocado: tags=tuxboot:arm64
         :avocado: tags=console:ttyAMA0
         :avocado: tags=shutdown:nowait
@@ -270,6 +271,7 @@ def test_arm64be(self):
         :avocado: tags=cpu:cortex-a57
         :avocado: tags=endian:big
         :avocado: tags=machine:virt
+        :avocado: tags=device:pl011
         :avocado: tags=tuxboot:arm64be
         :avocado: tags=console:ttyAMA0
         :avocado: tags=shutdown:nowait
@@ -285,6 +287,7 @@ def test_armv5(self):
         :avocado: tags=arch:arm
         :avocado: tags=cpu:arm926
         :avocado: tags=machine:versatilepb
+        :avocado: tags=device:pl011
         :avocado: tags=tuxboot:armv5
         :avocado: tags=image:zImage
         :avocado: tags=console:ttyAMA0
@@ -306,6 +309,7 @@ def test_armv7(self):
         :avocado: tags=arch:arm
         :avocado: tags=cpu:cortex-a15
         :avocado: tags=machine:virt
+        :avocado: tags=device:pl011
         :avocado: tags=tuxboot:armv7
         :avocado: tags=image:zImage
         :avocado: tags=console:ttyAMA0
@@ -324,6 +328,7 @@ def test_armv7be(self):
         :avocado: tags=cpu:cortex-a15
         :avocado: tags=endian:big
         :avocado: tags=machine:virt
+        :avocado: tags=device:pl011
         :avocado: tags=tuxboot:armv7be
         :avocado: tags=image:zImage
         :avocado: tags=console:ttyAMA0
-- 
2.41.0


