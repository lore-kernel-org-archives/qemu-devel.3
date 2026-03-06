Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9ABF5140F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPLC-00037B-RX; Fri, 06 Mar 2026 02:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLB-000371-0L
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:17 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPL7-0007fv-0S
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:16 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-829781b2b01so1634960b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 23:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772781071; x=1773385871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pPR+uI8lKC3Rpqp/0VWbZPQWXrEe3XZ4PUCkc6MXVcs=;
 b=CXJFUH2E5g69rWIzXjaVWcjtoKnIVO132fdOEaDdX8JO6LA1htpSInFC7NMjRDfWhF
 5sTbfWvFkjFKzBGDbb9GHFkoOX32VnNKpXl/AC3yQ4eWefLq5ONUYOyS962vdXwWMjpf
 6lE2NauYsL+tTIalhAHJqceBazilLcycpWTnx9grZjuvn7QZ2Tfv7khvjcjF48IepT2t
 fCHcjMp2FyKSpwiTr6ZKb4FN3hyR+NQallH8bZ6uxFPE0etI7HEslUYUfigBAQcsoFTA
 z/d2uVHt5X6aTQNW2E52r45nQJCB3l5QQJMmyzSaj0YK/9mAftcGW+ZNUSo42oIpZuks
 +W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772781071; x=1773385871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPR+uI8lKC3Rpqp/0VWbZPQWXrEe3XZ4PUCkc6MXVcs=;
 b=mXEbLdOZZDpv7FvVammmEmDFmyrDqYbkRoQxS2rjy2vDQI/nwWpAo5YmSDNVAl0wmV
 0rnGWv22HwsMGqnMGSjbWUlxKWkkC3WDkxxYHmeeeQGoAfRDbPcQp7jl0S7+6t0af8lp
 dzDtwXrcvyJEVOOQV3GRtOO/W3eMS1J8WbmvFu75GBcuacy6HTrgj19cu3tRQM9CIXkS
 npfNz14QW/VoBL4E/VaddDpQUJTeYAEabb3zXGgTL89ReW6OkqaASpF4xrqh52AH4gJF
 U0Xays2XlW4yU6MiIGld4nr2fmXGODxhVK+iJfgYHxOCFDMKgL/+Sd2cvWV1ZL2BS/yE
 Hbmw==
X-Gm-Message-State: AOJu0YxRvfdTmmShUwkcwR/12DoqiJfqK+PtLaKouOh51N494/5VIC/u
 /NSses/Ybpf/VqxrQizaMBXoX1jmLPaz1fj6848mSm/D4r2m+n8J228PU9ggpJ9VJViFPZ1R4o0
 r3LkHwQKYJjPIsJ/fjCsx1kdbBL3HceMdQS9g1DvbfqDp4GoYRefpajM7qUhZ/dk72/14Azyz0q
 ZcNHjPsvYF5Swm0E9dC1jqRvkiG34ifr+SeiybKZrsJjYp
X-Gm-Gg: ATEYQzwoub2+keP4mV7vZgv2gY30+bKzZRvdb8AHGzNoTXuDWm4P8RbPc1x0oMGpHCM
 o5vwewrW0qUwv2AI9fKozEKTs9fdUBTN6GickltPpJ2B3JDUg8fNRl///cSmrz9AtB/iQ7pajun
 cOcMVKMvoTlMlPeccrxQm2g3ehGCEJVNB2gdReByUwFcXTCv/CtkvtWWOW0/Ae/iI28u02N3QbI
 aROPq7H45LTk5SwLVUfJUEmorze7yq7eE9QHICS9SFMTJ78qwVMwuRkBrhevPPJHSqNQs39Cb6p
 qKR2yh7Zgcl8rlfcOqwuJsnp47U2byJ1VaM4RVtbAGVC1Qd/0Xm1xTI5zEa5f/t5bsgzZERnGBg
 z4x68+R4HMSEhdZFYtodhh3MtgxIqh5P5GI/RYkHBsyKNSbHAkPsgwsdcHbM/y189A7O1HCNykL
 YbKgB592aTahybFe7MH9p5OnsIdXPb/6QkLDIiHZWFraAWsU/RqHDRRfX52QArRVj8H/72zeTdn
 uZOafejMcrDa4kmSGfYXR4mNbc=
