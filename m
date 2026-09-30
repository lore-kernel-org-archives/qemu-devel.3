Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74803CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvqw-0008KX-QR; Wed, 30 Sep 2026 11:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBvpw-0008Gl-U9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:03:16 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBvpu-000846-Sc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:03:12 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so30637635e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790780583; x=1791385383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zhnMuDo26kDFIRhZbp8lAtImg5hoT6BkyYcqBDw/CGY=;
 b=UkWyCaV/Bah7rPQnd7+wxUzrR9jVu0sTsGRlXh/fioJl9RIi9Cg0RM2stYqCmK7G64
 1qoGrOxm2UvrRaNyivsXMM4nYzAb2x+aGVCSC3F+oJyzcvvWgPzwGM9Evd9tD1YCKBC9
 B8j+5ww5kHIUUV/E9x6HrEuGMLTO5dulZtDZ8xDn+KbR7zGXKN7IIRxDcHvqOYIXp7ZC
 cZlPcODFVtPATplq8sjxlWLp2PGTu7lwntgtHF8nq1rVCTrZua/itpeRJuxY5JCKUfzt
 nHhXNTJDc+cQ40IfyGsPv2UIEouvjlxkHEOcnpV9G9xNgL7SpHZ3opN1CugP6EnH0GYQ
 tUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790780583; x=1791385383;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zhnMuDo26kDFIRhZbp8lAtImg5hoT6BkyYcqBDw/CGY=;
 b=mvltKYJcIFBz0iAx8UBkJYtLE5xveeomCKav6BcUkTZcLwuuxEI0qZUFOCmLYuPIz9
 vASSUXV+KfEOUbYgM1/v0HXM75TimQxH8eZErU9HyN2bo6BgUEJdkLw+3ggF8RMWjFH+
 YuxZfW2jcdwUqoKm1WwZoiOK4SL6wdD6OT2E1BzxPEwljWHAlkF0cc5lE5n8hPI5ZdXv
 2RuoUcCHHcQTPuepTfB2auIZ2ndbaOhvmsi8L0vUOiZG4AIRyBrF7IO6xIv6eYEUaS9J
 IVSg8GeBIfv1IY2NoTUgON8EV9+l8YYrnlL3CXc3DyWz1H6je0I5CgJCB3wW6zGO0PcD
 OSPA==
X-Gm-Message-State: AFuF++nBZEv+uNbvKsqu9UwRscHW1O95sOd2OD5FbyRoee+VrRS7DnSZ
 Jpk5sZ2VZzmKNLrrbzMYrddlk6xNMItmOtfNuE1LW9sqAaOnFrxIQxcoMCb1m65I5og=
X-Gm-Gg: AYBFou3KHQiid4OIT343ENOoa4zdHGzgb6Ma8mspzv6IV4duTNAnI+pNywTAl3x8m49
 XGQRyhWJTw0mHQ5Z84w2snp2xipwtSk4t1Vm7JMQo5HQQuhsU4mY6VVJkr4Wz/eQcqOX84SuL9k
 4j02w5IJzKCRSTYv+aRuXNfagL17I+2AdaRllLVnxd9FhNJM7pOViXyl5P5llSKiKTM6Z6IGDwE
 cShdAnizV34j7UHsYPRYeHdsI3tz/w0Rf9KhB+L4bQ+TfFHHqyWHI+pFBROOVmmUyC3JNIP2Qir
 D/5Ur0oEp5Yiu4wEKVnQswBqvzGkjpeZfXaNA/FujAp4QIELuBdFuKPuJzYqloIQOu6BjDmksZa
 qZtztg10jUd0Yt+MyLsXTkiKpCEt14Wn/EgDUGFRchxPCLTS4M+wjku4SYSIvwKZKtWVvIl47Zz
 +rZyibHW4NgRCFvxSlBu6ODt/yRHqBtrx85gSaRFH+JKxak9aa+KmsddQQTQXu33O5mst1UA==
X-Received: by 2002:a05:600c:4512:b0:4a0:136d:f721 with SMTP id
 5b1f17b1804b1-4a01b00c143mr30175965e9.17.1790780582112; 
 Wed, 30 Sep 2026 08:03:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01e65a4c9sm5328305e9.9.2026.09.30.08.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:03:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E8FB5F8D0;
 Wed, 30 Sep 2026 16:03:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v2] target/arm: fix user-mode emulation of ID_AA64MMFR0_EL1
Date: Wed, 30 Sep 2026 16:02:57 +0100
Message-ID: <20260930150257.408020-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
the behaviour of the test differs when run on real HW:

  id_aa64mmfr0_el1    : 0x00000111ff000000
    !!extra bits!!    : 0x0000011100000000

compared to under emulation (neoverse-n1):

  id_aa64mmfr0_el1    : 0x00000000ff000000

Update the test with a new helper to explicitly test for fixed bits
and update v8_user_idregs to match real systems.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4566
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add comment
  - make it clear what real HW is currently reporting
---
 target/arm/helper.c         | 12 ++++++++++--
 tests/tcg/aarch64/sysregs.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c3f607e6d6b..d8b34c53fab 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6902,8 +6902,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64FPFR0_F8CVT_MASK },
             { .name = "ID_AA64MMFR0_EL1",
               .exported_bits = R_ID_AA64MMFR0_ECV_MASK,
-              .fixed_bits = (0xfu << R_ID_AA64MMFR0_TGRAN64_SHIFT) |
-                            (0xfu << R_ID_AA64MMFR0_TGRAN4_SHIFT) },
+              /*
+               * Linux does not expose the  TGRAN* fields to userspace and so they
+               * must read as the "this is not implemented" value for those fields
+               * (which is 0, 0b0001 or 0b1111 depending on the field)
+               */
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


