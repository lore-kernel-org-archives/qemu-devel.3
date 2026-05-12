Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1C7CD4846
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMd4S-0006bO-Ug; Mon, 11 May 2026 22:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMd4Q-0006b6-4a; Mon, 11 May 2026 22:42:06 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMd4N-0001sD-4a; Mon, 11 May 2026 22:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778553714; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=koapgSdF4zPyRmHEuQh60ZYluItX7p+hkU6JbWojqII=;
 b=IB361WQAuNy2vyqZ3VB1B18MLldku0kbs424h2CTLpDuC2KfAgkNVs862W4YmmpERkXS8AiAiKHYiTfp3YtmWxPSmvUvY6tdHY3UPKf752VV9sbxaRhgXLOd4WZGYuboTKSFFyz0VE2oA7GW1R3fDTJlhEVwxi6UoTDATxwchuE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X2ooPI0_1778553712; 
Received: from 30.166.64.212(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X2ooPI0_1778553712 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 12 May 2026 10:41:52 +0800
Message-ID: <8f1f57f3-1e0d-410c-bf88-6df51b665a75@linux.alibaba.com>
Date: Tue, 12 May 2026 10:41:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] target/riscv: Implement Smsdid and Smmpt extension
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com, liwei1518@gmail.com
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <e0144605-d8b5-4c9a-9c6f-af0715be1189@oss.qualcomm.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <e0144605-d8b5-4c9a-9c6f-af0715be1189@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Daniel,

On 5/11/26 5:29 PM, Daniel Henrique Barboza wrote:
> Hi Zhiwei,
>
> I was re-reading the code and the version history and I realized that
> these patches seems to be based on version v0.34.  At least this is
> what is mentioned on the v1 cover:
>
> "This patch set implements the v0.3.4 version of Smmpt"
> (https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4).
> https://lore.kernel.org/qemu-devel/20250909132533.32205-1-zhiwei_liu@linux.alibaba.com/ 
>
>
>
> Seeing the changelog from 0.34 to the current version (0.49) there's
> a lot of differences, including opcode values.
>
> I think it's worth bumping the patches to the latest spec version in
> v6.  Even if v6 takes more time (there were some IOMPT register changes
> that landed on v0.42).  Latest version 0.49 is staled since January 26,
> ratification target set to Q32026:
>
> https://riscv.atlassian.net/browse/RVS-1345
>
> Thus I think we're in good shape implementing v0.49 it without the 
> risk of
> changing behind our backs.
As SMMPT extension have many other sub extensions, I'd like to submit 
what we have now(aonther patch set about Smsdia  is also depend on 
v0.3.4) to make a base for future develop.

Thanks,
Zhiwei
>
>
> Thanks,
> Daniel
>
>
> On 4/8/2026 11:06 AM, LIU Zhiwei wrote:
>> This patch set introduces support for the RISC-V Smmpt (Supervisor
>> Memory-tracking and Protection Table) extension. Smmpt provides a
>> hardware mechanism for fine-grained memory protection, checked after
>> address translation, which is particularly useful for supervisor-level
>> sandboxing and security monitoring.
>>
>> The rfc patch set:
>> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
>>
>> v4->v5:
>>      1. Rebase to master.
>> v3->v4:
>>      1. Add missing review tags.
>> v2->v3:
>>      1. Fix build error in patch 2.
>>      2. Rebase to master.
>>
>> rfc->v2:
>>      1. When ext_smmpt is false or BARE mode, make other fields in mmpt
>>         CSR zero.
>>      2. Add patch 5 to fix smrnmi ISA string order.
>>      3. Fix patch 6 smmpt and smsdid ISA string order.
>>      4. Make smmpt and smsdid experiment extensions.
>>      5. Add review tags.
>>
>>
>> LIU Zhiwei (6):
>>    target/riscv: Add basic definitions and CSRs for SMMPT
>>    target/riscv: Implement core SMMPT lookup logic
>>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>>    target/riscv: Implement SMMPT fence instructions
>>    target/riscv: Fix smrnmi isa alphabetical order
>>    target/riscv: Enable SMMPT extension
>>
>>   target/riscv/cpu.c                            |   6 +-
>>   target/riscv/cpu.h                            |   9 +-
>>   target/riscv/cpu_bits.h                       |  27 ++
>>   target/riscv/cpu_cfg_fields.h.inc             |   2 +
>>   target/riscv/cpu_helper.c                     |  81 +++++-
>>   target/riscv/csr.c                            |  95 ++++++
>>   target/riscv/insn32.decode                    |   2 +
>>   .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
>>   target/riscv/meson.build                      |   1 +
>>   target/riscv/pmp.h                            |   3 +
>>   target/riscv/riscv_smmpt.c                    | 274 ++++++++++++++++++
>>   target/riscv/riscv_smmpt.h                    |  36 +++
>>   12 files changed, 560 insertions(+), 6 deletions(-)
>>   create mode 100644 target/riscv/riscv_smmpt.c
>>   create mode 100644 target/riscv/riscv_smmpt.h
>>
>

