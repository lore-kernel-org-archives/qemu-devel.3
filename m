Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6731CD1A627
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCb9-0004fi-9z; Fri, 09 Jan 2026 08:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCb1-0004Vg-9i
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:32:09 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCaw-00027Q-L2
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:32:05 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0f3f74587so35108145ad.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 05:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767965519; x=1768570319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=lRUrPUvBFRuXC2FQf4b3+uuc3GFCJtPGwsQiF6HW3a8=;
 b=XEBP/EPVEaVUG9Xq0pSSOI424DrI/9M7Dm+ZGf++SW5sgOPKT3480RJQZDC7aPrOuk
 tLMC6OZW1AAkC4YN3Sa0Z7c5bvfC/+h7es86C6xTO7nDmC2PGptEcBfp3pwi/LF5zGX1
 voEZwrWtyn6bMqFqs3Jt7e12bdMutf/HAFWDz6kGqERL8CoTBo8+iiT85YghbBp7OETg
 wZ2ZWaiM0qeTc7me9vkpsah+aT5SoJmZEgp+k3iipNZ2nfegpPUQfkcT5c/wDr9YHGKO
 MBwdPdfIQh/Fd7AL9hHORuxlBBWJ2cEXvvcqjLdg275VRwzK4wVeMmE0HcjGmeFWWbrB
 AVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767965519; x=1768570319;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRUrPUvBFRuXC2FQf4b3+uuc3GFCJtPGwsQiF6HW3a8=;
 b=NwwmFfF9rp4oOq+foZRk1q/Au4/DxU21iy9/JWeQ0eyRBPFgBrJe8qy3j03khMRYBC
 RtKL1DPapWq0BdqFIY25nF9Q1xCMbUipK/R0ce/qWY//8gpBylJBdSojkPu9B2zcaL+R
 mt4OYqexPhx4PgzOL+DWlj74P3KCq40O2WXl+NxTHYSAIX52NiQjP3WjmRZg2uoUeTM+
 i5wuvCrCt1tmGFU36oSeW8dOJLPxuMjLn3lctDvif/S7TzX2rG7UOrD4azD4PoqO+CnV
 guK8wIrcsns/PK490xibkXPcEDjnZS0wOyGd231hPIEXV0z1OEGKjeQqGXyLo6Psmefo
 ErqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdfiC6CRKpKIhdSdc1GcsbGYuAqf69pGQEyignHWW0HXGH3itQsxVJvhLzPITSf8Ex1o20L4BUQ0AO@nongnu.org
X-Gm-Message-State: AOJu0YzawA36Gg/Xe5FrDi8wfL38uJJSjFJpgfKNxFxkJo22PjJ1rmn3
 Xhr9BhAS04BlEt3Pqj7E/BuGlRXmGJO2/kCta9OGeUab7z/1QA0k9Fi4
X-Gm-Gg: AY/fxX6kFcbgRHafXK/3Y9V1L2YgYH+PWVw93xpQGAm4FY7IS/vWU2i7XS4mGNzI38t
 o3ejF6l4hfbmU5oAD2y2oGyCaQcfYbF1h1I0lSfgGPHtcn5w+KMPAT2MNwag4MeRfTTcSIALWJn
 /Dr4Cj7+H+OHy1eio3/ysFw54mgqF7dnwJG11DtsvCWBAAjZymkLKU0qtILE48RhaN2QgNwfGXa
 p/3BdY6ZChtP7Gj/4XE0h8UAkZBm41yRzm6cmgZnD6xKG0u2xAhwrz+Vo6OuVv+PWuBgMlstss1
 YILGJQtVcWxTHDIi99uNgQKXWlDGDBEDfatpp3qIDqiwDj8HQIgXdJjCLMfT5tPgB+nEs6dJHNt
 zFulgD9WTPrGD3IuOJdj1lu6MTl1tpk5hY7rljXlWGyTUXoH+wBwBIHAk1xzrz2euJJjgtOnlyb
 WH0IIydFB/L0FNMA7MfoVa
X-Google-Smtp-Source: AGHT+IFiM8u6P/3GLFhEQR4/VgG8X7nhcgmMoIU7PSTL2HCR3HgtWHeRygeDJCeqxA2h02IkS/9kIg==
X-Received: by 2002:a17:902:e54d:b0:267:a5df:9b07 with SMTP id
 d9443c01a7336-2a3ee4389ddmr88216925ad.12.1767965519472; 
 Fri, 09 Jan 2026 05:31:59 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c491e7sm107755535ad.38.2026.01.09.05.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 05:31:58 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 0/2] hw/riscv: Make virt AIA setup reusable 
Date: Sat, 10 Jan 2026 00:01:21 +1030
Message-ID: <20260109133125.397364-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

Sharing the AIA setup code looked like a good idea when I was
implementing a machine with AIA. It will be used by Atlantis initially.

Atlantis will use 128 IRQ sources so the second patch makes that
configurable as part of the setup. I initially changed it globally and
that broke the virt acpi tests as the number is encoded in acpi
blob.

Joel Stanley (2):
  hw/riscv/virt: Move AIA initialisation to helper file
  hw/riscv/aia: Provide number of irq sources

 hw/riscv/aia.h             | 59 +++++++++++++++++++++++++
 include/hw/riscv/virt.h    | 30 +------------
 hw/riscv/aia.c             | 89 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/virt-acpi-build.c | 24 ++++++----
 hw/riscv/virt.c            | 87 +++++--------------------------------
 hw/riscv/meson.build       |  2 +-
 6 files changed, 176 insertions(+), 115 deletions(-)
 create mode 100644 hw/riscv/aia.h
 create mode 100644 hw/riscv/aia.c

-- 
2.47.3


