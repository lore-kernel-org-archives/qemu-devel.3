Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10CBCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 11:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vERDP-0007Kc-Ed; Thu, 30 Oct 2025 07:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vERDN-0007KN-5W; Thu, 30 Oct 2025 07:53:13 -0400
Received: from [115.124.28.43] (helo=out28-43.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vERDC-0000Bh-IB; Thu, 30 Oct 2025 07:53:10 -0400
Received: from 192.168.71.4(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.fB-J3GO_1761824913 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 30 Oct 2025 19:48:35 +0800
Message-ID: <dbbdc597-9b4d-4dd3-8143-821ac5d82a3a@zevorn.cn>
Date: Thu, 30 Oct 2025 19:48:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dbarboza@ventanamicro.com
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 zhiwei_liu@linux.alibaba.com
References: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
Subject: Re: [PATCH v3 0/4] hw/riscv: Add Server Platform Reference Board
From: Chao Liu <chao.liu@zevorn.cn>
In-Reply-To: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.43 (deferred)
Received-SPF: pass client-ip=115.124.28.43; envelope-from=chao.liu@zevorn.cn;
 helo=out28-43.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

On Wed, May 28, 2025 at 05:01:29PM -0300, Daniel Henrique Barboza wrote:
>Hi,
>
>This is my attempt to ressurect the Server SoC Platform reference work
>that has been buried for an year. The last posting was made an year ago
>[1]. 
>
>Most of the changes were made due to upstream differences from one year
>ago. Patch 1 is an example of that.
>
>In patch 2 (former 1), the main difference is the new CPU is rva23s64
>compliant. This wasn't possible in May 2024 because we didn't have this
>support back then.
>
>Patch 3 consists mostly of code base changes rather than functional
>changes. There was a discussion about whether we should supply fdts in
>this machine back in the v2 review [2]. The answer is yes: machine mode
>requires fdt to work, and we want to be flexible enough to generate our
>own fdt instead of relying on EDK2 to supply them. Note that we can also
>supply an EDK2-generated fdt via command line, bypassing the fdt created
>by QEMU, if desired.
>
>Patch 4 adds a riscv-iommu-sys device to the board. This wasn't possible
>back then because we didn't have the required upstream support for it.
>

Hi, Daniel.

Do we have any plans to support virt-io on the rvsp-ref machine in the future?

Recently, I have been using the RISC-V reference platform built on this set of
patches to support running the OpenEuler RISC-V operating system.

I will actively feed back any test results to the upstream.

Thanks,
Chao

