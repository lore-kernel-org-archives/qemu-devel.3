Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65932C4452B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 03:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmNNe-0006GP-ND; Tue, 21 Jul 2026 23:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmNNY-0006F8-0Y; Tue, 21 Jul 2026 23:12:17 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmNNS-0002e9-AO; Tue, 21 Jul 2026 23:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784689901; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=0GSVpOzjszkcYJiOltwo6Tb00f2TN6wYyQB1pHWsBic=;
 b=RZTckp5qAogKaokFteEyrdSkQPyel4zAt8mEVM1zXfsgCsKkq3eF8ZxDlyEm78PwPZ/XJOzAjVuZ7D7I5lkSG5I3YLXjPNCZ+I0zWTrtXy1HlE5UMhsrNPLG0OFFeG+ONzi9YN75O1a059kKsqhr4JcNVaI1m+ybn+13lmCidDc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0X7bzWXY_1784689889; 
Received: from 30.166.65.127(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X7bzWXY_1784689889 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 22 Jul 2026 11:11:40 +0800
Message-ID: <db11d478-c0cb-4ca6-b7b4-3f53b281452b@linux.alibaba.com>
Date: Wed, 22 Jul 2026 11:11:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] target/riscv: Implement Smsdid and Smmpt
 extension
To: Alistair <alistair@alistair23.me>, qemu-devel@nongnu.org,
 xiangyi.zeng@linux.alibaba.com
Cc: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, cxx194832@alibaba-inc.com
References: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
 <a568614fb2f7221583bbcc2c67cf7282d50e4d83.camel@alistair23.me>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <a568614fb2f7221583bbcc2c67cf7282d50e4d83.camel@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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


