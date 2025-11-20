Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E49CF884C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 12:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM3Yy-0003Oq-LC; Thu, 20 Nov 2025 07:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.semichastnov@syntacore.com>)
 id 1vM3Yw-0003Nu-Lk; Thu, 20 Nov 2025 07:14:58 -0500
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.semichastnov@syntacore.com>)
 id 1vM3Yu-0007Hm-Ht; Thu, 20 Nov 2025 07:14:58 -0500
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id C37181A0004;
 Thu, 20 Nov 2025 12:14:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com C37181A0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1763640886; bh=P2Q7hwyiXX7mlh7Z/UK8BvADLpW9q6378YcSTU7CGa4=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=astkgntwVH9Zq/8UhA0kQaizolZIYiezGOOY8eIzJyTzb8nBBiHBy+VbcyrIJBoz9
 MqlPkOTf4Fzy/qHAEz/uZOrv4+YbalSNfB6LAH5NiqaibdFlSaIT/Rnp8+c3bnwgei
 1lcqnGZSBLWwnVaJCKy/cbQiQpEIxxSQ5+BzQ+qcIZJLnymz2283Kr7ospkKAXwfkm
 Ja0QT/TtBTMNEBk6SqsDx0Fo/WGBdXdD1Krz9AKca2xQzZZU6tB4+RoyPYRB5vuBIm
 TaBFaUW7muXjLckWFvvhyr0TUMikMOg42nLnyksrN4gyhjN+dxBf+Zq/F1kBmmAvFk
 cVVEMh15xdqVA==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Thu, 20 Nov 2025 12:14:46 +0000 (UTC)
Received: from [10.178.119.213] (10.178.119.213) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 20 Nov 2025 15:14:40 +0300
Message-ID: <115a56af-4db1-42ee-9541-8077322207c7@syntacore.com>
Date: Thu, 20 Nov 2025 15:14:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] hw/riscv, target/riscv: initial e-trace support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <alistair.francis@wdc.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>, <palmer@dabbelt.com>,
 <k.semichastnov@syntacore.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Konstantin Semichastnov <k.semichastnov@syntacore.com>
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.178.119.213]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/11/20 11:26:00 #27952687
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/11/20 11:32:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=k.semichastnov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 11/11/25 14:46, Daniel Henrique Barboza wrote:
> Hi,
> 
> In this v2 we're addressing a review comment from Konstantin in patch
> 14. We're also doing changes in the FDT (patch 5) to keep up with the
> changes that the kernel support is making [1].
> 
> I've been thinking about adding partial support for N-trace in this work
> as well. From what I can tell the difference between N-trace and E-trace
> are the encoding of the packages, with everything else staying the same.
> In this case we could add hooks in the code to be ready to support
> N-trace encoding in the future.
> 
> No other changes made. Patches based on current master.
> 
> Changes in v2:
> - patch 5:
>    - changed tr_compat from "ventana,veyron-v2-trace" to "qemu,trace-component"
>    - renamed trace encoder prop handler "cpu" to "cpus"
> - patch 14:
>    - removed updiscon generation in gen_jal()
> - v1 link: https://lore.kernel.org/qemu-riscv/20251002112335.2374517-1-dbarboza@ventanamicro.com/
> 
> 
> [1] https://lore.kernel.org/linux-riscv/20251101154245.162492-1-apatel@ventanamicro.com/
> 
> Daniel Henrique Barboza (16):
>    hw/riscv: Trace Encoder initial impl
>    hw/riscv: Trace RAM Sink initial impl
>    hw/riscv/trace-encoder: add trace start/stop logic
>    hw/riscv/virt.c: add trace encoders and trace ram sinks
>    hw/riscv: add e-trace message helpers
>    target/riscv: add initial trace instrumentation
>    hw/riscv/trace-encoder: write e-trace packets to RAM sink
>    test/qtest: add riscv-trace-test.c
>    hw/riscv/rv-trace-messages.c: add encoded trap message
>    hw/riscv, target/riscv: send trace trap messages
>    target/riscv, hw/riscv: send trace ppccd packets
>    hw/riscv/trace: add format2 msg helper
>    hw/riscv, target/riscv: send resync updiscon trace packets
>    hw/riscv/rv-trace-messages: add format 1 msgs with branch info
>    hw/riscv/trace-encoder: send branches info
>    hw/riscv/trace: update branch bit in sync messages
> 
> Mayuresh Chitale (1):
>    hw/riscv/virt.c add trace encoder and ramsink fdt nodes
> 
>   hw/riscv/Kconfig                              |   5 +
>   hw/riscv/meson.build                          |   2 +
>   hw/riscv/rv-trace-messages.c                  | 373 +++++++++++
>   hw/riscv/rv-trace-messages.h                  |  40 ++
>   hw/riscv/trace-encoder.c                      | 609 ++++++++++++++++++
>   hw/riscv/trace-encoder.h                      |  62 ++
>   hw/riscv/trace-events                         |   9 +
>   hw/riscv/trace-ram-sink.c                     | 263 ++++++++
>   hw/riscv/trace-ram-sink.h                     |  83 +++
>   hw/riscv/virt.c                               | 135 ++++
>   include/hw/riscv/virt.h                       |   2 +
>   target/riscv/cpu.h                            |  11 +
>   target/riscv/cpu_helper.c                     |  26 +-
>   target/riscv/helper.h                         |   6 +
>   .../riscv/insn_trans/trans_privileged.c.inc   |  11 +
>   target/riscv/insn_trans/trans_rvi.c.inc       |  15 +
>   target/riscv/meson.build                      |   3 +-
>   target/riscv/tcg/tcg-cpu.c                    |   5 +
>   target/riscv/trace_helper.c                   |  62 ++
>   target/riscv/translate.c                      |  19 +
>   tests/qtest/meson.build                       |   2 +-
>   tests/qtest/riscv-trace-test.c                | 120 ++++
>   22 files changed, 1860 insertions(+), 3 deletions(-)
>   create mode 100644 hw/riscv/rv-trace-messages.c
>   create mode 100644 hw/riscv/rv-trace-messages.h
>   create mode 100644 hw/riscv/trace-encoder.c
>   create mode 100644 hw/riscv/trace-encoder.h
>   create mode 100644 hw/riscv/trace-ram-sink.c
>   create mode 100644 hw/riscv/trace-ram-sink.h
>   create mode 100644 target/riscv/trace_helper.c
>   create mode 100644 tests/qtest/riscv-trace-test.c
> 
Hi, I am currently working on adding the N-Trace message format, based 
on your v1 patch set. Currently I have supported ProgTraceSync, 
ProgTraceCorrelation, ResourceFull, IndirectBranchHist, 
IndirectBranchHistSync, Ownership messages.

After finishing the internal review and rebasing over the v2 patch set, 
I would like to send it here next week.

Konstantin

