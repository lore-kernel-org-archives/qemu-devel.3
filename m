Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F66606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qv1j74NK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXIR-0000Fr-Vd; Wed, 21 Oct 2026 10:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGf-0006Yh-JK
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:13 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGd-0002YV-J8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:13 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so775736f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592770; x=1793197570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j3PO2zbs51T71/e6CA+NAU1in9lZ334YbsXX2W3rrzg=;
 b=qv1j74NK99AYYe1GJL3YOvWjMCvwWmD8110nsXxdUiSdzGyNXKTJBMRinBeFbvQhoU
 ef1l++8KMLfQWjO4DKjNx6RMRuomJAhTCxgD1a75qL/syZ/iw5JPqz1PGjj9F9w4WMUl
 0l0n9CpunfCekBqWftJVxMo6TCIn6risraW+g/mPvYv407nJtV79/5H0337k4a1jgg4q
 7NN5eKlTkZWxURrju74205bVQZD9Hh6h2zsZcsp7lxqU6MR6uCal50XRYk4SCVPtspeu
 JK8UIvRqdps8rXYv7lXarG5InMYV1cv2fzCHdipxCav8tFOGbrxWH52U95P3oWlfQOIo
 dJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592770; x=1793197570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j3PO2zbs51T71/e6CA+NAU1in9lZ334YbsXX2W3rrzg=;
 b=zT9fjO1E4qFrLGUntCsUu24Qd7K8mXNISvu6fxElCfuvdd6Lnt/t95GC64DQPPtd4A
 htKCsV81AFCkt5PizqEaccthy5IYPyiI/I8ivPZ+40VVstzded6iSBzPGVg5AK3V6JxY
 DPx5N8ExbggKoUoIDfpFoH2KUoOo6CMG327aYVDX5Utx0twhHOxxxLdbegH2vC3h1Qle
 jXlCpf8yVRFsv2mxOUY9fvL84J+nzzxO/9psS7ghdCnNS/9+/IQyg34PMBXI+lHW0VDQ
 jgYrfww5TnFJn6cr2naEivInn4cf4St5UmwSGw+MJ2hv5fFAgf0x/YuXTEfrt4zR2CQ2
 GpPg==
X-Gm-Message-State: AFq9FYKrHvMAY13HJdm3F060sCdchPrmpoPI5r/zqUteCP3xx2A5d8mQ
 itT/1O3IZJb0i9RzZpqKhzr+ihWakwGLLESijKvDLjZVwZymZYcgpk0xEo10N6PBECQZda0n2Nz
 gGp4uEyk=
X-Gm-Gg: AYBFou04sQrz41EmNVCRW9JZCcethc6rXmL2860wNfLCPLsRsE5lj2UUHmPSVOwedoN
 5XwVCnLwrtvHY3/JkTFnDAUyCvqhiQs0zZV2TqPHxqKbRflM1/0UpXRW5rd/RRgdf/OZnFQKLJd
 xsCU+rWhVRGIp3HBc2356rTthTCE+gW5H+S/bnpQOeusoqyCO83DSlba1a4O4mtyPF9jb4FeN+x
 Qv5O3ceCZwLFYCoYpig0nsk3JFh3ivoBfzjitw3+8Vb45cKX4eUa6RAwH59v928f/dZuW1ZKhSh
 hBPCg6svqUqq8FAGJIYbSYw3YQsfFxpVkKlkI3xtWVJ47lHmJSAnt3vQYwBMM2u3yOVLPNQXSgC
 bviQdthy9Eb1bJHNajwe6zElJOsnE5Hm2Fr4sYepdeQkCUUyK3VTOk6YjTsg4mRn2dfwi7qxNAx
 l1Wms8Srb0Td62AENcF5iIBBVEKmn26xbHgiBAXpIVGpivUhqHehQ/LXrRK55EAqhHe6mrqqTRd
 imCPw1Usxtu66wu9+hbWTY63NLYlQS4QJV5FLManHkX0tMt+8CWMeDWxlWbECmIrmlZiqFtRRfM
 cMW4Ev5EPqeRImB7F6FkChv2Mog=
X-Received: by 2002:a05:6000:1789:b0:48d:ffcb:28e1 with SMTP id
 ffacd0b85a97d-48e264a6351mr4802417f8f.11.1792592770023; 
 Wed, 21 Oct 2026 07:26:10 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 089/100] tcg: Generic expansion of tcg_gen_ld8u_*
Date: Wed, 21 Oct 2026 16:16:41 +0200
Message-ID: <20261021141652.363109-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 32128ad997..744211c4c6 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,7 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
@@ -168,7 +167,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a110e64510..75bb38a07e 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -33,6 +33,7 @@ DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 749e0d5f06..74ddc74191 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -780,6 +780,12 @@ void tcg_gen_ld8s(TCGType type, TCGTemp *dst,
     tcg_gen_op_tti(INDEX_op_ld8s, type, dst, base, ofs);
 }
 
+void tcg_gen_ld8u(TCGType type, TCGTemp *dst,
+                  TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld8u, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1384,11 +1390,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
@@ -1417,11 +1418,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 /* 64-bit ops */
 
-void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-- 
2.53.0


