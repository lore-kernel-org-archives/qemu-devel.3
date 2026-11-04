Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEF6074FA9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=Txc9TnjU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtH-0002xA-BR; Wed, 04 Nov 2026 14:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsk-0002K1-Tp
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:51 -0500
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsi-0002Nx-FF
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:50 -0500
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-36cad25b8b0so1632274eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821367; x=1794426167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wlbqFyGOSrRcr8i6c+NSyPYhZ2EEv9ADrZ7i6vIgKbM=;
 b=Txc9TnjUdMEeYyRJx4dGz3DL+PT7/F8T/PRCYEM7KOvFgDR0VPM98sTqqQX0cIeFqi
 Q6rPQuiH+jK9POJXRjoCImrH0RFGAP3bPFU9SXP15zbANWvyIIw3gVnxyh/kCTETty9V
 2ZTWpE/WsEcnVn8W9xybE6zlCm1mUi6qRxyGWIfayfd3AWc4/bPnEPuM+UDngsW+RFs9
 t5LeTRf09iQaObhXy5TckBq7cCDhFyblCq2PKUEcFPbcmc3SMcHVqi6sHeOPxLJa3uGo
 4WCn+sDp7SPUb84wPCDAaax/1c/speAQ6hxd1nhyXWpi9EcuG7Y/DNV01GisrRQ/Qbfj
 nHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821367; x=1794426167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wlbqFyGOSrRcr8i6c+NSyPYhZ2EEv9ADrZ7i6vIgKbM=;
 b=YkgH9HEu99pKNSNthPkMWaBTcm2dN3/ZVWFJITip+HYduomPzY4bopq9c0++nMKFUe
 vYPrIAJEObYkQN2h7FADt0/cn5U9o+F8KrYMLbLSV2Rith73ahJEIrZrZ9xGoWO1ftEf
 LJS3V7fWPt3Xk/+EVf1JoxqFr7f3ci3OYHOahorhDF7dCWct3cneZi4SNaute7OmXhZQ
 otu6Rg9XKEH8Ez+2nmDt9NK7SIxoy2PmT+KMecpz2h7QsdPMXR/R+uKsPl4qISb6Xi1n
 hP89vNSHQFUABIE3D6f566bNq9JCak8p/ZBr+Voq5KTHGzx3cxwWvbCSmS4gqCqvVAlK
 wMaw==
X-Gm-Message-State: APuU4Z/uBaQbBxWenGZWhhaQXGPgziZULmgJUazxkJJegQ1D6JKlC7qU
 wE4Zy/Alhk72uQy0eON749pVwgLRUZT4kfDyfxg/HkmouiYTCvYzhYNliYmlxgfkQwAnLBo+qUi
 3a6cP4tj7S0thl9JoQDpdGR4C+LJcWuioVxaHTYIVkHpCeGEoUNp8kUokwdZJack+yiBrdoDfEX
 G78H/ojlpJhwyiJ66KSy1diwcxDnv9PboAOZsYwm8r5w==
X-Gm-Gg: AYBFou33gtBOleuEP/ntndOsq8QuCScTcxz1BC4tbF7XL2y4nd3IecJWVu+oJKUiDrN
 NRQgtu5suT7jVNkmQk7l/rxD2pZkRgCzJqEW9Ct7fr+v4WACqYY3s/5G22PwPuGHChZ9YBrcuBw
 7+I5OE8w7ULYk4OQKtr6KA0g9V5saIVtgq5qVWgS5AUNoNOxcF5a8KnBzJW5V4wNdstoKmo1e0q
 qWmQUfvShpjKWtHH5u3W/1H3HSpS88/sb++xWpvWgHnCgFiLmdBjVzF8KPm+WoNxOGoOzGUU2Qr
 RUqntuYEzyjva79tz3OiIvIrdCc2CQRvqoh/GUuFilDf8AzruvXksDSIh2m6NGe6Uya8+bmeAYP
 PtA7jh+DaTRSojngBpgjh/8choC35yR1HhPraUGIzk8tlnvyQODhOs1Fo0Pi5wUDQdh1S4vz10z
 70yzu+jO70ewTSAektTIL7lVkG7rXdJTaAgRxO0WpwB0zHGDxKxcjxl7B1AnsJVU20ZV+wAnJmj
 B59mNYJgTT7HEogXmw99jTqbfXrl7b6lwQeo6zTk9/i30TlHOY63TmIW6F/g9UqH3S8Y2zxSooo
 AyGSdjsitqnwz5jJkjkTF9gwaxE/2CHUnwCv4F2zfLyZJuM4k2QGqbdnGO/a41n6j0+mq9k8Qlw
 aYH9hDBOYvPGzr4YlEY8Wk26Iyer1
