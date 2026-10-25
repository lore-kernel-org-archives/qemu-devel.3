Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36C606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j3xaC5tz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsaC-000833-IW; Sun, 25 Oct 2026 03:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZZ-0006Su-4f
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZX-00045Y-6g
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so619125e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912994; x=1793517794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FM77TgtzMIX48du0AbuYu78qiXaoqdD6jpxoCKpryEE=;
 b=j3xaC5tz1j0W5SAJ3jmLOZ6rmKKaGh/MgbMJrecp8LwBFv7CdTT7Ox8kvU+I1wxWOe
 Rf4mOz9InEANWbcWhkPjilxvZuGSdV3o6MEUwhAFjGks/R/K2pkGhIuaxh/12WN1p+9K
 2ZOs/Gi2o+2AblrBMIE4GIrpjDvVQhbnQSoSDzmlDreJGydTzx7/HMt7VVLbJQ1KOhcp
 xowzMQpTPFpCQ96m5FLNc/tSWPKG2R+WrYIBriCcphFXqXY+jFhawwDjTlVe2VbGJzfT
 +efsKIwsgeydiYfTDQrQAki6unMJAVSo4Uw4iFcWRfE1xtY4RcgQX7zko0Ltr7ngM1nh
 JB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912994; x=1793517794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FM77TgtzMIX48du0AbuYu78qiXaoqdD6jpxoCKpryEE=;
 b=1zdKFlbyBP/MK7Smil5uZWGiecipIc8dXejboN8TKv1AXkeE3r9UbopUqYBXCDfg76
 G3iGgz0ncP16DMhEVPlvzrQcTNFPqBqJTkvpk5aefUbBD3ZIiuME7W3W++ad6tK10Mg0
 81y3gSuQWCH/0nGoqc6pp5miBWf7WGn9H1yNqfK7LxXzgb4jNhbZV1T5x3alnwvkI8p5
 a4wgRENvRD4RF74At3DdqZFaeTmiQv6CD2gDh0kjLJnFIabe4lIr1pkI4M4yqnbtH6rv
 2PGpEIMMoATCd7/zVGnq5fjK8Qc6q2PG8BQpATI6bh+dc6RZi7/RprJXbtHNCCbVfCU/
 XeKg==
X-Gm-Message-State: AFq9FYIMu2sz3Tz7nVLUqrVVMTvL11PkUIPe18/gdtpdAv3RLw0oPVUp
 pYNGwONc9aiIpNhgJ5OOB1hwhSpYLlz6J5PFphV32z7usWZ6isLgR6wcs96QM0SCb3PESOLZADI
 +oiF6RYo=
X-Gm-Gg: AYBFou2EeeuYJPGakgxaZ4HT8boafd+IzD1gVhfAYyZ2VEqoI9AZgdyYDrLdljgkdQP
 mE8d0DXQ64gtNZaDOcsFVNwfjazco6Ba5G5+lj6soiX7V9SVfUYuynEq7rzgUo2kPEZQmp/WH4R
 ogasadGeReIkpwxDj7zynHlk7JI3/lwDGuH6PSxxwEor3lZshhtHKdxQm+smq3N3gnVogUH3U3F
 dRhPhBVJyTIAZM5IlV2YCEWJjx9VXIw8KObQI/MBMTTVlePJ8rfWFA21XJKWI/DyRKIT8mlSzVz
 0usk0umcRslmp03sjGWovmmIZI5LxVp+8TZR22zTs+54ei2njHKq9pFl8K/KL3fV/uJ+oZAXC6b
 ds3DrrGMCRKur2/xmjtEZvPBYRYRIxvPNjK3RVOvA6CMM6qjtQ+7wji7OtcLmjRY8B9o3tA5UdX
 5b5i4rfJfRGH3HvmwrO6m5eBETL8kFgFMX99iAJMNdmlqP8kzgEBXs6CDOhRFbiwM9s+CDtZPgM
 9dzRLIZykWXAzfukGDD8tlJ6/53Fs66AcoijjjubG5/vnwQMdh9ZOQf4yc=
X-Received: by 2002:a05:600c:3b82:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4a35ae71a3emr62712325e9.6.1792912993612; 
 Sun, 25 Oct 2026 00:23:13 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 053/100] tcg: Generic expansion of tcg_gen_ctpop_*
Date: Sun, 25 Oct 2026 08:18:28 +0100
Message-ID: <20261025071915.1123867-54-richard.henderson@linaro.org>
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 41 +++++++++++++++---------------------
 3 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d68362fd02..8c1b7a1968 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -191,7 +190,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index cf832a6dc0..66977cada1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
+DEF2(ctpop, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index efbbe4d8a1..bad47af1c7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -450,6 +450,23 @@ void tcg_gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     tcg_gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
 }
 
+void tcg_gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
+        tcg_gen_op_tt(INDEX_op_ctpop, type, dst, src);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_ctpop_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        tcg_gen_extu(tmp, src);
+        tcg_gen_op_tt(INDEX_op_ctpop, TCG_TYPE_I64, tmp, tmp);
+        tcg_gen_extrl(dst, tmp);
+    } else {
+        gen_helper_ctpop_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -826,21 +843,6 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_ctpop, ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t, arg1);
-        tcg_gen_ctpop_i64(t, t);
-        tcg_gen_extrl_i64_i32(ret, t);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_ctpop_i32(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1731,15 +1733,6 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_ctpop, ret, arg1);
-    } else {
-        gen_helper_ctpop_i64(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


