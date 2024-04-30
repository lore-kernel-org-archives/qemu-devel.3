Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308CFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qf0-0002ES-JD; Tue, 30 Apr 2024 12:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qex-0002Dp-3i
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qev-0005bo-I7
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5592so29985985e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495725; x=1715100525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rohcqdho/QsiHvs0ZVMO0uh/LJCHZLF+RintcSkxghs=;
 b=dJSQg/s63lNIv0DzFdatHw+J1yTxGkadOYsklaGFd9p2gJs+lK5FYnXzWgko9EhbKy
 ROccDkEzeJtD2EgEhFPfs6Wa10hyw9NqgqhJyhGz06Vjl2DxLH/BZjTKhMlpKjjdNgF8
 /E9Fgtxy7H05TAvWF+RXgqXir6YjuglHAFK1r7M8X7tqBritOGXcwEns7/nf/J9J63H5
 nBRYo2aBUqyzI5fsgnWxLu6g0CwygDOAbLDWjpWXF9t3VKZoX/Xy4FNeZ5M5oG/+5+kI
 cveXLtNUCc6BZPx8iTTJkn39sSkVSXYLsYjZvjc4nViJmDOuqhR17P9w7DeaEA3Ohgva
 Nxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495725; x=1715100525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rohcqdho/QsiHvs0ZVMO0uh/LJCHZLF+RintcSkxghs=;
 b=C4ooT3ogD6dJsFm3bbn/KvHwKsuVkFnwUGIMaM3jjuVIP1NT2GPt3mkiz/NK5deMTF
 OYmB0NH1g6zkAJ5kSc+ZxE+2Mu+dzp7egaPh9D+y0xUzLkK5N/Iq6igeFPeskFH4/UA+
 UKkZRSg9II40zY2UlOWUIbqxsWJo5Ye5woIULDHhSJqQYqyBsSe9O0zstOEM4m079dkk
 KrAXwZeBsa/ZEcUOOZriqoFiVOhDpDTWt+j6ilZ4dCo8Gh+2VNMjnIqx/Kix9Y3KSwxo
 KVrSmyeIaQvtWwl71YseFdNclrqiT6tD20spt/Pu8sttaQLZ8eJ2XdA4/BJTgldHwQKo
 v0Dw==
X-Gm-Message-State: AOJu0YyiC94tKyUnDJ/Hao18AvbItHEA1FwK0YImFGPDSweyPsCooTL0
 bRqhWIvLIfyeCYK3E4BuxuPLDEk13T+2TTS+Tj7eLA1E/W9nxKJuiiegWvPGQ9AZhwDdnrYsYi+
 J
X-Google-Smtp-Source: AGHT+IH+ukTKEQEXkrwpcDFynT5lBqwiP7lhJkoEITHucqPCiJ4yOMlcjXv4xLMM6sBki3kuYLk/ew==
X-Received: by 2002:a05:600c:5794:b0:41b:f106:bb89 with SMTP id
 jx20-20020a05600c579400b0041bf106bb89mr89593wmb.18.1714495725331; 
 Tue, 30 Apr 2024 09:48:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/21] hvf: arm: Remove PL1_WRITE_MASK
Date: Tue, 30 Apr 2024 17:48:23 +0100
Message-Id: <20240430164842.4074734-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Zenghui Yu <zenghui.yu@linux.dev>

As it had never been used since the first commit a1477da3ddeb ("hvf: Add
Apple Silicon support").

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Message-id: 20240422092715.71973-1-zenghui.yu@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index db628c1cba7..8e942f89b35 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -150,7 +150,6 @@ void hvf_arm_init_debug(void)
 
 #define HVF_SYSREG(crn, crm, op0, op1, op2) \
         ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
-#define PL1_WRITE_MASK 0x4
 
 #define SYSREG_OP0_SHIFT      20
 #define SYSREG_OP0_MASK       0x3
-- 
2.34.1


