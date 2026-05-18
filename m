Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFB7CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VM-0000OM-B8; Mon, 18 May 2026 17:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VH-0000Le-Dy
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:27:59 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VF-0000Qc-Uw
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:27:59 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso2793362a34.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139677; x=1779744477;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cVEDxJOr7kvxcvFimTX8HDuVyK0o5vQxB8bQI0dGqCI=;
 b=mbkBHW/gm0juVP4P6ssRFaWDFYC/inFTvYWVrL0RO8Oxh3BrMVvU58TzcGpjdD3/xg
 fWfCjUkRed1GrjGwOP1PwHAF+W2ncsxvxyWxUNC9TVVZrHWCPPyVpErdA8igFSvvYPAG
 h9gom46AuVdhv/kHG2ag67+VLt/4sWdalA55Fsxs0+3rdAed76gn1j1tp4SkEGJ64ZUq
 9Tkq6E1XkbPwV6Bgn4xAFzsI1YDP/cdrDmMjmKkVpCIBuztvrB0woEa9q6be66fdOMsr
 nMbIEparz15VGss7zeonBnekcfr2wI0+kbikHolzVQBji2ZUjuauW4R2uhgOTOKy5GEF
 8I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139677; x=1779744477;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cVEDxJOr7kvxcvFimTX8HDuVyK0o5vQxB8bQI0dGqCI=;
 b=dBrsrctnNPN5xLZdwNACZrlm7tU05fqc2I3BX7cPqdnG4SeGamH/pCT7fVpWvoGtAW
 w7teLRxn2XJQS9U9cUcbtc+qACqQQQv4DiTPOYvYsJjHUITPkfBLrCdkEQTJhJiUHHM4
 V6bmGdJzHB23vxtv/5OULfDe/bUPCw/hHLHcfy+fZpn2UvvOBa4EaE+zcP0jn0/hqEwU
 zX7DyXfOjr9RYOrcUkcaDvCJ7geWji2s2/ux0pI23X5N533P6dCK7fl37ERjY6u19q4v
 4CKTDs1qg72hop0p4DI9Oppu6xGp0zfz01+nM0LCP2d8VCEHuEKYC2SRJEeYIaBqZ1Yn
 nSBw==
X-Gm-Message-State: AOJu0YxoVCQ7wJR6NHPrSfLCHnf3dHcPz64lMTw13JCzw/ld7F27Me/+
 6pPBrsQAkfWQ33eoldG+RUqgb7UCwAC8d1MO3mHOfSdWg1bu+CDxmBSXhgVO9tnQ0BQ=
X-Gm-Gg: Acq92OGJvVtY3SeooRkss9FH1fzeRg4b3Xz6mWJ7Luroukf9lgeZE6dfmRKd0ad+tYg
 XfwNy0z0VtL5OI6Mux9Gb9Xxhtbl6s3T47aeCMGpH/I3mAn/vNtTFs/zdOQIwpVcbUOYswCCBDx
 3ngzzD3b2XgbMvs223or7C7Hl3Ay58tbtta6PhGguRuJZDlYehR3g8m17srCK7MxPZ8Wmez+6kE
 /i/2J9AvZC16P6zXfk38fEaBDOoGAVMXw3aqKmTdXj3MDGJKuRR3ITVZ9/CcvUO1LzXqa2U/F2R
 +adzhSXTtztJc2969qRFviKVHbu/JgupVst1+FxS2LekwgGM3RPor3CLxlVsOTXYYig19CkfFBF
 qL5h99ZQqu0hWVHn19eelXwdWqQeRxhHeD2S6dNngE4j5MrkZedNXfFhT37wviR5t6EB9oxXWTo
 ewjl9l/T3Mdg==
X-Received: by 2002:a05:6830:6515:b0:7dc:d2ad:fb29 with SMTP id
 46e09a7af769-7e4fa057c32mr11434429a34.24.1779139676779; 
 Mon, 18 May 2026 14:27:56 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:27:56 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:23 -0600
