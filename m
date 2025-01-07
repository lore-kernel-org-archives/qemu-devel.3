Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1BAE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Xg-0000yd-9s; Tue, 07 Jan 2025 03:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wy-0000Hy-CY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:41 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Ww-0002wN-5N
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:39 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so22251102a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236896; x=1736841696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrF/n7KBeARlzDdAnf5wLY/6SKHxmfqpW88RYm3jHsU=;
 b=EZ1Wz9ngozo9/9Pt4Qhr49IPLRm2rPoboWkQlcRiYKhDcp3yqEKvlutt+shi9b7b8G
 X7fevSh/1ZUEbaQmogOIUF3fDpMylJ6ezM/4XerTqpJ/jG17uvO0XTSCnTu2EesKtslm
 AjZeXyrPVgrageuDf4Y1j5626GcxenoP6WGrCAqLzCsA323qcOmOHuK9A4Nz/aQwH8YQ
 PdEPofDiNgMMR/FhjCYf4c8x9aR0eqr8qowhZGoBIm1meyQFH6i/I1x2plYvOt7cU3Jg
 svwQd0KiKzUH2l2cfj94n1xrP1HxooxZ3zgVOpSnlpLBLYVoHW2JtsOf8ZCDeUEIY6wq
 KxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236896; x=1736841696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrF/n7KBeARlzDdAnf5wLY/6SKHxmfqpW88RYm3jHsU=;
 b=kHLYOqcdeunKvTQ/1giI24dCgs6V4aK75+1k0i1S20/sSuJc7Ini5P3P0Htec59ttq
 Y+Tr1GPkZatCqUYogVI6X97zCe9zC4IfRXYm+7qmN/mY/xE5h+gG/y/meO8O//eRvBiF
 sC2FuoCCTe1wEqyKoztAsOT9izhl3Cfwat6In/AaKXu+XbVUGQb2JQ7Ws4O+IDC+Myfp
 DViHRO7d0TzPDip+mLX4uduNd48SCRglMBbA5+Rsvmr/IsXLZ/ElSQzh+sDgUvKCnxnZ
 pIrOkGujZ8/R4ZBgX3xc0QMY4sG+rYjhePex4ZwkAacn34xfNeYyZnqdnRz5gzgNWM9g
 vm9Q==
X-Gm-Message-State: AOJu0YwTyw21Vh8pmEshr80E2Cl1t+M0UaWKGS+PeaqjVBy4BI1gKQX8
 Vy7+96xNVjXsaIPAKoBCjDnCsr43Qcg8XgI2uObJGXW0z+Ijq7RPuaifKlQNpkXlhvUWSxf9kuP
 g
X-Gm-Gg: ASbGncvs+rdhB2oGa3wVpLiSZ9G3+YWhZRzHVgw4SP5c/RFIsdERQl+e8HOh9tTRtbR
 nwJoxW5oeSsEyceez1M7HfJqODnl/SfXcc3JNHHSunjzS7JATX0z1hw1LwWmJZB8XKqnUhNzj4g
 XUyE4nnZU4U8stCddOgn/e6FcXiWleMdJr5UnEYGp0Zmc7BwjU/p36aiRtwOzVjJGQGA6pF8ch9
 uKl8cBsCKXosT940BgRSCUr3z7teeFrYXslxCJJC9MK5AJugNev+i+3YNPUFR9dkgHvO0Ah3pgQ
 sJ4QGt6PalpZQkPZpw==
X-Google-Smtp-Source: AGHT+IEXFVOo4LvSBgrS5LU6R9srH82psj1tmdE3yuAQmEUCpzmWBhVUkYN/KeyvH2NxKo5avNHClw==
X-Received: by 2002:a17:90a:d448:b0:2ee:5edc:489 with SMTP id
 98e67ed59e1d1-2f452ee6dddmr80082382a91.26.1736236896391; 
 Tue, 07 Jan 2025 00:01:36 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 21/81] tcg: Change have_vec to has_type in tcg_op_supported
