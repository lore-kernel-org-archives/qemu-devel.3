Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FCEC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuaXh-0005Ei-Q2; Tue, 18 Mar 2025 13:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuaXd-0005EE-5O
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuaXY-00005F-4o
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742318142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XhWKA5bkfVRXA+8Rpingi3QLLhcufvKZUuUxevPUwA8=;
 b=LLkhKPXZRneiNfzqipWtR2uw9cR7MeBvow+vTvj/d+6M2g75aiSiiiZbcfdhKC2g+2SRIV
 rmU5IcV+WY1MH6kF01dtWKA53v1lT9wECGJ/lGShivSmb1tTWj1V17jOzwiI/zq8lh9zZo
 mO8S5WU2KlGC12nceuO9HJ0Ag+LJlzw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-A9KIODQdMHGX0TY0CnUzdQ-1; Tue,
 18 Mar 2025 13:15:38 -0400
X-MC-Unique: A9KIODQdMHGX0TY0CnUzdQ-1
X-Mimecast-MFC-AGG-ID: A9KIODQdMHGX0TY0CnUzdQ_1742318137
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86BB919560B3; Tue, 18 Mar 2025 17:15:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.157])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEB7B1956094; Tue, 18 Mar 2025 17:15:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, David Woodhouse <dwmw2@infradead.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/functional/test_x86_64_kvm_xen: Remove avocado tags
Date: Tue, 18 Mar 2025 18:15:30 +0100
Message-ID: <20250318171530.94966-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

They have been forgotten to be removed when converting the
test to the functional framework. Since they are of no use
anymore, let's remove them now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_x86_64_kvm_xen.py | 28 -------------------------
 1 file changed, 28 deletions(-)

diff --git a/tests/functional/test_x86_64_kvm_xen.py b/tests/functional/test_x86_64_kvm_xen.py
index 0298c96c2eb..3bedef6c98c 100755
--- a/tests/functional/test_x86_64_kvm_xen.py
+++ b/tests/functional/test_x86_64_kvm_xen.py
@@ -80,10 +80,6 @@ def run_and_check(self):
         wait_for_console_pattern(self, '#', 'Oops')
 
     def test_kvm_xen_guest(self):
-        """
-        :avocado: tags=kvm_xen_guest
-        """
-
         self.common_vm_setup()
 
         self.kernel_params = (self.KERNEL_DEFAULT +
@@ -94,10 +90,6 @@ def test_kvm_xen_guest(self):
                                 'virtio0-output')
 
     def test_kvm_xen_guest_nomsi(self):
-        """
-        :avocado: tags=kvm_xen_guest_nomsi
-        """
-
         self.common_vm_setup()
 
         self.kernel_params = (self.KERNEL_DEFAULT +
@@ -108,10 +100,6 @@ def test_kvm_xen_guest_nomsi(self):
                                 'virtio0')
 
     def test_kvm_xen_guest_noapic_nomsi(self):
-        """
-        :avocado: tags=kvm_xen_guest_noapic_nomsi
-        """
-
         self.common_vm_setup()
 
         self.kernel_params = (self.KERNEL_DEFAULT +
@@ -122,10 +110,6 @@ def test_kvm_xen_guest_noapic_nomsi(self):
                                 'virtio0')
 
     def test_kvm_xen_guest_vapic(self):
-        """
-        :avocado: tags=kvm_xen_guest_vapic
-        """
-
         self.common_vm_setup()
         self.vm.add_args('-cpu', 'host,+xen-vapic')
         self.kernel_params = (self.KERNEL_DEFAULT +
@@ -140,10 +124,6 @@ def test_kvm_xen_guest_vapic(self):
                                 'virtio0-output')
 
     def test_kvm_xen_guest_novector(self):
-        """
-        :avocado: tags=kvm_xen_guest_novector
-        """
-
         self.common_vm_setup()
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks' +
@@ -154,10 +134,6 @@ def test_kvm_xen_guest_novector(self):
                                 'fasteoi')
 
     def test_kvm_xen_guest_novector_nomsi(self):
-        """
-        :avocado: tags=kvm_xen_guest_novector_nomsi
-        """
-
         self.common_vm_setup()
 
         self.kernel_params = (self.KERNEL_DEFAULT +
@@ -169,10 +145,6 @@ def test_kvm_xen_guest_novector_nomsi(self):
                                 'IO-APIC')
 
     def test_kvm_xen_guest_novector_noapic(self):
-        """
-        :avocado: tags=kvm_xen_guest_novector_noapic
-        """
-
         self.common_vm_setup()
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks' +
-- 
2.48.1


