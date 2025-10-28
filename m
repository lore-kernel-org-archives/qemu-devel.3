Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF601CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkYs-0006pW-ON; Tue, 28 Oct 2025 10:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDkYf-0006ok-I3
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:20:21 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDkYU-000238-6Q
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:20:18 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so6191042f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761661204; x=1762266004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GDfyhmgBCgRnnaE8Yz6WedBHUTy41PksMvzT8dh3pBQ=;
 b=pAwRpV6/UGWDl4C6bJgXT1fjmFUUiZmKSl4o6kHF5lkY7CKurR4x/nUm3ExCY0srIx
 ID/q+9+She80v8ddbc+ntVOJCNrPeOKJA3ySh58zHLhNwNFoLRzZJnlIPCWLgVzWzfdY
 nVTpRXvRRRtpgnLa7QSKgpZ1r7D4iDYJb+wt6Fri6XVFQfHXSar75Kcqs32w8Gz+Qqf6
 Z/fw6OdyfUKkV4csxzT87qfnkdby9oirrSnGbNT02XOqWaGiQHqhahyhom1X9MYlaxJR
 t1OvJajMMyzRvAIczZBR8qpWgk3lRivw8M6gHvG2hOFmsa1deh5YoQ0RHeBhFxHOoqRY
 pXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761661204; x=1762266004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GDfyhmgBCgRnnaE8Yz6WedBHUTy41PksMvzT8dh3pBQ=;
 b=qxBt4OrGHx8PKfaOlYEg2GdCuUqRgEX+Wcpbt07c+oRFnxbfDOnXIAoos4FOJ1mSNW
 nqpVGCwrzYzlc+KO7vnzmyLMO/KYMdnwr2cohUeYH3pyeSfGmJAccgZOOXybdKRErY8L
 aaub+L+gNRE5gwEcR92VTBg2+Vok9c29oMZguIYdKzfsYKeq5YdI6wp26pv84lEnKv69
 Nzk4vv+d0vRz0bTOtxCZiCsMGkcimjhHx3cZ9TQrf3sdoIzC3U2V3w+54AFdPxtuNvys
 Ozd68cNBQVXYcXgRZdofkl4MMFe2cW3HDoOnG8nI6l9QLQim3O6r3Mi5wwGpKEBVGE/A
 C9fw==
X-Gm-Message-State: AOJu0YxGzSBFjOWBPDDoIa9lFUL/7ZmT8rxg9LqxRBNep3Hxd1p4vSv8
 XyiKYBiL+1oAfdyvxfH+rj2gbukUfcS+yH0ke2rMyCqHfCxUlS8U0JYWLh6AcL4y06elQdCGljq
 NEEjx
X-Gm-Gg: ASbGncufOmUpSXsnG1EMCOoPaV1G0YWR1/ni/LBwagweffaP4lAd1qOi4bfPI4oex5S
 M01Q2F8uAAEAR3Z5p0gAFJzZhV1CfB2Svw7SNayRx3Sw7gov3z7vk8yTKpJoduZN6OVJgdowPQQ
 HbWcY+TfkQdkq0YhtsQsSqNyk5Je3Zk5WQ+9mr58ubV/GflsSy9Y1+XFo3364/pYDRRqqKICqoP
 piTDTpm6U2soBHbEywhbFsVeevnzhY5H0Z8z7OSZFxAZFHcPwZnShAguIHGuw73HcndGv3Xx97Q
 ksljAcLvWOMUJqqqNvdjBs/FtFU5vhEeWWJLoM/LNzNH0pnT+ZBVbhxmuThBxJKQu+vRoGud9eQ
 4O2WCpjCH5SofoyCvzDf8XhTG2nKJLhOFIIrsnbRZ9W86SOthRropzMG/PFRcgzFdXaGLUDWgsz
 U1cnNLGQ==
X-Google-Smtp-Source: AGHT+IHIhabQLUiQHpTi5czRDYVLTp3Tqqf0J/ZX8ZrFH80uJWNHdPk1FyhVR4x/PmZHkuCWVfwEgA==
X-Received: by 2002:a05:6000:2406:b0:427:847:9d59 with SMTP id
 ffacd0b85a97d-429a7e7a6c4mr3607924f8f.45.1761661203488; 
 Tue, 28 Oct 2025 07:20:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df3c7sm20262512f8f.40.2025.10.28.07.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 07:20:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] linux-user: permit sendto() with NULL buf and 0 len
Date: Tue, 28 Oct 2025 14:20:01 +0000
Message-ID: <20251028142001.3011630-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If you pass sendto() a NULL buffer, this is usually an error
(causing an EFAULT return); however if you pass a 0 length then
we should not try to validate the buffer provided. Instead we
skip the copying of the user data and possible processing
through fd_trans_target_to_host_data, and call the host syscall
with NULL, 0.

(unlock_user() permits a NULL buffer pointer for "do nothing"
so we don't need to special case the unlock code.)

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3102
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8546f48a05b..2060e561a20 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3581,7 +3581,7 @@ static abi_long do_sendto(int fd, abi_ulong msg, size_t len, int flags,
                           abi_ulong target_addr, socklen_t addrlen)
 {
     void *addr;
-    void *host_msg;
+    void *host_msg = NULL;
     void *copy_msg = NULL;
     abi_long ret;
 
@@ -3589,16 +3589,19 @@ static abi_long do_sendto(int fd, abi_ulong msg, size_t len, int flags,
         return -TARGET_EINVAL;
     }
 
-    host_msg = lock_user(VERIFY_READ, msg, len, 1);
-    if (!host_msg)
-        return -TARGET_EFAULT;
-    if (fd_trans_target_to_host_data(fd)) {
-        copy_msg = host_msg;
-        host_msg = g_malloc(len);
-        memcpy(host_msg, copy_msg, len);
-        ret = fd_trans_target_to_host_data(fd)(host_msg, len);
-        if (ret < 0) {
-            goto fail;
+    if (len != 0) {
+        host_msg = lock_user(VERIFY_READ, msg, len, 1);
+        if (!host_msg) {
+            return -TARGET_EFAULT;
+        }
+        if (fd_trans_target_to_host_data(fd)) {
+            copy_msg = host_msg;
+            host_msg = g_malloc(len);
+            memcpy(host_msg, copy_msg, len);
+            ret = fd_trans_target_to_host_data(fd)(host_msg, len);
+            if (ret < 0) {
+                goto fail;
+            }
         }
     }
     if (target_addr) {
-- 
2.43.0


