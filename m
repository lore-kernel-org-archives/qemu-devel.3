Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B079C369C2
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Apr 2025 17:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6YId-0005QP-4n; Sun, 20 Apr 2025 13:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1u6XVm-0007Rk-Lh; Sun, 20 Apr 2025 12:27:19 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1u6XVh-0002IW-9F; Sun, 20 Apr 2025 12:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1745166414; bh=VI5REOPFWhvVlFkH2UY7J84EUU6wlp/5+XoSFMJOk/s=;
 h=From:To:Cc:Subject:Date;
 b=VuRWAiFkEAPyrnmF+rkXLLG+dcQQArGQFca0zmmrCmAs1XI//uQ95yWXgVmLoxKLZ
 AXDBtG/gGr+VcaGbDpmtKxGTiAWAfjUw6qwohhPzSu5MaeryeyrkuhsY8vu7LVu5+q
 0QGsa9ES82bT+ikYe6mizG95BWIrHa1ifK4qIi3o=
Received: from 192.168.182.133 ([117.147.34.50])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 4D09FAB9; Mon, 21 Apr 2025 00:19:16 +0800
X-QQ-mid: xmsmtpt1745165956tu3vc3sd6
Message-ID: <tencent_8649D99B33E6E6665A0EFA05B97592D70106@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoxEPmMs9FyeH1tgvtXUGo19ZHzbkt4qx2Imeoox7HJD4Zdgn0lw
 NbCMBS3BfGDlvV5CMfFwuEQl9apmxVt5DOM5N/hDN0BLDku76ojnRVfLpptz9sgNvJUaLxi5lQoE
 ceGno9eN/D2slObzLrQb0tl1CsJckSsJWxDxQH/C7EJunAqhQFiVmiPiSSFRPO8F5Bf3VqwyXHKt
 vO7QnRZGxr3wEISuIeChIyK4O1VlzlgxrtzWr7aqTRW72vaKm7TMpT7SIJXCetWOiYqskFjubY1T
 eb6J4E6V0PQGS3LiR+HFPzPTWIebwfH0tlSY330TXkqrIyiP8TvuIH4wRLQRz8hIdQ0AMeHCdOCD
 VPzZEbiJjhX/HXvxhl5cg7UcKahqKp0wJkpuDtHFcmRwpjYtdw8cDvAUK+rjootczndEak6FJLNR
 OF8LfsjnD7TzVRHZLzMW5Qtf0JFxfihQz3DodqGPC+rDfElyWaEZMR4JATXbBdcIKqTxFHuK3VX2
 pn+IlczamYZbmu53lA5YqtB7yGK2xDyBq53BUtqgZnT4SmZGwqsMiv3oopxeJCf1aZwL/66iKObz
 7gTqLVY/WDA60l7voA12oPR0/HMlzehGaahy5oAvCclmMthH8suIKKDxvxLd17PEVUZYYqLdHqkB
 RoI4qHKQ2A8lsK2laaxTQL590i/BrtLRc6oLb5R1jEJilh0E66NWwdjRmaAh+lmHweUHrg2/W7bF
 yDeBorLR6YPzBGL2GhbabHPOgQNOT4p6dOy57fuKltmYAaU6MDF/VfmDytqe4tvQxxbj8dJsNR4h
 GSQ4GGN4samU5Vh5BV+3yMBrIAGzRURrtJUCsApQTcHBk7b0PHLAeL9w/OLgcymifnIamrc2zWSL
 gIGjJ/tzyz7zioalr/lzKt/rvVKMcZuGRXZz2YbwMdZIoIbAXQPZnlAIVPNEFQRg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 Sunny Zhu <sunnyzhyy@qq.com>
Subject: [PATCH] =?UTF-8?q?block=EF=BC=9A=20change=20type=20of=20bytes=20f?=
 =?UTF-8?q?rom=20int=20to=20int64=5Ft=20for=20*bdrv=5Faio=5Fpdiscard?=
Date: Mon, 21 Apr 2025 00:19:14 +0800
X-OQ-MSGID: <20250420161914.25148-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.48; envelope-from=sunnyzhyy@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_PBL=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 20 Apr 2025 13:17:45 -0400
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

Keep it consistent with *bdrv_co_pdiscard.

Currently, there is no BlockDriver implemented the bdrv_aio_pdiscard() function,
so we don’t need to make any adaptations either.

Signed-off-by: Sunny Zhu <sunnyzhyy@qq.com>
---
 include/block/block_int-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index ebb4e56a50..4bf422d733 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -507,7 +507,7 @@ struct BlockDriver {
         BlockDriverState *bs, BlockCompletionFunc *cb, void *opaque);
 
     BlockAIOCB * GRAPH_RDLOCK_PTR (*bdrv_aio_pdiscard)(
-        BlockDriverState *bs, int64_t offset, int bytes,
+        BlockDriverState *bs, int64_t offset, int64_t bytes,
         BlockCompletionFunc *cb, void *opaque);
 
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_readv)(BlockDriverState *bs,
-- 
2.43.0


