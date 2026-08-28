Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A4DC61DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jm-00010e-5c; Fri, 28 Aug 2026 18:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jl-0000zo-19
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:01 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jj-0004MO-Fi
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:00 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-398a4dcf289so319160a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957098; x=1788561898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TDtoQykOTtlGAaVG6Zeyqh1hYI6bis39S05SlVKKuoY=;
 b=Fe7wS8Mehn+sS7xacLQnCGy03bpt+2PJ0kKpmjXAHvGgWi0a7choU+RpG+fAkPkDkO
 NpteCYAx7JTQ50Kg7pLvZPiH9M7GNhqg2irZI0OdYKSrRd5Bf+h6wDMJA8xMORd00VhA
 VSdfzldPBOT//Bt+cm9foGtHNElJnw77LPoUqBld3b3DlZ+srzNQHuegV2yz/qLvP/tz
 UW6RsJHnvlOlSxtJZ3q87nUBfGA0srLbE2iTYQtdF6NHlL94Plwjd7zkx3gINCHFPOn/
 aXwhT1a0/PCZwdDKEZPrdHXCzX/n0z5UAp1NJoG6+nEsOHhGpiLIIDL0amIj9S/G86+P
 K2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957098; x=1788561898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TDtoQykOTtlGAaVG6Zeyqh1hYI6bis39S05SlVKKuoY=;
 b=Lv9hWSYkxWX/7YXslowNQ7oJden8rV30r0W3NDZPhKDwPSTaIYDXkP3MvfM1zE8f0w
 DD0jkkHzgzB4S4lZCq7L6wA3omF/W1eTsVhIWCUPtcCW61oFya+zQASX3TErl2Rwqg3i
 9wcXi520BStWoJBrDwAA+oOx/qFF5zZBAjPrGuzVGA0XegZMYEO6P8cOTrFPEx2LGi7e
 U0D0h4vqKSgbK927O14FB+ZN4+oqgywq6Cz5K4t681/vhhP3zx6QITAabi1U/7acHbVE
 ewjb//oZtnrCGR79+bo6OxvO382ws+TgrWYijBfS7x//8tRdp1VBX2s8vJ8zcbQDX/Vq
 y89A==
X-Gm-Message-State: AFuF++kFLQdCwkE32EHka4qK9QfIi18zpKw8S0CGL9mxG8DKAXAaGceJ
 15O8oOV/zIu5C9fA5UsTeGQBpStKv1HHh3gMZ8Ub8ktzHakrCFY8+GcxyT+MOrGdGZyX1oiJXPv
 lqQdF
X-Gm-Gg: AYBFou2op94dsSDlwRl9CR5fn0p7qJB08CiI56xC22aUnonvjK46QnWyx7NuMBAu9b0
 FlxWkMCffWpsbBefSVxJRrEw2QEgSDR2kMy719Wxx8pzpDq19N8Em5djwED0p/V00/qyLjY47se
 f/UljgpVlWVLEyrY1+9GT3rabiR4nvr2rYhHblbI3LbNp/aHsU0FWBGhMVlvQwqYqTuumnwHuae
 RxMcijjGKmJFrYvmHNcmb9aGV8XWNOsJPE8onI+B44NFTVFGrU/nAjm3IQR6O58+xkTjPg9WSUX
 skue9xsJUa0lCeLtytaSPjNP9+/TWmr0XXsHdWiZHyvaHhwydsaxGMGu3qHfYbCZaB3s67StE4x
 llkjgZNgTDCokEeo+wONO9Cz3GPO4VrrmUXBWUSbB8zhz57v58TAnhUTDGT9svU+ROAw+rU3G5u
 6Hgh7OQk/2/YFk7JmPlWt+X4++HKRd3vEC65sZRNH67b2a5qeByGlPQGNLfYZWc0WHF8qfSFVWw
 L7TYcC+Fvt9TW1WKipF
X-Received: by 2002:a17:90b:4a92:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-396d0f75f22mr18127561a91.9.1787957097988; 
 Fri, 28 Aug 2026 15:44:57 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:44:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 06/16] target/loongarch: Use tcg_gen_lea_tl for ALSL
Date: Fri, 28 Aug 2026 15:44:41 -0700
Message-ID: <20260828224451.1564072-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
 target/loongarch/tcg/insn_trans/trans_arith.c.inc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_arith.c.inc b/target/loongarch/tcg/insn_trans/trans_arith.c.inc
index 2be057e9320..c358e642649 100644
--- a/target/loongarch/tcg/insn_trans/trans_arith.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_arith.c.inc
@@ -188,9 +188,7 @@ static void gen_rem_w(TCGv dest, TCGv src1, TCGv src2)
 
 static void gen_alsl(TCGv dest, TCGv src1, TCGv src2, target_long sa)
 {
-    TCGv t0 = tcg_temp_new();
-    tcg_gen_shli_tl(t0, src1, sa);
-    tcg_gen_add_tl(dest, t0, src2);
+    tcg_gen_lea_tl(dest, src2, src1, sa, 0);
 }
 
 static bool trans_lu32i_d(DisasContext *ctx, arg_lu32i_d *a)
-- 
2.53.0