On 7/22/26 8:56 AM, Alistair wrote:
> On Wed, 2026-07-15 at 22:50 +0800, LIU Zhiwei wrote:
>> This patch set introduces support for the RISC-V Smsdid and Smmpt
>> (Supervisor Domain Identifier and Memory Protection Table) extensions
>> v0.4.9(https://github.com/riscv/riscv-smmtt/releases/tag/v0.4.9).
>> Smmpt provides a hardware mechanism for fine-grained memory
>> protection,
>> checked after address translation, which is particularly useful for
>> supervisor-level sandboxing and security monitoring.
Hi Alistair,
> Can you include a link to the upstream submitted patches to use this
> functionality
Xiangyi is currently working on OpenSBI support for SMMPT, and we 
already have an internal implementation in place. We plan to upstream 
the OpenSBI support as soon as possible, and once that is done, I’ll be 
able to include a link here.

Thanks,
Zhiwei
>
> Alistair
>
>> The rfc patch set:
>> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
>>
>> v6->v7:
>>      The implementation is updated from the v0.3.4 specification to
>>      v0.4.9. The main changes are:
>>      1. Update the mmpt CSR number to 0x382 and msdcfg to 0x74E.
>>      2. Update the mmpt register layout: the SDID and PPN field
>> positions
>>         changed and the RV64 PPN is now 44 bits.
>>      3. Rework the MPTE format: the N (NAPOT) bit now lives at bit 2,
>> the
>>         non-leaf NAPOT form is removed, NAPOT leaf entries encode a
>> single
>>         XWR tuple plus a G granularity field, and non-NAPOT leaf
>> entries
>>         hold per-page XWR tuples.
>>      4. Treat XWR=000 as "no access" and a non-leaf entry with N=1 as
>> a
>>         fault.
>>      5. Enforce the Smmpt64 root-table PPN alignment (low 3 bits
>> zero).
>>      6. Rename the fence instructions mfence.spa/minval.spa to
>>         mfence.pa/minval.pa.
>>      7. Drop stale Reviewed-by tags on the substantially reworked
>> patches.
>>      8. Introduce the configurable "smmpt-sdidlen" CPU property.
>>      9. Add disassembly support for the Smmpt.
>>      10. Add bare-metal M-mode system tests.
>>      11. Rebase to master.
>>
>> v5->v6:
>>      1. Use explicitly bit fields extract instead of mpte_union_t.
>>      2. Use the same exception behavior for MPT valiation as PMP
>>         valiation.
>>      3. Use PAGE_* instead of MPT_ACCESS_* as they have same value.
>>      4. Use address_space_*_le instead of address_space_* for SMMPT.
>>      5. Only print SMMPT address check log when SMMPT is enabled.
>>      6. Add implied rule for SMMPT as it depends on SMSDID.
>>      7. Rebase to master.
>>
>> v4->v5:
>>      1. Rebase to master.
>> v3->v4:
>>      1. Add missing review tags.
>> v2->v3:
>>      1. Fix build error in patch 2.
>>      2. Rebase to master.
>>
>> rfc->v2:
>>      1. When ext_smmpt is false or BARE mode, make other fields in
>> mmpt
>>         CSR zero.
>>      2. Add patch 5 to fix smrnmi ISA string order.
>>      3. Fix patch 6 smmpt and smsdid ISA string order.
>>      4. Make smmpt and smsdid experiment extensions.
>>      5. Add review tags.
>>
>> LIU Zhiwei (11):
>>    target/riscv: Add basic definitions and CSRs for SMMPT
>>    target/riscv: Add smmpt-sdidlen property for the mmpt SDID field
>>    target/riscv: Implement core SMMPT lookup logic
>>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>>    target/riscv: Implement SMMPT fence instructions
>>    target/riscv: Fix smrnmi isa alphabetical order
>>    target/riscv: Add disassembly for Smmpt instructions and CSRs
>>    target/riscv: Enable SMMPT extension
>>    target/riscv: Add system test for SMMPT extension
>>    target/riscv: Add system tests for Smmpt52 and Smmpt64
>>    target/riscv: Add system test for Smmpt34
>>
>>   disas/riscv.c                                 |   9 +-
>>   target/riscv/cpu.c                            |  60 +++-
>>   target/riscv/cpu.h                            |   8 +
>>   target/riscv/cpu_bits.h                       |  27 ++
>>   target/riscv/cpu_cfg_fields.h.inc             |   3 +
>>   target/riscv/insn32.decode                    |   2 +
>>   target/riscv/meson.build                      |   1 +
>>   target/riscv/riscv_smmpt.c                    | 339
>> ++++++++++++++++++
>>   target/riscv/riscv_smmpt.h                    |  26 ++
>>   target/riscv/tcg/cpu_helper.c                 | 119 +++++-
>>   target/riscv/tcg/csr.c                        | 106 ++++++
>>   .../tcg/insn_trans/trans_privileged.c.inc     |  30 ++
>>   target/riscv/tcg/pmp.h                        |   3 +
>>   tests/tcg/riscv64/Makefile.softmmu-target     |  12 +
>>   tests/tcg/riscv64/smmpt-common.S              | 256 +++++++++++++
>>   tests/tcg/riscv64/test-smmpt.S                |  85 +++++
>>   tests/tcg/riscv64/test-smmpt34.S              |  97 +++++
>>   tests/tcg/riscv64/test-smmpt52.S              |  91 +++++
>>   tests/tcg/riscv64/test-smmpt64.S              |  98 +++++
>>   19 files changed, 1353 insertions(+), 19 deletions(-)
>>   create mode 100644 target/riscv/riscv_smmpt.c
>>   create mode 100644 target/riscv/riscv_smmpt.h
>>   create mode 100644 tests/tcg/riscv64/smmpt-common.S
>>   create mode 100644 tests/tcg/riscv64/test-smmpt.S
>>   create mode 100644 tests/tcg/riscv64/test-smmpt34.S
>>   create mode 100644 tests/tcg/riscv64/test-smmpt52.S
>>   create mode 100644 tests/tcg/riscv64/test-smmpt64.S
>>
>>
>> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05

