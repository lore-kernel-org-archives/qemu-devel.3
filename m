Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A561CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1BH-00060X-92; Wed, 29 Oct 2025 04:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE1BE-00060A-6u
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE1BB-00042d-GQ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761725112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=op7z1X52GwW9SZWhbky3Kpx1uDQphXc2x6MOH436cOw=;
 b=fGIhuWgiF8s8svnXS44esF9H8v8omWIVe37FrFsVPnJMSReBwMUkV8xPFssl0DcPt76box
 6ED5+6CzDRhH1x4AETMsRI6/0obY5jRa2frHEGbs6jBMW1Q6ZMDCPyqcHysW7EsmaW0DuX
 pYK7XCtwETU9GbYB8tWNmp1f4E5JPBM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-e-mJfT_fN1214kPwPsvZMQ-1; Wed,
 29 Oct 2025 04:05:08 -0400
X-MC-Unique: e-mJfT_fN1214kPwPsvZMQ-1
X-Mimecast-MFC-AGG-ID: e-mJfT_fN1214kPwPsvZMQ_1761725107
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05EE91800673; Wed, 29 Oct 2025 08:05:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.98])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3192A19560AD; Wed, 29 Oct 2025 08:05:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/1] tests/functional/ppc64/test_mac99: Fix style issues
 reported by pylint
Date: Wed, 29 Oct 2025 09:05:02 +0100
Message-ID: <20251029080502.52938-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Pylint complained about lines being too long here, and mac99Test not
following the usual CamelCase capitalization.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/ppc64/test_mac99.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/functional/ppc64/test_mac99.py b/tests/functional/ppc64/test_mac99.py
index dfd9c01371d..a3261a8330a 100755
--- a/tests/functional/ppc64/test_mac99.py
+++ b/tests/functional/ppc64/test_mac99.py
@@ -7,14 +7,16 @@
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 
-class mac99Test(LinuxKernelTest):
+class Mac99Test(LinuxKernelTest):
 
     ASSET_BR2_MAC99_LINUX = Asset(
-        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
+        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main'
+         '/buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vmlinux'),
         'd59307437e4365f2cced0bbd1b04949f7397b282ef349b7cafd894d74aadfbff')
 
     ASSET_BR2_MAC99_ROOTFS = Asset(
-        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main//buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/rootfs.ext2',
+        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main'
+         '/buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/rootfs.ext2'),
         'bbd5fd8af62f580bc4e585f326fe584e22856572633a8333178ea6d4ed4955a4')
 
     def test_ppc64_mac99_buildroot(self):
-- 
2.51.0


