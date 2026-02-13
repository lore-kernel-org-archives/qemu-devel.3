Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34849EEA870
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 00:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqghA-0002Mm-Oq; Thu, 12 Feb 2026 19:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=laZO=AR=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1vqgh6-0002MS-BP
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:06:01 -0500
Received: from sonata.ens-lyon.org ([140.77.166.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=laZO=AR=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1vqgh3-0000bD-Qk
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:06:00 -0500
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id C9C30A20EC;
 Fri, 13 Feb 2026 01:05:53 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNEOfth1pPVT; Fri, 13 Feb 2026 01:05:53 +0100 (CET)
Received: from end (aamiens-653-1-40-48.w83-192.abo.wanadoo.fr [83.192.199.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id AD8D0A1BDB;
 Fri, 13 Feb 2026 01:05:53 +0100 (CET)
Received: from samy by end with local (Exim 4.99.1)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1vqggz-0000000AGWM-14kA; Fri, 13 Feb 2026 01:05:53 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: [PATCHv2] baum: Add copy/paste bindings
Date: Fri, 13 Feb 2026 01:05:51 +0100
Message-ID: <20260213000551.2446777-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=laZO=AR=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Brltty interprets

- TL1 (i.e. Display1) + routing as clip new
- TL2 (i.e. Display2) + routing as clip add
- TR1 (i.e. Display4) + routing as copy line
- TR2 (i.e. Display5) + routing as copy rect

https://github.com/brltty/brltty/blob/master/Tables/Input/bm/routing6.kti

- BAUM_TL1+BAUM_TL2+BAUM_TL3+BAUM_TR1 (i.e.
Display1+Display2+Display3+Display4) as paste

https://github.com/brltty/brltty/blob/master/Tables/Input/bm/d6.kti

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 chardev/baum.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/chardev/baum.c b/chardev/baum.c
index 157f8b9519..57fe60fe18 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -1,7 +1,7 @@
 /*
  * QEMU Baum Braille Device
  *
- * Copyright (c) 2008, 2010-2011, 2016-2017 Samuel Thibault
+ * Copyright (c) 2008, 2010-2011, 2016-2017, 2026 Samuel Thibault
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -564,6 +564,30 @@ static void baum_chr_read(void *opaque)
                 baum_send_key(baum, BAUM_RSP_RoutingKey, (code & BRLAPI_KEY_CMD_ARG_MASK)+1);
                 baum_send_key(baum, BAUM_RSP_RoutingKey, 0);
                 break;
+            case BRLAPI_KEY_CMD_CLIP_NEW:
+                baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TL1);
+                baum_send_key(baum, BAUM_RSP_RoutingKey, (code & BRLAPI_KEY_CMD_ARG_MASK)+1);
+                baum_send_key(baum, BAUM_RSP_RoutingKey, 0);
+                baum_send_key(baum, BAUM_RSP_TopKeys, 0);
+                break;
+            case BRLAPI_KEY_CMD_CLIP_ADD:
+                baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TL2);
+                baum_send_key(baum, BAUM_RSP_RoutingKey, (code & BRLAPI_KEY_CMD_ARG_MASK)+1);
+                baum_send_key(baum, BAUM_RSP_RoutingKey, 0);
+                baum_send_key(baum, BAUM_RSP_TopKeys, 0);
+                break;
+            case BRLAPI_KEY_CMD_COPY_LINE:
+                baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TR1);
+                baum_send_key(baum, BAUM_RSP_RoutingKey, (code & BRLAPI_KEY_CMD_ARG_MASK)+1);
+                baum_send_key(baum, BAUM_RSP_RoutingKey, 0);
+                baum_send_key(baum, BAUM_RSP_TopKeys, 0);
+                break;
+            case BRLAPI_KEY_CMD_COPY_RECT:
+                baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TR2);
+                baum_send_key(baum, BAUM_RSP_RoutingKey, (code & BRLAPI_KEY_CMD_ARG_MASK)+1);
+                baum_send_key(baum, BAUM_RSP_RoutingKey, 0);
+                baum_send_key(baum, BAUM_RSP_TopKeys, 0);
+                break;
             case 0:
                 switch (code & BRLAPI_KEY_CMD_ARG_MASK) {
                 case BRLAPI_KEY_CMD_FWINLT:
@@ -606,6 +630,10 @@ static void baum_chr_read(void *opaque)
                     baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TL1|BAUM_TL3|BAUM_TR1);
                     baum_send_key(baum, BAUM_RSP_TopKeys, 0);
                     break;
+                case BRLAPI_KEY_CMD_PASTE:
+                    baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TL1|BAUM_TL2|BAUM_TL3|BAUM_TR1);
+                    baum_send_key(baum, BAUM_RSP_TopKeys, 0);
+                    break;
                 }
             }
             break;
-- 
2.51.0


