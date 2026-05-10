Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFEBCD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgZ-0006E3-52; Sat, 09 May 2026 22:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgN-0006BY-Ro
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:17 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgL-000306-MD
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:15 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dbd801138eso1878611a34.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379252; x=1778984052; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6mXGnIwxsH9ElFtokWnfseqntsFuX5o3zEpJE5nKGvU=;
 b=lcBtE/GcVLqlg/8mdL3sOs7u+ABJik3+EiXE2Uz4C1prqns/FDVnzoVZnzC4U/ag7L
 tCdlBN05332ENpDurLIXyiPmEO8WtyrX+3Yi/jzcEyb3xbbgEZUf1naagfP9LrEBny5/
 RMScZQgi+RkXeE9aMcU16TJLk5XJywFPN/fkZPMXJi3+CNwMrB5ksW5Vq3lEXh9xZeFl
 uMVniWNTVbVm/0ThjILzoOZTn5Vb4YfQoNaDc5Rac+hO0EFLEVQr1JIvP0MyrcSy0jyM
 gSUDb7U9C28ytHIp6FXyZvshdhux5ygwA1aJw5j5meTV9CPzxLE0mQvysYAUiV7cT+0w
 fwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379252; x=1778984052;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6mXGnIwxsH9ElFtokWnfseqntsFuX5o3zEpJE5nKGvU=;
 b=SyaNecR6VnwOqOL/HMFRgV5jJvlWB2a0d71JR8zTQslJjkKlJuyDeSEkrxa+J2RZwr
 1lyrCZyFZMYf4L4sR0eY6sipaoVglmKPos4OXR059fin/5nyfPj1L5iHoluTuh1BZt1T
 eAzpYHWq+O3t4JSth15s44PeRnCJDVlCIY1F+AKCYMnvA/BZutxCD3rpuPlmSTB+oheh
 9b2N4uiSoJy6AqiwihiBe/cEUVgEBKAQw94/kjcj4rbzqUt9Y7+l4AXpsdLHcXB8Ha/3
 A2HaCBawng53Ikg/F0pBquffc+UFu+9NlzsQgYOgveJidABnLz2ImL0T94A61fDlx4et
 e6AQ==
X-Gm-Message-State: AOJu0Ywd0RXOJQMRzxe8bUSpPWJCcwB1M8RaEqToyXU7e6+grdOfLxef
 x9kgU6bFNUqoK27lEBFa4sOORz5RC3LGh4kankdwc065FfP9SRTApIjTehO++1pl
X-Gm-Gg: Acq92OGJNEeGapzjNcx0lNzdwZ5b1n3h3fWK0u2qFuB9FJQQ7RkpyDMHvY95WbxdXEE
 uKXLw0ETkMXoAoC25GFm5Gub9/8g29u4Pb9Yz2lEUaceoD6Bd9FyDhprbNXfkCbktUvOwXAtpkp
 nZve96TyxrFfoflFdSLmUL8ouMyBS16Np0uA7+w2sWzLCjLiFUP2qjo5mhCI4dpCyeXTP+21vuI
 MuUNu+p1PdUAknXAdZSZwPTtx2gJKPRECvSfPrhEHyf6k1o1D3nq4hLuY4YDdBjLRits5gaO2mF
 DqK3P1Dz0XRTfEiyDM7NeGzRF5H1LtIWoDcQaqRvdebmQtYlK1rCDwnsrjpYBIP/idZlONQTT7V
 KLc7CktxRvVojMfG/ythJ0TZtmIpO0DghyEMjPvc/+YhYoMR54+21qVrE2s9W21InAjN771TvvN
 W9jS0Cn7YUGTPGpcfbTHw6wNGaqU6Y5JL51sRwqX8afPOy4VqU+qlsdbJj/JbibljlcahRWzasP
 N8M1iIs+9eUW7iu2g0A6vL1wlgCz9gvbz7lLrdivzvXRHo4C8k/lZgGEzyGMTzXOSMl
X-Received: by 2002:a05:6820:4cc4:b0:696:2b13:6c63 with SMTP id
 006d021491bc7-699ab5a2cc8mr6672699eaf.10.1778379252375; 
 Sat, 09 May 2026 19:14:12 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:11 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:41 -0600
Subject: [PATCH v4 18/32] target/mips: add Octeon MTP2 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-18-d669dcd05c2f@gmail.com>
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

MTP2 loads the high Octeon3 partial-product pair from rs/rt into P[2]
and P[5].

This exposes the final guest-managed partial-product slot for the
Octeon multiplier operations.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTP2 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt P[2]/P[5] pair handled by the shared MTP
    translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d339e6d1b8..165cd5088f 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
+MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b93506eb5a..7f135d6293 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -287,3 +287,4 @@ TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
+TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


