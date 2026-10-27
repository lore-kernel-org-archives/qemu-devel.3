Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE5606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TreZV6CZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLahk-0004BL-FG; Tue, 27 Oct 2026 02:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLahA-0003hU-GU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:30:07 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLah4-0008Fx-Eh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:30:01 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3acd21ba21aso2943579a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082596; x=1793687396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=USf/TfP9ERCPJ+ymnkptW8vWTYOPnCO9HmQy6PiqzRE=;
 b=TreZV6CZvElQIUk+fMCPiNGPgP8bA1FSYTRwBXHFcVlTSmOnCEWTbS5vh7C3q4Xtpi
 7SrPFog9Pl3r7ag5HBpzJKKm7gvvSxrpBVh5JKsqXFpgrNs2lnNlpW7ykxrJWO7o2YF9
 TawDDkOnl9D2EnomqLS2PfwWGA1F6qL/rk7cMVg5lAEtWe5mGYIeI+z9fNMBZ4dPuCud
 nS+HkMU313HpdUFUfMQqwIlP2bA3xCdFa2wdACYOwT2JirU/oN94VCSzcwy++ZOIjXG6
 QSzgYFnfUJ6KeuLl50OBaSsDbfDuYZ+KoH6H7RpBA1FP3+SML5r4qtRNdhbgV5JWkqsJ
 CL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082596; x=1793687396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=USf/TfP9ERCPJ+ymnkptW8vWTYOPnCO9HmQy6PiqzRE=;
 b=eRKEe9PqOsgxMn9QJjVzusPH/C/5K0a/5zpSB6SPVJb28gHbM7xQ/8pjf6jj7pQCt7
 YO5eq1je4cdN/0OgOkpYqlm8Ry/vLPDS6x8OD7xhEE8bUt/uX36F71wys2ezg8IeYR2j
 pwlm9olXO+2tYZPQLJGo043ADwnlcxzjrgvm+BY9qKe/TtUbs0pB1XkidlYZ/S071/fU
 oE/JpM7Vwy7wpVNWwRbvgMYfpNYtLuEt2DwB0Q+u69elSqkBpJXfZtKd1l+SbKYjBHEt
 AZcQqr1FjrybUK4HSwcMR/Gg4WM/k1RkIaO8hQNu6wBk3VnnAE7AYFZPz38RK5mz8JeZ
 0Dzg==
X-Gm-Message-State: AFq9FYITCJS4abx3y0S2YQ+ukyk/F2sTalmLAf0uA3NkWyYYiiNp9Vnn
 Cm6OqbiUkbXN4cnF9n2du1qz7iGqyuL50p2YtruDzykopj+w93d968L2oUofmA==
X-Gm-Gg: AYBFou1GkrOZ3xXzyzzhAhsenAEXChVR1fBif4L7kaHKQfkeZJqzayEbodjyKXVVl66
 AIHUu1GxvVmW+J2SbaaXJwFv2R1w5CfQ2z6oSRR8mIHwwKnclHZZYNqJfh3Ej1YgINDBN4RIOOy
 d6YIfoj2ElqyCgf9MemxX/pIyxtSzw0qh0Zx1aDiUn1GUhzrYcktZeFQdgVNMbhJb5XnP8dCEHJ
 oIBLTT0p92tQzfvHFaF68J4wM2lnWuLwZjVecC95IFqQNQxGwkydZATWN3DGinaniUvAyJ7Otkx
 hKGEF6oNuzQhchY+ix5tjmp9oOh+mEQWEFdaxDmGzeir5XnlQ2iPOHCJWtIL3WXDDvOqGGNHn/0
 76+bR0tLgdTNwIaTGxFyGsSQ6/C9t9SanY3lExVE/PpI1d2EZ4LvhmgLWHJT1bZaMXZYKDzqM0k
 8r3bh9LktQflufUbNenYnM++Vz5TNtYOAuTLJVZnvtnLxS8kMogcuYwrv6QZ1DW4YXRaU6ioR2Q
 2Wx2th7SK8mm/O51zd1PzULiR7QMO7CS1hqHEGcsnfY9kVu/eZaU1y0sgtzd/Vpzt5cshdxDbA4
 OumtP9Bv9n+uFW2Ey84=
X-Received: by 2002:a17:90b:3dce:b0:3aa:6b5d:a02e with SMTP id
 98e67ed59e1d1-3adeafd64c2mr7758839a91.54.1793082596091; 
 Mon, 26 Oct 2026 23:29:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Tommaso Califano <tcalifano@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/29] target/riscv: Fix CPU state access on big-endian hosts
Date: Tue, 27 Oct 2026 16:28:08 +1000
Message-ID: <20261027062808.1995205-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Anton Johansson <anjo@rev.ng>

mstatus and mstatus_hs are uint64_t but accessed through

  tcg_gen_[ld|st]_tl(..., offsetof(mstatus))

which on a big-endian host running riscv32 incorrectly accesses the
top 32 bits rather than the lower bits.

Widen the operations to 64 bit so the lower bits are modified.

Fixes: 284d697c74ef ("target/riscv: Merge m/vsstatus and m/vsstatush into one uint64_t unit")
Reviewed-by: Tommaso Califano <tcalifano@redhat.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261023063025.8827-1-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/translate.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index ede9c2563f7b..79b0f444efbd 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -693,7 +693,7 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
  */
 static void mark_fs_dirty(DisasContext *ctx)
 {
-    TCGv tmp;
+    TCGv_i64 tmp;
 
     if (!has_ext(ctx, RVF)) {
         return;
@@ -703,15 +703,15 @@ static void mark_fs_dirty(DisasContext *ctx)
         /* Remember the state change for the rest of the TB. */
         ctx->mstatus_fs = EXT_STATUS_DIRTY;
 
-        tmp = tcg_temp_new();
-        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
-        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
-        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
+        tmp = tcg_temp_new_i64();
+        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
+        tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
+        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
 
         if (ctx->virt_enabled) {
-            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
-            tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
-            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
+            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
+            tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
+            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
         }
     }
 }
@@ -726,21 +726,21 @@ static inline void mark_fs_dirty(DisasContext *ctx) { }
  */
 static void mark_vs_dirty(DisasContext *ctx)
 {
-    TCGv tmp;
+    TCGv_i64 tmp;
 
     if (ctx->mstatus_vs != EXT_STATUS_DIRTY) {
         /* Remember the state change for the rest of the TB.  */
         ctx->mstatus_vs = EXT_STATUS_DIRTY;
 
-        tmp = tcg_temp_new();
-        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
-        tcg_gen_ori_tl(tmp, tmp, MSTATUS_VS);
-        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
+        tmp = tcg_temp_new_i64();
+        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
+        tcg_gen_ori_i64(tmp, tmp, MSTATUS_VS);
+        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
 
         if (ctx->virt_enabled) {
-            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
-            tcg_gen_ori_tl(tmp, tmp, MSTATUS_VS);
-            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
+            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
+            tcg_gen_ori_i64(tmp, tmp, MSTATUS_VS);
+            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
         }
     }
 }
-- 
2.55.0


