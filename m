Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097DCCD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vs-0000lf-5o; Mon, 18 May 2026 17:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vi-0000Vp-8T
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:26 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vg-0000al-1O
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:25 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso2793921a34.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139702; x=1779744502;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VjcpVZ6ruto1s3vfaA9tu6Wodi+LdfzqPHS4wMxKL5U=;
 b=gPnH7fv0QaY+TmXSEWeO6rfD195PEtP5krGN5BubwrqbcHlw5+J5WFmOb2PJDfymvj
 Q8tdjSekxvzZJ3L15jdXOqj4yiq+f6GvsEfkzl1rvOzTDGdaXG1np8HLTqpd29JWKqmQ
 qTYAJeBaE8wiqsSUxZZDDruKOvzs4p+jkyGjYDN6J+Kf/CngvgmFaFhZj60AOBkszNhT
 s+gYQCBAvPEu8eUz/03EaIziPLKKBJgslacAwRaMNX5LBMobyBjKU61NaBufPoaWL79g
 L9ZOEzcKx6qiuX5g82d1zSLpm9RevnTR8voyz0LszBctWz6SGZ6iMOCilw4OEofPA7CF
 xkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139702; x=1779744502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VjcpVZ6ruto1s3vfaA9tu6Wodi+LdfzqPHS4wMxKL5U=;
 b=dkw+8ZfLkgte16qQKoL8CnsK5/Fk7d8K1K/UWDkp/btu7y4olDu85LKyVVxa107MWY
 ykiO8Z7rdk2azOrCcoa/Zt0ZQXwQfGyDahsfzFE7XeV6mlC4We6zi0lA21wc61KLyrkZ
 DSZ3Ry8DHQNRK7lRo3Yuzaq68lwLBUDG4J7qcJf9x/WooLqtcv+0cTvhcwsfG5N94UNy
 kBjyysGr6+dnfPlMPfGuP/quinUktZV5vKpaCtOHLSzhL/vjYuIZe49CWbx3h/E4A0cE
 u6dj13e6uGKMBEFvXUFHzMIuwdHA5vPhwAZlxFuCfC0xfMsUzrdt3pTlkDTKcnYLQEyz
 wggg==
X-Gm-Message-State: AOJu0YwBvtScgiLvlTKBqycjh2UDK2tFLOwlkD+eQFHTKx67Ks51LVjT
 fEcZ37lm2L+TNilefnL+uCL/cLGHADjt5jTOtxdvJGLGpJgl8F7ycLcYE2XmzEaFWf0=
X-Gm-Gg: Acq92OHRIwTb0VJXrNmbu04+Mu1+1WU8/V2vZWvwJRv5INiQe35pcAb//XnjyNYeAX0
 r79W7ksqjk/h2/KgtkoY0BL4ixae+0V46JrzHOY5NdLs34NnjsKH4bCC+WRbmHMmHLs5URLMc0/
 KkyNYqF2EJLAvTtFshy1POHtBTd9AHJtys3KZ4EE/dcupGsBUXYbt+Y+wnQY1M2F8rIWw4iR28G
 3E40HHD/E/De5UwehBcvY0dlrAZWczWxHCVR1ZTrtlgDYEte08itzgUrcKw3bS4db4woIiJ9sMO
 0w/CsR07/qJWroWIelrxrz1YhOurpTdUa1VpC9W5fm/CmYHj+DObFECaXpU77FxYIxrLGoBPtQt
 mTq0pNoyMVYfcQbwaFVm41VLhbBEyuMdtCcKrvOuZ7hGqSc44jIOZOf5QqVkt/UGn57GwFVjNon
 Uu70zzRD4biQ==
X-Received: by 2002:a05:6830:710e:b0:7d9:71fa:3079 with SMTP id
 46e09a7af769-7e4f2a13f65mr12075492a34.10.1779139702093; 
 Mon, 18 May 2026 14:28:22 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:21 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:47 -0600
Subject: [PATCH v2 29/37] bsd-user: Add thread system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-29-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=asnQtYV47YyPo4EF9BS4x3B4tv7oCfQH0yj2OEdHsb0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RI82hUkPG34jVGmDGPszVjD47hlvV3fAtCc
 ID7x+CT96aJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESAAKCRBsHNEofbAR
 AP+qD/oCZC26l6kuqSHV6iBJoe2eNsqeqRC26+GuNEYBHKtLtklhZNx7uv36/VINPBFRDNNSoaO
 0kPA2xWCXbub971tu08dTl8OBkzez+eUYTefZyxKpanFva6FjnLDh00GWTvZ8lIheOYPK7+4ao8
 8yvte2undgEtrdXmNCIYpI0mDdcUJk1dvKiErkjnLCIClkbQL65af0ILS/YukNo0RLSk/U8b0D6
 ee7F4JxZVRKVJfzgebNg3l+QryL2dP0wfunLkfPVNvnNO5MmAM7T7nw39yvAb06p34mARi9r9tE
 5y1RM6YwgfgUW6RLV0vtcOTy85992IDynBPN7YUrKr9hp1qL6KglF3NR/Q4KYC5msztpZZHDEEI
 pNv+qM+/m1vUhAR1jsg97GnAMsYbynDjD5d5ErpA8sFMUOK8Duc1Hzpx1ONWqmpaHZYSUvHxwmi
 KGtbc6eBKoXT+bhVW2tRqtnSM+ShYdXvL0lz+D/3L/rYwZeDLFDhkOa/d7dL9SsO7WXyInAgS3T
 bmSjlH7Uf1u69LPfvqIRJt72wCE42Y9DnofPH+mkanSQ/FcdYHBs2/I8N6w3Ps2K+ZBVsblLGFa
 BcvZJeJ/yY30U4P+lkK81UskzPMSyIV5sW+QXKImmArtnQ6ffTb6pOv+5eVNjOKPpNL1tWfBxjW
 haspBkdAyYdDlrA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32d.google.com
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

Wire up thread-related system calls: thr_new, thr_set_name, thr_self,
thr_suspend, thr_wake, thr_kill, thr_kill2, thr_exit, rtprio_thread,
getcontext, setcontext, swapcontext, and _umtx_op.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f2c3ff25e8..0c729da0ab 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1293,6 +1293,61 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_setfib(arg1);
         break;
 
+        /*
+         * thread system calls
+         */
+    case TARGET_FREEBSD_NR_thr_new: /* thr_new(2) */
+        ret = do_freebsd_thr_new(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_set_name: /* thr_set_name(2) */
+        ret = do_freebsd_thr_set_name(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_self: /* thr_self(2) */
+        ret = do_freebsd_thr_self(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_suspend: /* thr_suspend(2) */
+        ret = do_freebsd_thr_suspend(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_wake: /* thr_wake(2) */
+        ret = do_freebsd_thr_wake(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_kill: /* thr_kill(2) */
+        ret = do_freebsd_thr_kill(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_kill2: /* thr_kill2(2) */
+        ret = do_freebsd_thr_kill2(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_exit: /* thr_exit(2) */
+        ret = do_freebsd_thr_exit(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_rtprio_thread: /* rtprio_thread(2) */
+        ret = do_freebsd_rtprio_thread(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getcontext: /* getcontext(2) */
+        ret = do_freebsd_getcontext(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_setcontext: /* setcontext(2) */
+        ret = do_freebsd_setcontext(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_swapcontext: /* swapcontext(2) */
+        ret = do_freebsd_swapcontext(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR__umtx_op: /* undocumented */
+        ret = do_freebsd__umtx_op(arg1, arg2, arg3, arg4, arg5);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */

-- 
2.52.0


