Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A01E606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bu8KjvOd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8E-00037S-Se; Wed, 21 Oct 2026 10:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX84-00035W-91
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX82-0001V7-H9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so4795005e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592237; x=1793197037; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OkeFfSgEcCPe2P8/CvFJqr1SXxAXpM1yZQ7nfQpBIzo=;
 b=bu8KjvOd9mdsI3dI+W5W96EU6GSQ3ZrxtAlMScfwqNkqeOjkXBy+PiA0AtLWHdy/xS
 0xK5LMNvB6ZOFu94/knwrU+DdlBeSCreU18aLOKVuGdKouNHN8fejzx9lLo1wRyQf1r4
 ywYv5PELbVtk2JQN4cetEOO7si45lsKCvXtSt7ivuJ23JtI104dUD/myQSIsH5xfqJAx
 Dem9gbVz4nvEPkJoe9EzwfcFbrvHTEe/UDrPJLwaeSrLTfW0Dt804IlXSAUW1jZeJvX6
 1cLz3xaec5wr25Hfh29LNuBkpf+2Oumf4Rv/XtQL+wUo40tZfx1kDwVenezXWnI1KRs+
 RUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592237; x=1793197037;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OkeFfSgEcCPe2P8/CvFJqr1SXxAXpM1yZQ7nfQpBIzo=;
 b=DEiUbpoGVsJk2uRU61GhBM7u8vUDPTf/d1KqkLr0QHQa2AVhHWNiNDvjVCfuzn+Apr
 Rx7rU02wBgMrt6RmhSG+1tVyGg5+bHdmWFV7Rn4ZmFO1K1HkpXXtn2fXj3l8zn/vKyBb
 eEkOYTPOyOAPSmeVReGzMO3FbY9T4cAh/uGVENHqXFeWeG12E6siXSWUXVIUVnS2EXiR
 7869j8uKCiVKUU4a/LVcKPW9mI7ikZZxXfejkCsvqLxXYYc0rM89PzlKBb2JCidQWNQk
 QFNAeRKiX+U8TdZOt2exBn71MCq9/TVNwBVkEKOA1l004JV1OA27aaL8Y6BJng5g1fQk
 sJsA==
X-Gm-Message-State: AFq9FYKI9uXvvHPVOsr4tYDzCi+b3f07JQXuWOcQXzeWDYiRZwWR//lC
 UlK/L1YQVIGD47D6t15HGH+DLJU1xdy1x14AGBCYcX4r13fOFpZUPHrklE3bodFGX90KnX4lgBY
 63iGxDc4=
X-Gm-Gg: AYBFou1V3hI/jI4VliOcGSIKnLlX0IWLuzG68O6u2KecV8ot4VF6FD02JqxBgRAl1V2
 PPJ9VxZy05/Pp0E8WfD24DQJbyjh7Cg+pyK8oAGEnFJRrc6WsiQnWbYe+VvpAbkMsMKsgdUojId
 7sC9aQCJaOWFTtOBeTuqdHxOblEpCrbLeCzDNU1I154xcwclhi26nG6NPC/3uqlZHuwEzi5hJJM
 sjLa+d+/2l/MISqTOLh9hC4XzweIWlHA8MC3R+nKlf3oB2kSRnLiXG4EuGJb8YNAdevL3nvwVQ/
 TWS/NjFnNGaVZ4HOH1wAu1Yg7pUkJUboz851yUsbmvJeHl7oG2+lOv7LaevrhfoJioreYxdkb4Q
 VR9natu3z98nYtY4po9RAXeEs/8S7ezHVgG6tGhYtpi6eiTe5XoinP7dz6V1RVSfIgMhD7TAD9R
 l5q8ZjxJsZg+rCDBJKcc1VAchgs/Mlm3ZK9zK1HzGJdpYHksmtj5BrJmPZfpUWuMc1VVbNzvxwx
 h16498CsNSjDTYg6JM6zPQSnHci/v1U/9RN852ctPmmP8tVe3f7wdp7VVYwK+tKF1R0H5h5gfI3
 qSLlbEb3z2N3+B2LMev+lUOjO88=
X-Received: by 2002:a05:600c:8012:b0:4a1:a39b:e75b with SMTP id
 5b1f17b1804b1-4a1fdd2434cmr47165965e9.21.1792592237068; 
 Wed, 21 Oct 2026 07:17:17 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 008/100] tcg: Generic expansion of tcg_gen_movi_*
Date: Wed, 21 Oct 2026 16:15:20 +0200
Message-ID: <20261021141652.363109-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  8 +-------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 20 ++++++++++----------
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index deec10159a..9dc05cc7b7 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -117,7 +117,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -224,7 +223,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
@@ -559,11 +557,7 @@ static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
 }
 
 QEMU_ARG_NONNULL void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
-
-static inline void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s)
-{
-    glue(tcg_gen_movi_,PTR)((NAT)d, s);
-}
+QEMU_ARG_NONNULL void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
 
 static inline void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
                                        intptr_t b, TCGLabel *label)
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c76e83396a..e55a9f9993 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -2,3 +2,4 @@
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
 DEF2(mov, TCGV, TCGV)
+DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4b8dfba8a9..d7272b08cd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -370,6 +370,11 @@ void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
+{
+    tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
@@ -377,11 +382,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
     tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
-{
-    tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
-}
-
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
@@ -1444,11 +1444,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
     tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
 }
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
-{
-    tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
-}
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
@@ -2778,3 +2773,8 @@ void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s)
 {
     tcg_gen_mov(TCG_TYPE_PTR, tcgv_ptr_temp(d), tcgv_ptr_temp(s));
 }
+
+void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s)
+{
+    tcg_gen_movi(TCG_TYPE_PTR, tcgv_ptr_temp(d), s);
+}
-- 
2.53.0


