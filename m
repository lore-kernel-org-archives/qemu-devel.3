Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C491AC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJYP-000783-TM; Tue, 06 May 2025 10:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV6-0001TN-O5
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV3-00025t-Ju
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:28 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-441d1ed827cso4604195e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542542; x=1747147342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iaRot8lpjeibNl8vHrlolFRTMgPm1jY7hWkc0lrumMQ=;
 b=qULwgcREOxy83GJwNuuLvA5YzlCPFyIzGcWe9pXKHZ/Js4+y0274sVv+5bG8cE79pk
 92cfTPrEx5VJ9P6Mf9T3tz0Zm0Imw/NgAM08+/I0bWfRn0DjWMBfoJsVY218LfLILeYs
 kiIB1P+DTCJIYji4puxlZIl8j6I7D5PJhARETOtL2BFWhMPFHzXR3KmCH0amUaFEhZ0m
 jwXRREBE6/zQFFT1qFwtqo8oZR69jgDMMzNIwseVVvrGa72eI7MqOye4MXAes8lVgBU+
 uQId3D2Vnht5jgsWctqcJ1SAWJ+U9Bb6vVq2s/HjRwPLDkIo1BZedhlPNGtC8CPuXXAw
 Wysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542542; x=1747147342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iaRot8lpjeibNl8vHrlolFRTMgPm1jY7hWkc0lrumMQ=;
 b=B7SsX/PR8MhVQaRgba4u6gMhheiRNpIb+EZBL2mmJKgLMmSLfMN02u5SCJtotrw/qj
 pcZnTTXv/xq+fBNYeS1PcI1VX9fZJs8ATCH0PEtjbD0aK69INDYZUlOfhwG6hsyGyvQe
 ylBubMcyXneuJu52w/8b0aCaml2Yf2CVH7JkyqYpYncTlwEmOy2IcC48KzGRNcoioXaX
 1R2JH/renLFXeHVBUzhMdANOWQZfEOhnE7ezdGU1BDQ2ZakWY3sV2g0VHJG0vg5Rdxns
 Zyunw2mYaoH5aiS1yOCfkjazP6RitQptssj7NcJ10DDZnRL74mGTR2Z+Nthx85zoX+9W
 Uh6Q==
X-Gm-Message-State: AOJu0YyM5b2F8sJEICK44CmPYs2MUWM23Fi/syTAYeguS6zDqBvs77Vo
 PHZErrfsFzowXKkTRnS65zIEABrCw/JktxZ11VoY5Z7uX5T0JAzYlI3hJx4/P67rV5OhQA9OquU
 T
X-Gm-Gg: ASbGncuMVPMmgPhu77YQ3KQwJJUELb6WvqaQmZi9MU+I0Iq68DbV6qnf6RYjmeOwvRf
 lSOXN7v62qMDHjD2bSb3mW8rH3MWcE534uJhesDvq0wh9+wIhxY18l8vXXxrmt/kzPOE61dFBpe
 duPI8k+NgxvvqU6rtPeiWGblijfj7s1TXhF32XA8szQ02E1lmtCOQKiVZdKtvz3VTZr0YPMlWQ/
 HWdXeNCaye6erhluqWirMpU1BtpfGroIG0POcvXqulJVQF3XxWddt3q6y+u3KK07OEQW+RjEIcR
 DUi5xBQz3oHgMTVO55XtYRCC47nF4T56hshG8tiFCWb88CA=
X-Google-Smtp-Source: AGHT+IGY7vqTYCKUDiONvepX46N8AZBcB6Y3OE7YRg/R2aEV78sgKLKG2kGhfHwEfmEotkFVpgJw7Q==
X-Received: by 2002:a05:600c:4ecf:b0:440:6a5f:c308 with SMTP id
 5b1f17b1804b1-441d051b271mr36444815e9.13.1746542542151; 
 Tue, 06 May 2025 07:42:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/32] target/arm/ptw: get current security_space for current
 mmu_idx
Date: Tue,  6 May 2025 15:41:47 +0100
Message-ID: <20250506144214.1221450-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: <qemu-devel.nongnu.org>
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

It should be equivalent to previous code.
Allow to call common function to get a page address later.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250414153027.1486719-3-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index bdb4de7c047..0ae9c5a3f49 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3636,7 +3636,7 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    ARMSecuritySpace ss = arm_security_space(env);
+    ARMSecuritySpace ss = arm_mmu_idx_to_security_space(env, mmu_idx);
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = ss,
-- 
2.43.0