Date: Tue,  7 Jan 2025 00:00:12 -0800
Message-ID: <20250107080112.1175095-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Test each vector type, not just lumping them all together.
Add tests for I32 (always true) and I64 (64-bit hosts).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 66 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 05bb464940..915a181596 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2136,8 +2136,28 @@ TCGTemp *tcgv_i32_temp(TCGv_i32 v)
  */
 bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 {
-    const bool have_vec
-        = TCG_TARGET_HAS_v64 | TCG_TARGET_HAS_v128 | TCG_TARGET_HAS_v256;
+    bool has_type;
+
+    switch (type) {
+    case TCG_TYPE_I32:
+        has_type = true;
+        break;
+    case TCG_TYPE_I64:
+        has_type = TCG_TARGET_REG_BITS == 64;
+        break;
+    case TCG_TYPE_V64:
+        has_type = TCG_TARGET_HAS_v64;
+        break;
+    case TCG_TYPE_V128:
+        has_type = TCG_TARGET_HAS_v128;
+        break;
+    case TCG_TYPE_V256:
+        has_type = TCG_TARGET_HAS_v256;
+        break;
+    default:
+        has_type = false;
+        break;
+    }
 
     switch (op) {
     case INDEX_op_discard:
@@ -2376,60 +2396,60 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_cmp_vec:
-        return have_vec;
+        return has_type;
     case INDEX_op_dup2_vec:
-        return have_vec && TCG_TARGET_REG_BITS == 32;
+        return has_type && TCG_TARGET_REG_BITS == 32;
     case INDEX_op_not_vec:
-        return have_vec && TCG_TARGET_HAS_not_vec;
+        return has_type && TCG_TARGET_HAS_not_vec;
     case INDEX_op_neg_vec:
-        return have_vec && TCG_TARGET_HAS_neg_vec;
+        return has_type && TCG_TARGET_HAS_neg_vec;
     case INDEX_op_abs_vec:
-        return have_vec && TCG_TARGET_HAS_abs_vec;
+        return has_type && TCG_TARGET_HAS_abs_vec;
     case INDEX_op_andc_vec:
-        return have_vec && TCG_TARGET_HAS_andc_vec;
+        return has_type && TCG_TARGET_HAS_andc_vec;
     case INDEX_op_orc_vec:
-        return have_vec && TCG_TARGET_HAS_orc_vec;
+        return has_type && TCG_TARGET_HAS_orc_vec;
     case INDEX_op_nand_vec:
-        return have_vec && TCG_TARGET_HAS_nand_vec;
+        return has_type && TCG_TARGET_HAS_nand_vec;
     case INDEX_op_nor_vec:
-        return have_vec && TCG_TARGET_HAS_nor_vec;
+        return has_type && TCG_TARGET_HAS_nor_vec;
     case INDEX_op_eqv_vec:
-        return have_vec && TCG_TARGET_HAS_eqv_vec;
+        return has_type && TCG_TARGET_HAS_eqv_vec;
     case INDEX_op_mul_vec:
-        return have_vec && TCG_TARGET_HAS_mul_vec;
+        return has_type && TCG_TARGET_HAS_mul_vec;
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
-        return have_vec && TCG_TARGET_HAS_shi_vec;
+        return has_type && TCG_TARGET_HAS_shi_vec;
     case INDEX_op_shls_vec:
     case INDEX_op_shrs_vec:
     case INDEX_op_sars_vec:
-        return have_vec && TCG_TARGET_HAS_shs_vec;
+        return has_type && TCG_TARGET_HAS_shs_vec;
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
-        return have_vec && TCG_TARGET_HAS_shv_vec;
+        return has_type && TCG_TARGET_HAS_shv_vec;
     case INDEX_op_rotli_vec:
-        return have_vec && TCG_TARGET_HAS_roti_vec;
+        return has_type && TCG_TARGET_HAS_roti_vec;
     case INDEX_op_rotls_vec:
-        return have_vec && TCG_TARGET_HAS_rots_vec;
+        return has_type && TCG_TARGET_HAS_rots_vec;
     case INDEX_op_rotlv_vec:
     case INDEX_op_rotrv_vec:
-        return have_vec && TCG_TARGET_HAS_rotv_vec;
+        return has_type && TCG_TARGET_HAS_rotv_vec;
     case INDEX_op_ssadd_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_ussub_vec:
-        return have_vec && TCG_TARGET_HAS_sat_vec;
+        return has_type && TCG_TARGET_HAS_sat_vec;
     case INDEX_op_smin_vec:
     case INDEX_op_umin_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_umax_vec:
-        return have_vec && TCG_TARGET_HAS_minmax_vec;
+        return has_type && TCG_TARGET_HAS_minmax_vec;
     case INDEX_op_bitsel_vec:
-        return have_vec && TCG_TARGET_HAS_bitsel_vec;
+        return has_type && TCG_TARGET_HAS_bitsel_vec;
     case INDEX_op_cmpsel_vec:
-        return have_vec && TCG_TARGET_HAS_cmpsel_vec;
+        return has_type && TCG_TARGET_HAS_cmpsel_vec;
 
     default:
         tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
-- 
2.43.0


