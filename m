Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29EBC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x69wW-00061L-GV; Mon, 14 Sep 2026 12:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1x69vc-0005ij-Sg
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:53:16 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1x69vb-000502-49
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:53:12 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 b225908acc2c2c0d65c46a1a9838500d22be502cb055cae52aacdcc33c869989 with SMTP id
 6aa82675729365b27e49d2e8; Mon, 14 Sep 2026 16:53:09 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1789404788;
 bh=3ZWutabqtiKt2Hw2LzOO58uiVuv3vhlpdieVokNriiI=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:X-Developer-Signature:
 X-Developer-Key:Content-Transfer-Encoding:From:Reply-to:Subject:
 Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=EGyR+ruudYM99CSr2MoSDOb4fBC19Q4ix99Q+GbjfiHP2OC5EytKv01krvoxyK0fn
 +vBcMwWqk2UNsRL/wfUvxjunGVxzT0BJ1suBlIEnKTU4+2AI4PVvRi9Q8+fWyNTVH3
 QWKCP2nBjtvsamvlvNIccrbEZWoXvlMj5vcVp6SxpDMxVBcXoauDrDPQjGNNsOd8nG
 ZNVGCIEpJJGbCRREH7cnRzZyvRl4qXmwpY5CgQ8+WfxzVFAKuOJTpTdG1+vH/EM890
 IT6pVs2yVHtZhGkRDiGXuaGkgicPBD4zrWKOoJe9UB18Urokp7FtPSLeEMCbg6jwpq
 JjCNvqIlISV0Q==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: "Yodel Eldar" <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH 1/2] contrib/vhost-user-bridge: Use stderr for debug output
Date: Mon, 14 Sep 2026 11:52:49 -0500
Message-ID: <20260914165250.88382-2-yodel.eldar@yodel.dev>
In-Reply-To: <20260914165250.88382-1-yodel.eldar@yodel.dev>
References: <20260914165250.88382-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; i=yodel.eldar@yodel.dev;
 h=from:subject; bh=YN613ctGLZV10xyGS25WuN25/EFMnZF8UR53VHZ7fuw=;
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGLJWqFZH/NGQ23dqVrARk8xSzqCPG5W77OJOp3kYveNTn
 /bojM31jlIWBjEuBlkxRZbLZyXOOuTu7kpb+eM+zBxWJpAhDFycAjCRNXcZGRasCl5z1ojjUHPW
 6QueVgcvzeLu0RaaJPttTscBxeoo0w8M/93+da9bZ3ChkNt92sf1y2YasMWdXhzpLRTzRV1H9Oa
 ZAHYA
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

Since vhost-user-bridge is solely used for testing, and
logging to stderr ensures proper interleaving of debug
output in automated testing, modify the DPRINT macro to
write to stderr instead of stdout.

Message ID of relevant thread:
<20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 contrib/vhost-user-bridge/vhost-user-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vhost-user-bridge/vhost-user-bridge.c b/contrib/vhost-user-bridge/vhost-user-bridge.c
index 3f0fd0fa49..a6f7ec226c 100644
--- a/contrib/vhost-user-bridge/vhost-user-bridge.c
+++ b/contrib/vhost-user-bridge/vhost-user-bridge.c
@@ -41,7 +41,7 @@
 #define DPRINT(...) \
     do { \
         if (VHOST_USER_BRIDGE_DEBUG) { \
-            printf(__VA_ARGS__); \
+            fprintf(stderr, __VA_ARGS__); \
         } \
     } while (0)
 
-- 
2.55.0


