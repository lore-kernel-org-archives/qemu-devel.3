Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0356D5E13A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 06:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9I3j-0003kS-9v; Fri, 08 Nov 2024 01:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3h-0003jx-Rv; Fri, 08 Nov 2024 01:01:25 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3g-00081x-4N; Fri, 08 Nov 2024 01:01:25 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53c779ef19cso1969087e87.3; 
 Thu, 07 Nov 2024 22:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731045681; x=1731650481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZjrStNyS6zrjylJelBgtgwnRK/JQa7gmfXHEF62fzZ0=;
 b=M0G6for0AdNwa9NCLOd/si2xBH4uCr+1mhqLYnQgicL4GdgGAYhhZwzBUU37gStftS
 0zXiRO/HGr07LkVbWdGVsPa8eR0BrV4kub2WHBFabueFHzU/Yhy9Nq7Yd/5uhQj/Ej3Q
 4ZijaUz/rfFod+EfoBctNLkzn1scIDJDXk4G/u3Zv0Z12xhAsLxE9Oc9C/wTXDHk2g6Q
 MjL6Tao7sYDyqRfMWUCK2ic++vb6kP6zb8quYunCKohvVfzyf/Qt6aXbsLWVbz2aaQpA
 X3PcoBG9kur1/xbVO/HpSQkpHDGQmb46TmYYEtShMv5Pb2HsHfs5T5Xi5/hWFMTxiB0Q
 ozyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731045681; x=1731650481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZjrStNyS6zrjylJelBgtgwnRK/JQa7gmfXHEF62fzZ0=;
 b=tZGyaMK9tC8yliV5IJ5kdmYO8TeAoqov2MYXVO7z4hcCMVB7gfak8ZOEnTqZ2jdx3y
 7h9FnyDSiLLsCZ8dpedZ6GHUjUOYYUrIi0nHQOV5nQFNAERsjyIyvfdsSsE7GusRBspz
 RTTe7gZ3/J0h3N/M6WGFddlPgK9gJtg1Kj8zsHDn/tyyTX73mL3VLPZpVHUBIQzb76v3
 W0zNLn1PNh1+wT4G/6Q7gNdMrS+uiGIbuAzCTkJj8AMva7dzlqLZRK0S97wB/ua7yhvq
 6BXp4oSHl5Sr9ICLNpsld6vp/1OsDNyYJ2kak7Hm1IYTovqSs2l6Sler2N1lOgSiL5Q7
 Al3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6/p67gQt07DEsYF2UvI+zvAlbDWTSdnI4fd1xZxUWIcXXkiJiJEOtAaAdO6IXKn8yLs9mz0lFtXME@nongnu.org,
 AJvYcCWquHrLAm3F4Iky/NyDzqACPVZ4tHwYyqjU1kl0mrs0JJyR4nqXMJ+ZwWudoOLR6bN9r5wSGtEeBKmiiw==@nongnu.org
X-Gm-Message-State: AOJu0YxkqwSDF9sBKOhzv9+QwfhEBo29iAofq9aE7j/4Btu0p/CTdMtl
 p5xHGqNcv3injQ7Wyf/GDj8ntOnxMUvEs6ikigHyYLvU8MRIIx8h
X-Google-Smtp-Source: AGHT+IFFFBIZ5Xns4X6nCFbYYyvW1dUlzUwAetFGsMmbF49DL9Oy95rVHXHNvT0SMdlQIM/TsbvJsw==
X-Received: by 2002:a05:651c:19ab:b0:2fa:c59d:1af3 with SMTP id
 38308e7fff4ca-2ff202774bdmr7147541fa.20.1731045680886; 
 Thu, 07 Nov 2024 22:01:20 -0800 (PST)
Received: from hades.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ff178ee325sm5159001fa.27.2024.11.07.22.01.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Nov 2024 22:01:19 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 0/7] Pointer Masking update for Zjpm v1.0
Date: Fri,  8 Nov 2024 09:01:09 +0300
Message-Id: <20241108060116.37397-1-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Hi,

As Pointer Masking is finally ratified, these patches intend to update the existing code to the final version.
These patches have been submitted previously and I tried to address all the suggestions, but I'd suggest to review them from the clean slate and then finally push them to the repo.
Thanks.

Alexey Baturo (7):
  target/riscv: Remove obsolete pointer masking extension code.
  target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
    of Zjpm v1.0
  target/riscv: Add helper functions to calculate current number of
    masked bits for pointer masking
  target/riscv: Add pointer masking tb flags
  target/riscv: Update address modify functions to take into account
    pointer masking
  target/riscv: Apply pointer masking for virtualized memory accesses
  target/riscv: Enable updates for pointer masking variables and thus
    enable pointer masking extension

 target/riscv/cpu.c                      |  19 +-
 target/riscv/cpu.h                      |  51 ++--
 target/riscv/cpu_bits.h                 |  91 +-----
 target/riscv/cpu_cfg.h                  |   3 +
 target/riscv/cpu_helper.c               | 124 ++++++---
 target/riscv/csr.c                      | 356 ++----------------------
 target/riscv/insn_trans/trans_rvh.c.inc |  11 +
 target/riscv/machine.c                  |  17 +-
 target/riscv/pmp.c                      |  14 +-
 target/riscv/pmp.h                      |   1 +
 target/riscv/tcg/tcg-cpu.c              |   5 +-
 target/riscv/translate.c                |  51 ++--
 target/riscv/vector_helper.c            |  18 +-
 13 files changed, 224 insertions(+), 537 deletions(-)

-- 
2.39.5


