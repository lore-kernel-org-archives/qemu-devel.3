Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75D0C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73p8-0005ZM-H5; Thu, 17 Sep 2026 00:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nn-0002EB-5R
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:51 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nl-0007Ky-6p
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:50 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b5b07ec78so283036a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619568; x=1790224368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4Gwz5IidMPaDjTHAos35ZuXkg6kqFYoFG5EgZu71ns8=;
 b=A7ve/lMXcVtALg7O+o2e89EpY0ie+jW8xWPUOcQrU4xy3BFfHL5fznxHPK1g7Se7UA
 FcQFNdd+MFCzrv4WfjGAUZ9LxcCpde+250FPCK8c8YL3G5gQ69A2jRhZKqyK1uXyTB2g
 N7qz378T4ipfahElsKEwfJcYYvp7hMaIKX8hvTBUrA3OqPECqxeEErD/7e5Od2IUyFs5
 6+UD9xBIeFTTxWF0UdxvYkuJNnJF0csjuBnNrgRSEaZsXqJqwXqmf6VnNwzjeCliUXb0
 Ix+nwYbYjn5cWdX1hQpsrxc2Scrb9TMl8/YzRfS5yxyViC8dc3ilfyJnEZ69nz5efNrm
 YgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619568; x=1790224368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4Gwz5IidMPaDjTHAos35ZuXkg6kqFYoFG5EgZu71ns8=;
 b=0TMWZFZ8ShcTm6txYa+qociUj6dhH92rF1icSWIs49wIZheqqh92s8lw6THK2M5tfV
 DK6MjHjNzUXiES2CYYOSdt2KlYwhAW0lW5jODUYpvjaPxX6zq1Eke8fFUiHMJO+3K8pg
 1qTyde6RNVOHD9SjHOO6fXYwPQIoHwgK94TGapwfMPcTUN2pSfzqsPuVvIp1sZ4BBq4W
 h8RJVMPpXIyx8QGMDrLWtNZCSsEuOLylNUibgSSZ5SYniNMRjtCXKc6XitK6rNiB3M4k
 qe6YR2Zhwh5XXQKfUeP8P195CHIvSAC+ZUCNWdzNVr00Hh8hRwDLVmPjBKQg0Hn+It4n
 XsCQ==
X-Gm-Message-State: AFuF++laLdbcSoLbln7vAp5+pVbajo3XA7p0FbdBt27Xb4JDYpWzHwzN
 t7D3XQrFEKLbXAOAiRPkqrwCdBTE/c9eCmQULytmnCegnAjQRC7fwUDDU0H3FHKVDfFSBJeXoPA
 twO4NM6I=
X-Gm-Gg: AYBFou33vpOtQlG+VoC6jGkQminH4xBE/lMAV2hwxU//k54q9qHz4Kcw1Mu94+iOJG4
 rHX+s2bM6phTjjoGdV/GKvTdTSXiqcnpVGRVh9R8x5iyZ3ljXL166iVE0qnQJlAjdB7a/t+MpA2
 LOOOQH5GbwdCGKlzlhLb6Fz3L6hgVFxl7mMydOcFmO9II12EdWwGmY1Q7O5WmHEA5l234pvCHt7
 sZvJXgv51J4SUwAVHoo8rEYOJkDJxiZVwlnMLi8C4GP1TAKSZv36iAT5dg7hIABnq+SuYYOMVOQ
 yZjECizjL2K4Ven4znxlncE90ejPhjeO/vSw7KJFBxp1RcNeiDvZQubLazkWR+XvF/3wydp6HKH
 mnw7gEO0rdu0htge6Gl03R92mDBdRfh7OzpswOAhmxJLQIvWVuExdPnL5n1x8JkijiIqK+t9je5
 1kzf/ILP9fbRCEqsMclA98uHkCtBw9kd5CK7oeXLCOImdeIy+wqfjkdps1qiCd3NbLPRDVk16yk
 Y36oGU=
X-Received: by 2002:a17:90b:4cc8:b0:398:c292:ac80 with SMTP id
 98e67ed59e1d1-39e1e330a2dmr13079775a91.10.1789619567682; 
 Wed, 16 Sep 2026 21:32:47 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 078/101] tcg: Generic expansion of tcg_gen_abs_*
Date: Wed, 16 Sep 2026 18:28:00 -1000
Message-ID: <20260917042823.542588-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 tcg/tcg-op.c                 | 35 +++++++++++++++--------------------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 79a3e82c98f..b64b54fcdee 100644
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
index 1405dff32aa..69df7967c76 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 
+DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5ed6cfd8f89..afd764ef16d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -415,6 +415,21 @@ static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
  * are of the proper type.
  */
 
+static void gen_abs(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        gen_neg(type, tmp, src);
+        gen_smax(type, dst, tmp, src);
+    } else {
+        int width = tcg_type_size(type) * 8;
+        gen_sari(type, tmp, src, width - 1);
+        gen_xor(type, dst, src, tmp);
+        gen_sub(type, dst, dst, tmp);
+    }
+}
+
 static void gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
@@ -1480,16 +1495,6 @@ void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
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
@@ -1984,16 +1989,6 @@ void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
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


