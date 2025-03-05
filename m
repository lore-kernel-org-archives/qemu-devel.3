Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBBEC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpj04-0001fQ-V1; Wed, 05 Mar 2025 02:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpj03-0001en-D6
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpj01-0000PY-6e
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741159018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xFxeuDWSz4tjbxTkmt1hJWhUDTgYQccNds2+X0yGLuk=;
 b=h8HoKvoIAwUMF2Ipi9UgL/RumF1pTQhxQeOiiW3YiZLSZEQjJfBbrAjRlYzIo3jLet6nLE
 8vd/FmggN1BeJKwcdCNrl8Z35hfMvW+NhNsuqK5+RD+o+mcjFK+aypTWLUc/RM0jx+a+OW
 yZ5DrgxT+u1kcY+hfvGPEPOQ7PjpmCA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-PKbnJwcyP-WIcG_eixQQug-1; Wed,
 05 Mar 2025 02:16:53 -0500
X-MC-Unique: PKbnJwcyP-WIcG_eixQQug-1
X-Mimecast-MFC-AGG-ID: PKbnJwcyP-WIcG_eixQQug_1741159012
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8007F180AF4A; Wed,  5 Mar 2025 07:16:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.68])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A08F6300070B; Wed,  5 Mar 2025 07:16:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] tests/avocado: Remove the boot_linux.py tests
Date: Wed,  5 Mar 2025 08:16:46 +0100
Message-ID: <20250305071646.44702-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

These tests are based on the cloudinit functions from Avocado.
The cloudinit is very, very slow compared to our other tests,
so a lot of these Avocado tests have either been disabled by default
with a decorator, or have been marked to only run with KVM.

We won't include this sluggish cloudinit stuff in the functional
framework, and we've already got plenty of other tests there that
check pretty much the same things, so let's simply get rid of these
old tests now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Only remove boot_linux.py, but keep replay_linux.py for now

 tests/avocado/boot_linux.py | 132 ------------------------------------
 1 file changed, 132 deletions(-)
 delete mode 100644 tests/avocado/boot_linux.py

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
deleted file mode 100644
index a029ef4ad1e..00000000000
--- a/tests/avocado/boot_linux.py
+++ /dev/null
@@ -1,132 +0,0 @@
-# Functional test that boots a complete Linux system via a cloud image
-#
-# Copyright (c) 2018-2020 Red Hat, Inc.
-#
-# Author:
-#  Cleber Rosa <crosa@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import os
-
-from avocado_qemu.linuxtest import LinuxTest
-from avocado_qemu import BUILD_DIR
-
-from avocado import skipUnless
-
-
-class BootLinuxX8664(LinuxTest):
-    """
-    :avocado: tags=arch:x86_64
-    """
-    timeout = 480
-
-    def test_pc_i440fx_tcg(self):
-        """
-        :avocado: tags=machine:pc
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pc_i440fx_kvm(self):
-        """
-        :avocado: tags=machine:pc
-        :avocado: tags=accel:kvm
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pc_q35_tcg(self):
-        """
-        :avocado: tags=machine:q35
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pc_q35_kvm(self):
-        """
-        :avocado: tags=machine:q35
-        :avocado: tags=accel:kvm
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-
-# For Aarch64 we only boot KVM tests in CI as booting the current
-# Fedora OS in TCG tests is very heavyweight. There are lighter weight
-# distros which we use in the machine_aarch64_virt.py tests.
-class BootLinuxAarch64(LinuxTest):
-    """
-    :avocado: tags=arch:aarch64
-    :avocado: tags=machine:virt
-    """
-    timeout = 720
-
-    def test_virt_kvm(self):
-        """
-        :avocado: tags=accel:kvm
-        :avocado: tags=cpu:host
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.vm.add_args("-machine", "virt,gic-version=host")
-        self.vm.add_args('-bios',
-                         os.path.join(BUILD_DIR, 'pc-bios',
-                                      'edk2-aarch64-code.fd'))
-        self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
-        self.vm.add_args('-object', 'rng-random,id=rng0,filename=/dev/urandom')
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-
-# See the tux_baseline.py tests for almost the same coverage in a lot
-# less time.
-class BootLinuxPPC64(LinuxTest):
-    """
-    :avocado: tags=arch:ppc64
-    """
-
-    timeout = 360
-
-    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
-    def test_pseries_tcg(self):
-        """
-        :avocado: tags=machine:pseries
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pseries_kvm(self):
-        """
-        :avocado: tags=machine:pseries
-        :avocado: tags=accel:kvm
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.vm.add_args("-machine", "cap-ccf-assist=off")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-class BootLinuxS390X(LinuxTest):
-    """
-    :avocado: tags=arch:s390x
-    """
-
-    timeout = 240
-
-    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
-    def test_s390_ccw_virtio_tcg(self):
-        """
-        :avocado: tags=machine:s390-ccw-virtio
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-- 
2.48.1


