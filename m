Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AACBCD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2f-000466-39; Thu, 14 May 2026 13:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa18-0000tM-Mf
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:41 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0z-0003vK-Vu
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:35 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-479dc6d26e3so4770852b6e.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780290; x=1779385090; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ekVB9zsXEwzIffnhXBJZKtqygSG2qAVqr4VVou4jc/4=;
 b=SPFGLiEy11ZZfbpK+GMacQZdBYeqj+Az6w5w89gSEk8OUUAEAcAl1MZ7VjjXMQ1pdU
 jrLrKNim2Wre04StsMhC1Pa+AlxoNGWilBGuarReX1ElzWwDoAGgkUKeiPFuYrdEYe4m
 GjO7c8u8C8h6NDlKNUPLQKWzEkQkdIS23JbU5TTIABsS00ouOQhEgFGAOcYUPVTk8yPS
 d5ZYy+4J5VhS2vhybWpxau20BfMYssRSQyNdhziVP+liGHZM6OxohpcGlJRfYH0rWv94
 QczbGbHlYZjewKW7RTyx910UhuRHQIvW5jX3BdmF77Uso1c6FCQYI+HB6XMsF6pZB1Ih
 Ju5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780290; x=1779385090;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ekVB9zsXEwzIffnhXBJZKtqygSG2qAVqr4VVou4jc/4=;
 b=f3ioLsn/s+8jYpdYroTikZquSaUm8XnIPOcBOnLoiP10hvRyBz6aJJYV9hCGp63Mre
 kU195Z+0+vw5j7TLbZMnSYMl4X/WRKiWT52NvrktD06EcEymYsJUTps3urW7O6jVTRvZ
 Idve2TfNwSenNHnHpe3cnDz5PHMHNG1q8iNpUIgMdOcJNTVA+ywvuP+OmAzrmU/zG2hP
 hCO3Z1BiJD8k+bCwPLvopBUbnAGuuQtkWthkQj+j1F7I9lpCc3J5OO8Vn+/rYNOS5tC2
 OSGf4WGZRojCyG0Hq1T0ajBwPKdtz2HHEQZ4VJfRfD9vJZgLnT3dw/K3CSFrSu5sF9Kl
 w6Rg==
X-Gm-Message-State: AOJu0YwtEEO+x6zE7XEG6nSurAyd6F6+FUKhHOX+OIfMoU+4giYmRnNW
 hr+CUchFe4W3aE1QxTAlgzpIALJK3xqsHSu77ynUp3AaDCYrGButIFOk
X-Gm-Gg: Acq92OE/ZFcY59sOHE2s82FC3pSTWiCQ2/CgT7znJeaeos4ydhSOvVyPnMjxNj6Eu/I
 xyP74VBRLWkgeki1nTZnKqvajKVG8BGgJJZaIQBScLFet1D2fTtnyVh1tYDxW0ec/jjYZtRMLHi
 6FkgBHpadmmkL7t8iIL9bRPDxhfpek31UdJqxnqbmKW7mo4I61RQlPXqlO2fA19F9YedZ6iCp66
 ZCa0aOC98Z8+gWDbdLhZIzCvfBPOCAkQyQxKPJIFVWIgUxuPRWPKMA5hkZD1wdQU9gwbfqcHaP8
 LNv8M7p7QoxBIILYDEDjoZXwa80pC2MQvRRr7z9F9uLkmxBXaCZFoMn2ROzoZvgjYpZbRmZbGTE
 7Dhq8SrlxNJ2G+tffOVxHVeJ6sFyhXH/33HKIN88L9GJ0M8ojNTp8X3ok/cLtcgNjVk0uJMHLuW
 0J2W0V8x9KrXhIlGeecW6F5n1nsWgPrXrWpjaHS38yyyGx32zyGAu7FZwyqPPl/3rtqBJUtpYcu
 RaWiUstIyB7pyQAgTkUcfUCPSe0l2ecO1mGu7EczUIDLVL3Ljgux7LGo+LKD6/lxTwL
X-Received: by 2002:a05:6820:f012:b0:696:97e7:7c63 with SMTP id
 006d021491bc7-69c94291352mr293873eaf.3.1778780290333; 
 Thu, 14 May 2026 10:38:10 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:10 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:06 -0600
Subject: [PATCH v7 17/35] target/mips: add Octeon MTP1 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-17-226686be4ce1@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
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
index dbd77e08a9..837c917a0d 100644
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
index c25307d28a..3c727d0b08 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -296,3 +296,4 @@ TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTP0, trans_mtp, 0);
+TRANS(MTP1, trans_mtp, 1);

-- 
2.54.0


