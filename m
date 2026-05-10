Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD089CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgT-0006C9-Gp; Sat, 09 May 2026 22:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgL-0006An-9V
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:13 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgJ-0002zq-K0
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:13 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-694891f8f62so1744991eaf.2
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379250; x=1778984050; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vDX8dRI7Hk5zUwiHnLCdrc7s4w9HEqumDFR0gqHduM0=;
 b=DuCGH9hq387ZxENNYLSupsJMZNr1233jKDih+FVN51LCm0hg7vd+aCG4HXB0aHE9g1
 6wXU4TykVaKhoFHWrnuTFdk6BCmZq5UdpUFDWfhgcEFTqHb/4bQkUje+51DoX7Yf/F8O
 aOdzp5gD11sv5iZey3f4Kc9At8KtLYilQm24L+s0SxCel2b87bo4rw7nlDwYAHuV0xND
 yDrGlKEuY+g3KR0+KvDGhfw7dbYqMlbCiYqa6YUiF2yeUQYMFPPLVRebs4z36DYIXPLS
 XQE/H4SrvTI+TjyMxyxQsWKb2TO4QrZi/sDfpVZ03y8QsNkBjWFY8wfudra+0fM2qDwe
 pLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379250; x=1778984050;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vDX8dRI7Hk5zUwiHnLCdrc7s4w9HEqumDFR0gqHduM0=;
 b=gW/drxYNlQI57lqjA+5y0iGGYca9aE06vZgPETaqTh6avbSFTB9tG1szMAmM3JVhJv
 Qdh6/TilaYxOeDKnuKhtbDfsPnVpt41d7tB7AjLLR0s7E7K/K45/Mc//k6WDz+o2IeM2
 YtOrDpO9eLqJJZCNXrTauAUqgmAfO+HK4cJSScGLV6nExu5moil74VMNXoYHXBPHUTY8
 msRYDgYMd5RVBTjZxb8aApX1h6kdbCEndHeCThzS9amSZuIKiTaumNf3PGi0gxt7BLft
 MLDsxqkhtP4uNzi6zNqjPWgInH3dwJd4cQk2Eb9o7MAoo6Mw99Y91mhX3knqOn8R/swH
 9iYg==
X-Gm-Message-State: AOJu0YzWfoCtt/Wkx44OHuZlH9NcldbTb1Q0dCB/qiW/s+IkudxzNVfG
 Xkomz0qP73J6QOIL6jWAokBU1e6Tut3J62rZzCEZ1NTgxR1l8CxULj8rpl8VhjXX
X-Gm-Gg: Acq92OELOQejhF6aq7D1B3G1eZMUGkVNDYWToKIfKrYPKMf2+iVEib6J+F6O5oXYJB3
 8xn0iNCQpAdklDPtWdtex4JnpqriDFf6pZsJ+bYrjxaFZmOMNrhY5d44u7EfVygfIl/gRiEwkkz
 uZRG0h+Vtq0foanjM9pEqQLZbSosrF/j3kWoSFfRhuCcdHPT37q0fU6VpXo3rOrFg2sbj2lRsxM
 6a6fnHR2u1rsBMtQmbdqCkwR3tnvq1x9SmsZr363oLbZxCJIJsv+kVzOFMwLBMH4PxqomYWqbT5
 Br6SMoqMCJY2nGL6Vp0oQKVvdhUMoII3TZW5eFOIRemCgx0eQ1yWGb7n1OjaJGXLQkpWp14YhV3
 YttjyGNQt08onovMeMJ6dia5uEcBPCwBOl6khpoCGc1clIThQTxPr5GZeMUzz8ZMT7RnQDTW5Nz
 sk9Ky2Ho+lKoiDX9ND+PwTiIRktLCiuWPSsKyQ+gBO++BEL96/3OTnoD6AqWIp2ADMH/i5w/mhy
 FhSYg9Pm9nR/74Y06vyRCQlzwDdvw2+C8qxLH80si6WQxE9ceOUldsraxTG4jP5SMoF
X-Received: by 2002:a05:6820:8c2:b0:696:6bf1:b8da with SMTP id
 006d021491bc7-69b25cd0c7fmr5202875eaf.42.1778379250021; 
 Sat, 09 May 2026 19:14:10 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:39 -0600
Subject: [PATCH v4 16/32] target/mips: add Octeon MTP0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-16-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2a.google.com
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

MTP0 loads the low Octeon3 partial-product pair from rs/rt into P[0]
and P[3].

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior. Add the
translator storage path so subsequent VMULU/VMM0/V3MULU operations can
consume guest-managed partial products.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTP0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 two-source rt high-lane operand and document that
    legacy one-source MTP encodings use rt == $zero.
---
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 2dadb13845..94dbc356ec 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -45,6 +45,7 @@ SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &r2          rs rt
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
+MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 9f1c1471c5..0af4c34263 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -260,6 +260,21 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
     return true;
 }
 
+static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    /*
+     * Octeon3 two-source MTP forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(value, a->rs);
+    octeon_store_p(index, value);
+    gen_load_gpr(value, a->rt);
+    octeon_store_p(index + 3, value);
+    return true;
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
@@ -270,3 +285,4 @@ TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
+TRANS(MTP0, trans_mtp, 0);

-- 
2.54.0


