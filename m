Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCC9CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2L-0002c0-3x; Thu, 14 May 2026 13:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa14-0000s2-1m
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:36 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0z-0003un-Q1
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:33 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so4343445a34.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780288; x=1779385088; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KZsvv6p5cZvZoDnqfC1gela/J0EtKNK4FpfAaUgVM2M=;
 b=FAywqoWjqYydVAYmP6ULWS/GJftMQCPpKAlyFft6lN5JbxIqd0IbjfvcuUh+N/i332
 +/BCcWex+yIQZ0YGI1OaExM4ow1naGmGv6REvbpeUUAP1UOcIVr2ZOK6ykacQkT7OLSS
 LCfnbdg56sncz/o8kNVwEjWSbei0F2DHr5uKGUjxSdzbK9GXdRXtuHfgsy2hN0cf2jbm
 VGHLxZadUhNwCxZAuBInyD5A/umYT7t9gV76fNchA//wRuz6xfUy6c4HEiyIyDMG3wbK
 RsNcbF/S2fjUfCCYLZcQLO2B1xmjdqOWOphw7Z4Prvu3uwIaA6X4Ami1IrzvCqSUXTtL
 jlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780288; x=1779385088;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KZsvv6p5cZvZoDnqfC1gela/J0EtKNK4FpfAaUgVM2M=;
 b=FfUmzWZJeyOtKWFduNiTGoKHF3c6LQKDvRSvBZSh4MmhFipQeBGK7odJIOlTu3z8/v
 cvBtJzs1jqEM3h0rXR6I7ORP3XotFGuTyIT+sHbodXlNIMO+5ARjrzpHLc7EzHuQe1d3
 rlWXp0cOmjhiPgJiX+AFyBpe+VABOVSibAbCZBMW+1mCSWsaQ0FB99YiiRGmuYiqAwi5
 PCVSTrW49CstTf3iFWmD8HIYk321VVm47H7Svtjp0po+/sg6BttEp0Hkwm0weujNdpmi
 6eNK1IhelgltSqGYXj5Ixm4ude8qt+UT3LFQWry7K9mYMqY7FWnym4VL8AewQoCyC2h4
 X0SA==
X-Gm-Message-State: AOJu0YznZMB0iWy+QDqn+Rdttl41ZQuCMJj3dawpsOEp9iFws4nWYqC1
 KD2500J0675OOWNVtdT44ccI8c9IkJfeUYDArIKzjMyV5BlYgpSGRJ1r
X-Gm-Gg: Acq92OEoWn1Y5VGw53UXRMkTdFbkhfB1xUtufBXfoYc9U2Nk9UtFIz7QZBVkBWriJCW
 nfbyIE+nFFuC5qSkXgikkx0AJ8G6daJ4dW/dFf+xsUv8jjImAuJeG6t2LzF1Wm8nNGMySrJmv71
 cIUUmDOFkA54DClOjxdWk0I4eXq6VyEIhlGzxI1C6HXuf2wbe2N3JhQ0M8hEKCdBTy48fIZx1sf
 NEVYpBn5i7wZ5kuaOrtXpFlOu9sZmRBy0GO8ereycVxidPtqQR4t0Pwet2DKT/6NzZUHzMy/Rxx
 VCKEh4UCJUECViv/+LyhpvvFxihte6sOYoKEIpmmrKY1U0gjMupouUcxeKF8X7F3eQhHhf3QLVj
 gM10K304YVWx7dh2x+w+QmSZlw9k1vnhTyF9HPbpwnhTi20AbnelTVaMV0QFeBQOoxEuroo8ZJC
 IDQ+Wf1fHnZV+JXk1yDq5aeHBsnElye9meaRyjriHiIXKwm4elRNl7mkMG7G2wOGchNWDlTzBrM
 SY1T+9GzTLQ5Ha5PVReuZ9gyh9BjD7Q+B3njLacgkma5um9/vKeWYUDgNbC4eTJ8Ds9
X-Received: by 2002:a05:6820:629:b0:694:9175:9d47 with SMTP id
 006d021491bc7-69c942ffb16mr253961eaf.18.1778780288406; 
 Thu, 14 May 2026 10:38:08 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:04 -0600
Subject: [PATCH v7 15/35] target/mips: add Octeon MTM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-15-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x329.google.com
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
MPL[0] and MPL[3], starts a new multiplier chain, sets MPL[1] to zero,
and resets partial products. Model the architecturally unpredictable
MPL[2], MPL[4], and MPL[5] lanes as zero for deterministic emulation.

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

Changes v5 -> v6:
  - Clarify the CN71XX-defined MPL1 zeroing and the modeled-zero
    unpredictable MPL lanes.
---
 target/mips/tcg/octeon.decode      |  2 ++
 target/mips/tcg/octeon_translate.c | 58 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 01ed3b50be..5f5a509106 100644
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
index d89e53045e..5c2575a5be 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -203,6 +203,63 @@ static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
 
     return true;
 }
+
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
+static void octeon_reset_mtm0_mpl_state(void)
+{
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    /*
+     * MTM0 defines MPL1 as zero; model the architecturally unpredictable
+     * MPL2/MPL4/MPL5 lanes as zero for deterministic emulation.
+     */
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
+        octeon_reset_mtm0_mpl_state();
+    }
+    octeon_zero_partial_product_state();
+    return true;
+}
+
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
@@ -210,3 +267,4 @@ TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
+TRANS(MTM0, trans_mtm, 0);

-- 
2.54.0


