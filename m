Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26448CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRDU-0004TV-I9; Mon, 11 May 2026 10:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCJ-0003xS-VU
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:35 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCD-000652-Qo
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:27 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-899d6b7b073so41530076d6.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508078; x=1779112878; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f97sAgovvneMg91EA00GUYMTrKlW3fVlRmKKW6/GCj4=;
 b=ETRMC4sfA1Z82+wV3pWhD2VKWZHslY378RZXbfJH9iDScQXvmR5OOWpsZk3ALA+WAy
 kE00+c6kv7teSVQ3mLHVan8rKNnsIer9biEz5e1OGP1oIZtQBxIJkCKkkYNyqm+abejg
 omXSrEiE31AL0tX0NtDLScjZ+9VqF07kPGhBsENJHm1hS3yrbxgv+FYKtvDOeLD4ubby
 qgqujdJZ2xaAOtG+281j59sMVSdkPpc0FVC4Dm1CQ79lEkzn9Oi9tbvqcq0aMFyGu702
 aKZjL+3pJ94WOooXHAz7lGP+iT+GlhmjAB6VU53K426NLNhtS2vwF6Ao/H4QifsDQ0c3
 uCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508078; x=1779112878;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f97sAgovvneMg91EA00GUYMTrKlW3fVlRmKKW6/GCj4=;
 b=fgu6KUOehJbfJobHyBzdz+n1ZKHMG/KJCisJdliMVLYGYuzcvLT1z9gwkhL7AENY2x
 7ItMgdZVkTLJNamK0Xz40Ha9azN8IjPaw8L6uY/QnRx9WjDNkcUbAYKuiqkXd+sgQjcK
 RHML3QG+lMFTO1Z1KSa36aSG0XlHKy4Aec15QV12v8raZlXSmO10o3lyC8jIRQZ2lwF/
 aHSXKw/xzcav9uT1WhoxiA7pZe8ZvPSMJIyEsTU02mkWxpDZX/OKR7Ow7/4bGvqblKKg
 hFVJ5vUYsBIgUeVgKtOcr0gnqlB2gHgndNhEZok3yqwWHHO/Y7OcJ2jIx44tSkcOrPjh
 ZZPA==
X-Gm-Message-State: AOJu0YyWI+HAZGzt9eMsL3Ep7BHZysG+LSeFI59taDSTYyZfu/wm2nk3
 MAA6U1mSyaZgLAhHOoQST/NiWvTN1+ADl95icxsIYChsJCDa1mBj1c2D
X-Gm-Gg: Acq92OGy46ivD/W/MNpow3ZYVgW2FHfADmvH23DazcxPjPlmFwRgMOtNtSKcsbveofE
 0O+1IYGpAGMZgH8CY6R7f9gCAoYz3TkIQ4l7KV5EtV75dxpg1hYw0/ms0d7lCfRTsUDq9+nq9pW
 OUyOQX5jFV8vskZ9MKJ8Cip5+rMHUFmNlxaxXWCmp1XpGLdAApyrCrUynOOAvy1a9pfTfK/9YOl
 wTmre2+tr3meoZm/wWi7Wy8g88CXAYGrKsI6ghuiVXRSCtr/suz6WM0/g+umEPzD8TDhO4k5f82
 pN8sRAti7UcJ7JUUJXcYhpDQXGrrmbxH2wpNRwFLpg5SS2uH3D5+dU+B9oxa3jCGZSU0TI5TAE1
 9JJptzD45IR8ttoaJq/BUFnnklaG78uNCnNvD3565hdysfoW+wZEzmzlM2rG/nZo+IEI9QNnJ58
 fs9RlIfTjxmVxF/1L5ssyE2CjoDFuf85ZTMBKYsGoG
X-Received: by 2002:a05:6214:5b85:b0:8a1:34df:bbe3 with SMTP id
 6a1803df08f44-8bc443d5a41mr375890326d6.28.1778508077796; 
 Mon, 11 May 2026 07:01:17 -0700 (PDT)