Subject: [PATCH v2 05/37] bsd-user: Add signal system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-5-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=kb4jsRODtuqp7BLyHoI4sYGmHuDVkUj+ukniTVK6Zrg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RGpR0i4uLSHQRkaq0XOGd13s9s1f529QQcD
 lcNl1NVmlOJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERgAKCRBsHNEofbAR
 ALXGEACJbJ6lsyNoogXF1bLLzHQD3fpob7Ef7OdJVivIcFxg+csV/FXkYmfjojLvVm6z9x+xntT
 MF1llzEGV/Ye6NQU8BIJqlNf33ooNnB97X4SRHnOaNkt3VxKMtnWIOUUnbHmAyfBLFuy2X5hfgO
 Xs2s8RuQGjyiWwLSAnTaFEd/wRKNmVLtMOLwWSRxEMhDTzu9DJmzqDMMFcSE6fTal69xXjiIXq5
 pKxiSSMKDHqj1Ujb9T5r2YbbM9baNjxHb/p3caOVLs1KEIfDr4E19U/uJOOIIQ2yIz3EuF+7yBj
 PPNzHPAq/YpGo5V9cY3NxyK3iy7JxHVE/ncUKwA1Ks0FV4tiaWRL4me1an+ZQ6hmyYYbAr2l2fg
 s4E838S6iDRN6vEDGtVBLXxiBSWsQezGKkVPnpYqbpIWH5EBy6JO2szobtxb/TsgfzhBP+5IxR+
 T2FVkC11WfE+4omGz62kpxauSTEqpuYQZ8A6X4G5DOdb59moTBXjEurCBDw+JfRVMzaStsKqNeM
 VKaFjz+TnEejPmxSvVrR9jeyLqWQhGjltBBrKDc+wbOukHLqAkipJNPcwJG0Ww1tqe9ZOs4yftQ
 QDchz+JuByOKm7iOYUJBd4anWxhs7HQHnsEB9yLOGJxaYerzVoadftxP4luSWrzzEhkAJMg2TlE
 9tJcGgX5HEYlydA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32f.google.com
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

Wire up the signal-related system calls in the FreeBSD syscall
dispatcher: sigaction, sigprocmask, sigpending, sigsuspend, sigreturn,
sigwait, sigwaitinfo, sigqueue, sigaltstack, kill, and pdkill.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7fefdb569f..06148fe3ce 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -43,6 +43,7 @@
 /* BSD dependent syscall shims */
 #include "os-stat.h"
 #include "os-proc.h"
+#include "os-signal.h"
 #include "os-misc.h"
 
 /* I/O */
@@ -950,6 +951,53 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_getdtablesize();
         break;
 
+        /*
+         * signal system calls
+         */
+    case TARGET_FREEBSD_NR_sigaction: /* sigaction(2) */
+        ret = do_bsd_sigaction(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_sigprocmask: /* sigprocmask(2) */
+        ret = do_bsd_sigprocmask(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_sigpending: /* sigpending(2) */
+        ret = do_bsd_sigpending(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_sigsuspend: /* sigsuspend(2) */
+        ret = do_bsd_sigsuspend(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_sigreturn: /* sigreturn(2) */
+        ret = do_bsd_sigreturn(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_sigwait: /* sigwait(2) */
+        ret = do_bsd_sigwait(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_sigwaitinfo: /* sigwaitinfo(2) */
+        ret = do_bsd_sigwaitinfo(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_sigqueue: /* sigqueue(2) */
+        ret = do_bsd_sigqueue(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_sigaltstack: /* sigaltstack(2) */
+        ret = do_bsd_sigaltstack(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_kill: /* kill(2) */
+        ret = do_bsd_kill(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_pdkill: /* pdkill(2) */
+        ret = do_freebsd_pdkill(arg1, arg2);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */

-- 
2.52.0


