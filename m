Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF60ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z0E-0004My-Ld; Tue, 23 Sep 2025 05:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1v0z0B-0004LR-Ul
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:08:00 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1v0z06-00005c-Io
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:07:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2680cf68265so39420455ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1758618467; x=1759223267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvZnoVopgO+vVIobVK5W/azjACmzwY/8WsAkXBWzMOY=;
 b=nPYLCub83pkFOYgcDMv22CPTOzymanxbNYR3euSE5+IyYiaips9CRJggwnuOIx6I+9
 o67Q27votnxgX2IHURYLMfUFvZ76y4IPHcoHd/7xp1/yJWOORcqZGuaGlGwx9fsJDzK9
 Zik5RL8KoSA1RI5VI4Tju8UgoHPPbBMFGuTsGmVeUIkU/IpZ8YXrcdzpAsAsjWPGvS0s
 0rjwL4p6OrZuuZb7SPFDuVEMiL+dEWDoJtzeQU2fM+BbIOUibtwtPbrDl7NGd7UKfFfY
 e+oqwqZAmte+4D9VyLpOqVS+IiCsyZXs4QieK9bPFkHqF4uHIUIKpjeVXGkHGP/Xob7W
 yxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758618467; x=1759223267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvZnoVopgO+vVIobVK5W/azjACmzwY/8WsAkXBWzMOY=;
 b=AtsJJrd1UkxgkwtGmkoiOJfSZePVKvWxtPwNOKNlX7UTysnpQZo5ki++fKVYqn9Pka
 1FlERhnVXwDegv24WwpT6SJI5vVeziWkbl/KvhCfFr4fQvtCAhVNaZKZjNdAnA0ctVSt
 ul4XEKPgaKT9lft83ctTBxl6VGETAHtKs3CmL1S/muNJdVQtbRNxojoKYLnQudiPhj+5
 4gkT+FyX2qzkUGR2cyuSGGBop1U02fKYXaMCi8o1DDBUW9Oc5tISi6zHmQNlzFzqC9Uo
 hp8xtMI/E9URTqnmqk9LI3ddUwvHtrnHuesPQDjxxRkYMRw1GRUgTB3/X83Hn40GY05K
 7UqQ==
X-Gm-Message-State: AOJu0Yw/hGweU8Vwq1q3wouksc3HZ9FLZel2OeOZS2L9qqmtI6+dBmfs
 pV4atl53UJx9S7HqKatE1T1SFD5w2r7FVhk4ozkb8F7Rdvau6hPCFMY4KOAo7MYg5EKz6TeKLOQ
 OX2xji6KwT3wY5xumzAACFz1VpzYGQpkvYSqHXlwsdww8Mc4Y2gs28vKIpq/x1j2RzvzyabMadK
 f5EX0hzg9iaF9aWsab/HC1S60lZ3EN5ZoRFLs3xGNjFA==
X-Gm-Gg: ASbGncvNyEYJ7OGVarnsT07p3qdr6bIK70/ZTlmg4YRTSxp9KOknimT949h++3fXTVr
 2JxXYX1Gh/kc3CsceQwJR3E1yLQbT8MOqcLu7AH4siDxfdLk0Ro1V8aj2sMTaX7tK6JH3Dd3b19
 k+7Ph7OCDxDRnc8F8cj5DTlY/Hq+cF+/8KOCxk/Si2XpXAstRhqJHG3IB8o5Jh9K9fPORG4Cv3P
 We0VkiYoKe/vDbG+7gb6DGfaiTEKgce/vIdum9PQ56A+XWYGRGB7sBg/JpU5yKQOguHAcgbpBYw
 whFkRHNyc1vaXLCC/thmwz31neHmm7DUdlxq6t3G4K2qSQx0jwQLFTom0W/9vt0T419uSeov6lR
 LqjvJp2Rzlj8QM6IocWPeBowV7XsGIIqhlPenviWTK3MUkb6DYqhkMt1SDNu4rvF4Jig=
X-Google-Smtp-Source: AGHT+IG+0y2srJ2JYUnN52fG2LoVoYCbwcMfOcRxg+HWUMV0x1Iqgukvc0dqT1IWn4sB9CqDe14KzA==
X-Received: by 2002:a17:903:19f0:b0:26a:ac66:ef3f with SMTP id
 d9443c01a7336-27cc09e378emr21133705ad.8.1758618467437; 
 Tue, 23 Sep 2025 02:07:47 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269800530b7sm157486245ad.18.2025.09.23.02.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 02:07:47 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 2/2] target/riscv: rvv: Modify minimum VLEN according to
 enabled vector extensions
Date: Tue, 23 Sep 2025 17:07:29 +0800
Message-ID: <20250923090729.1887406-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923090729.1887406-1-max.chou@sifive.com>
References: <20250923090729.1887406-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

According to the RISC-V unprivileged specification, the VLEN should be greater
or equal to the ELEN. This commit modifies the minimum VLEN based on the vector
extensions and introduces a check rule for VLEN and ELEN.

  Extension     Minimum VLEN
* V                      128
* Zve64[d|f|x]            64
* Zve32[f|x]              32

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a6f60f55ceb..02d99bb0ae9 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -416,12 +416,21 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
+    uint32_t min_vlen;
     uint32_t vlen = cfg->vlenb << 3;
 
-    if (vlen > RV_VLEN_MAX || vlen < 128) {
+    if (riscv_has_ext(env, RVV)) {
+        min_vlen = 128;
+    } else if (cfg->ext_zve64x) {
+        min_vlen = 64;
+    } else if (cfg->ext_zve32x) {
+        min_vlen = 32;
+    }
+
+    if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
         error_setg(errp,
                    "Vector extension implementation only supports VLEN "
-                   "in the range [128, %d]", RV_VLEN_MAX);
+                   "in the range [%d, %d]", min_vlen, RV_VLEN_MAX);
         return;
     }
 
@@ -431,6 +440,12 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                    "in the range [8, 64]");
         return;
     }
+
+    if (vlen < cfg->elen) {
+        error_setg(errp, "Vector extension implementation requires VLEN "
+                         "to be greater than or equal to ELEN");
+        return;
+    }
 }
 
 static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
-- 
2.43.0


