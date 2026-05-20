Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B577CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgk-0001CK-6K; Wed, 20 May 2026 00:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgi-0001Bv-VV
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:45 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgg-0003pj-08
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:44 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7de7c57b52cso4050302a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251859; x=1779856659; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PvDFLIp/PQLu75d/Ks+DYHupg+MRvJEmazWLJtuvb4M=;
 b=bPmi892ZutPTRd/cWzE9y1LygTUl9oc1lyiwAI7IFQHFGYD5XCNkOOzN+o7bFFDW1J
 njxeEDCs9mw99XHo8WYSoJi9sEPtvuEFBT53WS+s8IUkW2t14nlOA5SFM9ejeQOMAMpE
 JKXp+fdBOBs7PPs0iZ8J+bBRrhDZ2t3iNSMvn7G+tixliHBKQyitxBS3dMk+Iv28sGAo
 vUjsfYylalqoszxhAgUs1kdBKtgdrKzKfgy8/l2y2RsqkRtiRNTsZfRc5+yIIk7+69bZ
 eTlIW7S/4BhfgwZDHgbvz7DW1T6lQJEakVsah0BuTLopjHM2u2OHvexdKN0gyFP+At1E
 9F0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251859; x=1779856659;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PvDFLIp/PQLu75d/Ks+DYHupg+MRvJEmazWLJtuvb4M=;
 b=OUwCQ9INzNvk60oOKYeXVz4AITOpUT/097Z6qiG8AnuDTC8X07f3O4mxxdJZ1dL1J9
 S2afgWC1y/BAkRpDoXfmmwZJ6iCwwuEy0TjNOm/C+6OzmSUWuk+zxGDS8OqX+G+q5r8u
 fYWRR+QdCQNaiFmHv747bqWKDaQ4TXwV6Im2ng0Cojn7hSJcn4hy4qoHDTV2vFyEFjFG
 kYvTT01ygxJ5/YzQjXUNNsY5NFBESlPNJlU7Yclb9clo/rbRpL2gEVE8q5SzkF/w+3Ns
 BZ6LDd03UJfQCdhrAiYbLjidIq5YQPUX+k7gKi5hd5lgqk5RsF41o45ICn5Z6DBh63rr
 1VKg==
X-Gm-Message-State: AOJu0YxQmYSYZTxCswaomqFxIW0BdbbCKjfSyZXS2tg1DxdMjmC+IE3M
 htSQM4eA7otUFIGpD1QtvENDELmZo3Q/DRaBhCeG8+oEuAmn3hsTrIO4
X-Gm-Gg: Acq92OE+9KeO/gCn56djaCJD/94/Q3+bz0kzr7yupHh3HYeWJCPT1i4bwdJMqD5doob
 k9wy4lNpckqNprhgpcXHrQgHJPJsaalqNJW3nO3wwYzY4tU2zyXSwg25ads9XdKWtG/U5czOrte
 eqmTQChxHifVJQawpNuydbnsrkrU1+YFe0ADXJhSMurKE/muEudrZobFyEKcu99JRhsnD+kB7VK
 KEFXcS9BO2YC2JNm659l0NklnGn1PKPtSPoF/5DRZUu3S5K2pBkvqF9UmjSTxrLDBtTLvnvzklw
 8MidB2xmPvj1ToIPk4Ixifx8CrkzxHJmgTdCzbX9OOyAiJK7IIhjf7WyEgw0K+J4I+UlX02Fl65
 KtiYzKy9gJ/ZXmTqw6QlvXkUSUM9oQhxIrB8/yOktrwbIB01VtyxPmSfT9GqJyG8glidIY4a3SS
 lXLaZ53Cf7uFb+TW6C4AxbobjzySefksW31AWQIkqgIV/iEv2PRfCx8bcf36MngDqCGl6u43c8f
 mFtxNtXQfOCs4cIhCs2NIqiyCQIetzXxwdh5oragyiO0hP8DRnZHsuKIrPA/E+t0NhDq53GaZbX
 aO0=
X-Received: by 2002:a05:6830:4991:b0:7dd:9b19:a87b with SMTP id
 46e09a7af769-7e4ea072138mr15025826a34.4.1779251859480; 
 Tue, 19 May 2026 21:37:39 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:15 -0600
