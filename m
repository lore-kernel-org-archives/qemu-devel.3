Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699D4C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 03:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmkOf-0006Zh-4a; Wed, 22 Jul 2026 23:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmkOb-0006Yv-Jf; Wed, 22 Jul 2026 23:46:54 -0400
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmkOU-0004V5-KP; Wed, 22 Jul 2026 23:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784778382; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=oUUq4FugiH3fS+Az6GU1EViJio6Tdn8HQU+tFqjcIt8=;
 b=D6+KpOE/qWPyoCU8xx2qBFG5ulUueMoLpCRNAmGcQKaJrVB32K3laqhDVz3WXzGpgKbs1g31ueHfyXZiy/0z/9E5qZK2Y02ZDhph2o7FrzX+zqdBE6RpWLvsE5lJg1WRJoJjbmcyEN1UIUgAlC7OZLlAJy2NETGKM9ek+I8P1Zk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R561e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X7epHR7_1784778379; 
Received: from 30.166.65.93(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X7epHR7_1784778379 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 23 Jul 2026 11:46:20 +0800
Message-ID: <705186b9-dd43-4e8e-ba42-0b6d0af05081@linux.alibaba.com>
Date: Thu, 23 Jul 2026 11:46:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] target/riscv: Implement Smsdid and Smmpt
 extension
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair <alistair@alistair23.me>, qemu-devel@nongnu.org,
 xiangyi.zeng@linux.alibaba.com
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, cxx194832@alibaba-inc.com,
 rahul.pathak@oss.qualcomm.com
References: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
 <a568614fb2f7221583bbcc2c67cf7282d50e4d83.camel@alistair23.me>
 <db11d478-c0cb-4ca6-b7b4-3f53b281452b@linux.alibaba.com>
 <8cc10b77-22a0-40f0-b883-5d3491248fac@oss.qualcomm.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <8cc10b77-22a0-40f0-b883-5d3491248fac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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


