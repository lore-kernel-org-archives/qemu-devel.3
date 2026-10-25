Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613CA606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YAaOz5a4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsc0-0007Sr-JE; Sun, 25 Oct 2026 03:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZt-0006k8-P0
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZs-00049f-0x
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so14067025e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913015; x=1793517815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=717yCYoRJQfP2swjb5/yDgLk69yL7+1BK7KxGQ5tJew=;
 b=YAaOz5a4Tat0+sITZCgVjrJY7Xl/pFIuAkBn3xnheN7j9kboJKXEP+RhjldBJJY2Ft
 h9UP9uQlu35jWbPxZkizN3UKNSjoageJU70Xlf+cqK6OVeeRB3eosT5TdE64tf5rET6O
 EbRfXCt0KCW5XhRSVtOc+q6+NOf9NKp+vrYCR63gl+3QNQC5fCeEVSnR1fQZKce30nyr
 v7RUPaXbtRhzy2me63XJ59FPpGoXP/GMTlyT5LWsb/E5P7g7aLI5VgqBqJsu3PUJ8yFA
 7D42Vn6jvATGsQG7qNMOPNmG59Og2DMsSlXzOVsMztdIJSzfA1LqBwCTLhwqvhqgOPcc
 sy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913015; x=1793517815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=717yCYoRJQfP2swjb5/yDgLk69yL7+1BK7KxGQ5tJew=;
 b=fn0V99mjppsjRJ7b670eoZz5+xGwtX3RZAZ9N4qpTd/6xnueX9VJAzoBIqkcUA0vvH
 JbgvA/NMHZCMBz+JyDR+iothY/XVdO7Fs+BEtJzNF1R66L3dsi1V/Q/lrV7AItGukniv
 i9q/YjJBi0fmqpXQ4duXvnwXMknLVAqGzmVdRSTCw3V/tnaqRFhGz5bSDf4CASrTVrob
 WYtagT1beJ9/+DXM8AzPWZnJMc/QodIs7zLYJSGKGlyfTs5zJ5hFQZdretB4GlfGNiDa
 yhpaJxKYSgwioTuNyRn7ydI0u9k7+b/4LjIZSZCCQR6OoxaiJNZjYHMiigbTyOheNjZp
 E08g==
X-Gm-Message-State: AFq9FYI3BVo3ZkNMAMxHIhoo61MUHYXPY7CH4eWIPhIrUIIhCAx+qX9u
 5qZPqwSkzIKr4wq/RN5NRUl4n6Uc21TjnOKAtvNoT+w0VDDs24/zBi/zXTQz2kCO7GHA9WSf2WY
 A4e0i4hQ=
X-Gm-Gg: AYBFou2qj3NCxhRkIEORzOEMczL/GR+JuJhzxyE5yfm+NefHbaSYdrPFiilug0DftzX
 6USjMWukO4PAxRXbH3M0SYOWFbpz9if3eNgR/LD1+0m8aaWt91IPhtloyyCWZyod0VXI4rQdBwY
 RqsDSJKe44VArUmo+nOhWRIYc+PlGk3cPY1aW0bN4WhvsHQkZ+xHGVxFuU43NCmDjhvsAwgfDoi
 kGZA3YkVDcJvQpgcxLtSYpOPWgyK+B3yYjBtrh91YD+HnIPSyKozF15oQvyOTH69RyNIpMzZvkR
 ueCMpK8kwZr8xxa6d3rYjLW5tAPnO9WZx4HlsfQcoO4vLmf63yXRtl5SZ7QUuPvigi+WlL5uS5P
 bv5f/FwcWaA4qGlg1HPqA1W5cGIkEZcCbj59XtlRzolM8d1hGU5bVjQnNtw+cshiu5fBJPtxkl9
 ni/osm71u9n2h2pzLP0MH/unpQns1L0XNtbZgi6Wd3EEdju0barQLfOv4ps+XukMPbtoaHHgPwR
 cSdHQjJGu7d5ikvH6URG7an8nBaapr7U4qP9kVEuVBIo9BPF/S912q1gJw=
X-Received: by 2002:a05:600c:8519:b0:4a3:59ee:86b with SMTP id
 5b1f17b1804b1-4a35ac3b22amr58714105e9.4.1792913014575; 
 Sun, 25 Oct 2026 00:23:34 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 074/100] tcg: Generic expansion of tcg_gen_abs_*
Date: Sun, 25 Oct 2026 08:18:49 +0100
Message-ID: <20261025071915.1123867-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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
 tcg/tcg-op.c                 | 34 ++++++++++++++--------------------
 3 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4a79e3e1f6..9491879685 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -147,7 +147,6 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -186,7 +185,6 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 3c93c20704..19c6347fa7 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
+DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a288c14813..c1ce4172ef 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -331,6 +331,20 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * are of the proper type.
  */
 
+void tcg_gen_abs(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        tcg_gen_neg(type, tmp, src);
+        tcg_gen_smax(type, dst, tmp, src);
+    } else {
+        tcg_gen_sari(type, tmp, src, tcg_type_bits(type) - 1);
+        tcg_gen_xor(type, dst, src, tmp);
+        tcg_gen_sub(type, dst, dst, tmp);
+    }
+}
+
 void tcg_gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
@@ -1375,16 +1389,6 @@ void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-
-    tcg_gen_sari_i32(t, a, 31);
-    tcg_gen_xor_i32(ret, a, t);
-    tcg_gen_sub_i32(ret, ret, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -1879,16 +1883,6 @@ void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-
-    tcg_gen_sari_i64(t, a, 63);
-    tcg_gen_xor_i64(ret, a, t);
-    tcg_gen_sub_i64(ret, ret, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


