Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F19C021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 10:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEBW-0004FY-Oe; Wed, 26 Feb 2025 04:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEBJ-0003ud-OK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:58:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEBH-0008AG-AK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OhOHCVRG1ajbSFjgMYTuvP+dVzQxOuJ1lkMTnzzU1s=;
 b=e26CIw7GFzbPn8vKVnjc3wQes0ICqT0MYG5kqNJ+z2SfC6L8wAgo6lezwghCzR4tfqcEyY
 xy8uGb26BZGaZFhrsQ3gYTdOx1UiL6AhFJFzbfChsEscATRgtXVnV7qtG+E9WXZbmvYZoW
 a9SMHAwQxL83J50q7maDmmwaTfbXvW8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-vPhR6UJzPmSAnejDT7ajcA-1; Wed,
 26 Feb 2025 04:58:13 -0500
X-MC-Unique: vPhR6UJzPmSAnejDT7ajcA-1
X-Mimecast-MFC-AGG-ID: vPhR6UJzPmSAnejDT7ajcA_1740563892
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3D891800374; Wed, 26 Feb 2025 09:58:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E29D1180087F; Wed, 26 Feb 2025 09:58:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/18] tests/functional: Bump some arm test timeouts
Date: Wed, 26 Feb 2025 10:57:29 +0100
Message-ID: <20250226095731.1172375-17-thuth@redhat.com>
In-Reply-To: <20250226095731.1172375-1-thuth@redhat.com>
References: <20250226095731.1172375-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

On my local machine, for a debug build, sbsaref_alpine takes
nearly 900s:

$ (cd build/x86 && ./pyvenv/bin/meson test --setup thorough --suite func-thorough func-aarch64-aarch64_sbsaref_alpine
)

1/1 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_sbsaref_alpine
                      OK 896.90s

arm_aspeed_rainier can also run close to its current timeout:
 6/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_aspeed_rainier
                      OK 215.75s

and arm_aspeed_ast2500 and arm_aspeed_ast2600 can go over:
13/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_aspeed_ast2600
                      OK 792.94s

27/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_aspeed_ast2500
                 TIMEOUT 480.01s

The sx1 test fails not on the overall meson timeout but on the
60 second timeout in some of the subtests.

Bump all these timeouts up a bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250221140640.786341-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build     | 8 ++++----
 tests/functional/test_arm_sx1.py | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8ae70568a20..3fd2652c078 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -15,16 +15,16 @@ test_timeouts = {
   'aarch64_raspi4' : 480,
   'aarch64_rme_virt' : 1200,
   'aarch64_rme_sbsaref' : 1200,
-  'aarch64_sbsaref_alpine' : 720,
+  'aarch64_sbsaref_alpine' : 1200,
   'aarch64_sbsaref_freebsd' : 720,
   'aarch64_tuxrun' : 240,
   'aarch64_virt' : 720,
   'acpi_bits' : 420,
   'arm_aspeed_palmetto' : 120,
   'arm_aspeed_romulus' : 120,
-  'arm_aspeed_ast2500' : 480,
-  'arm_aspeed_ast2600' : 720,
-  'arm_aspeed_rainier' : 240,
+  'arm_aspeed_ast2500' : 720,
+  'arm_aspeed_ast2600' : 1200,
+  'arm_aspeed_rainier' : 480,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
   'arm_cubieboard' : 360,
diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/test_arm_sx1.py
index b85bfaa178f..4dd1e1859fa 100755
--- a/tests/functional/test_arm_sx1.py
+++ b/tests/functional/test_arm_sx1.py
@@ -44,7 +44,7 @@ def test_arm_sx1_initrd(self):
         self.vm.add_args('-no-reboot')
         self.launch_kernel(zimage_path,
                            initrd=initrd_path)
-        self.vm.wait(timeout=60)
+        self.vm.wait(timeout=120)
 
     def test_arm_sx1_sd(self):
         self.set_machine('sx1')
@@ -55,7 +55,7 @@ def test_arm_sx1_sd(self):
         self.vm.add_args('-snapshot')
         self.vm.add_args('-drive', f'format=raw,if=sd,file={sd_fs_path}')
         self.launch_kernel(zimage_path)
-        self.vm.wait(timeout=60)
+        self.vm.wait(timeout=120)
 
     def test_arm_sx1_flash(self):
         self.set_machine('sx1')
@@ -66,7 +66,7 @@ def test_arm_sx1_flash(self):
         self.vm.add_args('-snapshot')
         self.vm.add_args('-drive', f'format=raw,if=pflash,file={flash_path}')
         self.launch_kernel(zimage_path)
-        self.vm.wait(timeout=60)
+        self.vm.wait(timeout=120)
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.48.1


