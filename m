Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC39E77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIV0-0003vR-5J; Thu, 02 Jan 2025 05:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUy-0003vD-Sr
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUx-0005s2-8w
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735813934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=56mE7YsbykST1gNfOQXCHhWDoXIPtPc7hWmN3UlNX8A=;
 b=StE5TW7i7KyrH4ti5URwoFvUJ1+JFJH68MIDluHLrWOnMGT74TI/DXWbvrQIEvRq4Er+VJ
 cpRqvzqIj8upjIjmh29+EPSIEwZpaUG3VbrcGhTC9Nn4CV1PP29GO4ItoVRtsqcQxc4VH5
 3ez3h6fLjzQRIAKE/dzIPnKXysa/L5E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-vCdmhpE_NOSt0iXuY00frw-1; Thu,
 02 Jan 2025 05:32:08 -0500
X-MC-Unique: vCdmhpE_NOSt0iXuY00frw-1
X-Mimecast-MFC-AGG-ID: vCdmhpE_NOSt0iXuY00frw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A183D195609F; Thu,  2 Jan 2025 10:32:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.39])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2A491956052; Thu,  2 Jan 2025 10:32:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 08/10] tests/functional/test_ppc64_hv: Update to Alpine 3.21.0
Date: Thu,  2 Jan 2025 11:31:36 +0100
Message-ID: <20250102103138.354618-9-thuth@redhat.com>
In-Reply-To: <20250102103138.354618-1-thuth@redhat.com>
References: <20250102103138.354618-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20241220024617.1968556-5-npiggin@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_ppc64_hv.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index e0dffb1f15..62f996adf6 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -35,9 +35,9 @@ class HypervisorTest(QemuSystemTest):
     good_message = 'VFS: Cannot open root device'
 
     ASSET_ISO = Asset(
-        ('https://dl-cdn.alpinelinux.org/alpine/v3.18/'
-         'releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso'),
-        'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff')
+        ('https://dl-cdn.alpinelinux.org/alpine/v3.21/'
+         'releases/ppc64le/alpine-standard-3.21.0-ppc64le.iso'),
+        '7651ab4e3027604535c0b36e86c901b4695bf8fe97b908f5b48590f6baae8f30')
 
     def extract_from_iso(self, iso, path):
         """
@@ -114,7 +114,7 @@ def do_test_kvm(self, hpt=False):
                            '-initrd /media/nvme0n1/boot/initramfs-lts '
                            '-kernel /media/nvme0n1/boot/vmlinuz-lts '
                            '-append \'usbcore.nousb ' + append + '\'')
-        # Alpine 3.18 kernel seems to crash in XHCI USB driver.
+        # Alpine 3.21 kernel seems to crash in XHCI USB driver.
         ps1='localhost:~#'
         wait_for_console_pattern(self, 'localhost login:')
         exec_command_and_wait_for_pattern(self, 'root', ps1)
-- 
2.47.1


