Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8FAC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7gP-0006Rb-Op; Fri, 01 Mar 2024 13:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gH-0006P7-1N
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:25 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gF-0008Js-Dp
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:24 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5131316693cso3017414e87.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709317941; x=1709922741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nTitmqxEyjzm6yASfKKBHLFThAZ/7NzndfzWD2lD/nQ=;
 b=wUenYAa4cQ23rQFSB3G4TEcB36LEEWCNm+YbJCjeV1E7QKuxUhbYRWHAXZ4MQHuIfD
 NffnZOi/QSOONH3Oq/GFSNMmS1JZiPUt8A2PW3tjRcP4hX80JGWAT06gvBeSRQy7Mf9+
 AWwLiCwEPuk9pUbQjH/Fo1J9Dp/+DyzEDJgq8caT1N/x5Yjis3uCZYenO9OoCACPxc4A
 JQDQHfcas73qeOR10SRoqfp8G2Mt3YwQIlMmsr5CWRSfXdlyMwNOA0ZEfyQuHf1bLkkZ
 7KzPPMXprBQjqzJiTStMCB6m40SuxhuEeedm1erCeK+UxwgUpA1Cxu8DtqbY5j0FaC1F
 UAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709317941; x=1709922741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nTitmqxEyjzm6yASfKKBHLFThAZ/7NzndfzWD2lD/nQ=;
 b=UAVA8vDHQKjdhF/5c4OBVucivnnCBQVLYSHcyaG3ma+PMYVx80bEeGZDnkZAIQ/Lo/
 SEPVB6Sua7zB8WXNFQSR0y7tHla4dtgsZEkZXDwHEtCeHa2a4D6IwkQWlqJNOxsjq4jz
 fNXTbVXuXjmnS96xK6Q5D6DzzJH+O5wB3ysya7Zz+XbUH7Q+R9TYNpiSSGOmHwdLTdMo
 3jnpadYZbTUxRZr7CDvx28T3wbWrP6F/2KjmrSZM7YDDXus1cVUwZdJuutNo0CQXi/ut
 +IyvVg9fAnX5q2a33cmU85CeTOYDIz/YVtkoFP7clGiPbB+urzBOhfZoFO+MutvvCReK
 BcCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXarWzfofESpFZZq7OrHght2hR0AlGdGq+v69IHy+kaz6897CLu4OTOA9CLaiCp/koV59jHZArnBsrqanlOnf6BQKAK3Y0=
X-Gm-Message-State: AOJu0YzgPi98Oysns33Snt/hJLK4tAlvFcGPYslEQIzNmc3ZVUzthHwD
 dY8CSx+NPOYHAwqY/ARj3AAc91yv8bZkQIN41C8tixixD7eozTHv8sTB0XWUS+U=
X-Google-Smtp-Source: AGHT+IEa+VbhJJAauykhIrf/KFZwVNBk3gdB2Rssb7jyghJWqAb6FffrMMv3QTF+BNNEJPTUPTT4rQ==
X-Received: by 2002:a19:5518:0:b0:513:1cf5:bcb0 with SMTP id
 n24-20020a195518000000b005131cf5bcb0mr1968631lfe.27.1709317941155; 
 Fri, 01 Mar 2024 10:32:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u2-20020adfeb42000000b0033b483d1abcsm5158934wrn.53.2024.03.01.10.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:32:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 0/8] target/arm: Implement FEAT_ECV (Enhanced Counter
 Virtualization)
Date: Fri,  1 Mar 2024 18:32:11 +0000
Message-Id: <20240301183219.2424889-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

This patchset implements the Arm FEAT_ECV architectural feature, which provides:
 * some new trap bits for hypervisors to trap accesses to various
   counter and timer registers
 * support for scaling of the event stream for the guest (which we don't
   need to implement because our events are always nops)
 * new registers CNTPCTSS_EL0 and NCTVCTSS_EL0 which are
   "self-sychronizing" views of the CNTPCT_EL0 and CNTVCT_EL0, meaning
   that no barriers are needed around their accesses. For us these
   are just the same as the normal views, because all our sysregs are
   inherently self-sychronizing.
 * a new register CNTPOFF_EL2, which allows the hypervisor to set
   an adjustable offset for what the guest sees in the physical
   timer and counter (similar to the existing CNTVOFF_EL2 for the
   virtual timer and counter)

These patchsets implement support for this and enable them in the 'max' CPU.
At the start of the series there's one patch doing some "move things to a
better header file" and one bugfix for a "no sensible guest should ever
do this" corner case.

I'm hoping we can get these reviewed in time to get them in before
softfreeze.

thanks
-- PMM

Peter Maydell (8):
  target/arm: Move some register related defines to internals.h
  target/arm: Timer _EL02 registers UNDEF for E2H == 0
  target/arm: use FIELD macro for CNTHCTL bit definitions
  target/arm: Don't allow RES0 CNTHCTL_EL2 bits to be written
  target/arm: Implement new FEAT_ECV trap bits
  target/arm: Define CNTPCTSS_EL0 and CNTVCTSS_EL0
  target/arm: Implement FEAT_ECV CNTPOFF_EL2 handling
  target/arm: Enable FEAT_ECV for 'max' CPU

 docs/system/arm/emulation.rst |   1 +
 target/arm/cpu-features.h     |  10 ++
 target/arm/cpu.h              | 129 +----------------------
 target/arm/internals.h        | 143 +++++++++++++++++++++++++
 target/arm/helper.c           | 189 +++++++++++++++++++++++++++++++---
 target/arm/tcg/cpu64.c        |   1 +
 target/arm/trace-events       |   1 +
 7 files changed, 334 insertions(+), 140 deletions(-)

-- 
2.34.1


