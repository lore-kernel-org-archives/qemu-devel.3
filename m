Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28A6C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 19:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmd04-0006ml-5E; Wed, 22 Jul 2026 15:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmczz-0006m9-Pf
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 15:53:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmczx-0007wp-9Z
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 15:52:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MHrKnE1778735
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 19:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6D6q7FvIXmuaKBt6BXeR1nUN9WMG1wnIPvVkC2j2eq8=; b=lJY7VZk39BgcQ+Ph
 /a9WckOWc7Lxojn9knFpNuJD5rQB8vIDgGQASh2OsuNnJCDr7tZNOzJjzTcqa63i
 3usAPVz+ZLi0JrL3sgw2Oh1swnzt2SiFt/05//5bymWQ7Di1bdnar0W6O7Wp5m9X
 d5Q8BH0jd18+70nrbVxgzMX3xdQfeW1FPj3LFnyUyAZqvMkECBWI77Z8y9eRhSpM
 xb6a7zA/Y3oWJtarA8k7b9xXxKG6PWViQOJwiHGSuoNvbOtFIy1N4/FCj+Ys5QTM
 UDRj3Eklgcc3bppIrazB5o0LejMXJOaH/dwNVjvQXZO4PVJfG5UZt8YamitZByJR
 GN5Omg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt3cad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 19:52:54 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8efad04d884so189149276d6.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784749973; x=1785354773; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6D6q7FvIXmuaKBt6BXeR1nUN9WMG1wnIPvVkC2j2eq8=;
 b=LLiuFF27k4U7SISOU5P3Cqw9p3SlnM83GUDHL3Lug/TcRza+StEsVJAXKxpWWnKXgS
 MRR8Vfkz01UT0/ZzX/19UOYKM2iTd2gVqZD/Y7AmXTYWsheSnKZq0KNmZM4xAxVW5Ok5
 Qt72186innXYIDVUJeGYm4ppAhmONcXgk9/svBRnHO5cIgpk+nx1+N/DEl/lRsYsN7v6
 k++KulQQ6M6gAJM/z/KUugZdsoBYQ7SJsZRjNeXK3MCLleiUgb2NxrOx1WizxRY6Sx1+
 BBcNMAwU6orXf7v0rzxZ2e+jNkKOcwalvz0n14N8iSqlkqKj4Lb07ol3fQhSkr5cB+6/
 cWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784749973; x=1785354773;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6D6q7FvIXmuaKBt6BXeR1nUN9WMG1wnIPvVkC2j2eq8=;
 b=FxSQB3BCc9KzudPrKVqF0JkrCEPvzYbp0Z1x+BaUr7YtSvvHqUi/zccER4zkeUzi0B
 rXSf3CqZbQ9sT7Eb0irXQi/ta3BroPVD1mdCuvMDzerT4i3dHp5yngkaX7WgjAsUGuYv
 wmhVM1ykuJUjhaUYXITjuiUsRZXNKrgEAnGTg/csSZBxMlzncNGs+DDhkmJ75Q7xdOHj
 xeTzHo8aRgSnZAzwZIfZVVEY2u7KBQjs+0KRddrlvsAHkjqQUjAo8SYsx5eQJyL08s0Y
 D6DqOHDsCYCwNFVaEEe/hW2J7YcXNUVFH/pQvVLbM3bFeEwVw0414JODixMhVfnhPsBs
 I49A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpB8uge3ZK2lJNMuhidgEmD1Om4KgACQT83rmTxexb/cuG2bFlgWvYz2PR3wYoNO2RVk+GIzfbWAUI7@nongnu.org
X-Gm-Message-State: AOJu0YwS47cE6fnOx7f9/vv6LXT1Lt2we1eGl3CxWEI4mfHiXccoEMcQ
 YyoTdhykn3HbWLm/OLZ50jS8FIa5eInp8S3MHLv6QvnCL2syw3KB46VhVAAcXTN1SeHm5XVR7IV
 zQnQVZuSi4YhH/mpsyddTtNReE9QGF2iqM7pYmXk5lwWP8IKJUfPZfrNumg==
