Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCF2C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kJ-0003Hx-P3; Thu, 17 Sep 2026 00:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jo-0003Ai-M1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:49 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ji-0006mi-RQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:40 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso280693a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619317; x=1790224117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mi9YGCK/K8L2XG8JyWU5uLRVdpLLn+xOvd+M5yNzz/8=;
 b=fnhdwTK2pZutpeucjZQQ8bOZhqhP3lmyiR8LYOwskqazNalHlcQdLgS35gsgUkqiIo
 mvMzmjOe+JSTkZigrtbHsc72hvuhA9fJPtUvuGCcOooJtXIx7amerCZP2lVhO2gJBhWx
 L18oAJjWhkoqxLzSsRcoY0T0aklUc45PCRHBNPOqdU9kDyuQERnXvYXfwNqdgjDcMFyT
 1wMZO59W837bJP3biosNTh/Qz86Nb6fVawqffH+tnETi21MgMmQL2ibed05TzejbMy5K
 rnvdtaJxPPIJUT22xVDl4JAmotPZI6LpPTmuoG7M5QdtNbv5GwgsVUsEgeG82L7oe5jz
 2lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619317; x=1790224117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mi9YGCK/K8L2XG8JyWU5uLRVdpLLn+xOvd+M5yNzz/8=;
 b=h9mxKdzgoXAC0sLCG85muzXUi01UvP0CT8vxtvE/E8Kj6nDzgocf78MrSbgt8cGKW2
 70nuxn7hF2SRn159pEhomDFw/aZpqBcePyZjpJp4Kd0LOQXYfOVhk8AtHnWL+7KEEf1k
 pWGLLZ9sRkf4vgVZE+bdtfP/KYMMDSNkRqG6wDo58Y0BS7i2kEEHuP6yik6a1nrZ3R+g
 +yPU4g6NXd+gQxzAQjyugMwFWxJ3bhQglWQkHnQwofh7suS+ipw4cBMQMjXjhp9dZ/Nq
 eoJzZBNjfxwx23MbKVsHZkWYcdXwsVqVQgiCJDdZYilCmPxKj3JJ2sa1OgvNQH1jb+4i
 x56A==
X-Gm-Message-State: AFuF++nFD7V5Kq/qQgJcnNKTgVaJ1tA/C1glfutBVuBnOvF4eMsVtPVX
 6IFilepzXcXSMFJlWaRpO0oxQHTn3QW3umrzEyzrVn4kdUH8bdFxKNpgLJTVX3LrXvnRxOdOgQZ
 G1/HNAnU=
X-Gm-Gg: AYBFou2qtGQuAHkc/sFbf+PEaJQ+v18FKD4I2QNbc58OC6veDNLwV40FO8DAlNExzI5
 784zA+zom2Kd8XUCBmr5Hcc1Y14Cpd0VyXlTORhubYe6nFIrpLUifwxPBad+PRWiEl9CtR4Kep+
 uuzEX8RgiAIqBb3L0D64N6Z8Qv0uWH3I/rHvQD8FnJbgTX2ONUIV19TfbvI1vFqGzTEavHsagqV
 Yf0G0PQEiQ/xm7QekT3KF1uhjA1CzhWEsQzEHaf74Z41YFjFnnRDvgnznNv83PGyVQqblCP0f2U
 Fdbvkie0EB212TcD3/w7K9QXcCrg81n3LyuQdjNUBgndict8O4mfN/AgV5M3H2V6h1w0kYHGPdG
 v1gslzUEl0ZhePTdOD+m15Fk7TC+WHGulkvb69/I+BwIWfDXkmG6E8BSn0XYEOQglNDYNXD2MmH
 Ojfe+n706Cw9iAUaPqub0kQ/rbmeWWqiOx248UE27iZXG2QedUKD6SrplthjoV9TRA0poX7+swR
 CrR7UAxOk4kMhfqAg==
X-Received: by 2002:a17:90b:2b47:b0:39e:888:3841 with SMTP id
 98e67ed59e1d1-39e36106e9amr3391261a91.16.1789619317185; 
 Wed, 16 Sep 2026 21:28:37 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 010/101] tcg: Generic expansion of tcg_gen_movi_*
Date: Wed, 16 Sep 2026 18:26:52 -1000
Message-ID: <20260917042823.542588-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 69331928bd5..f54b3618e8d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -117,7 +117,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -224,7 +223,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ebfaf0b8188..5de7648ed48 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,3 +1,4 @@
 /* SPDX-License-Identifier: MIT */
 
 DEF2(mov, TCGV, TCGV)
+DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6fc75b9286e..3b3bd5cdfa1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -392,6 +392,11 @@ static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
+{
+    gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
@@ -399,11 +404,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
     tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
-{
-    tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
-}
-
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
@@ -1466,11 +1466,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
     tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
 }
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
-{
-    tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
-}
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-- 
2.53.0


