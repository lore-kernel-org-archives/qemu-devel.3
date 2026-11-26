Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C8606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=sUClM0eM;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=QYz5T9xf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWgNd-0000vY-On; Thu, 26 Nov 2026 15:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xWgNc-0000sd-6n
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:47:44 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xWgNa-00066Y-JB
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:47:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=EXMKj2v
 NniVnHzrLFw8c+EtR1C908roZ0NnukWXAj10mu3L3Fv6KpFPriWo8BfxCE41evBbABpRjQ
 4yWxwiKi1gaoxtkm0eUF9/++eAAcRPs9mY5Qn4z7NcnGvRMNBV5YAaMSeqKr8ayaxuFhQO
 0Spot3bnFydHZPgCvBl5Pt4mMp5bma+VERsSQkBiZlvfnETYtDucUklRkz88vNP/fbYegq
 FGE2SH2c0Rep+PV0the3ByNsNG0MKFDPfBqF0ZaW4BgeNa4TrTjdYOr6uR9HK3RplbK7dH
 /HzByUGoICCPkQumVH5CeW8/pRlX8vDv4HFTehRd5c9ZiCFHVJciZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=i
 ClbuOdsfkLUcU3S8rZ1Nons2x2PDY9A3Ll7flvZl9A=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=WaObfhlFLUwYhzzM
 AJidO452UI7BqEtGxsdLnzz5TfUpA1AH+eSi64glonj0wYqMMFzHhroL4cevmnnGSmc2PY
 F4aAEww77JH3POxsQZacu8LZ5hWzLeGadROoyB+cF2Os4h3wiMOMrGbh7v7StWo228nJNP
 d8v8O7Xi1TDeouBJYornYujLFltPVOzMGiI/4VIw5q77p4TLq2XasFFQNII1OQ+porsgg/
 nwKtkrIzesvVbzl1+ST13oMwzWeScYXOjBMooVP+CtlG8Q6iZF76XGu9DYt3chQSScTnZK
 8lgfQfB7wQVii1BkjqGdf59wWIhKNHfLo0e6CQyFUdKCug==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=sUClM0eM; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=QYz5T9xf;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=iClbuOds
 fkLUcU3S8rZ1Nons2x2PDY9A3Ll7flvZl9A=; h=date:subject:cc:to:from;
 d=korins.ky; b=sUClM0eMeqfnue7s2cc1URYim5txK5fiP/OncbxiGOa4hKE/eFBuIu1
 BlAr/pYaMA1jkmkmXBQQ2wV/9Xj954b7JRCbJf7G5kqXsAzEClZImY6kxN/JHGVceiFaew
 89C4VZFCN95aV537xKwG5JbH2+Nnbb7mvF5Z7nyen5v9KKoxPnHV2VQvcpharTxMy0XULT
 obqa+4uDDLeJ52pRk7Dg2YzVPhrZvDGekCM8w87hwKpsDZ04PtdzhX1OoB6S2k7UFMh8jK
 X2klbooeDxFXi8IJgjKu5t31XIfRm56tpYz4iehoo3rMPTTFVqoOIsDeB2E3U8ZzgIrLI/
 4SLms7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=iClbuOdsfkLUcU3S8rZ1Nons2x2PDY9A3Ll7flvZl9A=; h=date:subject:cc:to:
 from; d=korins.ky; b=QYz5T9xfNGiS7O4cSxsW9xAiJ9okNGhNtu6JNf9PJvyb50OA9
 4g0kZS+V6XTK4SkoZ3P4bSsIko7wW9a01wzDA==
Received: by mx1.catap.net (OpenSMTPD) id 798061db;
 Thu, 26 Nov 2026 21:47:38 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 1f03d52a;
 Thu, 26 Nov 2026 21:47:36 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH 0/3] target/hppa: a few fixed to pass OpenBSD's libm regress
Date: Thu, 26 Nov 2026 21:39:19 +0100
Message-ID: <20261126204733.9423-1-kirill@korins.ky>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Greetings,

Here a seires of 3 releativly small fixes which allows to pass
regression tests from OpenBSD's libm the same way, which inclues the
same failng tests, at real hardware which was tested recently at PCXW2
by other OpenBSD developer to confirm for me that behaviour.