X-Gm-Gg: AR+sD13ZxaQh3PhUcQtreqHD5RZsIISJUqaO4evEFoPrn7E06pfz9Gd3eV4HXhvSujT
 l/w/dBI847wy9edT4udhC5DZYNzQoIBWBaYNJNiOISp0ROmsd4SkUTGtFvnzq5UNeXoh+rL1wbU
 UPqeOKqa+2tHSAMk5SXxaA8Od7I2kj/4R3XRDEK3wCoJ1StbniwC0L/G1EWvo4ZmFR8Jqk4wZnY
 nPzzMxHQjNb/GvEW1yDSKv4KYJlyByxT+lzee5FYDZOAgdL+fuAXVG0EQpPMbs7zDBfusllcbjD
 CRf/1NO7Qnyq8a2/GSa8lGuWWykze3dGyQCrlRkw7y1VsibnKfvvRzI/Ut4bd+cpsMjZicpPogB
 QmEzHrRfi8DGfu3ScUFTVcypOsSlt6XLM5kRAHw==
X-Received: by 2002:a05:6214:2464:b0:8ef:7fd6:11db with SMTP id
 6a1803df08f44-907ca6388a2mr3399406d6.51.1784749972264; 
 Wed, 22 Jul 2026 12:52:52 -0700 (PDT)
X-Received: by 2002:a05:6214:2464:b0:8ef:7fd6:11db with SMTP id
 6a1803df08f44-907ca6388a2mr3398206d6.51.1784749970545; 
 Wed, 22 Jul 2026 12:52:50 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba8b5f6esm28221526d6.5.2026.07.22.12.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 12:52:50 -0700 (PDT)
Message-ID: <8cc10b77-22a0-40f0-b883-5d3491248fac@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:52:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] target/riscv: Implement Smsdid and Smmpt
 extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair <alistair@alistair23.me>, qemu-devel@nongnu.org,
 xiangyi.zeng@linux.alibaba.com
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, cxx194832@alibaba-inc.com,
 rahul.pathak@oss.qualcomm.com
References: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
 <a568614fb2f7221583bbcc2c67cf7282d50e4d83.camel@alistair23.me>
 <db11d478-c0cb-4ca6-b7b4-3f53b281452b@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <db11d478-c0cb-4ca6-b7b4-3f53b281452b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nLgk7QDzRmHAgj1DGSLRpL2t1WTkLYFd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE5NiBTYWx0ZWRfXyT35Xe40JVTg
 ay/I4J8uGBfHT20RS69GBCMzzqfNM02zUpAf5jxfL/8mlASPyzYVwtG3ZEM+ii0UG5Ew+elzHSJ
 FhrC+cm+b8ZWwVqAv+bxsw2qUQsqiID+v463g+vtJBjNZ2HeNHcQGrEwyxq4IIcjgGDNebO6RW5
 VR1CjYMoRszlYSQgyNf26QXkddSX53qALzyWvfYuAfBU+63GTtp7zZgVaq4klfVKvAcvnfYEzQJ
 O8Lt+oYuklaLPiNyJK04pBtmsXzIKQQjCRZwCLCMFCo63iMgKfin5SpuycYHFjgoBt3vPaby0FT
 H051hp4yZRHBB0RUH6282syNE5qdNfsjJI8qeoqh0EODQUmjosAitDL7u/BTiN5Ww+/+aLmqIKj
 QnOwYIxgZ2ngyxAdvoy1QE/5mZ5HgRPG1Hna549cc0pMId25CJhhGL+s7DYVwGSmU4R75/GlNDl
 OLOUfl6ZUj06Jk32m5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE5NiBTYWx0ZWRfX6rCGa9n9lhUZ
 zydf2PyQ4CajpfGnxHi2E5XNSoYCMBZSfqhfU3Umyz5m9nstYpWhWCl/XiftJ3nVEplgPV83EXX
 dp43g/5di6BNDsgy+tTVlKr0YEgng6s=
