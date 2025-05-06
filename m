Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BC2C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCI7P-0006I5-OH; Tue, 06 May 2025 09:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uCHpC-0002jW-B2; Tue, 06 May 2025 08:55:06 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uCHp9-0003X0-Ko; Tue, 06 May 2025 08:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CyA3+fiU6bvbv3D+Ecvlt15qfsc5exHj8atZdG8rHdo=; b=JS2pWmSKT6KuYIRR61l3yGD/1/
 8YVDBfTQog+Zhe5zm3WEcVtJvY1IAH9WLucfJNsa9EsyFPZyGcFTTGw/mYlpGpvmjFy9ToWFOzU72
 MpOyHyhh34pX0+GL7b6Mz1Zt+WIIrIosi92JBcqqhcI5MT3yvUuDmAy4kDVvXd27td9hg5BEGF2X0
 n0OYrdZB77oDget7C0jfRA4c+/hLXmI8v7NDzuZSI2CcCLAVe3sM1rWzG7motqM00VHkbklChZVFI
 /a3YKkQz0d6MmQqFRTd7dqEMSz3RhXZNJJVpp/sVchL7NWzGZaNZFiQZLSxEzSOwaGEp6UTmAQahY
 aD9slkOQ==;
Received: from [167.98.27.226] (helo=codethink.office.codethink.co.uk)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uCHWL-0070JL-N1; Tue, 06 May 2025 13:35:37 +0100
From: Roan Richmond <roan.richmond@codethink.co.uk>
To: qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, Roan Richmond <roan.richmond@codethink.co.uk>
Subject: [PATCH 0/1] Add RISCV ZALASR Extension
Date: Tue,  6 May 2025 13:35:02 +0100
Message-ID: <20250506123524.33022-1-roan.richmond@codethink.co.uk>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 06 May 2025 09:13:53 -0400
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

Adds the Atomic Load-Acquire and Store-Release Extension (ZALASR).
This extension is currently frozen, with no changes expected.
The repository for this extension can be found: https://github.com/riscv/riscv-zalasr.

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


