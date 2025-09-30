Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD756CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VoU-00069k-PI; Tue, 30 Sep 2025 04:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v3VoS-00069S-5u
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:34:20 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v3VoP-0004KJ-FT
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:34:19 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-780fc3b181aso3413618b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1759221246; x=1759826046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ojkPsTQsaNQYLtTu/H71d9cy/NzlEBkDnjWPKYtb4T0=;
 b=TtkJE6LqFJes8m9cS8yFId0rFRIraVNFfrYDA0e/aQZgugctnWv3SgxWkoVV4xuIdA
 swE3Y6vaTu+s67L+YQAuX5pppYZtkMWSZxNts8PNQ85LtcoNqmd8hbWJ/iOQ+OBG2eI0
 FP+CSWD6rCUMg2PYg0ydI4EJ2BkkOerhvLGl1bVDIjtYLozF3sFGSS5UsVQBgaHFyQLi
 TsS0dQ9JYJymsC8nAgD8PQuRskwYfFJVcKtWIR/7euNl3KMylmeWukgW9rvPxVruHj0/
 7ITA+U9PzVrOssgYcmcN9DiAwfFhaa+QhFrbse20jcpIBQj/P6YWdN0GjByfdvV9dIbQ
 mRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759221246; x=1759826046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ojkPsTQsaNQYLtTu/H71d9cy/NzlEBkDnjWPKYtb4T0=;
 b=FMpHadcDxT8BlkX1cEpPbCmM6jI8D6199JkNSXe+r7dA5k0FzQCnaF7LjtuWY9dzkl
 irP0H3zdjr1fGJdYO7+K+fG6CszLch+A2Biov4SS3bt4L0XCaAV8T0A+FR9EgDIuaZ73
 8//EnItAoAChk5LLo9xBUWHMcNlzYuJQivHxrlannPbbCD65WBC3fE497kGV+PeweHE0
 fghWxFD7JAPz9GkdJAHdcUglRaCIdqKP5j5ziLJ5owyuO2u8Pd/1TwZM0TIuLg+BLW8m
 mAOY9cyMCTPzovXI8lukqDK4F40qivdkX8OCatfglj2PdQcGypo0vUJPyGNO57Jf6rM9
 2Pyg==
X-Gm-Message-State: AOJu0YxrCCwPqCJTRJPWRVVgydNcqAaloP9OWecVsuJTJxmOMop+kvLM
 17DIWXG8mpjJ43jw9DDQo2mxyZ7CgZYy2Yr6EnpbeO7aSoG1ax7ZDuGCPdEWusUor2W7MhOwrbT
 875qYTbpJ4VfZ8ISzHFQLNSmcuS3wNThDYJDkFJ02Jjpb/8Uv4RvALtY5OrvuppEZOt7lzSafiU
 DxNjulrz0pD3YRRk66o3g9acKRINCe52xMqARZ+Cn6
X-Gm-Gg: ASbGncvZG9vPDwzGmqH2vQfyN2vrpVU6lcGKs522ZPbB6AahrQeN0uLaF0a6Tu8mWbz
 Ggn8OxfPI2CuqzlJNXIdeUwr7x6jaxwdX6lfzyX4G1RMjwTYqFp/ZZirb9s80rNuRx03gKF9ZMF
 UMXJeoNIy3hCWDiuLnUca6A056DCgHxYqZlEptSmrEQU1Kuq+H+7dH7/TGKK4o1JhfyCM9a2otb
 taajnJM92pxiIoH9ESgf0/NNYZZbnkYhsUuBOXKIfEa4y0asfn9khP46yK7afliYecPWjXJHWkG
 osVcf1SBcB+4K2pxUJz6rAmzc01u+nXQKi5X3NQgKJyoWWmZc6Xo0YmZlTrTbTq0vK3lchssiZk
 ZtlT3L+4Nze0N7SKKwhY83yPWIb7t0DN1BaHp0epdOy3hVZwcDL8biaRCk/Fylx4Y2O5I+a8vfd
 647GHcsPtFNQ==
X-Google-Smtp-Source: AGHT+IFJTWIawBn/P8oZRaHIFpBlkGnkrcjuQGHRqVvmykZ44WHMdjoVdtGIy/2hiQimh0HqPSA30A==
X-Received: by 2002:a05:6a21:6d9d:b0:250:9175:96e3 with SMTP id
 adf61e73a8af0-2e7d474b937mr22319644637.30.1759221245688; 
 Tue, 30 Sep 2025 01:34:05 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.190])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b580bd86c4csm10340089a12.14.2025.09.30.01.34.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:34:05 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH 0/2] Make PMP granularity configurable
Date: Tue, 30 Sep 2025 16:33:57 +0800
Message-ID: <20250930083359.27637-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


