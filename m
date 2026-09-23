Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96890C9830C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9N02-0004Gu-W9; Wed, 23 Sep 2026 09:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mwb-00066S-Ob
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:23:31 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MwZ-0007up-L9
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:23:29 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-33bf5a1c4d9so904061eec.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169795; x=1790774595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a+vM4VKx04YtiIcob+lp3bwuPAlEC1anahMCoo6i89k=;
 b=hUVd2xzydDzZHMiF2wGcOHjZynU5VMul64i/lszEqQDBc6dOD/vXHpibCbHVpSzNvi
 xe2cG2U3lbRATZvJbRgShNZinAwYK/Dunuf3fIrRbx7lC4qpxZi9XmwCRQyjmXa6Ze7s
 1na1bxjhmlpWiTXdIAVd+15SFJhbNjG11Ds6Xot93C+R4HeSj5NvCDIfZRgk9odV74qI
 LfZ7DUTzySGgp+NAoGZ3rLeDojjNBYlNxRcRGgsPqVX/jZHAyuh2X6Rpu7aj9EMKZONd
 m1dBWK/WNmAbXtt54Jp1BO2a6pc2puaxwh9w3MZ2S89KeQpYgIAQBNTZwtHcGlN/9MRr
 14gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169795; x=1790774595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a+vM4VKx04YtiIcob+lp3bwuPAlEC1anahMCoo6i89k=;
 b=QIS6dDjwP0b3qFYJ8VGdxP9NG1ZtlEg6ePHq7F8qF4E51g6Vyz6nH3qvnyCsW7eyj0
 +w67SVYYFVV33qSXW8QLpwMprzuZbHTSozKz9xhIZQ1ykk+eUM5cASku2AKWkTy4gH+9
 WuVb5VxMTqeIORI58TODZKl1RA/vk7NGonit58WTHV5sJW8fLbJA87NO849UVAGk4ex4
 iIYbdmWl8aCPBb4PGybnNpsBJDcOkKWLB6uLnjAOE42FBpZMLmGwrjVgZ5B3KWZHE++Y
 EX89eGPe8qglLuva9lqzFi+H6OWJQ2EjUpbTNLYeQItDkzTfGrGT2b8CCVJxYAzeNahX
 Q0Gw==
X-Gm-Message-State: AFuF++mIyL6p0YYQ1PFA05atpyn9WvvQTi9tfPJlkPfVILnMAL8eXIHW
 NA/DX0JyszdQ2+WRt9LKAuwWx4ShCYUgs6T0rwILSptbJdQsC1oQGgfjJT1KljhEaA4=
X-Gm-Gg: AYBFou26Z1PcLqFk4n7W7Z8H78zvjdUcLzj+QCqrLTYOWErhEISm+btAJhuz5nLPPg1
 Rls9QRdV+3j0Jr8+otDB+9hDgl5rHdcEmHikoKwZbTHvxFOrQ/ELoFbs8H9fMw+ilB6SZJeWB2T
 QvPv3oJn93YPKKigjDlhygCPTDUrJY7IoYTql7BT00ghSv7pKXGi07trqfNYj0/oztBZZTB+d31
 go9FRNhAHCcQZB05FCEumU6gpczuODyfyRDqKw8thK3k/Wf2HvQGHQEdOCeTwd99wKBInpu/kVN
 S1VUUQuCHECi1y1fvgTW+uOuKSANhMNk9K7r+1YCrtkMPBy9Q2AsBdgksH5u98d3Fh1jPOEM27G
 8aNwY5GTfvdO5OCTzcyCjVZ5YZor5M3VLBZNcxqLUlE1YTg0QJ3sRwsj2B2RxVv5V+4Uuub/ry/
 dVWmdhvQHTK6knLhGpWAE2sPkIgNzK5Z8hliIguCM0WTVXuT/EzWyPidmjvFeawYkY3VKurXFYk
 IXC85uucRsUzOICCfQyzoVf1B3m3Cav2kn5vy+qHw==
X-Received: by 2002:a05:7300:3e91:b0:327:affc:b506 with SMTP id
 5a478bee46e88-33e8c72c478mr2326450eec.15.1790169794702; 
 Wed, 23 Sep 2026 06:23:14 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:23:13 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 039/114] target/riscv: preserve signed XLEN semantics
 without target_long
Date: Wed, 23 Sep 2026 21:15:13 +0800
Message-ID: <20260923131635.1894-40-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Mask pointer-masked addresses with extract64/sextract64 at
  runtime XLEN instead of a target_long arithmetic shift.
- Pass vector vx scalars as int64_t after sextract64 from the
  helper tl slot so RV32 keeps bit 31 as the sign bit.
- Leave every target_ulong helper argument unchanged.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/internals.h            | 12 ++++++++----
 target/riscv/tcg/vector_helper.c    | 21 +++++++++++----------
 target/riscv/tcg/vector_internals.c |  2 +-
 target/riscv/tcg/vector_internals.h |  9 +++++----
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 1ee7e99e988..0844867246d 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -214,6 +214,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
 {
     RISCVPmPmm pmm = PMM_FIELD_DISABLED;
     uint32_t pmlen = 0;
+    unsigned kept;
     bool signext = false;
 
     /* do nothing for rv32 mode */
@@ -235,13 +236,16 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
 
     signext = riscv_cpu_virt_mem_enabled(env, is_virt_addr);
     pmlen = riscv_pm_get_pmlen(pmm);
-    addr = addr << pmlen;
 
-    /* sign/zero extend masked address by N-1 bit */
+    /*
+     * Drop the top pmlen bits of XLEN. Do not rely on target_ulong
+     * shift wrap; common-system target_ulong is always 64 bits.
+     */
+    kept = target_long_bits() - pmlen;
     if (signext) {
-        addr = (target_long)addr >> pmlen;
+        addr = sextract64(addr, 0, kept);
     } else {
-        addr = addr >> pmlen;
+        addr = extract64(addr, 0, kept);
     }
 
     return addr;
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 0d1e4e09646..0b78a733ce4 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -1248,7 +1248,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
         ETYPE carry = vext_elem_mask(v0, i);                             \
                                                                          \
-        *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
+        *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits()), carry);\
     }                                                                    \
     env->vstart = 0;                                                     \
     /* set tail elements to 1s */                                        \
