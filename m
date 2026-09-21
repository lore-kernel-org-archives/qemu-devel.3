Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FC4C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f2T-0003vA-Et; Mon, 21 Sep 2026 10:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8f1I-00029d-2i
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:29:36 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8f1G-0000Uv-11
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:29:23 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso26940945e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790000959; x=1790605759; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9yArQ7td5eLaBrNr2OJB2aovtHijUBu65cwOyBo22qY=;
 b=AH8tntoKRq7vSvYMcD+m6eOKWQUzFWT8gOHoZQWisJULzHYuL4y+qVchaoFVl+rOuj
 6GhSXRpJ0EU+g9idaOxb1dVXyhCkQoB5eyBoTGQli/ZD8G7rDkmX/tk8xZ0LJiM27SIh
 u0IVEOB2OlkfgnObORjUvXsb8vUX2Xwhk8mQlpdIZxZOW3HGNfIx0AF3UIRcswaNEBvv
 YnIti5j0shn62tSF+BbI+ZGFLh3Ocz0p/N88NP/Dp4jhMKAABCEx2siA9N0MiSIVgjYL
 DuUAjJUoIElf8anwfrNgeILyS7+a3Kbfnj05lx6SXaRdjh1vmQZYHJpMiOxRbwhRwj5v
 qeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790000959; x=1790605759;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9yArQ7td5eLaBrNr2OJB2aovtHijUBu65cwOyBo22qY=;
 b=FGXsI6FZID0jqe+piiS4sXqpaock0vUhnJmWTb5/ZuWt9b2oNxfK4jg1vf80UZf2n3
 e390Es152nF6DJoLqV3+latf0uFGzui5vb4ccUcmfHW0EkPVHaO8N0QIvZC6y6AyLMQQ
 IGYG4YG1eNMp7jCPBbqmRO/7oTl1pjCfNQAt8fvI7M5z+cjuuNAfqZQcNYXeVAgA5hv7
 8HBXJG8GdJeeGm+rzMo1TFy+ZsmhBfPHEiSzGH2GFnJ3IIUJwcPBZAzfon0+sVSOTdZp
 2O+l062HOWWOkDEYYNCsV0Uu/8mDEMWD6qbViZ9gwSnM/yjUgOu08/0L8w0oSZ+uGN4J
 oAUA==
X-Gm-Message-State: AFuF++nJin8zNTbWl7Fa2Fng7fTvhLKrF3mDyczGad88GXNSNkHh4DMS
 1RtMQQNCpgXQ44RJeaLbJTzyRd/nFJ8ndXzR3MxsBiKKqoW7Xx2JPiun39f4ulIuyTo=
X-Gm-Gg: AYBFou1k7lkdzP4h4YLNFCg2HO+c9BXHXbydUznO2o0ODI+3nmbWmWuoTuwTsaBdBdx
 YJgYGHCwhJS2HkXwOaPUzUCs4IXgO/G9pkVqAmoZz1O8xZxyY6i5OVWv/MlDp5NDJNQtpxVNIb9
 ljTC8/A5t5C8N3ZYasqe0pRzhSLCX/LD70Dl8ScRIWImdAjthUzCQakzlhUtc65NAQc58UszW2X
 bvr69D8JNLJMI2xIKLPSpBdPXd5+WYOqVFHhzzTbpXL5JODXJC9L5PjQ61yB7DuFRPtHyI5AqWq
 KHZ27aRCTaZrw2Qbv4E0JkeJ3aEQMr+9GdGQ/xpt5RKbl4ryVNo/k93mGGsOsrRTf4/vPQwF/tN
 xLTzE2viGWVrVI2DeEcT0hZJPQGiEa+M867tpQ8fJFGrY/Pqo6jkb9PXPjXAXV7a/G5K9PATArw
 sQMRaxIG1I9qjp7DjL9Q5gPORY/HEstwnCt4BfL8KoMStnakk9SPd3/fv7T75IqYVJrMj8CJa3/
 SC874FHdjI=
X-Received: by 2002:a05:600c:8b61:b0:49d:e0c:e55e with SMTP id
 5b1f17b1804b1-49fc574a635mr164858995e9.23.1790000959380; 
 Mon, 21 Sep 2026 07:29:19 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd07bba7sm226752565e9.9.2026.09.21.07.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 07:29:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3065F5F871;
 Mon, 21 Sep 2026 15:29:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] target/arm: fix user-mode emulation of ID_AA64MMFR0_EL1
Date: Mon, 21 Sep 2026 15:29:10 +0100
Message-ID: <20260921142910.1462880-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

