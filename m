Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482CCCD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwz-00057e-Py; Sun, 10 May 2026 16:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwn-00055e-Vu
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:22 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwm-00040W-Av
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:21 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-479ef2b78f3so3131010b6e.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445619; x=1779050419; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sYJ+dfk0C/lnE4hsgv28nWlsixUDPo5ASDHcB2f3yhI=;
 b=Q9KpZWg87Gli7FTz0xbWfPJnsNnhmYzTIypBW7uDN6EV+AKojSedd7IhhR0XIneNeK
 C5+eb/JbXuhgzry4BgCKcqZqUAQ4erkJ4+c8BMTXRuXV6tEPIgagqljSLETP0WhobGlF
 kWRjnvjCPdnk0rTZP8DsR6i41og+mfgG5FTheKQeX+M0HpMN/ds1uthb6RKSx7P3QLfC
 UK0WQe1YNXrsFGjmdonWTvNYLCp48CobC92kx27vJdX1yCkUEtmFn6VcVddlSDgLqHzW
 +ZcUdZqk3dNjr3/6z3h5ftz8u5cwH/0TuncGMkApkhJSGFUokSmg9MwxhcDBvHANo0Oy
 HR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445619; x=1779050419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sYJ+dfk0C/lnE4hsgv28nWlsixUDPo5ASDHcB2f3yhI=;
 b=EwJSZbygcs6GuUTtx4LyF7GOmiJCQB80QWobcjY0TAEH8IeGL0m/1hxsraZI1Fhk1l
 YgmMQCseZiMICXp/yQSE3+HAQ5jB7ccw8ih5MPz5WmCL3lfoFBcqMjZFuxnmaQVj5/0S
 PgU4vEcBztjwLO+Ye4FrCkKPaR4xQ6KAgI0dspp5MMaAfv8zT7NLVcXMLwIdFAZ/rhJZ
 A1SkNVUzepDKMNIbOhmEwWE6Vgi8ScYjZY82PSdQtTs5eRuv1LzT3JTJ/BmT4jXiqXJV
 YSWwRKXQO3bNvKeFb/qpcuTgT/OsUx/rrbFn1X3oT8Cs8hICZTdDoIcxb20ykjCIWGpe
 CgPg==
X-Gm-Message-State: AOJu0Ywl2OdIzqi+pRBJ1i+5IFqIFxiyY9biXne4/sxiM0f65q3Sa9RG
 jR4TopUNw1xLJtUfY5CU2S9YUfmSevfXAmCe5JGyXiTSn3HOWdFqQT7S
X-Gm-Gg: Acq92OET9Mw/FQ4q9EQ8BpBjN19LjA9o3yEr20kTyqsLH+AlPDrXcdx8bqKwbMTpvKj
 gEVwVACKD8FQZ4KqoWVX8Nz/jdz5P22W/5CGz1bt/cDQa15ifoSCaXTzWiK4qWf3Su7WC5qGUp+
 H+7janLQpmx1+OPMXtG4So/8DRuMoEpQmU5FTwb839Pq1lcHeZn6zoRFjlAX+3x/I47go1VU2BR
 MY+L5jx7K9+E/vv8g0Bfvb7eE8c0ffWgPk68OXdnNESKjSnY9ES9pc2g0isiPCcFXTfxxqJO/gF
 J7X0RSNNuGB3kMPSn+V+7DYLo8L8mB6Yj/1M5KK+8M4p/cj9ak9EeW32qmYirGCGIHXBxGBZ71Z
 2eEuGsglfshPtzliRUf3zuafdSNzxCm9eYFq3m1zfEfLRibDyyUzdIC+abcS8APx8DgkYiCLMvK
 VJOkNMfOh4EwfSh3LE+leHKpVramwCCAw/meSZe7YOAgcVXrFoybXrZY+vzO0JAiGGE3BetVAPc
 lNMm4M6tctbbEZmaxx2abVEBqcBrIYU4L3+6tfD/Ks=
X-Received: by 2002:a05:6808:e687:b0:47b:d07b:ec9b with SMTP id
 5614622812f47-4807fd390bamr4994310b6e.24.1778445618954; 
 Sun, 10 May 2026 13:40:18 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:45 -0600
Subject: [PATCH v5 15/32] target/mips: add Octeon MTM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-15-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x231.google.com
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

MTM0 loads the low Octeon3 multiplier operand pair from rs/rt into
MPL[0] and MPL[3], starts a new multiplier chain, clears the upper
multiplier limbs not populated by MTM0, and resets partial products.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 two-source rt high-lane operand and document that
    legacy one-source MTM encodings use rt == $zero.
---
 target/mips/tcg/octeon.decode      |  2 ++
 target/mips/tcg/octeon_translate.c | 53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 5377f7b3ef..bf1dab61e1 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -43,6 +43,8 @@ SEQ          011100 ..... ..... ..... 00000 101010 @r3
 SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
+&r2          rs rt
+MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 3373f4532c..126aa41b21 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -198,6 +198,58 @@ static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
     return true;
 }
 
+static void octeon_store_mpl(unsigned int index, TCGv_i64 value)
+{
+    tcg_gen_st_i64(value, tcg_env,
+                   offsetof(CPUMIPSState, active_tc.octeon.MPL) +
+                   index * sizeof(uint64_t));
+}
+
+static void octeon_store_p(unsigned int index, TCGv_i64 value)
+{
+    tcg_gen_st_i64(value, tcg_env,
+                   offsetof(CPUMIPSState, active_tc.octeon.P) +
+                   index * sizeof(uint64_t));
+}
+
+static void octeon_zero_partial_product_state(void)
+{
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    for (int i = 0; i < OCTEON_MULTIPLIER_REGS; i++) {
+        octeon_store_p(i, zero);
+    }
+}
+
+static void octeon_clear_upper_multiplier_state(void)
+{
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    octeon_store_mpl(1, zero);
+    octeon_store_mpl(2, zero);
+    octeon_store_mpl(4, zero);
+    octeon_store_mpl(5, zero);
+}
+
+static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    /*
+     * Octeon3 two-source MTM forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(value, a->rs);
+    octeon_store_mpl(index, value);
+    gen_load_gpr(value, a->rt);
+    octeon_store_mpl(index + 3, value);
+    if (index == 0) {
+        octeon_clear_upper_multiplier_state();
+    }
+    octeon_zero_partial_product_state();
+    return true;
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
@@ -207,3 +259,4 @@ TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
+TRANS(MTM0, trans_mtm, 0);

-- 
2.54.0


