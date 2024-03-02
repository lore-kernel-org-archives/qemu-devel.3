Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2F1C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjz-0002zp-Ex; Sat, 02 Mar 2024 00:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjx-0002xN-5y
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:53 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjv-0007aP-IQ
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:52 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29a7951c6faso2074562a91.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356610; x=1709961410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N80bNyHooYY1s+fX14oiEH8Mu2Y5C8TRiT0CJYJBJ3g=;
 b=VVIahRiOmHnSrroc58MgPldVGAT6uHXk86c/tY9O5qXoqqDHb52LNVQVd53VF7UCHi
 hRUjFvvvbbBGhp4sSKtNcpMIF/oM5z26Py+ycVR8dR/dY23VXdUp9DZc7NlQ6LI8477r
 ewp3VAhsN3WdRD+pEibeyGArZJ0O2yjblD9jqNDRgDMQMiH/PdsBYvJfwHsVrmVIGBYT
 FNsOyvikSlwgqNqjXN9DdIHW/fnYRepXAKh0AuBbVhIrjd/kjJPqmAgwies//4KHYknL
 SeX8AwIdSGA3gEMY4xPM3Z8z4h9By2twfnC5nC2BxfEb74NSotV13tSwFnH1UgFSesUQ
 p0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356610; x=1709961410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N80bNyHooYY1s+fX14oiEH8Mu2Y5C8TRiT0CJYJBJ3g=;
 b=HLxVqjjMJviw+HbgNrMr7Y7wyLqrdKpBw//lE0SDu9isB7intOkUqAQHxoNKcKFHO5
 qlmeHxHQZUbxQoDF4XGF/87NhVyt/p42kMnk6fO2iOzb/xMxN5sWMB5cOl2+KlmAeoYh
 VcaldMmEVaUsGP5P2YQAdVP6hUM346c/4mqrra6H9S3VD9BzoDxW/ON+qCLRh1oyHgFC
 MTdHXqXOKK1x6IKTWkKeXlhN1LmZsajsWL7T/7II5de3XzqtjHiK6vJVyeQ6Ra9eZQEg
 Wzdqpyq8bQNomNFwsfDAp/gW+Ksc6I6Op/1RAQ2LNalfS4Uq/V8/AYU1/WVril7Sf9aG
 zE1A==
X-Gm-Message-State: AOJu0Yy7ILT19r+AsLuPlbqfc8Rt0BtmklfiRWJKntgvusjbFeReB9K/
 yk1bmFgxRyqS4xSN6aK6IyaFZUEmBAGI486uxt/MMGOgqwk0EF36S7yeTenqZOiDUZOcyjgfVCg
 g
X-Google-Smtp-Source: AGHT+IEzqZnPqQQMs8iBdvlwHRbLw2J0wSb9iaxrvDc6y0lJNfTJNo7u4mlIOQe9wM12SOPX7H2lkA==
X-Received: by 2002:a17:90b:103:b0:29a:e097:50b4 with SMTP id
 p3-20020a17090b010300b0029ae09750b4mr2890709pjz.46.1709356610250; 
 Fri, 01 Mar 2024 21:16:50 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 28/41] target/sparc: Implement PDISTN
Date: Fri,  1 Mar 2024 19:15:48 -1000
Message-Id: <20240302051601.53649-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/sparc/translate.c  | 11 +++++++++++
 target/sparc/insns.decode |  1 +
 2 files changed, 12 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 70d87a68cc..8241676174 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -826,6 +826,15 @@ static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 #endif
 }
 
+static void gen_op_pdistn(TCGv dst, TCGv_i64 src1, TCGv_i64 src2)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_pdist(dst, tcg_constant_i64(0), src1, src2);
+#else
+    g_assert_not_reached();
+#endif
+}
+
 static void gen_op_fmul8x16al(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
 {
     tcg_gen_ext16s_i32(src2, src2);
@@ -5063,6 +5072,8 @@ TRANS(FPCMPNE8, VIS3B, do_rdd, a, gen_helper_fcmpne8)
 TRANS(FPCMPULE8, VIS3B, do_rdd, a, gen_helper_fcmpule8)
 TRANS(FPCMPUGT8, VIS3B, do_rdd, a, gen_helper_fcmpugt8)
 
+TRANS(PDISTN, VIS3, do_rdd, a, gen_op_pdistn)
+
 static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
 {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1189ad4c87..e46c5f7dc4 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -435,6 +435,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @d_d2
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    \
                 &r_r_r_r rd=%dfp_rd rs1=%dfp_rd rs2=%dfp_rs1 rs3=%dfp_rs2
+    PDISTN      10 ..... 110110 ..... 0 0011 1111 .....    @r_d_d
 
     FMEAN16     10 ..... 110110 ..... 0 0100 0000 .....    @d_d_d
     FCHKSM16    10 ..... 110110 ..... 0 0100 0100 .....    @d_d_d
-- 
2.34.1


