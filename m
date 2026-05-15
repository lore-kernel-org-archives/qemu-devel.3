Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2E3CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzx7-0001BF-02; Fri, 15 May 2026 17:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx5-00019n-3l
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:11 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx3-0002r5-8x
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:10 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso279567a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880008; x=1779484808;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lQ4DUSPnf3j70bwsGanbKYeKeZT3XaXnUobP2DFdQmw=;
 b=ppocHrup2XTPZ2M/ZtuoFQpfkVVB7m5GdfKDMg9NGutcnHvnF3co7HUJlTqxVq8Wl7
 PixcRLsQuZXjzj/kRxEp0Yl0oBK8tOkXUM4jtzyIP6OSssdKRggcXHS5mFWlW62g3fCG
 xnc3TqS3J4SxlJcghtDvWrfOV2l+msKz8xJSa+othzxxcCuyNeUOLqg7ReDUGS8EI70V
 WIWjleEb4m0rC4ltutHCov8+2Ud9fzKYYmWFsIXFaepFppxvFW9bbAs26fEfy+s5GCew
 KTB5OYNAB099ZxTARy03HM+Ka1uwsa0tNZhdU1cfQw+vOkmBW41SpFuQgVo2iEVssUiG
 Hgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880008; x=1779484808;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lQ4DUSPnf3j70bwsGanbKYeKeZT3XaXnUobP2DFdQmw=;
 b=hEq/1AVZp43FlJr/PbXUSuRTqPCrexKrmfIMeR/hgq9EIEINWmM+LsAwNy0oo1VAQx
 eaYKTaiuUm3/igg0scmKtPya9OBSFYUe8PrpYU+epKbWkYOhVpiza8UTkxb8r+tsq2rn
 XWcov59QTPkFKVAQ2icK9rX52MQnYiBuCYWxiqJWCkX5g5Jl7byzWM5WhyPgVwEeM75E
 3L3s/PS+TgEA/K7cc6jTQyZqbKB8yWpgOHbhSkh2t8tfpXzL9Fu1WD/a4uJBg1wycG2a
 NxnupA2oGZZLHR2evmulYkNQ5IHg6MwpOlVZEK69ysio+jvYwhLTwWi+m9H36KAONdBz
 3NUA==
X-Gm-Message-State: AOJu0Yy//Y3NYZVsJrDvI8ILmnEybyDX0LTJhBYO2rawqm11iJdKZxbS
 VAPb6nhZdY48KOrjI8uVVndFHncsnPj9Ds31xX1qs6Pt9wV8IDDh+4W6dHnfzjbDGeg=
X-Gm-Gg: Acq92OGH0m3qwKesoTBwA/UovtvgGgk3ChaOTAipNfwCG3aAMPochGp73ebvT2NrHvF
 5cosILGkozokidNXhYUFSi6bYfiAMdwOu/srzKu5MzzosyU9LRYHfKu8/gFWphiHpsTxFr+2ygA
 Pol57ZE/BdhwhjaON4hYqESI4mfo9DD0/T66zpBoyfGX8clF4boEr07IXwixtGI9MjEJpz85urO
 Nd394ySqNQvZ4c0Nflfb0AdEm8aLaPqPogaGpcSlZbnLIjsfNtwoPrESDSUZdf/E5nmwx5AnlCq
 dJamWQz8MYbheKVqGCSXACx68RAShkP/k/GUhCEbSl8iMZh+xQq+t9GAhXMPnmdU4+5jTNSW5ub
 wWaEXUUDCrKBfmCh+Z719YVXGPjjnoRoO1C0rIqrD9uDWmNqyqyGPXecdDYq8n70EBLZFOhpyni
 bDItU5XLEr7w==
X-Received: by 2002:a05:6830:8290:b0:7d7:fd71:f2d4 with SMTP id
 46e09a7af769-7e49a889f33mr3707820a34.3.1778880008089; 
 Fri, 15 May 2026 14:20:08 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:07 -0600
Subject: [PATCH 08/66] bsd-user: Add file operation system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-8-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3857; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=OdLR4pdCsotXmYKFnvtF6sPHNBWRKVP5533Nm/XNZIU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43hIxzeen3PHgkT2x9aM6CWPppimQroyo/+I
 uAd1/OlAGSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4QAKCRBsHNEofbAR
 AASKD/9a2gCW+WUxeSzYRrhai0XwldV6MXYqQU9UDqRhMkKmlBw3zRxlkaYXeAcDDTi6SaCCz4r
 s6ov7t9icIGnWC4rEjYO9kp8WN6VVgUCMqRUG8VUKF54Cq1Qxuq/AdlGFok3K/3rQjOrHu3Ekz+
 cA54e+M5ay4bTYMUsuYCf1ftfAtlFIVcULOuKe2NNbpsZmVsKafoaiGwy33ieG3ac5ehAnKiG/s
 JBolGagbxz9ZmYXQkHQC0Q0Civ3seuaUZ0mGRc+ydSF3zheWmcEqnjDObbXkCs+lWofLoKnlflu
 DLUo1fixw7xvIoKkXAbq+kTrFxIzHNNnfto6oKHSPAYS7Wz05U0CJr+xSxoDC1/ckBXgPXM7mQr
 9fL3paqyBn6Aq0E0ZDTVnj3xAOTJvHxJusn1yFXZAXvUc6WJNYEc+D2Tx3Hk7lX6CJoXN2bYHTJ
 ijCp24U0HNA2yICXUuEoZEdYLvczuA1IH45iOAuGfiX4KpCr2ceEF9qnz0O82Zo7LhL424BXiA8
 bLq6y37Gfdbf2erKOXnKPt3P6DQ6JbrTqSWwyC2yB8nD00fZkNnU+nNOyQVcnTmKaUs+PmIC6lN
 u77rasn69MSC6oVERW+LA3nLykKDSjRxIXHINCwlSLSHE95q8JiK/pom4EirFpYoSHWK8xvfsvv
 9uZZY0O6e/4lRcg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
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
 bsd-user/freebsd/os-stat.h    | 10 +++++++++
 bsd-user/freebsd/os-syscall.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index ea95aa6344..679acd338c 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -623,10 +623,16 @@ static inline abi_long do_freebsd_fcntl(abi_long arg1, abi_long arg2,
 }
 
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300080
+#if __FreeBSD_version < 1500032
 extern int __realpathat(int fd, const char *path, char *buf, size_t size,
         int flags);
 /* https://svnweb.freebsd.org/base?view=revision&revision=358172 */
+/* Removed in cdb24fbb0a75209043efd3b5e94faa57dfc44bd1 in favor of sys */
 /* no man page */
+#else
+int __sys___realpathat(int fd, const char *path, char *buf, size_t size,
+        int flags);
+#endif
 static inline abi_long do_freebsd_realpathat(abi_long arg1, abi_long arg2,
         abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -640,7 +646,11 @@ static inline abi_long do_freebsd_realpathat(abi_long arg1, abi_long arg2,
         return -TARGET_EFAULT;
     }
 
+#if __FreeBSD_version < 1500032
     ret = get_errno(__realpathat(arg1, p, b, arg4, arg5));
+#else
+    ret = get_errno(__sys___realpathat(arg1, p, b, arg4, arg5));
+#endif
     UNLOCK_PATH(p, arg2);
     unlock_user(b, arg3, ret);
 
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


