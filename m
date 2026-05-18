Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D66ACD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VM-0000Of-PN; Mon, 18 May 2026 17:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VL-0000Nf-6c
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:03 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VI-0000Rb-KQ
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:02 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso2406224a34.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139679; x=1779744479;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t8+v/EjXETKRTwyWebZC5HE0qPUNEGr0KvGN264bUy8=;
 b=H+xbyhUytBSIUPYnAsXlJWPyM5SEndBVu1Rhoy41L9kPM7s1eCA7sbTx33P3rJBGB4
 n+66c6VJEdVWjI2vDXGrsluKidvtP2gd0bhCchwb+jwj/jS1W4a/a+Ze8UbWBgYOwQ0f
 Y25q8ifRvbbnU+dWdGAIsDhr5l8RpUSlo3vV6/wtcE8zgNMEBnjTd/O0w/k6G57KGo77
 O1OgqHLGM3LjjSz64g4zFHGVj81CdNRxY5AuI/ATAHUMuhYD+ngJNfLESrRQyqrxkZwM
 XXRG7PqgqJxnOC0ZJF/cjDqJNE7ZvMuB6lxoxL6Rfc7AAJnnS4kpMzm+GrFU7PKKyfpB
 287Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139679; x=1779744479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t8+v/EjXETKRTwyWebZC5HE0qPUNEGr0KvGN264bUy8=;
 b=maCwehj+OMROgljVU16OUdY4Cv91N7ozizdAlVG7xGMscGuWW4TykoO88oGmtPfRhi
 c3occaUmdD3lsRDGeIoPCUKANEoZOM852CXrw3swk972p1ARYiqkjvzO04KiqN0/JbkK
 96+u5mGBzN2x4jW0iRS7ld/mHolT6iYMT9vEaL+6ekHJUhdp5ayaW9RT6qpMvfEUUsgE
 uGjtWFvuxnji9S2AnQPTAckfjmmeDEagdoCJHXG+Y+bzBWDj86kJyUd7aYg6hwh8tXd5
 RaJG7U8JEG3I9E+lOBvQR34qxD2Rv4icVz5t2ckkOtCKHKT3UvYe/zP+g37nRIkTfS9y
 Kb4g==
X-Gm-Message-State: AOJu0Yzn1xZU46UeB89p3veKoSnKQHWrOyH9P10KqYTZd7V78kVYxxfZ
 mE0X/iDXODIu721yaCwuSz3pfADqHwQRJ7TCZUtTtB4+fwdsnyJ7qOyxB7mY2jyidIQeFJdLACo
 egm71Smw=
X-Gm-Gg: Acq92OEJO6mGOwwyeUuo+IT3d+9sVIm4j+6kiN8W2zHjJ39TtvUGXFFzqDtx1+0Tj4W
 xWwcTnWzsNknvvVtdMPuHMBpYBInE8grExZp09DQBPuB5HtPseT8vkUE2nRC3iBqZTY/5PkDfFA
 Dzst4zqnEi6lNXxxUS2EpRHViJt+JjtT6BP1E8huiE2jzGHyR/g3ejcLD5LuQVdkmkr/qKhkCfE
 3ml8hnfvZzLE1M7kX4N3Ckx2NcBzlI5FRQGu0cz2u54A+3PzzdHPkIkZrGTD9iyKbTO848eTI1X
 BGtNM/SBHfKqqRq+GKINAzMIy00TZzN+ys64IM4k3VDBBE6XutxaCVTG6HZ3jCdQCMq9+3cRY1K
 8tRIRaoYOaV1XcGgSyFHnSSwlEyKIsmPUoU0s8nGvQqqq9QvjFQOsK8SP0tbxKKNKw5tLuTIVMp
 3FZTG4ILDwrQ==
X-Received: by 2002:a05:6830:6602:b0:7d7:c985:3a30 with SMTP id
 46e09a7af769-7e4f2a30195mr13830425a34.11.1779139679648; 
 Mon, 18 May 2026 14:27:59 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:27:59 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:26 -0600
