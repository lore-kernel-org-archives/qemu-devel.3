Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C2CCDB470
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9gz-0002wf-Ax; Sun, 21 Jun 2026 00:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gx-0002wE-KG
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:55 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gv-00055U-Op
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:55 -0400
Received: by mail-oo1-xc43.google.com with SMTP id
 006d021491bc7-6a0ef0e88e2so349722eaf.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015712; x=1782620512;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IiWazTsjHV3FGpcV1rYqHlq9lclQ1rtXU/+IT6WBdEk=;
 b=KJubaVpF4SpyR/kIaycBuqzdYbQdWVws0+JHWDqU1TBRXUfFtpGLL60w4UCEEbzckx
 oqWLeMMgZnxuceZ4lbyUpt5vK8ujjX9XEY5Q8a0GlBMdimv5GBJRhTMv0jFoC3dQsr9B
 QfVK7yP673SU2KM/YX3EHZqt612yM1sUGLJOaM3orGg24jWNe5venYEitBd8+B+MQ4SC
 AwT8wZX9VycgdRLjPD0nrHk5xzPggOLjMnFiUg3tMLYEJATyTbWWxdHN4+3mxfCmVnBa
 v2B1ra+HoaxOgyvGYSlboSQ9ohtpNkHg5iycZvfGDT4uun+2h8RA4ROr/Db3EEL1QLT0
 07Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015712; x=1782620512;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IiWazTsjHV3FGpcV1rYqHlq9lclQ1rtXU/+IT6WBdEk=;
 b=DbE+qcfkCMEjOEI7E1S3Klqia4EEG/U6rBwc8jDjgefl3ZPnZQj3NxWvUeFVI5s7tT
 uC0sPQ18d3Ic11r+L0G72jJ3+n4HMHozjAl4r1kcDlRLfs66Al2Lfu9UFVY+2RFgULoQ
 kjMOvoZGY8UISKiRYZUpgmbLp4vznhq3B/9SaPNVsRknRzCSDktLQg1782/nAo0Fmlqr
 Y6iY0xaSZdRWBpW7+6hrXC5WQx1XIWwVcoDKOAOq0oXdInaeh+JhKQz5YhHOmBlgSt6K
 pfdON68UPspc0dfk4//pA3fC30XZSdWVNetjxJGD+pU9fIez0XpRZfhg+FHwGdgpYSKg
 yZ0g==
X-Gm-Message-State: AOJu0Yy+RypNR9WIufDcokTPr+2+aKj84LUXWGowuRGU+c+OIoQ7Ierv
 mvhtfZDVTIR5TxEfiyol9hjeEP1LntjzpvSTZa/rb8ifdsENlqht7KZMy7PEF6tt6r8=
X-Gm-Gg: AfdE7cktwlrxIVOKF//yLn7x6/gQ1TuZZh3GMOG1ERYUVydAjML5tNdVYsTvxbh1Ffj
 1YFLlFOSrGGibtD/QsWdpSjigLh+3EegK4pXEC+ZWGO7tdBATlgZlhJAHKIPh0Qw2mSn+X1Vzsy
 YjDDVMnjFDg03E57YNCVnJfYdHw6bbLDQTp2MXpubQNmfmJaSgaMq15ekT7TWgvz0GFi6KOFClE
 qq8PcfoLfl+3DSFkE6RntuO9c8otGchI4I/GEA6gYwofZIy6ywRwLHadOHzVagLs7Upy4hF5/uf
 8vgVfHCVEbY+ynvf26E9maGNWfkUjh14xEB33jERzeO8GLdx8WwW6xeUyUnQzEDcevE2tiiHuPP
 bNhxVT+Cdrv5i8MRMyytFkxfOkNb98gTCgz29KCg5wylvmmpk50UK8hmWz6S2w+AyI67nAQLrZ3
 c=
X-Received: by 2002:a05:6820:6ac8:b0:69d:fc30:1cf2 with SMTP id
 006d021491bc7-6a0d883eceemr7154485eaf.7.1782015712452; 
 Sat, 20 Jun 2026 21:21:52 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:51 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:19:57 -0600
Subject: [PATCH v3 10/40] bsd-user: Add file operation system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-10-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3764; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=V1c5/yRkvmxjSaAU72UKP7d6NpebiPAGQNhepWKM4mY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z9YmLHPD1Y8MqK/Xz2Lvryrr1x+f7SUlSnS
 Dek2kpMDv+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfQAKCRBsHNEofbAR
 AEJVEACiLE/pZxoq429GKmPoFVc7ocPi5WMKqS1SUxxmKQBf7ev+bEeOmudtiBe/+kTLpMGdJKU
 e4O+PGArZBZsD0tSy/VGuMN5ytNnw15X/wk3vA+lY8NJcN/1WqOGjuFDTyA6K21lbKPj2PQYMza
 QQMYqqSHv2mmUSKQXv2qhIhUwMKwhWKizxIAKY7uk9xjnmaBXC216g5m/XzalI8uHbo/BRFhctx
 OAAKiQo8Jjb/UZAVewjGduV75z4evX4AXHzEbI0IIJjp8oGyKyMQ5LVbUOuXdr5aLxsWKfK6ONg
 VjGl2Rv1elCINIftx8+vyaTu02z9pW6I81iVGNPt/mmJeiV3WfXmMXbdWQArN7qQ7XfYItvNm3a
 weYmXEftZ1CUkzK0W0fMFmCoFKedOFAEMIES9GlW9lbGv6Y9hwZ1Mr+27ROHna5GfMLzBKiZGoj
 90vgafEuli+NXZDAy9qSN6IsAqLZ/nHADM5UYCOr4M4uodkXerv7hl/yXwQQxQe9FVG5Q6xX35e
 S6UZzuOe1l780pIfBkGjet3uB0KFGtLrqsHx9C8VV4WOFZA+jnYpw/8XLh9DhHKdGPTDfErtr0g
 PPxznaqJR1AyzyVqgeY4IPImh2Ey0hkumscFemj3EUZxFOOS9I5FSmmXeM0Q9a5n1WuJS7+LKVn
 q8E5sMZFwSXefZw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c43;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc43.google.com
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
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
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


