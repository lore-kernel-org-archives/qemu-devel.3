Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638B7D3F07A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl6x4-0007Qf-6c; Wed, 28 Jan 2026 09:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vl6x0-0007Q6-9h; Wed, 28 Jan 2026 09:55:22 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vl6wt-0000JD-3s; Wed, 28 Jan 2026 09:55:18 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAH7iZFI3ppf552Aw--.21998S2;
 Wed, 28 Jan 2026 22:55:01 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.118.162])
 by mail (Coremail) with SMTP id AQAAfwBXse5DI3pp8lwXAA--.26104S2;
 Wed, 28 Jan 2026 22:54:59 +0800 (CST)
Message-ID: <b5d6c6d7-5a85-4c8a-907b-7c12a2c88ae6@phytium.com.cn>
Date: Wed, 28 Jan 2026 22:54:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] tests/qtest: Add RISC-V IOMMU bare-metal test
 using iommu-testdev
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1769600111.git.chao.liu.zevorn@gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <cover.1769600111.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXse5DI3pp8lwXAA--.26104S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAJBWl5G-QHbAADsa
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWw1Utr13tryDCr48Wry8Zrb_yoW5ZryrpF
 yaka4Sy3WxtF1xJw13Xw1UGr1FgFs7CF47Ar13Jr1rXr90yr18tr1Dt348tr9xJ3y8XFyU
 Zw4jkF4kCr4Yy3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Chao,

On 2026/1/28 20:09, Chao Liu wrote:
> Hi,
>
> This patch series adds a bare-metal qtest for the RISC-V IOMMU using the
> iommu-testdev framework. The test exercises address translation paths
> without requiring a full guest OS boot.


Thanks a lot for working on this and for sending the series.

It's great to see iommu-testdev being used so soon — it’s only been a 
week since it was added, and you already have a nice RISC-V IOMMU 
translation test based on it.


Best regards,

Tao


>
> Motivation
> ----------
>
> The existing RISC-V IOMMU qtest (riscv-iommu-test.c) focuses on PCI device
> enumeration and register-level validation:
> - PCI configuration space verification (vendor/device ID)
> - Register reset value checks
> - Queue initialization procedures (CQ/FQ/PQ)
>
> However, it does not test the actual address translation functionality.
> This new test fills that gap by using iommu-testdev to trigger DMA
> transactions and validate the IOMMU's translation logic.
>
> Comparison with Existing Test
> -----------------------------
>
> | Feature               | riscv-iommu-test.c | iommu-riscv-test.c (new) |
> |-----------------------|--------------------|--------------------------|
> | PCI config            | Yes                | No                       |
> | Register reset        | Yes                | No                       |
> | Queue init            | Yes                | Yes (via helper)         |
> | Bare translation      | No                 | Yes                      |
> | S-stage (SV39)        | No                 | Yes                      |
> | G-stage (SV39x4)      | No                 | Yes                      |
> | Nested translation    | No                 | Yes                      |
> | DMA verification      | No                 | Yes                      |
> | Uses iommu-testdev    | No                 | Yes                      |
>
> The new test provides:
> - Device context (DC) configuration and validation
> - SV39 page table walks for S-stage translation
> - SV39x4 page table walks for G-stage translation
> - Nested translation combining both stages
> - FCTL register constraint validation
> - End-to-end DMA verification
>
> Note: The current implementation only supports SV39/SV39x4. Support for
> SV48/SV48x4/SV57/SV57x4 can be added in future patches.
>
> Testing
> -------
>
> QTEST_QEMU_BINARY=./build/qemu-system-riscv64 \
>    ./build/tests/qtest/iommu-riscv-test --tap -k
>
> Question for Maintainers
> ------------------------
>
> The existing riscv-iommu-test.c and the new iommu-riscv-test.c serve
> complementary purposes. Would it be beneficial to merge these two tests
> into a single source file for easier maintenance? This would consolidate
> all RISC-V IOMMU testing in one place while preserving both the
> register-level and translation-level test coverage.
>
> Thanks,
> Chao
>
> Chao Liu (2):
>    tests/qtest/libqos: Add RISC-V IOMMU helper library
>    tests/qtest: Add RISC-V IOMMU bare-metal test
>
>   MAINTAINERS                          |   2 +
>   tests/qtest/iommu-riscv-test.c       | 279 +++++++++++++++++++
>   tests/qtest/libqos/meson.build       |   2 +-
>   tests/qtest/libqos/qos-riscv-iommu.c | 400 +++++++++++++++++++++++++++
>   tests/qtest/libqos/qos-riscv-iommu.h | 172 ++++++++++++
>   tests/qtest/meson.build              |   5 +-
>   6 files changed, 858 insertions(+), 2 deletions(-)
>   create mode 100644 tests/qtest/iommu-riscv-test.c
>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h
>
> --
> 2.52.0