Subject: [PATCH v10 21/45] target/mips: add Octeon QMAC instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-21-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

QMAC.0x and QMACS.0x multiply the selected signed Q15 halfword lane from
rs by rt<15:0> and accumulate the Q31 product into the Octeon HI/LO
accumulator state.

QMAC updates the full 64-bit HI/LO accumulator. QMACS saturates the
32-bit Q31 result in LO and keeps HI<0> as the sticky saturation flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v5 -> v6:
  - New patch.

Changes v7 -> v8:
  - Use Richard Henderson's v7.5 inline TCG translator.
---
 target/mips/tcg/octeon.decode      |  4 +++
 target/mips/tcg/octeon_translate.c | 60 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 4d0ad05834..2d02b4e0bc 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -28,6 +28,8 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
 # SEQI rt, rs, immediate
 # SNE rd, rs, rt
 # SNEI rt, rs, immediate
+# QMAC.0x rs, rt
+# QMACS.0x rs, rt
 
 @r3          ...... rs:5 rt:5 rd:5 ..... ......
 &cmpi        rs rt imm
@@ -43,6 +45,8 @@ SEQ          011100 ..... ..... ..... 00000 101010 @r3
 SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
+QMACS        011100 rs:5 rt:5 00000 000 lane:2 010010
+QMAC         011100 rs:5 rt:5 00000 100 lane:2 010010
 
 &r2          rs rt
 @r2          ...... rs:5 rt:5 ..... ..... ...... &r2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 04e51538f9..e068fd8698 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -356,3 +356,63 @@ static bool trans_V3MULU(DisasContext *ctx, arg_V3MULU *a)
     gen_store_gpr(tmp, a->rd);
     return true;
 }
+
+static bool trans_QMAC(DisasContext *ctx, arg_QMAC *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    gen_load_gpr(t0, a->rt);
+    gen_load_gpr(t1, a->rs);
+
+    /* t0 = rt<0> * rs<lane> * 2 */
+    tcg_gen_ext16s_i64(t0, t0);
+    tcg_gen_sextract_i64(t1, t1, a->lane * 16, 16);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t0);
+
+    /* Saturate -0x8000 * -0x8000 * 2 = 0x80000000 -> 0x7fffffff */
+    tcg_gen_smin_i64(t0, t0, tcg_constant_i64(INT32_MAX));
+
+    /* HI:LO += t0 */
+    tcg_gen_concat32_i64(t1, cpu_LO[0], cpu_HI[0]);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_sextract_i64(cpu_LO[0], t0, 0, 32);
+    tcg_gen_sextract_i64(cpu_HI[0], t0, 32, 32);
+    return true;
+}
+
+static bool trans_QMACS(DisasContext *ctx, arg_QMACS *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    gen_load_gpr(t0, a->rt);
+    gen_load_gpr(t1, a->rs);
+
+    /* t0 = rt<0> * rs<lane> * 2 */
+    tcg_gen_ext16s_i64(t0, t0);
+    tcg_gen_sextract_i64(t1, t1, a->lane * 16, 16);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t0);
+
+    /*
+     * Saturate -0x8000 * -0x8000 * 2 = 0x80000000 -> 0x7fffffff.
+     * Accumulate overflow in HI[0].
+     */
+    tcg_gen_smin_i64(t1, t0, tcg_constant_i64(INT32_MAX));
+    tcg_gen_setcond_i64(TCG_COND_NE, t0, t0, t1);
+    tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
+
+    /*
+     * LO = sat32(LO + t0)
+     * Accumulate overflow in HI[0].
+     */
+    tcg_gen_ext32s_i64(t0, cpu_LO[0]);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_smin_i64(cpu_LO[0], t0, tcg_constant_i64(INT32_MAX));
+    tcg_gen_smax_i64(cpu_LO[0], cpu_LO[0], tcg_constant_i64(INT32_MIN));
+    tcg_gen_setcond_i64(TCG_COND_NE, t0, t0, cpu_LO[0]);
+    tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
+    return true;
+}

-- 
2.54.0


