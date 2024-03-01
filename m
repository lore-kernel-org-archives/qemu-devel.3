Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79DCC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7gS-0006Sy-7d; Fri, 01 Mar 2024 13:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gN-0006Qa-P3
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:31 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gJ-0008Lu-HC
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:30 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51323dfce59so2189163e87.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709317945; x=1709922745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+dys/cioNoZhTZtInFG+2Of2YnqX5s/i4q/n08XiVo=;
 b=d7bfaO/DwNC7mpCcQBZFHIioi6hZ4fuHU68ZIioIddceV5UNwRCcjUNjGSivrYO5Ss
 9VAr33G5Vi2/379arO4gW6q1AFHpmRWAK1hAMSONhxQ2tNMHOWvQqGv5lP9zvqYW3E+0
 q2tPJLFyl5mhvZuzyp+cM0WDJgCxqvCwUjnmu8WnnQLvHhxkesKIzGDJH/gSoI3j7IK1
 6pDDG/4mIxDOtv7dFqskZl6RYVTBT0o7cH6x5eZG1rfg2B4ovcKZz4KpHUG5yH5V3DMM
 HUeyq9/oVl9WRP1WpPwt20F9oKT/R+AMir7ldFogE2esXsIYPb01nEKX4nJIj9YXByxn
 yqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709317945; x=1709922745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+dys/cioNoZhTZtInFG+2Of2YnqX5s/i4q/n08XiVo=;
 b=sGYjSpklQViSgyYPp2Zc8O2wYCNl3LsCINMOpwqhtMjmCezJhfOQbhvM13sx7qOqIN
 53iaHCS49nvRp8kBDHjVCg1If4oPpfWc1BgAP6ubb5coc6WWDy2GCBWp9rX0cXYPq/Y/
 Ph35dLpYkCijQ1XG86tAJBw+Bsy0lXwo42Fdw25QxUOq/A7bkA6XaJCsVjXsA3OS4/Tt
 LSuqmZmfaUbP+VgB6sd0zutc8jvZulT1tZHqj5p/AgW7Zf9Dh8Zmq6GMgH/uIgae2TFq
 2tyMXzzn3poHMktsKQaH400VgfbXFD8/TzOatR4L1x0adAsxO4AOCt14w7HRkTrzWk/d
 3WYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl3/TdE+YWCP01BArBfJLL5ZPoVrvlBcRchTV8gMz7Fp71RiQfccztu3FHTBlfSPqMwR7WrFVZc65iTHVqMyKK+NJStN8=
X-Gm-Message-State: AOJu0YxHoreWiL4OeNptPW7qcFTyf3LrRY06lBlxAnSiLLnXL8bIH/yE
 eSmcSGbgk1g4TTXtaMn/KfXK0pacK2XACtbQORpi26dTdfypPKrrJ3zD+T82X8c=
X-Google-Smtp-Source: AGHT+IEgUHu/xZbIv13m1FIFX3u5GcnIRWoOOKgSZR7SlQUgv46qsabqOHMfvFw6p8ory+BS3X4asA==
X-Received: by 2002:ac2:5e24:0:b0:513:2010:6d93 with SMTP id
 o4-20020ac25e24000000b0051320106d93mr1762866lfg.56.1709317944962; 
 Fri, 01 Mar 2024 10:32:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u2-20020adfeb42000000b0033b483d1abcsm5158934wrn.53.2024.03.01.10.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:32:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 8/8] target/arm: Enable FEAT_ECV for 'max' CPU
Date: Fri,  1 Mar 2024 18:32:19 +0000
Message-Id: <20240301183219.2424889-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301183219.2424889-1-peter.maydell@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Enable all FEAT_ECV features on the 'max' CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index f67aea2d836..2a7bbb82dc4 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -28,6 +28,7 @@ the following architecture extensions:
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
+- FEAT_ECV (Enhanced Counter Virtualization)
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 5fba2c0f040..9f7a9f3d2cc 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1184,6 +1184,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN64_2, 2); /* 64k stage2 supported */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 2);  /*  4k stage2 supported */
     t = FIELD_DP64(t, ID_AA64MMFR0, FGT, 1);       /* FEAT_FGT */
+    t = FIELD_DP64(t, ID_AA64MMFR0, ECV, 2);       /* FEAT_ECV */
     cpu->isar.id_aa64mmfr0 = t;
 
     t = cpu->isar.id_aa64mmfr1;
-- 
2.34.1


