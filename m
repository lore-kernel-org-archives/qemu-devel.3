Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0CAFF5138
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaa-0004PE-5A; Tue, 07 Apr 2026 15:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaV-0004FQ-KU
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:51 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaU-0007QN-3o
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:51 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35da9c0c007so5170839a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591989; x=1776196789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Geed+LNcY7TFub3zSBXzpgR/5EdouLTW+yMNH7ktlc=;
 b=ycmhkGD/9CNsJJ4NaLf+rudHVdAYC+GlPbJmWHFRIYb00PTDocbVJRRiHmJEzglAx3
 UYgojlxtVVG2TxTAVMyBsMb4I4j6Ibs/L/beYAELJw1/qyNNSRit0DrjC2lCN/7R9thE
 wVia6pTsm5K7ZaUobZBVDzzx9CAvBYjK2l0Xt6F8npKKRajTG6vnctViogiTyMENQOQr
 KO4B+WXse5dAwutJVCtfrgV98+3Lbqtvpnk8BKgxAk0dnUEH0PKEZAsZtgRUiRltK0+R
 7HzLBZHoksG0S43d207ff61L0EthKtTF1eJUxXOE7T8p00evOkWZHuwsQBKaDLELwA6H
 Ui8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591989; x=1776196789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Geed+LNcY7TFub3zSBXzpgR/5EdouLTW+yMNH7ktlc=;
 b=lM6I3xRC7r45m7Y19MZFCreAseIb+jxREoN4FtZzQ9ImorXuiWZj9QY26Is4oppGB+
 YrT33N++0bxHda8byvAQOVv3PJidZ2APav9RB633kIjpMZ1JwD3r7b3lPq5RuA1JV62i
 4id3CffyjCqCbcdDx55e0l5abPphgdZXZFEF1/Iyj1tByCXwtXNSFoclQzWCibGURc9Q
 5yCZDoy1hbMF3Zg68YstV0GwTRW7E++P/o5k3hHW3VU2bzLaDvmBszoi6hj4o4dzLLr4
 J1UI8IsAHEB1uJ/x4sjeL+14wrvFDe8Jxzto4onMb80tTdX57p0zzizuG711dMzuVF2j
 1S5w==
X-Gm-Message-State: AOJu0YwqOM4yOgWe1ApZSys3w9S3EQZeYjbUPGY5EoTEI5AlVyRK562B
 QHLBpbxQ9N1Nmc4sierCh+Erc3tECDVv/sN2nsSE7+4k+HkW3qtf9ehogCqxR41G93AGpuGXmOd
 4leNFByo=
X-Gm-Gg: AeBDietZ2Zk2nbmymHgYUe+GXht4c5nMTVJMaSA2QeD6Yw9m25D0hbQ7CCeyVG40Ajm
 pqU2QND+r+uLuj/C8F+Lay+gfby5gQAiQls2Rhe47R57c+vbLCQb0mdTbzFGNTfsaJZgRlAsSBS
 KMheoHgL+ZaBs2udqmjXI/86KbfvemoRbTuckRwQFfjFCfNsQyZ+625kNLP4PtqLi9k9l8pfb9G
 7hKZ763mjuqlgt4GxgoRA5JPfD2gywsDVcSBz7AcAP/DxpqMm06ph7gMegx85/HyZLn7amqf6n5
 sbKz5Max5UI4ctu8fQvy7U8qkyoKBot+RCBF1+ibvoP0U3kwtmiGZO3PxcuDHjXtSEd0aWTCNes
 WPOkvHS7zae7mHN/v2F9QS5PUUb1Q4hjQObVBDyE2dd1ddTJ8W/UqnW7rLHe6P5X4oHLe7JnTJg
 pxEf8y0Fiutfd5i+MT/ZIUWsFuP6SjACbYifvgVE7qxbA05ZDXUSlLa8MoMmvOo4zu6NTXixcIv
 Ma2
X-Received: by 2002:a17:90b:224e:b0:35b:e56e:a17e with SMTP id
 98e67ed59e1d1-35de68cf52fmr18712203a91.17.1775591988444; 
 Tue, 07 Apr 2026 12:59:48 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 19/21] target/arm/cpu.c: simplify endianness handling in
 arm_disas_set_info
Date: Tue,  7 Apr 2026 12:59:20 -0700
Message-ID: <20260407195922.196410-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ccc47c8a9ad..b62de8addff 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -828,15 +828,11 @@ static void arm_disas_set_info(const CPUState *cpu, disassemble_info *info)
     }
 
     info->endian = BFD_ENDIAN_LITTLE;
-    if (bswap_code(sctlr_b)) {
-        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
-    }
     info->flags &= ~INSN_ARM_BE32;
-#ifndef CONFIG_USER_ONLY
     if (sctlr_b) {
+        info->endian |= BFD_ENDIAN_BIG;
         info->flags |= INSN_ARM_BE32;
     }
-#endif
 }
 
 static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-- 
2.47.3


