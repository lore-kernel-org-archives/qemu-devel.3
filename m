Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A51606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=HGsNjwIW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp61-00020E-H7; Fri, 27 Nov 2026 01:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp4B-00061A-RW; Fri, 27 Nov 2026 01:04:21 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp4A-0003dM-AE; Fri, 27 Nov 2026 01:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759043; bh=bMeWgH2qegYPSEQ8igAmhWVSzz9Bg+UxWFrcUXGMYq0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HGsNjwIW2BjXzE5OwQoLBI21ZuxxefeBzLp55AydNRaOsPl//Hf9c8pOs0MGU301E
 NwAXfhEp70BIvmjNH4iqINkf3QUyKS245belss1ptMq+CcMNagsw+Ur6ZkmkUZ0q0n
 lRqLLM5i7zcPAk7VyUmQ1Zz9st9gQRlkhK7/Zoai0sh3GbghKnHFLAOTg9LAzSLDnE
 HEB7kxokYE+C8UvtZ9/IuPNACD0tZfOyRkrgL2RhrBUsAkI3bqSg1vN8a7FPIk2iTV
 x7PKgKRX15PTNV4Q7oO09TG2Y6WF0JrReq4S8ajS/6jFylLQaoVIvP1xxnLM0Mxaaq
 ngfTOgr0elURw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A26E01EA345;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A03F5469970;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 94585CF2D8; Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 083/152] docs/about/deprecated: Add missing "since"
 marker for OABI/NWFPE
Date: Fri, 27 Nov 2026 08:53:41 +0300
Message-ID: <20261127055709.39630-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In 750c2d53ee4 we deprecated our linux-user support for the Arm OABI
and NWFPE emulation; however we forgot to mark the text in
deprecated.rst with the usual indication of what version it was
deprecated in.  We announced the deprecation of this feature in the
11.0 release, so note that.

Cc: qemu-stable@nongnu.org
Fixes: 750c2d53ee48f1e ("docs: Deprecate Arm OABI and NWFPE support")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-id: 20261112093824.2281467-2-peter.maydell@linaro.org
(cherry picked from commit 64593b5ca1998c8d08e032eac0ad90f763143559)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0c656a968fc..e18f474e059 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -395,8 +395,8 @@ across versions).
 linux-user mode CPUs
 --------------------
 
-OABI and NWFPE support for Arm CPUs
-'''''''''''''''''''''''''''''''''''
+OABI and NWFPE support for Arm CPUs (since 11.0)
+''''''''''''''''''''''''''''''''''''''''''''''''
 
 Linux for 32-bit Arm has had two major ABIs: the original OABI and the
 more modern EABI. OABI support was marked as obsolete in GCC 4.7 and
-- 
2.47.3


