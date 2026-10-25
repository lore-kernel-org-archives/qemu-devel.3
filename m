Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF781606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d5GjnbQ6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsOs-00038W-DM; Sun, 25 Oct 2026 03:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xKsOo-000381-9L
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:12:10 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xKsOm-0002qQ-JP
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:12:10 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso4037770eec.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792912326; x=1793517126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+BVTL5cFGH0FYsGaDrgVYRRquLqRSkbDTBGIls4/7WA=;
 b=d5GjnbQ6KJGve0JuYUVdvcqvxHRRjjY/hLx7C7vlqgeVjlYqd+T4HBN7yvg1H4Gs4B
 SbVhMLAhHzxJtJWFPTkIe9uh2byNIIowdgHpIO358ihracsdsdOo122CqAMnE+5IWdIT
 rcYRIS4qV8mVDD3NivO7rU9Eb6r52Z6L+Okae09kTsEp67QQ602BGJ9znTzA+YPnXOqF
 E9ZtRwPc7o3b5/nc8lzxRQQ1fDhNxVb9W3eR9ln7a0nyu/hAOHrdQp4YbV8XC2p17zhz
 cQAHGx0s+phMCzYM6e+z58inNC8V5/Vv4XubwaDHv6rfkbzzmHd4gnVZXN+gPTAIGh9U
 laWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912326; x=1793517126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+BVTL5cFGH0FYsGaDrgVYRRquLqRSkbDTBGIls4/7WA=;
 b=cAOLC7HfDLTQbQDTyipZsBb/8au+ITpncZbBBtvMt0UIHSADKs9vEzNOzO61epRmRe
 PP3bouelPwwTJdyo7styTMpV0z6O7VErbsPKMMWllac5QsakVUC+ekP2i7pwS6JKBu+N
 3QabK2WlSwHUP46GDGJM5RB0R7xwhgrrjEi2K7oOUUP5p6m0ofwvyK2JCJaGPOzPk5lh
 fDKTpPvKo3ZWqkLBZBUtFudQE7d9wE/30NXTDLvJhB4VCP7KbrW+3GLMpbhZQOyvSypZ
 v/v1efMIVKL2yzK74hMQK5deZZOmhNlnUpcdbPXXXbQ3UucH8v3tLkU8+SXRrQ+CxJLu
 iNOw==
X-Gm-Message-State: AFq9FYKs0AajVXwNRDh65J8b41Pe+qTBGjj2P9d99C7z5bYOrbjggI1L
 LQPM05sgNPTQHVWg4gtJvC74H8w+GsBvFOLv9Bs9owHADbNrYZIGcrV5dYLlEw==
X-Gm-Gg: AYBFou1WloUCjqSsTG5dSJ7vWRCb1uUWYkrBvYY3ascaVbc7QYraX+Dtv5mgYkbCd9E
 0shLDFf/Yg16oxHFhU3yteStLg0FrWzmGO5UB6PBw0hVT0eE+e+nXWDVMuTn5uWoctqweY3fZD+
 kIDv7uf6d7B5voZiZRNvq9qHEjNvm9E8fKDzTwgofMdMQX99v9Lo7KQKEx7Qcd+12w794Ofg7L6
 urwLw6tLZQDbsTB/PjF9vFrp1mTJ9+HK1mwFXpsWoO4+KzToEZMucPtD0n26/mu2g6oNLg012eb
 UAz+jQoT0eRRsWhRyXdGFxfAJzzcVViwzFiLeNd4EVwAGeTM9cXjb48Axfr1bKxk5sNydVchrTN
 CnuXarxBfhxQDzqj5ZaDbJO6+/PlVmD+wnNp5Be2rnj8R/7jjJNaFr/dxEg8YsDcY0FXQB1YpQ1
 myHfsKXxZRF9vtG797GUaFBjYS99lAdoL66kW/7HdtoCeFHreOv3HDaC7E9dtqdfmPL4l5yQ/K0
 RM4H8AY8eSYOBWl/puGoh7mV/KEXkRONtln9eYsHZvSPs+Q
X-Received: by 2002:a05:7301:e110:b0:369:9af5:7bc9 with SMTP id
 5a478bee46e88-369e8614733mr5601583eec.23.1792912326260; 
 Sun, 25 Oct 2026 00:12:06 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ec9276sm23307132eec.25.2026.10.25.00.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:12:05 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/2] linux-user: validate the fd for a zero-length readv/writev
Date: Sun, 25 Oct 2026 07:12:02 +0000
Message-ID: <20261025071203.1214199-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=takano32@gmail.com; helo=mail-dy1-x1330.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

Return an empty vector for the zero count so that the syscall is issued
and the host reports the real error.  This covers readv, writev,
preadv, pwritev, preadv2, pwritev2 and vmsplice, which all share
lock_iovec(); sendmsg/recvmsg already handle a zero iov itself.

Reproducer and measurements: https://github.com/takano32/qemu-user-zero-iovec

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 linux-user/syscall.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0380691a8b..3197ccaec6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3093,8 +3093,13 @@ static struct iovec *lock_iovec(int type, abi_ulong target_addr,
     bool bad_address = false;
 
     if (count == 0) {
-        errno = 0;
-        return NULL;
+        /*
+         * The kernel validates the file descriptor before it looks at the
+         * vector, so readv(fd, NULL, 0) on a read-only fd fails with EBADF
+         * rather than returning 0.  Hand back an empty vector so that the
+         * caller issues the syscall and the host reports the real error.
+         */
+        return g_new0(struct iovec, 1);
     }
     if (count > IOV_MAX) {
         errno = EINVAL;
-- 
2.53.0

