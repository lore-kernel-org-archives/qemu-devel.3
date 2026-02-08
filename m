Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4623FEF06E1
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpAS9-0000x4-Rz; Sun, 08 Feb 2026 14:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARD-0000e1-2E
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR8-000070-7L
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:18 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-66a12c77a2cso2115642eaf.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578810; x=1771183610;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yALg5/MNl2nO24xUZJBgXb45tIqbhdIbI3oNelDRSRk=;
 b=no5iHkXpYzwICgSL/f9cvtgUC9NSdd2Ui+XevNolOqhohnS+LycAt9nHZ84nS4uTGn
 cYZP4Up4YanpTlXNLXMrsu4jAL5LfcHaRsjYWEgpczn6dVTHiRsVu+4cXPaz0UOfCp2A
 0GIODaUhHI6rWE47c0y20rZ5JhbMvUr6xeOBEMKOq+AgR7uw5Lfe8rLWq5Q+Tm7FeBhp
 mfy+GVnN+ZzLewhFyQ48mH/eSoufc2npmg0pGaDvANn8RsniY+zluWML9aMZJYtOATfT
 kJSq75rOVTPOyx4kRdaa1DY7P0hyert4AE52X+BtcFP5q5akkj9k/+xo6/ZLtOmVWAMu
 uafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578810; x=1771183610;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yALg5/MNl2nO24xUZJBgXb45tIqbhdIbI3oNelDRSRk=;
 b=FPkfeofmrqAZGPidggghXfcZOYxnBs19UKyQ7fePRpWCKqQjNVig5knJIkBEyS5rMQ
 WGMu4cGVOnP+rxSLJxaXF7pZLG2cNp8FXQZVzumAiAVXzOfWUFLSMfsND3Dvh2AUpM31
 7mIsTUfKtq+P/9oGeuADDcHmSGDSC78oEbU/O5U7/nW6sTgThpShXuIlJE3wM8JUYk3K
 yq7w4QlcltbcA0Oub5qTUenhwWk2/yhycJLH0Y8diWIAK5RQ7qlcgl5TpEmEpzRV8S47
 JLEjdo3ZitoNICCS3pSbWpSlw18Tex7/u5wpBQIMGKRsfq8UmfkECCe1nJtaFey5ciPZ
 Uzcw==
X-Gm-Message-State: AOJu0YweLLGAsCmxaPlU5nAlN6xXwk4UI3mSq8Nj2jy39kXwWboHXbMA
 rxgGTx9eYFNLVvcUmX6lLjKLUxHT5cX+Oz8eaTLSI9qTCsygPo/OeOpokXSsHQWZrb8=
X-Gm-Gg: AZuq6aJ9GKN+eRA1UREjANKBjQsFksWKpasngUIQZFzw5gH2PD8ydTeWbEBZCTKbrl+
 ZMw28/7GEDQYCfOCu5DPqVlmCRvxv4QBFk/l6p3H/wXpam49NvtG8GOa/O3ZL0y0bskOU701duz
 Ec3PNEHf1/P0krkFnnTYnKb978LVfwbMIP0wpeiQihac47qe/7kA/XvdW2P8V9BKg4m7fSvKkvg
 xsREVvocCPDBFKxvlaqNPLlXKHzAf17c/7Lqg1VnunFOQMARH2f7OUlZL82PZrEv0CQEgIhzrAz
 31lGvAfviCswDmJEEnxCHT6bzay4Id9Xk3ngSDHkID7ph1BrnPDwwYyNnKyxrFSRy/XLEVxIy91
 A5JHTAqK1V7rrI8mgZklSXtUTSpyTr97mOiytgSmO85o012NgTtkuM6ZevtAs6UMW+xeveJgqHg
 ==
X-Received: by 2002:a05:6820:3088:b0:662:f61e:759d with SMTP id
 006d021491bc7-66d0c666b89mr4287451eaf.62.1770578809867; 
 Sun, 08 Feb 2026 11:26:49 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:49 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:27 -0700
Subject: [PATCH v2 18/24] bsd-user: Add do_bsd___semctl implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-18-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=cfJRTsYvKZD7Yc0/nEDaV9nHPnFLlDrFK+u5REhyA9A=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONh1ytqjerhAF5KTqNaGjVQGpF6LRcY5tgpd
 sq5XLIA2xyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYQAKCRBsHNEofbAR
 AHd6D/9f7T8bj5AjPKh6aqdpq0sr+AqhQJimIe3lq5TzCmrLcePe9V2j2p6MwxpqrpoDDH8ZkHK
 9ClwMnvHJjoAssxdBbiS13dYH4gqr7VsZ1euI5VmhR/OyWqJ+aT3PtRMCcDRayTuPIApvmelLzU
 /hHfgk/ZaG2DkP850zWSMCyAQp7MPJh3OCviWrsZ24kO1EWAX2tr6G4CDZ/ywcl1fMUV2T8r9yu
 v0Yx9DIGk2KKxUxrCcRHvToJ2EGApwK/yqnYC4tqo3l15G8sGnc04nT4uSOigT479hQlzn+9W0r
 /k2+j/7EN6xaHf2UdLU9AUnV5kf4xNPLCX+fm9kn5hDn/A7Zvb23TB8gE1nsaUMXJqqMahGAAf1
 HUPPMczsBP+Z42hrDfg9FIeBN+FFJunXF4KyHA2WxZzV+pFsVu4G50lxZVHilzYprnIQ6MH9PvZ
 iH+19igv1b/mI9mwY1YShNOBuxmiL8Ian2npQgYkT/46cD0h9WQMRrM8AsSr3bwU1Wujzkgac6F
 4t83pDP4vGKXpiHbmwqTqSZXWnGidc6bAAwjBJwnlZLJszRW82ZYO/cQF8KxfWVdnZASfLz4a1o
 a/Z1jVV6m3c7ewpm/BtvjAV1t5pmmtsiXKO1h0ChIWPYxtuXpG6uk7zXUpVTCYbPproxkw2HClT
 uFqlsw8rlSMXnmA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c35;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc35.google.com
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
 bsd-user/bsd-misc.h | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index cba0b2ec92..d3ce01a2a3 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -106,6 +106,121 @@ static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
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
+    target_un = lock_user(VERIFY_READ, un_ptr, sizeof(union target_semun), 0);
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
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


