Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9353ECD98C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38H-0004Wa-93; Thu, 05 Feb 2026 12:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38D-0004Ts-0q
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:05 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38A-0001RX-5I
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:04 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40438e0cba6so814378fac.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312421; x=1770917221;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hARm4ZVp4UQOIrGnY8G9/H6CU9f4tk6JRiUQdLGJAAs=;
 b=lkEx4MqkNA+EMfLacbYn7qYG7ap4bFViR5TgzMJeCqrIs5OWN87KGwNT1L1+oVTibB
 KvjRxMNrLoyV08Eevl5hrsD+WxUfi+GyHxzDjjxC5/KlXt/hk5lAIs9Bu8lq1Dx/PH7a
 nsf4ymblyR0SEuu2Gyx3v78sny2eoduCniyCtNGR8v+Eok5a8iwsCovPheJNwCLBH9E9
 e3I3NKJyPXiJG25Eg8OYs/ZbczL+jQ3Cu74DRVVwWVoH3GNUOl1HoLM9OmxZAzw82y/r
 1I71lFH1GGppLS7Zt+Jb7q3PyRWI1fvudjPUxM9uZfKNDmfZh6aXwer8xZqvZFHuvcDQ
 FVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312421; x=1770917221;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hARm4ZVp4UQOIrGnY8G9/H6CU9f4tk6JRiUQdLGJAAs=;
 b=qYzVyod8AFSO6Futgq9drNeu87+kDhKJj1EimFN+/aa8rysgc0aJoy8L4uMLWzWtaV
 VfHDAJxx6byHa/7ruM4AZnoFwXS9rdxegSkYoLA5+gperCKfpcgA/Yi8MyIT9lcYJAUH
 l9hx8xA2+bEvJhrLB0STMxlPmANyJ5MZheNHHMqJGMkRctjgd8BxB4iw9dCUr6tloqzf
 NwkFFB/miAN5nIllXyNl6de9G9FPc0mNDejO+OEMoOnHrtLSZ7xSgAM7VChR3cTc9aO6
 k3rUKufY3HwyJE7w5hz9eC4Ud0cABOjJncd+QdckQ2jloeXMwTYhSqov9occcNw/CB7C
 +pPQ==
X-Gm-Message-State: AOJu0YxkhKJnPnQea6mEBG8xAU0cTHxQCB5vf3pPUr6k8cXqfrgExkwn
 RCa+0IDyh19LR6qf9Zf/Bwu+8qPgns1duv2TT1tY/Lft+TP4XCSFd4Njzg672K1jD9o=
X-Gm-Gg: AZuq6aIuIJ2lvGx1h41iCf/Yt9L1x4/KuQEMfEDd3ksCCEC4A2kIzZxEfYIkXVpAPzL
 qAkWJmrvp70hS4x5sREn8ozxVOP3UaqsSNBRASlYZ/SlpxYo3WbCyIOVQQRY4ZlcQ6AUmN1A8rF
 uB56Z3wRT7KrRfIoTf//2LQyrvv/f/frZyWrh4gVw4pBhVRdawYrXkQYwXbHJvHBIeIrICcJC+0
 wwQLMMwtnRDfLDGXuMj1mHAgzfmLwAfEyA/fP7M+Q5fYDUTQP1yxU425hMF1RmSaMAaXej5lpk/
 TUe5Pyp47UPez0dYhCaWXCpOrxYML5MlY7z4OLp/B3FmZ79iVcO4cior4TIh2wlIVxVAqPAzGif
 pjbABEFO4Zfxc23MCyuW/RZg4upBaZmLOjrMeHb+/Kh8PWNwRNSV9UdR4hTzAj9MsHlLasYVEyw
 ==
X-Received: by 2002:a05:6870:d891:b0:3f5:b16e:82c6 with SMTP id
 586e51a60fabf-40a96f7d35amr3446fac.52.1770312420901; 
 Thu, 05 Feb 2026 09:27:00 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:27:00 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:51 -0700
