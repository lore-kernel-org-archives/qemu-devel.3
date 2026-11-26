Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CC606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J8/t4VKT;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dZxH26Mw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWfs1-0007Yy-KT; Thu, 26 Nov 2026 15:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWfro-0007Yc-Q7
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:14:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWfrm-0000Ja-Vo
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795724090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qU8UnYephEeunY0mdr0CgbXtGk/NsxR8QTX+xWd5mUg=;
 b=J8/t4VKTAeIUE2XbwNd1qD9oJH9YX5xHC93spHZwIx0sLKkAz9378qDFJC/DWCfu8xudOb
 58dYwxCRoAWvLhCTvSKMijIOJ6NDmsB8SOxuE5uX/MQz4oEJ3Iz8Txk+mVK5tUawaq8B6C
 m3TeHgFJ4kKrrJC2mbeTpPytMaRpLeM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-_ClVvlCIOTGXcVbQNOjVdA-1; Thu, 26 Nov 2026 20:14:48 +0000
X-MC-Unique: _ClVvlCIOTGXcVbQNOjVdA-1
X-Mimecast-MFC-AGG-ID: _ClVvlCIOTGXcVbQNOjVdA_1795724087
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2005ce21so1141270085a.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 12:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795724087; x=1796328887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qU8UnYephEeunY0mdr0CgbXtGk/NsxR8QTX+xWd5mUg=;
 b=dZxH26MwmTz+uKRhswXPUTUD0pBZoeNKJwy32rjb7CykZZ/tiKGEt822qYNA/FSKYy
 vuoe8vGMSbzt6MnCr6R71stbcOSbbqLnuO3ACjEakacpeeyIEgd2ParuhbhSCRjbk9cO
 SKO2HsOlD46BuTLwk6BYAwov9oFCBqG1aphdYVMoseYo0KkqV6/IW5LbHbDGlONrY3dv
 UESKoIfSP8nF4hxHfc8ZKxT09biP/UQpeNaZYtEo/oreZwaNePTth5RPoqihUpZ/0F73
 6AloFdDpuTaOAzqXNOYmbJK6vPNrdNdumlr1L4ZY36lbRnG2ReY/CVdh/VggVB8TCLXg
 GydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795724087; x=1796328887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qU8UnYephEeunY0mdr0CgbXtGk/NsxR8QTX+xWd5mUg=;
 b=w/feiYVvyM5U3t53UmActdTnYW3SDbkByWgduQKiOnFR3nqYzxuJ4aBnhQmXXY7a2l
 FikaeAZo1+XiCVrwHwpFTO39HC00JqJ02tCAWntoW9/IPMcFVcdqaThkjpeJ6BiKtHdB
 AMPMtMU0BavbRsJFSlRA3bJwgzCENMA+E18JrORhfp9VHTSwzpM+ga8W7Ye2SKWHfvSk
 kKF7Isxnzd277lnShQBPTBRIT5V+b6tos1KF6fGSd3VfHsOnLrKpP8y6b+agpqryqIy9
 1vRE1W3kFZLErZjK9bsI6nDqAGalfFVsEblgph/A/TF6g3IJ0YVbSjXcvcOqykqIt0Q3
 fFrQ==
X-Gm-Message-State: APuU4Z/JypatUKI2ss+dIICmQChyBH2Nd/eICoycSLlHLNiCDyyb05C1
 uuKPxunWftkPmeA0rJ/85k1OiZ3hKQUn1FSdt0hdMlKp5JIHeb9dAQsB2a3cFir2ztih4M2Az+Z
 skxvYv6tMYVq50NVORrtYMjSoRzEkQyz9zE/Gol0E2w99jPlyvLmNRq6Q3aAuybclmhhm9gXYEn
 lhGILJckdq5JRjC8RDrZUY0aLZAHn4EM0fUhNQpg==
X-Gm-Gg: AZFdTZdDrnKt0lHo7INyQS4cI6xL755YcWIogqJwF++8AD074ww3OagKOIgXiXN0apD
 bIU0aFSyAquscwOWviYoGU5206si9Pj9CrNbKUnSuz0r/R1k1a14ORFb34c5FbEgM8BBLsHvtoI
 DGZOaDntbfCTTxk2mKjf8sfWtCBQAo+W5Mkq7J1nLdLR8psLZyfCJ+JNEmZ6yfb4me2V3RVCQeU
 cDSoGyfAUIK76mgNlG8IVOfLR1LDcmB/vFgYNujY0UDgupd1nd1yBhNzwTZEATtb626Wr/TrSnW
 0V9fODF8gjKlKnUsvU3DyeQGQsujkK1NBeXz//VlwQFFKbJZi2hrUtPQwVHED+1j0VFUDQFfSgf
 dfGeDSxjt38d4sV7/LOOaGTZM0dz0PJ31Svb8eEkxMFra
