Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB622C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 14:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s93mW-0002DZ-Fy; Mon, 20 May 2024 10:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s93mU-0002DH-VA
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:14:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s93mS-0003MC-Vp
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:14:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41fc5645bb1so17539465e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716214463; x=1716819263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=a9DRv/RF9T6pLBQGRdcb4EE1+9iavHaVTAiqNXEwLK0=;
 b=LYheQFbY1pyxApuVqrWfNQly3bgnVayjc9UiIZFs/gNvUv1r0ryEKo5LXkpG/a7eZa
 tcvW6VrOYxjGl8D64cMyy/bUjdN0nHmeTRLfErbD0gTaXRPVWIoZjoQrApLHOTmNXd8L
 8IwIdrLSK2YULzMzIn8/u4Ei3xgwoB2JY3xxMivp6UBWeudoz9+xhYwjeyOH55ToXpoC
 B+pHpz+GtEBsPyRvbc4jQhf9e3UN86+9EHbik32HR5kgqTTlFk/x9i3CT6OcbVe2kOhl
 202aWjF4S7m+qZYjpNROca4jqNG3MKavhRO4BjxPJjGA1uAynM6nlnUK0OpYYTTQz1Q4
 msnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716214463; x=1716819263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9DRv/RF9T6pLBQGRdcb4EE1+9iavHaVTAiqNXEwLK0=;
 b=hyOnXTjkLM9cvKOn606rWgxIYeDheCe1BmTHYiJWIeDM0ThTbzGeUUB3UPWR8uOISp
 cD/K9soBQy8ixpCANcsq890G0hV81Li3+TljTFjuSMBR604zmlSzRTfxeZSL5G7VUQzs
 oWpx7dqKjHQIVi799D6ewah+8izbLHsgItOEzVHvKx84hEB+NVVrFIjXgOre9JvOej54
 JIVFNHO977m+I5m7e6w2l9XEl6Y4eYgOxHRrC8kVFKduvo0N3+k78ATTkW05W5M4lgDP
 MJ/wg6+JSNqFCkPUfH6Qf6p11Rec0aoZ+PAtmopm8NnGvXrpXKLm+SFIwU3xJl+K3s7B
 6aBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUv5ZRV0aBZKIuCSowI/eYgq8MHTHPBHLKKryaNGeAPgVx8e2FxNsYYmxNpKWVa20CGS2Q/GFh+H4hd7GaM/t2avFbtK0=
X-Gm-Message-State: AOJu0YxDso4H/19JgqZLyyjif6eyIgk8qd6br08Hv07qy1pJYmZPOe2U
 y6+4iB0SxFQ55mL8ORkk15fefoIanClINMfWOwxPJU66dJWJV2q5LGHdYM+ricsXYuuJ2rm9M7E
 Y
X-Google-Smtp-Source: AGHT+IE0OYZlrY8u3FFXOdbj8d0BqEV+i3MbvJnqd7J51iGWFraB5NPX4M4N7R2RUukvtvIo4VtBIA==
X-Received: by 2002:a05:600c:15c2:b0:41b:e0e5:a525 with SMTP id
 5b1f17b1804b1-41feaa44411mr255533515e9.17.1716214463078; 
 Mon, 20 May 2024 07:14:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbedbsm29234107f8f.92.2024.05.20.07.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 07:14:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] docs/system/target-arm: Re-alphabetize board list
Date: Mon, 20 May 2024 15:14:21 +0100
Message-Id: <20240520141421.1895138-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The board list in target-arm.rst is supposed to be in alphabetical
order by the title text of each file (which is not the same as
alphabetical order by filename).  A few items had got out of order;
correct them.

The entry for
"Facebook Yosemite v3.5 Platform and CraterLake Server (fby35)"
remains out-of-order, because this is not its own file
but is currently part of the aspeed.rst file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/target-arm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index c9d7c0dda7e..870d30e3502 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -86,16 +86,16 @@ undocumented; you can get a complete list by running
    arm/bananapi_m2u.rst
    arm/b-l475e-iot01a.rst
    arm/sabrelite
+   arm/highbank
    arm/digic
    arm/cubieboard
    arm/emcraft-sf2
-   arm/highbank
    arm/musicpal
    arm/gumstix
    arm/mainstone
    arm/kzm
-   arm/nrf
    arm/nseries
+   arm/nrf
    arm/nuvoton
    arm/imx25-pdk
    arm/orangepi
@@ -107,8 +107,8 @@ undocumented; you can get a complete list by running
    arm/stellaris
    arm/stm32
    arm/virt
-   arm/xlnx-versal-virt
    arm/xenpvh
+   arm/xlnx-versal-virt
 
 Emulated CPU architecture support
 =================================
-- 
2.34.1


