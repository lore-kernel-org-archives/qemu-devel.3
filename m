Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E9FE668BC
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 17:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFG5T-0003kd-0J; Sun, 24 Nov 2024 12:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fb364d12045217a4c6ccd0dd6368103ddb80698b@kylie.crudebyte.com>)
 id 1tFG5P-0003k3-0I; Sun, 24 Nov 2024 12:07:51 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fb364d12045217a4c6ccd0dd6368103ddb80698b@kylie.crudebyte.com>)
 id 1tFG5N-0005HK-NJ; Sun, 24 Nov 2024 12:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=bglsoUlhCRKaokV268JNEiCI901dRlYpBAqwZbBilN0=; b=cLr+C
 deHGt8YAEOCN+xPUP9rvyPapIQL3OmgOkTcvBVChfV48Is7JKjxnXuUVEewnBokb9ZDCtx/UbkhRi
 mrAborIfqadnM09cRE+LdniuP1bXhKkJMVmPC4vDsoSBPPwhVsagcoeo5w/Hg9tLqvbQiXfsFNgt6
 9kNKyaU1/cCPMmn+dde10GAxaWpcnUALQ2F9gicNIWNrT1F01lC2gLRhE+++IWAoDHXMPsFEL15w1
 JYYYRhJVrNJqSE2HC1vMnZA8OkOu1GKx/ldJzEtNZT5iwVGzAOC1QRtMGXiFlHogYQ0eAOi0wGCZU
 TMTae9FW/Iglf52ockEfifix1KlLx0jH1v8bRVgSTV87DxS8AZY8sUqdj4kwH65pKXa0XXRpjFf3f
 gG7Ui93ICZ6ZYIJ7R5TIkTNcBsJmMdNvqf4qt7PqElVzH9g+kk3OKHrIvZXZ81fXofJHABwZgNtPC
 wg39P+teRA0v3Y9rLy1poxjR4bx2mbd5ou9+N2BYmbWnbLBtbls/qAJeqhrWBLsiAhDIOF+0mzIzB
 LBKFDjUDPF3Ilpqm97huz13mL2myVqei7B7UUNj0xrsf98pIaOpRruyL0+ixiaTg+bNPiRl8EHeAd
 WGzecWU5iPsigdAi/jvkcUv+trw76EvGfbwAA1tVN9rN736GwyFFWKjB6lKANs=;
Message-Id: <fb364d12045217a4c6ccd0dd6368103ddb80698b.1732465720.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 24 Nov 2024 16:06:40 +0100
Subject: [PATCH 4/6] 9pfs: remove obsolete comment in v9fs_getattr()
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=fb364d12045217a4c6ccd0dd6368103ddb80698b@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
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
2.39.5


