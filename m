Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547160A260A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KIDSNiaT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXGT-00061Y-8N; Wed, 21 Oct 2026 10:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDV-0001kn-A8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDT-0002DN-KJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so6248145e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592574; x=1793197374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uAkN2tO6gscMsWf8MLX85qK7f+aFKgaY8BOsmUdE/ig=;
 b=KIDSNiaT/kq/H2gp4EWFyiij/jbegPmRHihRsidfFV4RAYpFmwFEkw6QyTSv73W5QB
 n1YPzP8bF+769KmruBKvMMtFXm3wUUU6hSz4menNUI6wMY2U2FUI66aR/M0dyEmPM55K
 Ae/HA6MiTAgbKD6e5sDIsRvyqTuFTLORy/Lf/N40RADNLpWBFcpEDrOvJ8TiNYbzmB8G
 Y7Q2TJzoYeHtDT5Oi4jhnEO9YDaNVr4WyUoFD8gNTAj6bRuBY3rSQd011dqLt6EaN+xJ
 8HIWn5NZnlDfsBdRM0pNhaBmfRJ2KTM7m9+Js5eNeH6UqKUOJDLgLc90NtzqB32MlbRR
 aG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592574; x=1793197374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uAkN2tO6gscMsWf8MLX85qK7f+aFKgaY8BOsmUdE/ig=;
 b=E5JGaWUjT4MDoSy/7xW6MlTo47YDS8g/yEp7QirC+qWGusiTVGN4K7M+iQXDXzCJ/J
 UdGXM89N7cA5Abc8sTV9cWK2cshV1KzNCUABjb6induQXl3LdmArdo6lg/hXgOmJyOGI
 DrIODIYrC/KWlMd0g2DzKgT2dx2FYkvI9xjJ4sNuENeDMP8UNuqg/ykS2WYw5wb9lhkS
 R91fJDW5vAGOPz2hni4r9DG9sN3NpwaRSZjcTXOYXtr4+3M0If9cbMsvNDahxjmyWZSw
 /yNBusVxqFP9QOQHqo5xDX3kSUVmiedvnYCXipH1nS9xqy1NNp6eEVBYDO9jky84ZiMW
 I1sQ==
X-Gm-Message-State: AFq9FYLnyJFOdX0wB8O66uoXIbWomQma2Shhz7SWB0KBL9rcv0xOWEXX
 ugm/IWojEDqaFG4AaD4h9nDNc7gmBo8xBNhlmkUFoL4OidE0W/6oHYxHSYnFxiwd+XhTsDodeou
 49wpiBoA=
X-Gm-Gg: AYBFou22F2TrMA1vFSBZTgFTq2VQVoAw/HMKpYZQBnnpcnLcXyFGV5SK9KZV/noMfci
 KSMNkJh1WKpHxYqntBthz2ZY8SmLvBCzCrAs3vAXbXdQEiGdM99AzSfAfdD5K0oe03//wktuj/q
 ZD+KPwTO2vOIRE7FiTB/643nzrGUvKMNTBlBZZUsEsZrk6feceQtXnx/xYM7L1TMG0uRI3Fqxrz
 QxrhB3+4uIxvAyHIsE2NsoVN2u07xbw1NrwbMIYB9i4+15/CyuY7PF2OgwzksTarz49C4G/UsUQ
 HwDzVHf2hJI+InBw6CHObqFyCVGYw+fOEeKhybDk9tbpf99bKleyjGjeB0YOnHeh1brOI6h1b3i
 KixxLDu13SxAhwlBkKyOnIuxe/bpXvYZJlJJR4kyEM5G8DAgeuwB0vGsmxIFZRATKPJ845BrDe2
 S9SJwj4YagljQL9Emd92TKYXfAn/e7n57TID5nSWy8v/+nW4bqoCq9JOjfRp5JglozqIP4KVLhT
 oqxhrsbOI6BntRK4zxmdKFwWQ5hmf0xwVU9f4PWovKIMeGD/v28TT/Jf0eI0x11LIelZTPPW96X
 iseWURWpuF+nBOOfqssFZf2dvxc=
X-Received: by 2002:a05:600c:3b17:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a1fdd31aebmr51668095e9.16.1792592573523; 
 Wed, 21 Oct 2026 07:22:53 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 075/100] tcg: Generic expansion of tcg_gen_ussub_*
Date: Wed, 21 Oct 2026 16:16:27 +0200
Message-ID: <20261021141652.363109-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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
 tcg/tcg-op.c                 | 29 +++++++++--------------------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9491879685..6942012787 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -184,7 +183,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 19c6347fa7..82dfc90009 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -63,5 +63,6 @@ DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
+DEF3(ussub, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c1ce4172ef..c5329a8d95 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1082,6 +1082,15 @@ void tcg_gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+    tcg_gen_sub(type, tmp, src1, src2);
+    tcg_gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
+                    tcg_constant_internal(type, 0), tmp);
+}
+
 void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
@@ -1379,16 +1388,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-    TCGv_i32 z = tcg_constant_i32(0);
-
-    tcg_gen_sub_i32(t, a, b);
-    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -1873,16 +1872,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-    TCGv_i64 z = tcg_constant_i64(0);
-
-    tcg_gen_sub_i64(t, a, b);
-    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


