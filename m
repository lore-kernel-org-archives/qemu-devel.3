Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4448F99369
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquZ-0007Qr-Nr; Thu, 23 Apr 2026 06:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqto-0006TR-30
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtk-0002AJ-TO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48374014a77so84334635e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938582; x=1777543382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y6pW4GJO8LH2c/4U7MIrvNXSv3KgyWFqUobZ6FZ67NA=;
 b=ZxVk4SpJLRh+UUlwumvOqQ8Gbx9wJPtbHurFLU6Nn2StXZ7HLH7f4mIjeSbvKJ1/aH
 LgdYniIaCxgyZJUg6cn4yNwYzGB/LLe3BjRB/YauBn5goIKCqHSox7PXVEF59LLKCZm9
 /f213yeYO2G0i1iDFuXTKc0Eti7GnK3oO6KboGRgE1LnGZjbPMIIE97aNECA1b7kQidv
 U929DgRTnVcPczU8X6KY8VIWxoHvKP1xlYBwSWoFP5UUoLzIfj3W6PTv/ojmfIFyA9N5
 Hat79yWbvBAMx5NT7G2gwjD/qZlgGUJ+o39pzA0n32R+gm6sirUATZzSDKFIXvzrt8xS
 kogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938582; x=1777543382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y6pW4GJO8LH2c/4U7MIrvNXSv3KgyWFqUobZ6FZ67NA=;
 b=kjcW8psOVwpER+WKa6fYBG85tGk897caOdgGFckiOnO/gdM0LetzegXud6VY3oiuv2
 EnVArJjfIri4vocoaChOxtj0tbrOAmqFNbs2iX+5TZAOfVktXoXs619YI3aP/k8yrep1
 lgKCD2BLb1EgTc0pzCjNEptlvAxSv5seoV1lz+PVKx+Vtfc3Uj6IHSS/t8DG9YYmdKl5
 LZJAyRso16670V+dWQSWFRJXGl1qepz8ZrBT8L6X5FGgvNdO7QtzQmNLh4RbLCGX+WMY
 /D0JTuSVdfdqqcINjii1Nc800orXQ2oq21WXpwYf1A+VzYSX2EDNJhUbrx4wgjh7E9TH
 MCiQ==
X-Gm-Message-State: AOJu0YyMFjfbBGj8YDroOM9d31UOOZ+oCKqMLtZNF3Yj8/GWk5HI7aaJ
 DU+H1A6LSjTBEGUmGnPnFLWU3yLoKUGBgP24lHJjVZxi2RaxSnKMPN0Z5MbjIX+9NKdrGEmwNUL
 QMqKE
X-Gm-Gg: AeBDieuVMtnjK4nO72lb1QjTJWMxoq8e7X6THeZhvpYR2gHJGwSM7/X4Z5O6HfOYd/x
 VGwxBr1Z6SuwiV4SasWpzIqYjz/dn/YC/FPm/CxtcyVEXecx5AQVV99wj9FlhjDxJn2YVReAbA5
 T/yt6X5IYNXq9a3Hhm+V5awKT7axQqpigD95mXjXm163i0eBmRHTNEQWicijI93AvfMjyBOevCQ
 U1XpUE32PXzQj1ZuMNX5BMykEl4a51nj+Ltc/X334ReFN0v1MwjlTj82GJG+xowAzhtdMz8mOX8
 xrtBWHfcD0LaKTSZbUnECSJcsJsjGVWwBU32Vco3FPfYTv+vLF0I4AvHAVc0m1RmeZugg+7jvAl
 2cq1dVOO6jzU6/3YB2g64RSBkBBBlxlcOsmGcbURTOrJbw0m4LZ8nUp1pacUQJ7EGit5s8FCCAe
 wKC9y4khKZBs1HZpIIM55YS5lIvX3Aphbybzx8zNaPhTm00XB5JjYi1d0IQ7brtnEuh9KqlQi3V
 77i1Ra0KddpUPrE4QnUU1qbaFq69H0PMCuF9uzFuA==
X-Received: by 2002:a05:600c:8b28:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-48a5c230e78mr78284425e9.19.1776938582185; 
 Thu, 23 Apr 2026 03:03:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/59] target/arm/cpu.c: simplify endianness handling in
 arm_disas_set_info
Date: Thu, 23 Apr 2026 11:01:58 +0100
Message-ID: <20260423100229.2941820-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260407222208.271838-20-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ccc47c8a9a..b62de8addf 100644
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
2.43.0


