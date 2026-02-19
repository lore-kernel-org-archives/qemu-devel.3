Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F1CE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswVG-0002pa-IK; Thu, 19 Feb 2026 00:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVE-0002or-OM
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:04 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVD-00021t-5y
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:04 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45f194e9a98so196008b6e.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478581; x=1772083381;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zmzAcKrvw+80FElJtKbuDqFW03d0ZcWA2mq3lAw48qQ=;
 b=Kvz65PdWJGtoE6sk0Yf1TsbHZUh2OyEawJflXkwfQCCHsyvskSmXY5nYmOdMjysNwe
 7bBzJP628FkC/Ejg7oRuCOMyb+W9jEI0tZvHU9AHsb6R7402qOc62xNbv3PP2F7kMzj4
 AXbSG05a/GgAZAfc+r1+YAm/2/s2uTzMrZMCcJFoJJ+Rz8TDqL6gmSb4pKpTKRsu/1dT
 0t/m0M11dqA8GCrBDzv3JIZ3s3dNs3uO3XTAOUxfiDwgCz2U8i81rgsMggsujyluhS7T
 GBm0YiDKsOdJQtBNhrD1Eo+dqRWbyGKdtpH5skR9ycAaZ5G2wWioGNfjtKFRpIUfvOyR
 os6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478581; x=1772083381;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zmzAcKrvw+80FElJtKbuDqFW03d0ZcWA2mq3lAw48qQ=;
 b=IzdaIrShqWpbaaYmb3beSaeqkMbqH0c33e/Dct+uWd/05kgwrNyF8RzkNz0jEFJ9I5
 XIDKaMk65J4v6/shwWMY9uFz3CgCL9P2Bxo7GmczDIdkn2OjibVJC3enMnma5gEqxNhP
 /mYp3MHR2GGQOl/HOJbjVpKXTY++RF38dJ1CjFFxniWMmJ6nC1xcXxlvspIzd3LDaz0n
 yseY+5bHJQ3JbXYS4HyeOrZoJR5URNDzhZMXNkIp8Kat+AijDJ2pPzHSLR7NH3hqqHSE
 lcLOihnQI6RTJ+rbBhl+1t/6+GVMRsWKwe/MSrV+M4C9YghVn4QuLNmqlz06OZZfM/uB
 bmog==
X-Gm-Message-State: AOJu0Yxe7YyHHjxW/CK6V/yidYjyeyXEKd7U0fF20KJfXo3MTRT3GAJ+
 G8XUjFVVRri2YqrtGInzhoti358+zt+F4l4n4wnD69Eu4ljm7FYfxUoLVRx5GOy3Wfg=
X-Gm-Gg: AZuq6aKvaWU3J4LrsKzSZ9/5WQE7fs9Isi6jFGRGhR63IBY8iy5U9MFBKzA8HDmVPn7
 YT4uZ1qGjKRy9yBMyTd0OXXMYhI8Nb3UbLqehRH9Rb6MAog6kOS051+BSwvAWubGo4lc5cASSVp
 2aTL6BkWqa4vs9+on7zZxHidW3zsr68QEyUYzCub+FXpnD5oo5DhIaA9PqmG36IK0WzTilKAYQI
 qywSGSObxNJzQTBa2dhTUr0X4+gA5++29alS/dutfXkceGuyM1+FzmYQV5FUJYd9fWUb49oUbzO
 buwHFji1R/LDffIvk07aF7T9AHGg3I0+A07sXFBKF2aleawB3ThearXYo9D6h26HMBterV6ftsZ
 XxKaRviJeiHK93MIHXdRZoLIeZUnDKUW63VrURi0f3lvo77LDolD0iqPgCrIAAghZW1S8dkfq5H
 D/mlR5OrEp2g==
X-Received: by 2002:a05:6820:991:b0:672:e67a:96cf with SMTP id
 006d021491bc7-67766ad5b04mr8726622eaf.16.1771478581431; 
 Wed, 18 Feb 2026 21:23:01 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:23:00 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:41 -0700
