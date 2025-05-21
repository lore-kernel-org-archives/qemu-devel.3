Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D86AC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHfcC-0002zx-Cm; Wed, 21 May 2025 05:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uHfc4-0002z0-2q; Wed, 21 May 2025 05:19:50 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uHfc1-0007UX-Pb; Wed, 21 May 2025 05:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YcdQNHhSjqbTUS0stbJYh4pu4yJRwdhDkuaiNSz5I3s=; b=OxyPNsN4DCIXov9y7R/u920xBH
 Llqnln00/949bq8TZbkQnUoH3s7iSSVOQzEIZg9pGQ9m0MOKBj47obndDRwVMUqpnnQrvbFBaFpK7
 j81EWoH4nN1NETwzKW8jVS6F6DdvKs8Agz909rUz9PrAMv5f9nczW0d1hpxP4EXzZJmE66cAawbZN
 S556ICdhjV/FSftFz5hblVERpCFY6LaBwhE/PfG+M7SEsnvEo1N/c6GOmDdfmPusq0CjFmkqhlyxy
 1hZ2mtNJtyj5gNH4/uH/9RZI4DxH4lL+8VYMO+wt7E2Ujcw2i7Y0IqLAANxIGkaFsCY9pGNnrgIOw
 gRuSmb9g==;
Received: from [136.226.167.112] (helo=codethink..)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uHfbr-00FG11-Av; Wed, 21 May 2025 10:19:36 +0100
From: Roan Richmond <roan.richmond@codethink.co.uk>
To: qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, Roan Richmond <roan.richmond@codethink.co.uk>
Subject: [PATCH 0/1] Add RISCV ZALASR Extension
Date: Wed, 21 May 2025 10:17:54 +0100
Message-ID: <20250521091921.180094-1-roan.richmond@codethink.co.uk>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=roan.richmond@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping, resending as no comments in over 2 weeks.

Roan Richmond (1):
  Add RISCV ZALASR extension

 target/riscv/cpu.c                           |   1 +
 target/riscv/cpu_cfg.h                       |   1 +
 target/riscv/insn32.decode                   |  10 ++
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 109 +++++++++++++++++++
 target/riscv/translate.c                     |   1 +
 5 files changed, 122 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc

-- 
2.43.0


