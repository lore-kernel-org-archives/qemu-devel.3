Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B9606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j6tpjeKb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWa-0006ww-Th; Sun, 25 Oct 2026 03:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWO-0006QU-Eq
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:20:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWL-0003ka-BH
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1024383f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912796; x=1793517596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vS6YeJU7fOaunMZYbE/QxQ0oiW1DpBl2NhngJLysgvs=;
 b=j6tpjeKb8jso/oEPHDwM870lMPP3Ll1YPW6XB9TAiq4438Ovp316wFsjUSeLnClqPM
 tE8M3m0WD8EQ1+Bo9uAwRGKNtf6Atuq9w3A808bWx+nwbB4WXYYEbTE0opg5+QsbHbm5
 TrOzq+BU1ggLNptki8swcvvyiFcUYrTVEGQUh4rxbvoLq0fn8r2qV1fEJFNFH1IiXVtl
 5aJ1CVx6iXdauaMLqcdmDWX+b7mDIWJMp61m8ann2ijuBU2v6ofZudcLTy8ultm/uhG5
 zcpfCiGycxM26BanJYzsMseEh+R48XhDMFycIO9AUdsEjr7+naPXKkJa8+fXGVWc8GPG
 QEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912796; x=1793517596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vS6YeJU7fOaunMZYbE/QxQ0oiW1DpBl2NhngJLysgvs=;
 b=V6X8JQTVbA/l2hkZHHXtQD0YvEzi5fHVKJeSu+RTTU2lcHaeYaKjhlY2v90DCIVrIB
 rqQFvh5th3CmeSg5CnSzc4mWx/0bJtY42ywZfm9u1LTUKfhhCgZ2mt7Nr+aTkW/VmDHl
 yC4xsrUyhirrEBi5oE0KT9flXRvvDQIh113aAzA+yC3Liy4PudUGGKmgm0tbmjmBrUyV
 kxpan6Q1o94Os/7J2cwtgZDCKFi1vRotN1IZXf8SBwHJHTtUu/U0MSznzqP/9wCm3JSW
 T4Ku/ca40p92gYOdruukUmG0hEWwiCNNQcNbNh33uRGSGQXO/jK4tyCD9fX50z0AkXyX
 jkjw==
X-Gm-Message-State: AFq9FYIMMWdiIKWKG66mVz0ye1i8jNHTfj6g2rebR1kWLIcX+kjgRoh8
 ItAAuDt3NXLUUZ03bcuPbK7zkJDthrSqIEWygAZwTsOKxnKHc9wW5lxjjyCP39wucV5KjZB7jym
 QBS4VzsU=
X-Gm-Gg: AYBFou0fjrm5K1awF9u5ao3+MfsJ6SvDKDmLcKwP2GZ2PMBmpMiXTUeNPpJAO7Q0trZ
 BczH1XbtG4/4gUwHfXwdXyIQUJwQ/yDpy9k6pVzqN4bX7BdErOx8srjsuG6dMLge9nPnhiQWdus
 HdKVouZgLS7oBjmxY6qyXGWTaZHnz37HxehK+745jlee/ySE0pOF8quLhqGg1QlbXstrXsP2S6k
 IMj428/x5CSwjFqSiKmc+4LZBkpXtjp/RHceIYdX6YHO9oecbp8pZf4DAVe2KaSWWdyWQVGi6Jg
 h0Gz3KfOXyTFrJ1WLcbM9f3YfbI27sDSeiskGhEXpY+AW7lzQBMgOhEMdl3NrjPEyR/NZVpzDNH
 o9drj/uzCv2k8XZAVTM4pu/kWCiI01QHbUAKzPWzvZUoRTcvCmG6rIkekI/VYwatEI28oLk4G00
 j6WOOJzK8Nm0ZhvWfg0f2DQ6Yae1XcOkj5Ec0h7g7+8n7G10pBRAOQ6Ig0pIBo+368QAFH+KDwW
 aJmrv9cEMWXaqrHWpWwfvLc97zXVMC/WhUPbDMjyfi/lZkZNxZbJbyIfg==
X-Received: by 2002:a5d:5d10:0:b0:48b:1a0:5630 with SMTP id
 ffacd0b85a97d-48e3eb9e397mr5421411f8f.41.1792912795863; 
 Sun, 25 Oct 2026 00:19:55 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 034/100] tcg: Generic expansion of tcg_gen_divu_*
Date: Sun, 25 Oct 2026 08:18:09 +0100
Message-ID: <20261025071915.1123867-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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
 tcg/tcg-op.c                 | 42 ++++++++++++------------------------
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index eb090984e9..9024963c06 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -203,7 +202,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 50d725b72c..1b108d9f14 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
+DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e194c33eb7..1bfefb9d65 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -425,6 +425,20 @@ void tcg_gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_divu, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_op_ttttt(INDEX_op_divu2, type, dst, tmp, src1,
+                         tcg_constant_internal(type, 0), src2);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -643,20 +657,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
@@ -1537,20 +1537,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


