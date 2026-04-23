Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371C6FDEE39
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG4cw-0004U7-49; Thu, 23 Apr 2026 20:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wG1jo-0002Zz-JS
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:37:32 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wG1jm-000188-V0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:37:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d7b879691so949512f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776980249; x=1777585049; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U7LovPah/QE6KW73zZhcUInjXBKP1mVggfWfskBESs4=;
 b=gEQWWbK8+P3TiWRgMBVl+hKy+CG8W5NmbwXB6Ph6cebqPIREarfkrEcsulsO4CJGlu
 Fud+OJteYc2OaWua2KZHPcHv/jhI9TnQ1kjk0b7gGDtYNBouIrQUPzbByoqumAvU1VDd
 tAQ2vb8LxHog83rcBBmWWLhn90i+CJG6qargJLRFOqTlWkbZt8h0bf4SNayh/eYJzbK3
 vVJY5U57j6PakLHZSgRKUoSfzvD15Us1p44Rr8LVoqg6pzFZ5Se8ty/vwEDmFdjCLPbh
 VXA1yZNAPG6767WGuLtwbsWjrnGkL/AiQxX8z9ldgS+KKrJth1Bh/7/yM1qKTllPRcj6
 GSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776980249; x=1777585049;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U7LovPah/QE6KW73zZhcUInjXBKP1mVggfWfskBESs4=;
 b=OmOdaXBh/oQES9dpVJ5Pk6rSNO9TNUbsByLkIwacfiuPBadD3dT4TfP4Y0cYWT9pk+
 RK6JU4RyXbwNEhtjQDrjlkWF5vQGUgDC79ZWFD+7nmMD/wtd8gkqlgZdB/LqimAq8DTo
 oKffIpbGKPJ//z4xcq1E+gI/EdSxDtwLEzWy/3j4f6uWf2tm6XvWjVix7LYIbuDxw9EM
 PXp7q98XMUIm3L/TZd8imP3lHNmQ8LIMETP61PYV/NjRP7g8I3UC3/DlXHN+49nqRCuN
 HmaB6WuaEdpw5AcZwB7WxENrNnZz2X8IXFUHMdrobdi5FqkOcmMEKC0Mrk+XwSvNrLTK
 Rbsw==
X-Gm-Message-State: AOJu0YycAmJwsY/mcsEeK40kYNQsEGm/4BKl3OR5M00b+NBmjCu6e4ST
 qSxGrVIBJk4WHkjTgr0o71eDfs6sqbc+fQp0FQuaspxAm9hjSQSArnysOqw1CsDw
X-Gm-Gg: AeBDieum6XVnaYaDVVtYOKTuGJeAC3/Pxs9fYxydmC3f5/cVaIE5wEG4jDSbWM9WFut
 ka6KJVvg9j9JMnYIC/p8fZwgT4msInmVc1CIJoo4vD2ILSuo9qIQel2D/aHhkNY8nug6rpvMKTD
 GLEiJNp2ERJHoUVb+D2JzBqu1TLjQuNauck+RF2PYI2epog3wnAJOKzeoOYgp1fbhU+AExDIpDl
 zS/a5+apFevpNNSBSoMKn8KahZOoGikJs1wWAPtu9EuRhFQ4j0f6czhUISm1df6iBsbxFkeiTz9
 QMwY7iVudAix//gcaRENplcBu+CttrkxnFTLgU5pYDlgsWANnarvZNvUTaI9s9WjcnoBjStkMJQ
 NVl8moVi0lhJDEtnduuNonSfJ4Nf1Ra/PpnwIBbZHM/wo4Lhy4XkZ6SI4uWKqBSvsV4LWKqHKq7
 pFWAg/y8ftHPtcyppwY/55Iz4APVwJUD+T/dp8/Q14Nw==
X-Received: by 2002:a05:600c:1389:b0:487:1826:e138 with SMTP id
 5b1f17b1804b1-488fb739780mr210684635e9.1.1776980249086; 
 Thu, 23 Apr 2026 14:37:29 -0700 (PDT)
Received: from [10.94.10.196] ([223.123.19.204])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48919f54572sm138755225e9.26.2026.04.23.14.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 14:37:27 -0700 (PDT)
From: Ali Raza <elirazamumtaz@gmail.com>
Date: Fri, 24 Apr 2026 02:36:39 +0500
Subject: [PATCH v2 2/3] linux-user: Validate tkill/tgkill targets are guest
 threads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-master-v2-2-8b50b5c063ed@gmail.com>
