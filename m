Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ABDC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 11:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpmrj-0008Et-5m; Wed, 05 Mar 2025 06:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tpmrg-0008ER-Q2; Wed, 05 Mar 2025 06:24:40 -0500
Received: from out28-124.mail.aliyun.com ([115.124.28.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tpmrc-0006D1-Qk; Wed, 05 Mar 2025 06:24:40 -0500
Received: from localhost.localdomain(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.bl5H9d._1741173860 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 05 Mar 2025 19:24:21 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: lc00631@tecorigin.com,
	alistair23@gmail.com
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, zqz00548@tecorigin.com
Subject: Re: [PATCH v3 0/2] Enhanced VSTART and VL checks for vector
 instructions
Date: Wed,  5 Mar 2025 19:24:12 +0800
Message-ID: <20250305112412.1804-1-lc00631@tecorigin.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <cover.1736130472.git.lc00631@tecorigin.com>
References: <cover.1736130472.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.124;
 envelope-from=lc00631@tecorigin.com; helo=out28-124.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi,

This patchset fixes some bugs in RVV instructions,

can you pull it in the near future please? 

Looking forward to your reply!

--
Regards,
Chao

> 
> Hi, all:
> 
> In accordance with the review, i improved the commit message of patch and added
> the reason for the modification.
> 
> There was no change in the patch content.
> 
> PATCH v2 review:
> https://lore.kernel.org/qemu-devel/61e8f7d8-607a-4d63-b9dd-cfbfc840716e@ventanamicro.com/
> 
> PATCH v1 review:
> https://lore.kernel.org/qemu-devel/CAKmqyKPFYxhK8PANOVzV3FMWxd79wZSJYLWkKOAgEMt_b2KvZA@mail.gmail.com/
> 
> --
> Regards,
> Chao
> 
> Chao Liu (2):
>   target/riscv: refactor VSTART_CHECK_EARLY_EXIT() to accept vl as a
>     parameter
>   target/riscv: fix handling of nop for vstart >= vl in some vector
>     instruction
> 
>  target/riscv/vcrypto_helper.c   | 32 ++++++-------
>  target/riscv/vector_helper.c    | 83 ++++++++++++++++++---------------
>  target/riscv/vector_internals.c |  4 +-
>  target/riscv/vector_internals.h | 12 ++---
>  4 files changed, 69 insertions(+), 62 deletions(-)
> 
> -- 
> 2.47.1
> 
> 

