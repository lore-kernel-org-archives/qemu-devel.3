Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901FFC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 08:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOuQQ-0003JF-CN; Tue, 10 Jun 2025 04:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uOuQL-0003I1-I7; Tue, 10 Jun 2025 04:33:37 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uOuQI-0002fN-Jg; Tue, 10 Jun 2025 04:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yGw4W3xuyHF1Hv8Nhv5muZ0Yn0n3cIHXQMyUDcCVGP8=; b=hoX2NUbznVZwnZQbc+E/4onuot
 wlzFdXHiy6cTQbvxIRumkeXX4hzzzxQeodnmyrOLD75uVQJAZNrF9aqMY6TY6/Kn6WtBxpSl+zEUI
 2umomzthp7BoIJzClH+1hbXgupNmXcHqmxH+KuMAemJWx5Us7rAzYIEb+NWtibrU9dgHJ1C8cspgX
 GO0KE32t6km0u7dqwYjyV0XSElRAq3YC6OywrtC/noljvwVToioF9kpA0FU6R7p7ujxbv+syNy7zk
 3jgc/ZGhsJHYK5es5weMg4jYf7Q2Gj3VyJd9g1hQrChVabVtHHUsk4fVAioenriGnBwW/LW0dUvgN
 ukoPMWwQ==;
Received: from [167.98.27.226] (helo=codethink.office.codethink.co.uk)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uOuQ1-00FyBH-Ib; Tue, 10 Jun 2025 09:33:17 +0100
From: Roan Richmond <roan.richmond@codethink.co.uk>
To: qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, alistair23@gmail.com,
 Roan Richmond <roan.richmond@codethink.co.uk>
Subject: [PATCH v2 0/1] Add RISCV ZALASR Extension
Date: Tue, 10 Jun 2025 09:32:57 +0100
Message-ID: <20250610083309.992724-1-roan.richmond@codethink.co.uk>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=roan.richmond@codethink.co.uk; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Ping, resending as no responses in over week.

V2:
  - rebased patch onto master branch
  - added check for RV64() for Load Double, as pointed out by Alistair Palmer.

In response to Alistair Palmer (https://lists.gnu.org/archive/html/qemu-riscv/2025-06/msg00010.html):
"Aren't you missing a check to ensure RL is set?"
  - There is no need to check if RL is set, as this is required by Spec for all Store Release instructions. 

Roan Richmond (1):
  Add RISCV ZALASR extension

 target/riscv/cpu.c                           |   1 +
 target/riscv/insn32.decode                   |  10 ++
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 110 +++++++++++++++++++
 target/riscv/translate.c                     |   1 +
 4 files changed, 122 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc

-- 
2.43.0


