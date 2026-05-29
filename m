Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0F1CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4s1-0005GZ-Fg; Fri, 29 May 2026 17:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4r2-0003cj-RK
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:35:01 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qw-00032D-1m
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:53 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so9889137b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090469; x=1780695269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7t5cTU126FnpUwkoAoirKGUM08oblbAVX84J7t/Z2ng=;
 b=scWAMzRbSzoXGvXN+LOE1IMbJLY2KTBI1CIXLhlE3bG0iaQHU/G/7FBox6J+r0w47k
 HksjJTSm8ReNXcfG0AcwOJfEPkIctWFmVbn+VGeT5EO7lEUAFW29z7excKB2hIBZCiOU
 Uk2uYEPCssK7cc4/CX2LT7SauXUqDblif5HxsPiSitYQd6IYUeNl+EW04ypynggfCkvz
 3lnuuRE3csr9MCX8Xk3VN245BZMueMM+oJePHJ8IkKWZ38JoTqp1jG2TWYM3pXOkoC8y
 FgtXfNVQ0Zuo397hotWZ+7wKVsnDwS4zWlhNTYS6FDfGGqU9tQsNXauT1miQxLPC9xEc
 1Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090469; x=1780695269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7t5cTU126FnpUwkoAoirKGUM08oblbAVX84J7t/Z2ng=;
 b=HMYWiRscV+nZbslGD5Xs5IQFG5rZ5TW7secUmnRN1NJSHsCT85uJyHQIu+pdikNEdV
 n3oVDGxIjMkrvRLzzjdBtAHgENp79UULs0EsR93z8a4q8qlaDFBnlh4qU6LKxwQKEzG1
 Oj9Dyhz8Ne3ERcNjm/YOd9HkGCr0q7JX6P1cnbw0luhaRThUj7oeQRMxUIql7q8LM4MB
 cDJbw4U15RDbCTVFQInlfMYLznbCJth1ejTnt4k6vKZgW580PMdtqP0WFBKnD5Rni5qD
 sV8eV32q+dsBMeVlmqTzOi8QSHC5dlz85M+qx7wnjt0AigRy/G3tn7aI/OUDp/prP/UV
 G0zQ==
X-Gm-Message-State: AOJu0YxLR42HMmF26hf44aJGnDNgtuAk0XbqkLQxicLK5ufdSeEV1uaP
 33zF5bFsDkPLi2pt8eleigzVWcz2e04ucmlPBIycRrS6Zwrf8fsB10kxbYBAMAMxvZM=
X-Gm-Gg: Acq92OF5RKgsaJRBYjRMVtMZfbV0xoLyBvsCHohcWKJLmRMnVe6m0VJX7lxCHNcttju
 7SFFxbVy8nSLrgKvWZfu/cBSj+B1xJuF9GPMm3oniQXwt+ZhhmbcFZkr3AorJhbkTNy3Lg4R1B2
 YymnUWDJgUqbiji1MH0HgSvOnoMeuZeM5RLPPhrBmLN9hTKaCAF7bwlgkg1RozOi+veyl+mQajd
 SUMxf7YFp0DFKQ+Dq8H9vyfzCLWe6l+V6cRwZhU7SMTHzxZPqu20ksyokW4IodcypJoBZkiS7Qy
 kUxKTIGpnPg4xW3031J0XLTwUhBJO1ekDLKyrpS9/7EQ6AcAgmSqoikCwqAiLLKrZiwbvFU1aDz
 MTB4Gsz2eXxmnPG7cAdmP7YajjjK+a6nujxZWurTBbJZ4B85MExUREQwBuQU2XJIXgSUn/3N8N6
 Ra1GW6W/yRe9O25hBKOftSqjEyAGmIRLlVhhyFMBRoF7DWNgyY5/4NlKd4jgs1HL5ifFTU6oZFi
 A==
X-Received: by 2002:a05:6a00:3317:b0:83e:d996:92fa with SMTP id
 d2e1a72fcca58-8422535d027mr1224003b3a.11.1780090468907; 
 Fri, 29 May 2026 14:34:28 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.34.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:34:28 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 13/15] xen-block: Update tracking iothread users with
 holder name
Date: Sat, 30 May 2026 05:33:19 +0800
Message-ID: <20260529213321.96271-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x42b.google.com
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
 hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..b5bf8d359f 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,15 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+
         dataplane->iothread = iothread;
-        object_ref(OBJECT(dataplane->iothread));
-        dataplane->ctx = iothread_get_aio_context(dataplane->iothread);
+        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
+                                                          &io_holder);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
@@ -652,7 +658,14 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
 
     qemu_bh_delete(dataplane->bh);
     if (dataplane->iothread) {
-        object_unref(OBJECT(dataplane->iothread));
+        g_autofree char *path = object_get_canonical_path(
+                                        OBJECT(dataplane->xendev));
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+
+        iothread_put_aio_context(dataplane->iothread, &io_holder);
     }
 
     g_free(dataplane);
-- 
2.49.0


