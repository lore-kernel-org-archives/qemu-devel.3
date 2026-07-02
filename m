Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6C8C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfCAW-0004oX-Nj; Thu, 02 Jul 2026 03:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wfCAS-0004o5-MH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 03:49:04 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wfCAQ-0004yJ-Oe
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 03:49:04 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id B1671240104
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2026 09:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
 t=1782978538; bh=0R848jtIsl6VNMt52++4HiaBII5yWrCVPFGwdroBrAQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=LkO6Meo4kDOayImt0e1rvxRbZ5u1+GAMUYqkadAFMrsgxw24UbrMLE0onU/Kh7YGZ
 H2N2PPjifC/qP9M2Geaj51jC+5BYmpLihZyg+nqFtGxcXiYOSYLAgF2eJSgp9slb1b
 xFgoFxHC75ubEVtcOumwWl0Cl7HgAspjd507n5cTBnBb8BesKs0s5vj9oMEzt/7/Ti
 XiwN+JHSxNiwfsoqFLWp3WdJjw8Y1fkkJ1Vr4dpgGjn0fGvgoC5fEe5I1HwTTagytj
 qelE4KzeWbZucnjA4HTgaPWnpNTaXV0+vwU7Eby9tysToaoPA+eK0As23Ovs0gdHlU
 gTTO92r8IkAgQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4grTXn05t5z9rxL;
 Thu,  2 Jul 2026 09:48:56 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-trivial@nongnu.org, aik@ozlabs.ru
Subject: [PATCH] docs/system/ppc/pseries: Update the link to the SLOF
 repository
Date: Thu, 02 Jul 2026 07:48:58 +0000
Message-ID: <20260702074842.4806-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SLOF has been moved to gitlab.com already a while ago. We updated
the link in pc-bios/README in commit 7f98b4f25ed9 ("pseries: Update
SLOF firmware image"), but forgot to update it in the manual, too.

Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 docs/system/ppc/pseries.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
index bbc51aa7fc..107091a37f 100644
--- a/docs/system/ppc/pseries.rst
+++ b/docs/system/ppc/pseries.rst
@@ -43,7 +43,7 @@ Firmware
 
 The pSeries platform in QEMU comes with 2 firmwares:
 
-`SLOF <https://github.com/aik/SLOF>`_ (Slimline Open Firmware) is an
+`SLOF <https://gitlab.com/slof/slof>`_ (Slimline Open Firmware) is an
 implementation of the `IEEE 1275-1994, Standard for Boot (Initialization
 Configuration) Firmware: Core Requirements and Practices
 <https://standards.ieee.org/standard/1275-1994.html>`_.
-- 
2.54.0


