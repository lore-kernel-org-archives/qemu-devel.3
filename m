Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C4606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w/o7XwLF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAG-00062V-SF; Wed, 21 Oct 2026 10:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9k-00058g-TP
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9j-0001gG-1u
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a2001dd4e7so6735855e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592342; x=1793197142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gINRv5PadbJrtxLn743KU4KQnYJRr5DWjdAlQ9uczw8=;
 b=w/o7XwLFRqQ95oYSmFGB7DxaeSmocSWILpTTnQdqItTbqgy+K7no852B390TxOrs/Z
 N6zm6xlkgzrFyQ/D7yzQzUIayj6aIUv3TiDl00YNoYccPtXpcUvN1JIw4AwCH/9pqFtx
 P/jGTrbYt+MKfhYdmX71SC3KfOBRj+w2ckPguBZYzds1+aawKoycfh3neL6WpxpSvbLA
 VDnXM/3uvVuQjUNt6/y2nowHJvGb2fFN9AGILOxRg5zxdpE9JVtQlPS+RXAJI6jmravT
 q8mg2zUg7tt5iv7OXVHdVNSS7gY1+Cmw3lV5bBMelwFChF+XNQOIxjtRbT0cxGF9n8kF
 i/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592342; x=1793197142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gINRv5PadbJrtxLn743KU4KQnYJRr5DWjdAlQ9uczw8=;
 b=eCyw+LQGClBrWXL+pdhza0Gk4tP5yB6nlzT6DtNJaodivRbW/5cIc+pOWZjqjEJKYB
 jNHRPuBFA4o9lUuddeZLeE9NLYpQRtysaP/7zbZZlz1V+HXwVDEb+649lvQEXyPSfncD
 9NXnW7e01VysPLtjSe5GBpsnyzG3JTfLP71zaFtwRyq147usP781U60K89maG+ZU5Gnd
 tSGjx7BC995xvLMl/f7PVcbgRCyZ7P1p3yNYSpnbEqNMPm+9uF6kioKmsROKTWuAW/Eu
 zX4nj9NCd3QAwCF7RJI7HRdrO/qUADZi4BfCruYocHnzXlOBRn6HNjcjlll+ybDhhAtp
 dNyQ==
X-Gm-Message-State: AFq9FYIFE0RsEuAsJzLty4rap5yY2hh5z/0axu9INBK/V2LyapCoqucY
 jsMyKc0cfOY+QQHfpTq9dpRyeivNj45BWJ/R5fh8btegcKSBXZs7IAXfSNJmVLXET/o4BtkK1aP
 wYvPJAFA=
X-Gm-Gg: AYBFou0lIZxoSFoZtp/ddKbhiafUrECThb71+TGc/TFd5visSNWsD1aKEKNlvupKS8i
 OOtLmeyXadfDIkp6dw4KFT5T6Fj2GMYrBzyYQd8m3YmZjVDmS/BPMwj9+W3O8dRNFk/sKWSGpTF
 0qo1SzNc7O5bXHDxy1cQpD1fEKWWsevuTXAAKdL3JJUpRmdpv9a2xIW+zp6n3RxWFpVwMv4+Jo/
 5QVLcqrL5AVEKO1G4dNST5vot/1XN+Is2fJRvdPyB4PbR0Q/vzZb55vyVttKYWwJjnqiy1SRjEw
 BRFLez3/55wMEm1XE1TBcXNhBLEE+NNoLb9eU9WIhnCTHhlCDwZG/LrOexaENh4bqD+mKltN15h
 MO5JpYS+bOBYmd3ohS15FGNgcX6/1gp8IX+/yPKbLLGLTmZUtFf+Ud9IEXBKB2GnBoFMoXKs6AP
 9oPpNOUS3eSCUhJiKDROkKG0qeAhog92+QjDFcr/ecchNMJZz/MFUZTRCDvxIfdO97BYkYF9awt
 ldqpaZusA7+KJK656J6ZK1zwV+f/OJg0kBwhgbn4GKk++zOFnJVQNI+BiLIwMK383RZNaWA+DCC
 mIhmooYevpjU5f6GU7BR67WaGwY=
X-Received: by 2002:a05:600c:3115:b0:4a1:fba8:b13d with SMTP id
 5b1f17b1804b1-4a1fdaf7457mr47045025e9.9.1792592341550; 
 Wed, 21 Oct 2026 07:19:01 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:19:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 028/100] tcg: Generic expansion of tcg_gen_xori_*
Date: Wed, 21 Oct 2026 16:15:40 +0200
Message-ID: <20261021141652.363109-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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
 tcg/tcg-op.c                 | 34 +++++++++-------------------------
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index dc5c7f7cb2..dd4e7f6686 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -209,7 +208,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f7a7dc69c9..b38969478a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -22,3 +22,4 @@ DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
+DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 668c946c03..cc34e0f31f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -518,22 +518,20 @@ void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
 }
 
-/* 32 bit ops */
-
-void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
+void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 {
-    /* Some cases can be optimized here.  */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        /* Don't recurse with tcg_gen_not_i32.  */
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg1);
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else if (src2 == -1 && tcg_op_supported(INDEX_op_not, type, 0)) {
+        /* Do not recurse with gen_not.  */
+        tcg_gen_op_tt(INDEX_op_not, type, dst, src1);
     } else {
-        tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
+        tcg_gen_xor(type, dst, src1, tcg_constant_internal(type, src2));
     }
 }
 
+/* 32 bit ops */
+
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
@@ -1486,20 +1484,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-        /* Don't recurse with tcg_gen_not_i64.  */
-        tcg_gen_op2_i64(INDEX_op_not, ret, arg1);
-    } else {
-        tcg_gen_xor_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0


