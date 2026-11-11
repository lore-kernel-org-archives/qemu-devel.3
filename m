Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E3606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=218dQhfm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQyhx-0003rl-DF; Tue, 10 Nov 2026 22:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1xQyhu-0003rH-VK
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:09:06 -0500
Received: from va-2-42.ptr.blmpb.com ([209.127.231.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1xQyhq-0002vm-BQ
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1794366527;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=iV/JOl3/nqd/ayw6BVfT4WE51KwuKImXaEcLBGAeuts=;
 b=218dQhfmpbpF8XYsro8M0Hf+qtimOZyaQJgmTuLvTgfnqHGx0qjtzB2zY7ltiF2R1OdJwp
 Wqg1rUHE4qB3no2jBfpxdbKi2b5bf50uJXrm6hfdgBBqXV6mVwnAKxRL9v6IwlS9EYkM6X
 4tzn+7ugI3MQJQj1IahnGyUFZ+vAQVwOEJzFdpmeDM1/nsonY6I6JfW/q334ckHqYrd6Eu
 9DkB37rNcLl4H/kjBeDAdbUQ+J6JwEMYTFqdwy4lzOjTuLoI1wcU+13C+MDCRT2LGR6zOm
 d3J9AfgP5Cfk11gXVn8Y5SFvk4qVzG5fxOYnhAF24g9/HgJazRUHIJMG7WYIxQ==
Received: from [127.0.0.1] ([123.120.4.67]) by smtp.feishu.cn with ESMTPS;
 Wed, 11 Nov 2026 11:08:44 +0800
To: "Nutty.Liu" <nutty.liu@hotmail.com>, <palmer@dabbelt.com>
In-Reply-To: <TYZPR04MB74919088016737D2EB0B05BAF3722@TYZPR04MB7491.apcprd04.prod.outlook.com>
Message-Id: <6d6e37b8-62c1-41c4-b7f2-c0be8b9d2f62@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
References: <20261104025308.1920474-1-xiangwencheng@lanxincomputing.com>
 <TYZPR04MB74919088016737D2EB0B05BAF3722@TYZPR04MB7491.apcprd04.prod.outlook.com>
Cc: <alistair.francis@wdc.com>, <liwei1518@gmail.com>, 
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>, 
 <chao.liu@processmission.com>, <qemu-riscv@nongnu.org>, 
 <qemu-devel@nongnu.org>, <anup@brainfault.org>
Date: Wed, 11 Nov 2026 11:08:41 +0800
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26af3dc3d+45fb79+nongnu.org+xiangwencheng@lanxincomputing.com>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Subject: Re: [PATCH v2] hw/intc/aplic: Fix msicfgaddrH in split mode
Received-SPF: pass client-ip=209.127.231.42;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=va-2-42.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/2026 7:49 PM, Nutty.Liu wrote:
>=20
> On 11/4/2026 10:53 AM, BillXiang wrote:
>> Add hart_bits and guest_bits to msicfgaddrH in KVM irqchip
>> split mode.
>> Also remove the redundant left shift when loading
>> kvm_msicfgaddrH in riscv_aplic_msi_send().
>>
>> Rationale:
>> static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t hart_idx=
, uint32_t guest_idx,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t eiid)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t addr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MemTxResult result;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RISCVAPLICState *aplic_m;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t lhxs, lhxw, hhxs, hhxw, group_id=
x, msicfgaddr,=20
>> msicfgaddrH;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (aplic->kvm_splitmode) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msicfgaddr =3D ap=
lic->kvm_msicfgaddr;
>> 1.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msicfgaddrH =3D ((uint64_t)=
aplic->kvm_msicfgaddrH << 32);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lhxs =3D (msicfgaddrH >> APLIC_xMSICFGADD=
RH_LHXS_SHIFT) &
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 APLIC_xMSICFGADDRH_LHXS_MASK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lhxw =3D (msicfgaddrH >> APLIC_xMSICFGADD=
RH_LHXW_SHIFT) &
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 APLIC_xMSICFGADDRH_LHXW_MASK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hhxs =3D (msicfgaddrH >> APLIC_xMSICFGADD=
RH_HHXS_SHIFT) &
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 APLIC_xMSICFGADDRH_HHXS_MASK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hhxw =3D (msicfgaddrH >> APLIC_xMSICFGADD=
RH_HHXW_SHIFT) &
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 APLIC_xMSICFGADDRH_HHXW_MASK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 group_idx =3D hart_idx >> lhxw;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D msicfgaddr;
>> 2.=C2=A0=C2=A0=C2=A0 addr |=3D ((uint64_t)(msicfgaddrH & APLIC_xMSICFGAD=
DRH_BAPPN_MASK))
>> << 32;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr |=3D ((uint64_t)(group_idx &
>> APLIC_xMSICFGADDR_PPN_HHX_MASK(hhxw))) <<
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 APLIC_xMSICFGADDR_PPN_HHX_SHIFT(hhxs);
>> 3.=C2=A0=C2=A0=C2=A0 addr |=3D ((uint64_t)(hart_idx &
>> APLIC_xMSICFGADDR_PPN_LHX_MASK(lhxw))) <<
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 APLIC_xMSICFGADDR_PPN_LHX_SHIFT(lhxs);
>> 4.=C2=A0=C2=A0=C2=A0 addr |=3D (uint64_t)(guest_idx & APLIC_xMSICFGADDR_=
PPN_HART(lhxs));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr <<=3D APLIC_xMSICFGADDR_PPN_SHIFT;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> }
>>
>> Since msicfgaddrH is left-shifted at (2), the left shift at (1) is
>> redundant.
>>
>> At (3) and (4), hart_idx and guest_idx are masked/shifted using lhxw and
>> lhxs, which are extracted from the LHXW/LHXS fields of msicfgaddrH.
>> However, riscv_aplic_set_kvm_msicfgaddr() did not program the LHXW/LHXS
>> fields into kvm_msicfgaddrH, so lhxs/lhxw always read as zero, and the
>> hart/guest idxs were never encoded into the MSI address. Fix this by
>> programming hart_bits (LHXW) and guest_bits (LHXS) into kvm_msicfgaddrH
>> in riscv_aplic_set_kvm_msicfgaddr().
>>
>> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
>> ---
>> Changes in v2:
>> - Add rationale.
>> ---
>> =C2=A0 hw/intc/riscv_aplic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 13 +++++++++----
>> =C2=A0 hw/riscv/aia.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++++-
>> =C2=A0 include/hw/intc/riscv_aplic.h |=C2=A0 3 ++-
>> =C2=A0 3 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
>> index 03a0852b8b..2b618e73df 100644
>> --- a/hw/intc/riscv_aplic.c
>> +++ b/hw/intc/riscv_aplic.c
>> @@ -182,7 +182,8 @@ bool riscv_use_emulated_aplic(bool msimode)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return kvm_kernel_irqchip_split();
>> =C2=A0 }
>> -void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr=
)
>> +void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t=
 hart_bits, uint32_t=20