Subject: [PATCH v3 18/24] bsd-user: Add do_bsd___semctl implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-18-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3747; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=CS/V5WC8Srq1FLPmW0uAGJGedye01GRaBY0Hn5RlDX8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4scuf4hpBud14pWQ4s+2Q0smTeW0bIjC1eb
 xjd0aE2W8KJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLAAKCRBsHNEofbAR
 AKrtD/oDSX0WMFYuMgGVQHIlSbK2dszJ5stfUL3NpKuqeAtFbh/iRHTapGWcNZiITmld3njxm17
 eEQG8mXAurEXY6hhXc1CWNEqwh5rwDiSdj9DR8Z6q43xUhfg4fZn89mYukS46okGWFGGMnJFSs3
 SSu/XwqBAh8/MmEBxG0YqSelYtX5m/waGT8n81jNqwanAbwoc1CYbWG943cmcc/sIIFMmBS+wW+
 eQ93wxN0rcTXboQe03NsTB2G+po7aYMJ47oK2mC20lI79tmAlbKcnfXGuFrn511obmhfyeRXU29
 eR27TlDV0050RZjcU1P83oMyWrBUz0Ts5S3/uYUj4ItaishHG2Vc9n72DzJ5yMMtAMmkaXeOi9X
 a3VWh4kZrLMHBOG63gElzDqe76zHC2NY8aPv302AIBmjxbI/y69rcOYBcWYSFgO3CrJD2FElWWn
 /ZtjSS3g1PrvqacuT9QhDqjpXVhZstKziDv2/sF9FeaYollHkdUJ6O1v+k9TQsUjV1OmehMbUV4
 Xwdda+59jhnfiD239bxftTUmURGeJKuvKg4tJ3bectYWB4/n+WjZW5/8837nO0rdX71IohlReUo
 he8AZvInTM55HbAS+qVHXwgJZT+9BgEGr1VdX9PdZ6921vQ8AxcHzNOnqDOBWsfLPvaoWQ5bnls
 0DtXW0Q5E5HH7cw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x236.google.com
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
 bsd-user/bsd-misc.h | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index e1e552b58f..cb7fe1d6d0 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -99,6 +99,122 @@ static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
     return semop(semid, sops, nsops);
 }
 
+/* __semctl(2) */
+static inline abi_long do_bsd___semctl(int semid, int semnum, int target_cmd,
+                                       abi_ptr un_ptr)
+{
+    void *target_un;
+    union semun arg;
+    struct semid_ds dsarg;
+    unsigned short *array = NULL;
+    int host_cmd;
+    abi_long ret = 0;
+    abi_long err;
+    abi_ulong target_array, target_buffer;
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
+    /*
+     * Unlike Linux and the semctl system call, we take a pointer
+     * to the union arg here.
+     */
+    target_un = lock_user(VERIFY_READ, un_ptr, sizeof(union target_semun), 1);
+
+    switch (host_cmd) {
+    case GETVAL:
+    case SETVAL:
+        __get_user(arg.val, (abi_int *)target_un);
+        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
+        break;
+
+    case GETALL:
+    case SETALL:
+        __get_user(target_array, (abi_ulong *)target_un);
+        err = target_to_host_semarray(semid, &array, target_array);
+        if (is_error(err)) {
+            return err;
+        }
+        arg.array = array;
+        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
+        err = host_to_target_semarray(semid, target_array, &array);
+        if (is_error(err)) {
+            return err;
+        }
+        break;
+
+    case IPC_STAT:
+    case IPC_SET:
+        __get_user(target_buffer, (abi_ulong *)target_un);
+        err = target_to_host_semid_ds(&dsarg, target_buffer);
+        if (is_error(err)) {
+            return err;
+        }
+        arg.buf = &dsarg;
+        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
+        err = host_to_target_semid_ds(target_buffer, &dsarg);
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
+    unlock_user(target_un, un_ptr, 1);
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


