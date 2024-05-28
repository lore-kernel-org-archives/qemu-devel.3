Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAD0C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxLE-0006UR-TQ; Tue, 28 May 2024 09:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sBxLB-0006TL-2U; Tue, 28 May 2024 09:58:13 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sBxL8-0005Af-HN; Tue, 28 May 2024 09:58:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5d80:0:640:e743:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 35CEF608F2;
 Tue, 28 May 2024 16:58:05 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6512::1:33])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nvQj710IWSw0-2xEHR2Vs; Tue, 28 May 2024 16:58:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1716904684;
 bh=7sBESpZah4nl650LjWnJo06q2iUkOsSjhsvCpZwsyWM=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=FVYc1wDcn18OWCSooozzQHkA6pNgcYF7Az87lP+0G6o8up38luT5nhpDGPwsKUVQo
 SutZiMxnWYZRTcaxYtWKP1LOLe4wB+NB26fr3ymzWFbM3bQZu4uqJeuTgkbs2I7eaX
 yokdgGCIT8TEwEjLPxV7iySUvzgjjb+HisSArNuw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 7/7] iotests/pylintrc: allow up to 10 similar lines
Date: Tue, 28 May 2024 16:57:47 +0300
Message-Id: <20240528135747.2476904-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528135747.2476904-1-vsementsov@yandex-team.ru>
References: <20240528135747.2476904-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We want to have similar QMP objects in different tests. Reworking these
objects to make common parts by calling some helper functions doesn't
seem good. It's a lot more comfortable to see the whole QAPI request in
one place.

So, let's increase the limit, to unblock further commit
"iotests: add backup-discard-source"

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/pylintrc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index de2e0c2781..05b75ee59b 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -55,4 +55,4 @@ max-line-length=79
 
 [SIMILARITIES]
 
-min-similarity-lines=6
+min-similarity-lines=10
-- 
2.34.1


