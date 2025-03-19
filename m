Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2164C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutKg-0000ec-RO; Wed, 19 Mar 2025 09:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tutKe-0000TY-0U
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tutKX-0007et-Ik
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742390372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tu0RlvcrYsmz8VD7rcIi1MCC0IqxBh9nmPXdBXLXDp8=;
 b=Kwqaf+hOg6g4pwfstyQX//+1x9oaBApQpiVTYLeQUZc021ls+xdv+GEhkFfpu0rJPPLpXt
 10lv4d4jHTRBDoxoKxjY96cgqhFf3f7IJ5VzVtgAlyehlBpirotbXBohw0UsUvll+Jd5RP
 eC6Q+7wlyc1MkWfWIl/LNvwngVS9RFg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-QxiciL_JP9uchsZ4Fde-WA-1; Wed,
 19 Mar 2025 09:19:30 -0400
X-MC-Unique: QxiciL_JP9uchsZ4Fde-WA-1
X-Mimecast-MFC-AGG-ID: QxiciL_JP9uchsZ4Fde-WA_1742390369
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EEA71955DC5
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 13:19:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.212])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 418003001D0E; Wed, 19 Mar 2025 13:19:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 7/8] tests/functional/test_x86_64_kvm_xen: Remove avocado tags
Date: Wed, 19 Mar 2025 14:18:50 +0100
Message-ID: <20250319131851.148817-8-thuth@redhat.com>
In-Reply-To: <20250319131851.148817-1-thuth@redhat.com>
References: <20250319131851.148817-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

They have been forgotten to be removed when converting the
test to the functional framework. Since they are of no use
anymore, let's remove them now.

Message-ID: <20250318171530.94966-1-thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


