Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6B1CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aK1-0003Dw-Hl; Tue, 14 Oct 2025 04:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v8aJz-0003DG-0d
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:23:52 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v8aJv-0003rO-26
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:23:50 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b550a522a49so4187011a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 01:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1760430223; x=1761035023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HYGt6gYGR6dF2AZNEJ7ZrXWSOP7QVzdUZavzcwclZ3Y=;
 b=OCBSVsz7vUTGs+q0sI7SmU1Nq23os+9jGZKm38kR9ntOwqoe14GD5fB74H77iG5K4B
 Wtg8TwSBVHhpGT6rKwM+TmWsSp9ahYS8ov3yMUNf83jCogRCCrQvhY9JmW0Yq/LBde0X
 GhM6mzttOzHhaZl09tIxwXI7YLGFsQ7EG+VYn1yqM2dteepPYLa63K1jwly5kJA3oidI
 MpDH0W+F9aYgqtCp+cDO6R1AAD0sKKlug/kncNj6k6SwsHNCyFdW7IeiSn/EBvTx0hvy
 ZgkmmkGbzAeVQvicE4CTetUm1OvPys4Jzl67g1Uf5xO+VU5/lgLpVW8mMVnda/V+RKDP
 oWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760430223; x=1761035023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HYGt6gYGR6dF2AZNEJ7ZrXWSOP7QVzdUZavzcwclZ3Y=;
 b=lxQqFH3hcB+Yuxghw9kETauOlnf5lXlG1WQhoC2/MUE0QyEAYA/pQofd8x5tQfUoxd
 Yw9XDJW9b3qpRXyr5n5muozhenXTE19f3oDDQLrRWnLipZXAUBThiB7T12Onl0aptMgI
 du1z8hG7/66f2LRWLliOIOmXNbFNRDCgkZ7qje1ChsxoWde5zRuaPNCcK3x48F/GzcIM
 QAWJFtGmrYos5G5sFRl6pN7xgQnY/rBCrivU6OaarFrDCYP4rE89hYtylmX0379uDfgw
 odjOw87iRdrtEbFoBllw+GpFEGoJ2P6wc+8nM6WMLRBEU94wdtxmfxpTpV8ON3sfvToL
 EzPw==
X-Gm-Message-State: AOJu0Yy/X9TFfjRRkidqWdmc5Tq4t55y+o1RaljWujSEajQ8aKqo/G/J
 e2DpaLKb+6NuEhdpu7w20HGN3RsoEI3Or811UE0/gJNjYTOxkKOKZPT4ALAZly0HxWrDYdfVNHZ
 s37+HaeKB5FaBiiJUeEdlsbGJGEJSQ1MiyEtMzpkdETm0Jda0MVfVjY5k+2t545GQF9ijq5rU8f
 cvZLZfCk8nTqi3/vUn2aUcB8cCaOXmmwYV1nJ9RZ1v
X-Gm-Gg: ASbGncsyl11AKdpNnVyY5TPGcul8Za+6bXgaXLsDd8XLJZ/8WT2jQg3olSaqEDNQVNQ
 NovvJAuXiU3xGGCva+QiBpI2mFdgy9ASFnU/InsASnXkK6i1+ChGacxqJV9lkLXd51CdEIfliss
 xz87KCWIznsIZFi9cY/cdenRzre60xdujUs2cnsqa5Ai+itePf3Mlpg5DvXnIVeJPWPuRsIczaR
 UM7OPCel8u2EkPei0SIiBCLUi/gH+uDG69UBG8KminFn9r1DpNJNKrUfNNVQ4XODI01D4VuvlZE
 5hBcPVSpLvYnKT7FPt/bg3fbnY39ST2O0GF854dczm/cogIGtJTWJ/D60MgZXAYUjSQDxulimZX
 asWugiC0/5Ue1X2WGomt3JWd6r1sXxkfZP06FVFXiGW8kq2inlpgftAAXzpTpEALAXUuxbIh8pQ
 RxHbBaULfTPyvZwSw4bwZLslv2zw==
X-Google-Smtp-Source: AGHT+IF2IdlIkcDT5LFW6KYNueC4xCZ8w2Rl4HIEQ3GAJuGIXqxZKwm0SSpJc6AFkacu2QV23oJ3SQ==
X-Received: by 2002:a17:903:2f84:b0:28c:834f:d855 with SMTP id
 d9443c01a7336-290272667bcmr332073805ad.27.1760430223246; 
 Tue, 14 Oct 2025 01:23:43 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93e06sm157162815ad.115.2025.10.14.01.23.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Oct 2025 01:23:42 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v1 0/2] Make PMP granularity configurable
Date: Tue, 14 Oct 2025 16:23:36 +0800
Message-ID: <20251014082338.87618-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=jay.chang@sifive.com; helo=mail-pg1-x535.google.com
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

This patch series enhances QEMU's RISC-V PMP support to conform with
the RISC-V Privileged Specification regarding PMP granularity and WARL
constraints.

Previously, QEMU always used a fixed minimum PMP granularity of 4 bytes.
This series introduces a configurable "pmp-granularity" parameter, allowing
platforms to specify larger granularity values. In addition, the handling of
pmpcfg and pmpaddr CSRs has been updated to follow WARL constraints. For
example, when NA4 is not valid due to a larger granularity, it is silently
ignored. TOR and NAPOT address ranges are also properly aligned according to
the configured granularity.

A new CPU parameter `pmp-granularity` is now available on the QEMU command
line. For example:

    -cpu rv64,g=true,c=true,pmp=true,pmp-granularity=1024

If not provided, the default remains 4 bytes.

---

Patch summary:

1. target/riscv: Make PMP granularity configurable
   - Introduce CPU property `pmp-granularity` for platforms to configure
     PMP granularity.
   - Default remains 4 bytes if unspecified.

2. target/riscv: Make PMP CSRs conform to WARL constraints
   - Update pmpcfg and pmpaddr handling to follow WARL semantics.
   - Align start and end addresses of TOR regions to PMP granularity.
   - Ensure software can read back correct values per the spec.

PATCH v1 update
Add the UL type to prevent bit-width errors.

Jay Chang (2):
  target/riscv: Make PMP granularity configurable
  target/riscv: Make PMP CSRs conform to WARL constraints

 target/riscv/cpu.c                | 39 ++++++++++++++++++++++++++
 target/riscv/cpu.h                |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/pmp.c                | 46 +++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

-- 
2.48.1


