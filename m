Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728CEC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpN-00081d-Tm; Sun, 27 Sep 2026 05:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknp-0004Rx-HO
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:10 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknn-0007d4-Ub
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:09 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so1122166a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499846; x=1791104646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tnuNK7BCXGd0v1/LjVMp4Nmyvqg9IVK3tEL3+akaqV8=;
 b=ppOAih9oRCIxGbx1qgX3s1yxSnETWNoA+wsrW213UQFtc4asJBppth1h8slIWJY6Rf
 YKGjn/q8BIPpJifhVNUlZb3C8hxah9ot3HTlMrqmtLy2aOtu7nrXtlodn0INso32mOBo
 X8MO3A7fCFQhSNVqSVdKTlRc8ULm4UksWglNSn1I4hKFMAYIvmnGA/ay6L5GgeXDNJ3p
 6Ksr48L87Vt9shoz11g0c/ulDegrDGzt6Kc7A9ngp+uG2fgOgeDk8fnhmgvQBDK5tvk4
 zDEHqIMj9j+D/5/bKqB0J4nhWnG9Ss+boPOXu4lhoc66qFmcwHSAlxbweizvfTO84tNC
 7yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499846; x=1791104646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tnuNK7BCXGd0v1/LjVMp4Nmyvqg9IVK3tEL3+akaqV8=;
 b=qhc1hF110VJ10h7SKfOjC1gbiWc+WRQ6V6njtbYIUB49KhJdHHDrq3Z6nflqt7LjkL
 ZIpU6pH1wQZRNzGrUvep/6rN6D9Ve8AZMQvHSxiE8Ow7VNE5ZEPzWu+JeNkA3bn7S2W1
 FxKNX7txUpLpx5Y/y2dlAUHohE7GvnsRwmj3HT064qYeds70RYMNohDHABKHF9gR3v5h
 qEBxHVmVwYvRpv84kGO4OKprV4cCaCN1+8j/nMseb1lESfjjhsSEu7fe+B8My15sJ/hy
 Fizj59F2Mp61VdqPUZ0Yay4QeL72ZTU2WCADO52ax6lqfzcfFketnWxeW5qzJ9cgta2B
 cPCg==
X-Gm-Message-State: AFq9FYKLZV2MjN7aBMjbzIZaeyMCRU0qtqYqb//xbMiMUL0X8ZrUKfpo
 dj0jR2D3XzFBBwwiESIFznKMXSMH6QoFgLatiUeLCueMNulo5XasE1eOJSm7OO2UhY5hjNtd5WY
 xWjsY
X-Gm-Gg: AYBFou3LSrbRjVBK5tkM8EliU+ULfjcm6oqsuUR2q91pa4H2faDFplh95/esqKfkPB5
 qXHurFvXe8S2o9W614vY1RXT8j+hsDxoysJC96IylcybrtL2vGoK8g2cZwdoPcn9VN7uTpkzLXN
 Dt5zNpv64aoiEwWFp3ZZSlZ98QxyCOMeE5xrORCvwt4wl8UMAxCpKFqPW2UPIjkBqIwea9hjSix
 v5StFKFKKsgpwbIrfN+UZYF0AW/nvgsdo+WDhu2aqEMKgmlWaU5q56l1znF5odaSMCQrJFT1Yl2
 VcVm70Zwjl7bM7txqt3DIujqQnVyien4d874lkoVGQG4Ml8ujVrhW32ZUHMcRnZQpd/9Xm+mti5
 83OIbcxRhzzyKI1GFnPZEAQva36Vvts47hWCr6FnFNnZwYGytek7v0A8CCLsXj9+njumGY9ojPf
 ACl7ShjV02QHgSJKzun1NaJcSOV2dWKvTVkzDqnCgJjtwe9kLsIQ0VYY91NQzxTRdpvhmhvhMHt
 gP5l9SbVnGpsCD8O6xtmlLOLzSqw8c=
X-Received: by 2002:a17:90b:380e:b0:3a0:bcc8:1544 with SMTP id
 98e67ed59e1d1-3a0bcc815bfmr5504825a91.39.1790499846390; 
 Sun, 27 Sep 2026 02:04:06 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 050/101] tcg: Split out tcg_gen_ext{rl,rh,s,u}
Date: Sun, 27 Sep 2026 01:59:20 -0700
Message-ID: <20260927090011.10724-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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

We'll need these for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 20 ++++++++++++++++++++
 tcg/tcg-op.c       | 12 ++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index cd5028104a8..a0edf112927 100644
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
index 35cffc6447a..6a5f77e9977 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2200,26 +2200,22 @@ void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
 
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


