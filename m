Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BCE10F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYbw-0004GV-Mo; Wed, 08 Apr 2026 15:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAY9H-0000R8-KG
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:01:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoh-0000tG-B5
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:40 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b0ba3bfe16so2954025ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600557; x=1776205357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Geed+LNcY7TFub3zSBXzpgR/5EdouLTW+yMNH7ktlc=;
 b=PiiAoDPQpSu2CAJX/3cnSuUXhQ5aMep73nTEcwnOTfouSSRyWZrvd+K1eLA/P8Mz8y
 xx5AKlo4IvCFMnRzjuE4ZX6nIdSa+DniLB6QCmTjOBnKN8s58GCZWODrvMu0jV+NrlzN
 4Ur8/foCaMxZdeTG/CYJXKZ+D2zD7acgh4jD2A/Ct/FhK/F+CWC5GCqGEYSQ22DrslOX
 5GmvCPI0bvQsWhkad+7Xm4su211FiYUjNjf+ARm8jIt0CQVl5KNJr0Rmy+O8vL2KgztB
 ShZcsUGO/MrO58rYgYVphWDRiXEcRgrb3aw6fW0cnfCW8VUgE5/FXH1SLMH2Nx7kRuwJ
 UYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600557; x=1776205357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Geed+LNcY7TFub3zSBXzpgR/5EdouLTW+yMNH7ktlc=;
 b=tKofsqnXda6f8InSFkSHY3QUl/kfNtIOxsgSWo6qI65lnOgl0exfIpD6O5k7rXXTIV
 exnH2tHc1YNzq/TMxa+wa5pR/ZpuuRt/yy9yPQ4tACrGralsngDrRejOgW8tBoW3wwO8
 1c4yon/hBCu1mYT1hG6ClGWx76l2pE7Xfjh7GcPN1Fp/1g0RBofkhTNfdzY5+ouyUlNg
 9P5J+efAGIJGzWfmFeGPv4tnnwiH4SK6wGSV1QXayl7rJ4RRwX0wjOCH4GG88Z64l8GZ
 N8Wr5rmWVO3aFYjHVuOiTv/fL6CTMH5xA14RKqQWGtF3USu/zKVQ7MKbJzqMx339utSS
 R5YA==
X-Gm-Message-State: AOJu0YwaQgdl/9kTcS1oyvkSdS9B7pCSHuFee8lz8FzqvyBuxIcnyMYR
 gwG6T6+hDCXetqBT2PMRb6yDNXHgUbO8F4ia/F0aFyfImD0jY49MYzE3Z1zK4+ufWkGA3bTdGSK
 P5LkCiJU=
X-Gm-Gg: AeBDies2Ew2bN3LkJ/eTh6vPJbeRwOtv+0zU1B4qHJDuOw2sNcQ8Tte41Y0MiKulk6q
 yWdme21cuuem6d7tPHCgpd78hHvGTEBflUFiys637+vID41cJqV5OGfxvnqr1EKE/S5EAEp3VLi
 61uu/MzKaB7ISaxdA+vlOHZ+/MVojMfeEXOWolhAdNHESfa4ct/sX9R8kvaXFzBJyg5//AsfIKB
 RieNRfVEjd2V4PraHFLDJovSVM43H+dUHjXgEVJJQo+F9BxmknGyXzYTdaNhqGxnjSWrtqYEEV+
 EwzADMuBXHd2VXVgj45eAEkFqa/t1CsnNm4Jp/Crbtn2D2rzmQJvs4xz7x87SMLSBSqEfjqCUuK
 aWROD0mTyxqF6oRbv6bK+vuN/WLQr7yH0+vZS6OCqcmzXDD7JTh+9YDNvx9B/hDGYQ3yulsOx3O
 FQuHORKzmkDweGH4bvgR3uShxm4RaVk8jR2cjAehk+rDWIIC4go5qUphZaG2FSnOXSthsZstbew
 Rgh
X-Received: by 2002:a17:903:32c3:b0:2ae:5350:3a4e with SMTP id
 d9443c01a7336-2b2821ca1e7mr161452155ad.21.1775600556639; 
 Tue, 07 Apr 2026 15:22:36 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 19/21] target/arm/cpu.c: simplify endianness handling in
 arm_disas_set_info
Date: Tue,  7 Apr 2026 15:22:06 -0700
Message-ID: <20260407222208.271838-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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


