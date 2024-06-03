Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E761C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0pC-0004kz-OD; Mon, 03 Jun 2024 02:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sE0p7-0004g9-B1
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:05:37 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sE0p5-0008Br-Hm
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:05:37 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c1ef9b95acso1390905a91.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 23:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717394731; x=1717999531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8rxGb8yr1xR46RfOMNs4eCoE/qowlyeVm83wGnEZPA=;
 b=l0WScKmi0DIHpSVl7lpJ81RYIumPtOYSxChkPmRm8Gh0NJdufBhw65tbgfaueoaSW8
 My5ozWxkZvmxvcEOcM3aGUyv3ZgipJFbjX0dI4cnVHggaH09fSdP1JBx7MZn0Wdf0FE/
 klkLjgbJQiHRslQSGNnSH6wAh79aMHESsKqXNXRNLiOct34BcTqL6rryH8gfwJP1NbT6
 V+jDYGU/UMArXoIpkzGxh5+bptHNct4bo2xANkDn3zHDDrlBr4g8fbPxSP0fjkrOu0DP
 q3hyASsEM5iKVNRX+pijrr4X0Y21zJFL+wr5osxuvFypaM3xqrMYRo8/h1sUY2PpGLFJ
 0HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717394731; x=1717999531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y8rxGb8yr1xR46RfOMNs4eCoE/qowlyeVm83wGnEZPA=;
 b=txylqeZPjCX736nMyqCJFsG4doGw3JKDi840NSNAWAXGPW3kY+JOOgXGq+h9VXjQs6
 6oCjJjgJEFOYDtbkRav6eDDDNSwaFegTJWFOfI7aFOdRYQ6isjCcSMU0FwLY8q5uqrhp
 EpZtEw/jyTwminB3rGEIEChRXXsG6ES3qyjxdSBczU1TZDDCXHFBhd/DnPsYxts1xaGr
 nnRYTWljZrLHvsrN7azZ1xCu8MG4XU8WIDYKlHYpSkd0fzGOJJDhBclphitmZGYPFj84
 6P9WYQmso7CZmEn4iCuQQrU/aTDtCUlg0b4q+dfprGTH02GqjU7+lYjPCLUESfIdMQmq
 PtpA==
X-Gm-Message-State: AOJu0Yzd6NVsADGwdyeU7CSO8AnP4gqZODvsqZEwcsB7osQ6qYRWCbTq
 Ou7Ub0OMGEtxdhWZCW2kxy6oBEzXxp1jyqv/PCfO/7euEtDsXWqa2D9jBW3nIGGdjgwVQxw6UQC
 Zn1Xib+yPSdjyCEBnMKeTYdrWGfb/V3hafK/rHUsO5bBUgO75Ke9DADCKDKRUcOcoo+7SosBk0E
 W4fFh6Fj9HnbCYFSXFe+2oS0kJTZqdp8mBNgm6z2s=
X-Google-Smtp-Source: AGHT+IHP8V3hyMkTCKVyRE9B22PY/tcsaeL4jk+KA1FkYom4xh4eTUR1TAenSXWEpzUpS2Tx9unaKw==
X-Received: by 2002:a17:90b:4b8c:b0:2b6:208c:2aee with SMTP id
 98e67ed59e1d1-2c1c4453885mr10868126a91.20.1717394730955; 
 Sun, 02 Jun 2024 23:05:30 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a77afa1fsm7149291a91.42.2024.06.02.23.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 23:05:30 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 0/6] Introduce extension implied rules
Date: Mon,  3 Jun 2024 14:05:16 +0800
Message-ID: <20240603060522.2180-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1033.google.com
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

Frank Chang (6):
  target/riscv: Introduce extension implied rules definition
  target/riscv: Introduce extension implied rule helpers
  target/riscv: Add MISA implied rules
  target/riscv: Add standard extension implied rules
  target/riscv: Add Zc extension implied rule
  target/riscv: Remove extension auto-update check statements

 target/riscv/cpu.c         | 396 +++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h         |  17 ++
 target/riscv/tcg/tcg-cpu.c | 233 +++++++++++-----------
 3 files changed, 531 insertions(+), 115 deletions(-)

--
2.43.2


