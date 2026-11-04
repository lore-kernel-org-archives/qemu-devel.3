Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F567606D820
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=eNlNaFwN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtZ-0003pn-1j; Wed, 04 Nov 2026 14:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtW-0003mU-Tc
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:38 -0500
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtV-0002am-5e
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:38 -0500
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-36d6e342f98so1156421eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821416; x=1794426216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5AX5eJ/pPbJ7vuc/TMSU+a639LFRMm0l50hu5KtjQYU=;
 b=eNlNaFwN6HdTGkHwkLIkD5F2gd2FWz13J5ZOeNhTCBpedvjBQlX77Ugxyix0v5W0rR
 Z4wYjJhoLHVc5xN6eJU7ZDoylW9GZjWb90isRg+pGJ3OzugY9iCfj7ez/7G8A/xsxdT2
 JxwpIHqQrKTLoq0tXgDE9k3H/rLSqBKhYcxk7Sb0eamsaOZC3YzlO+PS5M5G9mlyqsPG
 xJ2Ex09Dpjelnk+WxoekKSSbq5UxEwzoyXyBmnG56P2md3QWz20Inixvq06Imf31vBIc
 NwSX8W14eq4CqsIsAnR6c8wY46ouEdyyB/Az/tZ5wX3HIqUz1wPaSZX9TVeOfJU7HUSY
 Dk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821416; x=1794426216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5AX5eJ/pPbJ7vuc/TMSU+a639LFRMm0l50hu5KtjQYU=;
 b=k6DboG5ALp4d1fZcXQPyp5X0uijoogl8/9OLW2D2FKqRDuCb37QJBI6QFGYaj2IszY
 UKbJdGvzseF/b2lUm7YNk6qkWy5TeqbDoO5vG7pgWTQ7VACLRGjr5ekvRRbOjXwJRkFD
 ApeH0aAYqCtaJSySMoYhKr9Q2ja/QQLQ7qplC5zpeBM9QOcyU9QW9LlARcCFj1q2PVal
 zYhQlG6sP0lJGKcESEPJfpmMPhfLOTNt3W2i8PaWSnza7XnIHJXe37vWf81ucrLMM2lm
 /L0zxZg0D5TRvgfjwuTCNrZk6ntzVeBRtszTIE4aKz3CQ62vC2jhnQtmbzAjzfbD6Br0
 gU6g==
X-Gm-Message-State: APuU4Z96/+fGsWpEFyxszX13ay6HFEvao/2YoshUea7vlnDomEesLkef
 8mLVq7hYWgCSZWKcgq+uGERXdFmCTdryEWf5QCmOuQnSSigXz0MXHVSAErZ8MsnChpGc5/lTP4G
 XvYAejftqzv8QYAtqhkD+ex7z9H3LY1PUeB6p4j4BtUl5NvGVCrcBWch1rojN53ItjK41XJq5rI
 SWcqus0/HjgY1pyl6Dck9j4qWHM6xPfsPsh5/0c9ROEQ==
X-Gm-Gg: AYBFou1kDHt/JiH9v6s8xzYmy8hW4znky9isBnEeAlyEnheZBWYn2ymnNpGo2dYyUiY
 o62hpvHaCZVCupNhYqewlTzReJE/xq0cz0rPK4nGr54fu9tcyEaqHPl6sjr2pyl/d6jkoiuBbTm
 JVZ/iNHmMdnHIK3M+42UxyFys7Do1OUBnnvdj2g5rBJ/h34qRq4CLn8pTkGjcoofo1X9W4smFAz
 m719snYPrpHCOnUDv1UUJIRM3cQqfCbee1Y9s6LWJxDU8TGyH125j32JxhI9sh+59AfOcDea2S+
 HMmcVXfXBhCEs0cx58kI2F7TCrrwHWd/vOsBa1ogE2in5QluU21zgjohTnE+UuakIR0QSlzHFlf
 d81l4Hk9zXVGoFjlJDo037nmauc1qrh1hUIVq9W7L2b0VbMTTdyWu8AQS7N5o0JLL4/FISlSQbz
 3hjPiK28sBQth+fQLv3CvVeXU8h2372KqxBsQYNZm50fro/VnanB1PBu8ctGLrdVjf85KfLC05m
 8nDuztpsh8RMUMFQV/40IIV/vB5ggX1CeedPvEHLCuWNvvX5KkHOEcIyWBRFqLyA8W9HSGsp5QO
 z6hWwhtL/vI9qhZMq6jrnPsOhaRhKl7lVuqZYMS7KiuocinqbzvFd/qzl9t6vqZO0pDOmOTtDhH
 ubxLvYA6BLO4tUMUwpPpvc6QqAPuTkQ==
