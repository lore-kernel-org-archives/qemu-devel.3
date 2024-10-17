Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF7FD0C604
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 23:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4qbb-0000QK-I9; Sat, 26 Oct 2024 19:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1t4qbY-0000PH-3n; Sat, 26 Oct 2024 19:54:00 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1t4qbW-0002hs-2S; Sat, 26 Oct 2024 19:53:59 -0400
DKIM-Signature: a=rsa-sha256; bh=P/QJArraF9s0Wj18D9e7gLOaNmiBzvEBCk+A4ZQSQHo=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1729986833; v=1;
 b=oapcfOcNL1+krpHB2glGuyc9COMRVvFCeQlKfEOzYaeewjfx/zPbhyLXsqzVK+pYzbCxcATJ
 KRkq8RsOPvDaQ6tzgkhxPPJCb0XVS0vCIZ5O6JNLy6sNs9J5qwMwLi0O3ETrVgtrZrvx8QUEPbb
 r95rJeX5DEupsqIyhjJE95LM6C8RwUYVzqm5Y/tr1hN7P3KtqPuLu8EqmJMCaeI9PPjNnziFvj4
 lxsbATUFxaZ7k1Sc6Jj6ttB+8X89/jcedRB+iwPsD3FwJQ8By9+Mb4kPSxR7pJN0x/l0YYqzjXp
 rFPoqMonehIMFHESxTfnaaHl/O+PMVpqCshRI2TrkLZZA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 5129320271;
 Sat, 26 Oct 2024 23:53:53 +0000 (UTC)
From: ~axelheider <axelheider@git.sr.ht>
Date: Thu, 17 Oct 2024 19:58:21 +0200
Subject: [PATCH qemu.git 1/1] docs/devel/reset: add missing words
Message-ID: <172998683323.20070.572834413126431721-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <172998683323.20070.572834413126431721-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~axelheider <axelheider@gmx.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Axel Heider <axel.heider@codasip.com>

Signed-off-by: Axel Heider <axel.heider@codasip.com>
---
 docs/devel/reset.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index 74c7c0171a..3e64a7259f 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -286,7 +286,7 @@ every reset child of the given resettable object. All chi=
ldren must be
 resettable too. Additional parameters (a reset type and an opaque pointer) m=
ust
 be passed to the callback too.
=20
-In ``DeviceClass`` and ``BusClass`` the ``ResettableState`` is located
+In ``DeviceClass`` and ``BusClass`` the ``ResettableState`` is located in the
 ``DeviceState`` and ``BusState`` structure. ``child_foreach()`` is implement=
ed
 to follow the bus hierarchy; for a bus, it calls the function on every child
 device; for a device, it calls the function on every bus child. When we reset
--=20
2.45.2

