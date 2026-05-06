Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C544CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcn0-0003Q1-IH; Wed, 06 May 2026 09:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcms-0003FH-1W
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmo-0000DW-OG
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso68545655e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075976; x=1778680776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DGXaedvuvPqBP32+XrDoox80BbxiKZlCAJ3TNdOVZak=;
 b=CttPzYSp3snHFRgkA+D1iuJN3rSrYlaXCsv7i58PVDKbdGzIDN5+Q1hzldHvWel/qj
 Ip/PSnwSOKtMd6gKxEmhnDl1GUcIMmkfPsH9EW3PCy5KiVDeDinRe9oxPITBreyt0c2y
 tWW8YTRkxOKg3xI4SLstGxNchpMXDftFLGzc+g55mxZjmuBpVkY6/f1Pc8Yyra0LfcOc
 LgNHmpK2wQPP7Bwt3PUxGNhCWhGfIfwsHDolpGpSl+lfK3NYVzpY8+1rmdZqfeJEh05R
 z41LT3sDD6w4WPuqY9tDUL5VTU//H+auXKozUek377b234d7sd/Y49k98HQbHq/ZAxDL
 bcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075976; x=1778680776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DGXaedvuvPqBP32+XrDoox80BbxiKZlCAJ3TNdOVZak=;
 b=VcjJLGl4AKqy+MWuzyyVWd1YUmj9aQAwlCsHFT6EoDHfpaCe1z2aXmfMvp1D167gnZ
 C+RMK/cN0THZ3Fx7PrJDug/y//s00hgwfdFpCKcWwMmXjpIwcCEKpOu4VDaayjQYLG71
 UKy6SCM2k6fozfmflDznNeuqfiJMjhjkxnHBy6Nf4eKcFV8BWsf3FRvnf9h9kEDHyACa
 LoftJIlMJBr8QrpqINJRMQXK0b5C9vxMYVBVCId7ujSBk9PMcF/00GycLWyp02G7O38j
 XTAtzdspPjMSezIgLpkvpB4YaWe7rJRpWrPeAOhGEcx+QyYjsQsgxHC+d3LS4/yYzQA2
 CUvg==
X-Gm-Message-State: AOJu0YwUXZyWnYAx4TupkViFz623Ns8GxFXFj8wNYKOOYm0WhOYNkQRV
 2aviLjyPE3lj2zeTh8/XFvuCu1+9GgcAZvk4TzYnfwUv2G8DEWnnQkQj4mYbuLjxOcvSqRaiSwr
 wb5G/hPg=
X-Gm-Gg: AeBDiet/xdWXU0ujqmYIdJnMR6wFwuPGmPVMjJP9QIbAOJ2P2e+1iE9vCxlkVe92YkE
 tBkhFhUnR3+oe423q/dnqClwG+TA8TUpbjhf1X4nYVtvzHGEN3whE0Fm+H69fq3XjCggcc8TyZy
 ov9E//Qa3ACFcfluxd4ffIelIAjYRg0JcMKCKwfiDIuQ/EKlCBE4/Qhrv2z8qTjC3emeC+uoYhp
 OagI4rrrEcvbh3sHYxrasWXlQHEYLVCrrbfdhOoQWaFyvleTP0SJrFIIvJCLW8HBLX8RXYtefSt
 6Fc7GOdS9EIydGPfyUmDcv7yhkgtk8wPuoiAu9rhJHnmimqDwUl79TD953xN4CV0OK+KUuTRVUl
 VxCpCLv+nhtNNN2BAEVVKRhdzUdFvVF1jbUg0GaSy8ekSwclxdJu+TuPstFlAf0Vf3DeuoQmc7G
 uHRMaqpU2HDrijRijOqrNl0Qrglg02hxsQKjiETO3btOTpkpf+gYEvtfTQPZDSFltgCbMV8PlZY
 5TXPGPzIXo=
X-Received: by 2002:a05:600c:c494:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-48e51f32c35mr57970135e9.13.1778075976106; 
 Wed, 06 May 2026 06:59:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb1a7sm97873935e9.9.2026.05.06.06.59.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:59:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 033/110] target/i386: Expand VMSTATE_UINTTL_SUB_ARRAY for APX
 registers
Date: Wed,  6 May 2026 15:54:05 +0200
Message-ID: <20260506135524.20617-34-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

APX registers are only migrated for 64-bit binaries, so
VMSTATE_UINTTL_SUB_ARRAY() expands to VMSTATE_UINT64_SUB_ARRAY().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260325211728.89204-8-philmd@linaro.org>
---
 target/i386/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 48a2a4b3190..1f5c517e562 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1756,7 +1756,7 @@ static const VMStateDescription vmstate_apx = {
     .minimum_version_id = 1,
     .needed = apx_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINTTL_SUB_ARRAY(env.regs, X86CPU, CPU_NB_REGS,
+        VMSTATE_UINT64_SUB_ARRAY(env.regs, X86CPU, CPU_NB_REGS,
                                  CPU_NB_EREGS - CPU_NB_REGS),
         VMSTATE_END_OF_LIST()
     }
-- 
2.53.0


