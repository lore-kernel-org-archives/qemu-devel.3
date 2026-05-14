Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0BBCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa1u-0001NG-SH; Thu, 14 May 2026 13:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa10-0000r4-5v
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:31 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0u-0003uv-JO
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:29 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-40974bf7781so77921fac.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780289; x=1779385089; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N5UaoIrDy0XdozflscGg9WWVkHGI3jcQyNZ+vEFK5ys=;
 b=VaDr0nFkqVeIFIurmFW1yti4oNiqPoq4XlS99GhVa1Wljr71RN9QNZtb4Hzm/n86+S
 9QEHn5q/Jrb/UVOVS6VPniPuDx7zrRbMq3g5eenNYHGBqunE4WLPKKQIMTiMiec1llkI
 GpKYlMt4q/uKgYyeqnZitZrhgxMuWg6Jhwt3cZJn41Faxou5NHkqA5cIYW4E22l3Yf/P
 f7NOdLBmJTR7zB4hFS3Qaoe4xH5pK8mWuzoaX8awjknwBFaa4yQXOSOyx0Iona4tHD3b
 cVCu2vC+MAe5OPL28rBq6nUexfWyMc2Vlxf3zWqcgBx5vQtfPf5AlJL4wZEtSUmDpOAF
 8miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780289; x=1779385089;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N5UaoIrDy0XdozflscGg9WWVkHGI3jcQyNZ+vEFK5ys=;
 b=crRA2uF9Gi8wBlxA24XfQ+rJBfkY6An9uufABfhYxQqGvN6HwQf2Se2t2K7oE9Gx4t
 jScexa+yGsp9dQLv+0BAuhtX7YggkP51KqmRzbRiwad+uRejMz1ln2huQNSlo6hodYCC
 00MUn+rUe2yhWgRw8aGYWKDs+XoQTGh3sIj33XOMu8UWfHVwdcAOeikfxCIH5SaEbh3J
 +VXsopnJQt4O1bRU/ZMmQ23uBlvpsUBIjaoNt8WUJ23GiSmKuiYVM7A+0IVdAyH6CdLK
 p8COjhdYxuWLMrUOB8bbaHDRPk5rUTVgkEptMwFMW9hEkqdYcMJ6su2ysZygrecNfHcg
 9r2Q==
X-Gm-Message-State: AOJu0Yw97tZYKEgYTxTLkN2z8p6Fctav3KB9P49neBGfqrXYdHLMPAF9
 /1NlAZ5TxXNHpvqcp6guZYfQcBV6QMlVQodZrJGkC1HfnbXTC2HvDmKX
X-Gm-Gg: Acq92OFgiGrNMPUbwc4RERB2GZ6lqxthjurnKObg6GOq8IyLU3wlzhAhQ7EfoSv1ixQ
 UE9Q51Iuhvch5WQTKFA4DP7sYoAtflgrHamqbnSwH73qEGsxCNufb9X6VgXo5I8jckrRiQakGGb
 3tTFDrr3Q3TAZV9izhbI/tU8+FyY8FYWj+Dz3KY/mVL+6JFcF8JG79eV2WyVZlzlm8Q0Wi7zh6O
 38TkEgshqs4vVZ1z4hQlteMDbtt9A9x7FLvnopcV0sj/MIaJRoEWr0k/vWbmuCb3tdLVm1wDzYJ
 3m3hcBXmO43be0hxvJpNysZ2s/XH6MTWdJ5YsvJygSWRNsHor09tCi+zN2Rp6NrIqugSe5zje/L
 bf8HbfEEwHge/waynuPk8EvdOK3GacIm7pjF+pwv16N90UrMQt/j4B4EJ+8n5j1qIK59SRg2dWp
 cf3B2JuMNktfVZZ3Dnm7BYVYiPdPuhksGrif4zOcs4tGPf10kYS+jaMcQiUa63q+CgwTQOqEzH2
 quKi9lDy/NkOGNII2jua9J6Y162NUqgOi6HuLGVQRLCI/6LxyeZezDMBecBVWxMcdNVDRoHs4OH
 0vo=
X-Received: by 2002:a05:6820:2009:b0:69b:5486:e86 with SMTP id
 006d021491bc7-69c5d3fb558mr266848eaf.10.1778780289523; 
 Thu, 14 May 2026 10:38:09 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:05 -0600
Subject: [PATCH v7 16/35] target/mips: add Octeon MTP0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-16-226686be4ce1@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2e.google.com
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
and P[3] and sets P[1] to zero. Model the architecturally unpredictable
P[2], P[4], and P[5] lanes as zero for deterministic emulation.

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

Changes v5 -> v6:
  - Zero P1 and model P2/P4/P5 as zero after checking the CN71XX
    register-state table and description.
---
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 5f5a509106..dbd77e08a9 100644
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
index 5c2575a5be..c25307d28a 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -260,6 +260,33 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
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
+    if (index == 0) {
+        /*
+         * The hardware description and register-state table define P1 as zero;
+         * model P2/P4/P5 as zero for deterministic emulation.
+         */
+        TCGv_i64 zero = tcg_constant_i64(0);
+
+        octeon_store_p(1, zero);
+        octeon_store_p(2, zero);
+        octeon_store_p(4, zero);
+        octeon_store_p(5, zero);
+    }
+    return true;
+}
+
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
@@ -268,3 +295,4 @@ TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
+TRANS(MTP0, trans_mtp, 0);

-- 
2.54.0


