Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8DEC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 06:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEkBy-0000o0-K3; Wed, 05 Jun 2024 02:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkBx-0000nI-El
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:13 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkBu-0007Bo-P9
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:13 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6c4926bf9bbso3442733a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 23:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717569129; x=1718173929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Vi9flPZ/5mcVO9gcD0Cmk5m90JyfmhcRz13qooMoDA=;
 b=X2k+79Afcn9c4+ZCss8B6sudRqNTvmnug9a1KwX1lIZl1OCbGxnyu4EqQ+nSr8Hovz
 NwuvxE3JOAUj+LdQme+GXrcWgs/i4Wn3dr4RkNf/C2VZpY+4qsBWhJ7HmtdZWyCFHEoj
 AZSAoG1z2uimisFwDITmpOabHEACPvPSfAH4NvDs8WEum41M5kRt51Um5zC2xXGLtloP
 zt9Jj1FZPhyTcCNP07/booEZ79AWymmjaYcTyE2EAWDpAi6OFmNATw775BPCbEZ5ioBP
 ul4PyMFPpVpzuH/kbLsqVnBqc7iuAxEucz/J3ex8XZlNLezGQD269SSVn5TOu9W7qJ60
 n/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717569129; x=1718173929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Vi9flPZ/5mcVO9gcD0Cmk5m90JyfmhcRz13qooMoDA=;
 b=jedKbDtgZmGGTQDgTsNRJst/teKwaz3NlMh/kp2vxT8R34tMr7HSN22MIbjAUssEr0
 F/elfcTLa0LzKqKMBwP4oLvWGnc45RFXGn3YqMT+jdr+SbSyq9sTkn17C+s2zXhYo80y
 wGtJ5n/VrvuP3bkfaDhajEqPrp+SyyluO0wqYcnqHdwxcKzBk1MHXQ4CAl7hIW3/VJFl
 Bg3L0VdK2XVTxEiwzoesqqEbbRyCvCXqOhWVmTY/D0ty2pKas/5clzaM8XdIQ0T/Efwp
 U86fGpNr+FGFDGYPFMicnkHgI7+/Lrdsf8/sqZq5J+P8dch0t/sC41WGsSLv2q9rqBgX
 hZng==
X-Gm-Message-State: AOJu0YyxKwaQKHy54L9gknFPyMh26GW9gDfdI7y0041M57QTqudPjoqq
 tXgkWl5pGV00Yl1cUOm4jWeqWWL8hQYGIRIpPVhajfehOoybyW2bKI5A8FniR+PjCJ2wGyfTRpB
 nVMLpEbuGCa1eMz7x5HLS81EbALYsC89ey9mdw6LTuYzFaFCUcmtXuUqeH8j7oMDHotiBbwuqfY
 5BZYoAPZ8JdP2ZxuzqIfkWFoRJLH4oh5JKVpXcOUkVYw==
X-Google-Smtp-Source: AGHT+IEoN8msu0LPRA9eKI7YSyVm8ZP/8eqgvBMs+ZAQP0MrXla99LWwFBlhsCQ7xsKf+LEGiJT6Qw==
X-Received: by 2002:a05:6a20:6a2b:b0:1af:d44c:cfc4 with SMTP id
 adf61e73a8af0-1b2b6ee62efmr2264186637.17.1717569128466; 
 Tue, 04 Jun 2024 23:32:08 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632356c84sm94819725ad.76.2024.06.04.23.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 23:32:08 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH RESEND 0/6] Introduce extension implied rules
Date: Wed,  5 Jun 2024 14:31:48 +0800
Message-ID: <20240605063154.31298-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 target/riscv/cpu.h         |  18 ++
 target/riscv/tcg/tcg-cpu.c | 238 +++++++++++-----------
 3 files changed, 537 insertions(+), 115 deletions(-)

--
2.43.2


