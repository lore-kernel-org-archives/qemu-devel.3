Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859C606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TGe7QPIw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL5C9-0000TA-5g; Sun, 25 Oct 2026 16:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xL5C6-0000Rq-0J
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 16:51:54 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xL5C4-0006AQ-Aw
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 16:51:53 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-35829219da8so4284898eec.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 13:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792961509; x=1793566309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z9Kta+KfCkcQOsZgYvT+246Jbv94ngM6lu0pdvr/gF8=;
 b=TGe7QPIwxnmIykt01ngF6i3CWNn52xR7nto9OUrLx9KVw32eRfzdUMzDGsEFfuB/SE
 eG3pfcFDigBNSWy3lpHd4Ba7v8Jqs1az84KYhUlz13745Q/8pkgS4BIZVi3QKZ0CxdtJ
 +xOHye21tQt1RE6xXVek6obU4hiYjDy62uSfgZYr1pWw/LLvbpvzUnD412brVCCThE7L
 pNMz2M09MMqatHLo26B/a2CiJ95b7heImU+XVSggAw4IZ1z2NV33ONSV0OfVPZZuH69T
 Y9PAqy5ix5w45d2Ayi3PgEvXZ3LwrnEqDOgZmApcknzK8jZI8B45VgmBNyq5jZt6sjp5
 QJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792961509; x=1793566309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z9Kta+KfCkcQOsZgYvT+246Jbv94ngM6lu0pdvr/gF8=;
 b=VjA8Dyq3RMfVqMIjJt/RSS3l+Xrbw0OGePg5wgtNleFeusWIpm2gyNLpoqqtzgQkBH
 2UgCX6g/u+i7V48r+zV/6z9QTCDSeomnB00qkBMFYbxYv8pdtOAR+YyHKgxvUhBflpz+
 k0GuedCQeu4Ewih4vP0tdj6HglFqBFpjAVjw5UZJFXjJwXpGwODasuNLQLaZ/UZyEwdA
 XarcjIFrjJB8PJEb0e9JL8Z+J9EUid9S4klZ5R5IiNTOooegzNcCUY55U1S8qW3Vhs+D
 PKjMwUV1/zOU5KBfz8yQ83jeE+OIZnYIvwRwHOqVZbfNWv7LWJAAY972yk5pKhf+fBBe
 mujg==
X-Gm-Message-State: AFq9FYICpKr2cf5buryG8Y8g+DZtAKDXDaOy6kQcu13o4FClFm9eb+2A
 RxonqN9dpXYm0c8PrrQ9tMGA5ElB/gUltMPTSGD3Cx3Ud9zmDx/DBpOd
X-Gm-Gg: AYBFou3lqL7j5KDLRSI0mpSWRQCyxwgj4mieKmyAxKEBGaF6rxaEIFaS1d2DuMBWwaL
 5pJ+l1r7pYfItTUyJ+uV2Y/zmtABvHIjLem20ypXpCO2rYqaM0JMuQqRRNWd8+e0SJxAyyayWgt
 gYz9dP0EK5xk32vD2YL5coYbGZa/ebeC40AuEUlX33v/fTTqRKgxV+cH53qYWPNJ0sJlvrqe9Xi
 zA1KavSs2ZYyqAW4lRBsHLK0W3y+R2cp0L8VcXo6c2nF8V8L/x6v5eDxyLwDw8so42yRSyWdIzP
 44+8IQOBZ5/vsndcXyWIJ8Po2Q8pTIc2d2HYrePjijX3TfYmA7wBoY0DUwMFNZ+w2iIAzHOhmxx
 CK792lPBqHwFnyAdQQyAMYfB9l7cALuCI9ukcL4WqVk0eOfV96gGwSSfkXSDxsQ5hf8nydv62D3
 G5aDyfhGtmTUSbeijSNK6C9hbQm2ErQLKdgj3I7rNpWyI0s3xoxDBzF7BZzKfHYnty9rJiWYMzh
 PB+yohzwTDxck7PUZqKHS2s5WQng9YjT5WDawg075tZmso=
X-Received: by 2002:a05:7022:7f07:b0:194:e9e5:11b0 with SMTP id
 a92af1059eb24-1993506300dmr6440691c88.14.1792961509260; 
 Sun, 25 Oct 2026 13:51:49 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a2a5937dsm18680738c88.20.2026.10.25.13.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 13:51:48 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 1/2] linux-user: validate the fd for a zero-length
 readv/writev
Date: Sun, 25 Oct 2026 20:51:43 +0000
Message-ID: <20261025205144.1781959-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025205144.1781959-1-takano32@gmail.com>
References: <87o6chn1nw.fsf@draig.linaro.org>
 <20261025205144.1781959-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=takano32@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

lock_iovec() returns NULL with errno left at zero when the vector count
is zero, and the readv/writev family turns that into a successful return
without ever entering the kernel.  The kernel checks the file descriptor
before it looks at the vector, so a read from a write-only descriptor
fails with EBADF even when iovcnt is zero, while qemu-user reports
success:

    fd = open("/dev/null", O_WRONLY);
    readv(fd, NULL, 0);     /* kernel: -1 EBADF, qemu-user: 0 */

errno cannot be set in lock_iovec() instead: an empty vector is a
successful no-op on a usable descriptor and only the descriptor decides,
so the syscall has to be issued for the host to answer.  Return a shared
empty vector, which is never dereferenced and which unlock_iovec() leaves
alone, so that every caller reaches the host.

This covers readv, writev, preadv, pwritev, preadv2, pwritev2, vmsplice
and recvmsg, which all share lock_iovec(); sendmsg already issued the
syscall for a zero-length vector.

Fixes: f287b2c2d4d2 ("linux-user: Perform more checks on iovec lists")

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 linux-user/syscall.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0380691a8b..75151c1054 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3082,6 +3082,13 @@ static void target_to_host_low_high(abi_ulong tlow,
     *hhigh = (off >> HOST_LONG_BITS / 2) >> HOST_LONG_BITS / 2;
 }
 
+/*
+ * A zero-length vector is handed to the host so that the syscall is still
+ * issued: the kernel validates the file descriptor before it looks at the
+ * vector.  Nothing is ever written to it.
+ */
+static struct iovec empty_iovec;
+
 static struct iovec *lock_iovec(int type, abi_ulong target_addr,
                                 abi_ulong count, int copy)
 {
@@ -3093,8 +3100,13 @@ static struct iovec *lock_iovec(int type, abi_ulong target_addr,
     bool bad_address = false;
 
     if (count == 0) {
-        errno = 0;
-        return NULL;
+        /*
+         * There is nothing to lock, but returning an error would skip the
+         * syscall: readv(fd, NULL, 0) on a write-only descriptor fails with
+         * EBADF in the kernel, and succeeds when the descriptor is fine, so
+         * only the host syscall can produce the right answer.
+         */
+        return &empty_iovec;
     }
     if (count > IOV_MAX) {
         errno = EINVAL;
@@ -3190,7 +3202,9 @@ static void unlock_iovec(struct iovec *vec, abi_ulong target_addr,
         unlock_user(target_vec, target_addr, 0);
     }
 
-    g_free(vec);
+    if (vec != &empty_iovec) {
+        g_free(vec);
+    }
 }
 
 static inline int target_to_host_sock_type(int *type)
-- 
2.53.0