Received: from [192.168.1.160] ([2600:4041:54f3:a400:c013:3550:ed5f:a59a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm94773756d6.31.2026.05.11.07.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:01:17 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 11 May 2026 10:01:06 -0400
Subject: [PATCH v6 08/15] target/arm: add canonical MTE check logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-feat-mte4-v6-8-8557cc1313b9@gmail.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778508062; l=3812;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=2L9HEB41G779r2QZ9fho3irTF36kpNHlmsTc5qrI5Vk=;
 b=Vpcq9R//+VLC04ga57rQKsKOEbpVXVwtxyRN6O0xolCeiTKkm2XcrGM+BEeTQNavAcKaL+N7E
 SCin8q8DFwLAnsmPOfzQdEzT1L5gTRgC8+Pe3YLU/s0rf7Z1t8znYGh
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

With MTX active, address tag bits are checked for canonicity if the
corresponding memory regions are not allocation tagged. See
AArch64_CheckTag.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  6 ++++++
 target/arm/tcg/mte_helper.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 192e6a2d47..779eafabc8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1629,6 +1629,12 @@ static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
     return deposit64(ptr, 56, 4, rtag);
 }
 
+/* Return true if mtx bits mean that the access is canonically checked.  */
+static inline bool mtx_check(uint32_t desc, int bit55)
+{
+    return (desc >> (R_MTEDESC_MTX_SHIFT + bit55)) & 1;
+}
+
 /* Return true if tbi or mtx bits mean that the access is tag checked.  */
 static inline bool tbi_or_mtx_check(uint32_t desc, int bit55)
 {
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 61cdf92c54..d35e3ef04d 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -858,6 +858,14 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
         mem1 = allocation_tag_mem(env, mmu_idx, ptr, type, sizem1 + 1,
                                   MMU_DATA_LOAD, ra);
         if (!mem1) {
+            /*
+             * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
+             * otherwise it is Untagged. See AArch64.S1DecodeMemAttrs and
+             * AArch64.S1DisabledOutput.
+             */
+            if (mtx_check(desc, bit55)) {
+                return tag_is_canonical(ptr_tag, bit55);
+            }
             return 1;
         }
         /* Perform all of the comparisons. */
@@ -873,18 +881,24 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
 
         /*
          * Perform all of the comparisons.
-         * Note the possible but unlikely case of the operation spanning
-         * two pages that do not both have tagging enabled.
+         * Note the possible but unlikely case of the operation spanning two
+         * pages that do not both have allocation tagging enabled. This can
+         * happen with or without mtx (canonical tagging) enabled.
          */
         n = c = (next_page - tag_first) / TAG_GRANULE;
         if (mem1) {
             n = checkN(mem1, ptr & TAG_GRANULE, ptr_tag, c);
+        } else if (mtx_check(desc, bit55) &&
+                   !tag_is_canonical(ptr_tag, bit55)) {
+            return 0;
         }
         if (n == c) {
-            if (!mem2) {
+            if (mem2) {
+                n += checkN(mem2, 0, ptr_tag, tag_count - c);
+            } else if (!mtx_check(desc, bit55) ||
+                       tag_is_canonical(ptr_tag, bit55)) {
                 return 1;
             }
-            n += checkN(mem2, 0, ptr_tag, tag_count - c);
         }
     }
 
@@ -999,6 +1013,14 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
     mem = allocation_tag_mem(env, mmu_idx, align_ptr, MMU_DATA_STORE,
                              dcz_bytes, MMU_DATA_LOAD, ra);
     if (!mem) {
+        /*
+         * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
+         * otherwise it is Untagged. See AArch64.S1DecodeMemAttrs and
+         * AArch64.S1DisabledOutput.
+         */
+        if (mtx_check(desc, bit55) && !tag_is_canonical(ptr_tag, bit55)) {
+            mte_check_fail(env, desc, ptr, ra);
+        }
         goto done;
     }
 

-- 
2.54.0


