Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E75D711BB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 15:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDmnz-0003Tg-8O; Wed, 20 Nov 2024 10:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tDmnx-0003T0-Pt
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 10:39:45 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tDmnw-0005wH-7V
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 10:39:45 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so3520860b3a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 07:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732117182; x=1732721982; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwVYlW+hUSz9isSQvySubaghNMwPsy3Rgbp412mFcl0=;
 b=QN9Ula/kI6CPxIjyHpwJceXRyI6t0uDQXHPlO1SX0vhzc4vMVjm4P3ZpcXnLEy3hOO
 PixGQXqOLSt/V15IyWBzN1tZ16HvMyd5uelw+BpRgAlYga8aRw3khFNcSyv4fth/Y5/P
 xcybqT9CR5gItG+IJ+laCA4QUC+N7TdfIlJnl4i4gmYBF3o7HjqmqN2mUmZDXydvM/Vk
 c9pEHAoRtwWrrLdIc3ih8/G9SnHQ/gskeZWnnAeVwKl9UvYZHiUfLTa9Y2SanX/SY9ZJ
 H83B1aFGoiM9ucbFlthtgEqRjm97+ZKv99KYEFGo0cBn2Rd7YyQdsE/e7BB6EF0Sc3ym
 N2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732117182; x=1732721982;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwVYlW+hUSz9isSQvySubaghNMwPsy3Rgbp412mFcl0=;
 b=Rn4KvwQQcVQzAS0j1/MDPtqSWP6omyVysZ+gUi0tLaspbhBLNN23ooEAxX+iJg2mcF
 x/QocmVcumV7xkOTeJHT70poLzf88EqpXJj3wPBfCogLMJ58OcJuYC1FpTVC8b5x/L42
 g427dJ/SieEv06rNqXKECahYKp7oCW84ZaNyG0ltdi0Y9Gqi3z3eMm1CFuMNiGqKa+ae
 MHUglnTqp5+6dhpjx9ZPyBZOOHuFRm8UAH3eSmlLkK3UnY/K3unGivJFdMJ9ZDZjHHpI
 9g59+5GwkF27wrnqbhWSNB7yipZCdMkvpVckNABO5WywHLjwkfa1zhJSwV75ZMrer7KY
 Nm9g==
X-Gm-Message-State: AOJu0YzOasyvprcSl9A7ES87xr3WkQlv+XFjXCNVUv78ykZkjAPIeWQx
 V7rUSi/IwAyv+l2aMgdFXpQYliAzBFO/Lg3fYXCBt80jD492PMojfktjHmgKJlFK1POWPoYna0a
 SjOQNUd0Pk2DbcC5SWbzDXb562ivREo89yJuGvwBfhk4mO5cGmQgYJsMJmsR5jrgmrjJV6wo+OS
 xJNsF9NWHf7y2efpScX1zD7dHqFJLIqJb5dyU5
X-Google-Smtp-Source: AGHT+IFQkmyJS8HP4qOLUw32Q8W01kuHiEjp+qlU+yiDJVAp0z60IF5I1sl7hrTZ8CEm8poq+bt8Pw==
X-Received: by 2002:a05:6a00:cc7:b0:724:5815:5e62 with SMTP id
 d2e1a72fcca58-724beca4220mr4667958b3a.8.1732117180749; 
 Wed, 20 Nov 2024 07:39:40 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724bef8da6asm1838903b3a.123.2024.11.20.07.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:39:40 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v4 0/3] Support 64-bit address of initrd
Date: Wed, 20 Nov 2024 23:39:32 +0800
Message-Id: <20241120153935.24706-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x429.google.com
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


Changes for v4:

  - Update the comments of loading DTB in 64-bit CPU
  - Align image_[low|high]_addr's type with initrd_start (hwaddr)
  - Fix commit 2 to avoid unnecessary change .h file of board

Changes for v3:

  - Change struct RISCVBootInfo from machine state to local variables.

Changes for v2:

  - Add DTB overlapping checking and struct RISCVBootInfo
  - Remove the commit to change #address-cell of 'initrd-[start|end]'

Jim Shu (3):
  hw/riscv: Support to load DTB after 3GB memory on 64-bit system.
  hw/riscv: Add a new struct RISCVBootInfo
  hw/riscv: Add the checking if DTB overlaps to kernel or initrd

 hw/riscv/boot.c            | 100 +++++++++++++++++++++++++------------
 hw/riscv/microchip_pfsoc.c |  13 +++--
 hw/riscv/opentitan.c       |   4 +-
 hw/riscv/sifive_e.c        |   4 +-
 hw/riscv/sifive_u.c        |  14 +++---
 hw/riscv/spike.c           |  14 +++---
 hw/riscv/virt.c            |  13 +++--
 include/hw/riscv/boot.h    |  28 ++++++++---
 8 files changed, 127 insertions(+), 63 deletions(-)

-- 
2.17.1


