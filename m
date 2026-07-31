Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81625C55174
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsQi-0008MT-0v; Fri, 31 Jul 2026 14:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPW-0007S1-EU
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:47 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPT-0002F4-2X
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ce87c7e3bbso13925855ad.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524201; x=1786129001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GC3PuJ5nU2dAA6CO/lRMcZG7iiR1Dy/m71YIBt+D3DA=;
 b=H24v8xFlkRpB3Y3Bo2XE1GV+BQGsR81dFwRMyHkNduBOOO/Si763CkEnVylZ496Nlu
 q1rttkg2JJsCJqtpwrlcx3JSkE6AbgN5H1tS6LUKCfYV6W4ykRplnWYqD9IupGgVoMhd
 mWbfoPEZv2RJxY2Towmipu2SOBWwZvWU9FSRcQd/T7ttYh/HU83+bIRElkXwcQlQfpER
 bpZrmWa6kkWbCsjyebcwmYVDD8TDw3P9sVW2IvQgCcbioXQfXtf2zWBaTXwVdoizdwZt
 rgMZKMDKUXrOdP5ufgER0xyWGBUi3GTynliFR9wSVa4ddGpsmb0K/m10tBzmjtwIL1CF
 lRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524201; x=1786129001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GC3PuJ5nU2dAA6CO/lRMcZG7iiR1Dy/m71YIBt+D3DA=;
 b=qOpf5tovMYxNEpJrDQFWrM+tj5+A01raKF1q3cqzZpfgDriJwgmQd9Ur4I7GGfnino
 7bifk/fbFMUub4oLs0Y3S1rRYUJ9Ks23ICEIiSOjPasqDgKE8KVGOqXNUybwvKjgk3wu
 WG97v6qWdq+VX+fr0/F78APqvvEL5INjLFQ9UOwnnqBQI1+58A2eWLjGO5X2Spac3q3N
 n9VuSw3UIE4/2hVKKReZzK834TOsz+/xU2b3BHdZIi8kMV5lrCjL4s45zFCfpnlNyBO5
 YoAdF3nYR7GMm73heQRy9p08Ktgh8sRWnAU0V/J6L9EhzWUPrGw7sXUeXZcODVvhBiyw
 Zs0g==
X-Gm-Message-State: AOJu0YxUXL9tDyKjkKBv9z3GJKdwrjMvMM66nbUXQP7ydKQduNFFqY5C
 0x0htyqatO5XYZnNIM3O39X8dbvTtMrWgeShrlCLmxOVta+Uuajznq9VtI+gQQyivyG4ALRw5sf
 FxCjC
X-Gm-Gg: AR+sD11yqidYfxgeYY0Q+2nsS3Oq9DeX5r0bO9HqaoYe85V7qaq7y/Gb2VTTWQ/ktvC
 CEUknR7KI0gp/38sfEGduyNKwZygG8ros6FM5p0pQ7rnlf7cQ4ktceAjkMVfJRH4Znwk7wLjPzp
 aBqeUki/Ie6ylpOS0Mm7Fs7qbgRmhkgfMDZMI358Opq5gBcvoeeO0v1LsZs0gQe0fVOXL871Erl
 bHBR+suUVfYnQaNIJ02u5bxsRtvfEQ0gmLc0uI8Zws7RZg1eoZT5YqJkq7fsXfjsJPD08ObSHX5
 DfCLmbtJgbe7qy77MQ1yTcRh3+9aaEDWTUy1eDFoAxYWNtNapGH20T5F3GaN5SmjsI5f1jHXb8Y
 NpUzNooB9y+Ud/sVdI4b8U28QnmEmfIHesXQB7kX/iWRyL7KV/3ZiHhyRXIIwkK+XxmwzFN8Ag4
 9ox9jKo6eA6lqW7Rdxkmqu5rdicH+Wk1h1p13GDgq++x7CuBIIUVzSi6NJPd4hccROXuWs8upN2
 JpkQUqCd8YGRUxJuPh6hnvEVmLcXlg=
X-Received: by 2002:a17:902:f541:b0:2ca:5970:732d with SMTP id
 d9443c01a7336-2d0524810e8mr10726545ad.41.1785524201232; 
 Fri, 31 Jul 2026 11:56:41 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 13/14] target/s390x: Use op_st for STORE REVERSED
Date: Fri, 31 Jul 2026 11:56:26 -0700
Message-ID: <20260731185628.23161-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Use the MemOp parameter to op_st to directly perform a
little-endian store, rather than a separate byte reverse
before the store.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c     | 13 -------------
 target/s390x/tcg/insn-data.h.inc |  6 +++---
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 7c1961567d..09c5541615 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3713,12 +3713,6 @@ static DisasJumpType op_rosbg(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_rev16(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_bswap16_i64(o->out, o->in2, TCG_BSWAP_IZ | TCG_BSWAP_OZ);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_rev32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_bswap32_i64(o->out, o->in2, TCG_BSWAP_IZ | TCG_BSWAP_OZ);
@@ -5543,13 +5537,6 @@ static void in2_r1_o(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_r1_o 0
 
-static void in2_r1_16u(DisasContext *s, DisasOps *o)
-{
-    o->in2 = tcg_temp_new_i64();
-    tcg_gen_ext16u_i64(o->in2, regs[get_field(s, r1)]);
-}
-#define SPEC_in2_r1_16u 0
-
 static void in2_r1_32u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 691f8222ab..774a3cec36 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -882,9 +882,9 @@
 /* STORE HIGH ON CONDITION */
     D(0xebe1, STOCFH,  RSY_b, LOC2, 0, 0, 0, 0, soc, 0, 2)
 /* STORE REVERSED */
-    C(0xe33f, STRVH,   RXY_a, Z,   la2, r1_16u, new, m1_16, rev16, 0)
-    C(0xe33e, STRV,    RXY_a, Z,   la2, r1_32u, new, m1_32, rev32, 0)
-    C(0xe32f, STRVG,   RXY_a, Z,   la2, r1_o, new, m1_64, rev64, 0)
+    D(0xe33f, STRVH,   RXY_a, Z,   r1_o, a2, 0, 0, st, 0, MO_LEUW)
+    D(0xe33e, STRV,    RXY_a, Z,   r1_o, a2, 0, 0, st, 0, MO_LEUL)
+    D(0xe32f, STRVG,   RXY_a, Z,   r1_o, a2, 0, 0, st, 0, MO_LEUQ)
 
 /* STORE CLOCK */
     F(0xb205, STCK,    S,     Z,   la2, 0, new, m1_64, stck, 0, IF_IO)
-- 
2.43.0


