Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F706CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMty-0003WC-0L; Fri, 08 May 2026 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtB-0002fl-05
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:18 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt8-0001iH-TU
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:16 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-694891f8f62so1110542eaf.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253193; x=1778857993; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9OQ/YP9CUv1tumSDoHamd9129Jq30WVaMsclytj+5hE=;
 b=fN3omTMI7eQBOWLpBLrnhs+yH8wmb6xF/M5HH8D0r5zmd4dcWk0Na9Icbct5Ys8tKX
 EWogEukDGtFexs44Ohng+BChK1Y1wJOoxlAuwYsaWU6gSHXJ73c2cWoB6L0HV95ek89s
 WdbjgjDq0ri+YyB1L2TW8Oad5qQbDmpRf1zxj3bcvrpEg3BPMst7qR4lx+PJCTSlj2ge
 f3EHnwP9DDxuRFL68QsUgLrUxNEvH+aFR5y0zE0acaWdSQyqFJ8Lb0gWCRo4imJNfdfA
 Obln0jX4X/6leNEUKNTMyxuL2hNv8GGBC7JohVEOHSd0HJDEBvfrX2wM5UauLV7zYJey
 iTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253193; x=1778857993;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9OQ/YP9CUv1tumSDoHamd9129Jq30WVaMsclytj+5hE=;
 b=M6KMLz53bIEQruk0Odd6ocoNO+t4Vav9RoXxk3hWdcffNDmv7em9kr1X4+bzmTPA41
 8rqjcdsVDKfDi8QM0bzt/N2I0/VIP9PY2N/CvVUiXki0Cq7qOvrWtTYFj3tvy9HLvnJU
 scY+j/ORmxdjt3zJm9wrpWBKTk2r4KMJFOPaaOqpP3LLmlAE5L0ZMJ8XkAT74IriVP+8
 OaUJdmJef719vaJIugvwR76mJTQiyFarPF6eaushTfzTmYToEH1hmjgVwYOQNo52ph0r
 eiNnrYXy5pISLZTzZ6dT5RtAeG0kqNRCU4P1y+2WERmILHyyPuQIDriQpdx46NmPebD0
 dYug==
X-Gm-Message-State: AOJu0YxxZixw9+AJ8UL49bYPLTg8K/j3uq9+2Kw2lJzwmKZLDD3baj6P
 M7hOi538jdyOG9Tvl4JG+sBR+og9uZdgHKhs3ePGhdMA1xWB+OaDOAFYG1iR7g==
X-Gm-Gg: AeBDietc7Khozzc7XcQISYn0734aRxxWlPhufcN4DyUXY7zyGZ9z7MmZY7yPMmfyNPx
 yfiyrkRviMjuMkNx032n+7LTcZhCusfQ8psOOKmb++UIZL4Yf/g2QyMJwrNwuIPJkt0XXuK+LyH
 9TEPrMmcLAr2sBXX5HyNZmI1oB7Lf5vQZeNGY44qYiRdY9RVK/yyDqdaDbOC4PKMlPgsi9R80Uj
 8mH9OZWKz38T97JxFSBu9owdrWbUb+ReHpKRbKpRNqMhG6wg+AtG7Svk1IWHckjmiQeECJR0cQe
 frDzJ40SrduCxfKVj80sRaBUJcCEDnTp5XJTPPLJNUzfmmXb2xoWM9TkXxdvkrRVAQwUeeOb0tl
 2gY0jxRb0JmbTJg0rXGGNMVJU+kqjk59VFKz8eYb77z2uFyNIxRd43y0XQDU/qHjDVNxER5dgqY
 raCSYHFPexPMfAW348EwQVw+HlYccaQypospg2QOLPJVNYaf965eqHAzoAm0fAP3vKOCFfwz1K4
 O8LicjuUxGarYG+4QHkszj3XSqaDtWwZZQF/aWYzv7QimQkfuM2mmbnRrHBFCDBPE8ndde6QC1N
 53uTDV5VGkeFNb3BNW8Y2QngjjCny9VicLzarFUIiP16EzsZshwHVlYfjd9awTv5cxbQw34=
X-Received: by 2002:a05:6820:308e:b0:67e:1c67:ebb8 with SMTP id
 006d021491bc7-69b25cd22e3mr1612867eaf.50.1778253193227; 
 Fri, 08 May 2026 08:13:13 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:15 -0600
Subject: [PATCH v3 15/32] target/mips: add Octeon MTM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-15-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2b.google.com
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

MTM0 loads the low multiplier operand pair from rs/rt, starts a new
multiplier chain, clears the upper multiplier limbs, and resets partial
products.

Add the decode and translator path that writes MPL[0] and MPL[3].

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  2 ++
 target/mips/tcg/octeon_translate.c | 55 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 56c54e0973..2dadb13845 100644
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
index f94f765055..186200036e 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -216,6 +216,60 @@ static bool trans_ZCBT(DisasContext *ctx, arg_zcb *a)
     return trans_ZCB(ctx, a);
 }
 
+static ptrdiff_t octeon_tc_mpl_offset(unsigned int index)
+{
+    return offsetof(CPUMIPSState, active_tc.octeon.MPL[index]);
+}
+
+static ptrdiff_t octeon_tc_p_offset(unsigned int index)
+{
+    return offsetof(CPUMIPSState, active_tc.octeon.P[index]);
+}
+
+static void octeon_store_tc_field(ptrdiff_t offset, TCGv_i64 value)
+{
+    tcg_gen_st_i64(value, tcg_env, offset);
+}
+
+static void octeon_zero_partial_product_state(void)
+{
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    for (int i = 0; i < 2 * 3; i++) {
+        octeon_store_tc_field(octeon_tc_p_offset(i), zero);
+    }
+}
+
+static void octeon_clear_upper_multiplier_state(void)
+{
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    /*
+     * MTM0 starts a new multiplier chain.  Guest code relies on a single
+     * MTM0 load making the remaining multiplier limbs zero unless later
+     * MTM1/MTM2 instructions explicitly populate them.
+     */
+    octeon_store_tc_field(octeon_tc_mpl_offset(1), zero);
+    octeon_store_tc_field(octeon_tc_mpl_offset(2), zero);
+    octeon_store_tc_field(octeon_tc_mpl_offset(4), zero);
+    octeon_store_tc_field(octeon_tc_mpl_offset(5), zero);
+}
+
+static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rs);
+    octeon_store_tc_field(octeon_tc_mpl_offset(index), value);
+    gen_load_gpr(value, a->rt);
+    octeon_store_tc_field(octeon_tc_mpl_offset(index + 3), value);
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
@@ -225,3 +279,4 @@ TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
+TRANS(MTM0, trans_mtm, 0);

-- 
2.54.0