On 7/23/26 3:52 AM, Daniel Henrique Barboza wrote:
>
>
> On 7/22/2026 12:11 AM, LIU Zhiwei wrote:
>>
>> On 7/22/26 8:56 AM, Alistair wrote:
>>> On Wed, 2026-07-15 at 22:50 +0800, LIU Zhiwei wrote:
>>>> This patch set introduces support for the RISC-V Smsdid and Smmpt
>>>> (Supervisor Domain Identifier and Memory Protection Table) extensions
>>>> v0.4.9(https://github.com/riscv/riscv-smmtt/releases/tag/v0.4.9).
>>>> Smmpt provides a hardware mechanism for fine-grained memory
>>>> protection,
>>>> checked after address translation, which is particularly useful for
>>>> supervisor-level sandboxing and security monitoring.
>> Hi Alistair,
>>> Can you include a link to the upstream submitted patches to use this
>>> functionality
>> Xiangyi is currently working on OpenSBI support for SMMPT, and we 
>> already have an internal implementation in place. We plan to upstream 
>> the OpenSBI support as soon as possible, and once that is done, I’ll 
>> be able to include a link here.
>
Hi Daniel
> Please be aware that Rahul already sent OpenSBI patches for smmpt and 
> smsdid:
>
> [RFC PATCH 0/5] Add Smsdid and Smmpt supervisor domain protection
> https://lists.infradead.org/pipermail/opensbi/2026-July/010235.html
>
> In fact, as I said in another thread [1], Rahul also has a QEMU 
> implementation of his own.
> His OpenSBI patches works with his QEMU changes:
>
> https://github.com/pathakraul/qemu/tree/rpathak_smmpt_v1
Thank you very much for pointing this out and for coordinating between 
us. I was not aware of Rahul's OpenSBI patches and QEMU implementation.
>
> But seems like his OpenSBI patches does *not* work with this QEMU patches,
It seams probe_sdidlen in OpenSBI write a sdid to mmpt with bare mode. 
According to the specification, in bare mode, "The remaining fields in 
mmpt (SDID, PPN) must
be set to zeros.
>  but works
> with his QEMU implementation.  Seems like there might be things to 
> improve in both
> implementations.
>
> I asked him to not send his QEMU patches on top of yours because I'd 
> rather work in
> collaboration on top of a single series, and I advise to not send 
> another OpenSBI support
> for the same stuff in that mailing as well.
>
> IMO you and Rahul should sync up in both OpenSBI and QEMU bits to 
> avoid effort duplication
> on both sides.

I agree with your suggestion that it is better to avoid duplicated 
effort and collaborate on a single direction for both the QEMU and 
OpenSBI sides.

Since the SMMPT v0.4.9 specification is already close to stabilization, 
and implementation work has already started in both OpenSBI and QEMU, I 
believe we should be able to converge quickly through collaboration and 
help move SMMPT upstream sooner.

Xiangyi and I will continue to review Rahul's OpenSBI patches to 
understand the current differences and why they are not yet compatible 
with our QEMU series. I will also reach out to Rahul directly so that we 
can sync up and work toward a common implementation.

Thanks again for the pointers.

Best regards,
Zhiwei

>
>
> Cheers,
> Daniel
>
>
> [1] 
> https://lore.kernel.org/qemu-devel/2e2de5da-9eb0-4d56-b193-d8b06b7a3512@oss.qualcomm.com/
>
>
>>
>> Thanks,
>> Zhiwei
>>>
>>> Alistair
>>>
>>>> The rfc patch set:
>>>> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
>>>>
>>>> v6->v7:
>>>>      The implementation is updated from the v0.3.4 specification to
>>>>      v0.4.9. The main changes are:
>>>>      1. Update the mmpt CSR number to 0x382 and msdcfg to 0x74E.
>>>>      2. Update the mmpt register layout: the SDID and PPN field
>>>> positions
>>>>         changed and the RV64 PPN is now 44 bits.
>>>>      3. Rework the MPTE format: the N (NAPOT) bit now lives at bit 2,
>>>> the
>>>>         non-leaf NAPOT form is removed, NAPOT leaf entries encode a
>>>> single
>>>>         XWR tuple plus a G granularity field, and non-NAPOT leaf
>>>> entries
>>>>         hold per-page XWR tuples.
>>>>      4. Treat XWR=000 as "no access" and a non-leaf entry with N=1 as
>>>> a
>>>>         fault.
>>>>      5. Enforce the Smmpt64 root-table PPN alignment (low 3 bits
>>>> zero).
>>>>      6. Rename the fence instructions mfence.spa/minval.spa to
>>>>         mfence.pa/minval.pa.
>>>>      7. Drop stale Reviewed-by tags on the substantially reworked
>>>> patches.
>>>>      8. Introduce the configurable "smmpt-sdidlen" CPU property.
>>>>      9. Add disassembly support for the Smmpt.
>>>>      10. Add bare-metal M-mode system tests.
>>>>      11. Rebase to master.
>>>>
>>>> v5->v6:
>>>>      1. Use explicitly bit fields extract instead of mpte_union_t.
>>>>      2. Use the same exception behavior for MPT valiation as PMP
>>>>         valiation.
>>>>      3. Use PAGE_* instead of MPT_ACCESS_* as they have same value.
>>>>      4. Use address_space_*_le instead of address_space_* for SMMPT.
>>>>      5. Only print SMMPT address check log when SMMPT is enabled.
>>>>      6. Add implied rule for SMMPT as it depends on SMSDID.
>>>>      7. Rebase to master.
>>>>
>>>> v4->v5:
>>>>      1. Rebase to master.
>>>> v3->v4:
>>>>      1. Add missing review tags.
>>>> v2->v3:
>>>>      1. Fix build error in patch 2.
>>>>      2. Rebase to master.
>>>>
>>>> rfc->v2:
>>>>      1. When ext_smmpt is false or BARE mode, make other fields in
>>>> mmpt
>>>>         CSR zero.
>>>>      2. Add patch 5 to fix smrnmi ISA string order.
>>>>      3. Fix patch 6 smmpt and smsdid ISA string order.
>>>>      4. Make smmpt and smsdid experiment extensions.
>>>>      5. Add review tags.
>>>>
>>>> LIU Zhiwei (11):
>>>>    target/riscv: Add basic definitions and CSRs for SMMPT
>>>>    target/riscv: Add smmpt-sdidlen property for the mmpt SDID field
>>>>    target/riscv: Implement core SMMPT lookup logic
>>>>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>>>>    target/riscv: Implement SMMPT fence instructions
>>>>    target/riscv: Fix smrnmi isa alphabetical order
>>>>    target/riscv: Add disassembly for Smmpt instructions and CSRs
>>>>    target/riscv: Enable SMMPT extension
>>>>    target/riscv: Add system test for SMMPT extension
>>>>    target/riscv: Add system tests for Smmpt52 and Smmpt64
>>>>    target/riscv: Add system test for Smmpt34
>>>>
>>>>   disas/riscv.c                                 |   9 +-
>>>>   target/riscv/cpu.c                            |  60 +++-
>>>>   target/riscv/cpu.h                            |   8 +
>>>>   target/riscv/cpu_bits.h                       |  27 ++
>>>>   target/riscv/cpu_cfg_fields.h.inc             |   3 +
>>>>   target/riscv/insn32.decode                    |   2 +
>>>>   target/riscv/meson.build                      |   1 +
>>>>   target/riscv/riscv_smmpt.c                    | 339
>>>> ++++++++++++++++++
>>>>   target/riscv/riscv_smmpt.h                    |  26 ++
>>>>   target/riscv/tcg/cpu_helper.c                 | 119 +++++-
>>>>   target/riscv/tcg/csr.c                        | 106 ++++++
>>>>   .../tcg/insn_trans/trans_privileged.c.inc     |  30 ++
>>>>   target/riscv/tcg/pmp.h                        |   3 +
>>>>   tests/tcg/riscv64/Makefile.softmmu-target     |  12 +
>>>>   tests/tcg/riscv64/smmpt-common.S              | 256 +++++++++++++
>>>>   tests/tcg/riscv64/test-smmpt.S                |  85 +++++
>>>>   tests/tcg/riscv64/test-smmpt34.S              |  97 +++++
>>>>   tests/tcg/riscv64/test-smmpt52.S              |  91 +++++
>>>>   tests/tcg/riscv64/test-smmpt64.S              |  98 +++++
>>>>   19 files changed, 1353 insertions(+), 19 deletions(-)
>>>>   create mode 100644 target/riscv/riscv_smmpt.c
>>>>   create mode 100644 target/riscv/riscv_smmpt.h
>>>>   create mode 100644 tests/tcg/riscv64/smmpt-common.S
>>>>   create mode 100644 tests/tcg/riscv64/test-smmpt.S
>>>>   create mode 100644 tests/tcg/riscv64/test-smmpt34.S
>>>>   create mode 100644 tests/tcg/riscv64/test-smmpt52.S
>>>>   create mode 100644 tests/tcg/riscv64/test-smmpt64.S
>>>>
>>>>
>>>> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
>

