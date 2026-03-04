Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B312EF8FE1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmEA-0006dx-BT; Wed, 04 Mar 2026 08:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmE8-0006cp-7s
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:24 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmE6-00021z-By
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:23 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82735a41985so4077854b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772630720; x=1773235520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zDGLTpUIHcR8BHwrihB3b3JMuVxUqHS6TYrlzubd//E=;
 b=O9gvegRXRV38VsX0D/UtHMS1+m3C27WbxQdi1/nYhusdXTbZpvXYdNnrAVy6viCXJT
 Aau6GKyhVTpW07dGpU0EsE5L9WWB2oE0qnhnG9z7VvHROQyN698D8hXv6yeMtSEnbtrQ
 OMZ1ifCVHT+BwQhiZMPmGSqNjxcWVCSFGz2rPGGbqeVDYUBJtEnrSB/dqqU1rqfZMrgD
 /yU2pICum3C4fcbPuDQzrYITy8gWF1tA8MMqA/n7EwFVRd3YpGoiLteAb3GN6+nj69Fs
 kzq8qfc26haVhmnkbT+SCc6Dak8BrRn8NS4V5WslnucjK5wa5Yrdc9eMpkgzo7ELdrdu
 DWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630720; x=1773235520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDGLTpUIHcR8BHwrihB3b3JMuVxUqHS6TYrlzubd//E=;
 b=j/1fbuUns/8wqijiubt6rcBX9FXrJGFhbmNDQ34BY5E/fFQ7LaQfSgrADAorYLkHhw
 r6Ddfp0pfKoPgdMOLF6TpPTsfAEnMGIExlont+8vOofhxV2C3xGaT8Y52qW+XcN024zw
 KsSr7b7TjkEcaULSM3+G0wLFyoNJFlmfcbcO9Ab1YH4grYMeBj/KvEDzhubGZs+jzhcM
 5AVvbnelJeNb78vAk5nCiG24T+f34c/H6MeVt0kAB8h0HLt36A13dD3n/aqsE9ssYVYv
 A1rFPpMKXHDcdrerQwK1Yq0dhUTrj0ebUakZg6ONo+kBjwpTV7B2hKVFMkvpL9aqeD1C
 l95w==
X-Gm-Message-State: AOJu0Yw1zW+VRtQQfgcmQp5dYUe2hnUKCZzcSpsT7qzY7ai1tQWsmL0Q
 FAjlG449eHrlajbLzOg4wqTK3JS8HXu7GWbucZ78jUYuSj5dx1UOTHUfZy8vG4xjDRQASnPMA4g
 etc72WmxYb+gV9jlV4lj+10bUH8hXfVSKP9WQKogBd4aLTkHm5ThW8rfKIAEEcnX8geCV08px+a
 Y/COWgeDj0G3u69vIiJVpE4VIlOONwiCVZ2StIBTnFuA==
X-Gm-Gg: ATEYQzzFhApb5vWPuvuea8G7+HCi3/urfhgqBilgldYVmVd0yJDRc+vqAN9Z9yfwOF6
 ZeVXYrDIdOGFoClXk9+DM0aXt+MKq4jhDbG35emixv47GRw4dTVafcQPfYLhkHhptQEc63sidIU
 oHpF5uL7CA23TJcDyGpW/br4CFxtvuV74lQqFIvMMtrNOUgWHxP44WfDpLcZcNVGReqfxXSIKYG
 I5Rg/2LMMtOmupuG5hx/mYMtvalFC6gQS+Bozv6LUA0/weluRNPIWP2tzy1dlkK7c+3yO+QhJUK
 Pqp60m9FNn+U2J72+ALNZyKnvDPK8siNT7PyCZEoJRO0TBAe+It08lb09qSQ1EpGdkBpKAt2Fc/
 gu3gBSfj308gr7VQmQgKkZHWbwjrSgJPXygjVIq5TrgCqvmMskrBvU0vuH19g7bQXKBlYUM2AY/
 ztKet5yw2X8P21J9TYmvcJE7/igSV8/iWtLygt28qc5pGRzcqRiqkbGFEoEJKOafp8PB1pdeIgA
 a4Yh4jjoIEa5IihI0Qd6JzmDRw=
X-Received: by 2002:a05:6a00:2e12:b0:81f:40e5:34b6 with SMTP id
 d2e1a72fcca58-82972b4404dmr2066918b3a.15.1772630719943; 
 Wed, 04 Mar 2026 05:25:19 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db1d6dsm16968505b3a.26.2026.03.04.05.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:25:19 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v4 0/9] Add Zvfbfa extension support
Date: Wed,  4 Mar 2026 21:25:04 +0800
Message-ID: <20260304132514.2889449-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x432.google.com
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

v3: <20260127014227.406653-1-max.chou@sifive.com>
v2: <20260108132631.9429-1-max.chou@sifive.com>
v1: <20250915084037.1816893-1-max.chou@sifive.com>

rnax

Max Chou (9):
  target/riscv: Add cfg properities for Zvfbfa extensions
  target/riscv: Add the Zvfbfa extension implied rule
  target/riscv: rvv: Add new VTYPE CSR field - altfmt
  target/riscv: rvv: Introduce reset_ill_vtype to reset illegal vtype
    CSR
  target/riscv: Use the tb->cs_base as the extend tb flags.
  target/riscv: Introduce altfmt into DisasContext
  target/riscv: Introduce BF16 canonical NaN for Zvfbfa extension
  target/riscv: rvv: Support Zvfbfa vector bf16 operations
  target/riscv: Expose Zvfbfa extension as an experimental cpu property

 include/exec/translation-block.h           |    1 +
 target/riscv/cpu.c                         |   15 +-
 target/riscv/cpu.h                         |    7 +-
 target/riscv/cpu_cfg_fields.h.inc          |    1 +
 target/riscv/helper.h                      |   60 ++
 target/riscv/insn_trans/trans_rvbf16.c.inc |    2 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 1002 ++++++++++++--------
 target/riscv/internals.h                   |    1 +
 target/riscv/tcg/tcg-cpu.c                 |   15 +-
 target/riscv/translate.c                   |   11 +
 target/riscv/vector_helper.c               |  389 +++++++-
 11 files changed, 1097 insertions(+), 407 deletions(-)

-- 
2.52.0


