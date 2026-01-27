Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418C4D1951B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 01:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkY6l-0000y6-LY; Mon, 26 Jan 2026 20:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6Y-0000vH-AS
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:42:55 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6V-0008B3-EP
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:42:53 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a12ed4d205so33866005ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 17:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769478169; x=1770082969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RUwp6jUWzIamU03Rf2ZMxjvrIZbWunR5LSETcA1SY3g=;
 b=kiSxiTVbLMhAIDI7NwY1B/M75JV2poDTrF4Leudug51wuYCtvawU9FlBBkUFS5vu9I
 o28gWsz3vzGs2xTFSlPzBLZFsOhwSHL6GYaPRFbHpg1qUBD+wrP7A7R619EOq4bjhFFb
 I59hMM2hiYzRAvAWPdez/O/G3lXitF6vOk1UvTXjhfKDt8VgtXwcq5hEq/sKaXKQwxQX
 pmv3frQjWWWnIALygxa4oe+4em8ag08D/1xhOk6xmdcsq44MQq+mU4mqPevLTwTgD2vd
 Hx27QqMRyEOBFkvZqP3Xckeful6m5H8WrRowo8U8/ZkZjeZH40SWaxYsgPGy4EJRWMjp
 LXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769478169; x=1770082969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUwp6jUWzIamU03Rf2ZMxjvrIZbWunR5LSETcA1SY3g=;
 b=gK73McF34eKh9tFA+jojEfhE8YmYMV6cJWoNEwACOnXnp4ZHL5RIeiwKwOsxbOYyNC
 z71JzB34uBXcWsYnBx1yJynsGRMAqu4BMpXBVqFJaqBCRt7lUbchiGKCI1W1PRxaw6He
 nOLMRoYMpO4ssxG2uC7khW55mL+HgenT0XrhEtJCKBgPcXz+uEcnkrKWOAS0QEWkqxP0
 Acw57qofC9ybPHi3rr+MozO91OQV/0JJS256JG8tPirJt59gCnHxE/2LXhTq2qgy0IwD
 Z/63HLJz5a8NeAzFOScyG+d9Ownponlmsq92CDOsR+BoV4P8ZUrQ3SdvUlVQd6ZgFhMd
 +CUw==
X-Gm-Message-State: AOJu0Yy9kfQKA856pvy1bviwoqmtx4+NES3nMz6xnWTm8PIREoy1qhgS
 AjwDR5vUE0s6WRKFhwlymXwFX25N1qUjO5x0XhPUobqBaxwjQp1GPoNKzL6Zg0oFJlNLGh8fQLe
 2uM93e+7vj8CUZM/ovHjpe0Lp2emqPTPCIesc91XzvKeVBiggV3HTfDzCqMP2MY82d5LBRm+NzA
 FPcpWNAZWpZIgU3hG/7hsnPe+5BzWvLaUSqw1W04F/2w==
X-Gm-Gg: AZuq6aLDxIp5wH6+kyhDO1l897Ss+HSukp33TWRih3yxow4TYxUt0ePaaP+0/mD7Y70
 Fy2Amol3tBeIwb9XUsE8HdZXwUd14XY+KoMLSMW2qnvuSnu4muK21Z6aOeqmzvZwIABnSPMA0br
 ix17ckz2+fbNhEiIP85/IY0wZsATOOI6dLy+GjPjufPpxpsQJ7ai596eNXFFzeGIeWhyXkDT4it
 BE3rw27dgpb/JEF0rIXI3Ia52myllUoa7Cnpi/LImhTMz7aZgvWWw1PWje655MxylffmsIxhpY8
 DJpQnraVplv+iNc8MLpGybE6c3IpEIqLS/DWMtXdFTw1SHeR9JJkG1pRErDWnZsMyLGHaC/CcoG
 L/i0REmO4Ox8PQFWasTV5ktZ1zLcYWqQmCGgcpSLbtgw3DDDclkeVu7mrVWgf7zmFy6fZIZTIAS
 rDC+mGokpoers1fA/bz7kSBt/m5I5JKzyP8hRW2xHUWBUr7AESBcONELbj13h5N9FH3+NAUAIO7
 X2EKAMME2qgKYA=
X-Received: by 2002:a17:903:3d05:b0:2a7:9b6e:33df with SMTP id
 d9443c01a7336-2a870dd5732mr1433895ad.35.1769478169376; 
 Mon, 26 Jan 2026 17:42:49 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f6129426sm660121a91.7.2026.01.26.17.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 17:42:48 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 0/9] Add Zvfbfa extension support
Date: Tue, 27 Jan 2026 09:42:18 +0800
Message-ID: <20260127014227.406653-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x636.google.com
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

The isa spec of Zvfbfa extension is not ratified yet, so this patch series
is based on the latest draft of the spec (v0.1) and make the Zvfbfa extension
as an experimental extension.

The Zvfbfa extension adds a 1-bit field, altfmt, to the vtype CSR in
bit position 8.
The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.

Specification:
  https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfbfa.adoc

Changes in v3:
  - Rebased on riscv-to-apply.next (commit f66f234)
  - Fix typo in v2 patch 5 commit message

Changes from v2:
  - Removed RFC designation from the series
  - Updated commit message for patch 3 (VTYPE CSR field - altfmt) to
    clearly explain:
    * VEDIV field removal (bits 8-9) since EDIV extension is not
      planned to be part of the base V extension
    * ALTFMT field addition at bit 8
    * RESERVED field change from bit 10 to bit 9
  - Added new patch 4: Introduce reset_ill_vtype helper function to
    consolidate illegal vtype CSR reset logic

v2: <20260108132631.9429-1-max.chou@sifive.com>
v1: <20250915084037.1816893-1-max.chou@sifive.com>

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
 target/riscv/vector_helper.c               |  379 +++++++-
 11 files changed, 1087 insertions(+), 407 deletions(-)

-- 
2.52.0


