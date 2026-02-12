Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D549FEEA860
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQO-0008LE-Bz; Thu, 12 Feb 2026 16:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQL-0008Ix-UR
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQI-0006B3-Sh
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYiMPPzpDbrmmZ9+z7uDuwj3oM05b8pmH+0ydAGbCJk=;
 b=HTOHh53i7CmwPuPPf6Z3ie/E9tx2oLZYk9v//HjJ25olgZxMrOioqMqls7zdO/F3VojzPm
 /k1TQGOUWEiCPjd440OOvHXMY6vT0lRajXkDqpgZwxfj20mOUvosHdpfo7y3Sew9c0Jqy1
 IQgRPqSW0PYzJrqqyZ21dnqxT8HlFAA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-VoH1Jt6dP4al-rYg0Ol1CQ-1; Thu,
 12 Feb 2026 16:40:26 -0500
X-MC-Unique: VoH1Jt6dP4al-rYg0Ol1CQ-1
X-Mimecast-MFC-AGG-ID: VoH1Jt6dP4al-rYg0Ol1CQ_1770932425
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BABB1955D89; Thu, 12 Feb 2026 21:40:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0E17180035A; Thu, 12 Feb 2026 21:40:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/16] tests/functional/aarch64/test_aspeed_ast2700: Rename
 AST2700 A1 test to reduce test runtime
Date: Thu, 12 Feb 2026 22:39:51 +0100
Message-ID: <20260212213955.2225662-13-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

Adding additional test cases to test_aspeed_ast2700.py makes the test
suite significantly larger and increases the overall test runtime.

To keep testing efficient and better scoped, rename the existing test
to test_aspeed_ast2700a1.py and dedicate it to AST2700 A1 specific tests.

A new test_aspeed_ast2700.py will be introduced later to always cover
the latest revision of the AST2700 SoC.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260211021527.119674-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aarch64/meson.build                          | 4 ++--
 .../{test_aspeed_ast2700.py => test_aspeed_ast2700a1.py}      | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename tests/functional/aarch64/{test_aspeed_ast2700.py => test_aspeed_ast2700a1.py} (100%)

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 5ad52f93e1d7..b5dd674bac61 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 test_aarch64_timeouts = {
-  'aspeed_ast2700' : 600,
+  'aspeed_ast2700a1' : 600,
   'aspeed_ast2700fc' : 600,
   'device_passthrough' : 720,
   'imx8mp_evk' : 240,
@@ -23,7 +23,7 @@ tests_aarch64_system_quick = [
 ]
 
 tests_aarch64_system_thorough = [
-  'aspeed_ast2700',
+  'aspeed_ast2700a1',
   'aspeed_ast2700fc',
   'device_passthrough',
   'hotplug_pci',
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700a1.py
similarity index 100%
rename from tests/functional/aarch64/test_aspeed_ast2700.py
rename to tests/functional/aarch64/test_aspeed_ast2700a1.py
-- 
2.53.0