Subject: [PATCH 18/24] bsd-user: Add do_bsd___semctl implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-18-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3865; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=HUPyJDxIUhLpC347cYUoD0NCrlqyR8thYmZfxprwEXo=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLbp20o7Qfo/cFNCPpWjkizHKCS6t4i7HCDv
 8SqQh6RbQ6JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2wAKCRBsHNEofbAR
 ANOiEACXKMv9jUv/HK30b8IzNgpeHHr2Suu5q7AVs7nOna3LWrBRQ2ypP1YG8W1eV+AVv5XxZwX
 VU5poAlkOa3I0ht24de4AawzzTuxHpGjjvcCs1z1HTyzcG9diq3q91bCqFAcWhSfzKdx8ju6WuY
 i+GcD6RzMTnYKpirQpDLBbrWgjptUUYrO8Zmo+VB7amjMP4TRt5Hd0EkbbZm2BKKNjH8sjn1/rm
 vXr+mE1TlQ/7F2IBgICpyLumwW0dfsRKo643Z58f8Wz7bpZPsuL0SeRaVoU0w0fJ+Tj2xBvgZmZ
 47jyGebHRv02RskcDu0pRyhF7zZzFWF5oOJoXtFJlrVsSKcUFX3c+WdHXpL6qR9TlsPMAp6jxf/
 ZnbFLqg1bOWE5ixS3m3HTwH6uKJYrVadMD0xngx23/xR9ALpynz5mGQhBrvwtZvb0qt8kcRFMc6
 ivaU/Z4SiKZaORIRo5ojYR6+PuDFuPyv/9ZRchspQEu+Yzx6VCKeNLznZW1fgAnoNXlxsxLEZdQ
 aVU7CC2q1Mggo8aWff50dJt87fYNFiYOCXlltx0CRTausYuuMsKlMG5bFHdSHIiG46Mq1MXMQk6
 sFQcGDx6mHp16c8wa/MZlGiSFbMbqVZh9Ka3ujylYIBD49zhcuT6pHeqneGhDIOkTqfTrX2K+FN
 kylWiuk/HxWTJwA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::30;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x30.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add implementation of __semctl(2) syscall for System V semaphore control
operations. Handles command translation, endianness conversion for GETVAL/
SETVAL, and array/structure conversions for GETALL/SETALL/IPC_STAT/IPC_SET.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 1aa1549fd2..81fdfd8351 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -111,6 +111,123 @@ static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
     return semop(semid, sops, nsops);
 }
 
+/* __semctl(2) */
+static inline abi_long do_bsd___semctl(int semid, int semnum, int target_cmd,
+        union target_semun target_su)
+{
+    union semun arg;
+    struct semid_ds dsarg;
+    unsigned short *array = NULL;
+    int host_cmd;
+    abi_long ret = 0;
+    abi_long err;
+
+    switch (target_cmd) {
+    case TARGET_GETVAL:
+        host_cmd = GETVAL;
+        break;
+
+    case TARGET_SETVAL:
+        host_cmd = SETVAL;
+        break;
+
+    case TARGET_GETALL:
+        host_cmd = GETALL;
+        break;
+
+    case TARGET_SETALL:
+        host_cmd = SETALL;
+        break;
+
+    case TARGET_IPC_STAT:
+        host_cmd = IPC_STAT;
+        break;
+
+    case TARGET_IPC_SET:
+        host_cmd = IPC_SET;
+        break;
+
+    case TARGET_IPC_RMID:
+        host_cmd = IPC_RMID;
+        break;
+
+    case TARGET_GETPID:
+        host_cmd = GETPID;
+        break;
+
+    case TARGET_GETNCNT:
+        host_cmd = GETNCNT;
+        break;
+
+    case TARGET_GETZCNT:
+        host_cmd = GETZCNT;
+        break;
+
+    default:
+        return -TARGET_EINVAL;
+    }
+
+    switch (host_cmd) {
+    case GETVAL:
+    case SETVAL:
+        /*
+         * In 64 bit cross-endian situations, we will erroneously pick up the
+         * wrong half of the union for the "val" element.  To rectify this, the
+         * entire 8-byte structure is byteswapped, followed by a swap of the 4
+         * byte val field. In other cases, the data is already in proper host
+         * byte order.
+         */
+        if (sizeof(target_su.val) != (sizeof(target_su.buf))) {
+            target_su.buf = tswapal(target_su.buf);
+            arg.val = tswap32(target_su.val);
+        } else {
+            arg.val = target_su.val;
+        }
+        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
+        break;
+
+    case GETALL:
+    case SETALL:
+        err = target_to_host_semarray(semid, &array, target_su.array);
+        if (is_error(err)) {
+            return err;
+        }
+        arg.array = array;
+        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
+        err = host_to_target_semarray(semid, target_su.array, &array);
+        if (is_error(err)) {
+            return err;
+        }
+        break;
+
+    case IPC_STAT:
+    case IPC_SET:
+        err = target_to_host_semid_ds(&dsarg, target_su.buf);
+        if (is_error(err)) {
+            return err;
+        }
+        arg.buf = &dsarg;
+        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
+        err = host_to_target_semid_ds(target_su.buf, &dsarg);
+        if (is_error(err)) {
+            return err;
+        }
+        break;
+
+    case IPC_RMID:
+    case GETPID:
+    case GETNCNT:
+    case GETZCNT:
+        ret = get_errno(semctl(semid, semnum, host_cmd, NULL));
+        break;
+
+    default:
+        ret = -TARGET_EINVAL;
+        break;
+    }
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


