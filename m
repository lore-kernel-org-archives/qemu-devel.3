Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AB8C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6us-0007aw-Ns; Wed, 15 Jan 2025 12:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6ur-0007Z7-8L
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:53 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6up-0006b4-F3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:52 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso43712f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961049; x=1737565849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVvcy2oYMKXeEI9v0ixIQcy6UbZyWQJwljg2mj08G8I=;
 b=wJlkU7EoKSw6oXWJLUL8URn2/z7ZAGuIVOHM5wLkXHB6mUjkqx4J7gPJNotp+WkfEG
 J0k+peY2ZSJ//MqSwd2pKWsWpzyW62mGUvnsxKNBDKNMLmsUnek9OW1dPTHq2K5356xh
 NqVQZUXCO2LydB1EwrFUBYJ4S7wlolncRcdYLjExebcnqhc1UM4nBbaPZS6JfXdTRLlQ
 Br1P1RYEoqRBl6Hu40BjCq7YiaFXIcMASasT38/6A67CUtcTfYaZIWAi6WoQ/bbIbVqr
 Xl754iYKEWbqmQznSplbtwRPXryQg90sJYWLZWp+Y9gYcf2SXPzAQh1Hkk15ijq8BlpL
 3CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961049; x=1737565849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVvcy2oYMKXeEI9v0ixIQcy6UbZyWQJwljg2mj08G8I=;
 b=Wral/XmkhOyJ4x10zZeOiIJQgqhHldlTnh3KipWvPQ6e3Z8xhfI0jC6UIi5+RfSK6K
 wZvVeu5/7ah9DMhHwBnnFfJEbA3U4TAtJ+CmDIxkF7yDL8ND5vlA93ex6nhCWJJGyC+v
 z4Az0KECKas14ADeHq4PK3D98qECpRTccPAk39E4tjnzhyJ6OkmfZqylJI0QoewJ2dwg
 xf3t2vrcLnQsvR/LWouE97w4n8/imn5SWMcpl4FCVLXEDqEHPu7U8xE/kFUz9igdYwl6
 m7m08pF6bIUHugqzGzSnutsTtWxZN60CnJnesXP0MKVefvdM5Ja9QcsGEKM+iHkGp+y6
 b2mg==
X-Gm-Message-State: AOJu0Yx+qTWEzDv0PIbJ06f4OnERWTYm7CvXZWE0SwTbjLM99iF4+U3H
 fQfn3/RH80wSvzdRFd9sR9T7Fpo69LO3WXPJOUgWAmhBym0B+SRmhBOFBC758pS3FD1VKZrwoiL
 Zpzo=
X-Gm-Gg: ASbGncvbUcA2w5c74w5vFi79ZGnng8l+OMbLzv5Vi+hyGXw3mq/GWFxqDGLkuzeBubN
 yexShLrfRfvirU42UfyKfWqd2b6/HuAoak/xizx2jOLnmjvShvXiSugsj285v9plXqBlbpJG2X0
 CD8LTRxWiSLUshPznSmUOenTR1+yBy4W/8mX4U17R2EUXW/D2hbrA3i6e5djcCNt3zhcHmvAnqy
 woambDxTD2Ozwv3X3BNrgicp8aFheTVTO8w+EuDZf67VGA3EuFbzDeGRI2G7C/BPen3LEr5zZn2
 1jl3B51gGGMmtjmP82SO6OWGuvsdT7Qo8mvk
X-Google-Smtp-Source: AGHT+IHI/aH1G3fBpzbOw6V3u4FJLC/zhX9XpPVyil0Nq1c9XpBjuRrEMMD+9jGCWMnrc8u2w9QsxQ==
X-Received: by 2002:a05:6000:18a4:b0:38a:9fdb:7307 with SMTP id
 ffacd0b85a97d-38a9fdb750amr16887449f8f.43.1736961049233; 
 Wed, 15 Jan 2025 09:10:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3838a3sm18241435f8f.33.2025.01.15.09.10.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:10:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/13] hw/arm/virt: Remove deprecated virt-2.9 machine
Date: Wed, 15 Jan 2025 18:10:04 +0100
Message-ID: <20250115171009.19302-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst | 2 +-
 hw/arm/virt.c                   | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 732ec2cd05d..dbd04b00e4d 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1065,7 +1065,7 @@ for all machine types using the PXA2xx and OMAP2 SoCs. We are also
 dropping the ``cheetah`` OMAP1 board, because we don't have any
 test images for it and don't know of anybody who does.
 
-Arm ``virt-2.6`` up to ``virt-2.8`` (removed in 10.0)
+Arm ``virt-2.6`` up to ``virt-2.9`` (removed in 10.0)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''
 These versioned machines have been supported for a period of more than 6 years.
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ec47ee4755a..6ba75a91574 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3544,10 +3544,3 @@ static void virt_machine_2_10_options(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 DEFINE_VIRT_MACHINE(2, 10)
-
-static void virt_machine_2_9_options(MachineClass *mc)
-{
-    virt_machine_2_10_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
-}
-DEFINE_VIRT_MACHINE(2, 9)
-- 
2.47.1


