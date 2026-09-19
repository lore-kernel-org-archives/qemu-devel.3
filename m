Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C1CC982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yEz-0002nS-7D; Sat, 19 Sep 2026 12:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yEw-0002n1-VS
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:39 -0400
Received: from mail-oo2-x2a.google.com ([2607:f8b0:4864:31::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yEv-0008AF-9v
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:38 -0400
Received: by mail-oo2-x2a.google.com with SMTP id
 006d021491bc7-6c901f4bfffso1000908eaf.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836516; x=1790441316;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hw3PVYWVyfOZlqFEjNse5+bK9WSckDL6geC7202YNEI=;
 b=bMhwJmNlGLbZhV4UMtL5aeUYRtYFQlBdm3RZla9vCnnOK1v6xsxVSKtuk2HzY/E9Yo
 y+xdyQJQGFkE6h5ZvmrfRbdYcmJca7Xvudg9VkyNG4LxH2ym6XXxiprTEBCLTYbpVbVU
 3aQ0ceNgB6yHChH74I+r47ISSpiWcDQ4upQSuT2fVAN6t7JNxKYGDIMftHCa2TGcq9ks
 n9dF3ynrcgr9q0BdJsPPXxqZGUASQPpZ8dMnokXA3BXOCCvC1oDlCGsJAOEwuauaPKWb
 T+YfNZuRawW0NgfWiUpHrYMzZe/wL8VvBbh5gT82/gbJ6qEBgESd5Ym3VMqvhM1qoIR+
 v96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836516; x=1790441316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hw3PVYWVyfOZlqFEjNse5+bK9WSckDL6geC7202YNEI=;
 b=zLs6ESZVAEfdKdRZ0Ywb8NkK2tx/jJB63uXO+d4QT7uYZCEciKll35xtEUY5zcTw18
 PpTX7zpfTdsNYnVxu7uzOsZ4jbHazujFJ/iCueRYmPN+LY+wVlPidZsJR5opt80SvM/9
 4EVb7N8PL/0Eqz2llTdNxILoAsMgLT3oH73VyyMdgqrz4m2uCmu3mLaj4R8h0apDU+cJ
 HwIH45FpZAu76miuzZ3qfRjlndMJydOnQqW9Huyk1/ot0f7/uSiHZL8Jp6VMQwEVSOLg
 UQZ2nMQLg4u6WkwajLOHxMv/7f38XaqdcbgJnoeEB4n4RdB0xaBFRC3U1Lwis8Yu8Ie3
 Quzg==
X-Gm-Message-State: AFuF++nkwP0LghiO9ce6vlQ/gf8dpOkeNl6T0XFojbnXcmrYiJBowb+V
 zo8dD6ja7/EbDwcyOEVqZtifbUc6GTqF88uROBEVrjP3lV5QN60llnlwPLHR7PQJ+Hgs5bl/nB5
 6WaVjDAw=
X-Gm-Gg: AYBFou3E/qggjPoGMtH+v2MeAY5ivVSJMnG/L1ZOthEHk0UKA3OFBvzCm/E5u8RdYAw
 HZwYy+TnhrbXR5kR5a1b2vIk4gj5fjSeFqNYJ5vLMvHDtPfLCkUSHTVyg/Eg5S7ZRulImTXjBW6
 gm/1hWyzlagDicuSoUs/I9w1xMbWar3u3LGuksneuk92dXch/Y3ChHQUV1w9+ULYMu4eQphA3qC
 lpeLA+btv4hwUMokSZLhGb6jHofmfAP2gf/gnEdqpZSiyUawFQmMS+k9h935SEP/oSiSOIHMT6D
 ES0UV4Ahl0Z6Tr4zFeYhtAW5s3a2fUVxvAdZDJ7ZxcXvUqwL0X4aOgkXZMe9L/30QPtFF5YL9vE
 ZD+aMZ0ho3C/t3/hMZCTbK+0v6/cthAcOW3Nxqbjc7PlMlPvNXnU/G9FAzylrzU05l6CmjlFJIp
 EkEcPe6m/Vw4G47T96CZjDpE3Vr88y9f1tjB4CfRkK706M5YkzF6AwnX7dLg==
X-Received: by 2002:a05:6820:997:b0:6bf:5d5e:5402 with SMTP id
 006d021491bc7-6ca9dd893e6mr5364459eaf.68.1789836515966; 
 Sat, 19 Sep 2026 09:48:35 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:34 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/41] bsd-user: Add signal shims sigwait through kill and
 os-signal.h
Date: Sat, 19 Sep 2026 10:47:33 -0600
Message-ID: <20260919164810.70151-6-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::2a;
 envelope-from=imp@bsdimp.com; helo=mail-oo2-x2a.google.com
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

Complete bsd-signal.h with sigwait, sigwaitinfo, sigqueue,
sigaltstack, kill, and killpg. Add FreeBSD-specific os-signal.h
with pdkill.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-signal.h        | 80 ++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-signal.h | 20 +++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 bsd-user/freebsd/os-signal.h

diff --git a/bsd-user/bsd-signal.h b/bsd-user/bsd-signal.h
index 49e58d7436..09c5b30913 100644
--- a/bsd-user/bsd-signal.h
+++ b/bsd-user/bsd-signal.h
@@ -148,4 +148,84 @@ static inline abi_long do_bsd_sigreturn(CPUArchState *env, abi_long arg1)
 /* sigsetmask(2) - not defined */
 /* sigstack(2) - not defined */
 
+/* sigwait(2) */
+static inline abi_long do_bsd_sigwait(abi_ulong arg1, abi_ulong arg2,
+                                      abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    sigset_t set;
+    int sig;
+
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&set, p);
+    unlock_user(p, arg1, 0);
+    ret = get_errno(sigwait(&set, &sig));
+    if (!is_error(ret) && arg2) {
+        ret = put_user_s32(sig, arg2);
+    }
+    return ret;
+}
+
+/* sigwaitinfo(2) */
+static inline abi_long do_bsd_sigwaitinfo(abi_ulong arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    void *p;
+    sigset_t set;
+    siginfo_t uinfo;
+
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&set, p);
+    unlock_user(p, arg1, 0);
+    ret = get_errno(sigwaitinfo(&set, &uinfo));
+    if (!is_error(ret) && arg2) {
+        p = lock_user(VERIFY_WRITE, arg2, sizeof(target_siginfo_t), 0);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_siginfo(p, &uinfo);
+        unlock_user(p, arg2, sizeof(target_siginfo_t));
+    }
+    return ret;
+}
+
+/* sigqueue(2) */
+static inline abi_long do_bsd_sigqueue(abi_long arg1, abi_long arg2,
+                                       abi_ulong arg3)
+{
+    union sigval value;
+    target_sigval_t *tvalue = (target_sigval_t *)&arg3;
+    abi_ulong sival_ptr;
+
+    __get_user(sival_ptr, &tvalue->sival_ptr);
+    value.sival_ptr = (void *)(uintptr_t)sival_ptr;
+    return get_errno(sigqueue(arg1, target_to_host_signal(arg2), value));
+}
+
+/* sigaltstck(2) */
+static inline abi_long do_bsd_sigaltstack(CPUArchState *env, abi_ulong arg1,
+                                          abi_ulong arg2)
+{
+    return do_sigaltstack(arg1, arg2, get_sp_from_cpustate(env));
+}
+
+/* kill(2) */
+static inline abi_long do_bsd_kill(abi_long pid, abi_long sig)
+{
+    return get_errno(kill(pid, target_to_host_signal(sig)));
+}
+
+/* killpg(2) */
+static inline abi_long do_bsd_killpg(abi_long pg, abi_long sig)
+{
+   return get_errno(killpg(pg, target_to_host_signal(sig)));
+}
+
 #endif /* BSD_SIGNAL_H */
diff --git a/bsd-user/freebsd/os-signal.h b/bsd-user/freebsd/os-signal.h
new file mode 100644
index 0000000000..fe102c33e4
--- /dev/null
+++ b/bsd-user/freebsd/os-signal.h
@@ -0,0 +1,20 @@
+/*
+ * FreeBSD signal system call shims
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FREEBSD_OS_SIGNAL_H
+#define FREEBSD_OS_SIGNAL_H
+
+#include <sys/procdesc.h>
+
+/* pdkill(2) */
+static inline abi_long do_freebsd_pdkill(abi_long arg1, abi_long arg2)
+{
+
+    return get_errno(pdkill(arg1, target_to_host_signal(arg2)));
+}
+
+#endif /* FREEBSD_OS_SIGNAL_H */
-- 
2.55.0


