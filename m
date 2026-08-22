Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9655C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtMa-0003yH-Rm; Sat, 22 Aug 2026 17:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMX-0003wh-PC
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:49 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMW-0000lN-7e
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cab973140bso29053075ad.3
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434487; x=1788039287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YzyunjGqwnVL4+zZqn+0tH9PAMSOhSLwwJCF0/mtHPY=;
 b=a3kiPmOxgOLf/3M6lDmgM9xrnj8UNlKtM5LHyUjectUYOOhzA9f/XwQxu7Lim5RVwI
 DZhNgWQYM+SwCX6koWYtEuck7XxKNckCgQxn1vX1rXH6w7kHTjPz2udEH86ANDd58/oy
 5WXFi+3ptA4l52Hn1J4DbpdhwZB4Qi602dQDN8jzd2uzbQTgxUqRO3NtLEL3ETl/wUtE
 0cdA3quTn/XyjjHG9NAmugF0mHs5naIRkvXkMKmpyLliFxlbD0c1w6aX93VWXfwW6uFI
 aFml53Udq8ji0Oarcu+bfgP1oZMU51DleiGL7D86bQV0ttbcMvi4nQ8+da0jPJ35y9Uu
 i/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434487; x=1788039287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YzyunjGqwnVL4+zZqn+0tH9PAMSOhSLwwJCF0/mtHPY=;
 b=iv//iKH5h3G2NFL2KuZLXuOUk8xWe12up/5omS/wG1+n1tAuyZ8s5JhVwih0Lv0ky0
 Vj3dUZE/ibMk1PjZoY80D4x5Fd/pZcRtR7iuilVQRrfFtYe5fzLehCvD2o3VMS/AYCPs
 mNguRC5aLncVchkcpfC6IB4smlV1THeP4q4DJ6XNmJo2fYfi3JFJ8rsPoFs0nnnStdVa
 2AasgzjlS7z2thW5mKoLlt3e4HL6XavGgNTGiA8Yd5DnJdD2+8m34ggzLO0fvXAHiq9/
 mAuoSmmkMyQ1s8k8D8wdn4J8qY33/BRLPHB8cdJyVnVJmYBO8xczGCOCzsjU+CuQ+4Pi
 kMBw==
X-Gm-Message-State: AFuF++mGLM7rZfZUUIcm+SCtBN8AxctwqN3ABKTgtOVq9mRT5yIAnR9J
 X5IbC9TOXdsicmtul09j9UdsnbxpQEGjIkZ2uoOqB8gxVyGH3M+nZeEEDnF9zThVJsNeTt4B
X-Gm-Gg: AR+sD11EXXG3LB0Ytx0chfcjr/V0XRsNNvRL3FlNkLCDarJ57j/pKoXGvFB8R2YbXh4
 cXGvD39R815fzI3FT6/x6GiaWDoie5C4Rx6HC6XeSfyxcMJeIpnvsJDj/BldenAUrWda7vwGae5
 KUHW3bhXYybAbnUmX6Zdcy1nK797/bALyYwFM4omLTDDeevrTtxucUsSN+zKKq9AItMgCC5ptuJ
 9BWw7nUp31ic9JYD70K7NUW5DP7z6WO4O60XnjIWuJeuU1FULbg2jDoR1sFLS2YtUXFz4ObZqCi
 FGBiJV3BfPzXenQuWV3PegF/aH1TYWCTUP/Up6IJ3b3JtIwfMbNsBpEvm02dVQu6aNXv0nW8F+I
 S6saEnpeS8zbng2WHgYwEYzf7sNGivoSWb2vORH7VGD/4ebO93MIJr7XQlbQ43GRtGUtak8N8uS
 KHxCEZ/cdQgqskDmYtFneTLRNmRsbbxqKFd9rVhLbCoyRegcXBVbn+Y8gvXF7SUicf6vJCAb8JZ
 I60w/59hWR3AqXoA9k=
X-Received: by 2002:a17:903:1843:b0:2d6:3c22:993a with SMTP id
 d9443c01a7336-2d670b4c97fmr153787725ad.3.1787434486761; 
 Sat, 22 Aug 2026 14:34:46 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:46 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 12/15] xen-block: Update tracking iothread users with
 holder name
Date: Sun, 23 Aug 2026 05:33:35 +0800
Message-ID: <20260822213343.661939-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..9dfe06e1be 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,15 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
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
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        iothread_unref_and_put_aio_context(dataplane->iothread, &io_holder);
     }
 
     g_free(dataplane);
-- 
2.55.0