X-Received: by 2002:a05:620a:4551:b0:93e:94f2:ada5 with SMTP id
 af79cd13be357-949ba965b93mr3862880385a.25.1795724087343; 
 Thu, 26 Nov 2026 12:14:47 -0800 (PST)
X-Received: by 2002:a05:620a:4551:b0:93e:94f2:ada5 with SMTP id
 af79cd13be357-949ba965b93mr3862873785a.25.1795724086789; 
 Thu, 26 Nov 2026 12:14:46 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb427388sm1638267685a.42.2026.11.26.12.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 12:14:46 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Hongyan Xu <getshell@seu.edu.cn>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: [PATCH for-12.0 v3] coroutine: Make yield_until_fd_readable() detach
 fd handler always
Date: Thu, 26 Nov 2026 15:14:45 -0500
Message-ID: <20261126201445.3326530-1-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hongyan reported a possible use-after-free of RDMA migration code:

https://lore.kernel.org/all/20260904033130.276-1-getshell@seu.edu.cn

The issue seems real, while this patch is a proposal to fix it in a simpler
way, meanwhile it should be a problem to the yield_until_fd_readable()
helper in general, so it should make more sense to be fixed there too.

The problem is about the use of the stack allocated FDYieldUntilData where
we must make sure after yield_until_fd_readable() returns it's not used
anywhere.  If the coroutine yielded can be entered from outside of this
helper (fd_coroutine_enter()), then the aio handler might be installed even
after yield_until_fd_readable() returns, and that makes the stack variable
accessible by aio codd, even if stack gone.

Fix it by moving the aio handler removal outside the handler.

Fixes: 923709896b1b ("migration: poll the cm event for destination qemu")
Reported-by: Hongyan Xu <getshell@seu.edu.cn>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Cc: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- Drop FDYieldUntilData altogether [Kevin]
- Drop the comment, doesn't feel as helpful now [myself]
v3:
- Add doc for the helper [Stefan]
- Add Fixes [Stefan]
---
 include/qemu/coroutine.h |  5 ++++-
 util/qemu-coroutine-io.c | 20 +++++---------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 1c31de60f9..6b34dc750c 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -279,7 +279,10 @@ void qemu_co_sleep_wake(QemuCoSleep *w);
 /**
  * Yield until a file descriptor becomes readable
  *
- * Note that this function clobbers the handlers for the file descriptor.
+ * Notes:
+ * (1) this function clobbers the handlers for the file descriptor.
+ * (2) this function may be interrupted by another re-enter of coroutine,
+ *     the caller needs to be prepared on fd not readable after returned.
  */
 void coroutine_fn yield_until_fd_readable(int fd);
 
diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
index 364f4d5abf..720d27d737 100644
--- a/util/qemu-coroutine-io.c
+++ b/util/qemu-coroutine-io.c
@@ -65,28 +65,18 @@ qemu_co_send_recv(int sockfd, void *buf, size_t bytes, bool do_send)
     return qemu_co_sendv_recvv(sockfd, &iov, 1, 0, bytes, do_send);
 }
 
-typedef struct {
-    AioContext *ctx;
-    Coroutine *co;
-    int fd;
-} FDYieldUntilData;
-
 static void fd_coroutine_enter(void *opaque)
 {
-    FDYieldUntilData *data = opaque;
-    aio_set_fd_handler(data->ctx, data->fd, NULL, NULL, NULL, NULL, NULL);
-    qemu_coroutine_enter(data->co);
+    qemu_coroutine_enter((Coroutine *)opaque);
 }
 
 void coroutine_fn yield_until_fd_readable(int fd)
 {
-    FDYieldUntilData data;
+    AioContext *ctx = qemu_get_current_aio_context();
 
     assert(qemu_in_coroutine());
-    data.ctx = qemu_get_current_aio_context();
-    data.co = qemu_coroutine_self();
-    data.fd = fd;
-    aio_set_fd_handler(data.ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
-                       &data);
+    aio_set_fd_handler(ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
+                       (void *)qemu_coroutine_self());
     qemu_coroutine_yield();
+    aio_set_fd_handler(ctx, fd, NULL, NULL, NULL, NULL, NULL);
 }
-- 
2.56.0


