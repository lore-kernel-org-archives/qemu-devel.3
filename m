Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C89606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vivier.eu header.i=laurent@vivier.eu header.a=rsa-sha256 header.s=s1-ionos header.b=HYVSmq7q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWtIi-0006lu-7j; Fri, 27 Nov 2026 05:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1xWtIg-0006l6-HF
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:35:30 -0500
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1xWtIe-0008Cd-J7
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:35:29 -0500
DKIM2-Signature: i=1; m=1; t=1795775724; mf=PGxhdXJlbnRAdml2aWVyLmV1Pg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=vivier.eu;
 s=s1-ionos:rsa-sha256:RJ0JY8f+XnlS6ijbkGVeVpqlK+hW
 uR5g32RMfDRSNZZKRXQFjXkEcZnx+BJY/5NZksc+qYw36TRs+dPW+Uz/JleY3x8wtDHQyQd/F0Y
 0TiT2lsjilSc8pmYRQ1sfQnSyplR+8WCwKBJHQbkxCVDXeV4e/vdtCmBqgokQ4yHLv4RdI5FZYv
 w98/kL94R7r9MQRirwdBWYDab5b4cUK5THVgKP4bFU/A3FeS6Hu+wsKUYqgyGjD88cWfftNZTwM
 ghTAlny5x2EjDLHV7VRAFrEyROTePsKsM8s2BUlLzIDGxmEAMAYKov0VYVHt7rErRRlL34cAAZg
 LPXG/4q5af1USg==;
Message-Instance: m=1; h=sha256: 2CbbQ1Ahe8tW/ZUGt7LUgA5DKyM9ZOcMqBqPQsepbOg=:
 cdx4F0gmU/Vr4sVrkxgNowBJqGs8npOavf/+rur3BFU=, sha512:
 dnsWm1paEhxUt+X0Mzk535RbmlSpSi4AocDeGnnOAs7yXtLoOMB2NATs1wF1/m8zPUKVMiGEubDAllw7rDHnAg==:
 VXjIkM12jLBjM1pktvU8PorHXFfaHiBltMK6LUXkMv5YmzLBB2WZELqMs1RYuT3tonZg/BhsGYsZLdXB6NJcqA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1795775724; x=1796380524; i=laurent@vivier.eu;
 bh=PUOHgQRvBOeA4NSLyNVYAASNUu0vQ3Lq11NGO7nFpTQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HYVSmq7qPk9tssjuAcpzUlqRBRhAy5Wc7nV1HgfeWu8pzin+o1rb9AW2m4+Qazzr
 mKFAIcYqB5j504lQU7H6gvMhhEPT/veg2wjOJLIpAIYLN30TgAkmOShZ3rtgcluux
 OZYCoJW4sCLx566fLlq4hVVUPSCGGU06+9NHEgit/9IxF/bla11k0PqxwcoqxzaH8
 BNrZyEAeVK+GJsnJEaw7pi/cKbt08O2MRPnRQj+b5+dtipRDlazgE/jWtB3VBz0Ou
 ai0JFHUO/ZRMIL6zIrWxeSOpIIicI4YYR2WiwfrlLHVrSJOO7IAeDfiLtT7btL7pK
 77/Onsq++iDx3xKZ4A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N1OsF-1yUeud1PdT-00v4cg; Fri, 27
 Nov 2026 11:35:24 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 0/1] M68k for 11.2.0 patches
Date: Fri, 27 Nov 2026 11:35:06 +0100
Message-ID: <20261127103507.382826-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Nv8cmjDKZuDcc9+Qw76tIXxm0MrUX+USjRy8t2OfNF+QsCvO4Y
 QByCsnIDLLi1Uzzh70sPSZQS4r/GlxqFJw3jX8Asbjs2RccnCwVxq4KzCZCJxC3AokcTBBY
 44lXEg2HinrGl7NOkeUltSFyKlUqyJevP7KCsGoywqNXY908X9dy9uaZGmi5OxSpB+9R4ET
 KtuPph41JsmK37OuxTelg==
UI-OutboundReport: notjunk:1;M01:P0:o1+keaOID3U=;BosPjN6jTn9lrec8YlBGkQHDTA1
 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
 vbI/9th
Received-SPF: pass client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 9751c62358073580cbf330a4df22077a7c6a407=
c:

  Update version for v11.2.0-rc2 release (2026-11-25 21:39:27 -0800)

are available in the Git repository at:

  https://gitlab.com/laurent_vivier/qemu.git tags/m68k-for-11.2.0-pull-req=
uest

for you to fetch changes up to 20a2f956153e82b84fcb1be5b3a6ed2906f75e55:

  hw/char/goldfish_tty: Fix signed data length (2026-11-27 11:33:21 +0100)

=2D---------------------------------------------------------------
One goldfish fix

=2D---------------------------------------------------------------

Laurent Vivier (1):
  hw/char/goldfish_tty: Fix signed data length

 hw/char/goldfish_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

=2D-=20
2.56.0


