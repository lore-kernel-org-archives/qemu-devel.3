Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3305DD70DED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkLD-00063Z-Aa; Thu, 28 Nov 2024 14:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3bc4db44430f53387d17145bb52b330a830a03fe@kylie.crudebyte.com>)
 id 1tGkLB-00062q-FI; Thu, 28 Nov 2024 14:38:17 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3bc4db44430f53387d17145bb52b330a830a03fe@kylie.crudebyte.com>)
 id 1tGkL9-0001kw-7m; Thu, 28 Nov 2024 14:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=yu2+fuCqlPpIhciUDx6LHQqmVm2hltzj+n6lloV1XYU=; b=fSzIY
 /KyiHI7rv04BqOMYeK0BGdgiAKwOpOmGz9yPEHMDVkGoU4NByf7u30NNmsAO1BC5X5UshHQElfOKy
 33NPeubBG5MBhNC76u3Gh/lvvTIVdl8J2VMerVSeZT0Slunld5Elo0YDpogYv34g6svsdebZ1xGGM
 xFhSBZXOOChQMZAn1QVHJZJKsMX9Z/dlGNpyJa/XyoJ1d/63hbNmHBPtuUI7ogUAvS8b0Teli2mNr
 4J9/oB5f5ZxrV6YVTsdpAZ2gmnQ3qK+rf1P49b1WEiW64QUkQL49AYjgqBod1OHCpZYIcXgHWdU5Z
 rV26EbRK1SdK1UWg/OpYraDZPRUJdG5nzYxa3HpjUoLO9nc75OTtdTBMzaBQLWsrRNDoPqW/b618C
 IVD1Xt+3syDQShf1dkqkp/0vgOH+/+Mv5owV0Ufj+Wez0jfLIkT8ef8jXZGFyq/YwtzNx+fra+ZIc
 KFDEalZbFAJ+roskpt3abjsRnIh9SVVrBuOWLvSXfgACg8WHjteZt6GYwIkBUgY7FD1vA3XdV6CB9
 ZZAXUlryxwvT3NH7kpIhf/tgfJl0CajGPT86blmV3cAfmoqGXVhr7+5Md70q1l4gc3m3hDxuSOxwk
 QhK6Auy2RP5F8Sr5BTakJJLDj4oTLBTP/0hr3oUZeeplPySW3kbRaTeDUNDfsM=;
Message-Id: <3bc4db44430f53387d17145bb52b330a830a03fe.1732820037.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732820037.git.qemu_oss@crudebyte.com>
References: <cover.1732820037.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 28 Nov 2024 19:53:58 +0100
Subject: [PULL for-9.2 5/7] 9pfs: remove obsolete comment in v9fs_getattr()
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=3bc4db44430f53387d17145bb52b330a830a03fe@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The comment claims that we'd only support basic Tgetattr fields. This is
no longer true, so remove this comment.

Fixes: e06a765efbe3 ("hw/9pfs: Add st_gen support in getattr reply")
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <fb364d12045217a4c6ccd0dd6368103ddb80698b.1732465720.git.qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 9a291d1b51..851e36b9a1 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1596,10 +1596,6 @@ static void coroutine_fn v9fs_getattr(void *opaque)
         retval = -ENOENT;
         goto out_nofid;
     }
-    /*
-     * Currently we only support BASIC fields in stat, so there is no
-     * need to look at request_mask.
-     */
     retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
     if (retval < 0) {
         goto out;
-- 
2.30.2


