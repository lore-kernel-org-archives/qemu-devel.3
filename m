Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA3FC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklP-0003se-B1; Sun, 27 Sep 2026 05:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkO-0002Ty-BB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:37 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkM-0007RH-41
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:35 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0b6200eb0so1601421a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499633; x=1791104433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJJ6x4JDKtziwseE92uIzOyOPo9C5KwVo49TDfp/03I=;
 b=PzClaPTI5JMFgkbBNLwKj+oLmnClQ7uCTpchZ2LoLc7Vl2QTWJfHLg/WmiMz1sw2AF
 RZoE1FROa+YR4ykeaJ2/qFwwIWg7AiviS06sBj7KCx/iPKRwxH4y91WvZqdw8YZn1Kwf
 MycetC/rFpfQOdbzxZITkqjLNS2RP87CFiCk3IH7l9QsyKpKRv7m0p0wntGsPmi13FZX
 bmfSw3sbIir9sLSSg9FBN2TacPsVbiBGcon+aADw7BI4pkjoK3zIcWOyqLslMyI768HY
 GEkRbMSnwV78hbKh5J4TJTQXH0dJHQD2Ih7V54koJsCjbSU6n/JJw4dHY92zKOw7figW
 tCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499633; x=1791104433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJJ6x4JDKtziwseE92uIzOyOPo9C5KwVo49TDfp/03I=;
 b=cW3yMb0p1rvxh3LKSQo6Fvphu8sQTN57JKeoZWj79CXk+Eu3JpNbxfLJEQeunHUTB6
 AxYSWLyP28goTnyXtk5MtZZCHtGRDTt/8pXT9L13oPFd2Y7rSgF7hDGx288YQJ09vh2F
 9II889IOEn9rt1QP5tALv0tZlfkozY+nDTgayuCK7uM1d6qAkYXsImVwdEtsv+/vYceV
 U8eKr4nc6YR1D7F3//bIlT8kDELGJs1rqPddIvXB6oPmuch/c+JxoF3uA1EV+uABmopP
 Hwsvcag+f2WB7KDCkxD2loU2WGnx8V0jT7cQSL9tADPiXvJgpIlPx166ReU3CKOCEmi1
 irLw==
X-Gm-Message-State: AFq9FYI3KOg2x/t97cYYW99TIXTD38nNYd+9VUVOg3YtKjbXnPjItJwB
 uz2MZEAVLJ3PuVQcpTQTp/vUy3JO03RW9mu9VSqvE6j3B6KhgV/8mlhapbTBJZwizObpf9EyBM5
 RLw5b
X-Gm-Gg: AYBFou2SrqJ5qEG7MWY6PbdFw50vyEa7OiG0vBF0/A4Nt1AhUmQmbC6zIwvK31LJLEU
 pHzMWkDQV9qvLh2+MkQl72s1tIHJVRLNlE3I0Bmp2ibpAck1hkfO85Ad5LlixWRIz/DspvBDASf
 1mG7qPRicOFEnDWOq6NNosuTlEi1rjJ4ug/tgnkf8C0U5wrV50t/pinlXynIw+UCS4Qn4HMkD19
 D2E8a0RyzNosBMMtfIJiK1OFP7QVZl8uOcxabJ8JgcKvp+OcSLNiHzg7dYBs+MwMm0Og3e5MIB0
 nk3KfDYfNgRWAvNVtUx5U5AbWSIOZcH13N0snKGgz3x0QZ3f0h4NdPyrrHLz5eC5yoncDftwKLy
 kcsBB8iuNMyzWOEJxvuR6ZqhmUx0LI7F1QHaspNVoEpdARRyRJJW8DhRLiYlmbdBgYpB9j3w6up
 aJHhlX8ZHqtSxL20f+N3MhldWXd324IQvlA3nQT5PjHzvokNIs6IEHwguQ7Ac9YZDF3XTly29Y4
 dZXHBlPZmkBDwjWb/KEKS1XHH0FbA==
X-Received: by 2002:a17:90b:3c8b:b0:39d:f064:3a68 with SMTP id
 98e67ed59e1d1-3a0bb57874fmr5569747a91.21.1790499632735; 
 Sun, 27 Sep 2026 02:00:32 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 021/101] tcg: Generic expansion of tcg_gen_shl_*
Date: Sun, 27 Sep 2026 01:58:51 -0700
Message-ID: <20260927090011.10724-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index 81854b56f93..773f1e16c41 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -314,7 +313,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ad298b7e306..3e6dd1eaf93 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8c3f7dce815..8d5befb75a6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -409,6 +409,11 @@ void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -500,11 +505,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-- 
2.53.0


