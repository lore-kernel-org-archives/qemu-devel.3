Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48118D13587
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 21:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5AaC-0005Nc-CZ; Sun, 27 Oct 2024 17:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1t5AaA-0005MY-QB; Sun, 27 Oct 2024 17:13:54 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1t5Aa7-0007VP-Lu; Sun, 27 Oct 2024 17:13:54 -0400
DKIM-Signature: a=rsa-sha256; bh=xpJrd+oeCpWEXqbTmrWASBMLlgFrzvs3zCilL3pWEko=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1730063627; v=1;
 b=WeEHbrcZErCbjHB4NXsaiXQ6K4HJH1qH2VL+Okym1LF59osyMkI0mFvUJm8Imod6trINN9JM
 PCLtipiTFD/bwwRwVda2ugjt77et8BeC2aW0QseRKUZcbBjtDea8atjkQpcMp76FEHvOGR5qPtD
 fisDsEgBChcz2qxNF5jSvvdzglB1KmJCC4rtM1ycLnAQoQOWNrI2qCmC7ookn4FN5U3RHngFhxn
 Jnrcjhb7G1q09HvD9+R61CFAQP54q2ju0fvnYzEV6RH8aDUvTm3r8tRl6kUUcnMikp2KzJAfjli
 8yLJvmWLx/zqyKSAv7SpYa8r2ZOgNddcdbVkH6vxzHbzA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id C0BA3202BE;
 Sun, 27 Oct 2024 21:13:47 +0000 (UTC)
From: ~axelheider <axelheider@git.sr.ht>
Date: Sun, 27 Oct 2024 22:02:42 +0100
Subject: [PATCH qemu.git v2 2/2] docs/devel/reset: add plural 's'
Message-ID: <173006362760.28451.11319467059840843945-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <173006362760.28451.11319467059840843945-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
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

Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Axel Heider <axel.heider@codasip.com>
---
 docs/devel/reset.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index 3e64a7259f..adefd59ef9 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -287,7 +287,7 @@ resettable too. Additional parameters (a reset type and a=
n opaque pointer) must
 be passed to the callback too.
=20
 In ``DeviceClass`` and ``BusClass`` the ``ResettableState`` is located in the
-``DeviceState`` and ``BusState`` structure. ``child_foreach()`` is implement=
ed
+``DeviceState`` and ``BusState`` structures. ``child_foreach()`` is implemen=
ted
 to follow the bus hierarchy; for a bus, it calls the function on every child
 device; for a device, it calls the function on every bus child. When we reset
 the main system bus, we reset the whole machine bus tree.
--=20
2.45.2