X-Proofpoint-GUID: nLgk7QDzRmHAgj1DGSLRpL2t1WTkLYFd
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a611f96 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=xvfqbYfxAAAA:20 a=JfrnYn6hAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mDV3o1hIAAAA:8 a=5dsZQrsRkkb-I2esH_cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220196
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 7/22/2026 12:11 AM, LIU Zhiwei wrote:
> 
> On 7/22/26 8:56 AM, Alistair wrote:
>> On Wed, 2026-07-15 at 22:50 +0800, LIU Zhiwei wrote:
>>> This patch set introduces support for the RISC-V Smsdid and Smmpt
>>> (Supervisor Domain Identifier and Memory Protection Table) extensions
>>> v0.4.9(https://github.com/riscv/riscv-smmtt/releases/tag/v0.4.9).
>>> Smmpt provides a hardware mechanism for fine-grained memory
>>> protection,
>>> checked after address translation, which is particularly useful for
>>> supervisor-level sandboxing and security monitoring.
> Hi Alistair,
>> Can you include a link to the upstream submitted patches to use this
>> functionality
> Xiangyi is currently working on OpenSBI support for SMMPT, and we already have an internal implementation in place. We plan to upstream the OpenSBI support as soon as possible, and once that is done, I’ll be able to include a link here.

Please be aware that Rahul already sent OpenSBI patches for smmpt and smsdid:

[RFC PATCH 0/5] Add Smsdid and Smmpt supervisor domain protection
https://lists.infradead.org/pipermail/opensbi/2026-July/010235.html

In fact, as I said in another thread [1], Rahul also has a QEMU implementation of his own.
His OpenSBI patches works with his QEMU changes:

https://github.com/pathakraul/qemu/tree/rpathak_smmpt_v1

But seems like his OpenSBI patches does *not* work with this QEMU patches, but works
with his QEMU implementation.  Seems like there might be things to improve in both
implementations.

I asked him to not send his QEMU patches on top of yours because I'd rather work in
collaboration on top of a single series, and I advise to not send another OpenSBI support
for the same stuff in that mailing as well.

IMO you and Rahul should sync up in both OpenSBI and QEMU bits to avoid effort duplication
on both sides.


Cheers,
Daniel


[1] https://lore.kernel.org/qemu-devel/2e2de5da-9eb0-4d56-b193-d8b06b7a3512@oss.qualcomm.com/


> 
> Thanks,
> Zhiwei
>>
>> Alistair
>>
>>> The rfc patch set:
>>> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
>>>
>>> v6->v7:
>>>      The implementation is updated from the v0.3.4 specification to
>>>      v0.4.9. The main changes are:
>>>      1. Update the mmpt CSR number to 0x382 and msdcfg to 0x74E.
>>>      2. Update the mmpt register layout: the SDID and PPN field
>>> positions
>>>         changed and the RV64 PPN is now 44 bits.
>>>      3. Rework the MPTE format: the N (NAPOT) bit now lives at bit 2,
>>> the
>>>         non-leaf NAPOT form is removed, NAPOT leaf entries encode a
>>> single
>>>         XWR tuple plus a G granularity field, and non-NAPOT leaf
>>> entries
>>>         hold per-page XWR tuples.
>>>      4. Treat XWR=000 as "no access" and a non-leaf entry with N=1 as
>>> a
>>>         fault.
>>>      5. Enforce the Smmpt64 root-table PPN alignment (low 3 bits
>>> zero).
>>>      6. Rename the fence instructions mfence.spa/minval.spa to
>>>         mfence.pa/minval.pa.
>>>      7. Drop stale Reviewed-by tags on the substantially reworked
>>> patches.
>>>      8. Introduce the configurable "smmpt-sdidlen" CPU property.
>>>      9. Add disassembly support for the Smmpt.
>>>      10. Add bare-metal M-mode system tests.
>>>      11. Rebase to master.
>>>
>>> v5->v6:
>>>      1. Use explicitly bit fields extract instead of mpte_union_t.
>>>      2. Use the same exception behavior for MPT valiation as PMP
>>>         valiation.
>>>      3. Use PAGE_* instead of MPT_ACCESS_* as they have same value.
>>>      4. Use address_space_*_le instead of address_space_* for SMMPT.
>>>      5. Only print SMMPT address check log when SMMPT is enabled.
>>>      6. Add implied rule for SMMPT as it depends on SMSDID.
>>>      7. Rebase to master.
>>>
>>> v4->v5:
>>>      1. Rebase to master.
>>> v3->v4:
>>>      1. Add missing review tags.
>>> v2->v3:
>>>      1. Fix build error in patch 2.
>>>      2. Rebase to master.
>>>
>>> rfc->v2:
>>>      1. When ext_smmpt is false or BARE mode, make other fields in
>>> mmpt
>>>         CSR zero.
>>>      2. Add patch 5 to fix smrnmi ISA string order.
>>>      3. Fix patch 6 smmpt and smsdid ISA string order.
>>>      4. Make smmpt and smsdid experiment extensions.
>>>      5. Add review tags.
>>>
>>> LIU Zhiwei (11):
>>>    target/riscv: Add basic definitions and CSRs for SMMPT
>>>    target/riscv: Add smmpt-sdidlen property for the mmpt SDID field
>>>    target/riscv: Implement core SMMPT lookup logic
>>>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>>>    target/riscv: Implement SMMPT fence instructions
>>>    target/riscv: Fix smrnmi isa alphabetical order
>>>    target/riscv: Add disassembly for Smmpt instructions and CSRs
>>>    target/riscv: Enable SMMPT extension
>>>    target/riscv: Add system test for SMMPT extension
>>>    target/riscv: Add system tests for Smmpt52 and Smmpt64
>>>    target/riscv: Add system test for Smmpt34
>>>
>>>   disas/riscv.c                                 |   9 +-
>>>   target/riscv/cpu.c                            |  60 +++-
>>>   target/riscv/cpu.h                            |   8 +
>>>   target/riscv/cpu_bits.h                       |  27 ++
>>>   target/riscv/cpu_cfg_fields.h.inc             |   3 +
>>>   target/riscv/insn32.decode                    |   2 +
>>>   target/riscv/meson.build                      |   1 +
>>>   target/riscv/riscv_smmpt.c                    | 339
>>> ++++++++++++++++++
>>>   target/riscv/riscv_smmpt.h                    |  26 ++
>>>   target/riscv/tcg/cpu_helper.c                 | 119 +++++-
>>>   target/riscv/tcg/csr.c                        | 106 ++++++
>>>   .../tcg/insn_trans/trans_privileged.c.inc     |  30 ++
>>>   target/riscv/tcg/pmp.h                        |   3 +
>>>   tests/tcg/riscv64/Makefile.softmmu-target     |  12 +
>>>   tests/tcg/riscv64/smmpt-common.S              | 256 +++++++++++++
>>>   tests/tcg/riscv64/test-smmpt.S                |  85 +++++
>>>   tests/tcg/riscv64/test-smmpt34.S              |  97 +++++
>>>   tests/tcg/riscv64/test-smmpt52.S              |  91 +++++
>>>   tests/tcg/riscv64/test-smmpt64.S              |  98 +++++
>>>   19 files changed, 1353 insertions(+), 19 deletions(-)
>>>   create mode 100644 target/riscv/riscv_smmpt.c
>>>   create mode 100644 target/riscv/riscv_smmpt.h
>>>   create mode 100644 tests/tcg/riscv64/smmpt-common.S
>>>   create mode 100644 tests/tcg/riscv64/test-smmpt.S
>>>   create mode 100644 tests/tcg/riscv64/test-smmpt34.S
>>>   create mode 100644 tests/tcg/riscv64/test-smmpt52.S
>>>   create mode 100644 tests/tcg/riscv64/test-smmpt64.S
>>>
>>>
>>> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05