References: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
In-Reply-To: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ali Raza <elirazamumtaz@gmail.com>, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, deller@gmx.de
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=elirazamumtaz@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Apr 2026 20:42:33 -0400
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

The tkill and tgkill syscall handlers pass the guest-supplied TID
directly to the host kernel without checking whether it belongs to a
guest thread.  This allows a guest to send signals to QEMU-internal
host threads (RCU, TCG workers) that have no CPUState and no guest
signal handlers, which can cause hangs or disrupt QEMU operation.

Add validation that checks the target TID against the guest CPU list
before forwarding the signal to the host.  For tgkill, also verify
that the tgid matches the current process.  Return -ESRCH for TIDs
that do not correspond to any guest thread, matching the behavior a
real kernel would return for a nonexistent thread.

This complements the /proc/*/task/ filtering in the previous commit
to provide defense-in-depth: even if a guest discovers or guesses a
QEMU-internal thread TID, it cannot send signals to it.

Signed-off-by: Ali Raza (@locus-x64)

---
Changes in v2:
- Range-check tid/tgid before narrowing from abi_long to pid_t.
- do_tkill: only reject signals whose target lives in our own host
  process and is not a guest thread; cross-process tkill is passed
  through to the kernel unchanged.
- do_tgkill: drop the previous tgid==getpid() blanket rejection and
  apply the same in-our-process-only filter, so legitimate
  cross-process tgkill keeps working.
- New tid_is_qemu_internal() helper based on the CPU list and
  /proc/self/task/<tid> presence.
---
 linux-user/syscall.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 44f2cd851f..c7dea1086c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9161,6 +9161,27 @@ static bool is_guest_tid(pid_t tid)
     return false;
 }
 
+/*
+ * Return true iff @tid identifies a thread inside our own host process
+ * that is not one of the guest threads -- i.e. a QEMU-internal helper
+ * thread (RCU, TCG worker, ...).  Cross-process tids and unknown tids
+ * are not classified here and the caller should pass the syscall
+ * through to the kernel unchanged.
+ */
+static bool tid_is_qemu_internal(pid_t tid)
+{
+    char path[64];
+
+    WITH_RCU_READ_LOCK_GUARD() {
+        if (is_guest_tid(tid)) {
+            return false;
+        }
+    }
+
+    snprintf(path, sizeof(path), "/proc/self/task/%d", (int)tid);
+    return access(path, F_OK) == 0;
+}
+
 #ifdef TARGET_NR_getdents
 static int do_getdents(abi_long dirfd, abi_long arg2, abi_long count)
 {
@@ -13511,11 +13532,41 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
 
     case TARGET_NR_tkill:
-        return get_errno(safe_tkill((int)arg1, target_to_host_signal(arg2)));
+    {
+        pid_t tid = (pid_t)arg1;
+        if ((abi_long)tid != arg1) {
+            return -TARGET_ESRCH;
+        }
+        /*
+         * Reject signals that target one of our own QEMU-internal
+         * helper threads (RCU, TCG worker, ...) which share our
+         * host PID but have no guest CPUState.  Cross-process tids
+         * are passed through unchanged.
+         */
+        if (tid_is_qemu_internal(tid)) {
+            return -TARGET_ESRCH;
+        }
+        return get_errno(safe_tkill(tid, target_to_host_signal(arg2)));
+    }
 
     case TARGET_NR_tgkill:
-        return get_errno(safe_tgkill((int)arg1, (int)arg2,
+    {
+        pid_t tgid = (pid_t)arg1;
+        pid_t tid = (pid_t)arg2;
+        if ((abi_long)tgid != arg1 || (abi_long)tid != arg2) {
+            return -TARGET_ESRCH;
+        }
+        /*
+         * Only screen targets in our own process; for cross-process
+         * tgkill we have no way to know which TIDs are guest threads
+         * in another QEMU instance, so the call is passed through.
+         */
+        if (tgid == getpid() && tid_is_qemu_internal(tid)) {
+            return -TARGET_ESRCH;
+        }
+        return get_errno(safe_tgkill(tgid, tid,
                          target_to_host_signal(arg3)));
+    }
 
 #ifdef TARGET_NR_set_robust_list
     case TARGET_NR_set_robust_list:

-- 
2.43.0


