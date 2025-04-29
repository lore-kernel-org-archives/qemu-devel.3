Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998F5C3ABA9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jDq-00078c-GO; Tue, 29 Apr 2025 07:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDj-0006xE-Rz; Tue, 29 Apr 2025 07:33:52 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDh-0008Gx-K1; Tue, 29 Apr 2025 07:33:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1779461333;
 Tue, 29 Apr 2025 14:33:44 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b423::1:3a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bXTAnY0Fe0U0-E099GDmw; Tue, 29 Apr 2025 14:33:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745926423;
 bh=BtuTV4i6Dso4pgdFfeN1B9eAAXqbLI7RCSe0Zk64D1I=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dlQe4M/FN6pErqV75MkagQYMuJbv8snm0aFLmTP4RUf7ALH1swMa1x4dl7IsTuqu/
 /0qiCvEGmTzqj7isbmsORyD8ro/8Pd9fkeNFEE7lLaqRzAEZ0P006b7YiALmFGKBmM
 NHJLU5eeiE0qF0fkQC4Fx86gfTocOQ6TMMhvjt7g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 5/5] util/co-shared-resource: Remove unused
 co_try_get_from_shres
Date: Tue, 29 Apr 2025 14:33:32 +0300
Message-ID: <20250429113335.423535-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429113335.423535-1-vsementsov@yandex-team.ru>
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

co_try_get_from_shres hasn't been used since it was added in
  55fa54a789 ("co-shared-resource: protect with a mutex")

(Everyone uses the _locked version)
Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-Id: <20240918124220.27871-1-dave@treblig.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/qemu/co-shared-resource.h | 7 -------
 util/qemu-co-shared-resource.c    | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/include/qemu/co-shared-resource.h b/include/qemu/co-shared-resource.h
index 78ca5850f8..41be1a8131 100644
--- a/include/qemu/co-shared-resource.h
+++ b/include/qemu/co-shared-resource.h
@@ -44,13 +44,6 @@ SharedResource *shres_create(uint64_t total);
  */
 void shres_destroy(SharedResource *s);
 
-/*
- * Try to allocate an amount of @n.  Return true on success, and false
- * if there is too little left of the collective resource to fulfill
- * the request.
- */
-bool co_try_get_from_shres(SharedResource *s, uint64_t n);
-
 /*
  * Allocate an amount of @n, and, if necessary, yield until
  * that becomes possible.
diff --git a/util/qemu-co-shared-resource.c b/util/qemu-co-shared-resource.c
index a66cc07e75..752eb5a1c5 100644
--- a/util/qemu-co-shared-resource.c
+++ b/util/qemu-co-shared-resource.c
@@ -66,12 +66,6 @@ static bool co_try_get_from_shres_locked(SharedResource *s, uint64_t n)
     return false;
 }
 
-bool co_try_get_from_shres(SharedResource *s, uint64_t n)
-{
-    QEMU_LOCK_GUARD(&s->lock);
-    return co_try_get_from_shres_locked(s, n);
-}
-
 void coroutine_fn co_get_from_shres(SharedResource *s, uint64_t n)
 {
     assert(n <= s->total);
-- 
2.34.1


