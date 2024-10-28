Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13B4D13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 09:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5MPQ-0005DS-Oy; Mon, 28 Oct 2024 05:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1t5MPN-0005Ct-I9; Mon, 28 Oct 2024 05:51:34 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1t5MPK-00031k-45; Mon, 28 Oct 2024 05:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202410; t=1730109069;
 bh=fyg6kWD8YQaOPtfGdgELKvPbsxej2xNNIwDN8RSQsRg=;
 h=From:To:Cc:Subject:Date:From;
 b=AGMdHli16d4+01wx3ZHQM4Gj9XqwX6rbhQoEBa9x9HiyjbBeNTivI2QSHsRJpPl/w
 6MxEJGoqXAIPhBMOPPLZO3BMq35KFo0FOVgOGKpI/oh+7sIHcCUMQr0iGplsQbmoY5
 eSbSUZ2WKL1aAerZ0cNCa3AGiIq4GjBdu+z1XeeYNb2/hi9lTJ/6FNJoNP9yDmiSm6
 iEzuzBpHmjwS6Lcdd8plyOO1AQ0B28e5iIuIN5m1/FWbB+g2wdwQTNGLNs276lZW84
 0+uoLv+T4lFAzVFCj9Gf5vDWkfETKFeCwr6uj8bvFhtg9KTolWGOm2wsEunJH2Crku
 W3I5w/fgcuX1Q==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4XcTDF2tTDz4x8C; Mon, 28 Oct 2024 20:51:09 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] MAINTAINERS: Remove myself as reviewer
Date: Mon, 28 Oct 2024 20:51:09 +1100
Message-ID: <20241028095109.1611019-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

I've now well and truly moved on from ppc and qemu maintenance.  I'm
occupied with other things and am pretty much just ignoring mails on these
topics I'm CCed on.  Time to remove myself.

I'm still listed as a reviewer for Device Tree, I'll keep this for now,
since I do have some interest and it's lower volume.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bcaf36e525..5cc9873861 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1465,7 +1465,6 @@ F: tests/functional/test_ppc_40p.py
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Daniel Henrique Barboza <danielhb413@gmail.com>
-R: David Gibson <david@gibson.dropbear.id.au>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
@@ -1555,7 +1554,6 @@ F: tests/functional/test_ppc_amiga.py
 
 Virtual Open Firmware (VOF)
 M: Alexey Kardashevskiy <aik@ozlabs.ru>
-R: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/spapr_vof*
-- 
2.47.0


