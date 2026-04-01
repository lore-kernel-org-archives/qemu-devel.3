Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B88D35164
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sC0-0008CN-Ug; Wed, 01 Apr 2026 05:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7sBz-0008C3-UB
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:48:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7sBy-0000Lp-AB
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:48:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4888244e9f9so10270355e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036933; x=1775641733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YWUWvyYmwxpesYfMxCSgCLmRDVhk6kKfDEQRKBjiWeY=;
 b=Hvueo9C+hETRmrW3KRa6scNG80f/NICdSJab8VHF9EyW/rCF8sTIehHeTEadnJY2Co
 ygCsORtoWjTcCJGo34za50tzbTwqr472LLAa/ExrXRRXfccshotxsSjU7W3wamorprZL
 2bvOUPZQilduExptZaoJkrF1TexSdNRoMWNIgW+M7vwB4Rzm+rc54VVLaw942JvES/gq
 QXdIclfG/62xZyTM3JSWatz51blX5Vez4MJQ7bevinsEHoXUUIuqUVskWzUb6bk9obYw
 6L+J6BZzuqdEsbkw6LI78YYDnwicwHNVNsiQ48IeXnKLuD7SX5Jotv2NafoenFLPnbiW
 3LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036933; x=1775641733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YWUWvyYmwxpesYfMxCSgCLmRDVhk6kKfDEQRKBjiWeY=;
 b=KXJquaXxhTp+Z4uU9Tw1a1RZ9hWzLVEBJXGlxq+PBABp6CBChwgmwli6x3+ddxz22m
 TaUg61ICQr4nYnua7Ua4K/r3QCvYwuIY7yOnfKuZDNs3I+f7zRHMJ8EE+Di3OThg0Tk2
 PH/EULU2dGUND2K8nPyQCyxgXAfzD7KO712YyIu6SCQoNQMrR5HxRRlZsVS2Af+d3/7V
 sbY4SQYM/S8PQ/oxX3TQuhzufiTHHVnXLQKokxb+N6oUYiDLsQBBXk+8U8NzhAjpURyK
 1oX8Bd/y9viLqvuWKe5l2zYxAzm5qMKhQpmYEhIW5rjfkVIA0LW5oXU38JG7EzxUX3Ct
 y6Xw==
X-Gm-Message-State: AOJu0YzdfjGRvQBCVdL2mLYUXzAVXF4jtRxkiF/ixSIDb9TWCW15Lv2L
 3JxSaSumoeeghar2q0fnF3Q58VMEP4ZRYX7yDoyHjEKLLqCrU45IIFqD29fiZTk8BGNtFTjSWAM
 xp69mEU0=
X-Gm-Gg: ATEYQzzkL2lLiePqS2yVyUwYjT60gHT+/PtbmlEd+u0wCu5yTHpXyA3TdERwGg9jQRH
 FTrGbl4p3sqTPNDp0xA0luCID3qEPL5nKDiXxkw16v6vkAn4cfzg14JPAUCDmiOTKXkPJb2VDOI
 f5iZ/J+y4IzULxKI9kCa7nwo4cpXBjlqvh6xvMI8PQyFedXbOSPQlC3sMWl2HEil9HyleliJY0d
 mLDLZCIcL6sHjEQBZTxAdu9xs51a2gbYUW63lWd8AouDCkD5DVJIyG44giCzu9qQGuU1ov3FvDa
 XYZnl0MHp8G5kqm8xeRGTgbeH2wECrPfqFpgN2cSJVP4wjj0kSpyyiqdM+9aHqgKqXN5xoG7N+q
 8bbfY/viGUD2pWh3wJwDfonxv+mCOoD+IsD3zmoYfq8iVAwaR9jKYt3uCjpnv1jqpLwSnYOLOJ6
 e466+UNulXsBI5xx3lvIedLb46/91ACuLIqbiZhFldSJ1ESTnu4hUr4QpF+GTnondj4HN5+ZTyR
 FXnVrGFip/FhsARdXTuZOHzOi10JjFgT2FOQfN8xA==
X-Received: by 2002:a05:600c:444e:b0:485:35ee:f836 with SMTP id
 5b1f17b1804b1-48883569e3dmr44289365e9.2.1775036932697; 
 Wed, 01 Apr 2026 02:48:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887eb5aff3sm146945685e9.15.2026.04.01.02.48.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 02:48:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] linux-user: fix name_to_handle_at when
 AT_HANDLE_MNT_ID_UNIQUE flag is set
Date: Wed,  1 Apr 2026 10:48:45 +0100
Message-ID: <20260401094848.2661985-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401094848.2661985-1-peter.maydell@linaro.org>
References: <20260401094848.2661985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Clayton Craft <craftyguy@postmarketos.org>

Linux 6.12 added AT_HANDLE_MNT_ID_UNIQUE, which indicates that mount_id
is 64-bits. If name_to_handle_at is called with this flag set then qemu
passes a 4 byte int to the kernel, which then tries to store 8 bytes in
a 4 byte variable, causing a SIGSEGV[1][2].

This stores mount_id in a 64-bit var if the flag is set.

1. https://gitlab.postmarketos.org/postmarketOS/pmaports/-/work_items/4431
2. https://github.com/systemd/systemd/issues/41279

Signed-off-by: Clayton Craft <craftyguy@postmarketos.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Message-id: 20260325-fix-name-to-handle-at-v1-1-49fb922e6fd3@craftyguy.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7832a1aba5..3cb00c643e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8166,6 +8166,9 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
 #endif
 
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
+#ifndef AT_HANDLE_MNT_ID_UNIQUE
+#define AT_HANDLE_MNT_ID_UNIQUE 0x001
+#endif
 static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
                                      abi_long handle, abi_long mount_id,
                                      abi_long flags)
@@ -8173,6 +8176,7 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
     struct file_handle *target_fh;
     struct file_handle *fh;
     int mid = 0;
+    uint64_t mid64 = 0;
     abi_long ret;
     char *name;
     unsigned int size, total_size;
@@ -8196,7 +8200,12 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
     fh = g_malloc0(total_size);
     fh->handle_bytes = size;
 
-    ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
+    if (flags & AT_HANDLE_MNT_ID_UNIQUE) {
+        ret = get_errno(name_to_handle_at(dirfd, path(name), fh,
+                                          (int *)&mid64, flags));
+    } else {
+        ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
+    }
     unlock_user(name, pathname, 0);
 
     /* man name_to_handle_at(2):
@@ -8210,8 +8219,14 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
     g_free(fh);
     unlock_user(target_fh, handle, total_size);
 
-    if (put_user_s32(mid, mount_id)) {
-        return -TARGET_EFAULT;
+    if (flags & AT_HANDLE_MNT_ID_UNIQUE) {
+        if (put_user_u64(mid64, mount_id)) {
+            return -TARGET_EFAULT;
+        }
+    } else {
+        if (put_user_s32(mid, mount_id)) {
+            return -TARGET_EFAULT;
+        }
     }
 
     return ret;
-- 
2.43.0