Since kernel commit b130a8f70cbbf9 (KVM: arm64: Check advertised
Stage-2 page size capability) the relevant Stage 2 have been pegged at
1 f(4KB granule not supported at stage 2) by the kernel. As a result
the behaviour of the test differs when run on real HW compared to
under emulation:

  id_aa64mmfr0_el1    : 0x00000111ff000000
    !!extra bits!!    : 0x0000011100000000

Update the test with a new helper to explicitly test for fixed bits
and update v8_user_idregs to match real systems.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4566
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c         |  7 +++++--
 tests/tcg/aarch64/sysregs.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c3f607e6d6b..7e65f072a4a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6902,8 +6902,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64FPFR0_F8CVT_MASK },
             { .name = "ID_AA64MMFR0_EL1",
               .exported_bits = R_ID_AA64MMFR0_ECV_MASK,
-              .fixed_bits = (0xfu << R_ID_AA64MMFR0_TGRAN64_SHIFT) |
-                            (0xfu << R_ID_AA64MMFR0_TGRAN4_SHIFT) },
+              .fixed_bits = (0xfULL << R_ID_AA64MMFR0_TGRAN64_SHIFT) |
+                            (0xfULL << R_ID_AA64MMFR0_TGRAN4_SHIFT) |
+                            (0x1ULL << R_ID_AA64MMFR0_TGRAN4_2_SHIFT) |
+                            (0x1ULL << R_ID_AA64MMFR0_TGRAN64_2_SHIFT) |
+                            (0x1ULL << R_ID_AA64MMFR0_TGRAN16_2_SHIFT) },
             { .name = "ID_AA64MMFR1_EL1",
               .exported_bits = R_ID_AA64MMFR1_AFP_MASK },
             { .name = "ID_AA64MMFR2_EL1",
diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
index 301e61d0dd4..8f7c5303f77 100644
--- a/tests/tcg/aarch64/sysregs.c
+++ b/tests/tcg/aarch64/sysregs.c
@@ -54,6 +54,23 @@ int failed_bit_count;
             }                                                   \
 })
 
+/* As above but also check that required fixed bits have expected values */
+#define get_cpu_reg_check_fixed(id, allowed_mask, fixed_mask, expected_val) ({ \
+            unsigned long __cval = get_cpu_reg(id);                     \
+            unsigned long __extra = __cval & ~(allowed_mask);           \
+            if (__extra) {                                              \
+                printf("%-20s: 0x%016lx\n", "  !!extra bits!!", __extra);   \
+                failed_bit_count++;                                     \
+            }                                                           \
+            if ((__cval & (fixed_mask)) != (expected_val)) {            \
+                printf("%-20s: 0x%016llx (expected fixed 0x%016llx)\n",  \
+                       "  !!fixed mismatch!!",                          \
+                       (unsigned long long)(__cval & (fixed_mask)),     \
+                       (unsigned long long)(expected_val));             \
+                failed_bit_count++;                                     \
+            }                                                           \
+})
+
 /* As above but check RAZ */
 #define get_cpu_reg_check_zero(id) ({                           \
             unsigned long __val = 0xdeadbeef;                   \
@@ -127,8 +144,16 @@ int main(void)
     get_cpu_reg_check_mask(id_aa64isar0_el1, _m(f0ff,ffff,f0ff,fff0));
     get_cpu_reg_check_mask(id_aa64isar1_el1, _m(00ff,f0ff,ffff,ffff));
     get_cpu_reg_check_mask(SYS_ID_AA64ISAR2_EL1, _m(00ff,0000,00ff,ffff));
-    /* TGran4 & TGran64 as pegged to -1 */
-    get_cpu_reg_check_mask(id_aa64mmfr0_el1, _m(f000,0000,ff00,0000));
+    /*
+     * TGran4 & TGran64 are pegged to -1 (0xf).
+     * Stage 2 translation granule support (TGran4_2, TGran64_2, TGran16_2)
+     * are pegged to safe value 1 as exposed by Linux kernel since
+     * b130a8f70cbbf9 (KVM: arm64: Check advertised Stage-2 page size capability).
+     */
+    get_cpu_reg_check_fixed(id_aa64mmfr0_el1,
+                            _m(f000, 0111, ff00, 0000),
+                            _m(0000, 0111, ff00, 0000),
+                            _m(0000, 0111, ff00, 0000));
     get_cpu_reg_check_mask(id_aa64mmfr1_el1, _m(0000,f000,0000,0000));
     get_cpu_reg_check_mask(SYS_ID_AA64MMFR2_EL1, _m(0000,000f,0000,0000));
     /* EL1/EL0 reported as AA64 only */
@@ -179,7 +204,7 @@ int main(void)
     }
 
     if (failed_bit_count > 0) {
-        printf("Extra information leaked to user-space!\n");
+        printf("Bit check failure or extra info leaked to user-space!\n");
         return 1;
     }
 
-- 
2.47.3


