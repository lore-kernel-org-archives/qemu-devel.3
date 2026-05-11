Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2767CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI7-0005OJ-Gs; Mon, 11 May 2026 14:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHa-0004kO-As
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:10 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHY-0002sq-MT
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:10 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7de7c57b52cso3783815a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523787; x=1779128587; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K+G3B36X/9ry336xbKmucfkEPyEB6BJHY5PfVXdyEMQ=;
 b=qb9DD+JuVMNOKGe6fIckQsHUMDIMv4l0k1mfY8U/2JLMaHk45ps0D4hd/MRHuerdbf
 Ts9Fi+dXQ0uTPFud3yY7dw5taIXLoEydIIVMJG71uqo4ystPDQYlQygCFLNzUV2cH4O0
 L/8wNbLrPoBzhgL0uXz7EK+P5RLm9PC+0DDcKjRkMnycXhf6ulB4+R8Gfwq/x1oPC0FB
 h0DxsxVHD5w8YlgF1Q4cuewmfCaXO+T8lLM4W1H64yvf5yGPxNfatbB52dzqqD5/e2ta
 mlorg5N3PvbgxqzqomN0xWtih4WRgGJmFok10gGcbYzpmGVZOuC9kcj9mc/c3IQNOATG
 EQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523787; x=1779128587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K+G3B36X/9ry336xbKmucfkEPyEB6BJHY5PfVXdyEMQ=;
 b=KejsZ96weEAlG4k/lpQPkySNCqscYDGhGXGyEw+4BfDmHkf6DPTssTsl1Ww8WveF6I
 zLUATIP71LbJdlrGoodY0PKta5Mx6Vdh79K9M735fmP995tpEY37OxOc6pA4B5MwZmCh
 dnrYALcjto08ARfzQVVtBsoAFv3AiUK9yVbXaqyNkj7VQmab04y2UfRJnQAFY7DJYClM
 NbeF/XtDjgjT4RmhC+NIi6A+HCYTqtt4tS95IbmSCaO6EDYl15KGaD241Wavwsxuilaw
 lhz8yRmupYZ73SgAi2+6Hvp9FQq8EYhiVLFlaW4Gbw6nqjKOrP+QnESa8/Soo65piv2j
 vYHA==
X-Gm-Message-State: AOJu0YxIa20k1rNFVs8Xv+IB+PyMOWPKSiAN4rLKIGFtkf0x8MVq5tpQ
 F82zklVX05YjKo4rwH5YttEcIJzMwd7ZiUA752Jj2NDDP8hMSkdkwYzf
X-Gm-Gg: Acq92OEq2J0ENzE1H0KNxee81a1JR8eSwLVibgmwf/+PQ/+CGUC5yletZvklgBz2wwA
 Tf5FOUyM0i31FDrd7nrwx7wEpAC1aue7+p7YbQLmesMyrlEX8z4ymFxNNJfMRErHITVos/m2g2S
 QUlop9pch+zfaVmqA96NuMgTRs8ST6Fy+4lEaJsFNRiQQMBvj0Nc0Klkr9dur2Rq2sJpSeRaQxH
 4DWLWC7PjNM9KMqouI1UOGyhMxWlcZIWrBvlJJA5EgM6PMnmPqb3wRzU3DAfnuYlSwT7t9igfmK
 daOSaCZqnZfv0eZjf73HrUpwSXvnMnfMYsVke8MM3T4XbGh3dxvEvLdAEiNmSdbgVWFBm4UhBcz
 gIBnpUGRD5ReIsBCI1MG+DoXUBsRI0WDuSOjvSv56pJbaio3ap0t7mwZ3+xYokGmxSvGsIwEZHF
 Ua12vZgPDQVm+Ws3PpZG/hZaE4fFqTCheqLL1J/gIDtTKu3JL/xgZUQ5yeQc4kJZfTi4Z2HTkRw
 ItYgBUgU8Dv+enVXghDTIcjiBnybAduvP4A3tCDVs0V2hkkFzessL0KwCguT5RZ0lHk3U5L2iwa
 pD0=
X-Received: by 2002:a05:6830:4986:b0:7dc:e032:9b5f with SMTP id
 46e09a7af769-7e1df220611mr16751181a34.25.1778523787580; 
 Mon, 11 May 2026 11:23:07 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:48 -0600
Subject: [PATCH v6 17/35] target/mips: add Octeon MTP1 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-17-5062889c4d3c@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32f.google.com
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

MTP1 loads the middle Octeon3 partial-product pair from rs/rt into P[1]
and P[4].

This completes the second guest-visible partial-product slot used by the
Octeon multiplier helpers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTP1 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt P[1]/P[4] pair handled by the shared MTP
    translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 59ab7401ab..670a12a956 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -46,6 +46,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &r2          rs rt
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
+MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 88f64e791d..3f954eb134 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -292,3 +292,4 @@ TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTP0, trans_mtp, 0);
+TRANS(MTP1, trans_mtp, 1);

-- 
2.54.0


