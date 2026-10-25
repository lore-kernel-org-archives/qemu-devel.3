Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C550606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yg7CvmeP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWD-0006Fb-19; Sun, 25 Oct 2026 03:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW7-0006Cx-1I
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:44 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW5-0003hj-66
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1734366f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912780; x=1793517580; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sz2LN6W/doy7zVYvNV2XjaJNtB7VxmtuROJMu50C6ac=;
 b=Yg7CvmePnyMOqUjFfQfQY7t7yTNmEleXqX6+hyEZg80RX5CVJb2OVfv3YSu6pa1qPn
 gHm/mqNUayJITMIF/SiXOpKiqtUK8Gq7znwFB2D3L/rcwKGRJt9Bmd60/kRwPO0nAYAr
 TyVdCMrn1W1vNQIHlk1R83MYcm6ipvnigZI4DK+uDWDu8hDpwyJGBnIqO2V9WRH0dlvY
 oX7l0d/2Ru8O71PAYs6e5YGhO5QodMGBx4nqKxQutziF/R3qfMtfrWUWIwcNIM4ictP0
 z3FHKDHPZVC7eNBTGvKVujvYakQt2GVeXX5+XrmKRwTtksPxe7POHYR10mqvzdksy36R
 76fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912780; x=1793517580;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sz2LN6W/doy7zVYvNV2XjaJNtB7VxmtuROJMu50C6ac=;
 b=xkmZxrJtugDbhYZ4FnhjY94XIEXUtLmTeSq5MS8loB+0KRceWCFI9ZsxdhTvHPr41T
 NQlKQEvEsNr0YWMpWGJWYx1gBHRO73Lq7ht6pAst4PtmXLMJesdAr+5O6QN4DlYMNERg
 Wx9tfIVqscLdocl2LNPBGAtf3NcQaFrH8q9WoZC6KO3n7s2QLNqoGUjsY7vdw24wYzC6
 I1QBrOMnH/QXpPVJxaV02HRiNAJcwnlhs+VJ/ZUY/6qVZk4UdYso6h0ut4Qrs+T0+WoQ
 HCRCd3uVnh54tCGizMj8y6SSNq3c+S+bB3a0HFu3zamr/x+wGBYvTWHFbqBj46b438Vw
 XjtQ==
X-Gm-Message-State: AFq9FYICV6S5LHp1cZ7gSJ/jEs+wAWn+1+VdTZrbO8DwzzdxDT4pV4Fg
 m8c7eprGbbIfuCnL+k1cs6VTx9+M721K9IKGFESz/rjY32k1XfIwNRl+3TA/gbc1FZVxhOq8a16
 7DRs6KeI=
X-Gm-Gg: AYBFou0VLcTV62Dp0+gOFwFSDaa+YycoM/pjHkOWY/WYyxllN9+4A1jKdqntifwhXL4
 kR8R6PJ34MFv4oXwdphWi9KvxVTf9+aL7uOOexPvsfjUCSbmmu6iStGnIX97ODm08rLNWPjcXU+
 brobVlSNXrGPIZC+frRy6+b+1e+kqnsy2yntlIUBn1JxpEl8BGHUjog1V+z/fgZC+1JE3mxqtJ1
 syjH3SsUlQq+61nt3p3MpdCWf/9ZHcyJVUe2liR9hnk4yOoImkewEclb2GiZYaSe1mgjw6BGuGp
 sObtl+fzneafxcaqW1KOl6HFCGdsR+LuXlOZozJ3BmOgYQ16sMitxNVlHrjvMvZW+qnqlKabG2m
 r19U40shGD1B+S6DOBNYG1W1K46/coOfIYS50tmQseX6jpWhk2Q3vn9UzMXsibZtJ93EPkE7dxR
 sBcJqJRGqc7jaCq/ggPp4AoPAvcqw7l4iD7D78o4qzsYxZGDNoYVYhKHFALMsj2Nw4tz8EAzDq1
 VJb040c11gaPLRBlA9wuQshjq09SWGpYqlMXgyf2Zty4w2YwR2B908IVK2HYCXGYQjZ9GxMfESd
 sDk=
X-Received: by 2002:a05:6000:430d:b0:48d:ffcb:28e1 with SMTP id
 ffacd0b85a97d-48e3eb780b0mr5659637f8f.11.1792912779805; 
 Sun, 25 Oct 2026 00:19:39 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 018/100] tcg: Generic expansion of tcg_gen_xor_*
Date: Sun, 25 Oct 2026 08:17:53 +0100
Message-ID: <20261025071915.1123867-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9cb9089a90..7ff99a7671 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,7 +314,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 8dd3929060..ad298b7e30 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -12,3 +12,4 @@ DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(xor, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b330d0fdb5..5a0c7246d1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -428,6 +428,11 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -472,11 +477,6 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-- 
2.53.0


