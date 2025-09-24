Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972D7CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1KFC-0000s1-Hx; Wed, 24 Sep 2025 03:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v1KF7-0000r1-Dr
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:48:50 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v1KF4-0007d1-Tz
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:48:49 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso1498462b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1758700120; x=1759304920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bt6FROfWVPEeXPVJk3keuUb3yGmPAjxGB9eCdrJ47Vs=;
 b=bXEyI8jhbdizjvdxEVuXx97LAL8FgSzTbHixTgGZ1MfK+ARLGaqIkjGRNyO3UpvZWS
 /ISHIqtKtkCn+0Edf3GnetCB7zzEMgjsDGSLJLDiWKwhvjTyUdAoESzu2OMfN2K9rU0e
 na1gfiV3qnPbSmCA/yx9lgS9ohe6adjGypKtiSWyLxRxRV6FRJMr6MPcJYPv2EmQWXwB
 bvfpOsUDUDZvKTKzTo07FsL1poUmRWSHpCORWRRnUrTDa1qqUjtdSV7tllB7VdyuJ/6z
 yBjqyon0GNB5BFTn7h+NT3C2pONjvi9PzJjwbz2e71vo77D5jJtf3lgbjQnHhqN5EJPY
 4vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758700120; x=1759304920;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bt6FROfWVPEeXPVJk3keuUb3yGmPAjxGB9eCdrJ47Vs=;
 b=nyNkakBvPFKF+4wnUev8laH98PGw7dDciKmxon4X765FmTys6SSU0sXDb9fJT8XQnG
 DMj/Q65J2TdzDMy8hKePcPDfk5A1BNnw34yMyAJuNxfBg3jXmfFm8xdW8xbi9dl26bRu
 l6LNfNuAMLDYj//YjEkXp6zJs/A6f1Ugrw/Jg7/FvLSxEf+6+V2sxZCHrFbVT1D11NFB
 p2MO35XArEZk6v43RjFL462CA1Q6JMN/4VFTdgg/+zJkWsxO+eV+/YEBDqrNMzPcMTO2
 NYNWhdDo7dkRJG+RUgEOdI3Vmab7KgVCNPnbezmmd/wvbn1QrYL0MQPFiVBWJBrqpWQR
 8DMA==
X-Gm-Message-State: AOJu0YyAZlw6djp2uzpvQkWl8hNMwvl8CfMGfBFqCbtx1NmuOSv9x+xY
 AVo0nSQGyzBeGu4P3K7y0uL3W9EV2h+hBQJ0pelpllD4NwzPTVsFDAAjz3Dtpx5RUAXPplqo5L3
 iIGoqKYrWDAjtBuaAVbF/FQdKkB66DaAKITQ/TtAQ+S4esNGkEEdB+tE6QsC1QuWbChcBWau1en
 b7BSuwHNaUIdqreuHcIxLJ63MMxGZJRgOUVQDCgQ==
X-Gm-Gg: ASbGncvc5c1257zAHBfTLxRW3v5L2QqaVQGvXvWFESaqbbnQ/VSD/CaYAtlqbF8gZFz
 Sg3zNnYZSPlJy/qxapwBUcSyEkxs2eeMzrkYpVxMLAMc0mO6doRGdtUGvt0iedMQ1cznsPewkzA
 dcc/Pmqw+kDnjtkx5QI14Aj2clPgnBYDU/eMl2MEX27wk3un7eH8S/A90TzAnGC2iVW14HFPxTU
 VVr5gW+y0Z4dCpUweH/gRTnVUka5ncutewQ+u9rD2trQF2tRAAeZn1MP4oT/moWmcAtnh8O+CNE
 PUJda8sUnY8O+NrwjDKvqur0tTZ14antZKQBvPrt+qCUMsz9ggkyOZbC2npfEJCbOuecO19R633
 xzDtBk8knF1R6eqAIWZMv6pYXudnZapxHbZWG72jxbN4p
X-Google-Smtp-Source: AGHT+IElm6viL79BKQVSbOUsKh70z86hI/2kfhje80Chyz3P+lsg2VqTQnGhXh76LFfc1fkQZJWx1w==
X-Received: by 2002:a05:6a20:3d08:b0:2ca:1b5:9d4d with SMTP id
 adf61e73a8af0-2cfd4836d5cmr7731771637.2.1758700119682; 
 Wed, 24 Sep 2025 00:48:39 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b5541f0374csm8778502a12.49.2025.09.24.00.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 00:48:39 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v1 0/3] Minor fixes of RISC-V CFI
Date: Wed, 24 Sep 2025 15:48:15 +0800
Message-ID: <20250924074818.230010-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42d.google.com
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

This patch series contains several CFI fixes:
  (1) Fix the mepc in the exception from sspopchk instruction
  (2) Fix the exception type from SSP CSR and ssamoswap instruction

Jim Shu (3):
  target/riscv: Fix the mepc when sspopchk triggers the exception
  target/riscv: Fix SSP CSR error handling in VU/VS mode
  target/riscv: Fix ssamoswap error handling

 target/riscv/csr.c                            |  2 +
 target/riscv/helper.h                         |  5 ++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  9 ++++
 target/riscv/op_helper.c                      | 49 +++++++++++++++++++
 4 files changed, 65 insertions(+)

-- 
2.43.0


