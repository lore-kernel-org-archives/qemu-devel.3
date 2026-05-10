Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D13CD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgY-0006Dx-Gk; Sat, 09 May 2026 22:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgQ-0006C1-3S
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:19 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgN-00030O-IB
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:17 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-697bcc9d769so1700236eaf.0
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379253; x=1778984053; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+Hqrzj08wtj3b2hP2t7try1LvJnEWInWlbluQGarIwY=;
 b=EVJiQCHsD5s6+KDzCMVnI9+RqXF8bbqzIfI448svl1itkctFF18MnT0IliU51jzSBv
 AGdYl3qxMYvum+FQmhj8iqWZxMskD4vqujglbwx93JnTecPp8/XD/oMCYRDta1UJV78B
 xIa8YnVrW+a47OXx249c/9NFMsiRWEeLM6V3y7c7QDtI1vX/1ORQZbnXllfoCUZZeq7o
 9rL+30R81djp7vvKiVtj6EofRZ1/rpgFszYflKvnApWLFlbgArKjjMIdaC+xfTkDHKvs
 cYyBo5uUOddhZOdNvFzoQM5TXbrB22Zqv3U3WypIrtcLFfPXLizYfkf1gsU3OHOnh9pk
 IT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379253; x=1778984053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+Hqrzj08wtj3b2hP2t7try1LvJnEWInWlbluQGarIwY=;
 b=Bw/lACApyYlldCtNXDCWz8fXvTDaB85vqTvZz4jqzqf3Ep1Jb+k1JVTnuvtNGMT6W0
 mbCzR0d/7lSZcmYZjKVb73+NhR0oOwlsG4rWADh+6h2iegpwM+OeKXm1GoHvx9j8tuxq
 veIcUkyJyDYtPjNdBtdxc1MGR3aKGXI46lgbRm50JOay2dg5FU/nn0CMgZ3hTZCjs6P4
 362QrvSn7TCUIVjx7s4RdwE4AFYcFkZlcn1X7300tZ+DccYeKuVPkayeLL6cK0rbPGfp
 a5yOcU1gPybIHpQs4CmL0GbB1AQVq7W+dcaWhueELGZbFdktKsxx5KzoyeQTB74l5PyP
 QvYg==
X-Gm-Message-State: AOJu0Yy1C3FrnmobUOe1tf0KRVSv160SU0SqaIROuLnr4mnv3ENsr8Ox
 /8eWcGuXDPMhFANYz9/cRNEdFNFi9NIeVd4k9ZAEfpUt/Nza1WzVWWGjPESIcZOu
X-Gm-Gg: Acq92OGe5bT6ar/vi9qsVVKQ6tTcIy0ItDhdcig+ud4m5Cl9tH4D4JQ4IgsYA0BgXfc
 eyNym7+3JIPqwM0ByLKFtYJM7btwU48rW1nPeRnwRPSHOiGY060pIHakUQJfSMzQvGyXu+/gBWa
 KomTjYPUkulguQttgNgDFqcJuWqqS65tPipghH64Slt754wl8JUcS4fE/AIeP0KBBD2FV2qmm+4
 STDGfq4OdMr8A5dFzY+vz6KTPjgRe6Xgv/4OOdH4ZIhuvm1p+Xy91Ff7cO4sEEDR6zoNQLi7be1
 Erki4Zan+v9WwW8JxE5PQ+2jqpEcjbQRzu78UkbJRs9L9bUDfDJ2Adtf+ZGntNgb2sU/2645xwX
 +gsOtaeN/syK3PcFLZXVqsRh5/wUAzlb8HlA4YIvZ/zZ43eTYOKpHf6LgFhaHRnTtE3kzNCWgD6
 D0N/GndeltIBWDDdR2knri96DIo/CYKKB3D83riVlBRn6Xt/rzlfsrIstEV9fdivsUS1jK1rIbr
 JHhQ0bUAdSyxtOZmu1ao5yV+o5NPoOHZrEN45bmbw15CFtTpKxwnvxv0Y/82qQrCZmP
X-Received: by 2002:a05:6820:a0e:b0:696:89e4:5493 with SMTP id
 006d021491bc7-69998d1d8d8mr10338707eaf.34.1778379253288; 
 Sat, 09 May 2026 19:14:13 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:42 -0600
Subject: [PATCH v4 19/32] target/mips: add Octeon MTM1 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-19-d669dcd05c2f@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc31.google.com
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

MTM1 loads the middle Octeon3 multiplier operand pair from rs/rt into
MPL[1] and MPL[4].

Like the other MTM writes, it resets partial products so the following
multiplier operation starts from the newly programmed operand state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM1 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt MPL[1]/MPL[4] pair handled by the shared
    MTM translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 165cd5088f..82d0410e6c 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,7 @@ MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
+MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 7f135d6293..cbf2e3188f 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -285,6 +285,7 @@ TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
+TRANS(MTM1, trans_mtm, 1);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


