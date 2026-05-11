Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CE5CD484C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI6-0005LD-DY; Mon, 11 May 2026 14:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHW-0004j4-6H
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:07 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHU-0002kz-Og
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:05 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dea20cf21aso4304627a34.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523782; x=1779128582; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qxf2VIGh8FXF2BrFMNAX2p8LvMxCEZUgp42x3jY4KfQ=;
 b=fbJdW7Q6DqXGD54hx2+gQckGflE+I6/PwEbI4R5NJ9fHJK6RVqmzMfMTfyxFq/ppzO
 NzdEZ8OIIrIdptWOGlwrIwDmo7gZcG2Mvq3TjnYH9asR46/yoTFOi0XEmpe56ltPhfir
 5DBl73MK3yUQMlrSsM0KrSR4PIoEyxqJPT0wlYuwU2CZHX4IlRF5fr0IngROqOyeyLEW
 QtqL5JdLvm96tMy1EdSOqfg55yk+/9LCvgXs6f1ZHtK+XXYHfIN1S9nCzMoQRPGJmdFF
 F5SZcAqJa7m8HlC5N13duUTHcMiEVpSoHzFMciPxfHMSH2u/WL8B2c7QVFhWqUDhZxBe
 g0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523782; x=1779128582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qxf2VIGh8FXF2BrFMNAX2p8LvMxCEZUgp42x3jY4KfQ=;
 b=gPnipLsqws1KUeddw+a6ewH8wB09LPQFXs3cUYZO8LvhMXKePIjiiIQydMMHe5ROeN
 KjsIm+BCQ+/QOKiKCzntkxZOzn7iBbTv4T447polJncOLldbJgA7+zjeHCM4hhlT7vzc
 vrOVTXe67EA6Rl/N8MqTzxKyvsFOnnEIwESyprS5t2kmU2ApWrOAkbvyR1MH9ZzjDHfn
 NdBIx7F5iX+IfaVbQ2KNFx0JFNB37GRQGQPvjjwIoBPVmVQf2/gWrGi/C2HpsVI27iUs
 NlohKUE86ZsF6EQiXkh5p/PZ+zt9hieUlv/DlGnviIc89SYccQ0osbEq+LcKbEzQBDKi
 uTWg==
X-Gm-Message-State: AOJu0Yx4wHvrVeEJ1XilO/JYa4cgqILUd10rKx6A92Fa4LolRY9c6nhx
 itxxKybScWc9vJ1JrdynAjg9EoYykdbNdnhlYaJj4/tkReygBTeu1YSH
X-Gm-Gg: Acq92OH685bIt7WaeuS7/cUlz8TcJyGGtNcCb1NMyyZ/WYpDW9NjDuzljAfC1zztH61
 UrDY+XrBnL6Rbm2R2I3PYXY1eByUt2vJceTCwzDJ/6oXqndBw1W472defwx8pe+lhMJwYGNWfX1
 9T8qyeBGXD1YpBiiVscXky55CV0LqYiWjr/v74wdDQXDKMpaCCue6prhcv9GvBRWM0YfQyzDR5y
 kqSI944CLWh0cx20wRAvgaeXc8SdV36knLmD/eSqUQHFfJWyjKf9FSSIUiy1msLB7ai98zz3ZiB
 xKd0DMp5Fr2CPhCSdaDG0wmjJ4t/Y9/1B+t48hKx0q7xOr+Qe36hyHbKfYGmhC3gt006EYtLkJ3
 SGyq+676A0meXElu2AgfZ7OyPhwgPtD4iEjfuBTybrRQ1NalARK3b6VdlQVh/sCa/F0Zn7N+gAC
 UWrZfRMgrKfiWhpvxVLyWTxjQdy2SpfBnIBGMk2p6MfOJKZGkWqhH6tQGjMKeX5PBchlBDGNoZ7
 FqesPGlUMJxjAXCrzIQ13i16SuATeCQdxtcZHJuXfxeFhFxtf/YJtctgEOof9GyC5xg
X-Received: by 2002:a05:6830:3894:b0:7de:4f6b:9e10 with SMTP id
 46e09a7af769-7e1dea53c38mr15836472a34.0.1778523782583; 
 Mon, 11 May 2026 11:23:02 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:43 -0600
Subject: [PATCH v6 12/35] target/mips: add Octeon SAAD instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-12-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x329.google.com
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

SAAD is the doubleword form of SAA: it atomically adds rt to the
naturally aligned 64-bit doubleword at base and discards the old memory
value.

Route it through the common SAA/SAAD translator so the MemOp selects the
aligned doubleword transaction size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split SAAD out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Note that SAAD shares the Octeon+ gated SAA translator path.

Changes v4 -> v5:
  - Drop the Octeon+ gated wording/path and keep SAAD under the existing
    Octeon feature bucket.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d6b241de42..d77717cd50 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
+SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 441d71d57b..daeaf07072 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -175,6 +175,7 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 }
 
 TRANS(SAA,  trans_saa, MO_UL);
+TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


