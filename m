Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0260C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2V0-0000xC-4D; Wed, 17 Jul 2024 07:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2Ul-0008FQ-4s; Wed, 17 Jul 2024 07:06:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2Uj-0007RX-9Z; Wed, 17 Jul 2024 07:06:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F1F7B7B374;
 Wed, 17 Jul 2024 14:06:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 66D9710B289;
 Wed, 17 Jul 2024 14:06:40 +0300 (MSK)
Received: (nullmailer pid 844388 invoked by uid 1000);
 Wed, 17 Jul 2024 11:06:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Zhihai Dong <dongzhihai@eswincomputing.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 02/16] README.rst: add the missing punctuations
Date: Wed, 17 Jul 2024 14:06:26 +0300
Message-Id: <20240717110640.844335-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717110640.844335-1-mjt@tls.msk.ru>
References: <20240717110640.844335-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Zhihai Dong <dongzhihai@eswincomputing.com>

Make the README more clearly.

Signed-off-by: Zhihai Dong <dongzhihai@eswincomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 README.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/README.rst b/README.rst
index 21df79ef43..b120a1f69e 100644
--- a/README.rst
+++ b/README.rst
@@ -82,7 +82,7 @@ guidelines set out in the `style section
 the Developers Guide.
 
 Additional information on submitting patches can be found online via
-the QEMU website
+the QEMU website:
 
 * `<https://wiki.qemu.org/Contribute/SubmitAPatch>`_
 * `<https://wiki.qemu.org/Contribute/TrivialPatches>`_
@@ -102,7 +102,7 @@ requires a working 'git send-email' setup, and by default doesn't
 automate everything, so you may want to go through the above steps
 manually for once.
 
-For installation instructions, please go to
+For installation instructions, please go to:
 
 *  `<https://github.com/stefanha/git-publish>`_
 
@@ -159,7 +159,7 @@ Contact
 =======
 
 The QEMU community can be contacted in a number of ways, with the two
-main methods being email and IRC
+main methods being email and IRC:
 
 * `<mailto:qemu-devel@nongnu.org>`_
 * `<https://lists.nongnu.org/mailman/listinfo/qemu-devel>`_
-- 
2.39.2


