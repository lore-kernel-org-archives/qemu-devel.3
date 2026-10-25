Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18857606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ANTpg00p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWQ-0006V1-EX; Sun, 25 Oct 2026 03:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW5-0006CQ-8p
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:41 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW3-0003hE-5w
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:40 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so1224147f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912777; x=1793517577; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oLqoKv5AM4OUmv/iRqPee/iPgrjBGllkUn9VjyEi+EU=;
 b=ANTpg00pqTNs5KC9o2f/XtUkaMtIIKIzJbEXaI4HElSvBa2YveftX7tfi+kl7fP3qd
 zvX+hZBgsu94FzTMWCM3hiQuW7Blk2LVOhGc5QX+jpJysnDWNTg635MvCOG9wtU4bk6x
 8uwFkctVRqQ31mcO3Vp4WoILBRY3rvG1gHBLtaUll+T7zWWJEL9XoCC3mbyuqgOhE8WZ
 kGXLMnWBW8OK4za3sGNfwIDm0DyywLEeO6O8CXCCP0LFt3Vqgfm05i0idr4icCdjan79
 HElCQBwu/zZ2XxZFjwtOwXUwd1tX096pyS7tDvhphnoQpFZTJove2iYtDc5bKAAV9ORM
 Vhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912777; x=1793517577;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oLqoKv5AM4OUmv/iRqPee/iPgrjBGllkUn9VjyEi+EU=;
 b=kvqwNBfae8EMzjCwpoUtBI1u+Lp0kkJjUQbYSEsCnf5iIEggS9HCOeIXYMXtlCCbve
 hFjZHOZxca/1jEyIQzHLMR04dMzV6uQ95QGSA4Y/Yop3ryb84patchJ8tq/YJ0/HEZ4W
 5g+iBMqLyEt1fe/9MD7BG6nMpc4f/xhBKsB1BJB2VaF8Fs6wsp36fyxYDA49mKFSjZrK
 JO3anPhHVA0BaP5oqDFyB2wg7ajF4lv23QgZyt7wFTH9TCoTgHccYLs9sH379zrK5csp
 jULN7aBhTb41c4AaCxrGKuFeTI6Kn2dvO9b+frZOAh0YAVZ/a46jgzyxIQgotyWF/PoU
 YZ9Q==
X-Gm-Message-State: AFq9FYIE4w+EjVuw8MoUvN4QTzOgRRnWi+h8P0zGNQ6L72mvqm/ky7tZ
 lWvdpbFlRZ6FPmzhzaQsvWkzzGjXFhvKuCfgv7sSHgjWN9ea8eecUDU21zx4tVdcwfm1lAjc24s
 ZY08PoY0=
X-Gm-Gg: AYBFou2iwIMlB8Ru7yBom1yeuw7PMmpjX7Dwi6lVSgWxbUGSdsQt7wEisOI63OIgml1
 TU0tkIqe7AtrpJUdck1Rd8aT95/hhPCVdE5HRisE3pik4vwqcmBDhQoq5BTg+8yEAba8pZ+2wiY
 1RCwLSZ37YoEmLfdqkMsoZHJW/qxPGYdx531zIECLlPa9EKJ7bW3LdbSn8xiFkq7W94/U3cPTn6
 kdd00fsKs5rbh0fW3B8Dc2lPsYC1/fjDpRNvk/odWShFAeYUZp7/qMjQIRArsOHWkmnVj1QrAtn
 1EFg5p0xUQVdms+G/DBy0Q4ZCnJIUKUKa2OMctwwYKySr9BMK27QgXFwmbJQe87Q2NfqlOoazZx
 uk9+QxUZpFCE50vMOJqSJm3O7dUjjJBca/lm/wqP7Xf6aMsupyybhfZ0VMMMlnPV1oEYyhBXK4T
 LWqrdUtGcrTu4NW7P1weHBBiQPFprGocGw8sDXmgqw7IM3fYG3x6qnYzwBmuXVCIbrkYicwbyCJ
 k2XTEFCO+uz0OYd2fGAu7uu/j3J3GdP3o+FdUi/rOlnpmJC+3PsgZOpKQ==
X-Received: by 2002:a05:6000:4008:b0:48a:fe00:ad1 with SMTP id
 ffacd0b85a97d-48e3ed09e47mr6868826f8f.6.1792912776882; 
 Sun, 25 Oct 2026 00:19:36 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 015/100] tcg: Generic expansion of tcg_gen_subfi_*
Date: Sun, 25 Oct 2026 08:17:50 +0100
Message-ID: <20261025071915.1123867-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 21 ++++++---------------
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d7b40e6705..03f3cba216 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -222,7 +221,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b5ede94511..487ee5936e 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,3 +9,4 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
+DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bb34f883e8..cdb9774ca6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -409,17 +409,17 @@ void tcg_gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     tcg_gen_addi(type, dst, src1, -src2);
 }
 
-/* 32 bit ops */
-
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
+void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
-    if (arg1 == 0) {
-        tcg_gen_neg_i32(ret, arg2);
+    if (src1 == 0) {
+        tcg_gen_neg(type, dst, src2);
     } else {
-        tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
+        tcg_gen_sub(type, dst, tcg_constant_internal(type, src1), src2);
     }
 }
 
+/* 32 bit ops */
+
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1528,15 +1528,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
-{
-    if (arg1 == 0) {
-        tcg_gen_neg_i64(ret, arg2);
-    } else {
-        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
-    }
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


