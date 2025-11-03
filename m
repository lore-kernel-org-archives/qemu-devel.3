Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8E9CCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsHE-0003sT-UW; Mon, 03 Nov 2025 05:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsHB-0003re-JK
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsH3-0004RH-U9
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hff/k/1RIB4r6If5d41QAniZ0RCrNVZJzbv+PSn88Hw=;
 b=CAIWQFw5f1ZENgfrKRYkIVPjYVNjtqgVfDE8hZqHs9BzcSjGxMEQ37cDmFwnnw55NdTkkV
 3/gf4iSPvIXhrZ3qQgEJSuCk/NtEulrd4oBveKQ2A8/5udAX49QAeVAeXHqmUwCBc+2HC/
 DM0M4bGngLQCXyD06lYnK8/XKdvkUd4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-q_s7PCTeNPWukrpqrIIxHg-1; Mon,
 03 Nov 2025 05:58:51 -0500
X-MC-Unique: q_s7PCTeNPWukrpqrIIxHg-1
X-Mimecast-MFC-AGG-ID: q_s7PCTeNPWukrpqrIIxHg_1762167530
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE4471800669; Mon,  3 Nov 2025 10:58:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5625930001BC; Mon,  3 Nov 2025 10:58:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 11/22] tests/functional/ppc64/test_mac99: Fix style issues
 reported by pylint
Date: Mon,  3 Nov 2025 11:58:08 +0100
Message-ID: <20251103105824.322039-12-thuth@redhat.com>
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
References: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251029080502.52938-1-thuth@redhat.com>
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


