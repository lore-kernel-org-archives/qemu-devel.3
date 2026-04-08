Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853FC10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXiX-000417-CX; Wed, 08 Apr 2026 14:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wAXiU-0003sL-67
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:33:30 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wAIr3-0001Op-MV
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 22:41:24 -0400
X-UUID: 6332da1632f411f1aa26b74ffac11d73-20260408
X-CID-O-RULE: Release_Ham
X-CID-RULE: EDM_GE969F26
X-CID-O-INFO: VERSION:1.3.12, REQID:9a123e84-91a9-40e1-a4a1-3dfa735fc3e4, IP:15,
 URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
 TION:release,TS:-20
X-CID-INFO: VERSION:1.3.12, REQID:9a123e84-91a9-40e1-a4a1-3dfa735fc3e4, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GE969F26,ACT
 ION:release,TS:-20
X-CID-META: VersionHash:e7bac3a, CLOUDID:fe676f893e334d42bcaa6a352d991b70,
 BulkI
 D:260408104105X6V6V9AL,BulkQuantity:0,Recheck:0,SF:10|66|78|101|102|123|12
 7|850|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
 l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
 :0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6332da1632f411f1aa26b74ffac11d73-20260408
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 526151136; Wed, 08 Apr 2026 10:41:04 +0800
From: zhaoguohan@kylinos.cn
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] ui/input-linux: close evdev fd when qemu_set_blocking fails
Date: Wed,  8 Apr 2026 10:40:24 +0800
Message-ID: <20260408024024.606222-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

input_linux_complete() opens the evdev node before switching it to
non-blocking mode. If qemu_set_blocking() fails, the function returns
without closing the file descriptor.

The finalize path only closes initialized devices, so this leaks the fd
on an error path.

Jump to err_close when qemu_set_blocking() fails so the descriptor is
released before returning.

Fixes: c7b1172026a0 ("ui: replace qemu_set_nonblock()")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 ui/input-linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index c16726a3b799..74bc8511428a 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -316,7 +316,7 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
         return;
     }
     if (!qemu_set_blocking(il->fd, false, errp)) {
-        return;
+        goto err_close;
     }
 
     rc = ioctl(il->fd, EVIOCGVERSION, &ver);
-- 
2.43.0


