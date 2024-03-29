Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F433C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKmx-00084B-I0; Fri, 29 Mar 2024 18:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rqKmv-0007mp-N9; Fri, 29 Mar 2024 18:33:29 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rqKmt-0003kw-SB; Fri, 29 Mar 2024 18:33:29 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so1688195a12.2; 
 Fri, 29 Mar 2024 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711751605; x=1712356405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UiT87QcdTydktqQoQiYKrqblOP7f9I+ZW7v1tQ7uTyQ=;
 b=c7a9YGdcHxNB4trFkMDWuavaUpPBjkX4NzTSZrfyr4g6VzraVOrIqn5roc9P/31dP4
 6e8d9WW7KG0PqVi6UzuFUcOXDoIt+PZ09bHN/KO6WEesJurCojVsZnrWUxBW6kIULV1b
 PJ0t0Em1HLPoX7Rhq3rIEMjSik6Ibs6HYHI4fzWayC3v+oVYDQ2u5D0HdCMyoQFwchRG
 8M1A1otEJpRp6BZATs2pgUWdTthdoA/TpdjOvIoWIZcm5cer9jFBCzXc88xqi4Qyl+oh
 m7ulmK/kOqxjjWsdinOzbRwRI8BD5UbiSZ4uowUo+DMiRXFU9chrJ24qPDi0quM0viFi
 Q0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751605; x=1712356405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UiT87QcdTydktqQoQiYKrqblOP7f9I+ZW7v1tQ7uTyQ=;
 b=Sm1dBkXszdXCHlenN4dVvehswM972dTQr5hwZHHzIqOj8uoeNQk1JSIMv+SNWB6WUG
 tKQ8EzwV7qWGtZxAfXA/mpQb7QLOV/+/uJnaJO9vC9VyPncxwi74qFzMjLJTlFSBw1Es
 12tVKbofZSKQUcGQqM4y0RxA4sJNUrupRWIra34E5+P3OecWQdmoiUadsMFEUM6TRWQ1
 oLhD4cufk4umWZ8Pfrh15R5OqUxW4QVdM26sxUVdrBUFASHF/A6KbFJCLQ74Nmsd6EXl
 xBaz0XopvbCNCaUue4eVf80HT1FnW3hNRdbz+rBRQ4yMTFYktf/wQO70lBv+vpfJJ9dG
 ep1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm9+RckRtxh8bfSjPJouf5EohOp9W+zP5WOa0kNDs25f+Oakf7p/9WJKxhBFfs8FmD57AzOfhHntnMY+yGVT5q31sqsPlk
X-Gm-Message-State: AOJu0Yyp6di7fjgPOullBdCRhiinhn4Yj6IhfuI9ea1qhkaaKzzy6FMS
 nRNRZT7XKyhqj/DT1Tm8audSxBtk2lsuVY3uIBKMM6nSjxtzl1InB0jy8njr
X-Google-Smtp-Source: AGHT+IHiY+gHwn2CuqIFjfAOshpwFWaMRRhDCnnfDEs1DmoTOLgPzfeOU05mA02w9G+KHWbdl2/pgQ==
X-Received: by 2002:a05:6a20:9184:b0:1a3:8904:1fc9 with SMTP id
 v4-20020a056a20918400b001a389041fc9mr3425460pzd.41.1711751605269; 
 Fri, 29 Mar 2024 15:33:25 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:646:a200:bbd0:2399:5e4a:95e8:172f])
 by smtp.gmail.com with ESMTPSA id
 u25-20020aa78499000000b006e6c856c0f3sm3479490pfn.188.2024.03.29.15.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:33:24 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH v2] linux-user/syscall: xtensa: fix ipc_perm conversion
Date: Fri, 29 Mar 2024 15:33:18 -0700
Message-Id: <20240329223318.155572-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

target_ipc_perm::mode and target_ipc_perm::__seq fields are 32-bit wide
on xtensa and thus need to use tswap32.
The issue is spotted by the libc-test http://nsz.repo.hu/git/?p=libc-test
on big-endian xtensa core.

Cc: qemu-stable@nongnu.org
Fixes: a3da8be5126b ("target/xtensa: linux-user: fix sysv IPC structures")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- split into a separate patch

 linux-user/syscall.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e384e1424890..d9bfd31c1cad 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3758,12 +3758,13 @@ static inline abi_long target_to_host_ipc_perm(struct ipc_perm *host_ip,
     host_ip->gid = tswap32(target_ip->gid);
     host_ip->cuid = tswap32(target_ip->cuid);
     host_ip->cgid = tswap32(target_ip->cgid);
-#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC)
+#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC) || \
+    defined(TARGET_XTENSA)
     host_ip->mode = tswap32(target_ip->mode);
 #else
     host_ip->mode = tswap16(target_ip->mode);
 #endif
-#if defined(TARGET_PPC)
+#if defined(TARGET_PPC) || defined(TARGET_XTENSA)
     host_ip->__seq = tswap32(target_ip->__seq);
 #else
     host_ip->__seq = tswap16(target_ip->__seq);
@@ -3786,12 +3787,13 @@ static inline abi_long host_to_target_ipc_perm(abi_ulong target_addr,
     target_ip->gid = tswap32(host_ip->gid);
     target_ip->cuid = tswap32(host_ip->cuid);
     target_ip->cgid = tswap32(host_ip->cgid);
-#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC)
+#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC) || \
+    defined(TARGET_XTENSA)
     target_ip->mode = tswap32(host_ip->mode);
 #else
     target_ip->mode = tswap16(host_ip->mode);
 #endif
-#if defined(TARGET_PPC)
+#if defined(TARGET_PPC) || defined(TARGET_XTENSA)
     target_ip->__seq = tswap32(host_ip->__seq);
 #else
     target_ip->__seq = tswap16(host_ip->__seq);
-- 
2.39.2


