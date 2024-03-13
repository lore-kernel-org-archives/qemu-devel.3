Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F30C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkUJs-0006qU-Ir; Wed, 13 Mar 2024 15:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkUJl-0006q0-8P
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:31:13 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkUJf-0002Q9-Rt
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:31:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6aaa2f02cso211972b3a.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710358265; x=1710963065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u49ZsHiKEZPJuB9ki+WLQrM9cRTAq7Fel6AdXa7pwl4=;
 b=lFvca4BU4G89xX+uxnnyfWHU2hrxQ0m+safJ1xyeWhq5/TkfSlfrrBkYmL/JKU9Ywq
 NWtTYBacWibcTWHIbdgA9APk1VX21yN/3e+jhGxjw7yxBtK68qtIL5JKrC83qSHS+41u
 bIahh+88lFSweGJpQNNuD0aapA9sJdYqTavjMGO1esL/23V4Y21/lpb8sw8zDXwWFcM2
 D3/ycDcYMGBzb+nPFlg84DI1iwoNtoP7rT5qIBV/fQwOICHBLgOrJMSs8VBXn85qA9x1
 sE/h20an+kzsUbdhst0ZOEEmajseZ9Y7dUz/z8eQcBRVy/HtuyWmfF5TVwfjgF+bMB2X
 XHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710358265; x=1710963065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u49ZsHiKEZPJuB9ki+WLQrM9cRTAq7Fel6AdXa7pwl4=;
 b=eKWkhQv7NJPnvMy9B1yYplc4eZ1aE7/D/WFMZq67m0bV6Q2MrIY8Q5w9wcsYF7aG9E
 EPRR8IC3E4k1xIqpeDsu7T1146mgbBHP7yLy4rfjee+LqH9NhounFUPRfFEWN7zA23ae
 IB90qjVawZKMfSiHfYbFs0X+Eha7EoNXarnPuJffA2ZS5K6Uhi5lUP4xDxmClFd5+jFj
 KWu/W4ldN8v8oBaoYe4OmL8NmZp9tBCSsfykUxfSx+kQq/B31mmb17bXSOTgg8Xl0ZHw
 qaGsOSlnE9lXNrVtQF4DjrG2B49H6ACTs4hBWVJz7jCGvLBK5NDfnINmFKM52xUI45OZ
 eocQ==
X-Gm-Message-State: AOJu0YwP5pHO3AljTDA5OoTtlHQnohMSTLxnfBLa64h+nm5/LhMn1IuB
 Zm6zpuydz+L/KwLLFXO3Ojgr5J2XyF/Mlw6mKmrMQ66bkWZsvExRvDM6oUgCaYTb9+sB7AF0cf7
 f
X-Google-Smtp-Source: AGHT+IFKXP9ho4NSxxrUXMK9RLKbTROhSlf+f0+BYGKpx4n8EmpM8A52jiSdBPpDKQJB1f3z/emprQ==
X-Received: by 2002:a05:6a00:189e:b0:6e6:c5d5:9195 with SMTP id
 x30-20020a056a00189e00b006e6c5d59195mr984143pfh.28.1710358265489; 
 Wed, 13 Mar 2024 12:31:05 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a628e0a000000b006e5a915a9e7sm8912421pfe.10.2024.03.13.12.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 12:31:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v13 0/8] riscv: set vstart_eq_zero on vector insns
Date: Wed, 13 Mar 2024 16:30:51 -0300
Message-ID: <20240313193059.405329-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

Hi,

In this new version I added a new patch (patch 4) to handle the case
pointed out by LIU Zhiwei in v12. I decided to do it in separate since
it's a distinct case from what we're dealing with in patch 5.

No other changes made. Series based on master.

Patches missing acks: patch 4.

Changes from v12:
- patch 4 (new):
  - move vstart >= maxsz cond to the vmvr_v helper
  - clear vstart when vstart >= maxsz
- v12 link: https://lore.kernel.org/qemu-riscv/20240311180821.250469-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (7):
  target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
  trans_rvv.c.inc: set vstart = 0 in int scalar move insns
  target/riscv/vector_helpers: do early exit when vstart >= vl
  target/riscv: always clear vstart in whole vec move insns
  target/riscv: remove 'over' brconds from vector trans
  trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
  target/riscv/vector_helper.c: optimize loops in ldst helpers

Ivan Klokov (1):
  target/riscv: enable 'vstart_eq_zero' in the end of insns

 target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 198 +++++----------------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +---
 target/riscv/translate.c                   |   6 +
 target/riscv/vcrypto_helper.c              |  32 ++++
 target/riscv/vector_helper.c               | 102 ++++++++++-
 target/riscv/vector_internals.c            |   4 +
 target/riscv/vector_internals.h            |   9 +
 8 files changed, 207 insertions(+), 192 deletions(-)

-- 
2.43.2


