Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14BECD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ3F-0001IU-0t; Tue, 16 Jun 2026 15:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wZZ36-0001HS-3t
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:02:13 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wZZ33-0007T5-2q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:02:11 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-842cd900ee0so2260743b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781636523; x=1782241323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=baUIBYzyyEeC7t3l0h6UMGuNFHnGmb9FmCceeSW/S0c=;
 b=VPtI8OPCuoAN2z7+yBMQdn64Do+/duLsmO6KC3zNLlDa6vxak3v2pq7OClMufOF4y8
 orUpKbW7jjhQMAyYVt+YfD+rAZwinzIW9BxhM29V7yUIa738XdcA5cHp72iz30V2pWpD
 rgZO4M8qrUpZmHCqIob8O0jCKhLnuH3JR8UfNrHf5dhWgAuLo0NemuIfGs0s/ZqpgPdH
 7zfjFcMd+/DXDOWTxUjmlC5Qr0L5yArYTPTNzAllKT2dufDh6lyQXho7v1m5jdorHx7p
 JEWUZj3Oe8jhkGXQmjcuLu1fJEN1bskJTIIxo+q5dAuKCdCII+hm/lDEMp9ifhMURYKO
 lvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636523; x=1782241323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=baUIBYzyyEeC7t3l0h6UMGuNFHnGmb9FmCceeSW/S0c=;
 b=hvscnD6a29pajYNEdQxEL/eRi43WvSOM17bGUjNEc4ZBDVKQrJv+filM1V9e5iqTNi
 pV2FoeW/ia5BrQ2x2e6NK/YAueaTY9AoR0XAEErWjt7Gt9nzrcSonNx1DA1PuOyN94jC
 xn2MjnaICEwDetuBZ4+lu6BqCoEEiv+YcTw+AlzTVFBWWxqlc8m6h7YV4NR79FUBCfR9
 fvrAmj+TjQQK/nflyUvX2xfb/zGMFwRlazOFsAo0y1dW11/ykcEGvG2tjTxa/b7aq5kD
 Rnxls9oGgK1nHTNiwmlj25I/fQ8noaOQzHdTATFOTH9za8kHHIxM40Lhwld1E+EQJH/c
 sNNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rcLJyy6xo2rFybCDCvL+glGV5l7xwxVTmqlUvGc5kyTtd2/dOa7hGF6yBcLIHVfMyX9ujdUG9+eC6@nongnu.org
X-Gm-Message-State: AOJu0YzApPPe6Mml9GIVqhJMnvQPiyPX25oF+Xm7Jn/dzAIyjLFEn3yC
 htdjZfPn8AU0//8lEWXP/MzfHthYYQbxuNM20NnVORoEs5dyiCPFGm28
X-Gm-Gg: Acq92OGDsT4AKIGeSGavq2X1pXUOv44KPxzRSwRLqcARNVhiOPQF5oMMfUYCtliNpAP
 SaavWJCrnaFPsZuMBTF4Pma2idS6aYX0OyePGJUP6wROkhNZsT/v5irFtEzmKTw2qqLPeGOzJbw
 efo1k3EGxlfhVJxU6QGGKAj85b2V2SrtriQ+L5TnrJTsNivbWjbTeAG11I2Yg8Bspj6Ued/4KK1
 l//WLTrFuaJcA0p1TnK4hQGGP5G2ZW09Bxs8tOyMr3gNLn5PJ9lh5Ah5BaeeT0izcycgDW1ynPB
 Y//DGKqx1sNv4y/UK05vvhCXaA2c3kK39O5sQlaL1LZ6Bnq+gcoR0oMpNP5f58GETvg7WkfXuIk
 WfbLSoOgj/02DlpEJZ0LanqPpUDVXr+QY6bJRDkfZBFQyj55YwY76wB88dljJ7Gx0YNwAy909Of
 QUC3zQA2P5m2bxIeS7pdbs24ajkCfynYX9V1mSIOML37wpUB8sc+bNhfF6gZB+gh+7iisSWgxgz
 SrYT6iU1tDhEGM8EcSND+0=
X-Received: by 2002:a05:6a00:1a87:b0:843:46ee:9de6 with SMTP id
 d2e1a72fcca58-8452441df06mr426923b3a.9.1781636523005; 
 Tue, 16 Jun 2026 12:02:03 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c474sm12671540b3a.2.2026.06.16.12.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:02:02 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 0/5] hw/riscv: Add support for Milk-V Duo board
Date: Tue, 16 Jun 2026 19:01:42 +0000
Message-ID: <20260616190147.1286316-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add initial support for the Milk-V Duo board.

The Sophgo CV1800B SoC features T-Head C906 processing, standard PLIC
and CLINT controllers, a dw8250 uart, and basic clock control. The
current implementation can successfully run OpenSBI and boot Linux v7.0
from an SD card to the Linux shell.
---
Changes in v3:
- Rebase on master branch.
- Drop custom T-Head PMU CSR patch to avoid duplication.
- Use REG_BYTE_WIDTH macro in clock controller.

Changes in v2:
- Added link for the custom T-Head PMU CSRs
- Added qtest to validate basic for the dw8250 and clock controller.
- Removed RFC tag.

Kuan-Wei Chiu (5):
  hw/char: Add dw8250 UART
  hw/misc: Add Sophgo CV1800B clock controller
  hw/riscv: Add Sophgo CV1800B SoC support
  hw/riscv: Add Milk-V Duo board support
  tests/qtest: Add qtest for Milk-V Duo board

 MAINTAINERS                                 |  12 ++
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/char/Kconfig                             |   4 +
 hw/char/dw8250.c                            | 118 ++++++++++++++
 hw/char/meson.build                         |   1 +
 hw/misc/Kconfig                             |   3 +
 hw/misc/cv1800b_clk.c                       |  90 +++++++++++
 hw/misc/meson.build                         |   1 +
 hw/riscv/Kconfig                            |  14 ++
 hw/riscv/cv1800b.c                          | 168 ++++++++++++++++++++
 hw/riscv/meson.build                        |   3 +
 hw/riscv/milkv_duo.c                        | 124 +++++++++++++++
 include/hw/char/dw8250.h                    |  27 ++++
 include/hw/misc/cv1800b_clk.h               |  24 +++
 include/hw/riscv/cv1800b.h                  |  52 ++++++
 tests/qtest/meson.build                     |   3 +-
 tests/qtest/milkv-duo-test.c                |  70 ++++++++
 17 files changed, 714 insertions(+), 1 deletion(-)
 create mode 100644 hw/char/dw8250.c
 create mode 100644 hw/misc/cv1800b_clk.c
 create mode 100644 hw/riscv/cv1800b.c
 create mode 100644 hw/riscv/milkv_duo.c
 create mode 100644 include/hw/char/dw8250.h
 create mode 100644 include/hw/misc/cv1800b_clk.h
 create mode 100644 include/hw/riscv/cv1800b.h
 create mode 100644 tests/qtest/milkv-duo-test.c

-- 
2.54.0.1136.gdb2ca164c4-goog