@@ -1325,7 +1325,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
         ETYPE carry = !vm && vext_elem_mask(v0, i);             \
         vext_set_elem_mask(vd, i,                               \
-                DO_OP(s2, (ETYPE)(target_long)s1, carry));      \
+                DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits()), carry));      \
     }                                                           \
     env->vstart = 0;                                            \
     /*
@@ -1609,7 +1609,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
             continue;                                               \
         }                                                           \
         vext_set_elem_mask(vd, i,                                   \
-                DO_OP(s2, (ETYPE)(target_long)s1));                 \
+                DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits())));                 \
     }                                                               \
     env->vstart = 0;                                                \
     /*
@@ -2050,7 +2050,7 @@ GEN_VEXT_VV(vnmsub_vv_w, 4)
 GEN_VEXT_VV(vnmsub_vv_d, 8)
 
 #define OPIVX3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
-static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
+static void do_##NAME(void *vd, int64_t s1, void *vs2, int i)   \
 {                                                                   \
     TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
     TD d = *((TD *)vd + HD(i));                                     \
@@ -2246,7 +2246,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
         ETYPE d = (!vext_elem_mask(v0, i) ? s2 :                     \
-                   (ETYPE)(target_long)s1);                          \
+                   (ETYPE)sextract64(s1, 0, target_long_bits()));                          \
         *((ETYPE *)vd + H(i)) = d;                                   \
     }                                                                \
     env->vstart = 0;                                                 \
@@ -2397,12 +2397,12 @@ GEN_VEXT_VV_RM(vsaddu_vv_h, 2)
 GEN_VEXT_VV_RM(vsaddu_vv_w, 4)
 GEN_VEXT_VV_RM(vsaddu_vv_d, 8)
 
-typedef void opivx2_rm_fn(void *vd, target_long s1, void *vs2, int i,
+typedef void opivx2_rm_fn(void *vd, int64_t s1, void *vs2, int i,
                           CPURISCVState *env, uint8_t vxrm);
 
 #define OPIVX2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)          \
 static inline void                                                  \
-do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
+do_##NAME(void *vd, int64_t s1, void *vs2, int i,               \
           CPURISCVState *env, uint8_t vxrm)                         \
 {                                                                   \
     TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
@@ -2410,7 +2410,7 @@ do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
 }
 
 static inline void
-vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
+vext_vx_rm_1(void *vd, void *v0, int64_t s1, void *vs2,
              CPURISCVState *env,
              uint32_t vl, uint32_t vm, uint8_t vxrm,
              opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
@@ -2427,7 +2427,7 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
 }
 
 static inline void
-vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
+vext_vx_rm_2(void *vd, void *v0, int64_t s1, void *vs2,
              CPURISCVState *env,
              uint32_t desc,
              opivx2_rm_fn *fn, uint32_t esz)
@@ -2468,7 +2468,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
 {                                                         \
-    vext_vx_rm_2(vd, v0, s1, vs2, env, desc,              \
+    vext_vx_rm_2(vd, v0, sextract64(s1, 0, target_long_bits()), \
+                 vs2, env, desc,                          \
                  do_##NAME, ESZ);                         \
 }
 
diff --git a/target/riscv/tcg/vector_internals.c b/target/riscv/tcg/vector_internals.c
index b490b1d3989..95327052666 100644
--- a/target/riscv/tcg/vector_internals.c
+++ b/target/riscv/tcg/vector_internals.c
@@ -81,7 +81,7 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
 }
 
-void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
+void do_vext_vx(void *vd, void *v0, int64_t s1, void *vs2,
                 CPURISCVState *env, uint32_t desc,
                 opivx2_fn fn, uint32_t esz)
 {
diff --git a/target/riscv/tcg/vector_internals.h b/target/riscv/tcg/vector_internals.h
index 5681b818153..da093d561eb 100644
--- a/target/riscv/tcg/vector_internals.h
+++ b/target/riscv/tcg/vector_internals.h
@@ -201,20 +201,20 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                do_##NAME, ESZ);                           \
 }
 
-typedef void opivx2_fn(void *vd, target_long s1, void *vs2, int i);
+typedef void opivx2_fn(void *vd, int64_t s1, void *vs2, int i);
 
 /*
  * (T1)s1 gives the real operator type.
  * (TX1)(T1)s1 expands the operator type of widen or narrow operations.
  */
 #define OPIVX2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
-static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
+static void do_##NAME(void *vd, int64_t s1, void *vs2, int i)       \
 {                                                                   \
     TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
     *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1);                      \
 }
 
-void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
+void do_vext_vx(void *vd, void *v0, int64_t s1, void *vs2,
                 CPURISCVState *env, uint32_t desc,
                 opivx2_fn fn, uint32_t esz);
 
@@ -224,7 +224,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
 {                                                         \
-    do_vext_vx(vd, v0, s1, vs2, env, desc,                \
+    do_vext_vx(vd, v0, sextract64(s1, 0, target_long_bits()), \
+               vs2, env, desc,                            \
                do_##NAME, ESZ);                           \
 }
 
-- 
2.52.0.windows.1


