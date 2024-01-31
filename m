Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EAFC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 08:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6JJ-0001qx-QF; Wed, 31 Jan 2024 03:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JI-0001qa-1C
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:08 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JE-0007oF-36
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:07 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40fb63c40c0so529035e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 00:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706691061; x=1707295861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RPEqoZsCMdC/Yd1ZOBxYPSQmuFl5Y3avH1pmkIvBDOw=;
 b=dMld/mQ1CVdY3FWu4gAsz85udzlXU8LS+ipJaQyzprqFAkXfHjiQ+vjbzZzvC5YXgo
 9q9AG0ikjn4aYVoynqjIRXxOpY6D4V9avcT6jF+KPomT8q7VXyfwW3nlQkOO4stcw9xv
 /t6TpeLYPnfgQhvZr3G9N/OS9XKg6OOGKYH6oLTvGo5eIKH1IynfqNWxYq/g1MS6IYvn
 MHvWkba87T7tvMKFvruJzJeYW+8TUUyM/Bpx+1NTGokVpjQNu9qZzCbHeTMCJvnCXKWp
 3J2KbeLxfFKEIkFNjWXV7S1BwcgDDD1zR/NL0ZA52D6HgVl2rg6qXqfxpVKJzBiX1tFc
 3NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706691061; x=1707295861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RPEqoZsCMdC/Yd1ZOBxYPSQmuFl5Y3avH1pmkIvBDOw=;
 b=EB9HXWPuZye6gCwaCZ0yhSimtru0ei3Ch9zPB459K54V24qwj9WmUeebPYnvTwjnoX
 oeiDnM77c2DuEw7nu/Gx/GWW1fNRXTiSwrJvH9uFOxs7DLoBfbuqVJceNxubwZSWwpES
 w22NOaNrFhpdE3hGYklR5n5xHIwURtBUz+Qr3SbumvucC384w9++4arwF/mwXY4ngldC
 pL5eJ998wPzSi+2+zCgiK0pnqhG0MRuxxSKv8O2qjz5O9cZ1j1S/HYJK2IfkTVwlPeKK
 vUhNlLl0MrvuE0G/G37irVasbpYhcZzaplYFpPti/OlxEzp+8a29RLFteipSy+5yoZsK
 xxFA==
X-Gm-Message-State: AOJu0Yz6cmoBcvNrXtBVUYt1/EFomfdeYW1maEZ3j/v216H5av9PpR5j
 DEQ9YOPzZa5sCRxM46lYGGZqgi1WZkTwjvE2lLhaXZNZ6gzYieI4HUzGZMclvlqo0REWqMnBvlU
 =
X-Google-Smtp-Source: AGHT+IEjpF+v7+1wOO5k9g9gBXFAiXTKqZB1dfawdPulZKSoNhDRAK/iCUeDF3a8/czHq2bcc8sEbg==
X-Received: by 2002:a05:600c:3b0d:b0:40e:b0fd:3c09 with SMTP id
 m13-20020a05600c3b0d00b0040eb0fd3c09mr745871wms.9.1706691061181; 
 Wed, 31 Jan 2024 00:51:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUDZqRMvtzQEMSiBz8wBlM9sJTHS5Dx3p76cR1USAqmLj8m9kDFyuqKHBxh24EfKJGbXo+TNeaNx4hXJI3EdpCjgZ0atwXTMfvaT02z3MkA5gkIwVBttjsDXCP/OZCRpU3InAKNP2ftWsskh1Hvt+bV4oJOf3P89MIEnyO2XLGuRbudRcbt2Df6whzu/ltl/g==
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:aea2:cdf3:9482:a36])
 by smtp.gmail.com with ESMTPSA id
 n28-20020a05600c181c00b0040efd216050sm909926wmp.35.2024.01.31.00.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 00:51:00 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/9] sparc/leon3: Add support for -smp
Date: Wed, 31 Jan 2024 09:50:38 +0100
Message-Id: <20240131085047.18458-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32c.google.com
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

V3 modifications
 - Patch 3: Fix indentation
 - Patch 4: Fix types and improves variable declarations
 - Patch 6 (NEW): Remove SP initialization in leon3
 - Patch 7: Add assert in leon3_start_cpu
 - Patch 8: Improve comment

---

V2 modifications
 - Patch1: Add SPDX copyright tags.
 - Patch3: Add defines for MP_STATUS fields. Improve comments.
 - Patch4: Improve a comment.
 - Patch6: Dropped as already merged.

---

This series allows leon3 emulations to record up 4 CPUs.

It requires some enhancements in the grlib_irqmp device and adding the
cpu_index field in the asr17 instruction.

It has been tested locally with various bareboard runtimes.

CC: Frederic Konrad <konrad.frederic@yahoo.fr> (maintainer:Leon3)
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (maintainer:SPARC TCG CPUs)
CC: Artyom Tarasenko <atar4qemu@gmail.com> (maintainer:SPARC TCG CPUs)
CC: Philippe Mathieu-Daudé <philmd@linaro.org>

Clément Chigot (9):
  sparc/grlib: split out the headers for each peripherals
  intc/grlib_irqmp: add ncpus property
  intc/grlib_irqmp: implements the multiprocessor status register
  intc/grlib_irqmp: implements multicore irq
  target/sparc: implement asr17 feature for smp
  leon3: remove SP initialization
  leon3: implement multiprocessor
  leon3: check cpu_id in the tiny bootloader
  MAINTAINERS: replace Fabien by myself as Leon3 maintainer

 MAINTAINERS                                   |   2 +-
 hw/char/grlib_apbuart.c                       |   6 +-
 hw/intc/grlib_irqmp.c                         | 110 ++++++++++-----
 hw/sparc/leon3.c                              | 130 +++++++++++++-----
 hw/timer/grlib_gptimer.c                      |   6 +-
 include/hw/char/grlib_uart.h                  |  32 +++++
 .../hw/{sparc/grlib.h => intc/grlib_irqmp.h}  |  18 +--
 include/hw/timer/grlib_gptimer.h              |  32 +++++
 target/sparc/helper.c                         |  16 +++
 target/sparc/helper.h                         |   1 +
 target/sparc/translate.c                      |  13 +-
 11 files changed, 272 insertions(+), 94 deletions(-)
 create mode 100644 include/hw/char/grlib_uart.h
 rename include/hw/{sparc/grlib.h => intc/grlib_irqmp.h} (83%)
 create mode 100644 include/hw/timer/grlib_gptimer.h

-- 
2.25.1


