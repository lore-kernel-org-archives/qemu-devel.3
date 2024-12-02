Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8562ED78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6v2-0000qb-2y; Mon, 02 Dec 2024 08:56:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI6v0-0000ph-0Z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:56:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI6ux-0001Mz-VN
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733147811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGiv13La/6+8npXJ5MLxbndIK8xraxUA2VUr2r9sEEg=;
 b=PjJJhaVdkBpNn9ZSWAyGnma21R4Bi5QmhFSya3QKh27jD7mLSoMJtwx7zYkxXOPIFatJaa
 1SzrpD3Hg4lPZjhmktxHhwVQUxzitv3hcCgBqsx0Hg6D9r3Aw3iJMv5PvNxVXfwtmEZBgs
 gd7MeNIGDG+oSGiWD1+jSHzdorhlCwg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-_SeKvW5xO_WjP3Ud4DfIwA-1; Mon,
 02 Dec 2024 08:56:48 -0500
X-MC-Unique: _SeKvW5xO_WjP3Ud4DfIwA-1
X-Mimecast-MFC-AGG-ID: _SeKvW5xO_WjP3Ud4DfIwA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FC70195394F; Mon,  2 Dec 2024 13:56:47 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-206.str.redhat.com
 [10.33.192.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33039195608A; Mon,  2 Dec 2024 13:56:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/3] tests/functional: increase timeouts for arm sx1 test
Date: Mon,  2 Dec 2024 14:56:40 +0100
Message-ID: <20241202135640.80528-4-thuth@redhat.com>
In-Reply-To: <20241202135640.80528-1-thuth@redhat.com>
References: <20241202135640.80528-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

When under high load the test VM does not complete running in the
default 30 second timeout. Double it to give more headroom.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241129173120.761728-2-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_arm_sx1.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/test_arm_sx1.py
index 2d86405831..2292317946 100755
--- a/tests/functional/test_arm_sx1.py
+++ b/tests/functional/test_arm_sx1.py
@@ -44,7 +44,7 @@ def test_arm_sx1_initrd(self):
         self.vm.add_args('-no-reboot')
         self.launch_kernel(zimage_path,
                            initrd=initrd_path)
-        self.vm.wait()
+        self.vm.wait(timeout=60)
 
     def test_arm_sx1_sd(self):
         self.set_machine('sx1')
@@ -55,7 +55,7 @@ def test_arm_sx1_sd(self):
         self.vm.add_args('-snapshot')
         self.vm.add_args('-drive', f'format=raw,if=sd,file={sd_fs_path}')
         self.launch_kernel(zimage_path)
-        self.vm.wait()
+        self.vm.wait(timeout=60)
 
     def test_arm_sx1_flash(self):
         self.set_machine('sx1')
@@ -66,7 +66,7 @@ def test_arm_sx1_flash(self):
         self.vm.add_args('-snapshot')
         self.vm.add_args('-drive', f'format=raw,if=pflash,file={flash_path}')
         self.launch_kernel(zimage_path)
-        self.vm.wait()
+        self.vm.wait(timeout=60)
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.47.0


