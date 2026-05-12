Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8771DCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnVz-0004S6-Ha; Tue, 12 May 2026 09:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antercreeper@gmail.com>)
 id 1wMhHp-0002dL-9E
 for qemu-devel@nongnu.org; Tue, 12 May 2026 03:12:16 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antercreeper@gmail.com>)
 id 1wMhHm-0002pR-N9
 for qemu-devel@nongnu.org; Tue, 12 May 2026 03:12:12 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-836ebdeb969so2385579b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 00:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778569928; x=1779174728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xz0e648EZjPOzfU36bsIktA7MSSiUSIKUjdvRSxBW3U=;
 b=XUlJ3JxvwuRhNZbdhAZOYb7Xm8R4/AcA8mpSMwiPpg1eoLPEUZo5cskNRPQ19C0yQ/
 Sl2JKhOp0DfddziDQg45gblyf1EznIN8hYH4lnBgX9vRlfzqIPjLssZwGDuzJwsdMAgN
 HrEZFunt9cje1y7WWbrDMZjCe1/3JOGvB3qQYOARL8ATosp/elbRwip/moUDS4RjPlQp
 gWjPAsdD/+z1DYTGIHtWwOa9zdrHdJWSC8eWJGtVnaWWvY9JRvSlzVN6kh//Stfy9tsk
 6Eu1e+6PH6QJHbPQoYa4pCBv3LHsEnNkXxmPzl+z8JW4TeZLa0P6Niax3uGWE97zAKwP
 T6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778569928; x=1779174728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xz0e648EZjPOzfU36bsIktA7MSSiUSIKUjdvRSxBW3U=;
 b=cmOhgaTaVARryigWBf+4nCt4cK9bus1FY1G1zvcobGkUtfgCb5oGuthAv8j140jlb5
 sL8Dt8B+8Vkr7P9qqsyq4r3y9EmBkh9wKu+8Wt4Qik8x3VwAP8LRPmw4G+GEMU5t0QNx
 xVFmvecyX6I8MO+D+dszEiYATooETMn5UBbNkw+iqlB+eZzxC8M5ceRdHbFl5NadJzfi
 vIa3+g5HMqobX+L8Y2jZTWo/hbTMUxCqhURZcR3v2l5JqdU0E/o3vmP7VfWVfmTAksKh
 +pTOVuJwI3wli+1Tg/A5P45KBxMJoA9mUZkFOXY9NQx6SGYkOvL9EC5epWh8pcacXHas
 JeBw==
X-Gm-Message-State: AOJu0YyvMiKAHVSKjYXcwKD82fr7MLpSz4NuRjKAC1HC9bFgKo5mRbjL
 Kw4p2kecE8pd1Ze3UN6x1VW4wzXcCblyQvxYkalrB1xYfnCfrsCjI7a1qiHfBGVDWdoZ4w==
X-Gm-Gg: Acq92OFWPPGnyAH/PPGVFkd5fFreziZUloKjW5Nbgat3hwcYxLmD1qNLxnHQHRVJ5bG
 4RKN61wZXlz6N3lYPVbYRotjZ7ue/LGhLMp+MxTtF4z70vyHctjnYc1dWvuYw0oEmDqH9fKa3Z0
 nmJILTVsXVgFnwsK2BPwrtk5XgPo36756TnWjYQqBOxuoLAGA76k84fcIhUKrfQKnUmU46wajk9
 2YyD277Rkua0qc8KEHixhvwPRGtf2u4wQE/YgexZuMCG5kpiQ2vLQAfZD6A9k6yfsvE4+wYfK9t
 8eDjDnd+Wwnp46LlrTZSa1u5Y/UGjWKmSAgwoBvUl54PYrvnE7SdOn/RjXl9IDej/b47ElRGo8Z
 WS5NSlmNKlwPqesuPuoznj1wEj/QgFbp7rAcPL8syR9iu0HnScK7J1Qs8glKht5rTxJcDSSPw7M
 RdMgyrckJxuJdQd524gZHwnohLLzc019t3QunwTxQK2jglDA==
X-Received: by 2002:a05:6a00:3d09:b0:82c:212a:a9b5 with SMTP id
 d2e1a72fcca58-83a5dc5de12mr27026790b3a.36.1778569927737; 
 Tue, 12 May 2026 00:12:07 -0700 (PDT)
Received: from silicon.tail3bd2b.ts.net ([124.127.234.227])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965646254sm23331096b3a.10.2026.05.12.00.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 00:12:07 -0700 (PDT)
From: antercreeper@gmail.com
X-Google-Original-From: wangzhihao9@hotmail.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com,
 Zhihao Wang <wangzhihao9@hotmail.com>
Subject: [PATCH 1/1] accel/tcg: allow unaligned access for SPARC Solaris
 user-mode
Date: Tue, 12 May 2026 15:12:02 +0800
Message-ID: <20260512071202.61416-1-wangzhihao9@hotmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=antercreeper@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2026 09:50:49 -0400
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

From: Zhihao Wang <wangzhihao9@hotmail.com>

SPARC Solaris user-mode binaries may rely on the Solaris kernel
emulating unaligned integer loads and stores.  Add an opt-in compat
mode, controlled by the QEMU_SPARC_SOLARIS_UNALIGNED environment
variable, that skips the alignment enforcement in linux-user mode.

Signed-off-by: Zhihao Wang <wangzhihao9@hotmail.com>
---
 accel/tcg/user-exec.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d283d3cc72..d87391a7d3 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -927,14 +927,39 @@ void *page_get_target_data(vaddr address, size_t size)
 
 /* The system-mode versions of these helpers are in cputlb.c.  */
 
+#if defined(TARGET_SPARC) || defined(TARGET_SPARC64)
+static bool sparc_user_solaris_unaligned_enabled(void)
+{
+    static int enabled = -1;
+
+    if (unlikely(enabled < 0)) {
+        const char *env = getenv("QEMU_SPARC_SOLARIS_UNALIGNED");
+        enabled = env && env[0] != '\0' && env[0] != '0';
+    }
+    return enabled;
+}
+#else
+static bool sparc_user_solaris_unaligned_enabled(void)
+{
+    return false;
+}
+#endif
+
 static void *cpu_mmu_lookup(CPUState *cpu, vaddr addr,
                             MemOp mop, uintptr_t ra, MMUAccessType type)
 {
     int a_bits = memop_alignment_bits(mop);
     void *ret;
 
-    /* Enforce guest required alignment.  */
-    if (unlikely(addr & ((1 << a_bits) - 1))) {
+    /*
+     * Enforce guest-required alignment by default.  Solaris/SPARC user-mode
+     * binaries may rely on the Solaris kernel emulating unaligned integer
+     * loads/stores, so allow an opt-in linux-user compatibility mode for that
+     * case.  This file is user-mode only; system-mode keeps using cputlb.c and
+     * the target do_unaligned_access hook.
+     */
+    if (!sparc_user_solaris_unaligned_enabled() &&
+        unlikely(addr & ((1 << a_bits) - 1))) {
         cpu_loop_exit_sigbus(cpu, addr, type, ra);
     }
 
-- 
2.47.3


