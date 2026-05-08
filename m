Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AE1CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtw-0003My-H8; Fri, 08 May 2026 11:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt4-0002d3-4x
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:10 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt2-0001eE-IO
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:09 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dcdaf06498so1573037a34.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253187; x=1778857987; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vKRIKunBp1BcQ/wvFKLfVR8rprQQ5oAvC03+LhObVds=;
 b=bpZl6x8Ca5nkSIxQefoMvreUAPHtWlyJWaoB60qVQcjego7PGX5GepMhkskTQvSIxZ
 OPxECUIx7T3dBH6YvnGMTO96kRR5lcTi8WPxbWjP8qROAIDkc3zMLWsBdveovHNSpiqg
 7WMFK3xfRaUarRet1SSC2Lb87UosP08mG8vclYRq8cHJXipiWCbbBhK6UDqre8oJqY8r
 XjrCpYaNy7GxgoqJQp6E36XpMJ8ys6BxiV/5Ry53WXP4l3hHXA3ZPGZQI4W3qeYVzHLV
 00JuIbud4P8MD9+OR8utAHF5b5aNuf4D1Vs6kAK5OEMbTgTCVHqKkkvE1mjl/b3BMD8h
 kJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253187; x=1778857987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vKRIKunBp1BcQ/wvFKLfVR8rprQQ5oAvC03+LhObVds=;
 b=Mt3DlCUGnm1c9l3qVhM/P1NhMeyFgux7+HeTEw1ZMC+b7zreQ1iYCAxihCFdH4US/X
 xLDpcByxD990ibOnukLywGOajmzYXw+sSzk7bzL2O7rb5rvZ5oOFWgRNSkBSF6wVtRYL
 XPXMZ8Oq6DSubdywoYMlX53HE5SyXVYHr3P3y6JZA7VR5dUcc+EM992slgOcXwIRmKCR
 RujGMEm6tl2CszPesCLPG7tSHxyC3rt49lw44Ez22JjIJEMnoaOyxU1KQ3zCZRhKjbyW
 1OuNU/AHSY3RXrp+W8mVYUCDzimfMen6bHUBDdn1dB/MaKe1wl66fNd4+GCWKo85chxR
 j7pg==
X-Gm-Message-State: AOJu0YwGfyKSBxjrshWiDuuL9qlGmveQabT0o/jV3MNQFg6NGq30ofke
 ifJKCOSQCanmBEuAJCYXqoijctYZn00dD3inKmthfR+beSkxweNAWlw75VlFuA==
X-Gm-Gg: AeBDievh9m9RanWanwmTmwW0eBHSaHCbzt1HbEZTR/b/pUh165Yyn5LdQD2F6rTwo66
 M1vRB6pkMkqPVUFGHbE98vHInRF5/BYqjUr6y0JybJy3TOD4sz88kQcSpyY2gyTBwdvdYRoJPef
 Xz/Ib7QJeEisiie19ZWz1Q89iFTd4N0Y637M9QKnh4QCMIRdsuBypU7sGnbQw34pz8vXLVC9Phl
 drr2sEgl+takXwhwemG4qdFhlZU1D9MGhH8fF8L0nxxqGAeUSDe+9oV2tPJaHz1ysNmuQRo1a3F
 vg+9EpYz9nMaIh9pZ/dnXGL0V/KMh0GxzJzFzb1/cYYCPZRDeBp2SZYAj4FpdtbEXDKBnKGQ6p/
 ok0xJBHUxY9kUL7eegr8VQ8eC3GyyDGWv6o1zccrDfDMrSJp7IWH91wit/zrsew7vnL+apivu/V
 6vWU/vmQJgQha+wbhqJ4F5g3+L3j2b63KWv8JpZk5ZcKjQYJthJvpV/Wsj6v5YCQoNKfw6Pcyeg
 rXoQHTEvpi1C+tRNC9oEnEd3nEbLuxV/9Urg1UtOOujLL6ApaEVX8TkpYEWZMM9psAObCs/Fy8i
 5pD1CBbeI9Vg2Lf6vAUlvIAp6mfaPeqwwh98rui3LKX+9fraVAzVSfaPAQbYBfYrn3OSLwY=
X-Received: by 2002:a05:6820:1792:b0:696:2cb1:a007 with SMTP id
 006d021491bc7-69998cde964mr7309534eaf.24.1778253187240; 
 Fri, 08 May 2026 08:13:07 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:09 -0600
Subject: [PATCH v3 09/32] target/mips: add Octeon LHUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-9-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32d.google.com
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

LHUX performs an indexed unsigned halfword load from base + index and
zero-extends the result into rd.

Add the decode entry and reuse the common indexed-load translator with
MO_UW.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LHUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index efb1a48b38..8a755075e8 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
+LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index ecdce6ab9b..5a189c6484 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -164,5 +164,6 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
+TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0


