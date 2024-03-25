Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A58FC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 08:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rofmJ-0003XZ-Ct; Mon, 25 Mar 2024 04:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rofmI-0003X4-Ch
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:33:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rofmG-0004Gi-8p
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:33:58 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e0ae065d24so8870525ad.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711355634; x=1711960434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oe3Pwg3DiK9pq96lcSurzf/refZG6bn1kCuxChyxq9g=;
 b=Cfxf/Gk/SOTWHVd1asMlKM7fNOUhajHy86de+Z92PQoEywcXtJxG7grzONSCWdFnKA
 7vxEhhcwQWzQP48nsmH6BPQl+R5ui/b24FTGlMo3R5hIpQQkiR1nv4/MyTYb3Qpfy8JI
 nCnYcJ2gLveVvisXWhBrOZZkStd7M7MxAwVSrN9YSMj3fBXto6RQkACxs+FtoLpTXILV
 I9x6XR67eAkVp1FspuE7irfrM4pRwWkc3PMDwswdOQJumg1NYSrQhhPVibQaftsfn4i1
 dLhg6O4GeGAHrRP2M/8rHov40ay7vEJ+rjfERtSXb5vdLGo4jb2YcflPJ+KjoMS8aphD
 JbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711355634; x=1711960434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oe3Pwg3DiK9pq96lcSurzf/refZG6bn1kCuxChyxq9g=;
 b=BeOrQ+CyKnhPICGgHkjUtSDP3P03y/QUDdLy0kOQfp7lFtuc+aENaKp/kYsz4OIhRH
 OJENxyyVfqv6LNlg+MjZAkengEY9gntQAYAU0Xlnut0H+ggBp05Qh8U4rl5bLldT7CZt
 6vm/522TEQUAtLYBswCfsZ+FBicLNorWfQNmzOusyBVfJ7xZkEsmXiVQwyFrKPKbuY4J
 +zgz4V+eYbTFvd+eZdcJRjbNKOuWFO4t8hEoz97mmsQGNoWg9t/IsFr4SPkQtKTrxenf
 L1gnywEPNprqWGIQ4bxqAEpCwPYYvQ89JTXkDmvKJZAiO/eCBtjZFPzaRWD28or4UT/d
 3nkw==
X-Gm-Message-State: AOJu0YxMlheVMfd97BPN9nok46UHNVsjKisOYVReG7nBMzTnWLS2UIDG
 RKcgpKoM1kUyPcJ4NNCNqrYQsB3cqNe7LRbX/NdRuWzTKjRpJvu34oDD3AJyg2p07lO/8dGzOlj
 e2MDPZvdezrTEQ1NmW59j4ZT/QBxoYR2rM37yoHppbRZ6oo3e73pMOE0+Ati72SE39zccMaL4FE
 NT9Tp9/rgqfJuN4HEHB0XAbgwkJJmvqxOyPJqcJKc=
X-Google-Smtp-Source: AGHT+IEiP5oRyMIyXgcXZNijB/P2vPU3M1T1MOq+CPgNF3zUjzEFrUUVnKJx1k1iE/Grppt8CxhYLA==
X-Received: by 2002:a17:902:784e:b0:1df:fda8:e0ea with SMTP id
 e14-20020a170902784e00b001dffda8e0eamr5439328pln.28.1711355633655; 
 Mon, 25 Mar 2024 01:33:53 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a170902684700b001e0287592c4sm4311269pln.267.2024.03.25.01.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 01:33:53 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>
Subject: [PATCH v2 0/5] target/riscv: Support Zve32x and Zve64x extensions
Date: Mon, 25 Mar 2024 16:33:34 +0800
Message-ID: <20240325083346.16656-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x630.google.com
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

This patch series adds the support for Zve32x and Zvx64x and makes vector
registers visible in GDB if any of the V/Zve*/Zvk* extensions is enabled.

v2:
    Rebase onto riscv-to-apply.next (commit 385e575).

Jason Chien (5):
  target/riscv: Add support for Zve32x extension
  target/riscv: Expose Zve32x extension to users
  target/riscv: Add support for Zve64x extension
  target/riscv: Expose Zve64x extension to users
  target/riscv: Relax vector register check in RISCV gdbstub

 target/riscv/cpu.c                      |  4 +++
 target/riscv/cpu_cfg.h                  |  2 ++
 target/riscv/cpu_helper.c               |  2 +-
 target/riscv/csr.c                      |  2 +-
 target/riscv/gdbstub.c                  |  2 +-
 target/riscv/insn_trans/trans_rvv.c.inc |  4 +--
 target/riscv/tcg/tcg-cpu.c              | 33 ++++++++++++++-----------
 7 files changed, 30 insertions(+), 19 deletions(-)

-- 
2.43.2


