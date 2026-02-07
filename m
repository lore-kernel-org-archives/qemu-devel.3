Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D94EE0AEC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 22:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vorDo-0001ct-Ts; Sat, 07 Feb 2026 17:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=SWPb=AL=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1vorDl-0001Yw-IX
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 17:56:09 -0500
Received: from sonata.ens-lyon.org ([140.77.166.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=SWPb=AL=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1vorDj-0007gc-7s
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 17:56:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 4AE91A74FE;
 Sat,  7 Feb 2026 23:56:02 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oD1A9ozKHHPW; Sat,  7 Feb 2026 23:56:02 +0100 (CET)
Received: from end (lfbn-orl-1-1611-126.w90-107.abo.wanadoo.fr
 [90.107.165.126])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 1CA67A74FF;
 Sat,  7 Feb 2026 23:56:02 +0100 (CET)
Received: from samy by end with local (Exim 4.99.1)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1vorDd-00000004DOW-2o2M; Sat, 07 Feb 2026 23:56:01 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com,
 jan.kiszka@siemens.com
Subject: [PULL 1/1] baum: Add copy/paste bindings
Date: Sat,  7 Feb 2026 23:56:00 +0100
Message-ID: <20260207225600.1004788-2-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260207225600.1004788-1-samuel.thibault@ens-lyon.org>
References: <20260207225600.1004788-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=SWPb=AL=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
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


