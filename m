Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B551DC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jnw-0002ax-0z; Thu, 17 Sep 2026 17:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jns-0002Xr-2E
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:00 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnq-0007bi-B1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:37:59 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-85469e211a3so102288b3a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681077; x=1790285877; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=juiLt9ox1Yu3ouhwl1G9qu9k2hfhd5XaUtW+KR/HL8Q=;
 b=NFpoyBYlIbK2n1rC9v6i/34dkeGpIfiRoBYXbkks896zy1aS6ngGnK5kH1vBL03qmt
 W704sAc24iZFg0NTboRrnzp7bMBnSVfk0BMSbtwi6qz7I4BIK/PMh2fWiF2eLiS8wrjj
 Sgmj1kCV/oJHyv5loBAeHWSJPy49Z/8Mgei4T/k0NwbySjSu1Het93z6en9HkopUlLU0
 cO5hiHVt3mogfAVYl08AvfQ/ScQTQZ4b2ehnRtk6/0q2/brHNRhiJhUywMVMWs8VgOPz
 XQs0/j1TJB4ci5CpGtzH8izc1ucJqFkm9jauivqmQ97KvVKc03osJ0yK8tKHF5ESyiEO
 Sysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681077; x=1790285877;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=juiLt9ox1Yu3ouhwl1G9qu9k2hfhd5XaUtW+KR/HL8Q=;
 b=ouU4w3sdoFlNkNRQvDczs+bvIoMrE+lrVFMqlyJsSlpee8/DmDNWyMsc+/w1N2PJHc
 /G2/r/G3r5vR03iMbBTZWvW0W4iHTYF1PrIiXrHMRQB/wkVxH4I18HVrrZ9V1nH4t6FJ
 UllcYKGZ20ERwdQtq3gTt7sWj9W4cyBi6zaAavr8Sp8IHNQ686rf9IKM0BS7xd78tVn5
 RlL+8blFMtgXAzLpRPa6wHT5y5TW6rJXakyi7fI7y7fBw+yOd4PUifWAdBHVYfZRJQBt
 3tsuGPJP2TT1fSbmDbVqvbMs158kb3F+SJ/+rhxp/aSqyLZNFOGLM/lumyyCdvPNwU1D
 7ycw==
X-Gm-Message-State: AFuF++mk/vTjbBTTcmaEeU9SQsr8kGN2GxVzmXXQyCQi3gdwRTgXLLR7
 Y2rN8hS4RJg+2CsBc1Wo9LaeOd6W9GuCxJU76cv/r3giaYTSYyYES48OcMAtcs/oSGW+8m5eVp8
 aOLevbeI=
X-Gm-Gg: AYBFou0ye/AdrQK2wA4LYshdBdG/3+r5hr034D3mf4Z/8ZV4OWwE5La+N/F1R5vR5PN
 nhxzSTzhFIadIOMz5jFpXrlFBtH5Irg90H+rFypaaSrQMiqQoz2/VzcH9BzO51AzWhcvd3Ufv0U
 NNP6dGIz13M/vahmjBEqi8HFaya98ElPlk3C+U30Qova8DMPUcd0sdpvqcqVzNSPALmc2PHXCX0
 PsmZrnQ4inpc4OQPbgBKXPyP2HXCz6wEjZurvAYP8RufUJ0khec6moq9JdBxZLmqmuWwJ08nCCK
 sI+WmgfEczo04fEwQx+ToNUm9/9E5VJ4fzAVwNs4ss6hvnZ6oM5JPFpwZuc1J1M7m7WvGBpTiaO
 HYedIt5t9dBVVrSYF/T3172/cb53CaLbAs/8VqnXUmd5FG0LCZho0TrY5WflYD0Nj/jczVGJJxH
 NIJZTiqi3HqZv+Sm56YsXJ8z4syM+fLp7BpmpHPi8e5CoRoV49KeH3Rqd3HxNFHAUowr2aY2xtJ
 DEF+8c=
X-Received: by 2002:a05:6a20:2453:b0:3d3:ae40:51e2 with SMTP id
 adf61e73a8af0-3dd8c541c69mr598483637.22.1789681076941; 
 Thu, 17 Sep 2026 14:37:56 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:37:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 04/15] target/s390x/tcg: Convert op_ld16u to op_ld
Date: Thu, 17 Sep 2026 11:37:38 -1000
Message-ID: <20260917213749.36756-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-5-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 10 +++++-----
 target/s390x/tcg/translate.c     |  6 ------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 68ce6c2b198..23b00a0eeba 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -530,13 +530,13 @@
 /* LOAD LOGICAL HALFWORD */
     C(0xb995, LLHR,    RRE,   EI,  0, r2_16u, 0, r1_32, mov2, 0)
     C(0xb985, LLGHR,   RRE,   EI,  0, r2_16u, 0, r1, mov2, 0)
-    C(0xe395, LLH,     RXY_a, EI,  0, a2, new, r1_32, ld16u, 0)
-    C(0xe391, LLGH,    RXY_a, Z,   0, a2, r1, 0, ld16u, 0)
+    D(0xe395, LLH,     RXY_a, EI,  0, a2, new, r1_32, ld, 0, MO_BEUW)
+    D(0xe391, LLGH,    RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BEUW)
 /* LOAD LOGICAL HALFWORD HIGH */
-    C(0xe3c6, LLHH,    RXY_a, HW,  0, a2, new, r1_32h, ld16u, 0)
+    D(0xe3c6, LLHH,    RXY_a, HW,  0, a2, new, r1_32h, ld, 0, MO_BEUW)
 /* LOAD LOGICAL HALFWORD RELATIVE LONG */
-    C(0xc402, LLHRL,   RIL_b, GIE, 0, ri2, new, r1_32, ld16u, 0)
-    C(0xc406, LLGHRL,  RIL_b, GIE, 0, ri2, r1, 0, ld16u, 0)
+    D(0xc402, LLHRL,   RIL_b, GIE, 0, ri2, new, r1_32, ld, 0, MO_BEUW)
+    D(0xc406, LLGHRL,  RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BEUW)
 /* LOAD LOGICAL IMMEDIATE */
     D(0xc00e, LLIHF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 32)
     D(0xc00f, LLILF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 0)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 31239866180..b724db6a1cf 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,12 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld16u(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BEUW);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_ld32s(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
-- 
2.53.0


