Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14906CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 23:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1C3g-0006t5-NC; Tue, 23 Sep 2025 19:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1C3f-0006sf-5k
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 19:04:27 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1C3Z-0004R1-Vz
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 19:04:26 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-77d94c6562fso6193019b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758668657; x=1759273457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h7jBToDckL+9WdyOpUrdDydxCn382Hk4iBNUg68buw0=;
 b=X+DJb1NEH4YreAED7QZCPtJn/bAGNmhZROrIcZ7aVw/oWLV/WWdVh12IUJPF6/mMSf
 PldgC6VLtKiqZjZz9LAC0AInlHvj3mWsIIPsl9Zt52M0Ap3pnwrGNBhmZ6KtvnHKEhNM
 2n9oXix6akpFkwfmMxDwyphKv7ONk9aRlzyGkHhqJHou/eQA/XETlefPrUKhkD3lwHc2
 KPT2EVUyR5rjiVnA5iPlYC+X0LCP/hMbleG/KAGhISsuBhozMQnCHtqUDh51jxG4C1yF
 8NeiJBxStfTyeaY9YcWy/OfpBmWdkcMzipw7Eof9uZh7CmOYQrvLxd2w14vNXu96IaPu
 c+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758668657; x=1759273457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h7jBToDckL+9WdyOpUrdDydxCn382Hk4iBNUg68buw0=;
 b=a0eqQEe2Wyuh0hdVMWrYEUBAdjchFsypfEL4Xi7oq1N7pDXOgm3I6UsTSfO7GxyeCN
 GQao7IlRTCzf6D9Xy+RMLmyd9wjR8O4W2ZMjL+DbOcL3mEviLrDrYx3DFNIMnnEn/gx4
 D+3R00g7aMIQfiTaNYML1xmLy3ukF3PUXRdHlWzM3KDdKdH0Q+6s5AmxfWqGOmGoSbKq
 t3ODFThMl+BfgLEdYW+H0wt8HYlwfFuQIHUPyo67hGHWjJlOvpBL+zZSaoljBvSd/wj0
 mfzgYuKOwKf36OYMvv4XSwg7/b750DBOIC0VmiuqUrB/UgmND9chEnmmzBtYIdDwc7Ob
 KN3w==
X-Gm-Message-State: AOJu0YxAm3As1VlkKy4XnAJCWsQ8FgK6WnkMZ335EQn4XsYK+6ryUKyA
 7Cc6k/sf8PaY8nSqb6JD5uDQMQGOt+s+F8S3vE/G0DWOD9tCvKns9oH7vwgOGkB+ZStSC5+x339
 vKHpR
X-Gm-Gg: ASbGncssF8dCovbbBkA4pFNk+XVc5glGgIPuDqcH8tp/5hsxa9XBGv7qGVAsLl7aPpj
 evlegrGuWz1gtsLxDx1PSACQSCTpYmlwbc9mN9KZHx1OhVagPCITtijBuu+HXHDSFFKIAcFdVM+
 aBf9NDLMLTfIHLhTdzRmTfxHMOVeGxHrwxa/XEPVgf9iogzlMBfl7fKcruP6LY2yE3+pedsPHnp
 /lCn1jzUiAHSaMc01GXZbqPd66nVjey22Kst/s0RFjTagtj4PqBnc+MapPk8jWek/6YkmSN8grV
 xsdbCBKMyohOSDh4RgvS6SLN4LovVEg+NNhFjcBsqjxr9BWaa6uCCIEsOAf8wUTwq04NU06ljDo
 ALhWmsaSN3xnPbDuYRhfEst//id6Q
X-Google-Smtp-Source: AGHT+IEYyt6JwWFXglePl3CgdewMub9FyehNXYnz+1CLME8YsVNXpHdn2zuXJG1NrzAjlzcm4Xrd6A==
X-Received: by 2002:a05:6a00:139e:b0:772:4b05:7899 with SMTP id
 d2e1a72fcca58-77f538479dfmr4313594b3a.7.1758668656875; 
 Tue, 23 Sep 2025 16:04:16 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f297235fcsm8901897b3a.16.2025.09.23.16.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 16:04:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: kasperl@rivosinc.com, lazyparser@gmail.com, liwei1518@gmail.com,
 =?UTF-8?q?=E6=9D=8E=E5=A8=81=E5=A8=81?= <liweiwei@kubuds.cn>
