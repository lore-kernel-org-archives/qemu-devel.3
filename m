Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDC606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kn3H21Un
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsZx-00072E-Pk; Sun, 25 Oct 2026 03:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZX-0006Mv-AH
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZT-00044r-0g
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so12471915e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912989; x=1793517789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=81cVd6vlNEx84m/x65AgIvhiMaxkWZhWLK3PQuUH0Dw=;
 b=kn3H21UnFcOPm73NclBy6X/UzclK1opukj8oFB53eT2m0jqYfVnD+REXbJISIIIsGQ
 YhKg+hOPcoYN9whuZHu62zz1XLWfdoRlWl5MhEf7qaaFyt5EkoQgJvj93XF8ogvD2++A
 jiYAoVpXabh9eCb1wKPj/kcmzXITv8KknyT6LparcWVOEp7o3uFAbI2ecdIw9nu2dvYO
 ag9iz8ouyFgt8RFhuvHWxiaoY9gbK9Jfhn5qCDsI5/+8EJYz22wJxz8VL2WrpkDJLbZf
 sM9YUniZHHvQ1FsxAZ88uXo5EgQ5L3GAheSAMcabmK+ywjgIulPmPxqdXEldJrnwmL69
 EPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912989; x=1793517789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=81cVd6vlNEx84m/x65AgIvhiMaxkWZhWLK3PQuUH0Dw=;
 b=y1xq1TxFWmUeUrTGMAPEfDIookLg8jBHC2pghUFUsczM212ieKxUA6P/WDTbRSj6aB
 UyumeSqCCzqoqolwrNTyroBunU2HE5Q7RRlqe4DaiFhhPHiV/9AF8KQt3stg433sitd+
 ySz5QtTy9ge4RzzQjGzheycZeTDb9vhcp1eV53pX2Jicny26U/tVjG80wIh1EZkIQdV/
 Aw/qvhUrs0iC5WATIZZQa7OYVTIgucd1XO1V6Zv8z3bQXtXGB7Iuc7ohMUQjiQm/GyFN
 inIrD2yvqePYTFuhl21pCeMZiHGIfNqLLBG14bfMweQPX0iUfsMlsEVZuPvTUrZ9146q
 /m1g==
X-Gm-Message-State: AFq9FYLxQ9J5K4yfXhbLu98HIH5yEnoGGq53LHmjUmDGg9PPlXdMYgKr
 eW0bpr+hPJ9rCzFK7qPzaIFN4oLzUezC2TNsMkdxowC7IrshAA5QcfHosf6GtsMd4gJlXUewcDB
 MO2bQgSY=
X-Gm-Gg: AYBFou3vTs/isaOoRytLmbzmHrvnB2Q8WIC6E9UbtuHdHzjkIutyLGOEGJB4YQSZvwH
 aLiN0x7++Fl68WeCAMXZn4LP2VT5ll0y8uaBOtK8Z8NUmh4ktzWGvbZ2ZQiDiXHjBWvc5uER4TD
 Et/GSYvrXy6mOSvh7kjtXCwla3zHREc+/0CaRj4xxiN01QR69X0D5De8Yh4OzO+FzX3Wqk2iH/9
 sXUBdM9+EfFKqss+eY0+1trLVao+myr7hAezc9skdYOsffXDmc+8UmY52oi2KF8faH6Qqq2tfnY
 in74Iv+lZ+/g9MSQKLT62skl8XSIowXfkLxnumtaa9qHwfdv1EOhVYiq21oQ4zHkLW2lk7Dav5l
 08QTwqjzmaH/kXV+9Fm/hy+oiRoTDET5mBz/AhWZ/KxrGdleRUf8EEPPcmU99lwd1Kl/vpolSAP
 ZwUXoUti2Id2NczpxDrAtUB81mtZt3ayOqYw/pnKXKS9f+iihNgW4tA7uHJDfoFL0FBYehSevvC
 z32uE/PkaC109CXHiAdaHrfhH4ZJ248ppjDoyCERUiZQyrIPKCGTFFBq18=
X-Received: by 2002:a05:600d:82e5:b0:4a1:cd83:b23e with SMTP id
 5b1f17b1804b1-4a35aae3e29mr77955055e9.0.1792912989409; 
 Sun, 25 Oct 2026 00:23:09 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 048/100] tcg: Split out tcg_gen_ext{rl,rh,s,u}
Date: Sun, 25 Oct 2026 08:18:23 +0100
Message-ID: <20261025071915.1123867-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

We'll need these for other generic expansions.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 20 ++++++++++++++++++++
 tcg/tcg-op.c       | 12 ++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index cd5028104a..a0edf11292 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -183,4 +183,24 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #undef DEF4
 #undef DEF6
 
+static inline void tcg_gen_extrh(TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_op_tt(INDEX_op_extrh_i64_i32, TCG_TYPE_I32, dst, src);
+}
+
+static inline void tcg_gen_extrl(TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
+}
+
+static inline void tcg_gen_exts(TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_op_tt(INDEX_op_ext_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
+static inline void tcg_gen_extu(TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_op_tt(INDEX_op_extu_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
 #endif /* TCG_INTERNAL_H */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ed7dd8c7c1..86f0c68c94 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2198,26 +2198,22 @@ void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
-                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
+    tcg_gen_extrl(tcgv_i32_temp(ret), tcgv_i64_temp(arg));
 }
 
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
-                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
+    tcg_gen_extrh(tcgv_i32_temp(ret), tcgv_i64_temp(arg));
 }
 
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_extu_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    tcg_gen_extu(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_ext_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    tcg_gen_exts(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high)
-- 
2.53.0


