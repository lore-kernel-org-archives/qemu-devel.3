Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09B606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p8vnysjr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWGxr-00062s-PB; Wed, 25 Nov 2026 12:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xWGxh-00060S-Nz
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:39:17 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xWGxf-0007XD-MJ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:39:17 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c513a854320so128343766b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795628354; x=1796233154; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C4inDwYSdZ6rSu6NlBqf+MwdZX9DKjxbN5xxNIe/N2k=;
 b=p8vnysjr0hOoz7CEwFDxFd33dOrpO+ASeqLlNJqKQWuPDTw9bcvn/DxBr8tpyClSmk
 dzmRGUdnb/aDBViQFJAS+72fW+ooXBF1tX+uelNFzeLnNqe1XS0qbiQKYyIbMprsajrT
 zIYpfPbXuw1nZHHIKKD6MtJ8lgNDg9fKeF385DLSUhzFzyhJipgakaY67xREtVQkj70X
 0AV079YfH3SRdfY9QUiIgchfqjGYGEM2B1eDYk0dyk8kgRbI11KYAmNt78IroY3kwgjP
 +k4p2ebZNbGOLH7FO85HRcbiK8uq0n+dO6d8pI+po+dQ7YtP7tVWgDg/xfcaTUfMXj4n
 tDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795628354; x=1796233154;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C4inDwYSdZ6rSu6NlBqf+MwdZX9DKjxbN5xxNIe/N2k=;
 b=i84o6Q4UtIuHahAQqE+S1FEB4XIIDwrWXlY3EOhiACWFW2QzRK+HMVSRmq8IQP92q3
 UYwnaWldtWiCdUR6cpZgBhf4j2tkd6yF74Q5tiaXBGywJSup7kwCacZGv5RmFUteG7zO
 VKD9RI/NhjnAealQ4XtnFjLQA6STcgNRRFcEw/pAYn45OerDXivMUaar2QHU1ICdJG2p
 Vwei6r2p3BrXtKExzu7A/ihu2J8jk8BvTLp0Fx7IMzZEOJXjKIckZDROyTTvnWD/psJ/
 DHnKzCQdERWP5l20aJR/gqmsiKmxQpP+Ujh2bYi7cCWDyi4OJtvpJNLhd3HOQd17MVDw
 3nhA==
X-Gm-Message-State: APuU4Z8zGM53np5jjhuP5WyrERw3ZL8TFlbhfx1bi+8/vfS2ERRBZtCe
 ycOWBbr1ogv7Gqv+8MoPFIKVkBmhxHzv72r6M2f1u6pTCOAjf2fGACqBZLbFnKdtrP8=
X-Gm-Gg: AZFdTZdoJQ72txvzaIvX/z5oIAE85W0JXZA25bVYASU048p1Z3ZtPowvybciJvEn5m2
 ouVLa+7v1Yxh7uHn3SOab0XiJ4XzOTgquYph4EaRI7diXpR6rWMDZLscG0IvkT40H6djWb/7S9T
 E2OgpgN9DUDvNpWpC2kgoexmlL301DgCwT4ucF3/81CN4DEhxeD+1B8CIZyeiG/6Gzv75/pF+4f
 cPU4S4fdu40+efAfq3dExf5yoIKm338dYJ6HWSSKYkTVnR7R6+Jujd6ea+bhxIpt93X33SWeJa3
 BDQUzkfIGJhbDIS/EDkvkkfNceK3zQtblsggFARfASscuq1ol66Hxu+wh8x+Z8my126Vn24nYqp
 iXo+o5m256YBpKT2FlMi0gDGkZbRymmhioGVgsWS8mQkC69REqfFmUU/dWMFGMkuwIGAytPu1C5
 eGVMI0LgdlKd5W7v8AWHsfrO1w2nZCBNIPoO7TMXfs3vzquaZ7Fc00YHNA7pXRUvjuCPA3w0iKB
 yawhHN+qrEE8HyCprDS4yGpG8pGNekUAbNJ0NA6omu0jKcvi/rRYEmXyyYZfuOdAC1LpEleYfQ7
 nxQ5pVbRsFnULtt/eOj8zEPbTgW/lTVP
X-Received: by 2002:a17:907:a890:b0:c4c:b4fe:ca01 with SMTP id
 a640c23a62f3a-c513aad51b7mr1657996266b.37.1795628353872; 
 Wed, 25 Nov 2026 09:39:13 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:82ba:bf15:3b4:e45b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513acfeda1sm709675566b.6.2026.11.25.09.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 09:39:13 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v2 0/2] Add SMMUv3 Root registers
Date: Wed, 25 Nov 2026 17:39:08 +0000
Message-Id: <20261125-jmac-smmu-root-registers-v2-0-9ce0f6aa5097@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADwdB2sC/3WNyw6CMBBFf4XM2jG0PHXlfxgWpQxQIq2ZAtEQ/
 t2CcenyJPees4InNuThGq3AtBhvnA0gTxHoXtmO0DSBQcYyF7HIcBiVRj+OM7JzEzJ1xk/EHhu
 dtoKkypM6g3B/MrXmdajv1Zf9XA+kp923L/rwdPw+2ovYd79M/j+zCIyRipLKsrg0SVrcHsYqd
 mfHHVTbtn0Aio9mcNMAAAA=
X-Change-ID: 20261015-jmac-smmu-root-registers-dc4f1e2a63b5
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Gustavo Romero <gromero@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x629.google.com
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

This is preparatory work for further SMMUv3.3 features including RME-DA.
We are adding in patches originally authored by Pierrick Bouvier 
<pierrick.bouvier@linaro.org> and Gustavo Romero <gustavo.romero@linaro.org>
in a way that will avoid conflicts with Tao Tang's current SMMUv3 Secure
state patches. Since Root registers do not use the banking system, this
should only conflict around the offset check near smmu_write_mmio and
smmu_read_mmio.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Changes in v2:
- More named constants for SMMUv3 register layout.
- x-root flag for Root registers; off by default, forced on for sbsa-ref
  machine.
  This controls the allocation of the extra 64KB page for Root registers.
  (Thanks to gromero@redhat.com for the example code)
- Root registers are cleared on SMMU reset.
- smmu_read_mmio_root renamed to smmu_read_root, similar for write.
- A couple of other typos raised by the review of V1.
- Link to v1: https://lore.kernel.org/qemu-devel/20261016-jmac-smmu-root-registers-v1-0-e78e8879d347@linaro.org

---
Jim MacArthur (1):
      hw/arm/sbsa-ref.c: Increase SMMU space for Root registers

Pierrick Bouvier (1):
      hw/arm/smmuv3: define Root registers and x-root flag

 hw/arm/sbsa-ref.c              |   3 +-
 hw/arm/smmuv3.c                | 241 ++++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/smmuv3-common.h |  30 +++++
 include/hw/arm/smmuv3.h        |  14 +++
 4 files changed, 286 insertions(+), 2 deletions(-)
---
base-commit: 6bf90d4fc5027567cb704d7888f5ec792b4ed75a
change-id: 20261015-jmac-smmu-root-registers-dc4f1e2a63b5

Best regards,
--  
Jim MacArthur <jim.macarthur@linaro.org>


