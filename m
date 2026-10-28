Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE445606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lxDZGUMX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aC-0006TG-TI; Wed, 28 Oct 2026 12:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aB-0006Sd-Fz
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:59 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a9-0007Ww-SB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:59 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-713e6ecf595so894960eaf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205177; x=1793809977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5j5+t/rNvpj+687FV3vQnTBAaY6AK814ujVkWS3xeMA=;
 b=lxDZGUMXpKHvb11r4ya7/O5JDNvmSoyx7+/qq0GdSgz5/1lBM+zm9Yv0rEDSBRW+uf
 DKXe7nTl9EIAPIl9dyJ83pmlcFat2tPKfLCHCy1BG4SIbdqceBbZAVWYnnerd+Bs1gW1
 dtmuEHaoGs6hEREVe33kvwPQVBK0TF7etXQfCuszufLTZDpR1n0QX99t/JHB26i7hq/T
 jXKdpnKruBsteOGcENJKGzZ3KF39LILLVYzMidW/he4xz2Z3N6xrYgiTyjcmffK098QO
 Svok8PGvV4qB1Rmybo9s6MBPh6J5hLm/+6+d5hn1MceZxxkayMveLlZ3nkC3cBoFANIg
 Yctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205177; x=1793809977;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5j5+t/rNvpj+687FV3vQnTBAaY6AK814ujVkWS3xeMA=;
 b=nyD4LRBNtlOyyWUR1vJV/WBTe1PAUKyfeIEC5zmA+cf2YDJJ0wW4M+97hutPe3n74O
 oXWBMwf3dMXBuNHDupf49yS7r/F2RG5UuO9+lowAmlzU5Tu5jOo/SnjiQqDnF/JMcxGc
 8emiJBmX+9hghweIvbJn/TQzYJhO/5t1GcaFvK+jqTy44rAULSBZ3baCFWN16HCubggA
 gfjcAm810CsTyoDtMQfLJkdaChM6B565Su+ryl+rcNK4a//cqs0KNPp9mm4Zd7Qh9fzK
 IqDFxnWsO6XCHFuXXxIBeHA5L7IPi4H0HDma9BI2nonWzPuIFnvyqmlWkPCPdUg2woI7
 6G9Q==
X-Gm-Message-State: AFq9FYJ72Uzpm/Ml0UB1bYDP7WhuLdGN+mNAZtFg+fx1iKWhCdeu1EiX
 lfzzypLXdj5afWVZKHCkNDr8LGYY6875fH7APZOb/ZA52Fwqzwufam9S41xVF0tgbwtF+1F2Dmp
 AlyyJ
X-Gm-Gg: AYBFou2j5Uxs+jKHDf5yo/ChU7jCI6UQhqHs68tEJ+yrEaetSm2p6N3rr0dlwV1KjLZ
 WAVAdGx2q6/SkW9CmDaBrwA0il5/92PwZ0Ay90NvDXQ5iuqHqAgHvLmMfmc+UCxM8L46npuNJBr
 FLGUs5ZxJ0p6qrzmfFjB15zifk79NqFeaLB+A0kGPiHMlmESkdhB5QbXHIU7LbXIWe8xd+NoOUz
 065nKi84oRu1n2pPB9Ky7V3/9KYRu3mhvHAnZYqn2wC0OC+PRwB5MzIMB5ESA3WqoitHGEgDM0l
 rPfzYH9wDt93AqhJZoRRZihbnYkkuN32WDWFXqNPDtb1Vupqc7GRRuMtly6byB0Lzh09febgZ5W
 qztjSaosqd5aALGVli9MSCPcXNTeIAe5GwLaqmIOdPVQKOByh62rK8n7WXVplWxTedGKcUs39pR
 2oNbISkGSGrbwFQiPtjHEZhtfN63gWdANCuljxt3ooCnOY+0CqljUbSZT9miuKCnE8XGeJ/9i/h
 S8xYw9pXx5p0flhLlEiHPTajcbrYW7zX31NDTi6lyx/Y1LptgmZlVFtMRb6guRTG3KVtDFw1G8Z
 OlXv8esLxtlLcfQr1ph62EY4NKMSSObgxw==
X-Received: by 2002:a05:6820:1898:b0:6f6:1e3a:6e1 with SMTP id
 006d021491bc7-714ddf7f9c1mr26981eaf.44.1793205176603; 
 Wed, 28 Oct 2026 09:32:56 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 07/16] target/riscv: Use tcg_gen_lea_tl for SH*ADD
Date: Wed, 28 Oct 2026 11:32:36 -0500
Message-ID: <20261028163245.1031673-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/insn_trans/trans_rvb.c.inc | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
index 3e74be223b..82e715c7b7 100644
--- a/target/riscv/tcg/insn_trans/trans_rvb.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
@@ -336,10 +336,7 @@ static bool trans_orc_b(DisasContext *ctx, arg_orc_b *a)
 #define GEN_SHADD(SHAMT)                                       \
 static void gen_sh##SHAMT##add(TCGv ret, TCGv arg1, TCGv arg2) \
 {                                                              \
-    TCGv t = tcg_temp_new();                                   \
-                                                               \
-    tcg_gen_shli_tl(t, arg1, SHAMT);                           \
-    tcg_gen_add_tl(ret, t, arg2);                              \
+    tcg_gen_lea_tl(ret, arg2, arg1, SHAMT, 0);                 \
 }
 
 GEN_SHADD(1)
-- 
2.53.0


