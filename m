Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4FACD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa1v-0001P3-OP; Thu, 14 May 2026 13:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa10-0000r9-63
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:31 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0w-0003zE-H3
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:29 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dea20cf21aso7539946a34.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780292; x=1779385092; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x4g4lyBfVnZjObr/QCS9Ykv0T1DSnWmL8VyNMoNy8FQ=;
 b=UEqD1UKnfnuli5NzSg5shxIbeMT6iV/9gUpr7LkFhnvyWD4qowe1LCPiMwSNmmk+7K
 1HxmyRcRmx8bBgNBxrJfOxv1SuJ2KmRV60LggNQi4SkoJlo1sdwKgeNe4cWXqccEWjMn
 TkOUm2hKITsbDPM6dR+74+y6RtJVuCAJyFoNRf+PFblx3IbsszVz8gcRVYlthp8p12AD
 9+RbSKpkrYn7pri3ZQZcZ4GrDih1F+iuzF4WoZtxPDW6/ZasbNHvRflRoX6+4zo4f3lc
 N42V6cRliNhuVasnZYPV3l2q+6BboIcrKNQJ6gbls8TWZrnInUOhgXmHNkDho+KPAdw0
 bI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780292; x=1779385092;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x4g4lyBfVnZjObr/QCS9Ykv0T1DSnWmL8VyNMoNy8FQ=;
 b=DENKv180ezUUyLI60DWoWRVMK6TcMQsFRK6PhKMnz9w3hqw49bejNNUEhWSgvZriCP
 HD0ZJdI7comVAMjOhZOl9ZWmVaARJf5p57rHboqExaFwh/ZAZIOdA+z2oI3gf00kc8MJ
 JgdfHZqfOFuvINQ9ZNym4nadeknB2qelNedYUiFUrJUQgLULtTnIRAM1ZUUb4udULSWF
 dlHTzridSxz3d9rNWGpolAvmi638cuzVBTxXiYz3hLekddPuki3zunueC1ZyO4UQR325
 nWNokyoFVmXZp7IvFQe0NoAF6qfHPbsUToWTuRRIFql1tO2V3ScnhAzOIe3mGTQJfqOV
 dNHw==
X-Gm-Message-State: AOJu0YxgF6aAtVCl2n0F3ZrfBfR0Nn+l0E/MEo5k1/bPExsVLzW55omM
 /adelVMTi2EmbgPYFiHU7JtFxXZhpz/ycq6ZzIf5Pu+OtbjNLLeMcm0b
X-Gm-Gg: Acq92OF2N53D14hBlGTM4P7ZDImikzuAqoc8taPTlnGCOq+6Kfi5vFbGAbbER+k1/lz
 3gPseeL8HabduBNTEsl7B8ssa6KZIIVv3log73fhmQcjcVo7Iki2OrrTDEgh4jqJuH4KBHLbiAx
 Fl9MoKDQqxjkF7KDqDVaWVYceNKSsXOpTTpUmtHfaRZnHLn96U9i1bOqeqgOP5dKGaj6OEKElfZ
 05KGrazF3u2QN4QHXFecwF0jjEUc34Ib33ZW4rNizjLq7V11tupBwUOj/twdAwo/sj1zs6SzW8m
 z4O7Cs6BfrReEik4AfH0wVtYrVC6WWkUXFqSj9nQRYX+xVNgydokT+WZmHxfhQUhpvADyj4LWlk
 VIBzoahZAqv8R3KzFlv7+94DMWhwKAiexEnYBwmQKESNmRh4aJxo32H70kkp12nSo/XikLabUPr
 d5+lNzELr+pnQ/EaUxFXX3638HO7KzS9lIF1KVOwUTkR9Mc+9fFZZcqOYmE/LxMoTLUugT95lqt
 Rm7qe9VIH4Lp9UxSAIXX0Sq8duVfmzRAvaz3y/DUjGu8OQw2SQsg+FCKYEr8BGseSUV
X-Received: by 2002:a05:6820:4b18:b0:696:89e4:5493 with SMTP id
 006d021491bc7-69c9437cdd3mr242235eaf.34.1778780292391; 
 Thu, 14 May 2026 10:38:12 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:11 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:08 -0600
Subject: [PATCH v7 19/35] target/mips: add Octeon MTM1 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-19-226686be4ce1@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x334.google.com
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
index bee64c1743..e6b06ac4b6 100644
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
index 9d7fa47636..623fb093cf 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -295,6 +295,7 @@ TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
+TRANS(MTM1, trans_mtm, 1);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


