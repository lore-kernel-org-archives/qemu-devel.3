Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64833CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtC-0003lJ-EZ; Thu, 15 Oct 2026 14:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPt3-0003k7-I3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPt1-0000zd-K5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so67328f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087741; x=1792692541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UMRTkQMSmypDqZd5Wb/cwRn+ckHEInKuZWNWzxQDprI=;
 b=xUpHBhLIb70Ejh+ZqYDTicTwzp8tGG6IQu6iS+L5rx+9FRZ8Bl6WvLhYaAG3J4UxSf
 2qbADEk80lb3+eVceOJiXzRyRSKJ+mmo6ZHPcrkkppFXm+M1pSwTmzH2Zeo37ApTsoGL
 7B93/uI0E1xzSy84x1O/RrXhYv2oVpBCExyKPjq+OdVIjFPLdf1PuCaE26/JNx+AmKUP
 iK+ekw6Ot6sr1YHTAjVaatdrrAGgzHOj+LWMgZSjAVj5nY6pWEpOoM1us3EaONUOMP33
 IPE2C7iR6qmeoUAuEcYgqlltf/g4OcdNDSRUHrIklEG+BjkaZ8378ktxH4FDcuNx8p+c
 xYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087741; x=1792692541;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UMRTkQMSmypDqZd5Wb/cwRn+ckHEInKuZWNWzxQDprI=;
 b=ZYE4pRL0Rdu+uOA2qy02Co1UB9KLvinheEoD6fT/0yMP8MEGdEEiB7Tis9Iv8ikAo4
 E+hsMB3gVikeg4zdqg+yIYXUm7CY376kyUB7Sa51vH6dSiodEPBkLQXqWIN+R6g4n+f8
 E9uCtLillIxtVXiKG27B4l8kq+/QqUo2ZWup/m99CLryeYyYAXRW0Hqr6+LkBuis0rbv
 oAaH00d/vVSLIb3+an/S/m142EBw35Zzwe3H3sdhRGqPKuV1tGdmAbt79+RELBDOupyP
 t9wy9U29W9kXus93JZOTPC79PVg0/I4DCuWxjKZL+ZmQf5HyRc0QDUnRVl1pwU0Z4JIC
 yWAA==
X-Gm-Message-State: AFq9FYKXa8k1vHx67dDVdIgrTiIOasWkLDh1ERykFOVjYaZGwEwPIMT4
 aHFc2oQTRxCPmireseuryaEG25dI9A4FTbhlYLHmekinrduUTavo1VfAPsZROyoz9NNtcJ3g2nu
 97o9apQA=
X-Gm-Gg: AYBFou1GOCpzRGVWXAFqfOeXkBfQSCNXnGyFVSVJDvfwwgjl7WvtLjLMy0aRdIntoKk
 EFMvJO1Ssa77177AV7V2Ut557DsKSRqY5OJYVs7f4I2v7mR3eV3YkzIuOQ02LAdmuKEershUHVY
 gBVgRlqlPx4sLGiWfW7x8emcrbd7ld3l2nEMWXXTA2cIWF1/PcnxKu0X+d0tosdgR9PJBNkhPEA
 4Xt5cunaQ8H0VEE7wjvTkBQwOrwGgIu6XLDYrNMtoPsg05rQCGssRS/ot4J6UAkx8G6Bhlocrwy
 t22vYT+Z/qgIU8s5rcwAQjz7rRMJm5grANl7FMNTnyp6P25UVDdgv5a7D6bWA6RTPtQqW72G529
 yJhVQIsHSv0wFdwCsIo5RaQChxQZjrQqTqbVluw/m+QXw5bu4J7pDbnhSQ3eZjncehrOoS0KWnk
 Udpa5q65VxOyjYb4lLiHT5u1YshT5fpWpDvf9b8ekaz5GM3uTMbxb1DIrtzY7dWYlerA+EKTOgN
 Yl8+fyp8qryXcM/VK//m8bFBdr3k7S2cfdwJazFku/JvFrVNu4jsD5h6zOto32MB+1b6iDHTm4I
 THfZG0G72utqZA==
X-Received: by 2002:a05:6000:29c3:b0:48c:58d5:30fb with SMTP id
 ffacd0b85a97d-48dba7876bemr26151549f8f.5.1792087741086; 
 Thu, 15 Oct 2026 11:09:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] target/arm: fix user-mode emulation of ID_AA64MMFR0_EL1
Date: Thu, 15 Oct 2026 19:08:43 +0100
Message-ID: <20261015180858.1863407-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

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
Message-id: 20260930150257.408020-1-alex.bennee@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: wrapped a few long lines]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c         | 12 ++++++++++--
 tests/tcg/aarch64/sysregs.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff0b766b73d..ff8a8fcca41 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7023,8 +7023,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64FPFR0_F8CVT_MASK },
             { .name = "ID_AA64MMFR0_EL1",
               .exported_bits = R_ID_AA64MMFR0_ECV_MASK,
-              .fixed_bits = (0xfu << R_ID_AA64MMFR0_TGRAN64_SHIFT) |
-                            (0xfu << R_ID_AA64MMFR0_TGRAN4_SHIFT) },
+              /*
+               * Linux does not expose the  TGRAN* fields to userspace and so
+               * they must read as the "this is not implemented" value for those
+               * fields (which is 0, 0b0001 or 0b1111 depending on the field)
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
index 301e61d0dd4..8f7af6be1d9 100644
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
+     * TGran4 & TGran64 are pegged to -1 (0xf).  Stage 2 translation
+     * granule support (TGran4_2, TGran64_2, TGran16_2) are pegged to
+     * safe value 1 as exposed by Linux kernel since b130a8f70cbbf9
+     * (KVM: arm64: Check advertised Stage-2 page size capability).
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
2.43.0


