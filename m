Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD47606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pn7B5mjf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3W-0003Yj-0U; Fri, 23 Oct 2026 10:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3S-0003X0-Gi
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3Q-0006oX-Ns
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so10142915e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764931; x=1793369731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ioZTYcnwxdwOikiX6U5CQVbz0h/jqyIs+hPhHLdxcR8=;
 b=pn7B5mjfKEZZwPtm7GJ781+KIHGXBCybIfdwcCAbYRq9laic01f+v2fFkzevvXkxjH
 3ti3sA79zC+ydoOsqaE3BOzd6yiSzWkBhPZ4svuwuG+Ej/WrA9c5iQwwOPn32ruxwwY0
 ectPFbCzTUqEf7Yfuk+tx2fgFyAlx/w7scACmj7WmQ8F28C9HshE/qm0a1yiV8N41VHO
 SoNpAHD42dyJDPStsxQXscsA0mTtL0qGakq4xuPI97l3T8D3uJfIpj9j1bv75r9pUEnl
 QfJ9H4C9du6O3dMiXupI1SD6g39812HNbJdNStIsEjAkHjlgaRrQv57nVpNI2aXEAzlK
 bWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764931; x=1793369731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ioZTYcnwxdwOikiX6U5CQVbz0h/jqyIs+hPhHLdxcR8=;
 b=fjYfQxjKwHHkz8C7URk/hYIdCtTsSlmbxMeTHxuyUZ4rfzFtPnlz3HY0XcyMNYoI0p
 zsCyYEUBNNxnnAOpQZa0l9RmUd772wEyQe2/egXXn50nhO9EH3qiPbmfAzii57oR0gj1
 t1BfnsGPUvjEqw+D+owTg8MHAut8DTNjPODizEDLArKpMSC7aYG8BXo7utQjdGTz/zHv
 mwB9eupSHfqimhv/9G/XnYcdkRf4PPohQ+bsVKbeF9WhgwEMcrR3KDQl0zhi3SNlgn8M
 HZqp7j7X8GLXGyC/zcKJmXA7WoIGInXZq+xZzkvSzF6rO+EZa1sA6lnwfxDed/uCHtXV
 YAKA==
X-Gm-Message-State: AFq9FYKtcAL3QdWMhZ4pqpnPcnvdHpDneZjqosgcIp8JyCanHB5Zj/M0
 LPLd8W9zebxrEGRHaGNLmxkPgvd3va7x11CooPWl+IsRMKJI/utIfitnAMME81R3tx091Hcws6T
 YJFD1ARI=
X-Gm-Gg: AYBFou2HesWYDipfj5BUzk3tR6A6ICVSqRQXqSHvL65s5RZ+oOn4PTH8W0EaoYcMk0N
 5bQjUyr7um3pUa99HeZ3lgabNvnn55USCvTzFP+MLUctvj1TtWQ//2Q2U9Hz0Lfq5daVdnqmrZ5
 t293Td+hTXD87fQol042A68EhKzY5QjrSWNMhPzoPjhwWhnPrSEyFFUpD5F71DHFE2/bcw/yqfw
 wZLWQvk/fLrFZdVebVW4OcAfOcRLfVT8tZwbTkc2+h7LQcdM+KyS1oHgc4Dfro25VQbNrEEv0In
 wkQ2qsAZnDJrTPe9+Rrl6D5QjbSbFNgnv4wiaXyWtuRwp0D3dZj0eWryz6KTWCQMTgABoV8+YQs
 Z3ETEK73dse6MAyULwfiHs0pc3I3VLj2l2Wmj5WeGz1FKaqlR7THEGUUBIMVG7tStREo+d+w1D6
 5EQXKrwPYW5ssFO47Rdk2mBOsh7OwwnvNTGSWLf5DB0mT4+UsJU/hwkwBU+Y8s9bGAVeY4g4QOd
 5I5cIPM94Dl55FUyNDrkOkFtx93H8RNUfhflMFWnMx513GiVw4IA9sCFDav+nXU2S2RJiiZYqSP
 4XP+BLuCvgBAaFcx9XRjhBfnyC/DQEeLTeoVRbQJEB4Ym+GIUfB1xjXmoojLX6zIEeEhCMVyO79
 KVer5zA==
X-Received: by 2002:a05:600c:a49:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4a211c78760mr36711275e9.12.1792764931010; 
 Fri, 23 Oct 2026 07:15:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] hw/adc/stm32f2xx_adc: fix left-aligned conversion results
Date: Fri, 23 Oct 2026 15:15:03 +0100
Message-ID: <20261023141503.1397009-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Manuele Conti <conti.manuele@gmail.com>

Left-aligned regular conversion results must occupy bits [15:4],
[15:6], or [15:8] for 12-, 10-, or 8-bit resolution respectively.
At 6-bit resolution the result is aligned within a byte, in bits [7:2].

The current single-bit shift and 0xFFF0 mask both misalign the result
and discard significant sample bits. Select the shift according to RES
and keep the existing right-aligned sample generation unchanged.

Signed-off-by: Manuele Conti <conti.manuele@gmail.com>
Message-id: 20261020211529.99689-1-conti.manuele@gmail.com
[PMM: expanded comment slightly, added brackets for clarity]

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/adc/stm32f2xx_adc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index 50a04a0722f..c8e05def2b7 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -69,10 +69,12 @@ static void stm32f2xx_adc_reset(DeviceState *dev)
 
 static uint32_t stm32f2xx_adc_generate_value(STM32F2XXADCState *s)
 {
+    unsigned resolution = (s->adc_cr1 & ADC_CR1_RES) >> 24;
+
     /* Attempts to fake some ADC values */
     s->adc_dr = s->adc_dr + 7;
 
-    switch ((s->adc_cr1 & ADC_CR1_RES) >> 24) {
+    switch (resolution) {
     case 0:
         /* 12-bit */
         s->adc_dr &= 0xFFF;
@@ -91,7 +93,13 @@ static uint32_t stm32f2xx_adc_generate_value(STM32F2XXADCState *s)
     }
 
     if (s->adc_cr2 & ADC_CR2_ALIGN) {
-        return (s->adc_dr << 1) & 0xFFF0;
+        /*
+         * Results are left-aligned within a half-word, except for
+         * 6-bit results, which are left aligned within a byte.
+         */
+        unsigned shift = resolution == 3 ? 2 : (4 + 2 * resolution);
+
+        return s->adc_dr << shift;
     } else {
         return s->adc_dr;
     }
-- 
2.43.0