X-Received: by 2002:a05:7301:2a24:b0:36d:48e:82de with SMTP id
 5a478bee46e88-36d049e0895mr5101557eec.12.1793821415401; 
 Wed, 04 Nov 2026 11:43:35 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:35 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 25/38] target/riscv: rvv: Implement Zvqwbdota16i
 instructions
Date: Thu,  5 Nov 2026 03:41:40 +0800
Message-ID: <20261104194155.679241-26-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1331.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend the vqwbdotau.vv and vqwbdotas.vv instructions to support
both 8-bit (Zvqwbdota8i) and 16-bit (Zvqwbdota16i) batched
dot-product operations.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                       | 4 +++-
 target/riscv/insn32.decode                  | 2 +-
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 5 +++--
 target/riscv/tcg/vector_helper.c            | 2 ++
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e48b9b4edec..84571a999f4 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1400,9 +1400,11 @@ DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfqwdota_alt_vv, void, ptr, ptr, ptr, ptr, env, i32)
 
-/* Zvqwbdota8i - 8-bit Integer Batched Dot Product */
+/* Zvqwbdota8i/Zvqwbdota16i - 8/16-bit Integer Batched Dot Product */
 DEF_HELPER_7(vqwbdotau_vv_b, void, ptr, ptr, ptr, ptr, i32, env, i32)
 DEF_HELPER_7(vqwbdotas_vv_b, void, ptr, ptr, ptr, ptr, i32, env, i32)
+DEF_HELPER_7(vqwbdotau_vv_h, void, ptr, ptr, ptr, ptr, i32, env, i32)
+DEF_HELPER_7(vqwbdotas_vv_h, void, ptr, ptr, ptr, ptr, i32, env, i32)
 
 /* SiFive Custom int8 Matrix-Multiply */
 DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index bf325229100..8a06547a570 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1109,6 +1109,6 @@ vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
 vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
 vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
 
-# *** Zvqwbdota8i 8-bit Integer Batched Dot-Product Extension ***
+# *** Zvqwbdota8i/Zvqwbdota16i Integer Batched Dot-Product Extension ***
 vqwbdotau_vv  101110 . ..... ..... 000 ..... 1110111 @r_vm
 vqwbdotas_vv  101111 . ..... ..... 000 ..... 1110111 @r_vm
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index bc12bcb9b72..650affc045b 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -4315,7 +4315,8 @@ static bool vext_vqwbdota_check(DisasContext *s, arg_rmrr *a)
     int32_t sew = s->sew;
     int32_t vd_eew = sew + 2;
     return vext_zvbdota_base_check(s, a, vd_eew) &&
-           (s->cfg_ptr->ext_zvqwbdota8i && sew == MO_8);
+           ((s->cfg_ptr->ext_zvqwbdota8i && sew == MO_8) ||
+            (s->cfg_ptr->ext_zvqwbdota16i && s->sew == MO_16));
 }
 
 typedef void gen_helper_zvbdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
@@ -4325,7 +4326,7 @@ typedef void gen_helper_zvbdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
 {                                                                        \
     static gen_helper_zvbdota_int * const fns[2] = {                     \
-        gen_helper_##NAME##_b, NULL,                                     \
+        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                    \
     };                                                                   \
     if (CHECK(s, a)) {                                                   \
         TCGv_ptr dest, src1, src2, mask;                                 \
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 5ea073b6d76..683b14f28f3 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -6197,3 +6197,5 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,                  \
 
 GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_b, 32, 8, uint8_t, H4, H1)
 GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_b, 32, 8, int8_t, H4, H1)
+GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_h, 64, 16, uint16_t, H8, H2)
+GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_h, 64, 16, int16_t, H8, H2)
-- 
2.56.0


