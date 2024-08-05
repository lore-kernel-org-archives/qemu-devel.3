Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA29C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 04:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sapPv-0001v9-LQ; Mon, 05 Aug 2024 00:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sapPq-0001qp-Jd; Mon, 05 Aug 2024 00:33:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sapPo-0002rl-Hh; Mon, 05 Aug 2024 00:33:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fec34f94abso78181245ad.2; 
 Sun, 04 Aug 2024 21:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722832425; x=1723437225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H+UbJav6pWivA5AV05dEiug1fpI419gYUieSJhjV/Dc=;
 b=NLXCyjgNNiCc/aJgqYYdN98L3HdamUuroiMm0+85JQx3xSe5Y1mYyLnCciW3+w96Q5
 GH7GD/mjPuetPeCM219x0VuPQVsb/UjolRh9hRDMe+8J5eShgvsB1k1fsAFCFEXf3UW0
 dKiyOGi1Y1frjj2YdYVijJqyuOyHgt4gKRqrPM+uQ70ZB2uGNOYyiDCvS78WrcLhi3Jo
 D9uhJ87hclag0N0bHQxT6CxsmU6YBGwool4+ooIfVhQzOs8605uuGOC8ErctTg09YdUV
 3MW5Sw2EBwNRTEHnkbUgUKn9i7Pi7qEKHV4IWsp6Th27iadeEZIR5UsU3yCFzK1aiEbM
 BAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722832425; x=1723437225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H+UbJav6pWivA5AV05dEiug1fpI419gYUieSJhjV/Dc=;
 b=trcbqC7xyqYO7djk5ITixsZNur+kcLEmKTYj8NpClGLdf5N1YviFoPmfyArx56Zn26
 40tC9gnxtzxFpz193z4J3JAGZjWq4hJOnqeocjGF8ZGAua5fvYgvPCjW+yRq+b+tfFA9
 3B4kipP0MPLFa6Ed70vhFGWOonwN/wcGwt8oIe5o0qL7I9W+xL8DzQ8WnKz1eWLvRSHt
 w+4NkbssyBpjfNOPpgCw8E+QqtwjJGumH73/LaFFGcgpPMqlOWdB3d5+GKGdYE9itbvp
 fCOk9Dcm4JcLJY2QWMFaQKsUCqW2N09XUmngiLJDiCOlDfXoChJZ1feoqwjeTkh0n21V
 BDqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXXW47dBC/YCLurXrXncKea1JJxULP5Ckvm+DyV/rkerq2PBZMZHtfCEPEdbFAdJo10nqUdU9GMrvs0NK3ZUFfwKTcUBo=
X-Gm-Message-State: AOJu0Yz+0kpyb/HoSDaID5Y63YHdGdmd6rQaC9PhoKJhxgrjdMXmPCKd
 Dt5P+LuDKrSYDSA6YdtqQIR8/EGqfNem2/Xr426JtCdkEnmp6P+jIR/EArgl
X-Google-Smtp-Source: AGHT+IHBAcFG94kdXeMF7wbU9eeD1/+ebRMAN41RVdGzCYS7lw7DpHBM7R+9snfEBUXtxoaN9I+LAA==
X-Received: by 2002:a17:902:ce91:b0:1fd:96e1:802a with SMTP id
 d9443c01a7336-1ff5749b888mr95073665ad.59.1722832425188; 
 Sun, 04 Aug 2024 21:33:45 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f29cd5sm57420725ad.56.2024.08.04.21.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 21:33:44 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: dbarboza@ventanamicro.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, zhiwei_liu@linux.alibaba.com,
 Alistair Francis <alistair.francis@wdc.com>, atishp@rivosinc.com,
 bmeng.cn@gmail.com, qemu-riscv@nongnu.org, alistair23@gmail.com
Subject: [PATCH 0/2] target/riscv: Convert RISC-V custom bitops to standard
 ones
Date: Mon,  5 Aug 2024 14:33:34 +1000
Message-ID: <20240805043336.72548-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Based on discussions at [1] this is a simple conversion from using the
RISC-V specific bit operations to using standard QEMU ones.

This series adds two new bit op helpers mask_extract64() and
mask_deposit64() which the RISC-V target can then use.

1: https://mail.gnu.org/archive/html/qemu-devel/2024-07/msg05976.html

Alistair Francis (2):
  include: bitops: Add mask extract64/deposit64
  target/riscv: Remove get_field and set_field

 include/qemu/bitops.h     | 35 +++++++++++++++++
 target/riscv/cpu.h        | 10 ++---
 target/riscv/cpu_bits.h   |  6 ---
 target/riscv/pmp.h        |  6 +--
 target/riscv/cpu.c        | 20 +++++-----
 target/riscv/cpu_helper.c | 83 ++++++++++++++++++++-------------------
 target/riscv/csr.c        | 82 +++++++++++++++++++-------------------
 target/riscv/debug.c      | 14 +++----
 target/riscv/monitor.c    |  8 ++--
 target/riscv/op_helper.c  | 70 +++++++++++++++++----------------
 target/riscv/pmu.c        |  6 +--
 target/riscv/zce_helper.c |  2 +-
 12 files changed, 191 insertions(+), 151 deletions(-)

-- 
2.45.2