X-Received: by 2002:a05:7300:c00c:20b0:351:7e5d:2de9 with SMTP id
 5a478bee46e88-36a422039cdmr28763515eec.1.1793821366788; 
 Wed, 04 Nov 2026 11:42:46 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:42:46 -0800 (PST)
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
Subject: [RFC PATCH 10/38] target/riscv: rvv: Implement Zvqwdota16i
 instructions
Date: Thu,  5 Nov 2026 03:41:25 +0800
Message-ID: <20261104194155.679241-11-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x132b.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend existing vqwdota* instructions to support both SEW=8
(Zvqwdota8i) and SEW=16 (Zvqwdota16i).

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                       | 4 +++-
 target/riscv/insn32.decode                  | 2 +-
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 5 +++--
 target/riscv/tcg/vector_helper.c            | 2 ++
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 767b04658b4..23d3e9b3c43 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1387,9 +1387,11 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
 /* Zalrsc SC write probe */
 DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
 
-/* Zvqwdota8i - 8-bit Integer Dot Product */
+/* Zvqwdota8i/Zvqwdota16i - 8/16-bit Integer Dot Product */
 DEF_HELPER_6(vqwdotau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vqwdotas_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vqwdotau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 
 /* SiFive Custom int8 Matrix-Multiply */
 DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cc7d639ab73..b8a5d0567b1 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1098,6 +1098,6 @@ vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
 vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
 vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
 
-# *** Zvqwdota8i 8-bit Integer Dot-Product Extension ***
+# *** Zvqwdota8i/Zvqwdota16i Integer Dot-Product Extension ***
 vqwdotau_vv  100110 . ..... ..... 000 ..... 1110111 @r_vm
 vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index befdbf273e5..fcff472a2ea 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -4149,7 +4149,8 @@ static bool vext_zvdota_base_check(DisasContext *s, arg_rmrr * a)
 static bool vext_vqwdota_check(DisasContext *s, arg_rmrr *a)
 {
     return vext_zvdota_base_check(s, a) &&
-           (s->cfg_ptr->ext_zvqwdota8i && s->sew == MO_8);
+           ((s->cfg_ptr->ext_zvqwdota8i && s->sew == MO_8) ||
+            (s->cfg_ptr->ext_zvqwdota16i && s->sew == MO_16));
 }
 
 typedef void gen_helper_zvdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
@@ -4159,7 +4160,7 @@ typedef void gen_helper_zvdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
 {                                                                       \
     static gen_helper_zvdota_int * const fns[2] = {                     \
-        gen_helper_##NAME##_b, NULL,                                    \
+        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                   \
     };                                                                  \
     if (CHECK(s, a)) {                                                  \
         TCGv_ptr dest, src1, src2, mask;                                \
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 6d79fb5d299..57a381098f6 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -6021,3 +6021,5 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,      \
 
 GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_b, 32, 8, uint8_t, H4, H1)
 GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_b, 32, 8, int8_t, H4, H1)
+GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_h, 64, 16, uint16_t, H8, H2)
+GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_h, 64, 16, int16_t, H8, H2)
-- 
2.56.0


