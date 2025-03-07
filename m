Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70754C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqeUS-0004MU-Uj; Fri, 07 Mar 2025 15:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tqeUQ-0004KU-QU
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:40:14 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tqeUN-0001tO-4O
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:40:14 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso3540290a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1741380009; x=1741984809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dppJGFKe0O8FEfkLqUZJx0Vx/phQ/obvZ/lkzgf8YXE=;
 b=OodR2xMsmzCUPRieRDPRKUb7fuqm0snDPpxT0mWzr1Zu1rud41ebKMaa7jszr7rdTf
 kDVCvIi1sRbKk7M0XRM1lqPF1fwYSJRKUfdauINUc/HZjIqR7tCP8bb3AS8dpR2iFWgR
 xW7aAfGpSXdkGZUkfbqqw4lfBxwKqA88DtGR50MpvwFwFi60HJI8UrUKMDfvBeQrPcQp
 eutJ9dUtBg2dygFD3lxe+QtWtn/DppVpqtCyUSsQa1+oNHOs/SupwLNanXcNGwC/SW+8
 +eK/nlNOnlvTiGOAtHuypNVIiHVtgErxnj62W+93t8ohsJoMDNuroIQ6Pmuz8yyKZi/1
 k1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741380009; x=1741984809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dppJGFKe0O8FEfkLqUZJx0Vx/phQ/obvZ/lkzgf8YXE=;
 b=JpXNBIENblvTmHqiAvA55oeP6rSCNlFQ8a13BTdMvhLu2XPBY+zhJ7iFfuBFcOTwQu
 ydxLP4Bd9OLSeUzC78w0Xlf+lFPtjguTgK8Jgpi2b0gz8sitLjlJ/NTRLIYoOWapy+g2
 cNlEgnccZbn7H6gRff/WnBI2jMzDph5xZnF2Jblae2eM3JXz8a03IAPsrKiionNQLxOU
 9jDHIRRrHierp/edSUzELxHNnxh1OmxJRrt7A27v0a/AfRAOc1hBrOZ5wpkS2oudrNQi
 R+2ZFLM9xrXnGZAFtsZbb6nfLFxreHaNvlRQGlsJ9oXnMJEPZM8qEMQtjMmtNFuAE8wv
 9VlA==
X-Gm-Message-State: AOJu0YxxZHfQMzaSON/jdt7j9YayytQQ6SOl+B5Gajpso0rDydrmegll
 O90HJZlhXFkp2FTwjxnHHfGC5TjbHnosZP28xlXfcXV2A0qS1WVBLEPep0tt9nsbTm4QVv2MTJb
 IHVmerOMXQXQmAO4RyfPYcCNqqAYArAPN9riCV+WDIaMlEhkbxyxF3U1HbLTfVaDxO+1q2obcV+
 hpV+bvs9+MlVlPRVGZ1q6BIbRbcQOBsvycTB/xPTg=
X-Gm-Gg: ASbGncsSv12ksytJclk/R9QAgBDBmtRTjM+biGMuZr+egBxZ+SkxUhD0PUh3aukh32z
 HjGd0/cXsruGa5ycAsTcHFdKHrtIA/jw67MMcsvuwZ3nLBhHXk492elx12+XHVK4f3sEcOqqhNR
 /a6Rz2UeIpXiKmCouDEGe1Pd5YXrhkH02AKSc96SGm247zHJekc1R/0Kbr5mqvliyCxJIP5X1ye
 A2QXx7nZYzRGAmqbGA+UyJO77I0dLlBJ9bufyIvGi+rvVm0x9auewu6k5IvRW0ZG19xz+N5eOys
 RpANIOcYOvFs2fQ2M8Q9OknwitXVK97noc0VDxVn7UJyR1ZB3m3FZVIfv05Nt8xJ3AX5M8ol
X-Google-Smtp-Source: AGHT+IG1Y4/xz6hk0YT4x0gmAAUF+JK6ZT9SziZSR1qtLRcv8OhlbExiO8LM/5kenrUZGBovoHmx2Q==
X-Received: by 2002:a17:90b:1dce:b0:2ff:62f3:5b19 with SMTP id
 98e67ed59e1d1-2ff7ce6f0bcmr7494655a91.13.1741380008547; 
 Fri, 07 Mar 2025 12:40:08 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff5aa3d3ccsm3270900a91.0.2025.03.07.12.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 12:40:08 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org (open list:MCIMX7D SABRE / i...),
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH 0/4] Integrate IOMMUs with PCI hosts that have ATUs
Date: Sat,  8 Mar 2025 04:39:33 +0800
Message-ID: <20250307203952.13871-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=jason.chien@sifive.com; helo=mail-pj1-x102b.google.com
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

The struct PCIIOMMUOps is designed for use by an IOMMU, but many PCI hosts
also utilize it to implement their ATUs, preventing coexistence with IOMMUs.
Overwriting a PCI host’s PCIIOMMUOps disrupts its translation rules.

This patch series introduces a mechanism to route inbound transactions from
PCI hosts to the IOMMU, enabling proper integration.

The final patch depends on another patch series:
https://lists.nongnu.org/archive/html/qemu-riscv/2025-03/msg00003.html

Jason Chien (4):
  include/hw/pci: Introduce a callback to set the downstream mr of PCI
    hosts
  hw/pci: Introduce an API to set PCI host downstream mr for IOMMU
    integration
  hw/pci-host/designware: Implement PCIIOMMUOps.set_downstream_mr()
  hw/riscv/riscv-iommu: Connect the IOMMU with PCI hosts that have ATUs

 hw/pci-host/designware.c         | 18 +++++++++++++++---
 hw/pci/pci.c                     |  8 ++++++++
 hw/riscv/riscv-iommu.c           | 15 ++++++++++-----
 include/hw/pci-host/designware.h |  2 ++
 include/hw/pci/pci.h             | 21 +++++++++++++++++++++
 5 files changed, 56 insertions(+), 8 deletions(-)

-- 
2.43.2


