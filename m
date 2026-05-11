Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19463CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI6-0005LN-FF; Mon, 11 May 2026 14:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHZ-0004k2-Ia
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:09 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHX-0002s6-Q2
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:09 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dbd23bc684so2748717a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523787; x=1779128587; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WB5qg6ChXWvMZr4p7egqKDXfNM6iJU7r7xKUy1R3WFY=;
 b=HZx0nQAj/aVjCQnz8quuqGgpl3i9by4TN7XANTijS4joKVicl8k4tptSmFLu1j8Ic2
 U4knMWIiqQmIRHxsDyL6eueSuZzN61Be1RCUnPUc7wCD7auDgPqw1bWb/O2QOgjt+UCq
 V1diPNPYfR8OALLHV2pHFkfojdsD3InF474vefV9OBzPUCG/idIfRM5AogHZDnbr6wlR
 n4bhK7Temr0Kt0A32eHiCfVU7M0D0cRGNIWp7cR4nIKDJde76DXorWJtKfY3Z8bTRSde
 Nqxnvgy3+vlCBDLhM2tpGPKihuHYyVT62WJ+x4wDbRyc5VMdv4z1vIZU0FWU11bc3wBN
 /wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523787; x=1779128587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WB5qg6ChXWvMZr4p7egqKDXfNM6iJU7r7xKUy1R3WFY=;
 b=kv2H3vF+H3+mit60YZSH/RBAjkUjl67v+eBzPEqy/+jq/FGJKdzyXEwOn87qpZFILW
 4Ymg0odvJJM4UxFwZfsRPx1j6RSEq+MczjgsSvNzSCNCpZ8Gc7PQkZ7x0v6XuANt3x0N
 hDAJ6XKFU7dPK0iwHzEeocLqsTjIdcyHMkKs8LXpVRPqcYEHII28mb9TXj0iIqvAKt+C
 p0BFIpy2DJoJj2S13RH+m43JkIxQLJ4t+hYQeZyDhBVNg2DbgSPKxHMngu1W2DpoRe4Q
 7kkQtHIUIw8gJSGbUqh5kMiuR6QhxidKP1TV5s8Z+r56eNvTdF2dLPHTvDuXa3GZVGS1
 NaTg==
X-Gm-Message-State: AOJu0Yx3aBND+oTf2wf8TvamXJPCvSwA4VDk4XOyGKP17OeB0Gvl+Xzl
 FXzjv8nYY5WYZVvsMfDm7jGXSCKArhIhJM4S8o21D7WRJns/EOv509Jj
X-Gm-Gg: Acq92OHIoHtwBA8KxNStVQa4YhktPPvzhf7vw9iJL/d1zo+mFmXxWEotlqVCh0OTDrv
 G6/o/vRMJw6h16gcKByruWWCDfpr8qzrL7+DIv45BSQBb67kjnjKI32NRqTTajP/pZEdMq9yTu9
 0Fo4e4dsY2l91aNMUcGE4fOd75hjhphait88iwrnfWtqt51ooD9Paa70hZSDfWYOv4S4U02KIYZ
 vmMDtEs1fvGbRYVB/LLgRT2zBYHEEg3dMOwzTyiJDYth16CzPgisCPPdDpIyIYYysy/hDQXNsVG
 9cduM6aqLud/j8/rDDlMQMfs+GSGK81tzoSFEmTnH1Tgtp7iBsCoTYwQ8H6YWR1DtdLZwNrvaB+
 2l+wnwq3cO9f4wX0SbejpvBmuxiGn2ZuU+G5VSklyqblFNOhN2UxDE6+yxsAj86ML4dV6oWgOXP
 rjXgt8XBUA9q1Z0pBsswhfJvNlYJ6RdiaeonFLcQcGDBrBnzU3r6cTF6EShQ6ipfdEe17tcPLh+
 ytopF0THWOY79U5dzS536KnVL3YM5Y4tD52t3Hqx4OdBKBdyQRkzTzAFxYBvHirzxhd
X-Received: by 2002:a05:6830:3494:b0:7dc:dd58:50b8 with SMTP id
 46e09a7af769-7e382125c51mr6971665a34.13.1778523786683; 
 Mon, 11 May 2026 11:23:06 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:47 -0600
Subject: [PATCH v6 16/35] target/mips: add Octeon MTP0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-16-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x335.google.com
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
index bf1dab61e1..59ab7401ab 100644
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
index 4507f8a5bc..88f64e791d 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -254,6 +254,33 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
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
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
@@ -264,3 +291,4 @@ TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
+TRANS(MTP0, trans_mtp, 0);

-- 
2.54.0


