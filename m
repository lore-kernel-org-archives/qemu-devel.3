Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA693C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBQ-0005AN-2U; Fri, 25 Apr 2025 18:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7j-0005Kz-SY
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:20 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7h-0001NI-6I
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:19 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2243803b776so48115525ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618535; x=1746223335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dn3ql/FiObl9BE/j0TWBEIvNjDAyjPMnxmlG+GZsUT8=;
 b=C6+BFlgOuqCRTomhd96Vx2kxWoqq+iq/xtnjSapj3QoDaBB76+ICBiRzkj4mcxE67S
 cyV5zZJ0aN/a3Qpa3TAKHu1j6EIbzh5fQqgAhsmbVY47YHNOdu/4Mzbl1NLpk6pXN+gd
 HF/AfvPw2/nFGHzozgbZSpkVITk73Q/WqpWFaJ3LATMR1Uyg1CJLNr3ccrTmXJUlLRry
 /DmB2l7JmxE1+lob6dmC+AFYfET0ypvtLV+gcinkPoOayGt3ILxRzkjLYZdFBmuUVvQ1
 NbBCp+adrw7K1yNQIucKeHSTXYItlHv/q08quMvCnCNlKXZKxltWJjn7Ig393agDqEW+
 smqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618535; x=1746223335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dn3ql/FiObl9BE/j0TWBEIvNjDAyjPMnxmlG+GZsUT8=;
 b=nUV3YkGfulnQ6cL24eHfdY2L8HRsl/4wEjbSIE84pl9Q+fTeHdZjYGhCzjI/NEBv6q
 fNj+eLF6TQH1mFmd18H7a5HA8xu5rcYvrepDiQq2dRVVjXcM1Wt/9fC8sIkQX6evX3o3
 kk5Gdxt6T6qSqcceCXc/XKr2HtoSSPyZBRxfaN/9mQfQIDGx2QE6gV7uRmQsb5OsH2cx
 CMNV9DOMd+UAF08GO9DkRHS97/2ZYnCUFbuqzsmIJbeO/9pW4pFsYZrxHPTdHpNx87Rz
 xuh3Q8LtUM4HeyzsL5n8B7qRxcX0oTDic8rxvBC76lwGWdPHhyzfriVCh8Z0ri3fr342
 NFRA==
X-Gm-Message-State: AOJu0YyyZMux20RDDQpq/LaItfcVt4FWBDNBUTIdi8QuqoqbMJx5CN9r
 2ckYQJ4fRqrgr8lVvyXyhb9FT2vAzFdC0pZCkB4kkTFgpxSAWhRcS1dg6y/fpM6EhEfwRkIRG4G
 U
X-Gm-Gg: ASbGncteSrgIRmAvEQl2TJ8vWHC2usrhfGYE2D3ScbP6HhFXAuknxqP46Jh00ZRuRrt
 I6SvnBobmE2ouX222E92mTvQACnXqd7gPjSMMRfPnmNirGEc1f+Z98kTQ6YFLvq/kAmpUlcM685
 8LGYdgPzwTFLQU60KxOlDoY1NQjgNadq9VsY+0AotDpwD5zqeJaFlv4K9IC1UyoNdxsYguNqFRJ
 NbpsT26Zgq2fMlrnKU2+MUYXAU6XII1uOZoqw1GJl3duiHTH+xIGAlQg02/RE8boFhjQpnVIVo3
 5eL6s1bY5Sz2bNrW97BGgD9SkPUcaLVaBkpGb11Uhh3uNznREkC0xwESl+wDcqesJ/+8mn+VMM4
 =
X-Google-Smtp-Source: AGHT+IEuNVztZ11jfNuDWmFHpKNiALRxOCsEDnTo6v+ouIAvNWi9qryQIP46nGPgTHxu/sph/OaHyg==
X-Received: by 2002:a17:902:cf0f:b0:224:910:23f0 with SMTP id
 d9443c01a7336-22dbf634d89mr53466145ad.49.1745618535129; 
 Fri, 25 Apr 2025 15:02:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 106/159] tcg/aarch64: Improve deposit
Date: Fri, 25 Apr 2025 14:54:00 -0700
Message-ID: <20250425215454.886111-107-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Use ANDI for deposit 0 into a register.
Use UBFIZ, aka UBFM, for deposit register into 0.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |  2 +-
 tcg/aarch64/tcg-target.c.inc     | 29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index 1281e5efc0..2eda499cd3 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -18,7 +18,6 @@ C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
 C_O1_I1(w, wr)
-C_O1_I2(r, 0, rz)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, rA)
 C_O1_I2(r, r, rAL)
@@ -26,6 +25,7 @@ C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rL)
 C_O1_I2(r, rz, rz)
+C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, 0, w)
 C_O1_I2(w, w, w)
 C_O1_I2(w, w, wN)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 62b045c222..dee4afcce1 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2572,12 +2572,39 @@ static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          TCGReg a2, unsigned ofs, unsigned len)
 {
     unsigned mask = type == TCG_TYPE_I32 ? 31 : 63;
+
+    /*
+     * Since we can't support "0Z" as a constraint, we allow a1 in
+     * any register.  Fix things up as if a matching constraint.
+     */
+    if (a0 != a1) {
+        if (a0 == a2) {
+            tcg_out_mov(s, type, TCG_REG_TMP0, a2);
+            a2 = TCG_REG_TMP0;
+        }
+        tcg_out_mov(s, type, a0, a1);
+    }
     tcg_out_bfm(s, type, a0, a2, -ofs & mask, len - 1);
 }
 
+static void tgen_depositi(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          tcg_target_long a2, unsigned ofs, unsigned len)
+{
+    tgen_andi(s, type, a0, a1, ~MAKE_64BIT_MASK(ofs, len));
+}
+
+static void tgen_depositz(TCGContext *s, TCGType type, TCGReg a0, TCGReg a2,
+                          unsigned ofs, unsigned len)
+{
+    int max = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_ubfm(s, type, a0, a2, -ofs & max, len - 1);
+}
+
 static const TCGOutOpDeposit outop_deposit = {
-    .base.static_constraint = C_O1_I2(r, 0, rz),
+    .base.static_constraint = C_O1_I2(r, rZ, rZ),
     .out_rrr = tgen_deposit,
+    .out_rri = tgen_depositi,
+    .out_rzr = tgen_depositz,
 };
 
 static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
-- 
2.43.0


