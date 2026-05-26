Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BBDCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmu-0001QJ-3d; Tue, 26 May 2026 10:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmp-0001EY-PO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:39 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmo-0001U8-8K
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:39 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-459bf19e87bso6314338f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805777; x=1780410577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pGYNIEOr1rNrvCWNsFYjRoJ1f5Nr8vGA4w0m+3esayE=;
 b=GhXSAaWLUFbIkDFSZKO9BSBfBd8O6fUTl4IXmaVea1vTVRKEha+6JQk8lcdApTkiRW
 CFrKiNS9DEeFKQaxTw4tNDNPCDoinnV+dhibOptfqqoOms5raLqTsYVa8HltY5Je8/Ht
 mRx3rvoZIBomDfZ7b7b1eU7o5dOGPuRkTdbsJhzQo3eifOb4MrfTfpX9q9ZxI4tW+V9M
 SHWFAQxejBbenru6BfiNRrRyKob6qxbX72uiSekmcdyVXAGarze1Ic7jULwbAE/84cbo
 Kmditgxs9mtCYAytUTKNOB/XL6tBT4uQ36XcLjN8bh1apjuv8wKRQ9qSnUQYvJdAkwm/
 HdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805777; x=1780410577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pGYNIEOr1rNrvCWNsFYjRoJ1f5Nr8vGA4w0m+3esayE=;
 b=MUVDDj9sICFEmIib7V7jj1CtUIIuepElhAF7v0XD6PetZKjVhx/tPJqfgOcUDtCmkx
 7Yg3hMFE3rYXhi+jeTsJgIJajC/VhtrRcn4SCQnVHdxW2aIlApSAOUiLrUCenQMs6cEB
 amX6VMlKx29Aul6LGRsxoTzjuQpywMjJoRpfEofYuEXXHAjZSofex2me28dhkc0S+mDP
 thw7281AdnCjxDcmzb0jpMYA+YzeGlyMbqZY8DJ9Cq0L1AvCZmpKFM9CPjQMD8QiF6aw
 HAvVMDx7MGODDaosVcoarq8vQhidaHlaUs3H7qJnsCE69bVCifybvW7Du5rNY4PbT0P6
 Yhbw==
X-Gm-Message-State: AOJu0YzPvoKjiQR87MnthU/+j0SFQz4Vy7gxwgaHQgXpgirhQrd02VJR
 RhYHEbW+2fo36wSiuIXl5sJO5DCHfFDPI4dhOsDkLyXtF9MzDxLlNj1tvKytJO1RToL2Mr0pYPW
 l/26l
X-Gm-Gg: Acq92OHQtH0cvKJG6CqHOB480sBDxLdPj+NyK06zH1bdjmVGq127chLjfnALJN0PX7y
 dXJdUPFlxgENzXtjSzbrgA62xpveo8KyOSSWMb8Mnk/3XQmPf91Vjl1V62+HfeL6kLMyWwkmG5W
 XxFIba7nMnWCji1oxaimroixcqvlGSPjCqHv1f11wGYE6wVw2SesA/MXFa7Ub+K0MOSm3ofg4FL
 mBMTeoDtbSic2iQfO+4QuRuuzKtkItND29FvywJo+x2v56dGA9GmthY/k/V6tQaMx3+XdY2OhHE
 V9Rv48xYkwFRQsppABznTFhjI9v41QIyTR8y09V32qTm/NWYKsKzNeeXohob3b7cTkLPtsnh/0o
 MmXXYTxj+V1cgmPsb2diPv1BNRSQlma3fy6h4Oef45uKTmXcrf+ViisXwaD0aCwjPyZ9u7KADbR
 HZOUUv0EO15aB3IKe+I/dqQwHdx0dtt89gkB9D2yXYjNvnHxgHzuBWe0dL+Uw5oDzzhmBHIxowP
 hvIHCg4ew3ooL7ersx8DOiOb3mkMaPsJocOUSwfgw==
X-Received: by 2002:a05:6000:2384:b0:441:3144:efc5 with SMTP id
 ffacd0b85a97d-45eb38e4fd0mr32451419f8f.42.1779805776931; 
 Tue, 26 May 2026 07:29:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/54] target/arm: Dump FPMR when present
Date: Tue, 26 May 2026 15:28:42 +0100
Message-ID: <20260526142850.2326589-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 84b2cc70e2..facd4def38 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -972,8 +972,12 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, "    FPU disabled\n");
         return;
     }
-    qemu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
+    qemu_fprintf(f, "     FPCR=%08x FPSR=%08x",
                  vfp_get_fpcr(env), vfp_get_fpsr(env));
+    if (cpu_isar_feature(aa64_fpmr, cpu)) {
+        qemu_fprintf(f, " FPMR=0x%" PRIx64, env->vfp.fpmr);
+    }
+    qemu_fprintf(f, "\n");
 
     if (cpu_isar_feature(aa64_sme, cpu) && FIELD_EX64(env->svcr, SVCR, SM)) {
         sve = sme_exception_el(env, el) == 0;
-- 
2.43.0


