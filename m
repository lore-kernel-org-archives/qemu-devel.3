Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C21CD5BAC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkg9-0006cq-II; Wed, 20 May 2026 13:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfn-0005jA-CE
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfl-000457-Pc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso35977925e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297929; x=1779902729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXj/+PY1yntAjcWodCob3h4dAJStyqYMpQ6tLHI9b0s=;
 b=ogrLu3HWt/m2X23yCGZHoFNMw5Ow3JUAUL0FdMs5loCkbHo9lBLJJ6EvnF6PkTU1b/
 Wt4SZW/zFxjjHJciKRxpQjUtFM/zkwAH6FzmqaHg34inVQCeVGVT8Nn87uN3l89JsP4C
 A8BQiR6aMGrp/btsDJcbduIIHTT4MWnVMjHKTgh0mREt8EkA0pC4GZwElSaI4MDd0DYF
 ETsIFWmBWoUdi5O9uqxFYY6cXVpX5N4RENB3JrXcozPzvOK3h/vOwYcIbeSefeGIEspL
 471SjyO3v7yLSrsLJvRG4T0Dvm/Lr2MwnEmcSwNM4W1iMKkK1pVKKMdqsljleaMMfjUE
 pkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297929; x=1779902729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NXj/+PY1yntAjcWodCob3h4dAJStyqYMpQ6tLHI9b0s=;
 b=R9XvaqCiLFHSt9PoUQN81pGniBMx1moZ/abytTxTubm3DvXh+pErvoMVx08rkVjqbp
 R46M+LjdywehskfhljOvWNLxHvOCpTb93+3BbbKblkx8FdVLG4+uQMc3gfaQivkXaDV3
 jnD0DiFJ3LPMGPg7UnD+giaH4eoujb54AJOV20vgXy4Ff/1kYyBLcJGNpkv2x6Pa8xx+
 jp1sPVz9IfVp3UJk+lBeORtcvMmPagkF75bnmEY3zMktW/tU3oEncG0ijWO6UTXWnPBe
 3DBQaNkbsLZ+GtFhNIW7a0Ae21mGMeIaGwhiU3JLxqjV+PLhRss38IZTS013vc1+OtUg
 cZqw==
X-Gm-Message-State: AOJu0YxOPsPSu0GgAwFRAeR+Bgbkyiw6Z+4dMfUksmUcZS8tiM8+5pUM
 aftMtquA+saHWw1roujUTF5mewoTOqH9xj/Vrhz9OmBybBcNUFNANjCo3M0wITaU80eFeH/F3mR
 wZQhHRuU=
X-Gm-Gg: Acq92OEggbowhMkVgtGdHEDA8y4B1B3JAluT9uYRq67EFU6QdV3l7tAy8B6RfOSOXVE
 SaMA1mA1iGAStWC5NekRhE+B/LNbCy++2c6IpCve+IrODnvjNZLtMSQuI+YIcNYm1/eioayCUUa
 ZijZOO4b91XqL3sYwoWamEzPrXpKu1Uz1pbX47Mq28ZbJXb7DPqobfqUDNRL3teAZg3aY/vBnPC
 vXa0jYqywWgCLRhD2c2pElhPJaMts4PkGTptSRy9xnOoO/1gLje/L3P50pdsyRhLaSGpbwU+96x
 rl2EKKR+9jrcM+XVFQJwl6aqzGT+74loX3Ofi04urHyUaVi0TI0qA6o7dExtHThwkPHqLdEhO/C
 5v+FrxsZ6CKyaxeEtO1lsToO5gTltyEBWFLFWszfMaKwyEoyoICOZBUJvOIXku4tCcJwRi7881C
 qfxt0CTbtqn+oOXBxqihEw9d9w5GIPkgpX7ET5FRkrccmM6ySvVDtKc0jq5wYzq+omUokgeXkO
X-Received: by 2002:a05:600c:a406:b0:48a:9540:1a3a with SMTP id
 5b1f17b1804b1-48fe60e56abmr315207775e9.8.1779297928723; 
 Wed, 20 May 2026 10:25:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d9eca8sm4944625e9.12.2026.05.20.10.25.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:25:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 18/24] target/mips: add Octeon MTM instructions
Date: Wed, 20 May 2026 19:23:06 +0200
Message-ID: <20260520172313.23777-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: James Hilliard <james.hilliard1@gmail.com>

Add the MTM0, MTM1, and MTM2 forms that load the Octeon3 multiplier
operand pair from rs/rt into MPL[x] and MPL[x+3], then clear the partial
products. For MPL0, also set MPL[1] to zero for backward compatibility
with Octeon2 VMULU.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  7 +++++++
 target/mips/tcg/octeon_translate.c | 32 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 01ed3b50beb..5139543b153 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -44,6 +44,13 @@ SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
+&r2          rs rt
+@r2          ...... rs:5 rt:5 ..... ..... ...... &r2
+
+MTM0         011100 ..... ..... 00000 00000 001000 @r2
+MTM1         011100 ..... ..... 00000 00000 001100 @r2
+MTM2         011100 ..... ..... 00000 00000 001101 @r2
+
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5392fed08a8..26b918d649a 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -209,3 +209,35 @@ static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
 
     return true;
 }
+
+static void octeon_zero_partial_product_state(void)
+{
+    for (int i = 0; i < OCTEON_MULTIPLIER_REGS; i++) {
+        tcg_gen_movi_i64(oct_p[i], 0);
+    }
+}
+
+static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    /*
+     * Octeon3 two-source MTM forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(oct_mpl[index], a->rs);
+    gen_load_gpr(oct_mpl[index + 3], a->rt);
+
+    /*
+     * Octeon3 clears MPL1 with a write to MPL0 so that VMULU sequences remain
+     * backward compatible with Octeon2.
+     */
+    if (index == 0) {
+        tcg_gen_movi_i64(oct_mpl[1], 0);
+    }
+
+    octeon_zero_partial_product_state();
+    return true;
+}
+
+TRANS(MTM0, trans_mtm, 0);
+TRANS(MTM1, trans_mtm, 1);
+TRANS(MTM2, trans_mtm, 2);
-- 
2.53.0


