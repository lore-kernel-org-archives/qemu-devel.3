Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED922C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr1PH-0005Jw-BQ; Mon, 03 Aug 2026 18:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wr1PF-0005JV-HJ; Mon, 03 Aug 2026 18:45:13 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wr1PE-00058a-1y; Mon, 03 Aug 2026 18:45:13 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id E25D1EC00F8;
 Mon,  3 Aug 2026 18:45:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 03 Aug 2026 18:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1785797110; x=
 1785883510; bh=08Dw4PPoAm/LKsvgv8DbTs0HZilaul6ArOzGW8pFwwE=; b=E
 YLZll+ckbpiGVViNhqlq14zLgns9jiXlONBMFlHi1Wg/FOvuxax7hwffDnz2FQdT
 6psPKgy8HqHOG0aWXNIuixouTIbZats7RplwTND/4Xxq31+QJbPG7WSFdY8om4sS
 DbIZbILX42bvnpEt1WhTVbuxIgkXjX573qFqlpPKbQAv8nT++3SMNpn8AXIk+njG
 NdOj0U2uVn9IQzLaw04zQWbyVsCFKzhjV8AY8clIEkCnX9s2iQEbIgj77azouw+m
 cS+bcLZMycTmTSn0MkzDmS327Rbvkz31Ktwcsv4aC93IOkPcEQ9fQ8VLlQ8TgieJ
 34b15flpnOAy9V4VjDfow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1785797110; x=1785883510; bh=0
 8Dw4PPoAm/LKsvgv8DbTs0HZilaul6ArOzGW8pFwwE=; b=O4KXZz+jdhJtjQQkd
 ZkuKdSetK9EYsl3M7hS7hchUdG+OorC85BQCwM75X1lqiDhad0azhPjKe6qcysIz
 i+zJj4Vu8dYXmKRfWD6zeOZJfWpPzm+uaXl7yBTgTkE/xCe0UgE4BDAIsSVuQ/kZ
 zxvTWTSlopWWgrQqOG6GUF4lf3zFqiD37CFNkR5XVIwzDABS9YAflxkF5A1/eKRY
 UN+kg6bfJr1hZAHPSBdt+ZMuUv2wekNKt3LR41NWHJzAGi//gC4FX92Ob9KTi9q6
 DaX986kM/l+oXafGakOi0ZLRfby852Kd7CkD9UYaWfzYk7erhUepNEnhZuu23AFY
 lCCQw==
X-ME-Sender: <xms:9hlxaulKQwOTY67oYDsdltKF15qtd9YR69NXnt2GRR0URyYM4ayIgA>
 <xme:9hlxav6aDUjxP-XDbThNcxrAg9xBnZNNhIqETyWB68n1OBNlXX1gl-YY1Vof1vx1t
 GN8_LD1FS9UcohHtvyuU008n2goTz6Rr7w6ax0SPRqDjsA4bAkT1sXq>
X-ME-Received: <xmr:9hlxasiNDYG-cPNfM7ZNq2r0q0OYxMkzmyRfRGsQcT2VJXX2B8eEgwdf9iNQ0FBJWjYW0fOiTMefChNkN9gQkGMIsAnqcAwpEVehMV8j5NgGuw>
X-ME-Proxy-Cause: dmFkZTFXkk6770ximeuBos74vR2JiBpZatXZdclZlrPAvXrkA2heiaORyn0hnKWjHIRFWz
 VbtxK/TPD3OPlr90XHwHeI5GUrlhvgfz4Lvo6r65by747p5uA18KRjwtDjikUtoj3P+0nB
 lq6xDGx6w7uwP2bGW43bVFZ1cGeRRCGDZ0al+jx8IF34pWJZQBEy2DAXQABe3WZODjLjaj
 n6FUTjfBkCgWWQ3B0dzUuYP3vgstYOAUo2y11UOwsS2R1/vVRd5ZlDgahgbEv1vO9/EWR4
 tVOm7v0luKRlwrMs97altgzlqVKEuvuMELDl/BKSIuu0iy+KbUSanj1oojsLt9GxB8iCh5
 ARMd0Pj6B3dNtEq/yIqYrZkfjAfFlKZknfUs16Mhnq9nJ39xWy+jd2jhiYqRiCvcgEF1Jg
 IrmxWb+Mk8Bjx/kjoVV8oR+FCokqa1SQaIeDlt3fbsyPbYdz1TjGba/2rQ4JPACmcb6klI
 4a6KvAzq+4htm3dN5i0RBR/0JQ/bQwNtR1ijtXBlZOIkTNC/vOGuB1FEj9KiK9JjUrnS0i
 F5vzSZTr+NpgvdApBtu5WDCNxkcXQmNxMw9npAJ7J85YhmBuOnjqKPtCwjYc84t6SWs4Pz
 WVb3P3gjt4BjlhfLWaiEx+cAW2WYOo6EhaGwPUvPGtdPtt/vg9r9NIsfIxqg
X-ME-Proxy: <xmx:9hlxakEJ8NI73OCms71KlyoW_535nf2xttR0sCd0t7KeJvS3jpMocQ>
 <xmx:9hlxaqQU_fGv5tVAr7VYP-2dvpmbEIm0dl3iD_odEy4BwES_hSKxtQ>
 <xmx:9hlxapw_Zh2orwauUVXVOmkB-kWm08xkC67tFxJDyxwKgN14mLkMgg>
 <xmx:9hlxaufLvXUcbdCeqway6EdiwDeZptpKRgFrD7PlBKzAiWX1ex9S6g>
 <xmx:9hlxavv4wCdmm9LoeYup1lhl2fxepU8KH3-JNVj6DGeYGHeHafI1d8kX>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 18:45:06 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 4/4] hw/nvme: fix leak on copy ranges
Date: Mon,  3 Aug 2026 15:44:35 -0700
Message-ID: <20260803224436.38768-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803224436.38768-1-its@irrelevant.dk>
References: <20260803224436.38768-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

The buffer holding the ranges for the copy command is not correctly
deallocated.

Fix this.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4072
Fixes: 796d20681d9b ("hw/nvme: reimplement the copy command to allow aio cancellation")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8461b6fbdeae..4893cf7e7418 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2811,6 +2811,7 @@ static void nvme_copy_done(NvmeCopyAIOCB *iocb)
 
     qemu_iovec_destroy(&iocb->iov);
     g_free(iocb->bounce);
+    g_free(iocb->ranges);
 
     if (iocb->ret < 0) {
         block_acct_failed(stats, &iocb->acct.read);
-- 
2.53.0


