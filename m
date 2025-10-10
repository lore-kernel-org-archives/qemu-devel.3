Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B84CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cou-00068u-Up; Fri, 10 Oct 2025 09:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Col-00065K-MC
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:56 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CoX-0003kw-2v
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:53 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so1245908f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101533; x=1760706333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1FvLOemgvKDIEtSEwbgd8ROqFhdvpG+48MvxRZRHw+M=;
 b=Ivsz/RdugwW2jdt8bZdb8INp/0g0mzWGi662ybOM+ZsCy3jo3wAC9xE9qZ0+wxDNqB
 x6Zh3r7IurYZIO7pwLFw66HpLKTayE81WwMKd9CF4GzOc5XJwDFGKS56x2IS7q/ViK5L
 9bvq/lufOjrvdyWcytitlHtZW1wONr/Q8KFyhVl+8jTheR0lUir1CSo1Gw/m30arOB1k
 wPJa+dFpCWVdjb+zbw3nuDaM34SWQwWJmQph9KSRRYRW/XoyGpSMvyuUeSb1nWqXKoWd
 aKQ4nWVdAMMKREB2LDi/Wk663u3OYz/hN6xT0zQYhJARWaHKqifMLVK1MLvTzzfdkKeI
 Fe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101533; x=1760706333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FvLOemgvKDIEtSEwbgd8ROqFhdvpG+48MvxRZRHw+M=;
 b=g+D/0MW6htCycPdbvVnpwotaUdKXG6wqtDdLI2FMyVkXBkG/rp8FDDseJvyg4P7rRY
 q2j9BGGJHbPF5pASsgIMaX/iCGtczw0scMnRwxn15mvdiUxFRnUHjMStyGP/J5hEnRnS
 Dx6Ut9wMQtFaSa90Jw0pzbJhrS6slj/XYQ0Tt9nh+WWqulvOgBf54hWsIk22upewSVtM
 hQ2NYv7KtBMxR5ovnoMzeos2CL5mC5mic3BewB+JVSl8K5mknjQm2cxoU/hY7on4OAFG
 ZMSi4EkZMUilMW+yXLSriML5NmjycCVNcgYSbjDR/gcHMbOkuROKbvcTXpO9eZsB+tAZ
 n+aA==
X-Gm-Message-State: AOJu0Yz9sZOU7rJ2BhzVh2CtdwFeIrtHfFCPCEQYq0hSpWZ38xQeCGfI
 uuVzMlra84ic9d7h0cvzLAVWaPYVHk65KYooJ+CSAWEVAqMrndxfcQpXUs/b3FsA8DcJvStD1eq
 jg260
X-Gm-Gg: ASbGnctRg3G0mP9ykheMkzaOV623Z1VG5DAfuSdQ1j5sffGxnXNr7mTJklZdnSTSSCl
 xTQSV7tN6l20Aet/KECZEL3U4nQuLLqM1CvKp/CkYj+HhXAT3O0c4Te0fu14B7Y5NApJYNApzjJ
 NRyxTPlIs7WrpjqVxScpqswJv+mRY5PcfZrMQTR4n4FZCUy0DzYO6vPE0Vpas7SXtVOmhF6Prx8
 EUzMHPeNbRW7+9Fb+BlZOLHGzyxFeO8hNGIcA6G+/nGwb41cO1bezDVCMBN7rxcqO/Z3n6kGqOA
 fn9ZbvzCSwIaCnQVaz2c9k5U9roaFUB7Len5rJgJOjKrKkYyDBD9F2QDp5a/P/kxXO6K1okHVdH
 Z03TdmRXzwp/fK+ygG24YCMJA9SnrQk/E4euGtJatNUirSk2M7AM=
X-Google-Smtp-Source: AGHT+IFzMTxFI1Hy9lBoNgbo7Ofkuboj5gPFXDCUvsvUmJbTOnzYqBRFJzc2/gQ6EYmyAX2+do1Bfw==
X-Received: by 2002:a05:6000:4284:b0:3f9:1571:fe04 with SMTP id
 ffacd0b85a97d-4266e8de175mr7622159f8f.48.1760101533069; 
 Fri, 10 Oct 2025 06:05:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/76] target/arm: Enable TCR2_ELx.PIE
Date: Fri, 10 Oct 2025 14:04:14 +0100
Message-ID: <20251010130527.3921602-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b7bf45afc13..c9ebdf144e3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5902,8 +5902,12 @@ static CPAccessResult tcr2_el1_access(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        valid_mask |= TCR2_PIE;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -5911,8 +5915,12 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        valid_mask |= TCR2_PIE;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
-- 
2.43.0


