Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E281C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAks7-00066b-JY; Sun, 27 Sep 2026 05:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrQ-0002BP-2x
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:53 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrO-0008Gg-79
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:51 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc79223bcfbso1027240a12.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500069; x=1791104869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=REfCEbljwD42oKESMb/2r/IzSCvlv/AMvn2Mo7n7qso=;
 b=PVE4QIhFBmGpmw0WBLdyZCk2ls1hhxgAXbF1XT7blNi6+D4jMZUkZOLbCPyNCIWl6n
 yiNtP60IO0dfW92LDa8Ur/T5sTC4pXxI7dABGJVshvRW0dZEc07ZyjiaKMqLIpcbZ8UF
 p16nUMOG2+cVp7+wvTZQ00YsQvVlgGcr7AvloX4pCdMXX3Lss1bCpp93fdedssV4GagD
 eEQw1IeyJwpe0RRGlu2td25kmDPrDX7hap8YbbxNFmhygwKxXMZNha1E9E4gAbP2J9Z6
 CcLxwavKC9/8vL+/EurHe5T7GTPD/vstLnlOn1thhwa7NAR2vB0/Z+WOrYjRjgO5N9NS
 a5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500069; x=1791104869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=REfCEbljwD42oKESMb/2r/IzSCvlv/AMvn2Mo7n7qso=;
 b=RDecR0br4AYhIwSgT5eLeFXXbEgSk4umQ7W3E9Gp8Ksj8uREHuR6Gp+LU39JlwCpcG
 7j4/5eRJEccsbSQ740NPUBguc79H5WTdt8nfMExk5xsx7LJ9ORFoS3yoREsd9IVX4UFX
 u3z5VNDMmBtlap+aqtIdrIE9wvZ+DSCS+fBtrpttvXBoRwDYsGaMqDR5/kVBSuvBrow1
 QmiNHtcLAK2HvVdzdCyamZLxy3TWsp9psOhqk2v3s2z6Wc6ZqAgw2+BJofchdu9aJn/y
 3B6/2yMDeSEfcNN2t1S/pH2QmNpPY+KlmaI3bQqVhfVre6suHR+IVOMC0wv/fPrsoEGr
 QzMQ==
X-Gm-Message-State: AFq9FYLU236CoOp1kdaBr6pBHi5zSNJa0gTkU4z+z4ar5LpspuBK3QFx
 R+KziEcNU9caDdSC/ij7PRWCvhY+BWntPisr4xvpm2T0U0p9Q4u3qJzZ6+HwzY629GHiaZshl9y
 im3oy
X-Gm-Gg: AYBFou3ujnz/aL/Gj2m4Al1v5M9bUIiMrK2ib3KujtSTrnzUDGFJ1bL0TFOxARFoO/n
 86ojrs1noAIhsDpJSayd41EC4zGMojD95LHYELsKLP2KPjLhFXPBGBVjOKi5iebJi+K0ubGkkKX
 JcpXg/Fc2302omHz6bdIlRDlsD3DWHoosveOJdHFAFnbAiNdMHgGjk1dM02o7fGnuRMuO8Lul0J
 uXMBsrMVYE/pZnObz+fYtR850A4Haa4bmIM7EcTPlmGzdrziXyTAnvbLuZiA3IVeCy+2NiMQAYE
 2lPmMMdlEmyiLTLl3tHUWsgxM0h8g7TerIZagHN33u2RRsd9BlPMioMnt+zOpG6fgut1Olp04Ar
 AG86Xfz9BV1fnevfYXeL7rzpz6U/eJ9q1qpKxrHYW8YLml2GZ31rBNzOr+IXi31TOgLdyMIiM8V
 wYxC2JnsmH0d8siWkYDidiFD6cuwp2pmXmdoSO6mkm5tG7FKf4RJWYB/H0ip3osSapyjzbaAm6c
 GN+qooNIT5P29R4B6bjxg/tkjvDng==
X-Received: by 2002:a17:90b:55d0:b0:3a0:4066:d3b0 with SMTP id
 98e67ed59e1d1-3a098e560e0mr8718465a91.59.1790500068695; 
 Sun, 27 Sep 2026 02:07:48 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 087/101] tcg: Generic expansion of tcg_gen_revbit8_*
Date: Sun, 27 Sep 2026 01:59:57 -0700
Message-ID: <20260927090011.10724-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
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
 tcg/tcg-op.c                 | 51 +++++++++++++-----------------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d5915ecc1bb..ed503462a2e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -135,7 +135,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
@@ -161,7 +160,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 2ebcf4a0665..ab1bf259296 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -49,6 +49,7 @@ DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
+DEF2(revbit8, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(rotli, TCGV, TCGV, TINT)
 DEF3(rotr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0c6146cfbe6..17f323b1b72 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -119,11 +119,6 @@ static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGType type, TCGArg a1)
     return tcg_gen_op1(opc, type, a1);
 }
 
-static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
-{
-    tcg_gen_op2(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
-}
-
 static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
     tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
@@ -1016,6 +1011,24 @@ void tcg_gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_revbit8(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    static const TCGOpcode revw[2] = { INDEX_op_revbit32, INDEX_op_revbit64 };
+    static const TCGOpcode bswapw[2] = { INDEX_op_bswap32, INDEX_op_bswap64 };
+
+    if (tcg_op_supported(INDEX_op_revbit8, type, 0)) {
+        tcg_gen_op_tt(INDEX_op_revbit8, type, dst, src);
+    } else if (tcg_op_supported(revw[type], type, 0) &&
+               tcg_op_supported(bswapw[type], type, 0)) {
+        tcg_gen_op_tt(revw[type], type, dst, src);
+        tcg_gen_op_tti(bswapw[type], type, dst, dst, 0);
+    } else {
+        tcg_gen_bitswap(type, dst, src, 0x5555555555555555ull);
+        tcg_gen_bitswap(type, dst, dst, 0x3333333333333333ull);
+        tcg_gen_bitswap(type, dst, dst, 0x0f0f0f0f0f0f0f0full);
+    }
+}
+
 void tcg_gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
@@ -1349,20 +1362,6 @@ void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_rotli_i32(ret, arg, 16);
 }
 
-void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_revbit8, ret, arg);
-    } else if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_revbit32, ret, arg);
-        tcg_gen_bswap32_i32(ret, ret);
-    } else {
-        gen_bitswap_i32(ret, arg, 0x55555555u);
-        gen_bitswap_i32(ret, ret, 0x33333333u);
-        gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
-    }
-}
-
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
@@ -1583,20 +1582,6 @@ void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
     }
 }
 
-void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_revbit8, ret, arg);
-    } else if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_revbit64, ret, arg);
-        tcg_gen_bswap64_i64(ret, ret);
-    } else {
-        gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
-        gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
-        gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
-    }
-}
-
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
-- 
2.53.0


