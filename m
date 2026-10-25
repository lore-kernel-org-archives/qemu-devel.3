Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C73606A31F
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L+d0KvKd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKseQ-0002qY-8U; Sun, 25 Oct 2026 03:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsdA-0008W0-JR
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:27:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd8-0004cW-L7
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:27:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so10677365e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913217; x=1793518017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x+czQAgP/wLn9YvinG6PMGIcmrwGulPZvirlSquDQVg=;
 b=L+d0KvKdXVBzr33qIZj41ag40EGEAQQL+3HgbV3cOrBXv31rYg5oKH2Z5A1YoBgvpS
 Tz1Q5YjWdv1+Rj7sei08k5rjcym6yx2PbtHtOaYQVohPNMb69SIkH38auioxo5hHg81+
 9kOr4F2Zbqt7RjVywBZoIlf+pBS1s/IqT3A79GBQdfWoSqjcZxR+VMBmMqBBE4e90tV+
 O3f09c5T7KNkrvVhJwmcMZ9KlODqglm+/DsNhPVk4HyHuHIQAXLxNcl00A08BgaTvNbz
 K5hp0KpPRTckfzIt8xzvgAO/g3eflF+RQav8K04/UEfEH8n072FTM3VLFIZLWdnYZOKC
 ++vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913217; x=1793518017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x+czQAgP/wLn9YvinG6PMGIcmrwGulPZvirlSquDQVg=;
 b=HAsuI6RDKW80aB6OzVZiKEuqlWe04Jqa9U9MdbRuLSxQgoKy7mpFIQV503+Twb1TrN
 LKBt9twVOi9gnFPRDKDmoi0FlZ3za6Uj9OVdRI6dkFSpf43cMuo8p+tksdD56N8HdgEK
 MDvJqfpt9dg1DR8bFSVQUdQFzMVTuXrIgtkUd+FMhbQn6dvFntREV0jPf/odtsnSoWWH
 zYflefVt237+W1mqe8ZFQuSP4DzLOvOEAcvHZbcbhMecl6K/SDe7bez3Znc24VMOJgd+
 ItjHNhEu/RJm9f4kSZHU9CLKlt/Wih2shrG8c5KFVkhsMdbp4XpWUOcQ1UsWysvGbSf/
 qNLA==
X-Gm-Message-State: AFq9FYKIEej9bsURclOMhUIzMesEmSqVyH5E1VjlnAAcMtAEVRqDo4J1
 cDZdB4sZsS5d5iqJztIrS0oq8f7rbPh/VlI9ArziFxepT0nzQQg09SJ1Z+rZCnL93MO+a5wUh8p
 jo+OIIvY=
X-Gm-Gg: AYBFou3DBa56FZ21bJF/epjR+YRzFfAWIvkT0Xds/BRInkz3wXYLvb2Lp5XKoavu3Ur
 fu6F9eNYBmKa75AK4mvurNrg13WNAUhZ5IkXLDF2f+PPJfQ5TrGZa3ISdFNavPCjC0ED/dQ0QEl
 xKdqbVEJjtCoKsVHo6BbMOnyGly3QmJ4PNjY9f4UzIwEEml6GnHAWtzhnr/z85cPSaU7HKy6BKT
 lcxstD1mZRsORVtOX0JVyj/1rE9KugQvQ+X468mxMDRCmfW5Ht2OW+2w5Oc+Cn3cz0vDBbF2qBU
 Vic8EAUa0h3y0dkab7AkWqGh9D6QOg2FBl842032R+ACc9ac6VqOijC6YsTtSAS9zz8RMvQoqxP
 jrQ1A56ZOsQSmNZNrPhSUP+l/aubYBuqIcS3CSEFf9RuduwYijyFelI2BCMahFkvVZqoSdh1A94
 ETIVlQpVOQZgYHaNJwDLV13t7cGeIXMl9dHcWQk2ikCVgs7EGT9uHjQ3XRgbih6ojyL79P8yoKo
 UIWbCIbUz90sYq1OclLfWH70pXiRA+cEB3Fp7upuDOUYAKQrB81qlk79i8=
X-Received: by 2002:a05:600c:4743:b0:4a1:fe26:24f0 with SMTP id
 5b1f17b1804b1-4a35aca078cmr54463215e9.20.1792913217027; 
 Sun, 25 Oct 2026 00:26:57 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 095/100] tcg: Generic expansion of tcg_gen_dup_*
Date: Sun, 25 Oct 2026 08:19:10 +0100
Message-ID: <20261025071915.1123867-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  6 ------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op-gvec.c            | 41 ------------------------------------
 tcg/tcg-op.c                 | 16 ++++++++++++++
 4 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1fe791d5f5..75194c1906 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -137,9 +137,6 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
-/* Replicate a value of size @vece from @in to all the lanes in @out */
-void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
-
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
@@ -153,9 +150,6 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
-/* Replicate a value of size @vece from @in to all the lanes in @out */
-void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
-
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f9dab50a91..556f7470cd 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -23,6 +23,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(dup, unsigned, TCGV, TCGV)
 DEF3(ext, TCGV, TCGV, MemOp)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 0d649cc13b..72abb0a08e 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -434,47 +434,6 @@ uint64_t (dup_const)(unsigned vece, uint64_t c)
     }
 }
 
-/* Duplicate IN into OUT as per VECE.  */
-void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in)
-{
-    switch (vece) {
-    case MO_8:
-        tcg_gen_ext8u_i32(out, in);
-        tcg_gen_muli_i32(out, out, 0x01010101);
-        break;
-    case MO_16:
-        tcg_gen_deposit_i32(out, in, in, 16, 16);
-        break;
-    case MO_32:
-        tcg_gen_mov_i32(out, in);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
-{
-    switch (vece) {
-    case MO_8:
-        tcg_gen_ext8u_i64(out, in);
-        tcg_gen_muli_i64(out, out, 0x0101010101010101ull);
-        break;
-    case MO_16:
-        tcg_gen_ext16u_i64(out, in);
-        tcg_gen_muli_i64(out, out, 0x0001000100010001ull);
-        break;
-    case MO_32:
-        tcg_gen_deposit_i64(out, in, in, 32, 32);
-        break;
-    case MO_64:
-        tcg_gen_mov_i64(out, in);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* Select a supported vector type for implementing an operation on SIZE
  * bytes.  If OP is 0, assume that the real operation to be performed is
  * required by all backends.  Otherwise, make sure than OP can be performed
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f7da3ff5c1..cb40ed7ca8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -659,6 +659,22 @@ void tcg_gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_dup(TCGType type, unsigned vece, TCGTemp *dst, TCGTemp *src)
+{
+    unsigned t_width = tcg_type_bits(type);
+    unsigned e_width = memop_size(vece) * 8;
+
+    tcg_debug_assert(e_width <= t_width);
+    if (t_width == e_width) {
+        tcg_gen_mov(type, dst, src);
+    } else if (t_width == e_width * 2) {
+        tcg_gen_deposit(type, dst, src, src, e_width, e_width);
+    } else {
+        tcg_gen_extract(type, dst, src, 0, e_width);
+        tcg_gen_muli(type, dst, dst, dup_const(vece, 1));
+    }
+}
+
 void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_eqv, type, 0)) {
-- 
2.53.0


