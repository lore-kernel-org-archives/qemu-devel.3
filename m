Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570F6CC6B03
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 06:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Bxh-0007tH-74; Thu, 02 Apr 2026 02:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanlonglong@kylinos.cn>)
 id 1w8BxV-0007lH-5d
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 02:55:20 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanlonglong@kylinos.cn>)
 id 1w8BxR-00019f-LU
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 02:55:16 -0400
X-UUID: e020c9b82e6011f1aa26b74ffac11d73-20260402
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:e080712c-03ef-4ded-8b5e-f62e8789f31f, IP:0,
 U
 RL:0,TC:0,Content:45,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:45
X-CID-META: VersionHash:e7bac3a, CLOUDID:35c39faf64244d1a6d1fa23e11e25979,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:3|15|50,EDM:-
 3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e020c9b82e6011f1aa26b74ffac11d73-20260402
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yanlonglong@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 2035260461; Thu, 02 Apr 2026 14:55:03 +0800
From: yanlonglong <yanlonglong@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: yanlonglong <yanlonglong@kylinos.cn>
Subject: [PATCH] keyborad: Since the qemu_input_map_qnum_to_qcode array has a
 length of 254, the values in the keycodes array exceed the valid range
Date: Thu,  2 Apr 2026 14:54:51 +0800
Message-Id: <20260402065451.20380-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=yanlonglong@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Signed-off-by: yanlonglong <yanlonglong@kylinos.cn>
---
 ui/keymaps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index 2359dbfe7e..7815c4e6d3 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -249,7 +249,7 @@ int keysym2scancode(kbd_layout_t *k, int keysym,
          */
         for (i = 0; i < keysym2code->count; i++) {
             QKeyCode qcode = qemu_input_key_number_to_qcode
-                (keysym2code->keycodes[i]);
+                (keysym2code->keycodes[i] & SCANCODE_KEYMASK);
             if (kbd && qkbd_state_key_get(kbd, qcode)) {
                 return keysym2code->keycodes[i];
             }
-- 
2.43.0


