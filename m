Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6000CC4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6C8-0005VC-Pq; Tue, 21 Jul 2026 04:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6C1-0005TR-IW
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6By-0005iu-Ri
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so23961215e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623869; x=1785228669; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hbE+1TFJ2PollExrCKISYsmaeN1UnHb+b/ard1c1p80=;
 b=WszsefPiXEOJaNxHP7MVtzpa9XziW6XcH3EVv0V7TqJcNwfDFJk8eDf56Dh0KPUFSX
 SCQN8Xb/wJsZdzzskE20Z6Qh3r9TDJ/c8V2sXAYXxg+Mlc0+JiG7oJjxBergpQIw1cSz
 PwbptvPffcwmAwHgsTjmup0Vwoxc6oy0xntTI3cDCQbfkn6Nkiyi0jPtohg7Hfo23N/n
 eRTUPC09Gj7ZU+P4EmG4Gf8qf9rQknr1vj8xf84SFiBm4ZK1zS6XKxXR3o/i46cg4W/T
 QoJlZmiLb9l2qTvB6YoXl9b4+cac3sc+8XmWNGVj5U9QVzFLByA54uNn69V6tOVasbL6
 30tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623869; x=1785228669;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hbE+1TFJ2PollExrCKISYsmaeN1UnHb+b/ard1c1p80=;
 b=Hgx58lqJCNLOGiHb/P7hHEa+DESUagWqT2SKkD3d/CMH3MF7AF7vfPnl+FDsFv/q2d
 jTFwqes5e7RBGBDb1o88B9gRmbxvKtwS/7RJlo7bLSZ7QV66wwJamEKoWnvC1tXCFIzL
 gtYiz3ItNxXMQ8lLSSyNQZpvXnMGJuA4Spgkdr8AW/gZ0IFnOxMfHRpsXV87iLWhj5s9
 IMmbNO46SDSPAO13LPfgRk6e7weSN1H4mY2iX7Nx2LEuXuHXc2Jh2GO3MTFrYrGeMJ3Y
 etxDu6yPbKBiVn73w67J+S6Kv2h53qBmTdYrZL1k8/Ix1sslc9T4etRA5g279INYKd+G
 golw==
X-Gm-Message-State: AOJu0Yy3ImqW8XazL57onS1iDTK9LXISIZxnWyQ2No7i1It7ASeaKFbu
 MjdyJmTci8zxIpfrPxiuw8i8rO94bArYe0dhcLOJVgPCoIksA/CpDNWlCqDWc7aqaGdhvUSksFZ
 tCdeVwc14sw==
X-Gm-Gg: AfdE7ckPo1e5Fi8i26v9Uf2evfn6euvqMq0U7QFZdw0NSbybGnSpMyS64goVc+AL5BF
 40tgNAT7dB25pdnxZlZ0wRRBWcc21P9J7Z2YUCaHvoVlmHStWhm9p2W/w6GiJ6j/hqYRSnjojQX
 TGsQj8qI9hdcdNnXtFJnKolj6P87/V0pai1tiy6BLyHXla6d/ahUx0JBlpV24uHDLW11aanxhXN
 0WkoH2KPVeab2gyKpqAabtL8cr0YXUXNRHCXfwaowzCBKUAqxGHrmhL7GZfOYuIvG+kcx2asSO8
 Eyph++3AXNqtgawD9ONwhUySmPh/D8lF/OJ7/epGMOc2vlSCDHmPZq4e5rDUqnfpMOroXtJwIQF
 C3aSZiAtNnMQoegA46kB0270W3zZqlQLARtY9Rt9AKFhYBtreweiIBGbnEdedmVSwoQROaTSZ6i
 1dg2wVXk7F7ju3zU/WCG+2DiF7uyr/faI3VfgmMWd4WmDRHdntSfX+obrz6Kwgcii9Iqg1Om0Xz
 4aAPpE+lsU=
X-Received: by 2002:a05:600c:3b8c:b0:495:5039:391c with SMTP id
 5b1f17b1804b1-495503939b1mr165187515e9.26.1784623869221; 
 Tue, 21 Jul 2026 01:51:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.51.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:51:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] MAINTAINERS: Add soc_dma to OMAP section
Date: Tue, 21 Jul 2026 09:50:49 +0100
Message-ID: <20260721085050.421257-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The hw/dma/soc_dma.c code appears to have been written with the idea
that it abstracts out DMA transfer operations from the details of a
particular DMA controller device.  In practice, it's used only by the
omap_dma code and I would not today recommend trying to use it in any
new DMA device.  Add the files to the OMAP section of MAINTAINERS so
that patches can be cc'd to the appropriate places.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260710105907.2570621-10-peter.maydell@linaro.org
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74fc43f5f20..a28935c8986 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2205,7 +2205,9 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/omap*
+F: hw/dma/soc_dma.c
 F: include/hw/arm/omap.h
+F: include/hw/dma/soc_dma.h
 F: docs/system/arm/sx1.rst
 F: tests/functional/arm/test_sx1.py
 
-- 
2.43.0


