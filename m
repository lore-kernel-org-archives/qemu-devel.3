Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D57ACD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf1t-0003S5-Bx; Wed, 20 May 2026 07:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPewY-00020J-Ma
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:19:38 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPewR-0001Dt-UZ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:18:30 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5aa1b2327c8so5857915e87.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779275885; x=1779880685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZ5Lr/3HXwgvmiWJDpsGZOFhNXogIonxGAyV7GqXUGU=;
 b=zAbZurhLJspf1sKn7Rd4FOY5203R+d/KxekiZgkyGdNtfiApk/99TCYrBNWNsHsJPI
 XF9jpTpgCoRxP2upMfyv9fMdKzwwtM27Q+9nE5KtP+xYQ6Xe2O4Bjfy/QqSfW/31elkw
 opvbFyt2VdSnEe5b2REkRruUHX0KOrtfQ67lKWso/nFaFbFlrwrKOErBBi6fxli2NsbH
 20MTK/pbzQjdZgdoL+jSPCh7IzIQ+S7pr+E1Agy+z0RdYCDj6aMDO7Eo4P/m33NObgvb
 fcn9Wm4xXOrPJQH2XT79CNUOjEPL+av3MPZHSQBzehnKKo78H/+Izd1vNXdvRqb4rHC2
 Iorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779275885; x=1779880685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LZ5Lr/3HXwgvmiWJDpsGZOFhNXogIonxGAyV7GqXUGU=;
 b=OO2qTMHcZPd+4g8WU2Tw5JMAbIEtgupWZWacGpgdbstOXwEH1m9M0E4Zr9Y74++KUo
 xuXC5gak5UdUaybYW9ky/isy9yXXgol8kUjVCutMUwVUnEIw4MNWCbrYN0L3BgTYwkuB
 dytqGUEBsUgQc9hPdo9t7BOAZzSQoRnBeKYQJajKEbHP/KPEzCqLtz+hWzr5vIjazaXP
 fPZiZgJ3z39+yLrYCe5XflW3h92MkP1NcvmSyydPV3GKYZ2YNTRtiTNpEwXdVDMYIVak
 qSUr2rOPxLP+RMk88+Wa2JPrUv32riKhkXWJmUKGMV4MuiyMtpHV5zFHAVjIduB3pgEp
 CMHQ==
X-Gm-Message-State: AOJu0YwPEtSO/1gjXXu5kD3fA0bo0erjPVXuyIs4l9RjF1x1eURsuboB
 Rl/e9oUN4f7w/pQIPfg+KOeULqMrABq/ZRM6Q6kYVKo2/T251VdArdlCxraSNcJjYq6OOoYy94b
 BDpE8F54=
X-Gm-Gg: Acq92OHI/1I//O57tHx5eMN47uGpGsQEUFrEygASXEDmNPs8zKjWvM3MbEhEfZEjvMh
 dPIPMdCws0jBAi+BA3CfV0/93VVd5/aXLYUhofcmESJdqoMYtI/OIvHCWeWZChamEVlmxqZHSmZ
 4Ix9DO5aDTC/zRoOv6SFP46bnSoi8Ca8Up0+oBDfS35tLg8nnPOuWUBsuYQr3IBWrmDKS0EpDTO
 frGcC25lHZY6QiM2meN8v1zpf2UO3RtbcBkOgX6RDE4pd6NpeODR2EZDFCc9WCortiwG0XZVnu6
 SarKWCbMffXrNYfmXnMj7FwnHuUyl7BDQuJh6wVWeh6CDQAzu3tfBQ6CiPG+2ooR1rx6vjgsD9h
 tMdxBOPWTLl6BSXxXOQYUNgdI1hYag7Ft8UeN1+PeuqoVyU8oRyxyStpGhvBVcmxnTCoVTrkQfa
 6Bc3sF8TOY8Ak9wsIWZdh3PZQ9uicxFLXtzglTxg5tGTab2o7H37KIEE+Q/UaXjwlBzgdyK1EH+
 4kH6U79twgB1cWx
X-Received: by 2002:a5d:5f49:0:b0:446:96b1:f53 with SMTP id
 ffacd0b85a97d-45e5c6000acmr38242651f8f.26.1779272430778; 
 Wed, 20 May 2026 03:20:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2f738sm51542897f8f.16.2026.05.20.03.20.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:20:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 19/24] target/mips: add Octeon MTP instructions
Date: Wed, 20 May 2026 12:18:00 +0200
Message-ID: <20260520101807.9971-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

Add the MTP0, MTP1, and MTP2 forms. MTP0 loads the low Octeon3
partial-product pair from rs/rt into P[0]/P[3], MTP1 loads the middle
pair into P[1]/P[4], and MTP2 loads the high pair into P[2]/P[5].
For MTP0, also set P[1] to zero for backward compatibility with
Octeon2 VMULU.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 5139543b153..bb0a9f1d99a 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,10 @@ MTM0         011100 ..... ..... 00000 00000 001000 @r2
 MTM1         011100 ..... ..... 00000 00000 001100 @r2
 MTM2         011100 ..... ..... 00000 00000 001101 @r2
 
+MTP0         011100 ..... ..... 00000 00000 001001 @r2
+MTP1         011100 ..... ..... 00000 00000 001010 @r2
+MTP2         011100 ..... ..... 00000 00000 001011 @r2
+
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index aae6e9811c8..36d268e09c4 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -242,3 +242,26 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTM1, trans_mtm, 1);
 TRANS(MTM2, trans_mtm, 2);
+
+static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    /*
+     * Octeon3 two-source MTP forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(oct_p[index], a->rs);
+    gen_load_gpr(oct_p[index + 3], a->rt);
+
+    /*
+     * Octeon3 clears P1 with P0 so that VMULU sequences remain
+     * backward compatible with Octeon2.
+     */
+    if (index == 0) {
+        tcg_gen_movi_i64(oct_p[1], 0);
+    }
+    return true;
+}
+
+TRANS(MTP0, trans_mtp, 0);
+TRANS(MTP1, trans_mtp, 1);
+TRANS(MTP2, trans_mtp, 2);
-- 
2.53.0


