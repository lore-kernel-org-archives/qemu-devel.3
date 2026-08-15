Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9197EC5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKk-0007KJ-07; Sat, 15 Aug 2026 15:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKT-0007Gs-36
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:05 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKR-0008Fq-Bd
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2d032846c95so30945415ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823162; x=1787427962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9jJ818IWZdbZ+oA7FKlW0IozvBhiq4MYdB9KFJONT5M=;
 b=Kl32tiE6ejrUzhfI2EUvwbEUvDwwQ0/3IAEK8qHo5OnEQNVbN5zJ72CwEHRmhrHG7g
 nyb3hXDSKN2xJNuCbxeMtkhQXoc3wSIsIU5689C/Spfho/CDnumo3xIhonHvydrKytL0
 fxlyuC7qIdgdsZNOAmhvuZVcmjwf5+EZXXrVjrqqaSZNqJP49GmkabrHysRYeZAuiIFd
 PSaH/vDZh3OiJLGNC2HutF2+jpxYftL8ZVocupZ/2nW6GB0G/RWUX+T5RA//kWb+0iPg
 ZGz1kNxgflwnI0Ui91U4lUUNUfUcuIGU6F0baXZnG5djTD0JF85fzr6gXDEA42MYTk2M
 WBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823162; x=1787427962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9jJ818IWZdbZ+oA7FKlW0IozvBhiq4MYdB9KFJONT5M=;
 b=VWydtU2c29Msjb9efWQaSWJDRJL2jQc3+qas1xJDzlzbdh+0JUwiRiPXBqPxJAk9Jw
 3Qlw/s2yTo8Vc/BbzlxFSOqvBGuFFPnjVlM4+8g4FczBr/bcAEic5wqg5+DmkJTTgT4B
 fkJinGeokKdnBddNilF3ZISuCDLOUA3K4+DiBQ2/qKeTLof8xQ1Hi06LSfXydU0nwi2X
 WqMx78U+Lpsmih7PgSrL4xV3pssgCP8xM0OQ1RM+gsxSxfCK8W4LwyASiIWkSeAfu5Yg
 Fs4JVmYQmUSuyrTpdd0hwhdI0k5DGeCqHLRqRiQGuf2Vifu37CU76PrwaSnH9W1tbKSI
 CDSw==
X-Gm-Message-State: AOJu0YyUEM3Y/cbMnOpUkMTuInfMctSTlkHawBbeF8qX53notd6Tvvq2
 6bDR2rauD3eQmekrBOQcpupzeGeNjSjw7/jDwK0EODNoDhWvxTLezLqw+c7YmfOJyqj5fhENaEj
 fF1CD
X-Gm-Gg: AR+sD10Z6AS2fclhP222xaQqhNoq1i+ot10oa/c/UvUe+oIRp2AfzRgczxT61XS1oFB
 zKKpGvfQ/vAuzAeDmpZtSEOSf8rgGX5nVs3tePTrmDQANTaoDaFSvwv1Jm5xRRIr5dCkGDpB0Sf
 NeqvqhvWPKG+5DhJT3gaZH8pbrrl7Dl6eEFa7ku0rPdLi37arwRZQPvF4LWfFe0ALX4nC4PsZFk
 5i/x1OGake9WmUF+2x/cRNoTNxGoEGEHptV0vhHYEi3STFFzXNEIAMpbtZceLDM/1fqLgtynYvP
 0jglJjkMOGq493nS9aB9RngxAa+crN4PwrUEYSMbypF+SfkZusyTBj7RV+GFlgclpdBiGfNdW4b
 cyvDJXkxjXksc2cuml+dpXdUz0MlKIrl1RKAZRStHMPi4vv2wuC1hgb+NSAxiEmPedUaCqTl3jA
 jaP03D2hoUjoTaITAfUl26/P9TsZUsc5iXHGdP7lqwF0rw8a28PY6p8JNelWN1dPhI8n4fTtq/j
 zf20OCZW+A9TTA1eIamcsV7uaR7Oag=
X-Received: by 2002:a17:903:144b:b0:2d3:2e86:647a with SMTP id
 d9443c01a7336-2d3b07effbfmr179973825ad.5.1786823161883; 
 Sat, 15 Aug 2026 12:46:01 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 02/23] target/riscv: Hoist vma check out of
 vext_set_tail_elems_1s
Date: Sat, 15 Aug 2026 12:45:27 -0700
Message-ID: <20260815194549.1377505-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

In all cases we've already extracted it in the caller.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 35 +++++++++++++++++---------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 20a8f95efb..8f74162d50 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -311,19 +311,11 @@ vext_continuous_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
     }
 }
 
-static void vext_set_tail_elems_1s(uint32_t vl, void *vd,
-                                   uint32_t desc, uint32_t nf,
+static void vext_set_tail_elems_1s(uint32_t vl, void *vd, uint32_t nf,
                                    uint32_t esz, uint32_t max_elems)
 {
-    uint32_t vta = vext_vta(desc);
-    int k;
-
-    if (vta == 0) {
-        return;
-    }
-
-    for (k = 0; k < nf; ++k) {
-        vext_set_elems_1s(vd, vta, (k * max_elems + vl) * esz,
+    for (uint32_t k = 0; k < nf; ++k) {
+        vext_set_elems_1s(vd, true, (k * max_elems + vl) * esz,
                           (k * max_elems + max_elems) * esz);
     }
 }
@@ -368,7 +360,9 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base, target_ulong stride,
     }
 
     env->vstart = 0;
-    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
+    if (vma) {
+        vext_set_tail_elems_1s(env->vl, vd, nf, esz, max_elems);
+    }
 }
 
 #define GEN_VEXT_LD_STRIDE(NAME, ETYPE, LOAD_FN)                        \
@@ -482,6 +476,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t k;
     target_ulong page_split, elems, addr;
     uint32_t nf = vext_nf(desc);
+    uint32_t vma = vext_vma(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
@@ -500,7 +495,9 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
                                  esz, is_load);
 
         env->vstart = 0;
-        vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
+        if (vma) {
+            vext_set_tail_elems_1s(evl, vd, nf, esz, max_elems);
+        }
         return;
     }
 #endif
@@ -542,7 +539,9 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     }
 
     env->vstart = 0;
-    vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
+    if (vma) {
+        vext_set_tail_elems_1s(evl, vd, nf, esz, max_elems);
+    }
 }
 
 /*
@@ -661,7 +660,9 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     }
 
     env->vstart = 0;
-    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
+    if (vma) {
+        vext_set_tail_elems_1s(env->vl, vd, nf, esz, max_elems);
+    }
 }
 
 #define GEN_VEXT_LD_INDEX(NAME, ETYPE, INDEX_FN, LOAD_FN)                  \
@@ -842,7 +843,9 @@ ProbeSuccess:
     }
 
     env->vstart = 0;
-    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
+    if (vma) {
+        vext_set_tail_elems_1s(env->vl, vd, nf, esz, max_elems);
+    }
 }
 
 #define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)   \
-- 
2.43.0


