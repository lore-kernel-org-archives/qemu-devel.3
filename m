Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1098CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa1n-0001Bm-Pi; Thu, 14 May 2026 13:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0r-0000pm-8e
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:25 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0g-0003tZ-26
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:15 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dca4debedaso7759120a34.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780281; x=1779385081; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lf7g3NWu9At1XLoLVfrABfLqdMiHDWY7+mwRcC6wpBQ=;
 b=INZIJF64jgQd2J1chz4tX9zkt0N9uyTRlLEl9AyZS27oeYl97gzJKXZPtPOXPuW1wH
 AC43vTcX/sGSwv82LnRvqw/Dz6eLsxNsjS93BhjfdVs/HIy0Mikdrp39P66KQdDNQqC2
 CZTxQBhvGPtZ/RM35OWkqPfOLK4EW72b6kXk7qDlZ+U02h5Kt49CXfieDGkpNECcndt0
 D1t7XzAvHTh3ubI5Z1Z0muLBpCn/B1Zr9HArzVADHNWLVXGE1ypnAHe0EPGN0XJSe18m
 MPvI6Fm2uwA0nIlPtlNyLRVrBwv/f/Nc5MXP5P7YnaHXO9hcB7yGEFEwPKWTcn5TLX3m
 KqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780281; x=1779385081;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lf7g3NWu9At1XLoLVfrABfLqdMiHDWY7+mwRcC6wpBQ=;
 b=dHPEg8H7o7jUt40FzTOLud1UpytY18d2g+JSORzDdllBofQhTvAWEmYD6LixQ/fXwg
 izGxoOXKqlTLSK73YwSC6a/jTm6jkQyppmvHAziv1yF7vM1m/PE2ZpHINB9N6tdbQ0X2
 iMiIrqlkD6z4L93SQVPnp40NwKSH3vejb7QqGP0JDpSr/z6WwJa3vdnaM8qo+H0eWEtA
 1XhMQDWxkHsxpgDBL4iprxywNVoPCs5ch4ywMt7T64agFfhGLAo4WlFjye2602wOUReP
 VxXZbX4bE7h9WKoc2JtRYCTD3OVNIDZcippZXaU3U9bF1ztqn+NClEPmeS8hXl5AqJkx
 V+7Q==
X-Gm-Message-State: AOJu0YzD5kwfYslHKR+cevbavC/JUow2eHWLhyyYkC7ArvFWcY6LQ0A/
 jOcPkPKcZ/2v5cucvIeZJ6KxWcDpdI8bIC6sZVClocD0kld7YYZTfjr7
X-Gm-Gg: Acq92OFlW9xkV5PtFkKlfm1/Yn4GZEa36Z3H+PeZCqLVbl/ZkhWVEfDHVwbR1pKgs4W
 mfCTNNjh8RyE/FSldpE94kdoqo5Zs5zqJKR4pkOkRgcCA8ND96optiit18+dT+ZGQAsZP7OCV+3
 s/5WAei9bhyG2P+ld0emCw83EJZbrn+Y9tacJ9B7a/i9IS4G1451kushV3IfrvmNhx0b/69v0iB
 t7uh1bYej36ZY3PLPQ+YiMqhavmvuz/S7ludbAUbz04MxMrjYm96FOnMxkDYHi3okhDahKjyhmV
 5+Q32sxPwkAFpXHRrIc++rtHV36csKNtKGTFnnQBIJ78WXZVfAueWsNt8CO8Yn+EU0yAbFDHq5s
 0md/NOj/rA68qIKhSJmaeHFRpf7liLjeJtdSPRn5s2q0nIK5LbrKmjDVzpFYuZbJQLUs/N/w4US
 d9wURH9XFYEI07CeAvi/T17XiFK0bD/UEYayCL09XwMeL4fTntqj79Dfm97jMRB3r4fQDRqJ4zj
 1+yP5zvJI6PL39JzKWGt4NbVydggSsBhiibVIuDzljbliJ4yQ3/DxL9HGK+55mHfGjD
X-Received: by 2002:a05:6820:16a6:b0:694:8683:3867 with SMTP id
 006d021491bc7-69c945844b0mr231071eaf.46.1778780280880; 
 Thu, 14 May 2026 10:38:00 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:36:57 -0600
Subject: [PATCH v7 08/35] target/mips: add Octeon LHUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-8-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 451737cda1..f897b42807 100644
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


