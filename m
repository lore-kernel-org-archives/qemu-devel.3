Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A7DEFCBD4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w226T-0007vL-JU; Mon, 16 Mar 2026 03:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225n-0007VX-L6; Mon, 16 Mar 2026 03:10:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225m-0007lY-2j; Mon, 16 Mar 2026 03:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773645002; bh=CmDa9F5nfz3aUSXpzzrFQot+GvJGuvW4S/3odYMM1j0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=v1dAAbLixcAvtx3h+20Ub9jTuDTLLRo7STJCLFUF4dJ2KhjaHerZLaUTVW96+ixZl
 SkdwPds6V/S9l4+YHZE9tMTaYEc3kQTxyiHRBLDrH0wyALsKCXW1xGyQBfDIZbt23P
 Xy+kwaPGRAwOmR9L1EeHyyQ/bSN8NRc3+tcE4v/srDQ5MvoNYsGnNEE216g45SZwwB
 XRi8M3jGopyUhTMBBG43+v5Pu0KreTTDJlGKTF3FFUVBjTOEq2LiWySEb2vqDoRhbw
 0QZwqjt5MrMuamA9xHBAuozSvLk2i8OzxwJ5C7sziIbM/yKsqWf8k6R43XGZrow2Kj
 3DKAOmk61ey3g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A700E193C26;
 Mon, 16 Mar 2026 10:10:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AF5D338004E;
 Mon, 16 Mar 2026 10:10:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Sergei Heifetz <heifetz@yandex-team.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 04/14] system/physmem.c: remove useless assertion of block
Date: Mon, 16 Mar 2026 10:09:52 +0300
Message-ID: <20260316071005.91624-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
References: <20260316071005.91624-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Sergei Heifetz <heifetz@yandex-team.com>

It is useless to assert that block is not NULL because it is
already dereferenced in the first line of the function.

The assertion is also unnecessary because the function is called
in only two places, and `block` can't be NULL in either of them:
- In `migration/ram.c`, we have already dereferenced `block` in
  the code just before the call.
- In `system/memory.c`, we assert `mr->ram_block` before passing
  it to the function.

(We could split the declaration and initialization of oldsize,
but then we would need to remove the const qualifier. As the
assertion is useless anyway, removing the const qualifier seems
worse.)

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 system/physmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 4a9e076004..4e26f1a1d4 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2028,8 +2028,6 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
     const ram_addr_t oldsize = block->used_length;
     const ram_addr_t unaligned_size = newsize;
 
-    assert(block);
-
     newsize = TARGET_PAGE_ALIGN(newsize);
     newsize = REAL_HOST_PAGE_ALIGN(newsize);
 
-- 
2.47.3


