Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FCEC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 06:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuQDs-0002eq-2U; Tue, 18 Mar 2025 02:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuQDp-0002dZ-H3
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 02:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuQDj-0002oz-K7
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 02:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742278471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g4IlVi8Kd9FpdmuECV5xmTf5TXrxvHsvm/wM2NRvvsU=;
 b=bPdgLMiOqpcAxcQtKlujR5tfgVfvR4r8BamyvRaGdQ+PCyk7VanNP2dqaLKvqcADMLGG6c
 j31+bOCzV536cUfd0cpZMDRcjdrhOEIAQOVeIlFELPmVqVT946zs295Al4LuouqSm9/Yxg
 kpWz1wn6nLHpQ8y++WljLxR3z9toKMU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-_1-WI3NxPM6Nwa0oONP44A-1; Tue,
 18 Mar 2025 02:14:26 -0400
X-MC-Unique: _1-WI3NxPM6Nwa0oONP44A-1
X-Mimecast-MFC-AGG-ID: _1-WI3NxPM6Nwa0oONP44A_1742278465
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FAAA180035E; Tue, 18 Mar 2025 06:14:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF5A41828A80; Tue, 18 Mar 2025 06:14:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: qemu-arm@nongnu.org
Subject: [PATCH] docs/system/arm: Use "functional tests" instead of
 "integration tests"
Date: Tue, 18 Mar 2025 07:14:20 +0100
Message-ID: <20250318061420.20378-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

We don't use the term "integration tests" for these kind of tests
anymore, it's "functional tests" nowadays.

Suggested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/arm/bananapi_m2u.rst | 6 +++---
 docs/system/arm/orangepi.rst     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
index 6efa222c16f..03cc5618c38 100644
--- a/docs/system/arm/bananapi_m2u.rst
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -125,10 +125,10 @@ And then boot it.
 
   $ qemu-system-arm -M bpim2u -nographic -sd sd.img
 
-Banana Pi M2U integration tests
-"""""""""""""""""""""""""""""""
+Banana Pi M2U functional tests
+""""""""""""""""""""""""""""""
 
-The Banana Pi M2U machine has several integration tests included.
+The Banana Pi M2U machine has several functional tests included.
 To run the whole set of tests, build QEMU from source and simply
 provide the following command:
 
diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
index 716062fca9c..d81f6c3bfd2 100644
--- a/docs/system/arm/orangepi.rst
+++ b/docs/system/arm/orangepi.rst
@@ -252,10 +252,10 @@ and set the following environment variables before booting:
 Optionally you may save the environment variables to SD card with 'saveenv'.
 To continue booting simply give the 'boot' command and NetBSD boots.
 
-Orange Pi PC integration tests
-""""""""""""""""""""""""""""""
+Orange Pi PC functional tests
+"""""""""""""""""""""""""""""
 
-The Orange Pi PC machine has several integration tests included.
+The Orange Pi PC machine has several functional tests included.
 To run the whole set of tests, build QEMU from source and simply
 provide the following command from the build directory:
 
-- 
2.48.1


