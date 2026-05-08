Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12250CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtO-0002i9-6T; Fri, 08 May 2026 11:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt3-0002d1-HR
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:10 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt1-0001dx-Mq
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:09 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-434e69e943bso1631002fac.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253186; x=1778857986; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kt/X9h3ebfY2yAsj4mYC6DTi18sxMdPXWVIaTnR56mU=;
 b=nLmEv3AXf+JF7ffnSaJ+vKqTipyevYSSp0Vgpe3Q3uL4U9dO7jTy7nvp+vl0KgClRd
 f5K8WTluQfEYo4+r1CDua2e0dvoBGEAOPzkZjcQH3+APl2G4cWsy03IcsOF/nkhfna+u
 M4nOsRbewq0EYh1/1I3OYRmd4u3pOKmVeVdzVjFJJ2wM4NvGAcnQALUYMMAZ/25d7qAz
 lfp+cLuZpU9rnmYXAxkB7FhvKLyapqgQht0K2MTPVsyRoqd5fqgpneEBNug7AK90+8CP
 /zpB4KeEghrDNAycHN5QRAytnKfSOchovHxypcR7TSU66MUmNwFiQsD7mZFXWQacS5Bo
 d7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253186; x=1778857986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kt/X9h3ebfY2yAsj4mYC6DTi18sxMdPXWVIaTnR56mU=;
 b=BVyVF0w0OyDVatDgqcnuhL8LLtWxxVcXsYjKRDnKz8zT/k4R5l3R3EbOGj9nMdCW6h
 DMwvfDJCPi27IEDMH+i1MF+HIwAFa6cqkSnkl5oIHTVsI8y37bhi8a590D3QuSE1F/IL
 37o8vHnbkMWKFZEoamtbklNDd38AfDMuJH+kCn7nBBXrut4Wd93mPQ7S/XArIDCm0msR
 fSflWFrP/zEhidnRtdGpSPtcO4X28Ah6mHR+a2iVluJnR5qklS+qE4QVB/PQFeUvGgdp
 PT1JfHCb33zLvTy6ehFbhACGxBkZsE4jloHcB1Hq/DIlTSQgFvW+pyHI0td4Ucz0uds7
 oT3w==
X-Gm-Message-State: AOJu0Yxf9tfIZ5baxFeQqnAa4YEDLoxok2t6VtB4ZUc3XGsMX3tKfAjQ
 QxVSYUJm2iwsNsvFHJENiNzWZMrWY/lF9rcU+PNzhLtmmyBM0joErMK1AJsCdg==
X-Gm-Gg: Acq92OEUfdJeu2hilUgtC/PGUkbHAj0jJIQas3OMw3nBw8LaqKA2n9VMRPr+hBdFUe4
 ZLiP/oqFc/f7AfzUL1sVCraS2fsbx9DNMc6ZX9Uic0TFq4J3iC6ijxijRlGN2uisjabJ28Zwvli
 J9ONtSpWlqAxA6dRqSfB+2Jkr/UOZ4/EBPhnsuftcRnWHZ5iguXe9oYFAs+mjIj6WjNF3L8AfeD
 dgdUBjcOAfgQHdw6lO7WJmwZPnVI3WJJXyBNAKlkGTxK2xmYX7t3mJndtujRl0S8LAG6pZ1etPi
 m6AiBQ4BepSU6WZ8/a38Qd3iyxxnDkH46OTFQ2SM6ueyaODbAFS7WO6pqtdwpOgICUPjyY4J4S0
 IsGAfV1INU1+jEAaGc9eKmfUSbHCCkKRIja/8l3wNS+kG/lBnBojDn2d9u4U/D5LrOo4im+2qH3
 21YPXOAkCm6HxGNGR14bci+pQMXNQ8Wx7lIAH/9l7hyuXXusYb/0QEdxum4Iq7nUjeL3g+XT7BE
 89o9XGj0HWWySpjCVlVX9gC54la0Qk01nxgmyFIoLeXOkBAdsE44uagccsOiR5lNitTWQvm5pbH
 M4yiYSNIS+1KXoPYD/JFXjbAtta26QDxyyEWFTD2OeXTm94ePqL7FsmKcKhjq6Wvm5WoZgI=
X-Received: by 2002:a05:6870:276:b0:434:7449:c153 with SMTP id
 586e51a60fabf-434f72597c9mr8618292fac.32.1778253186223; 
 Fri, 08 May 2026 08:13:06 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:08 -0600
Subject: [PATCH v3 08/32] target/mips: add Octeon LBX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-8-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x31.google.com
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

LBX performs an indexed signed byte load from base + index and writes the
sign-extended result to rd.

Wire the existing indexed-load helper to MO_SB so Octeon user-mode
binaries can use the signed byte variant alongside the existing LBUX
path.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LBX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index a2bfd0751d..efb1a48b38 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,4 +49,5 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 1893bf359f..ecdce6ab9b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,7 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LWX,  trans_lx, MO_SL);

-- 
2.54.0