>> guest_bits)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!kvm_enabled()) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> @@ -191,8 +192,12 @@ void=20
>> riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (riscv_use_emulated_aplic(aplic->msimo=
de)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr >>=3D APLIC_=
xMSICFGADDR_PPN_SHIFT;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aplic->kvm_msicfg=
addr =3D extract64(addr, 0, 32);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aplic->kvm_msicfgaddrH =3D e=
xtract64(addr, 32, 32) &
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 APLIC_MMSICFGADDRH_VALID_M=
ASK;
> Is it necessary to perform boundary checks on hart_bits/guest_bits ?
> Just like:
> +=C2=A0 =C2=A0 assert(hart_bits=C2=A0 <=3D APLIC_xMSICFGADDRH_LHXW_MASK);
> +=C2=A0 =C2=A0 assert(guest_bits <=3D APLIC_xMSICFGADDRH_LHXS_MASK);

Thank you for the review. I'll add it to v3.

Regards,
Bill

>=20
> Otherwise,
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>=20
> Thanks,
> Nutty
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aplic->kvm_msicfgaddrH =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((ha=
rt_bits & APLIC_xMSICFGADDRH_LHXW_MASK) <<
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 APLIC_xMSICFGADDRH_LHXW_SHIFT) |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((gu=
est_bits & APLIC_xMSICFGADDRH_LHXS_MASK) <<
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 APLIC_xMSICFGADDRH_LHXS_SHIFT) |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ext=
ract64(addr, 32, 32) & APLIC_xMSICFGADDRH_BAPPN_MASK);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> @@ -404,7 +409,7 @@ static void riscv_aplic_msi_send(RISCVAPLICState=20
>> *aplic,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (aplic->kvm_splitmode) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msicfgaddr =3D ap=
lic->kvm_msicfgaddr;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msicfgaddrH =3D ((uint64_t)a=
plic->kvm_msicfgaddrH << 32);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msicfgaddrH =3D aplic->kvm_m=
sicfgaddrH;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msicfgaddr =3D ap=
lic_m->mmsicfgaddr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msicfgaddrH =3D a=
plic_m->mmsicfgaddrH;
>> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
>> index 56fc064533..bd608bd7a6 100644
>> --- a/hw/riscv/aia.c
>> +++ b/hw/riscv/aia.c
>> @@ -38,6 +38,7 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr addr =3D 0;
>> +=C2=A0=C2=A0=C2=A0 uint32_t hart_bits, guest_bits;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *aplic_s_dev =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *aplic_m_dev =3D NULL;
>> @@ -93,7 +94,10 @@ DeviceState *riscv_create_aia(MemoryRegion *container=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msimode, false, a=
plic_m_dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_enabled() && msimode) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv_aplic_set_kvm_msicfgad=
dr(RISCV_APLIC(aplic_s_dev), addr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hart_bits =3D imsic_num_bits=
(hart_count);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guest_bits =3D imsic_num_bit=
s(aia_guests + 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv_aplic_set_kvm_msicfgad=
dr(RISCV_APLIC(aplic_s_dev), addr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hart_bit=
s, guest_bits);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return kvm_enabled() ? aplic_s_dev : apli=
c_m_dev;
>> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/=20
>> riscv_aplic.h
>> index 62d2b33ade..d3ee2e537a 100644
>> --- a/include/hw/intc/riscv_aplic.h
>> +++ b/include/hw/intc/riscv_aplic.h
>> @@ -78,7 +78,8 @@ struct RISCVAPLICState {
>> =C2=A0 void riscv_aplic_add_child(DeviceState *parent, DeviceState *chil=
d);
>> =C2=A0 bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
>> =C2=A0 bool riscv_use_emulated_aplic(bool msimode);
>> -void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr=20
>> addr);
>> +void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t=
 hart_bits, uint32_t=20
>> guest_bits);
>> =C2=A0 DeviceState *riscv_aplic_create(MemoryRegion *container,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr addr, hwaddr size, uint32_t hartid=
_base, uint32_t num_harts,

