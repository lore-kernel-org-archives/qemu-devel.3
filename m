Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0663DF33A71
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9eG-0004Ud-3t; Thu, 05 Mar 2026 09:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9eC-0004Dk-58
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:52 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9eA-0001ol-PB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:51 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ae43042ea7so54279785ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720749; x=1773325549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8YmwLzreE+b+qF7nmKqGZoFmuE8vtySMC0gctDt5HQ=;
 b=YjczrPpXpSGVQ+4ByFQk0Fs5x6jY63/UPsvUTggV7u4yiu1GFjKpkfoIniyzNIUyha
 HrwWgU0QXoXO7/qcPdESwjRR1oqPbGXk5UO48/G3keWGo2PraauR8Yat+yI4cK2v5tpL
 JzqYfpcMZLbS1xk5JMEnsv7T6A0pZqzKyAg59/3x2AivzcjywtGos8hnUSQKQ52ERbHL
 Ihz506TiGQnwG+d4nw9CPrbDIkIp/pf9lq4DSsXZBdIuPtlk/eE+69EHxMTwCeDU2rZX
 pw4dY0aXZjnwkmjFvGN2qWw9+AE/XVAjsrOZYUp7aqFOAod+DGpN5aclQSGUfGyKAUUb
 C/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720749; x=1773325549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x8YmwLzreE+b+qF7nmKqGZoFmuE8vtySMC0gctDt5HQ=;
 b=o0ppSlogSH8tw5pLLi3SSdvHpms6lQRBzupSu9Co+Eu+DhJi8NnN4S8kVlhLcMaOP/
 N8LDHoZkydgvpj/oFedT5Q48QIDeRR1/Ja5Y/vFer+OWFiFUsOnSyKPSS2dhBcNXrWYB
 E7g+zIljYWylMYhOCYVdlugW8gJpB6vNkR5KM+m0+VBVNCm6Vp6im5pZSEOtkbNEg6q/
 vRCB7+AXXcZL1qHEnYvyrVvGGDwrJ7pIxU4jRVTRE102pdEaP7WB1xluIe/Tn4yTpa/T
 I/e7FDVLBGp0EbVujAKZJ5RpPPhpSUn73m1aiPlGOIuAE7/zwy6Oa+uMY2pIf7JG02j/
 Wq4w==
X-Gm-Message-State: AOJu0Yx9Vfy3zHAcrkny5C37q9kN9OTTphxY+n5l6HIi8PSw1t7HYfhZ
 3+xMTed71V17D7VxLaD8irbl1wChyKQDLpOxqbRQRYjMfc0I/eb1AhJvHY/Jbe2icDbIXg==
X-Gm-Gg: ATEYQzwaA/6wrnlhR9AqB+C6oKZjz0ZGQCbQK3JrTjX3WUa08Suzx/cSSk1O3NC66/b
 g9TVakce/WCbvMjdPFPB1yS9tKFi1oj9FnWCoEcbAd3Ogms9DjDWdfRnTeJ1fmrw7kwHqtNh2RF
 KWWir12KgtspR4/mZ470Nz8E0jjHt56IQBf+MBWmy20VIXt079yW6MEHqWCJ1iBEzIDcKt3cxb8
 R60iMToe4k8xsMTPnzD93td7PhYApOp7seLW3BcfskyShcI3NB0V/o1XlQVjzvc+Xs+cNZa+UTc
 /ghVDq4qVgHhVMLUk8xpS1GwjSh+8hZL135QZSp/UhdjIQKUbvfscCwSybj3R+pwCNSDipqUWhd
 Y+MrCnHhCD0eb/yF0GA0UsFsdazrzhha+etBXn5nE9bIt1nMQewIMN2EmaEEj2aXbYo/Iwtn0Tr
 ICI5Dw5U1Zyzd0+9HP4ptXGAh3CLOK5Sb1hHE+8u0nV2xV85NY9hx/SRCOh1iL3NwDWE4=
X-Received: by 2002:a17:903:2c04:b0:2ae:4fc2:d951 with SMTP id
 d9443c01a7336-2ae6aaae1e1mr63884255ad.27.1772720748793; 
 Thu, 05 Mar 2026 06:25:48 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:48 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 12/13] xen-block: Update tracking iothread users with
 holder name
Date: Thu,  5 Mar 2026 22:24:58 +0800
Message-ID: <20260305142459.52559-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Replace raw object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/dataplane/xen-block.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..a14de14274 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,11 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        char *path = object_get_canonical_path(OBJECT(xendev));
+
         dataplane->iothread = iothread;
-        object_ref(OBJECT(dataplane->iothread));
-        dataplane->ctx = iothread_get_aio_context(dataplane->iothread);
+        dataplane->ctx = iothread_get_aio_context(dataplane->iothread, path);
+        g_free(path);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
@@ -652,7 +654,10 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
 
     qemu_bh_delete(dataplane->bh);
     if (dataplane->iothread) {
-        object_unref(OBJECT(dataplane->iothread));
+        char *path = object_get_canonical_path(OBJECT(dataplane->xendev));
+
+        iothread_put_aio_context(dataplane->iothread, path);
+        g_free(path);
     }
 
     g_free(dataplane);
-- 
2.49.0


