Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC75C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 02:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIfvJ-0007Og-LO; Sat, 15 Jun 2024 22:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvB-0007Mn-3Z
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:09 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfv9-0001gu-Eu
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:08 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5bb041514c1so1939554eaf.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 19:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718506025; x=1719110825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IxUHaAMwbJsA105BAP7W4CBk7gREFUPLGQwqLSMI7L8=;
 b=fzRIGoETV2Eu6a80cCRa3giCimGLPsKztzxtdAVXjcgp9yHOoORoWjvYJcTwvn9lSG
 0QIlUwESG/iU3tkc05U3jQ1rOPBuCiYzWeHDWAbXvnmR2hfJzDINun80co0bTPBn8OBt
 SGz3/tWUeDUPiENQOfPp5MW22onh1gGxbbEIXiRKiwciA71e+kxd6tZFAxGabjlK1/8/
 PsZt+fYsPNGyK8nwsVAo3YgqtJ9GWn+RK/QRt6ISOjuM6yO6xsOqEVT/F88VBbNPHKlV
 kaBjq8tuS+3anAANpJvCF/7bK2zkTvaMj3U+e1x62xt2H+K5OXjBnMxQKVL0rwDEeJCV
 fNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718506025; x=1719110825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IxUHaAMwbJsA105BAP7W4CBk7gREFUPLGQwqLSMI7L8=;
 b=tTgr2URICj0yQz11zy4ouZUNgSPJcf82Zc01vFbneYGRcCk0exu+kFC+R8CsKOQyt0
 /xOAD+1LsHwoKKsmcs4yL0Z84ePd7hpwMgUofWmw625qUhbtpdG0ZiaFpdk3hh9A5YAh
 O9HVwb41GX4BRfR304LPTKVtoYzhFvQliusVCyCrgKn6gAIKguigssa0vV8UfN8a8Sqs
 ha3r/BUIO4OyWTdjk6w3nIRgh5qxzjIQHk/iVegWoWYud9msd3ieHJIo4uFMishGWINO
 wTdyvZoL1bQes3O2LXTKfqcbXONisTNlVrEDeEvcK5kh+8w25WZ9DbuERQ7ZM4odUvUj
 awcQ==
X-Gm-Message-State: AOJu0Yy8fhFC+31qhlV3292aZedNCG0XlQ/qx4bcbhzaMaEYH72hRV4U
 5XZ24eIDXe+6RSHvtS0Y2eGKxQDnjBK1m7PZmne7om5U5CjsyumzGoHkgqDMYDvy+hEbiVJXJGi
 5OZgaP49YEfsuoQgfUeXgu962G7eqhhigNSiJV/Woj2hBa+hNgZI1SdGaeXsDKncLsFpLlouPGY
 B+onGDQps4zZtdPVces924Cc17zz8T2VLJ3mCabWU=
X-Google-Smtp-Source: AGHT+IFbqJxpn2/9bv7/7sI1lGNCApHDGvPj9M0Qn7LvjRy8HKlRShDXLIX1rgh8iEPSL9R8cDM7sQ==
X-Received: by 2002:a05:6358:249b:b0:19f:4691:7db9 with SMTP id
 e5c5f4694b2df-19fa9ddbf10mr789102755d.5.1718506024664; 
 Sat, 15 Jun 2024 19:47:04 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e7ca78sm56258705ad.106.2024.06.15.19.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 19:47:04 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 0/6] Introduce extension implied rules
Date: Sun, 16 Jun 2024 10:46:51 +0800
Message-ID: <20240616024657.17948-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=frank.chang@sifive.com; helo=mail-oo1-xc31.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Currently, the implied extensions are enabled and checked in
riscv_cpu_validate_set_extensions(). However, the order of enabling the
implied extensions must follow a strict sequence, which is error-prone.

This patchset introduce extension implied rule helpers to enable the
implied extensions. This also eliminates the old-fashioned ordering
requirement. For example, Zvksg implies Zvks, Zvks implies Zvksed, etc.,
removing the need to check the implied rules of Zvksg before Zvks.

The idea [1] and the implied rules [2] are referenced from LLVM.

[1] https://github.com/llvm/llvm-project/blob/main/llvm/lib/TargetParser/RISCVISAInfo.cpp#L875
[2] https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/RISCV/RISCVFeatures.td

Changelog:

v2:
  - Remove enabled bitmask from user-mode QEMU as there's no good way
    (e.g. mhartid) to distinguish the SMP cores in user-mode QEMU.
  - Use qatomic API to access the enabled bitmask to prevent the
    potential enabled bit from being cleared by another hart.

Frank Chang (6):
  target/riscv: Introduce extension implied rules definition
  target/riscv: Introduce extension implied rule helpers
  target/riscv: Add MISA implied rules
  target/riscv: Add standard extension implied rules
  target/riscv: Add Zc extension implied rule
  target/riscv: Remove extension auto-update check statements

 target/riscv/cpu.c         | 396 +++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h         |  25 +++
 target/riscv/tcg/tcg-cpu.c | 244 ++++++++++++-----------
 3 files changed, 546 insertions(+), 119 deletions(-)

--
2.43.2


