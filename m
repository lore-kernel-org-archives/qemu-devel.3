Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D664BC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOc8-0005VU-Nw; Fri, 09 Feb 2024 06:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOc3-0005Fe-Ry
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:08 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOc1-0000Vm-Qj
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:07 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-59a87156cb8so296248eaf.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476404; x=1708081204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aspT/yStwOjA8Zs21ikdtZZGlWfkyKgdWczVX8G9hZU=;
 b=C1K8TivY3snxgrZn8CLHXN3UfSAFPR4T31o8khGYO/W9Yt78YYIlZwuIlbXKXNkx1l
 tU3EOfoq1GYk2kcBxXi6WVGhZNwtJybbcDyzFCsB8ycD9f6W4+UwTP7fg2/thtlDoHER
 XcRmToEWL8ZA1sf8Asv6xKwDi8C6AKKUIi/ZXDHkTK+dYQrCN003RreZPcg5zStoRvZv
 jwIlgMOPFSb2kF4r66+8WvVo7CVmHNhYfCqlPwFtkxkRxL7jsMRJxes6DjPSEUIvZsUq
 YafAVZRP4k85yQ8ZXrMPZvM+LpVZuy4D+gEukvVAhJhmo0g1Q1FUnz55prHbz8RKXIqW
 kjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476404; x=1708081204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aspT/yStwOjA8Zs21ikdtZZGlWfkyKgdWczVX8G9hZU=;
 b=CoYQrrNBaoWIL5//h5XjxKDvGW81UR9/VD0iHaR6gqwW7hKlT9zRGiDQNcWJUD5bQy
 00NCNXRwq2ShsiXP4+zRPYoU12OC0/rwzG8GZbJh3kO37Cp1QUdDUcIWyd0vbUK6j1nU
 gY0je91M8yELb4rDTtACYIycztSOfaja6GVmDnTcs/zh9E9BqwhOj46dyLWy4GQOcPSh
 1YgtQy4NQUjqowIMBZyQEjyvCCcHjtacP+VoeiZBqV+Q6heG2rv4nSEoWMwBPWsORe8R
 rBLiU4yC4H3S3CnZ9OL9uYWZZ5wihyR3Y53xVsAOpYEUoNr4t6+Z7PnLS0jn175/BR7J
 Fu8g==
X-Gm-Message-State: AOJu0Yw42GYn9YRuGSL4Vg0z9B2OY+PpyoomPrduGvUxhVPHyAHnPvN7
 baIVWplpmOYDbBEWxqlMCVAwb2+f/rsSuCYyP4uTCTU1z1XjWqOxvdQGMEeEgTdcQQ==
X-Google-Smtp-Source: AGHT+IHAURR+iXsS7NGiZSSyOEADMr7C3W5ZioXFEu8vEAQ0FMVGVE2SIvDodYmVCm+LfxvVb37aBQ==
X-Received: by 2002:a05:6358:5288:b0:178:20ea:abb5 with SMTP id
 g8-20020a056358528800b0017820eaabb5mr1289873rwa.26.1707476404496; 
 Fri, 09 Feb 2024 03:00:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVqoS1ICn2qy9a5XYpmiZD9p+kiSWHwnb5cFSU34I51ONWAiziSu+cVnWFqqq4vlvXQaj0j7d1GD9UOM7FT/n9/3U/jwxIKLafYgc+C9ROjmXFmbOW/OllUSpDXeh5W7ozakllbPt/82w7ebP4/pHq1LaJYYqOzSD77ynPtFOl0muY=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/61] target/riscv/insn_trans/trans_rvv.c.inc: use 'vlenb' in
 MAXSZ()
Date: Fri,  9 Feb 2024 20:57:42 +1000
Message-ID: <20240209105813.3590056-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Calculate the maximum vector size possible, 'max_sz', which is the size
in bytes 'vlenb' multiplied by the max value of LMUL (LMUL = 8, when
s->lmul = 3).

'max_sz' is then shifted right by 'scale', expressed as '3 - s->lmul',
which is clearer than doing 'scale = lmul - 3' and then using '-scale'
in the shift right.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index d743675262..b4663b6e1f 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1160,12 +1160,12 @@ GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1, true)
 /*
  * MAXSZ returns the maximum vector size can be operated in bytes,
  * which is used in GVEC IR when vl_eq_vlmax flag is set to true
- * to accerlate vector operation.
+ * to accelerate vector operation.
  */
 static inline uint32_t MAXSZ(DisasContext *s)
 {
-    int scale = s->lmul - 3;
-    return s->cfg_ptr->vlen >> -scale;
+    int max_sz = s->cfg_ptr->vlenb * 8;
+    return max_sz >> (3 - s->lmul);
 }
 
 static bool opivv_check(DisasContext *s, arg_rmrr *a)
-- 
2.43.0


