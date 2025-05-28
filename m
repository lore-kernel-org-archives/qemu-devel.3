Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49BCC54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 01:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK60z-0000iE-AH; Tue, 27 May 2025 21:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uK60x-0000hy-VL
 for qemu-devel@nongnu.org; Tue, 27 May 2025 21:55:32 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uK60w-0003Ag-3f
 for qemu-devel@nongnu.org; Tue, 27 May 2025 21:55:31 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-525da75d902so1185520e0c.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 18:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748397328; x=1749002128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ekdSO3MxkWEhWoItetIsPFvG7mQY8NVEEt05rbTMaZs=;
 b=Wvy4JiIsUc9kuIgtYsOmugglSv5j5zPqkGVgT+usfVxPvK9ghKr3SrHSWrEzQ7r6Fr
 jIuuYvK1bV3GvBsVmad63daHNN2VSU7HUevIQ0xYXDAC7LqaOEwPjKkvsgipyyc24h1C
 RcBPwQ3TAhg6ufT0t8HrwoHKpibm2ovyxtuH7tdBZZ7+1D69VHzflVvJlFtAye4mn5Ps
 1qBrLMJhnccjTJ1G4BVjYBzGe3X5ecLmbu9tVLnvb6GrvR7hhB4H/f/WzKzJmIbPa/A+
 9ZFToP8Jtow9klKX5iMV9l0eu2TtQ04GRVA17Ihn6NTQFl4RNUwy5hL/xpnJXltlmazl
 Uzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748397328; x=1749002128;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ekdSO3MxkWEhWoItetIsPFvG7mQY8NVEEt05rbTMaZs=;
 b=W2L+yIF99Cz/zk8oPJTYH4WzzmFfI34kma6Mt7EaB9E/J4jWxXXX7MMt4toB12D4wp
 9WqnqHCHecZ9Q6M6TrEyUZ+rtoON6kVg87w/zW/AUHgd1uec4XbEK9HlKw3ZuYHqN6nh
 VM8PucaGlIJs4wBiJirFk9WUnIepw82SNNSu3uf8JtDszWZ4EPQUKlAeeARFbVz+6tJV
 ikKYABpGf7sv+z5qHqmpRB3E43hLpLtt04ZdpqKMeRTkNu7stq9Av1X1TT40w/Ra3lb7
 P0oXJ3GuD70VGGATCxDz1r3av04gJ3QzRk2T21xSOGt+2dop1llg229A0ZyXIU8WagE4
 eIqg==
X-Gm-Message-State: AOJu0YyMAXoXfz4toZrNkTa+MrtHyj5BH/QOQzIgzY62+Ph6RIbtZxoS
 g2sCMv2lFwSJZjdFb8Vn8WZ3pjPUUUpH0vCGKOVYbzmGb7FzVn+IAmlrUV7wlFCABJQlyNP+Gbp
 M+aS1
X-Gm-Gg: ASbGncvT0LF1pJGtg/34Wu343Cn5rfcLes9E0sK9BgNRYVpBIutH5O0ong0tkLvbIov
 MkDuyfV4mAnCRlLc+p2yOGCrESgNjXUfnbQ9c69I84mS6HDpc0OgnMdQvy34IjWq9OVZn78B2Y3
 Gmz7WsJ3M3rcHpnde4BrgnCb3G14P8y3aCt745sm/fX6IjFKrA6zL2Ac32XGyK8jnH3YvejA267
 84TBckfcOnrYX+OtCXUlR1mvh2JVXrzjeFaJz0awV+RPNe/SB6BGkr4ZOSyqBmFZ9c/S4Mhx3A0
 Q/a5iw3V/0dJJ9pZ33wQn79K8o04UeKlDt0fDzBQi9M9z5+PB5l2z4DNJITwYfdCgjvT6rWmr0I
 QBnhX8d0b+mRafHA+k+6ixA==
X-Google-Smtp-Source: AGHT+IGq0QjeGsJxdYS+r7/yoJx30jpViyp2evfwLhnAAzs8MFXBXhMA3kTOKslpl4WAPVezC2V/fg==
X-Received: by 2002:a05:6122:2527:b0:530:65b3:4920 with SMTP id
 71dfb90a1353d-53065b349f8mr413923e0c.5.1748397328493; 
 Tue, 27 May 2025 18:55:28 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53066864b70sm174242e0c.18.2025.05.27.18.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 18:55:27 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH REPOST] tests/functional/test_aarch64_hotplug_pci: Add test
 for ACPI PCI hotplug
Date: Wed, 28 May 2025 01:55:08 +0000
Message-Id: <20250528015508.1630804-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa31.google.com
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

Currently, test_aarch64_hotplug_pci only tests PCI hotplug using the
native PCI hotplug mechanism. Now that aarch64 supports PCI hotplug via
the ACPI mechanism it's time to support it in the test as well.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/test_aarch64_hotplug_pci.py | 24 +++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
index 2cf5c28b9f..ec8c7afe96 100755
--- a/tests/functional/test_aarch64_hotplug_pci.py
+++ b/tests/functional/test_aarch64_hotplug_pci.py
@@ -27,11 +27,26 @@ class HotplugPCI(LinuxKernelTest):
          '20230607+deb12u11/images/netboot/debian-installer/arm64/initrd.gz'),
          '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
 
-    def test_hotplug_pci(self):
+    def run_vm_and_test_hotplug_pci(self, use_acpi_pci_hotplug=False):
+        """
+        Run an aarch64 VM and test the PCI hotplug mechanism by plugging and
+        unplugging a PCI network adapter to the VM. Proper plug and unplug of
+        the adapter is verified by checking if the network device is correctly
+        added and removed in Linux.
+
+        Parameters
+        ----------
+        use_acpi_pci_hotplug : bool
+            If true the ACPI PCI hotplug mechanim is used, otherwise the
+            Native PCIe Hotplug mechanism is used.
+        """
+
+        acpi_pci_hotplug = "on" if use_acpi_pci_hotplug else "off"
 
         self.set_machine('virt')
         self.vm.add_args('-m', '512M')
         self.vm.add_args('-cpu', 'cortex-a57')
+        self.vm.add_args('-machine', f"acpi-pcihp={acpi_pci_hotplug}")
         self.vm.add_args('-append',
                          'console=ttyAMA0,115200 init=/bin/sh')
         self.vm.add_args('-device',
@@ -70,5 +85,12 @@ def test_hotplug_pci(self):
                                           'ls -l /sys/class/net | wc -l',
                                           '2')
 
+    def test_native_pci_hotplug(self):
+        self.run_vm_and_test_hotplug_pci(use_acpi_pci_hotplug=False)
+
+    def test_acpi_pci_hotplug(self):
+        self.run_vm_and_test_hotplug_pci(use_acpi_pci_hotplug=True)
+
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.34.1


