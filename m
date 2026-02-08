Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AA1EF06E7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 10:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp1eG-0004LR-Ej; Sun, 08 Feb 2026 05:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vp1eB-0004JU-Iy; Sun, 08 Feb 2026 05:04:07 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vp1e5-0001oM-VM; Sun, 08 Feb 2026 05:04:06 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B5F0F80808;
 Sun, 08 Feb 2026 13:03:57 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:d25::1:35])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id t3Njcn1A4eA0-PUQt3wd7; 
 Sun, 08 Feb 2026 13:03:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1770545037;
 bh=Y8T3sQ7myYRXFcyLO/RPNCMgHh3wQJni+Ls0PXgNJQQ=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=gedQFLZWyh7OzNvkbaCHaFHWiQ3YPHnBJwbSFMt2lWDcuHs9PiVxx5sUYGT/frc9G
 T6VjSlA98R0cNg7ZFiBKExKwCIC1bkR8jRCV/oPJn+mKL6OGmqHe9oa0YJ2JVs7aFj
 eNmINtXAPCOPNqN585IBqx8fpbnGlxzFPtmW06uo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH 3/4] system/physmem.c: remove useless assertion of block
Date: Sun,  8 Feb 2026 15:03:53 +0500
Message-Id: <20260208100354.116102-4-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208100354.116102-1-heifetz@yandex-team.com>
References: <20260208100354.116102-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It is useless to assert that block is not NULL because
it is already dereferenced in the first line of the function.

We could split the declaration and initialization of oldsize,
but then we would need to remove the const qualifier.
This seems worse, as the assertion would be almost useless anyway.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 system/physmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index b0311f4531..317b359ebe 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2057,8 +2057,6 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
     const ram_addr_t oldsize = block->used_length;
     const ram_addr_t unaligned_size = newsize;
 
-    assert(block);
-
     newsize = TARGET_PAGE_ALIGN(newsize);
     newsize = REAL_HOST_PAGE_ALIGN(newsize);
 
-- 
2.34.1


