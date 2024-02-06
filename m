Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8A7C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLWD-0000gt-JX; Tue, 06 Feb 2024 08:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW6-0000OQ-Do
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:38 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW4-0008Ck-DB
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:38 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40ff28388a6so1647565e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707226172; x=1707830972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fNE7QdrRujfmA6rkr1e587aBe1A8RQAGklHXsRx7cDA=;
 b=YBhmf+9ri3IwtOIFNqY6s6IQYth1pOSdu9Z30PjvQaI42ZQmSnfd5oDdzhD/RmKfty
 rCZwYcsLdSY57j0bTqMewXuXqc+iBi44UScZPjpg1UKUvZai6wLd18HA+oVek2yThQXY
 BDhu9x1/QZ0w4XoG/1W7OpdSxjvDU/D5A11l5vVV2f/4C8yZb367FMgQuC5IiifCgGMd
 KeL+R8VjSKHrYMl5udVhZRxsggIg3n4EDKndl2ANLCYQUQ8c7/Hq4wgMCRaYNHoEtqSS
 wMa2DG3k4LIkJB+72+xi0rcYfItbVnZ5TnmzzdQSXxVzAJk+uGlhJQnw06hcw1kOPh5D
 JjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707226172; x=1707830972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fNE7QdrRujfmA6rkr1e587aBe1A8RQAGklHXsRx7cDA=;
 b=qWbh2uBcRNL67DcOgd32I1+Gkwwhkr9HU4RfA0OiZrWJA8Bb+jndVNMGlwc8hA9zcv
 ltg3Ih/w5CVN2DsN+f7f0mjCdvnA7WnviUQxBNyQBWsqpeNB+rkIP7Bt+ye924KELk22
 QiniuqD8tQXR+8jAc3qbSh3Wxa44e3ZzoK7Bw0n6Ejd08aoPO20tIV386zEZUtgioiZO
 dJ953a9k0BrBBYq/0fbddQSNE6k6Lpfr9SHXcYlsJCBSPP9ztWN1HPVCd3dARuYdHL8c
 j19nN05yU6/mh9sJvvGWiRQsMntYK3PFqQyxRcKPxkyghlsH5QFqrsoNs4pCKOmypo5n
 wXHA==
X-Gm-Message-State: AOJu0Yx2gkV6WjYRnvY24XUaqc+dL1pnI1WIqPA24esKpsi+9Cbwxwma
 s8Yo+6hJaUBi5+t61CO7ZcmAINjJNC01Lh/rvWLbc2ylvvvqC8ZFmr1xJ+bnBghCxQhjYCYl8/R
 D
X-Google-Smtp-Source: AGHT+IFPBnH33j5+zMuv64i4PVbejkXACDKaSEWUpqILXxdvwINingI2emHnGHL0N7f/O2HZ5W9xXg==
X-Received: by 2002:adf:f182:0:b0:33b:247c:d61a with SMTP id
 h2-20020adff182000000b0033b247cd61amr1469999wro.31.1707226172631; 
 Tue, 06 Feb 2024 05:29:32 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXkSzNCI/rGQCxZV82kKiAKiun6DbeFLEygQHxJDnbVDkkSzkBzuJvH+BT/AGKClLHxqR9udBSYcJIOvC+R2hC0amBBpUI=
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a056000108700b0033b470a137esm1492932wrw.79.2024.02.06.05.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:29:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/13] hw/arm: Implement new machine mps3-an536 (Cortex-R52
 MPS3 AN536 FPGA image)
Date: Tue,  6 Feb 2024 13:29:18 +0000
Message-Id: <20240206132931.38376-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This patchset implements a new machine type, mps3-an536.  This is
similar to our existing mps2-* and mps3-* machine types in that it is
a model of an FPGA image for the Arm MPS3 development board.  It
differs from our current machine types in being based around an
R-profile CPU, the Cortex-R52, rather than an M-profile CPU.

This patchset implements the board support to a similar level as that
of our M-profile MPS machine types: most but not all devices are
supported.  Some minor missing features are documented in the docs
patch (and already in mps2.rst where they apply to all boards in this
family).  If there's demand (specifically from the Xen development
use case which is motivating this board model) we can look at adding
them.

I have tested with the "selftest" binary supplied with the FPGA
image, and also with a Linux kernel. (The kernel support for this
board is not upstream, but the patches can be found in this lakml thread
https://lore.kernel.org/all/20220630083641.21835-1-vladimir.murzin@arm.com/
or at the git branch
https://gitlab.arm.com/linux-arm/linux-vm/-/tree/staging/rclass-5.19 )
To get some of this guest code to boot I had to make some improvements
to our Cortex-R52 emulation; these are in the first four patches.

thanks
-- PMM

Peter Maydell (13):
  target/arm: Use new CBAR encoding for all v8 CPUs, not all aarch64
    CPUs
  target/arm: The Cortex-R52 has a read-only CBAR
  target/arm: Add Cortex-R52 IMPDEF sysregs
  target/arm: Allow access to SPSR_hyp from hyp mode
  hw/misc/mps2-scc: Fix condition for CFG3 register
  hw/misc/mps2-scc: Factor out which-board conditionals
  hw/misc/mps2-scc: Make changes needed for AN536 FPGA image
  hw/arm/mps3r: Initial skeleton for mps3-an536 board
  hw/arm/mps3r: Add CPUs, GIC, and per-CPU RAM
  hw/arm/mps3r: Add UARTs
  hw/arm/mps3r: Add GPIO, watchdog, dual-timer, I2C devices
  hw/arm/mps3r: Add remaining devices
  docs: Add documentation for the mps3-an536 board

 MAINTAINERS                             |   3 +-
 docs/system/arm/mps2.rst                |  37 +-
 configs/devices/arm-softmmu/default.mak |   1 +
 include/hw/misc/mps2-scc.h              |   1 +
 hw/arm/mps3r.c                          | 640 ++++++++++++++++++++++++
 hw/misc/mps2-scc.c                      | 138 ++++-
 target/arm/helper.c                     |   2 +-
 target/arm/tcg/cpu32.c                  | 109 ++++
 target/arm/tcg/op_helper.c              |  43 +-
 target/arm/tcg/translate.c              |  19 +-
 hw/arm/Kconfig                          |   5 +
 hw/arm/meson.build                      |   1 +
 12 files changed, 955 insertions(+), 44 deletions(-)
 create mode 100644 hw/arm/mps3r.c

-- 
2.34.1


