Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDB606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=KF32LqT5;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=6LXUZ0xA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRBsQ-0005Ag-Ca; Wed, 11 Nov 2026 12:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRBrr-0004q2-BF
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 12:12:16 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRBrb-00074J-9u
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 12:12:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Z3rR3uZ
 5wXBl/G0BKTiZo1R35YC28CzH3nS1USQzkr730ViU8OCwhK8W8NSPFBGGz2mHe2eJcV5hA
 18cVgEKYohViQS0N2Q+Xzz3dsTesm9Hxc096QZth0hpfgGfILV9VlmNc01r7TGYMdxcsqk
 Ref2gDHDL7PpQSb8EYX7YwbTy3AI7ho62BJWyRuX1FvEeCenASPGPUbFG7aJCtVouOETm4
 tDDyqp4dCuYNUqU2Gy2pnr3e2PyYC03XRogrFC2T7Kkxh+pbUsNzH4k7woS1kkpz+A+ewV
 tooqrg0e6Dxoig4mHPqPqdYcxcQaUGMaooEvI+abd3a/tgVemswGLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=W
 05QuVx02AfGODzUEGBS4GMbw2cdVt65ZDfEaC0PnJ0=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=Q1EBkW1/zh2VsWZR
 a3Q9HEqHpskwmSAUXFzxiDzmMWmjNLHnusOltDfSySzM+zABR9dRXCY1Z4zasYxpbwwS99
 bdy2oNAR9XpBT+A94t6L03JeEHd0IZpDt/nNypMiKBp0KekNhDwEsgyPfiLZFb0smSEPkQ
 UV0vlCSGdBVQuHruE+3IOHcJdVhbxJpPPmfgyfM+ycaiAuPvJ0sXdEutGD/W+Y0tuM0wXK
 WHM27+OOmWzglyvVEAbna+Db49vV6E4js1HFw/ZHUUxjDt+ddOv4D1I9besN5wMTMz6bhm
 edhPRLGjbaVVXr6qe7QIvLwAXe31jXvVBrTKjbIA8z0lug==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=KF32LqT5; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=6LXUZ0xA;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=W05QuVx0
 2AfGODzUEGBS4GMbw2cdVt65ZDfEaC0PnJ0=; h=date:subject:cc:to:from;
 d=korins.ky; b=KF32LqT51r60OJx5loePlRAv4WUiPsEscchoKYvFsO9kaoQIPfItj/w
 cBAQ1XMNEMsLmTy3DZW8FtyvD479BbH9aV16cNNJ+1p+72RgKKKl0NUgD2oKC39b+IWTMq
 XkitYO6lMeNZshyOTXBeyiHqrtF2JnCMbDRm3uXljolqwgjOPM1XnbX1oBAe4GdJG/MRN5
 ytr6gob2NWUKerAEVKv99r8Ld1NKb2gl35fkr+XGQXtUsLFqNrdV6jtq23XFP35iKpuLAo
 F9mvRzwyzCkMcuzz2wKCNH7FXhOSMtMqTlnGl6avrrGCVc9BjjNrZbLPeijFaKP8lT3zm0
 u6uPRGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=W05QuVx02AfGODzUEGBS4GMbw2cdVt65ZDfEaC0PnJ0=; h=date:subject:cc:to:
 from; d=korins.ky; b=6LXUZ0xAtgmjc4MOF1UxiNct5jjpk5VMeHY6X2oackmsQqPOe
 1W8ghYlxmvrioyQtohhCH7Csibp0SHyjBE8CA==
Received: by mx1.catap.net (OpenSMTPD) id 47d24ab0;
 Wed, 11 Nov 2026 18:11:56 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 06847368;
 Wed, 11 Nov 2026 18:11:55 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v3 0/1] usb/xhci: implement Event Ring Full handling
Date: Wed, 11 Nov 2026 18:10:04 +0100
Message-ID: <20261111171150.61871-1-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Kirill A. Korinsky" <kirill@korins.ky>

Greetings,

This is resend of the patch from July
https://patchew.org/QEMU/20260719215455.96122-1-kirill@korins.ky/
which was rebased to 29760efaf96bbe5928f8111881eddbf5ac06439e
(v11.2.0-rc0)

I use it heavy with my Octeon machine for a few montsh from
https://patchew.org/QEMU/20261111143533.1775-1-kirill@korins.ky/

Kirill A. Korinsky (1):
  usb/xhci: implement Event Ring Full handling

 MAINTAINERS                        |   1 +
 hw/usb/hcd-xhci.c                  | 585 ++++++++++++++++++++++++++++-
 hw/usb/hcd-xhci.h                  |  31 +-
 tests/qtest/meson.build            |   1 +
 tests/qtest/xhci-event-ring-test.c | 560 +++++++++++++++++++++++++++
 5 files changed, 1164 insertions(+), 14 deletions(-)
 create mode 100644 tests/qtest/xhci-event-ring-test.c

-- 
2.56.0


