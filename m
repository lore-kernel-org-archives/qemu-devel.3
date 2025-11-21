Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4A6CFA46E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJK7-0006Ei-Ab; Fri, 21 Nov 2025 00:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJJn-00065n-KL
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:04:28 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJJl-0006lt-Pl
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:04:23 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-29844c68068so17659365ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 21:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763701459; x=1764306259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BTX9KwD2YwTQRbsWY7vHTSd5zYZGddNybkmBjyJO5EQ=;
 b=Df1kpNfBhGEOaq1A8Q4y6aKIGHCJTJCO9j9pFtDAzDxnE4Ov+oulaEBZemSaFlqAoV
 0W/S8QzPaBvZ8Amw9DTJDDQIT5IY844t3bgecjeBLK/91rWAd6eGSXdOCA1xrD69FSkL
 AFVrLTJKy6Wx7kc7zgPbkNsHEvZxl9rwjF35982KM3YMesVGsnLcAkZialP452Z1c+v0
 G8a3Jy2qvrAqGRmfn2xqQyGG1YMYv/JFDx5E0TTUX0rxC47Eve/R2/X3ZBeCY+Hsa0XL
 JlK0vcuhh2YARU6X0eq9LyZrA0expUckJELNeRuG17Ad3hN28QmaBvha5hWA6SmLM/+7
 Z2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763701459; x=1764306259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTX9KwD2YwTQRbsWY7vHTSd5zYZGddNybkmBjyJO5EQ=;
 b=LMg5VaQg1HebFwmh1yhEZEIB/OqWwVSR5hKKuaNHmZm6cPIhd+2mZySZdPwSR+hRYe
 QlVt975Fb66NBbYDo/DpPhdfcrBIaBx1lU+gg7gSNQ2x/0a9nDwLvcmOn2qhJOmusx2g
 MFCs7Q77CmqfDjowBiD6tS0Px1lEguzGrMPmniy6ev3gTUYE4AETXK7G9qjE/ejd3yIz
 Etpg9wNbqyGI6KUZSaDSs++FNEXrSxbdOFnQWqE7eQgqMENIsL6P/HapS8jOrWdfT5sI
 4QtzS5PhJ3ITxITEH7lw7pWVwIKvbncznDM0ROL3bSSPFZXvJTcHo3HN7EoaC2mXE9du
 2hsQ==
X-Gm-Message-State: AOJu0YzP5xEQA+q6yoLfyG95uwPMcETpF9XXrkfwDKux0VfqIEC1nZdV
 6/Z/XngVtvYqzqaJtucA2UISdD5LPWAav/pKJoS8FsUCM+VJXHSceKaveQTv9kSkliKhLx95pC+
 xm3tyvakXaFVvSd3aLWRtSWM+m3gAF2NNsdwRUu3QhU7nnnJd34PN+RxBxbYeqmI/jaHyUU6C8m
 Y36zGUDxXx0fuUaSF41bu7VzZdgO2PzbLdGAacPXssiIE=
X-Gm-Gg: ASbGnctJBHWC3WR8UEraRckvMhsQ8/twrXcXIM46gqzXzgsF93DBsCNclau7e2iUz7o
 +zQaYplbgnrSABQap9IOKYCWg4P/IGgYQHGvdD9i4cRTY50idmdHJZtDtTMKqmUD5ft6FMLT7Ar
 AB6PXTlHaDqn13ZR7jhsh8pGQ2saTaYVXTLczKetvFxF//Cve+nuTVJzTOhAWG2iJWTHXAlo4RA
 juYJ1qhu1rjqQB6m2sjU0YnxxaBCcILLDF8XN0JMNSVMzXMB56guY2OGpBBqfZipI9p6WZDKAoB
 OonPTxwgxj6Yyd2C2N4WwawIkKKv58yAFlssIHYV4DZIMi6ZgksC8nCruKfC+8Z+YRYyvG1Nx8Z
 2T4r81n7X/Z5Lbsw7TRACkvSmuUrAGiSfSnibE9YYxGgBQIXG1W+hurteXY04fASZ849sdsypz5
 qNVkoNC+76cPljpI+BxS799vdXKGbCKpQJirp3oQ==
X-Google-Smtp-Source: AGHT+IEoRRo3pJqVKagvUXJ/NGdN7mzygWs30fVakmjHnjxX0HLZuTtcJ98wvYjDb7CT/s69D7kRBg==
X-Received: by 2002:a17:903:903:b0:295:9db1:ff4b with SMTP id
 d9443c01a7336-29b6be8b66dmr15673355ad.4.1763701458625; 
 Thu, 20 Nov 2025 21:04:18 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b26fed2sm43384525ad.69.2025.11.20.21.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 21:04:18 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 0/6] Fix Zjpm implementation
Date: Fri, 21 Nov 2025 13:04:07 +0800
Message-ID: <20251121050413.3718427-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x630.google.com
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

From: Frank Chang <frank.chang@sifive.com>

The current Zjpm implementation has the following issues:

1. The address is shifted before obtaining the correct PMLEN value.
2. riscv_pm_get_pmm() does not handle effective privilege mode correctly.
3. mstatus.MPRV does not affect virtual-machine load/store instructions.
4. Sign extension for virtual-machine load/store instructions (HLV.* and
   HSV.*) must be performed when vsatp.MODE != Bare.

This patchset fixes the above issues and also renames
riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm(), as the helper
is only used when checking the PMM configuration for virtual-machine
load/store instructions, rather than for VS/VU modes.

Frank Chang (5):
  target/riscv: Add a helper to return the current effective priv mode
  target/riscv: Fix pointer masking PMM field selection logic
  target/riscv: Fix pointer masking for virtual-machine load/store insns
  target/riscv: Rename riscv_pm_get_virt_pmm() to
    riscv_pm_get_vm_ldst_pmm()
  target/riscv: Fix pointer masking translation mode check bug

Yong-Xuan Wang (1):
  target/riscv: fix address masking

 target/riscv/cpu.h         |   5 +-
 target/riscv/cpu_helper.c  | 164 +++++++++++++++++++++++++++++--------
 target/riscv/internals.h   |   8 +-
 target/riscv/tcg/tcg-cpu.c |   4 +-
 4 files changed, 138 insertions(+), 43 deletions(-)

--
2.43.0


