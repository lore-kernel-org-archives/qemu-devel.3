Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66B2D5E140
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 07:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9J3O-0008Px-4u; Fri, 08 Nov 2024 02:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t9J3L-0008OL-Ug
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:05:07 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t9J3J-0006A3-42
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:05:07 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so1589475a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 23:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731049503; x=1731654303; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WgDfftvdha+DgL2LjAUeMKUi9N9A+5jceZKQDE72GE=;
 b=RCWwaCxvADEvEIBJPXK3iDqEaDHpya1OYfuQtuhewDt4txado6PNMtz6fkjd5gfTZ/
 NLAsvv4ge+v+vlkz95idRYTi26WLeg8T6UEnFyJdnwrNRWt544ze2fX0YHUoXSQxtxym
 NwL/GcdaPnjnqXhpvqQF8uVlSaYJkVKdQUBPEMsVTjPPEeMr+dUrLiPBNWmc61AyZY5R
 V9aWMsQgHgyuNInXkaqHQe+wlsJTGNvOte0OYaC3XLfefXDcr9fjsmqc2+S2ZqW9qIgJ
 izSbRgX2uOeCJiQ+qu5tm4PKmMlBb7MJeN0iISiOLonE0xNljnfPTLbBhVGGEet9Z/pF
 S7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731049503; x=1731654303;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WgDfftvdha+DgL2LjAUeMKUi9N9A+5jceZKQDE72GE=;
 b=w709cawgk7hDLdGES8K49VrCJIinvB8TDVQCEhok3RVfJAFVKUryohZv/YHSdys6Ly
 jqAKJJRiJ/ag7XCvU1b/l4iVKyGkac3JMT3Q+OB9Kf4zy7S4Nt4uAuMWbdoPRpvqyVPW
 Jp6l+Iwu4TwL1eVl67NZkcFMq3iQPLyyQjDetCt2kxw3ucan/B1TLgo6MwisLVgI9UT1
 yz4PF7EZB2mssQiX8Hm9LaicAwjqkiLoR7VR9vqmkqGO//kCeePHMsd/LutP+d/E2ClM
 bVux+e0yGJGt5njgZjxX5nQrj6xmqYMIp0NcprfzyW7CD+lGbdP8k4NaFn2gb4RhLrMf
 N3ag==
X-Gm-Message-State: AOJu0YzftPw1jCgHgFGmxQeSvuCN2sPGnx25BBukLIBAFcm54a8jIwOG
 M6xTwuZsHG12IAq77yJb/neNTsfzHnxBAQayILdsbnQiN9R8Amd67NJYWG/3PE8dT/FU8RpAeVH
 Fkj2uWbKvUznyQKNJUJgB9BF6kFYHdTOIEvyuhsB4/wrd1Ty9kM6/UVNKI7nUZvSysMNwCft8v8
 8YJuYcB7GjKqm+9F6C7JUcWFJz3YrJhfhwF7OM
X-Google-Smtp-Source: AGHT+IEa3IeJfBQcxbVc7dZhFGRIi9AegOprKA2tl0uiM/4SxW6rgpkIGsL0wPGvZzW5gZYkLIbFbQ==
X-Received: by 2002:a05:6a20:1590:b0:1db:ee29:4f4c with SMTP id
 adf61e73a8af0-1dc22a1b545mr2131587637.23.1731049502467; 
 Thu, 07 Nov 2024 23:05:02 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9058sm2900715b3a.77.2024.11.07.23.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 23:05:02 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 0/3] Support 64-bit address of initrd
Date: Fri,  8 Nov 2024 15:04:51 +0800
Message-Id: <20241108070454.12699-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=jim.shu@sifive.com; helo=mail-pg1-x52d.google.com
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

Support to load DTB after 3GB on RV64 system, so that larger initrd
doesn't be overlapped to DTB. DTB loading now will check if overlapping
to kernel/initrd and report this error.

Verify the patch via running 4GB initramfs on the virt machine.

Changes for v3:

  - Change struct RISCVBootInfo from machine state to local variables.

Changes for v2:

  - Add DTB overlapping checking and struct RISCVBootInfo
  - Remove the commit to change #address-cell of 'initrd-[start|end]'

Jim Shu (3):
  hw/riscv: Support to load DTB after 3GB memory on 64-bit system.
  hw/riscv: Add a new struct RISCVBootInfo
  hw/riscv: Add the checking if DTB overlaps to kernel or initrd

 hw/riscv/boot.c                    | 94 +++++++++++++++++++++---------
 hw/riscv/microchip_pfsoc.c         | 14 +++--
 hw/riscv/opentitan.c               |  5 +-
 hw/riscv/sifive_e.c                |  5 +-
 hw/riscv/sifive_u.c                | 15 ++---
 hw/riscv/spike.c                   | 15 ++---
 hw/riscv/virt.c                    | 14 +++--
 include/hw/riscv/boot.h            | 28 ++++++---
 include/hw/riscv/microchip_pfsoc.h |  1 +
 include/hw/riscv/opentitan.h       |  1 +
 include/hw/riscv/sifive_e.h        |  1 +
 include/hw/riscv/sifive_u.h        |  1 +
 include/hw/riscv/spike.h           |  1 +
 include/hw/riscv/virt.h            |  1 +
 14 files changed, 130 insertions(+), 66 deletions(-)

-- 
2.17.1


