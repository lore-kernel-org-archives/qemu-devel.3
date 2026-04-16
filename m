Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96986F88090
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDGmd-0003Kl-3o; Thu, 16 Apr 2026 03:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wDGmT-0003KG-Hc
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 03:04:54 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wDGmO-0004pD-Ao
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 03:04:51 -0400
X-UUID: 84067940396211f1aa26b74ffac11d73-20260416
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:a9b10825-9082-48c8-aa9d-6cb95c66120a, IP:15,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:25
X-CID-INFO: VERSION:1.3.12, REQID:a9b10825-9082-48c8-aa9d-6cb95c66120a, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:25
X-CID-META: VersionHash:e7bac3a, CLOUDID:247a52d111046b70ca1fa76359c609cd,
 BulkI
 D:26041615043204L66S11,BulkQuantity:0,Recheck:0,SF:10|66|78|101|102|127|85
 0|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
 :nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
 RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 84067940396211f1aa26b74ffac11d73-20260416
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 954091410; Thu, 16 Apr 2026 15:04:30 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] ui/clipboard: clear deferred serial reset flag on resume
Date: Thu, 16 Apr 2026 15:04:03 +0800
Message-ID: <20260416070403.1683648-1-zhaoguohan@kylinos.cn>
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

cb_reset_serial_on_resume defers a clipboard serial reset until the
machine runs again. qemu_clipboard_change_state() performs that reset
on resume, but leaves the flag set.

As a result, every later transition back to RUNNING triggers another
QEMU_CLIPBOARD_RESET_SERIAL notification even when no reset is pending.
That causes unnecessary reset handling in clipboard backends such as
vdagent and dbus.

Clear the deferred flag before resetting so the reset is performed only
once for each deferred request.

Fixes: c967ff606b99 ("ui/clipboard: delay clipboard update when not running")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 ui/clipboard.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index ec00a0b8ec75..e3d8a31ba9f7 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -47,6 +47,7 @@ static void qemu_clipboard_change_state(void *opaque, bool running, RunState sta
     }
 
     if (cb_reset_serial_on_resume) {
+        cb_reset_serial_on_resume = false;
         qemu_clipboard_reset_serial();
     }
 
-- 
2.43.0


