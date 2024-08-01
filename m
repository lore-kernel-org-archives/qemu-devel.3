Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4E0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWiH-0004fH-98; Thu, 01 Aug 2024 10:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZWiF-0004eE-Uv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:23:27 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZWiE-0002do-9y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:23:27 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ef2d7d8854so83625681fa.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722522204; x=1723127004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=myunw28flnSS/WmHYmFUyo5zN+xij5Yj/F4mI2ONk5U=;
 b=d7Mj1H2+CEDEFok3JBzk92PJ6WUNb+xq75qRo+pGdn2B7LilmPCGK3esKn/PHUBYAg
 LB4L6s0xJgF+9s6EfMP8CN1PeEAeI4JY2R05SyggSS/WcZCJZOVGR/fEu7XfSNrmo6Fq
 7ixjLp8ba2oMq0lmX96I+sF19VZeGTo9VAVR8P4Xel7CkQmiS8S+23EMW/yRoTWmmXNi
 70VSuQtkyzK9fjQ+/AiIFBTQlDaHlzFjmTzmbiw304lVXVaTTe5wKVe5KUJQFd1T7vbd
 6xcrampM1U/HdWNbSAQt/7KlNzLg5YWf+GxfVHn25hF214MgyUQ0vVDsJWutFrMiKyjj
 U5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522204; x=1723127004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=myunw28flnSS/WmHYmFUyo5zN+xij5Yj/F4mI2ONk5U=;
 b=hJ5pWxIz59WOVvoxTF8jiCS4dTrMCnnvRAvbC4cdJ1gHAc9YwPhoyqHp2qw586o6j7
 TF9tvs8bj0Zg2hp2wscgVTzopnl2mJJGuBLRKlMovGBFCRecFkER6QuykUWJYCkSFcvb
 U0YiEMKlAxR5tImhICC72f8vvJ7TcbUwwHboeO0YQP0r0obIrP+kNliVVXEO9qITKV/k
 RiySli4wKPWyocoPPlbDFxtXlJhS9PhkqQntMASGZwtmP6/OZPFJLM0R0v9oc2fGqL8S
 M0w0inPZeqiREnRRqdqo/IEDC4nH2b0lLrem+6/TnVtSCOqwODWeLxPxNnZ5X4RlR/0+
 wG9Q==
X-Gm-Message-State: AOJu0Yw9xUfrBRIlgR+uPyixpcV3pV4JQHoOuFvo1Xt1jOkoVKXaKyXs
 LuXO2gxN1Arcop4Goa2Wimt0B+S3xjYmbB1j3INwyLTqjQh4pnWX3/HHAp0YLvLIn2JGYtQ9Yd/
 4
X-Google-Smtp-Source: AGHT+IG/I2WfGiXvyjjHOE2cwFiNeGcgsrHQyJXAim5jVOqZzXaApGj+ZPZU1mCbFbGSy9hszV4zEw==
X-Received: by 2002:a2e:87ce:0:b0:2ef:2855:533f with SMTP id
 38308e7fff4ca-2f15aa8744dmr3586831fa.16.1722522204179; 
 Thu, 01 Aug 2024 07:23:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e08012d7sm29657435e9.22.2024.08.01.07.23.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:23:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] target-arm queue
Date: Thu,  1 Aug 2024 15:23:18 +0100
Message-Id: <20240801142322.3948866-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

Just 4 bug fixes here...

thanks
-- PMM

The following changes since commit e9d2db818ff934afb366aea566d0b33acf7bced1:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-08-01 07:31:49 +1000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240801

for you to fetch changes up to 5e8e4f098d872818aa9a138a171200068b81c8d1:

  target/xtensa: Correct assert condition in handle_interrupt() (2024-08-01 10:59:01 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/mps2-tz.c: fix RX/TX interrupts order
 * accel/kvm/kvm-all: Fixes the missing break in vCPU unpark logic
 * target/arm: Handle denormals correctly for FMOPA (widening)
 * target/xtensa: Correct assert condition in handle_interrupt()

----------------------------------------------------------------
Marco Palumbi (1):
      hw/arm/mps2-tz.c: fix RX/TX interrupts order

Peter Maydell (2):
      target/arm: Handle denormals correctly for FMOPA (widening)
      target/xtensa: Correct assert condition in handle_interrupt()

Salil Mehta (1):
      accel/kvm/kvm-all: Fixes the missing break in vCPU unpark logic

 target/arm/tcg/helper-sme.h    |  2 +-
 accel/kvm/kvm-all.c            |  1 +
 hw/arm/mps2-tz.c               |  6 +++---
 target/arm/tcg/sme_helper.c    | 39 +++++++++++++++++++++++++++------------
 target/arm/tcg/translate-sme.c | 25 +++++++++++++++++++++++--
 target/xtensa/exc_helper.c     |  2 +-
 6 files changed, 56 insertions(+), 19 deletions(-)

