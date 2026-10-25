Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C6606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jh5BLF2l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsf7-0003sK-S0; Sun, 25 Oct 2026 03:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd3-0008SV-Ek
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd1-0004bU-Ri
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:53 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so971405e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913210; x=1793518010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c4Wmq31sT6bpaevU7DOYvTQzRzJBB2/hP99PFmUAsYs=;
 b=jh5BLF2l+YMqLGFdvihpQDI9MI3Ob6rcmKOQ8cCUYt2jkYuLEaJ1jIc8I+kj57QDb0
 ZKJDMcrckkoG6GNYDNdAmQJ7Zoz0MX0MEUlxcOYEwGUafj5TQJnoFkOjemNHP87uk1jS
 a28Jmuof7wlXR0bZvTpHVtWOgUSCcxx/YZXo6aHHzXCiKyFrFh+MiRgvJVlAnmX02mX8
 X7kaiRwOkkkVbxa5TIUVZbtqENil5w4X8+mzdYTwxLZsPokgP54hrSy5PnYrZZ37GENB
 6lKfpUJVpRN/I6ZqgzaQj74dwt+QTQ5Ag1wKveyHGF68Cj/F2ODBH0O4On1XZMXNwmzY
 YEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913210; x=1793518010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c4Wmq31sT6bpaevU7DOYvTQzRzJBB2/hP99PFmUAsYs=;
 b=BeGblbNGfgP2s7UOKh51uIUQQVWR/lvz7D7oesz8RIje0nifBfwjFSJL6RkoSiZXzr
 gxi3uh26Qq3SMfPfQld2JFbYg1MGQest07LHhWz+1Rb1LSa1lA35OigneuPqD7mEK+5H
 PuE/TAz2RFxkowpEgnL2vyAK5aqQ1ssSsefK1dYrHPk1BtbbhVlMFIZ5RNoRFpGOh+Fe
 h9sZ7DEFHLcqSTaNYO37IDt+qE8wUGSRfHTYUeGNqUA3p5ATA6EIlPlqMcsuwHbQ+WAJ
 eEFIIvJ+J4P10fzQQVuQIQP/MKryFHzZwbe1ueh5wH3mDs/C7B0rMD16Jl2KZkXrGGy5
 g/4Q==
X-Gm-Message-State: AFq9FYI5dHY1T6vu/2SJkILNVeb7tzz384NB3O/zb2u8EmaMBkMp7rZD
 +Khuesgsh8R1LLZ3vE51SF7tVU1jGuCycwjnoAG7hJ1WY2rqeKx1hiRaOiFLhy7rUo7yll4mgBj
 8lAKV1Ng=
X-Gm-Gg: AYBFou39H5tFQU7XI8icqDvW7/UyCU90hpDL0/D2J2+ADZw2bBxuiRpIUuWMn1twknH
 zG9U3JiJoZAYmwRsMATkXgehdfVWoJtYEb+7JoU6U3EEyRkvFBIbKBcUfsNuIyearQzFBtNdrcG
 Ke8DmfBJ7EC3SVE/5bYlv0ysenHd33+gixUaAVWvap5gS4iU0OrzDbw37YXv9zZKXZOkrabEO+U
 QvuVmZ3SiV2MKTknuJ0s2Np0GzxkrhD+mwZ5rKIPRI9C9NLlPAR3ivM0f/Toht8hgQq1Ca9a0o2
 0T6pGtY28efuWb/SkcUTWJbNdagK14qyaGj24QRiPL9MhVyaAzxPxSWI4/0zROauPhjxJ9v3if4
 a8SIiJveUF7zZ/o1pzgXfuSlwk6Db3NZhwh0yG4uWerLdlIOww/3xtnVnz/wNw9rUkh93v5F8Aa
 u0UgVpFJcX5ekYc2VlOTuz/c8Ux9YWIWFOB47cGTauwxeYoae3CLqZj43Vy0zP5eHOsguSYBrbv
 W/s7HVQVgMIAF+3TnJxnAxC1RHrsF1I6u8bIdBpEvWFsVrxrXqvhZ7I6SKBBVvqN00V9tYep2Y0
 jCAb
X-Received: by 2002:a05:600c:3b2a:b0:4a1:71e5:9420 with SMTP id
 5b1f17b1804b1-4a35aca4e4emr59405385e9.13.1792913209734; 
 Sun, 25 Oct 2026 00:26:49 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 090/100] tcg: Generic expansion of tcg_gen_ld16s_*
Date: Sun, 25 Oct 2026 08:19:05 +0100
Message-ID: <20261025071915.1123867-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 744211c4c6..c12217f68e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -141,7 +141,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -168,7 +167,6 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 75bb38a07e..785c417a74 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld16s, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 06d0aa3fff..1bcf119ca6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -787,6 +787,12 @@ void tcg_gen_ld8u(TCGType type, TCGTemp *dst,
     tcg_gen_op_tti(INDEX_op_ld8u, type, dst, base, ofs);
 }
 
+void tcg_gen_ld16s(TCGType type, TCGTemp *dst,
+                   TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld16s, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1396,11 +1402,6 @@ void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
 }
 
-void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld16s, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
@@ -1424,11 +1425,6 @@ void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
 }
 
-void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld16s, ret, arg2, offset);
-}
-
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld32u, ret, arg2, offset);
-- 
2.53.0


