Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A31C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9jw-00010r-RZ; Thu, 20 Mar 2025 02:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tv9jn-000109-Bn
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tv9jk-0007uO-Ia
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742453438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NJTHZXxifyS69+9B/JLeUEUtbiGvlV9Y1yJtBCosFXc=;
 b=YRBFVyuec2uPA+hh/IokLugjSkvigRijzsBWRSscSZ5O5J/s9Un5XohUUm6XnDhPEUEkol
 RQQD00o+gxhTgjnW8EoSovKSTFNyP3h6EV3q+/T67ZP6Q6+3SH43167uwXcv0thVEjmHY+
 wuVd3XiRozHunSFc7ureAOXlKpaiaCg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-tat2Kl8FMbiU1v1vFg-ytw-1; Thu,
 20 Mar 2025 02:50:34 -0400
X-MC-Unique: tat2Kl8FMbiU1v1vFg-ytw-1
X-Mimecast-MFC-AGG-ID: tat2Kl8FMbiU1v1vFg-ytw_1742453433
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6E55180025B; Thu, 20 Mar 2025 06:50:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.78])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD71F19792DC; Thu, 20 Mar 2025 06:50:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/functional/test_ppc64_replay: Mark the e500 test as
 flaky
Date: Thu, 20 Mar 2025 07:50:12 +0100
Message-ID: <20250320065012.309520-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

The test_ppc64_e500 occasionally fails (it just hangs and finally times
out). The same issue could also be reproduced with the former Avocado
test already (especially if the host system is under heavy load), so
it's not a new regression. It's very likely the issue that has been
filed at https://gitlab.com/qemu-project/qemu/-/issues/2523 instead (e.g.
I could not reproduce the issue in older commits before commit 578912ad),
so use this URL for the reasoning in the the decorator.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Here are some examples where the test failed:
  https://gitlab.com/thuth/qemu/-/jobs/9391454847
  https://gitlab.com/thuth/qemu/-/jobs/9457171828
  https://gitlab.com/thuth/qemu/-/jobs/9458371668

 tests/functional/test_ppc64_replay.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_ppc64_replay.py b/tests/functional/test_ppc64_replay.py
index 48ce1b7f1e1..e8c9c4bcbf8 100755
--- a/tests/functional/test_ppc64_replay.py
+++ b/tests/functional/test_ppc64_replay.py
@@ -5,7 +5,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from qemu_test import Asset, skipFlakyTest
 from replay_kernel import ReplayKernelBase
 
 
@@ -16,6 +16,7 @@ class Ppc64Replay(ReplayKernelBase):
          'day19.tar.xz'),
         '20b1bb5a8488c664defbb5d283addc91a05335a936c63b3f5ff7eee74b725755')
 
+    @skipFlakyTest('https://gitlab.com/qemu-project/qemu/-/issues/2523')
     def test_ppc64_e500(self):
         self.set_machine('ppce500')
         self.cpu = 'e5500'
-- 
2.48.1


