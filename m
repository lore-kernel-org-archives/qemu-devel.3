Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22546D3C93D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 04:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2jk8-0007MW-Pf; Mon, 21 Oct 2024 00:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t2jjs-0007LI-07
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 00:09:54 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t2jjq-0004Do-J7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 00:09:51 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso2563867a12.3
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 21:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1729483788; x=1730088588; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YlQHmBIK0CFx8xbyfabzPzKVy4Q79eT8X8400qWpJc=;
 b=OSjhxs6zPpJudz0tHu+u8VEd4wAeL9dmZ5ry/s4qfY/Bk8GeEcU9rOSpRqQ7UQBL9U
 pPJY10Cn5zRUa/TGjqVJ1/zGKuCQ+6NJSxii/z/xYKDnV5CG2qQx8DFYpseAOp2y/dHd
 JjnPOpAZeEcp6nAkJs2xhAv7xlxzXawk5WiHsWWjcuf4TaxD/jYgxqUcafaZzsiXuub6
 ri4i1uoVPRxVcHYR46a9ONBuJTMJiMf637xeMjcFSCR8Nb3djsA5A44qmvWVnwU/LHPV
 wdOoQB2jReZJlP7ZcuRqpD5s/UL8opycx4QoFGtxWXs+ao9Y16k3fN3vdDww2rMV2hc+
 qqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729483788; x=1730088588;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YlQHmBIK0CFx8xbyfabzPzKVy4Q79eT8X8400qWpJc=;
 b=mQUJ14gJ82WtWUi+gZ33wznMM5Ptt6xm/BQiMvsKUjDKH9sRzykpx1Osi7Kqmfw90C
 IlO34VCqRnleCjy9QdDdhXiZyTNCwT74xId8k+Hs8/YvGACJfSal9+9BY/IJ2KXjF87/
 1wr9wiaS2VfNXrKE5tv60388X8btzj2RhHHunxeV4AneWL40dRk0mqeaTiXWHxBr/avd
 1f+Ampxfb+Yg31lMoLqGPISFjKqcQhqdPDWmsy20+lUWp6Bp6R09kab0s62jBQJLuxeT
 SmUWiidAH3ejr1DtaIpIK2PmFBnDj+UyREZhDSy+yIqd1x/Di3l8+a2eEO6aWPweD6ib
 fGBw==
X-Gm-Message-State: AOJu0YzYi4tRFqWT97rzndJhWNmiVxUy/rzLRaxIq8JMKtiFO4p3/zjH
 4arTm5bMIAUEpNuD4cI5E2Ck5xIyJhKsp9LhDqW5k9pkMKHsUTBCwtht1jbITuiekc1hd8Ozi1m
 Xiottbs9ZBXMAUItdusLEx0Vwsc2P41bI7akRlbouRRc8nEh0wP58JtgSRWDgd60UNDER1u9IJC
 D0yZjZqWfhqk2fwscy7OMCVSfHPQz5xxWNoQ==
X-Google-Smtp-Source: AGHT+IG7/9B1tS8FSYEhKoZ5UaV5Jnx0bg7gwRZX5y6e+wN2aKS1MBB15NIo9kCq7pEo5e5EfboBRA==
X-Received: by 2002:a05:6a21:9d91:b0:1d9:d04:586d with SMTP id
 adf61e73a8af0-1d92c578728mr15039551637.38.1729483787864; 
 Sun, 20 Oct 2024 21:09:47 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0dfc09sm16863485ad.236.2024.10.20.21.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 21:09:47 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 0/2] Support 64-bit address of initrd 
Date: Mon, 21 Oct 2024 12:09:40 +0800
Message-Id: <20241021040942.400-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=jim.shu@sifive.com; helo=mail-pg1-x535.google.com
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
doesn't be overlapped to DTB. Update initrd DT to support different
"#address-cells".

Verify the patch via running 4GB initramfs on the virt machine.

Jim Shu (2):
  hw/riscv: Support to load DTB after 3GB memory on 64-bit system.
  hw/riscv: Support different address-cells for initrd

 hw/riscv/boot.c            | 22 ++++++++++++++++++----
 hw/riscv/microchip_pfsoc.c |  4 ++--
 hw/riscv/sifive_u.c        |  4 ++--
 hw/riscv/spike.c           |  4 ++--
 hw/riscv/virt.c            |  2 +-
 include/hw/riscv/boot.h    |  2 +-
 6 files changed, 26 insertions(+), 12 deletions(-)

-- 
2.17.1