X-Received: by 2002:a05:6a00:1aca:b0:829:88e7:c89e with SMTP id
 d2e1a72fcca58-829a2d6ef96mr1050124b3a.9.1772781070403; 
 Thu, 05 Mar 2026 23:11:10 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a4636c74sm956093b3a.12.2026.03.05.23.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 23:11:10 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v5 0/9] Add Zvfbfa extension support
Date: Fri,  6 Mar 2026 15:10:55 +0800
Message-ID: <20260306071105.3328365-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
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

This patch series adds support for the RISC-V Zvfbfa extension, which
provides additional BF16 vector compute support.

The isa spec of Zvfbfa extension is not ratified yet, so this patch
series is based on the latest draft of the spec (v0.1) and make the
Zvfbfa extension as an experimental extension.

The Zvfbfa extension adds a 1-bit field, altfmt, to the vtype CSR in
bit position 8.
The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.

Specification:
https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfbfa.adoc

Changes in v5:
- Fix typo in patch 1/5/8
- Remove unnecessary do_bf16_nanbox

Changes in v4:
- Rebase on riscv-to-apply.next (commit 21101a7)
- Update commit message of patch 2 (target/riscv: Add the Zvfbfa
  extension implied rule)
- Update checking flow of illegal ALTFMT SEW patterns at patch 3
  (target/riscv: rvv: Add new VTYPE CSR field - altfmt)

Changes in v3:
- Rebased on riscv-to-apply.next (commit f66f234)
- Fix typo in v2 patch 5 commit message

Changes from v2:
- Removed RFC designation from the series
- Updated commit message for patch 3 (VTYPE CSR field -
  altfmt) to clearly explain:
  * VEDIV field removal (bits 8-9) since EDIV extension is not
    planned to be part of the base V extension
  * ALTFMT field addition at bit 8
  * RESERVED field change from bit 10 to bit 9
- Added new patch 4: Introduce reset_ill_vtype helper function to
  consolidate illegal vtype CSR reset logic

v4: <20260304132514.2889449-1-max.chou@sifive.com>
v3: <20260127014227.406653-1-max.chou@sifive.com>
v2: <20260108132631.9429-1-max.chou@sifive.com>
v1: <20250915084037.1816893-1-max.chou@sifive.com>

rnax


Max Chou (9):
  target/riscv: Add cfg properties for Zvfbfa extensions
  target/riscv: Add the Zvfbfa extension implied rule
  target/riscv: rvv: Add new VTYPE CSR field - altfmt
  target/riscv: rvv: Introduce reset_ill_vtype to reset illegal vtype
    CSR
  target/riscv: Use the tb->cs_base as the extend tb flags
  target/riscv: Introduce altfmt into DisasContext
  target/riscv: Introduce BF16 canonical NaN for Zvfbfa extension
  target/riscv: rvv: Support Zvfbfa vector bf16 operations
  target/riscv: Expose Zvfbfa extension as an experimental cpu property

 include/exec/translation-block.h        |   1 +
 target/riscv/cpu.c                      |  15 +-
 target/riscv/cpu.h                      |   7 +-
 target/riscv/cpu_cfg_fields.h.inc       |   1 +
 target/riscv/helper.h                   |  60 ++
 target/riscv/insn_trans/trans_rvv.c.inc | 988 +++++++++++++++---------
 target/riscv/internals.h                |   1 +
 target/riscv/tcg/tcg-cpu.c              |  15 +-
 target/riscv/translate.c                |  11 +
 target/riscv/vector_helper.c            | 389 +++++++++-
 10 files changed, 1088 insertions(+), 400 deletions(-)

-- 
2.52.0


