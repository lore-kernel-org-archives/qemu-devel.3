Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69431606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G2la2ks5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsW9-0006Cq-4j; Sun, 25 Oct 2026 03:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVx-0006AZ-Ps
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:33 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVv-0003gH-SL
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso15860355e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912770; x=1793517570; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dVQVNe5YJsA2vdrMgRQXLNByFU7IDSxYbQUvMczJAtU=;
 b=G2la2ks5M3UXrKU52hqdswIMTABLMGSPWS0/82wUI1Y0dx8XqCxpiQWtKeTms+D0Ld
 uS6bX5J6l6o9uLuRLAcnx8FUbTp8E6jy/Okg5T2yCHG8ZWAy5ztWJTFRXMCkeyN9W65W
 cgozK2hvru5lVRjFereTRf29Cwwv91ot87f81iluIZsD/tD/a79m/Z1JNNlOvNkP3Alg
 8DcK3Iowfk81uBjJ/LNEMYGyVoFFNkeZg7Bf1zW20PUFJGed6K8PwHYLYDSdFJtrex0j
 O8nq67IBliVF1+yk7isFmQ/PtqQ3naZ7jwNrQn02KMZzJffT+lDOxLbRacpnFTx1qml0
 9W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912770; x=1793517570;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dVQVNe5YJsA2vdrMgRQXLNByFU7IDSxYbQUvMczJAtU=;
 b=SUpjFzTy5NAdERo3iPpbJeOLQ4eXPrPLAEMiWriMXty1w0LMtU0fTG9oI3FkSef4Tu
 PW6ltwd5gIEMCox2uJ7AgEl/0IEZeddsl4Pw7sRRdprOtBeQSke7TZOvNJ5o1qFOppQd
 jQ325TOhO0VZQrte/Qb7vTZiYLNMNyb7HptfnUZOWex0N8nIiGL7QvoKmHSXbHq1bZ1L
 k+OVU6vWxKGP3e7saEE13sEMCiYB9FbcYDys5A4MwTBdHEgAr5HQYR0uVAgtnXbV95ww
 F9mc3pJ/LUrfZhVvfclHDg/WIrHsEE401FDczrdt+i4u59VtjrB5ol+AeJL4462WT/R9
 ewvQ==
X-Gm-Message-State: AFq9FYIsXCUceEyi3vcZbb/qOKpnunWfCaOjXSz2cvtiS1LgYGIVnSLR
 XFvz04XLQG/EhB4179mHhaSvcTSXp5emRGHsuEZDFGPLyYtbfDqZ8WhhDozAysBf70SGBlIItX4
 Cead41CE=
X-Gm-Gg: AYBFou1iampy7TuV7pybgsMBiZgbZYDD4zxCPbq4x6BC1eAjPXiitV5g990/2fdaUmv
 +D27WtEuwsqRsUc5NO2CsOJkZ91Wq06Xh7sd2v4nyFTTNGz+izJbZyJpUzYgkH43i+kCZ3gOJE+
 NBShbity3CqtJYNiEwl25L3SrzQ3jZkaejWEcyQAXC6ijepFaWYM1qqWYHzaEOXwVfAToElHYa/
 S3QgZK1sjasuMOcM4efgbbujesgrwv6PYwsf+dCjVh3F5pnjBQ8tOzDrGMTl5QOVuD5fgM3/QbB
 q8FeftB3f1shc2k78eC8PJddCwGVsSaxSV2Q/amdhd9g3fQfDYXoG7AtUq3uRneECKa9IXuTTli
 8oB7XlVw6MFLuzZQF9tHnhrixeLzud7jPdQcFL5Gs1Iqpf3EaOlrkiY6G0Ipolne4NApJATfWBx
 /naFfMamYcU4w7qTIHZsSt77CxaLvj8MwV3m/9WdEY3pbW0wEXI8vMCV/t+s9rIXRwloQT7BTNt
 RsmoVvs67Q00YwWaPAOE33MHUh59XVgThS/p4H/STiAtf0juTG4qvzOxEo9jTFTJ0s9As6tX0lg
 wJ8=
X-Received: by 2002:a05:600c:3f0d:b0:4a2:cbe:bec2 with SMTP id
 5b1f17b1804b1-4a35acae79emr56882385e9.32.1792912770370; 
 Sun, 25 Oct 2026 00:19:30 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 008/100] tcg: Generic expansion of tcg_gen_movi_*
Date: Sun, 25 Oct 2026 08:17:43 +0100
Message-ID: <20261025071915.1123867-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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
 include/tcg/tcg-op-common.h  |  8 +-------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 20 ++++++++++----------
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index deec10159a..9dc05cc7b7 100644
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
@@ -559,11 +557,7 @@ static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
 }
 
 QEMU_ARG_NONNULL void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
-
-static inline void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s)
-{
-    glue(tcg_gen_movi_,PTR)((NAT)d, s);
-}
+QEMU_ARG_NONNULL void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
 
 static inline void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
                                        intptr_t b, TCGLabel *label)
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c76e83396a..e55a9f9993 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -2,3 +2,4 @@
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
 DEF2(mov, TCGV, TCGV)
+DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4b8dfba8a9..d7272b08cd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -370,6 +370,11 @@ void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
+{
+    tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
@@ -377,11 +382,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
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
@@ -1444,11 +1444,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
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
@@ -2778,3 +2773,8 @@ void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s)
 {
     tcg_gen_mov(TCG_TYPE_PTR, tcgv_ptr_temp(d), tcgv_ptr_temp(s));
 }
+
+void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s)
+{
+    tcg_gen_movi(TCG_TYPE_PTR, tcgv_ptr_temp(d), s);
+}
-- 
2.53.0


