Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE0DC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yF0-0002o9-OB; Sat, 19 Sep 2026 12:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yEy-0002nG-EQ
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:40 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yEx-0008BA-1i
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:40 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae6a9aeaso987192eaf.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836518; x=1790441318;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4s+zO78YhAlvSbx1P5A7DHRUJ8bdtiX0ksZky7VNtEA=;
 b=BWlGf5QV7finfM5+BpbgUpIPPvkmAjuZYRONVsBA5RQvFlm8QxxwbnCBkdC1KkmMfe
 krqgmwKK/V0iCl8G1TJTNu9MZGH4byABlcNYKCpFWMwo5LsY1NyJjIXEbwXOfm9C48vn
 xSkO1EcyCtF1O/v1EE41g+7g0qiKw14b/VxONAg82dLTQaAXm+0Q7dkgsnlJgwFyjgLc
 rFp/rIcZ9aNKbx6iWfh/Y6UVn40rVk/ivCPfrX3nClRnUw9BCBiaU7smoUGl6iz0IMvj
 TXRcGqUQ3LEfVaUko5vKc94lX0aclMbxKOSmAwAYlFmnq1v5It4qG0isbgrckDiZzauy
 DBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836518; x=1790441318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4s+zO78YhAlvSbx1P5A7DHRUJ8bdtiX0ksZky7VNtEA=;
 b=Al0S3Pnub+wbOXSqwlHZNLXAevBTHh1KPxNnC1JDtH2iSBBsNp+36aavxVGmKFPE0m
 VYpjRW03OF0ugGhQ4k67kc5+UhLvxQ6HLfnWI47wtaWiVOGgIq2bAquToD5NaWUJO4hS
 NdTWJ8+aLnkutfUFk473jvQu1TU06qfxKRLFxeGezQYkaNV0TNiY/+pwg17v3mpMrWmV
 BGgLz9OXBWXLwQUtTh540lsD8xzdxndJbugFcvDmOXso/LRHQdrR+zdseVTXctRFPNuU
 BAX+hToTU14dH7IS4aYYXqKizwkLTdLzkr5by5640ss/2AYJK3bC9I+4HnlXY8fLeaE/
 0Miw==
X-Gm-Message-State: AFuF++nP9jc53Us3m3Aa2yjdF5due8E81mj6ZJ0Euco1ZHwWTDQ0wXph
 rICiIE2ASiFzq+F3utfRM/uNv46IK6oMLBFsahlRFuhGSwnznDH6fyN+tY4/L6IjiWpedf83Q8K
 h8z6PO3k=
X-Gm-Gg: AYBFou3xPA7tXZkXxFdnVq7n2MZt+CjcwgOAaxeWgzzihI2xFKxhUhZfaMTNFg7G7+Q
 Z5G0Hykbey5wcjYv1b6bZlfrq6rQe2EsBDip9waMb7Ml9+/Heu1MiJAowdolUunAKBJeeMemyiR
 oCznwfQEK5zu3ryzvi9Uid2ecl11FRG6X2p65rkXjWBfDSwppgrX9GjTCZ5SEfve9XI77wW6AoS
 zE+l0Y8sIZy++Fe39w+JeUTspy7D2VW6BjnE2MIQfMnZ4xQ6DPJZA8OATG8YEAxnQoqZjeMkiCP
 fm3SucB9TVtMVGZQrAwaPgY2FqJtLL0B6ZvXtYyrsK+8URoY4D/fMnyGKuLHp1yqO8L7Roq91/p
 oGpyxYHQYH3w6Q9wVOwjta0/sgPWmt0Mj1rkJINCraTMAJE4/GCZQA2cM1XOMWT1ylUZu3X8uwO
 VTXMTBGfiC0B6p7XulW5O1oKmFfHOfm3qopizQ3SaulrHt0cZLXHNa38tDtw==
X-Received: by 2002:a05:6820:4c08:b0:6b7:83c5:fde8 with SMTP id
 006d021491bc7-6ca9bd48168mr5718019eaf.41.1789836517899; 
 Sat, 19 Sep 2026 09:48:37 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:36 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/41] bsd-user: Add signal system call dispatch
Date: Sat, 19 Sep 2026 10:47:34 -0600
Message-ID: <20260919164810.70151-7-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::d; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 48 +++++++++++++++++++++++++++++++++++
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
2.55.0


