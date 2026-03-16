Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33994F46449
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PM-0001SN-Af; Mon, 16 Mar 2026 06:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PL-0001OL-9f
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PJ-0003fl-MR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso38930305e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657764; x=1774262564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2BAgs/8niYiRdvoircoJp/jBBqaaKqCs7j42CNOUdcU=;
 b=eJvFOyTZTTsSsepfY0bLO0jz5S3Tn3h2g17bMnTkZpHA/6h8pwVqCGl7II/V914LJz
 ibODDGrnYR6hA4FHBVKVYsJg280cZkuJN0qxkteua53jhvMpiZDxDUblf0Nt+FNb394k
 2QZbpKpB07dKtPikUsehTWmxJKl+Kd903p7WoAUQkzpL9jNAAFTDysM6SWD0uc7OFFzG
 LECEALRnapfQcBnRjcL2jjCrff0Ky9H1nkP9aXhKFCcKZuL2S7Mm3KZ3rbxieUBxDHXP
 lQ44Wz50rpcnHuqa4BcXbhnHj4a2TH8XUcjAkAC8AKdU4MVGVC21yrBYnpcvU+Ij/Dnp
 n5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657764; x=1774262564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2BAgs/8niYiRdvoircoJp/jBBqaaKqCs7j42CNOUdcU=;
 b=lq62CUQREjadcgD31PTQuLYGf45tsvydTN6JxgGUOlLv9N3WwUdEPL0BuMy0MIp8fY
 G2ortWMC7TMtvsvSO5Z01f9m1WAFAthjT5ct8n++0/QdyzT1f9ABw38rtPdIIEmmOCmF
 G3zO63hTTb9ppVEOGfxsV4MbQ3zruOp/rHvpa5zvHLFFUpv/6Xrl/9FlxonZXEbjYoMX
 paNhidf9CX6r47hxAGoL9FdhjWF4fG8asngv4NIE8HcL77wRTIPQuZevwnfOiAxHvccT
 0bHnVzoeXNnhUjJK1n+6IwYsN6iSCeVmYVfsIxEJSNj5fQc5XPmjRFFDrvalTv8oHSwl
 tuNQ==
X-Gm-Message-State: AOJu0YykRitNQtj29z8p2cgoosT7RiSb5WDd5Uv7PJisxpuPUc0oXRT/
 fbDYkFJP2L07s5rnEdoY6OLIdUnB0niwQZu7BMv89ICOY0/7HJxHbxbW93F9JFgqMPA+PKwIfAO
 nnrO2
X-Gm-Gg: ATEYQzya11yIVTlGoaw0yM96ydzi0fFkMDU2aaRaQIxpoLR56L+pvLb/ZkK0X1xSJo6
 DIlupp8RKGNTZ4TRM7+qve/GTKM4MKuaVpRc2Mmf7aRA9l+h2FnZ2ip63ASuW9JMbgIK8ud5n8l
 JIN/pEiFRGz3pne/XkDjsoaPM/ECv2z5lNiLbcsr0r8JEHJ4qLt5DjfLkGEQ+zf/RfscIB2/GRQ
 k+hTqmdjj37fwI2SNX3wPBaNPNTyOoaLENopV+G+tN6YrJaBiqtxUJlLTUgmEHbX/u91LBGoHSg
 53SIK52zYy0FZkJNoHHg+FQOd9dVZEucjh/v2uwHolONBJJTO2PWQaW7CihDo5PMBMr8vum9/xF
 2xi0LBZrQpSo5eTCZEMGFmbtQ4r+goVjsR7H0QDEdPjNbeqOa87Q6U/BoEkkKbAf6AVSRAOy2wn
 VS1RFtXlxAvMEC8iThc9Cn08zTTzNf4SdkSGKPConwugkIXHEaN0ohQfOfVP4b5JfNO/fAun7WW
 C3r4PavLTg=
X-Received: by 2002:a05:600c:4753:b0:485:3fe6:2209 with SMTP id
 5b1f17b1804b1-485566d516dmr200694885e9.11.1773657763809; 
 Mon, 16 Mar 2026 03:42:43 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/17] MAINTAINERS: Remove Cameron Esfahani
Date: Mon, 16 Mar 2026 10:42:22 +0000
Message-ID: <20260316104230.836962-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Cameron Esfahani doesn't wish to be listed in MAINTAINERS any more;
remove his email from the relevant sections.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260306120555.2035421-3-peter.maydell@linaro.org
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e691ac2662..f2ee7988ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -553,7 +553,6 @@ F: target/arm/hvf/
 F: target/arm/hvf-stub.c
 
 X86 HVF CPUs
-M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
@@ -561,7 +560,6 @@ S: Maintained
 F: target/i386/hvf/
 
 HVF
-M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
@@ -607,7 +605,6 @@ S: Supported
 F: target/i386/mshv/
 
 X86 Instruction Emulator
-M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>
 R: Wei Liu <wei.liu@kernel.org>
-- 
2.43.0


