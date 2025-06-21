Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D1EC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7yv-00050a-O9; Sat, 21 Jun 2025 19:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yu-0004zt-Dl
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:44 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yr-0004QY-Qs
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:44 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso3526371a12.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549840; x=1751154640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PdvwNl7JiFORoJKfG82WHoJWKQvzz977qK5CdHrmdQk=;
 b=q+bfkXjn9FzxzoxjHQ+6uC1XZ4+JQlpRb155Rina9CLHx97QxYJbGfK6RvcEVvAhpB
 gdCYChJ1oQlQ754RMdXMm4oTWej7Qw0Vc4e0UtViYBjQ9vddZCgMYICX3PiUd49JxK1+
 UiO/syncEXSoNwsy3vTQjl+E3+v+xoIP6HENEhgYaqqkgfAD7kuWuUJwqyEnE2PB1s05
 cdT/57I5DkILnxEIlpKLS2r8SkriqUK8aTfp6tNfWdDUaWfOjxplTpdSMB3fETF75dMG
 1wPXVN8akPgaqMUp+uCdtV5Ya1eb2dSWReyxBJ9FjEMaTOW+8NQgEjwMo8wt3ZiJCUEp
 5kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549840; x=1751154640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdvwNl7JiFORoJKfG82WHoJWKQvzz977qK5CdHrmdQk=;
 b=DSMYqgicbBgYUbpgWcAD4A8yVKWv+s4FQUI8VdQrC1829Uhu3Ig/+/kCVgdQ18upwg
 cay/+O1nJTcAImeLPLHvGDSJKtvn+MwQZe3Dem4ZSZoBgSh3NkEQhep+Z7yGmKYZgByX
 TGKsVQddZoZC1Q9pzcH7KFPUpoTM1B7STODhvwLXoa+bYzs7I7eOcT8seOcxII+tY+W1
 1/SND8ZKf0rfozJqp631GP5I6PPnkw07RX3amYLJe15jZmebgo12ruimRPPZ7fQ3gLdn
 dZuBCb9zQN5U2auIQsoAC9rcp8x55N0VAbcnHvAshvzh0vrUZNiyNEtWo6Wi5GfoTcTw
 R/2w==
X-Gm-Message-State: AOJu0Yx0WvUsqLuPxVh2QeG6iMPSvfy8CxWTjYIw0CyfT0NliD+AQ9Yb
 fQHFbmuV+GlbowvsmJmn5Y4NURkBBKVGcwTDqXPM3XYuifgHO+GiMIBidr3oGrzkn0wbIVr5N9b
 SnH+v
X-Gm-Gg: ASbGncsNr7JY1cLv6PvZKgwsgotJCX9F+UR80hFoGPTRRZ2HW1lJtU8tnFWDrzlpcjX
 k3LnJb4RSJtryfaQ43L3TBPN/JxPQXY7GNg6rxvfpRh8fRv4Wh2bmFfN39yqGXU+L1d8U1/AaNQ
 n7g7PGzPiwS5qzQe+oQ8Rl5esnqDifsfBJlxgi+n48WNxW9rvbXZHZpJG5jrl27Xai7xY0312FF
 2JOQIlX0OjL4rPz7msuQ1NHlJOIZcWUeJ3h3HF95Dboybt8+MRmtK++v2zQGkGQEu/s4m3cD2pg
 STx3vxRCoZRAApCSgxos5EWocgCGc/yfFNzcwqkQOSgbianMR66sC2d9Yd/q38Hp1fXDayhqIuH
 DQE4VxlGJr4PvG4EP4GQELiFjO5pXBXE=
X-Google-Smtp-Source: AGHT+IEKdwjRaTG5hX6pb+hkYLlUddT8DSxY6ckt3Rhf7Bfeln8f+Oa6jQ18IBc2bWS1QyUHktN8qQ==
X-Received: by 2002:a05:6a20:1595:b0:1f5:8a1d:3904 with SMTP id
 adf61e73a8af0-22026e131dfmr13605606637.7.1750549840166; 
 Sat, 21 Jun 2025 16:50:40 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 002/101] tcg: Add dbase argument to do_dup
