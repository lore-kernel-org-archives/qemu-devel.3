Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1C0CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzx2-000191-UB; Fri, 15 May 2026 17:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx2-00018Q-7a
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:08 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx0-0002pp-1j
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:07 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso312692a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880004; x=1779484804;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cVEDxJOr7kvxcvFimTX8HDuVyK0o5vQxB8bQI0dGqCI=;
 b=hC/IKqshTSWwuZnpup/d4aynWXWqi3/Dws0W6Q1eZMH0G+H0m7CXWdJYLxN4aPammY
 JaO45vx1Db61l19k+4TysLx/62aJFCbpU2FyKmmzPpkHhDwe3RHxSQYWnEc/ufpOFLqf
 NjQsfewoKZHn9KedNP6AOAmtixOSh0rN31PnIRncxLcq9JgbLWpwz8B9V24HVKr+310p
 XCBCInqRD7DHJcervr6rgJALZkgX1/4OA/FYfHpoaWMw9+Cps8lH3u6sUxJXtsB5ozqi
 bsAVsV/HM45Wg8o/Nr/cu/SoXMBjhBq2NCYw9MGPDVEuSDFS0kCsgC5NTOzMFRouHq1O
 ae2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880004; x=1779484804;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cVEDxJOr7kvxcvFimTX8HDuVyK0o5vQxB8bQI0dGqCI=;
 b=BZj0201r/EQhe688nY9KwXlTnwAibBrJ7tOI0WVAvFs/4fI26QNE4Yj0l5Skf4dqTQ
 97AT0XhcK1MfIvHAkRbsZDJEECu97bZvJ7UEuIuhB6zwDd8/9vr4QO/fWBlVeMfIY8KT
 UEIZ+g/xQwGZoNpntYmbvmDcScNW2ki5u78ArF71XJUuPugbhtAJt8hqgNi8vNFOMr/i
 Aj/RRz4Ds19ZR2H7V6B+BFsbUYvLLNr0P7DeE7xZzTPk/6FwwKO1l2Gn9/hYpkrRVckR
 Enyp/LbIrKRZcGK8zqL0mZoZI+DGLsEAuTa/uLod+LS2vy2kVXUkQjcj5VXMdYAd2f9K
 x8aw==
X-Gm-Message-State: AOJu0Yz8jpwsMzELO4U0M7AP2amZV+/mNRhBWq1TI0aS2qKiiSQZ5Csp
 z0tHRCwPuo5i4h98EV6cacuaeOSJo5Uua0Zln3wlsNGf/ism3QRTNRRpSwUp7e4ATEM=
X-Gm-Gg: Acq92OEdGgYI5CPy7mOWs8kodOfNOjX1OjVb6Y4Dao6U2Qt+rz1h3eePPH7492CdyaX
 qwMZ1cj5gpsCJNowXjcymKnXaMlRz+zHIXsWO5fsvnWlU+PgkS/F7uGs0jUU/pa/VGbYSCa4hUS
 QPumzaly41+uBrBmMU3D7ZuRS7uiROyLjaoRdfiv+jM0NGJfo7lXuojmRJ+5tQjbd6eg5F8fSHh
 A3RxEqAfCTDty5+RYwkQvoPTEUzEZ6ZtTSx2KH2sBnFtReVWFlciul+W6vasawulfvHhxEbrjtR
 ciBndz4yxUGmS5bvTXqfxvK5GZv9Z7rgVg9Xa0tqRPA4Ur8En7ifFv7MPddKDzluf6fVVHa5dKb
 f5EPeUg3mr6wPVQbnzs6J5mRdhfkxNJvdeHwLyDH+CmTCjE+SlV1trhowOcI9C4oBulaT+bsOpd
 HMqlPRqECUp0Bq5zfxFMnu
X-Received: by 2002:a05:6830:4410:b0:7dc:d679:3eb1 with SMTP id
 46e09a7af769-7e4f2bcccb3mr4224898a34.25.1778880004606; 
 Fri, 15 May 2026 14:20:04 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:04 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:04 -0600
Subject: [PATCH 05/66] bsd-user: Add signal system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-5-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=kb4jsRODtuqp7BLyHoI4sYGmHuDVkUj+ukniTVK6Zrg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43hs8stSkN2NVLsZUQQ0HDHTah7EV2+IFOet
 D+HPQ2B8JSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4QAKCRBsHNEofbAR
 AI73D/9mot0b071IZU5hPn57g26L8ehWdK1ESiQ7UaC5+puRDS1SkIUuyaSg02W7qsdsXLT2eHK
 ANnFihPxLcCLIsczAC+Ecjnecnk4AMMes4S6tW0vTHRSmK6Fv2UsMJ3/NULBxASExV2Tebmgo7N
 u9xWZdoczPNUJbRMduuCqmYezmqBsZWgrClgd/1i4wu7TIEODrc4koGc1qSRAacpWVqWnEcArgk
 x0muvcpBILSWtZnfAEhbSmqecIb5ZoiMPlDGEPZSYa9msRCKqSo6gpS+r1hmvxt2TLxgz6qrlOA
 S6dxZPCBNhVU10Xz43LtXfa7Fuc5OM6IVaa0WvqZ9bqyBmD4ztOONxtnolmA3d6Fzr6Y2dQmIZQ
 iDrPHHCNdO162iJZFxc+ZqDaUbJEvIt7y6LumZS7f6nsoxJT6Q2idOAED8HQ8MeuGbBRHQAAwfm
 ppu9HLBw8A8IdW/Ke4yCQWzKZ5arGZeW5Qyfr2senAUGijzy+rhp2IWd+tEN6IF0NFsJOOOfDnY
 /BWdrAdi7aqyE5YpuqCcf0ik5wDW8d0xugY69HburDCzx5JklOvG2pRYIAfAG/0Q1fZQsUcUOuL
 ErA3+ubQYGjSDnNk7NOuQ2P+DRiEspfPGD2B9CQ5P39KkXDl9nqUIadFg9bYqXyg8PXAZvObuTb
 028dmnaZEnci8Uw==
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


