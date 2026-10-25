Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371A606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qmigRQmb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWS-0006b2-8q; Sun, 25 Oct 2026 03:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW6-0006Ct-51
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW3-0003hI-8h
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4956869750eso13351715e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912778; x=1793517578; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J7qJqQpSz42EfXVyUtQthN5h6odQwA7lM0XX3MkQDdo=;
 b=qmigRQmbEc2AlioquZyghk4uieq6go7Qt3hWxYYl2WbFkQovKAB2v2T1bySoy3OJmw
 4QxNefi3LzixkQJmmw+3vK9KqAlI11NY3DkM3brUncGQRsF00C7Bpwb6XOokurR4J5T4
 ROD8oTpPhS6vFFCKcCGRMhHvlRn/fCrkUnQB0GvVTgzmm/oY8fgzMQ9MZvLs+SuOfKJ3
 oNzUCgxAiZ/xsvAhkGbhLFKyuI7cblBifhCcgMQK90PcRvsUwLJDSkJf8iE2demtmB36
 W3tqpPty5b2W+vCWa72mONuqfgMIqDWNqzoShZcy/6zyFqytVQJiwbea4osOC4dX/t6U
 MeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912778; x=1793517578;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J7qJqQpSz42EfXVyUtQthN5h6odQwA7lM0XX3MkQDdo=;
 b=gcJsOZ8cmja5hXGhe3VSF6I+IscDN7/7gy78/Uq1+ihGJi1nhLBE57eRZtSKoizdwO
 THEa0Jd7bzFaMd9hB/bpkD5LjOkvnW98M5a9mhfeCs1C7RECqVvDYEWskjpINrQWsLOo
 KZYX8rjHHpxbX4T46LG+lDSnUQV6P/gx/6S/rBIpUosrceEZTpAUJa+xyNnfScBeP43E
 gPqEhJj9jHxC6LaYOSzFVW9TgkLd2JRjwPPfmnqTv6xQwXvRup4QwP7znZ2I/+7Hx5/N
 Mafhz8MV+0Koln/s9O3hM6zrUh+ighLEYT+bbhhjePxVCDNuC5feIr97qTkFWVS6PMcW
 bPrQ==
X-Gm-Message-State: AFq9FYK9Gz9cvVHQBNF2Sbd3Apd2rzsWaF4Y342jVywRAtGQPoDlgc5O
 a/Z1YQMu8Gmh/6cbD3QEQX3ruTZHNPmpjZgVyRrCEnjbBjL1zi7n7xiFHARc1UPTU4sYq0LY07C
 SiML8JQI=
X-Gm-Gg: AYBFou2Mmfy9Cr2ibC/DT5yD5wXdfmmZZPnYsgINifbzZaOKWk82CdnxM1fRzuHyNbK
 xTkRya6atOxyQl3yYOX3Gzq4WugD2pxQp2pPFSDV/CVPaJcbKpBuSCnDJo+yRZ44ny550L90R3t
 QzQX6X1wU309dNQJIP5XXAnCECW8+yno9NBhp6Vturco2bQiT/q1wvE6lR8VtaOcPgy0C8qPxzq
 ndJzJLwsCaCRK9JU479nFG8pbTMZbw0GB4orIMKUMNYYRV6QIN0UzJhIUee1mffqiAA3/3x8jqJ
 BIj2LhGSlpmRiH9NmUW0LCetts+3tsu5iLQriVd0tmiox7FV6TPTNtAjdDunMM6XObA4TnJaYAz
 tUXmDvkHhYFND2tw3F5jkS/KmBhMTQbFoMrAYvwnhDROBc6Q+f35xLINmgYwuhqPPFZY3uHbOOB
 FOZi+oW/0PPh2wjLfB30sUmRngI97dEPPrY6Vi6dM2VRoJ5201szgluC1ZIdah2EUEM6l6SPXpt
 x+gKUfOJoJvzQpgRQwKQJAdG5YPifDEoT0KOWrijZaW6DKXLMD9NVfDtg==
X-Received: by 2002:a05:600c:a03:b0:4a1:d992:9476 with SMTP id
 5b1f17b1804b1-4a35ac9f30dmr59931275e9.23.1792912777670; 
 Sun, 25 Oct 2026 00:19:37 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 016/100] tcg: Generic expansion of tcg_gen_and_*
Date: Sun, 25 Oct 2026 08:17:51 +0100
Message-ID: <20261025071915.1123867-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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
index 03f3cba216..54ed9c9f6e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -317,7 +316,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 487ee5936e..d6b45004a2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -3,6 +3,7 @@
 
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF3(and, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cdb9774ca6..4e7ff03b34 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -377,6 +377,11 @@ void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -420,11 +425,6 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-- 
2.53.0