Subject: [PATCH] accel/tcg: Properly unlink a TB linked to itself
Date: Tue, 23 Sep 2025 16:04:15 -0700
Message-ID: <20250923230415.3688766-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When we remove dest from orig's links, we lose the link
that we rely on later to reset links.  This can lead to
failure to release from spinlock with self-modifying code.

Reported-by: 李威威 <liweiwei@kubuds.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c              |  8 +++++
 tests/tcg/riscv64/tb-link.c       | 60 +++++++++++++++++++++++++++++++
 tests/tcg/riscv64/Makefile.target |  1 +
 3 files changed, 69 insertions(+)
 create mode 100644 tests/tcg/riscv64/tb-link.c

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 0048316f99..e6d45c9c12 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -836,6 +836,14 @@ static inline void tb_remove_from_jmp_list(TranslationBlock *orig, int n_orig)
      * We first acquired the lock, and since the destination pointer matches,
      * we know for sure that @orig is in the jmp list.
      */
+    if (dest == orig) {
+        /*
+         * In the case of a TB that links to itself, removing the entry
+         * from the list means that it won't be present later during
+         * tb_jmp_unlink -- unlink now.
+         */
+        tb_reset_jump(orig, n_orig);
+    }
     pprev = &dest->jmp_list_head;
     TB_FOR_EACH_JMP(dest, tb, n) {
         if (tb == orig && n == n_orig) {
diff --git a/tests/tcg/riscv64/tb-link.c b/tests/tcg/riscv64/tb-link.c
new file mode 100644
index 0000000000..b6fcca8668
--- /dev/null
+++ b/tests/tcg/riscv64/tb-link.c
@@ -0,0 +1,60 @@
+#include <assert.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <unistd.h>
+
+
+int main()
+{
+    /*
+     * ## 1. RISC-V machine code.
+     * Assembly:
+     *   L: j L          ; Jump to self (spin).
+     *   li a0, 42       ; Place 42 into the return value register a0.
+     *   ret             ; Return to caller.
+     */
+    static const uint32_t machine_code[] = {
+        0x0000006f, /* jal zero, #0 */
+        0x02a00513, /* addi a0, zero, 42 */
+        0x00008067  /* jalr zero, ra, 0 */
+    };
+    size_t code_size = sizeof(machine_code);
+    int tmp;
+    pthread_t thread_id;
+    void *thread_return_value;
+    uint32_t *buffer;
+
+    /* ## 2. Allocate executable memory. */
+    buffer = mmap(
+        NULL,
+        code_size,
+        PROT_READ | PROT_WRITE | PROT_EXEC,
+        MAP_PRIVATE | MAP_ANONYMOUS,
+        -1, 0
+    );
+    assert(buffer != MAP_FAILED);
+
+    /* ## 3. Copy machine code into buffer. */
+    memcpy(buffer, machine_code, code_size);
+
+    /* ## 4. Execute the code in a separate thread. */
+    tmp = pthread_create(&thread_id, NULL, (void *(*)(void *))buffer, NULL);
+    assert(tmp == 0);
+
+    /*
+     * Wait a second and then try to patch the generated code to get the
+     * runner thread to get unstuck by patching the spin jump.
+     */
+    sleep(1);
+    buffer[0] = 0x00000013;  /* nop */
+    __builtin___clear_cache((char *)buffer, (char *)(buffer + 1));
+
+    tmp = pthread_join(thread_id, &thread_return_value);
+    assert(tmp == 0);
+
+    tmp = (intptr_t)thread_return_value;
+    assert(tmp == 42);
+    return 0;
+}
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 4da5b9a3b3..ba684616fd 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -4,6 +4,7 @@
 VPATH += $(SRC_PATH)/tests/tcg/riscv64
 TESTS += test-div
 TESTS += noexec
+TESTS += tb-link
 
 # Disable compressed instructions for test-noc
 TESTS += test-noc
-- 
2.43.0


