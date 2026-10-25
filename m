Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30436606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZXyudkbt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsd4-0008O5-Mo; Sun, 25 Oct 2026 03:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZv-0006kW-4J
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZt-0004A7-KF
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so15514025e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913016; x=1793517816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OFTN1Zep8XB9HzO4dfKq4nE+bgZEzNYwB242zHi98Uk=;
 b=ZXyudkbtJfxPz3DWjl9Anu8kHp6s2L0HGvXRB/LGKDvVQLyz1hdO8wVTALGuWtyNlf
 MZXZgpB7KcQEVfZqBsmAg+X48MKx2wUuDKoFSy8hBoMGlUh0HNYL16/zrgI+1IBEhKLH
 5olnEhmu7o1vwBdqy+blwC0oRop6FYRaWPNtkz8e5A7WxqnGziTfYcw5uoqD1l5HKPDD
 7bVnYUx+LUkWDUhwMIs1FIY7eAC4WXoOG+M1lcwMd6p0EDXGGdRKZDgCbQdZRxUaxtT2
 VcyJdF4n/sQXH072BTvzLxJRirIYTAIJWEbuHj2YpPE/Li7adrD8taKEYk91psJm/+3d
 UCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913016; x=1793517816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OFTN1Zep8XB9HzO4dfKq4nE+bgZEzNYwB242zHi98Uk=;
 b=j3VuvPES3MZUVfC9th1kkW+eQnZM5mBE7gHGL1Q7Yapd2J4iLRMRR9Kvi2PQ8WlSdn
 w45hjUk4DYV9VTmo9t9dK9uPY4fxVvsnNGv5FZR9ZJGyrGODHzxDJ4fFueCkIlvKfUA/
 R0TM13/Md7vti7lINiqWlo0NK5nOxyO3tAOImBvjf8PHQpVAAcaobnHHQbhwfYlgj3wG
 nUQKteizLHMsEQ0LpzOgyGVWRhRBbrs+6BT6TTpydBmGTD+pM4JHA1verJMBS/kgBZBL
 ri5Ouzl9TXHSH7VmR/1mJVVFM6X26Qk6U+uIlEat6keM8bR+jJoPaNDMGJ20zlr/DpH1
 C6jA==
X-Gm-Message-State: AFq9FYItJPTeFHMpova4Zzou40JEBXmox1MIbQpNwssIlD/TLpyV22gI
 LBqtJIFQ4wTJ7Fw3MYQ2QA98XJGBOSsv3AHUza4PfKR/fDxuhJoXiby07URWDPTvBT9vLcOp/NO
 R0w+Jrqc=
X-Gm-Gg: AYBFou2traIzZsWRn9b0f0ueRo/f+UIhK/BS7GauU0uTOh/V0/2EAutpLCwauLZyzQ5
 xFbrRwInwnKS58J+tjfLM1aSn2vmmSTxOTSmv4GHTDj8WJMlgBtTcIGWKlU0iBT9rQOFvt68DA2
 SoOw7DNtZDLT9xXhLqa6U30IPOcQ5SNGGeXrF8ZkOBcHgzjWGwWPWgDXKna9+R4wzufejb5tjY7
 PeybKIGrnJLDYDX1xAaF2wRnEmipoJ0yBDaLM9nu2VfDU13PT/baqQpJT8Ew3W/bgZ1LFOan9yZ
 FsZvzQg1aMLnGX1r2H0w/vGwY39atc0ltFqZOjIlL9qln99lBFw5zQHQLbpK5uEkrbJ8/rW5cLY
 OT4SUJeGCoctEBtuvKbtLIzmHmfiSPYVBACxYARKA8IGlTqt1xGlvci2Ftx/qQsoDdzFctwmqh7
 d9lTY3IJvr9RbHoLp6jiXYw2xjwvtoncT/X9tpGkJ9SxaD+oYS/kBgrj9+pr9afOe9/nZGKbeHz
 5VtzQo9pNho2usmYOb95StNVpg4qkWK2lxHxa8d/nT7oIfHpyn8mA6LX4g=
X-Received: by 2002:a05:600c:8581:b0:4a3:5da2:38ae with SMTP id
 5b1f17b1804b1-4a35da23c55mr37069505e9.14.1792913016187; 
 Sun, 25 Oct 2026 00:23:36 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 076/100] tcg: Use umax in ussub if available
Date: Sun, 25 Oct 2026 08:18:51 +0100
Message-ID: <20261025071915.1123867-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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
 tcg/tcg-op.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c5329a8d95..f6cc56661d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1086,9 +1086,18 @@ void tcg_gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
 
-    tcg_gen_sub(type, tmp, src1, src2);
-    tcg_gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
-                    tcg_constant_internal(type, 0), tmp);
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        tcg_gen_umax(type, tmp, src1, src2);
+        tcg_gen_sub(type, dst, tmp, src2);
+    } else {
+        /*
+         * While umax can be expanded with movcond, some hosts can
+         * perform movcond with a zero source in fewer insns.
+         */
+        tcg_gen_sub(type, tmp, src1, src2);
+        tcg_gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
+                        tcg_constant_internal(type, 0), tmp);
+    }
 }
 
 void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
-- 
2.53.0