Date: Sat, 21 Jun 2025 16:48:58 -0700
Message-ID: <20250621235037.74091-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 1aad7b0864..451091753d 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -534,9 +534,9 @@ static void do_dup_store(TCGType type, TCGv_ptr dbase, uint32_t dofs,
  * Only one of IN_32 or IN_64 may be set;
  * IN_C is used if IN_32 and IN_64 are unset.
  */
-static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
-                   uint32_t maxsz, TCGv_i32 in_32, TCGv_i64 in_64,
-                   uint64_t in_c)
+static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                   uint32_t oprsz, uint32_t maxsz,
+                   TCGv_i32 in_32, TCGv_i64 in_64, uint64_t in_c)
 {
     TCGType type;
     TCGv_i64 t_64;
@@ -574,7 +574,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
         } else {
             tcg_gen_dupi_vec(vece, t_vec, in_c);
         }
-        do_dup_store(type, tcg_env, dofs, oprsz, maxsz, t_vec);
+        do_dup_store(type, dbase, dofs, oprsz, maxsz, t_vec);
         return;
     }
 
@@ -618,14 +618,14 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
         /* Implement inline if we picked an implementation size above.  */
         if (t_32) {
             for (i = 0; i < oprsz; i += 4) {
-                tcg_gen_st_i32(t_32, tcg_env, dofs + i);
+                tcg_gen_st_i32(t_32, dbase, dofs + i);
             }
             tcg_temp_free_i32(t_32);
             goto done;
         }
         if (t_64) {
             for (i = 0; i < oprsz; i += 8) {
-                tcg_gen_st_i64(t_64, tcg_env, dofs + i);
+                tcg_gen_st_i64(t_64, dbase, dofs + i);
             }
             tcg_temp_free_i64(t_64);
             goto done;
@@ -634,7 +634,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
 
     /* Otherwise implement out of line.  */
     t_ptr = tcg_temp_ebb_new_ptr();
-    tcg_gen_addi_ptr(t_ptr, tcg_env, dofs);
+    tcg_gen_addi_ptr(t_ptr, dbase, dofs);
 
     /*
      * This may be expand_clr for the tail of an operation, e.g.
@@ -710,7 +710,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
 /* Likewise, but with zero.  */
 static void expand_clr(uint32_t dofs, uint32_t maxsz)
 {
-    do_dup(MO_8, dofs, maxsz, maxsz, NULL, NULL, 0);
+    do_dup(MO_8, tcg_env, dofs, maxsz, maxsz, NULL, NULL, 0);
 }
 
 /* Expand OPSZ bytes worth of two-operand operations using i32 elements.  */
@@ -1711,7 +1711,7 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t oprsz,
 {
     check_size_align(oprsz, maxsz, dofs);
     tcg_debug_assert(vece <= MO_32);
-    do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);
+    do_dup(vece, tcg_env, dofs, oprsz, maxsz, in, NULL, 0);
 }
 
 void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
@@ -1719,7 +1719,7 @@ void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
 {
     check_size_align(oprsz, maxsz, dofs);
     tcg_debug_assert(vece <= MO_64);
-    do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
+    do_dup(vece, tcg_env, dofs, oprsz, maxsz, NULL, in, 0);
 }
 
 void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -1745,12 +1745,12 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
                 tcg_gen_ld_i32(in, tcg_env, aofs);
                 break;
             }
-            do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);
+            do_dup(vece, tcg_env, dofs, oprsz, maxsz, in, NULL, 0);
             tcg_temp_free_i32(in);
         } else {
             TCGv_i64 in = tcg_temp_ebb_new_i64();
             tcg_gen_ld_i64(in, tcg_env, aofs);
-            do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
+            do_dup(vece, tcg_env, dofs, oprsz, maxsz, NULL, in, 0);
             tcg_temp_free_i64(in);
         }
     } else if (vece == 4) {
@@ -1833,7 +1833,7 @@ void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
                           uint32_t maxsz, uint64_t x)
 {
     check_size_align(oprsz, maxsz, dofs);
-    do_dup(vece, dofs, oprsz, maxsz, NULL, NULL, x);
+    do_dup(vece, tcg_env, dofs, oprsz, maxsz, NULL, NULL, x);
 }
 
 void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -3772,7 +3772,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     check_overlap_3(dofs, aofs, bofs, maxsz);
 
     if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
-        do_dup(MO_8, dofs, oprsz, maxsz,
+        do_dup(MO_8, tcg_env, dofs, oprsz, maxsz,
                NULL, NULL, -(cond == TCG_COND_ALWAYS));
         return;
     }
@@ -3892,7 +3892,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
     check_overlap_2(dofs, aofs, maxsz);
 
     if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
-        do_dup(MO_8, dofs, oprsz, maxsz,
+        do_dup(MO_8, tcg_env, dofs, oprsz, maxsz,
                NULL, NULL, -(cond == TCG_COND_ALWAYS));
         return;
     }
-- 
2.43.0


