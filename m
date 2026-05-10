Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1843CD3447
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgZ-0006Ef-UD; Sat, 09 May 2026 22:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgT-0006CZ-OR
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:22 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgR-000310-Fi
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:21 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-694891f8f62so1745013eaf.2
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379257; x=1778984057; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hsuL5VR/FNTPLzMDNh9wQQ68lfB9N1qvukmj0Rz5IBs=;
 b=VjXfHpMjVXy8MEFPk3hgGAbUjU6BzdeQLShxF5SM8OvkRcB3og+nIKRRNpQQU06sQ3
 d7NsVpOK0qkdpzS8d6w/ZhTWhBoHQVFOeGuqdVlS4p5n18iRrJdJlIB70Fkw6sb9w5wv
 xB025uZ4P5dBhouw5JZ7zzn7CJqt8LmkQYfTHcLHkbQ7CJNPptRNKEg0w9is+GIeK+Px
 lUNq09UxLnxsysXp08bjVLS7jQ1dz1IhgsaQQhCSXIQ45JWzy5tw3Q5/MoJ32j6gAZFv
 UtC7EB1kHCYP2uFvZ2iig7Zm+L1g2cdIm5/OFFSkdedRg0gTbPcLIXvbYFnyDhWp/z3u
 mwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379257; x=1778984057;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hsuL5VR/FNTPLzMDNh9wQQ68lfB9N1qvukmj0Rz5IBs=;
 b=RtEKSKaq9RFwGv9uD+E0yEjh2VHQno9st0YNXqtGrTme6wvtwMpCcdM518jkDeu2HA
 4vXzUwn9qxUREuLikfxIkXpmCOhotZuelZcS+Suzg6LTTJNw2Eskdul4EsJmwNCYPQlA
 9GajQNpBAoCRu2kKquUqhkGT7FmrJQR6kODh13sfMThtRyZhI/8cjfsHCm6O6V5cyziP
 crM06Vb8Ysnzt9cBsSgz2Vet4Eu7UtnVRxajAkFqMoZslhlSpmkgAZUqt7xrzPLaAJrs
 LWijmrqfbW+RnQpneCjkPHpKQg6gl+IL0bq05ADpr2HjBRWwzmjn/vlaj5WZKqlmwfji
 Mpsw==
X-Gm-Message-State: AOJu0YyTUfogYJg+Y7983IQApibol4jvLMt/bBJwAbHRWBw/+o9Hw03M
 ep2n7Ya+hnmD3fgo9TVcYsEF/PqwEDm3M0W2+ZMg70iLD19eiHa71x85LyY9SJL3
X-Gm-Gg: Acq92OEtO0t7eNvHUltp2bMr74yCo1mFbKdLBPxWSEr/l0oDiKkB13dCGlgMAqP+GfB
 OfkATIwqtq1IXYQQTUNdqhk0SgQXVbfK0qvlCYzlnwv0QNYI8yZBp6HKeEPPlzHAl7ARlifplfz
 eiTKE/cDqO5T05BQdYA1WROkfFNXhvEP/g5XAZ31QumqJMX9fzFYFHpiZAt7oWMPfmkWbMMfSbP
 /KGtJUiCZ55CR1rtKTaykYCRZZxjXQu0/GYv/+bpn9V7aCiSsXiOnkAR7/SIxpIhY55Ym/ZQyOl
 8BWwZNQTIjkTCdbNP837mYst4JtXiISPxssMUrRFqIV2m4lklmC+Upi4cgR9Cc4qok1pPhX0kXF
 POQAoidEuy7Bf0XLhdq2C6fBIO6DIQq2a/mBlaPP73ZEh1YbebTLhPgnEWhKRWYi+1/XHpdz3Ry
 d/vYEcyvMPFDGQ8FvKesJNte5I7XQqARFJyzeozlcQR4RYQxJNv35O8QjkK+GnDFxGjylS2s03I
 FDDW9XmWDh+FC0CnoRZ0JkYWZv8nokMn1xgfPBKClYxHkPOlNdedPBB6qznK/COhrpDATBIQvo/
 JT8=
X-Received: by 2002:a4a:ee0c:0:b0:696:1cbd:27ac with SMTP id
 006d021491bc7-69b25cd2391mr5123265eaf.49.1778379257102; 
 Sat, 09 May 2026 19:14:17 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:45 -0600
Subject: [PATCH v4 22/32] target/mips: add Octeon VMM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-22-d669dcd05c2f@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

VMM0 performs the VMULU accumulation, returns the low result, then feeds
that result back into the MTM0 multiplier state with a zero high operand
and clears partial products.

Add helper and translator support for this multiplier chain-update
operation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split VMM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 MTM0-style high-lane update and set MPL[3] to zero
    when feeding the low result back.
---
 target/mips/helper.h               |  1 +
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c |  1 +
 target/mips/tcg/op_helper.c        | 16 ++++++++++++++++
 4 files changed, 19 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index f1e78ae329..46ccad95c3 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -25,6 +25,7 @@ DEF_HELPER_3(crc32, tl, tl, tl, i32)
 DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 DEF_HELPER_3(octeon_vmulu, i64, env, i64, i64)
+DEF_HELPER_3(octeon_vmm0, i64, env, i64, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 1c3dbb4a33..8a909ffcee 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,7 @@ MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
+VMM0         011100 ..... ..... ..... 00000 010000 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 6c2edc2d47..0a4c359390 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -307,3 +307,4 @@ TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
 TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
+TRANS(VMM0, trans_vmul, gen_helper_octeon_vmm0);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index ab3fb06a16..124855d4dc 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -176,6 +176,22 @@ uint64_t helper_octeon_vmulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
     return sum[0];
 }
 
+uint64_t helper_octeon_vmm0(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo = helper_octeon_vmulu(env, rs, rt);
+
+    /*
+     * Complete the VMULU accumulation, then apply the MTM0-style state
+     * update with the low result and a zero high operand.
+     */
+    env->active_tc.octeon.MPL[0] = lo;
+    env->active_tc.octeon.MPL[3] = 0;
+    for (int i = 0; i < ARRAY_SIZE(env->active_tc.octeon.P); i++) {
+        env->active_tc.octeon.P[i] = 0;
+    }
+    return lo;
+}
+
 /* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
 target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
 {

-- 
2.54.0


