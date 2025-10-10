Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3C4CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 14:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ENh-0007Hn-Ew; Fri, 10 Oct 2025 10:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v7ENa-0007GO-Va
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v7ENM-0004XH-AT
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760107533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zHDDExAMYUaCgqxmq3WJ5bEcFdm3tSKRJVY3u3KcQgI=;
 b=WJEnG9vrr0nnopXfI7YpcQM7t5lRyOKy/hu5W4CKNO3KNi/DlHWCP9shU9nFkz8hx94JwG
 6V5o41RPfbYFd0vLzwQh9rtmdI9d7otbhsb78+wzSPWaHCkqjCYAXMMyb1huEU5W81Fxx2
 iXVTX7hon+aFd/abRvmxtfgyODPbwkk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-BBKgDi8IM4W83OwVUQ8u9w-1; Fri,
 10 Oct 2025 10:45:30 -0400
X-MC-Unique: BBKgDi8IM4W83OwVUQ8u9w-1
X-Mimecast-MFC-AGG-ID: BBKgDi8IM4W83OwVUQ8u9w_1760107529
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01C4C19560A0; Fri, 10 Oct 2025 14:45:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.128])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 829B8180141D; Fri, 10 Oct 2025 14:45:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] tests/functional/alpha: Remove superfluous fetch() line from
 the clipper test
Date: Fri, 10 Oct 2025 16:45:25 +0200
Message-ID: <20251010144525.842462-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The kernel asset is retrieved automatically via the uncompress()
line below the fetch(), so the fetch() is simply not necessary here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/alpha/test_clipper.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/functional/alpha/test_clipper.py b/tests/functional/alpha/test_clipper.py
index c5d71819531..d2a4c2a4ed9 100755
--- a/tests/functional/alpha/test_clipper.py
+++ b/tests/functional/alpha/test_clipper.py
@@ -17,7 +17,6 @@ class AlphaClipperTest(LinuxKernelTest):
 
     def test_alpha_clipper(self):
         self.set_machine('clipper')
-        kernel_path = self.ASSET_KERNEL.fetch()
 
         uncompressed_kernel = self.uncompress(self.ASSET_KERNEL, format="gz")
 
-- 
2.51.0


