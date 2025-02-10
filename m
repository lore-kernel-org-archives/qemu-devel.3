Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB4BC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW2h-0007DN-0U; Mon, 10 Feb 2025 10:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2e-0007CB-G7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:48 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2c-0004gS-JU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:48 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so30020185e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202585; x=1739807385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=eIhwxGSJo+fnEjb9uUzGNFjWk9qjiJXDurLhZkghUFo=;
 b=nwuMHul2+dOKpL4ZyQinWn2YmaI0ooJLqG8CdDa+LqtOZ1IdSo6MeDtFrG15kfcKVG
 6OdUbygwd868WviWgHeZ2qRLL5Jgs8ReVag8dprsbACe0UpZCL51KERmn+brxetL0Z52
 36xA48vg5yIEqx63ZmyBGn7Z03Pe6drFTM/cNgxoWh3gV4aSinS6VPZi/Vf3ilBPQumN
 0xa1l3mHMILDYKOvikJn7BiluwOxY40q3Pi2POFGbKm0U/HOoILqqjaNVKc/GxqrUFVb
 q3N5H5BqQj3yj68hcWtg0fu4J+ZWzHjxlwAd8/OPsqV5706G5PuGzGIGtx0jf7nMfAD+
 YNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202585; x=1739807385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eIhwxGSJo+fnEjb9uUzGNFjWk9qjiJXDurLhZkghUFo=;
 b=NSZpbOhyrYMuZiAXug0fx4jam4ad0x/Wm6uXB5GXiupwOUV/9YhFEhaZ2ik2nYwqN/
 TjQx0Bl/tPCwkv2YDfnwWY+UdjjQLhecWXBE6CJfGBOBv0niCCy4KOa4gp8Mr+ThbX0k
 h2StDOgW4QCLUjRKoVcOJJQhGK6R78jO4fvMxlG7ip6MnjU9g75mZS0rZjBzz32AUXqx
 NCb4jSVpk5v/mUZkYZnF4AbzOxD9Sak9FKyMBLL7YZdOhSaDDwHzV5RJtI0NMzZ3tptr
 u6s0kTS4QqkwPETbF7wpz7zoxIftvj4JEmB3/fU1qNxeKk7Ajxe9Kc9FVO5idHR8ilcw
 VLnw==
X-Gm-Message-State: AOJu0YysvosBHd+E6WFbq3+sYqOzivnupgoE536YIopk030neUO5oABc
 W7KZwuSd+k2/53uUd0bKaQ55E8sDf4KyD3SUuQkclFV6SpFfViPviJ5UDhIjsQRLVm5n1h8UP8S
 5
X-Gm-Gg: ASbGncueJg7/IbVdPviFxrfXe1f6gMC3mHx7kVnBtdaR7vy8flt9W4CYGdh0wKTs323
 kLWOACBv9XVu/yopwA11VJFWkTTWaWjdLojwBrDmkN5k+iPYF7PMxrHfVLe98M6LjPFjOm+yMif
 1Ys0lc1wrR5NYgqwRf6SQUpEIX/uuPJZv8bm/ZtF2xDaRcgxuyMFt/4f23hCJ6uSSZ/SUZDmQpB
 fcqpmLVVcdce51/uHo3q/6fgE397CucekL16Ow13dqb5qbrFaIhC0leATeMXTZjfnnMkt4IJPnU
 LDhMu2sSnG+Ye16Y4Q9M
X-Google-Smtp-Source: AGHT+IG+RzJDLON9+FEECOVGkV4LpGmnJFCd8thcxYg7Tr6ntQJ/yQQn1KkbEeFymFaJvDi99Xmtvg==
X-Received: by 2002:a05:600c:4f50:b0:438:a240:c54 with SMTP id
 5b1f17b1804b1-43924987962mr103243025e9.9.1739202584712; 
 Mon, 10 Feb 2025 07:49:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] target-arm queue
Date: Mon, 10 Feb 2025 15:49:30 +0000
Message-Id: <20250210154942.3634878-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The following changes since commit 131c58469f6fb68c89b38fee6aba8bbb20c7f4bf:

  rust: add --rust-target option for bindgen (2025-02-06 13:51:46 -0500)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250210

for you to fetch changes up to 27a8d899c7a100fd5aa040a8b993bb257687c393:

  linux-user: Do not define struct sched_attr if libc headers do (2025-02-07 16:09:20 +0000)

----------------------------------------------------------------
target-arm queue:
 * Deprecate pxa2xx CPUs, iwMMXt emulation, -old-param option
 * Drop unused AArch64DecodeTable typedefs
 * Minor code cleanups
 * hw/net/cadence_gem:  Fix the mask/compare/disable-mask logic
 * linux-user: Do not define struct sched_attr if libc headers do

----------------------------------------------------------------
Andrew Yuan (1):
      hw/net/cadence_gem:  Fix the mask/compare/disable-mask logic

Khem Raj (1):
      linux-user: Do not define struct sched_attr if libc headers do

Peter Maydell (4):
      target/arm: deprecate the pxa2xx CPUs and iwMMXt emulation
      tests/tcg/arm: Remove test-arm-iwmmxt test
      target/arm: Drop unused AArch64DecodeTable typedefs
      qemu-options: Deprecate -old-param command line option

Philippe Mathieu-Daudé (6):
      hw/arm/boot: Propagate vCPU to arm_load_dtb()
      hw/arm/fsl-imx6: Add local 'mpcore/gic' variables
      hw/arm/fsl-imx6ul: Add local 'mpcore/gic' variables
      hw/arm/fsl-imx7: Add local 'mpcore/gic' variables
      hw/cpu/arm: Alias 'num-cpu' property on TYPE_REALVIEW_MPCORE
      hw/cpu/arm: Declare CPU QOM types using DEFINE_TYPES() macro

 docs/about/deprecated.rst       | 34 ++++++++++++++++++++++
 include/hw/arm/boot.h           |  4 ++-
 target/arm/cpu.h                |  1 +
 hw/arm/boot.c                   | 11 +++----
 hw/arm/fsl-imx6.c               | 52 ++++++++++++++-------------------
 hw/arm/fsl-imx6ul.c             | 64 +++++++++++++++++------------------------
 hw/arm/fsl-imx7.c               | 52 +++++++++++++++------------------
 hw/arm/virt.c                   |  2 +-
 hw/cpu/a15mpcore.c              | 21 ++++++--------
 hw/cpu/a9mpcore.c               | 21 ++++++--------
 hw/cpu/arm11mpcore.c            | 21 ++++++--------
 hw/cpu/realview_mpcore.c        | 29 +++++++------------
 hw/net/cadence_gem.c            | 26 +++++++++++++----
 linux-user/syscall.c            |  4 ++-
 system/vl.c                     |  1 +
 target/arm/cpu.c                |  3 ++
 target/arm/tcg/cpu32.c          | 36 +++++++++++++++--------
 target/arm/tcg/translate-a64.c  | 11 -------
 tests/tcg/arm/Makefile.target   |  7 -----
 tests/tcg/arm/README            |  5 ----
 tests/tcg/arm/test-arm-iwmmxt.S | 49 -------------------------------
 21 files changed, 205 insertions(+), 249 deletions(-)
 delete mode 100644 tests/tcg/arm/test-arm-iwmmxt.S