Subject: [PATCH v2 08/37] bsd-user: Add file operation system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-8-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3697; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=p3uvcx4gphk1awyIPaOzO4oRtM8CLnIjjebf6/6Tgk4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RG6vVfdCP0XMTlMboozbEd9BfucP0bnEanb
 E7/0SrAlyCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERgAKCRBsHNEofbAR
 AFC1D/43ghBcwaidSO7Qc53BWTtjVh1rar172HL4pMBKGgrVgOw0RwQ0z3h4/Szx8VELFpxBVg1
 gh1rwaxgagnaOgYAv5SPpzz7SKlca8bnALiEu9hsGWx9ABltjVemSzHYCjmfH+/5KnHeneoxTxb
 kvfhTQwgcUiLU/eumiBt48iKSyzXgZ4jZz7V6Hpqj+VeWlTL2u3c8kf69EtcBp4MGOm22wANJN3
 y8UWsA+cPSIAICPzL9b9um3xmX+hMYUGxZlH1l2gDE6RB5X8A10albG1z6yN1GEyGXymzt1ye2F
 Xor1SCOMD6J45c5a0jYBJiZCe0aQ9NS9oVSspQpjUjBJsN4pVukRmN1rxjEBpA4ypme3/IyAyZi
 Rxq7faKxDRxf+uztc7CJfuxfERagCc1/2VIXIBD4Ef8xJ95fr0kdPxXCBZedVpNzxF82hH3NcG+
 GR9G+Jm4FkC1S9nSdw/X98Z4z2wwArWSH1n8geDWsMGA8evdQj2DVQSPf8oKALMx41T9Gb+cJFa
 iVEl3esdT7haPPaJk5MOkcITedVP9HIfANRRdnDEpRdngfLmJJuE0QoQv3iTzj1s+YkCmaz3ohI
 IaD2bFq7zd/zQI3IpPgdIu4/FU62Veecv1ytJTnbZ11jMwG2V7uoJtjQPmZMarDBgq1iaMQW3HJ
 7MHDAVrDMndn0Pw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Wire up additional file-related system calls: poll, lseek, pipe,
pipe2, swapon, swapoff, chflagsat, close_range, __realpathat,
copy_file_range, and __specialfd. Also fix __realpathat to use
__sys___realpathat on FreeBSD >= 15.0.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-stat.h    |  8 +------
 bsd-user/freebsd/os-syscall.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index ea95aa6344..4e5fc30de4 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -622,11 +622,6 @@ static inline abi_long do_freebsd_fcntl(abi_long arg1, abi_long arg2,
     return ret;
 }
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300080
-extern int __realpathat(int fd, const char *path, char *buf, size_t size,
-        int flags);
-/* https://svnweb.freebsd.org/base?view=revision&revision=358172 */
-/* no man page */
 static inline abi_long do_freebsd_realpathat(abi_long arg1, abi_long arg2,
         abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -640,12 +635,11 @@ static inline abi_long do_freebsd_realpathat(abi_long arg1, abi_long arg2,
         return -TARGET_EFAULT;
     }
 
-    ret = get_errno(__realpathat(arg1, p, b, arg4, arg5));
+    ret = get_errno(syscall(SYS___realpathat, arg1, p, b, arg4, arg5));
     UNLOCK_PATH(p, arg2);
     unlock_user(b, arg3, ret);
 
     return ret;
 }
-#endif
 
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 8a25be4ac7..228daed4c4 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -700,6 +700,57 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_undelete(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_poll: /* poll(2) */
+        ret = do_bsd_poll(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_lseek: /* lseek(2) */
+        ret = do_bsd_lseek(env, arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd10_pipe: /* pipe(2) */
+        ret = do_bsd_pipe(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_pipe2: /* pipe2(2) */
+        ret = do_bsd_pipe2(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_swapon: /* swapon(2) */
+        ret = do_bsd_swapon(arg1);
+        break;
+
+#if TARGET_FREEBSD_NR_freebsd13_swapoff
+    case TARGET_FREEBSD_NR_freebsd13_swapoff: /* freebsd13_swapoff(2) */
+        ret = do_freebsd13_swapoff(arg1);
+        break;
+#endif
+
+    case TARGET_FREEBSD_NR_swapoff: /* swapoff(2) */
+        ret = do_bsd_swapoff(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_chflagsat: /* chflagsat(2) */
+        ret = do_bsd_chflagsat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_close_range: /* close_range(2) */
+        ret = do_freebsd_close_range(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___realpathat:
+        /* __realpathat(2) (XXX no realpathat()) */
+        ret = do_freebsd_realpathat(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_copy_file_range:
+        ret = do_freebsd_copy_file_range(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR___specialfd:
+        ret = do_freebsd___specialfd(arg1, arg2, arg3);
+        break;
+
         /*
          * ioctl(2)
          */

-- 
2.52.0


