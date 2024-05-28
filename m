Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B2AC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBrIj-0003Zz-87; Tue, 28 May 2024 03:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sBrIh-0003ZR-Si
 for qemu-devel@nongnu.org; Tue, 28 May 2024 03:31:15 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sBrIg-0001bz-8f
 for qemu-devel@nongnu.org; Tue, 28 May 2024 03:31:15 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f6911d16b4so389210b3a.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716881472; x=1717486272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6RcZFSVWeBHTaSxO3oQt0mIiVlQtHhiz1Kxf5jYBFh4=;
 b=hhtS7lDZ01QCo9bOYHAbYOazUbhd50OwpZlZ8vhW2C6woHq1LRn4XdzjIC/0LFkzAv
 vFvopsyoJ4xuIaJ8+QUPQhBIy3V/90tbki/Aag8VFjBqRVUdMzQUjF/Z9Z3/j3HNqwMu
 wxssg6Z/s5DkbykJdOyA4zz55s9T+CobuOzPbRWzwDBl9u8pKRaNq+aukjIhehTyR4VL
 WnjnP1FpL2v8SzfAgDYr1qNv7VvzGxi1hNhE5B0gQqKiOKAuEXsxoMON0BuZ1yKNwYO8
 LqPbPxYbbwNoW6w/UtnVIMeeEgPzBcDxjgQlOvGcqxC0eMQ7e5GOxiw8ykCpJ+emHJ+a
 ao+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716881472; x=1717486272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6RcZFSVWeBHTaSxO3oQt0mIiVlQtHhiz1Kxf5jYBFh4=;
 b=t2EVrGcg337G6fUZ9m/ex8MkR/bdeR68MTfbGYZLq12HMBhFEgo7UjaHcfeYnMSnHh
 ml3lMjHsOd7kRJdTyjhXaCadB4qIFonLXOjcJgTPu31n+/wOd3lqgYWKqG4jyTUJUP14
 F5FGpUPLWwSVW83gwCUb6ESbdg/aZp0kfxF2wAtcTNLMzlSuUxLRq7DNx3Y8ElvFJ6sh
 dvFyX7S1kR0MqBMXGpZ3BFlF3/fOXxBOFk3h8wHLIopJ1ypEKHtBew+sLuBUYO4NPiOy
 f2pRROj9KJH87dX4+5KJm86MV9Nrv3I79Jrt6HSo89v1TlVBBpy0bdjbngfSLCWxEfNI
 ADcA==
X-Gm-Message-State: AOJu0YzpmRODFCBhTN9SqWomA7ltcrRV8+nllk7A4dHcRbP+6nQEykul
 pvzHWoN/4UH4ZENycJz25M/g39/cQfcueBWlNnnRm2YgBIPC2AdqrjGhXZVGoq8vt1xiUzkyMvP
 bK84=
X-Google-Smtp-Source: AGHT+IFqf6hsqlwyQeA4NYd8M8dXempDA10m982aScsNBI6j32P6+mGTKdKW1sYG71wQgl/dQfnYwg==
X-Received: by 2002:a05:6a00:4007:b0:6f4:46ea:2f26 with SMTP id
 d2e1a72fcca58-6f8f36ffaefmr12260172b3a.15.1716881471624; 
 Tue, 28 May 2024 00:31:11 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.31])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd4d51a2sm5881080b3a.189.2024.05.28.00.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 00:31:11 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 0/3] RISC-V: ACPI: Namespace updates
Date: Tue, 28 May 2024 13:01:00 +0530
Message-Id: <20240528073103.1075812-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x436.google.com
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

This series adds few updates to RISC-V ACPI namespace for virt platform.

1) PCI Link devices need to be created outside the scope of the PCI root
complex to ensure correct probe ordering by the OS. This matches the
example given in ACPI spec as well.

2) Add PLIC and APLIC as platform devices as well to ensure probing
order as per BRS spec [1] requirement.

3) BRS spec requires RISC-V to use new ACPI ID for the generic UART. So,
update the HID of the UART.

[1] - https://github.com/riscv-non-isa/riscv-brs

Sunil V L (3):
  gpex-acpi: Support PCI link devices outside the host bridge
  hw/riscv/virt-acpi-build.c: Add namespace devices for PLIC and APLIC
  hw/riscv/virt-acpi-build.c: Update the HID of RISC-V UART

 hw/pci-host/gpex-acpi.c    | 29 +++++++++++++++----
 hw/riscv/virt-acpi-build.c | 57 +++++++++++++++++++++++++++++++++++---
 include/hw/pci-host/gpex.h |  5 +++-
 3 files changed, 81 insertions(+), 10 deletions(-)

-- 
2.40.1


