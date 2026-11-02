Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991C6076725
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=kfGbLqxB;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=OPVgeBTQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtgG-0001hE-Bx; Mon, 02 Nov 2026 10:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNtgD-0001fg-HA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:10:38 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNtgA-0003MQ-Iz
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:10:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=c4lFusQ
 bMfwTtzElF3g+/2A3SnVA97BJy8ZNY4Amd/9TTWrDVyJz0BTD3CkYj4DisSkbUoFzJlnIW
 5znoEDDFnRdoMHAEYUyReHc7x15JbGUscS+SL7xNMVd53HJCCuxflTiYoOdux5cEVRAR7X
 rklSKtWmcgFDoa6eCsPCgj9QqRQEnNUaxth5We3VRsrVUGQXoAzYy5TmIGLEa4GnlAlY1Z
 4yKQlU+5WnKC1FKtikalXI9E2Ys3xjlubMjOCsnBobqv7JuQ6DmwBSUyR57EAPlSzs/KCY
 Phn+sgq6JCQPHGuUQ+h8QK2SOK+9mR67NuKdUDGvBqsShLL3EOrDc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=9
 kLKjC+m2wCzdnyOjWXTeUfcEU0a7+oIzL2D+VGV7lk=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=KkAnzq5bl0+oDU0X
 8e5mJBe7sCtzM21gYucfMQFy3DlSasFpv9tS9DDoAfwSLV45wO3KM5+s/VpVDaQrF9wvsE
 zx9JZtvAFQo7J/FDdkhjkayrqI1BRvFQL3pCYaCafU63yebshiO66SxMH+wW5W/LI4o1x9
 +otK3WGn7CXxMSYEf+oDfEkQk6Sus1x1MQLCG6gRfIFQlbBkvcz3xv0TGz6JBJLrMLZCf4
 omGWmTG7H3+EsN5NVmhk8PDL0Q8vpPthw6ygfI8e9WBW6cfnm15WFm2CmNb1oqJxQXi6dG
 5rRHRSvp/qCCQpiBFRmB6nDSunoa1O6t0MqTmfKTXShApQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=kfGbLqxB; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=OPVgeBTQ;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=9kLKjC+m
 2wCzdnyOjWXTeUfcEU0a7+oIzL2D+VGV7lk=; h=date:subject:cc:to:from;
 d=korins.ky; b=kfGbLqxBOeq6BMWTUAijFym18Egj0b5nw7fOzeHAMMmciZAUecc4eYa
 iRyDFpOuu2tf+ZyfeWhKJRBrPC90re+qUzIdZzsgF8S7hG0Oi1TcFnUtvTp2jgQfAYIs2u
 pDwLtN968By1GkdejvMW77lif4gOXFmO3NMxaMuG3tii4jUfd1oVp0M3WX4sAdL4ZLQirX
 srw20DPdBW6oAussZPyyVPrFl7wvCuLGK+q7CMxy3uq/5BUDUQVEKBlInAvCJdJGT+/29k
 schMKPSICNwxw0muBME/VIw91WrN7NNsyt7LkpbgslNoVcTFP+zY5rOzGYamkHIl25q3mO
 XauZ8SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=9kLKjC+m2wCzdnyOjWXTeUfcEU0a7+oIzL2D+VGV7lk=; h=date:subject:cc:to:
 from; d=korins.ky; b=OPVgeBTQ1Xn7uczD+VabRvTx7qvBCQfulBHagq8KmbT8oPDEP
 yOCIRVxIfr+nCGd3prW8OffuYI+gY3v4k1XDQ==
Received: by mx1.catap.net (OpenSMTPD) id 3cdede20;
 Mon, 2 Nov 2026 16:10:31 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 81bccd09;
 Mon, 2 Nov 2026 16:10:29 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 0/1] usb/xhci: implement Event Ring Full handling
Date: Mon,  2 Nov 2026 16:09:36 +0100
Message-ID: <20261102151022.64359-1-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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
which was rebase / reapplied to actual master brnach branch
56afd82bd4db9688f1c1c9d0e2ea163b8cde3283

I use it heavy with my Octeon machine for a few montsh from
https://patchew.org/QEMU/20261101142723.41346-1-kirill@korins.ky/

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


