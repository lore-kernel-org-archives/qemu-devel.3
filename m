Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57F5C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 07:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOuV8-0006vZ-E2; Wed, 03 Jul 2024 03:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOuV6-0006si-Hg
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:34:00 -0400
Received: from flow6-smtp.messagingengine.com ([103.168.172.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOuV3-0003XI-Ad
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:34:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailflow.nyi.internal (Postfix) with ESMTP id 8401D2005C6;
 Wed,  3 Jul 2024 03:33:56 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 03 Jul 2024 03:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719992036;
 x=1719999236; bh=1SotY8UMZJijOh3L2Kf7ui5f/f1RSRZrfh7TLcfyhws=; b=
 jVOLaoX5e7kspzoqUFHz6EyPwMZ+NevAS+X/t+nz92Wlc/TmbM75UBwzNRW1pOFv
 raBh1BDMPorEgkGUPzcrxVwM/4LHzyhMbhxAYCPo4iVXmmICYjHLaScVuZlaGulJ
 f64gmf7fqj0qq1Fb4dg+9fXUevspSQSsLf6n8G965S5kAIISXiugr3AtHb7lTOJ+
 YrsmytLGR5UWAePfHjE2MllEot2jvSVY6+cqm1vjj5Y6jUjMP2OOxo1/baGvDEZg
 12Ix1QrefvrYbduU7/jb8dVuy1E6RyEi4Ph05x2MzN04eWLTlEem5yLnRFmxriAz
 GdjTYdhLfA1iiENWUeVqeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=ifd894703.fm2; t=
 1719992036; x=1719999236; bh=1SotY8UMZJijOh3L2Kf7ui5f/f1RSRZrfh7
 TLcfyhws=; b=vswXSB+vgYLm78BNkqia9st2OuuVGioUMdy/+Q9KjvuViBomxk0
 q31gsPgc5UhhRtoeFm18/mUeWHBMei5QliD6sBQl/v8WeQU+7qzO5Pd5PJCoZWDG
 q7qcYt5ce+TQlraVHvLUK6B94eoI9vAHQ7PaSm/MXxvm0FLC7dcK/pk6bFXTc6a8
 VGKjE2MATgCG+42k/bKEFg0/h7M/GYiAmpo98tpLvddRRB57nZWXXG4NnfoOUW7k
 0sUfaQSkeNRryUeDoFVRtVTutRGVs74tVf+qa3bFrZapGG8Kq1tFJXN0bklcIXIj
 2Lt+NX+573nZ/SCx4JSXvBksTNn061rNVdQ==
X-ME-Sender: <xms:5P6EZtEsYrkG7lCDyoBDy0RaDssxZOeJIe78qA5LIiM_zG27xfEIbA>
 <xme:5P6EZiX3svkLD87043oZjmtcMnSlPpbuPqWg20Hr_YDbzH-qa8hbxYg3YHI1aNf3p
 N7oysRU6TZSwtZkfLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigdduudelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:5P6EZvLQuv4uCWEzK3mh_i0prN2S8mR7Ndt6ivRGbLB7RTXHt74ufQ>
 <xmx:5P6EZjHPPw3NMpTs_3_Pt0jyr3jrxmPSJo_Sv5cdIHxn9JLPyzjXMg>
 <xmx:5P6EZjUCwbNj1SGjPrBoa-f3SFOBENh6aIRtZFr2KWQSMejrabLgUg>
 <xmx:5P6EZuMq7HDD61tdg4pzy8u5IobOSgzbGIHOiZHtzy2JGHG6AbScqQ>
 <xmx:5P6EZi3G9xi9BgsolSaYWsEr7FgCnVQdmHskGeX3t8GaTP4vob93tfFt>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 55E5936A0074; Wed,  3 Jul 2024 03:33:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
MIME-Version: 1.0
Message-Id: <73e84270-1d37-4718-ae24-f87997ac1e03@app.fastmail.com>
In-Reply-To: <0fc1703c-6007-c0fe-c261-6c549ba58752@loongson.cn>
References: <20240703021245.3752786-1-maobibo@loongson.cn>
 <20240703021245.3752786-2-maobibo@loongson.cn>
 <66ae71c4-7b79-4d95-ad23-17b00f7eae08@app.fastmail.com>
 <0fc1703c-6007-c0fe-c261-6c549ba58752@loongson.cn>
Date: Wed, 03 Jul 2024 15:33:35 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "Paolo Bonzini" <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Song Gao" <gaosong@loongson.cn>
Cc: "QEMU devel" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/3] hw/intc/loongson_ipi_common: Add loongson ipi common
 class
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.141;
 envelope-from=jiaxun.yang@flygoat.com; helo=flow6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



=E5=9C=A82024=E5=B9=B47=E6=9C=883=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=882:40=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
[...]
Hi Bobo,
>
> MMIO is loongson ipi specific, it is not necessary to put into common=20
> function. Functions loongson_ipi_core_readl/loongson_ipi_core_writel c=
an=20
> be exported in header file include/hw/intc/loongson_ipi_common.h, or g=
et=20
> MemoryRegionOps of first memoryregion of loongson_ipi instance.
>
> There is pseudo code:

Thanks for your demonstration. I'm still not quite convinced it's worthy=
 to split
but I'm not going to block you if we don't have other oppositions.

Do you mind to finish conversion of loongson_ipi as well? Since you are =
drafting the
design.

>
> static void loongson_ipi_realize(DeviceState *dev, Error **errp)
> {
>      LoongarchIPIState *s =3D LOONGARCH_IPI(dev);
>      LoongarchIPIClass *lic =3D LOONGARCH_IPI_GET_CLASS(s);
>      Error *local_err =3D NULL;
>
>      lic->parent_realize(dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
>
>      ....
>      *do mmio specific implematation in loongson ipi itself*
> }
>
> static void loongson_ipi_class_init(ObjectClass *klass, void *data)
> {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      LoongsonIPICommonClass *licc =3D LOONGSON_IPI_COMMON_CLASS(klass);
>      LoongarchIPIClass *lic =3D LOONGARCH_IPI_CLASS(klass);
>
>      device_class_set_parent_realize(dc, loongson_ipi_realize,=20
> &lic->parent_realize);
>      licc->get_iocsr_as =3D get_iocsr_as;
> }
>
>>=20
>> If current implementation is hindering your future plan can you elabo=
rate so we
>> can work on a resolution.
>>=20
>> I'm happy to help with devlopment and testing.
>>=20
>>>   3. Interace cpu_by_arch_id is added, by default generic function
>>> cpu_by_arch_id() is used to search vcpu from physical cpuid, it is
>>> generic searching method. Different machine may define another search
>>> method such binary searching method.
>>=20
>> If you are going to implement some faster searching algorithm why don=
't we
>>   make it generic for all architectures?
> It depends on the detailed physical id layout, is physical id is growi=
ng=20
> up with logic cpu id or irrelative with logic cpu id? Different=20
> architecture has different logic definition about physical id.

For x86' APIC id and RISC-V's hardid they are all somehow linear.
I'd suggest you to post a RFC patch regarding better algorithm.

Thanks
- Jiaxun
>
> Regards
> Bibo Mao
>
>>=20
>> Thanks
>> - Jiaxun
>>=20
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   hw/intc/loongson_ipi_common.c         | 394 ++++++++++++++++++++++=
++++
>>>   include/hw/intc/loongson_ipi_common.h |  71 +++++
>>>   2 files changed, 465 insertions(+)
>>>   create mode 100644 hw/intc/loongson_ipi_common.c
>>>   create mode 100644 include/hw/intc/loongson_ipi_common.h
>>>
>>> diff --git a/hw/intc/loongson_ipi_common.c
>>> b/hw/intc/loongson_ipi_common.c
>>> new file mode 100644
>>> index 0000000000..f462f24f32
>>> --- /dev/null
>>> +++ b/hw/intc/loongson_ipi_common.c
>>> @@ -0,0 +1,394 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + * Loongson ipi interrupt support
>>> + *
>>> + * Copyright (C) 2021 Loongson Technology Corporation Limited
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/boards.h"
>>> +#include "hw/sysbus.h"
>>> +#include "hw/intc/loongson_ipi_common.h"
>>> +#include "hw/irq.h"
>>> +#include "hw/qdev-properties.h"
>>> +#include "qapi/error.h"
>>> +#include "qemu/log.h"
>>> +#include "exec/address-spaces.h"
>>> +#include "exec/memory.h"
>>> +#include "migration/vmstate.h"
>>> +#include "trace.h"
>>> +
>>> +static MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr add=
r,
>>> +                                           uint64_t *data,
>>> +                                           unsigned size, MemTxAttrs
>>> attrs)
>>> +{
>>> +    IPICore *s =3D opaque;
>>> +    uint64_t ret =3D 0;
>>> +    int index =3D 0;
>>> +
>>> +    addr &=3D 0xff;
>>> +    switch (addr) {
>>> +    case CORE_STATUS_OFF:
>>> +        ret =3D s->status;
>>> +        break;
>>> +    case CORE_EN_OFF:
>>> +        ret =3D s->en;
>>> +        break;
>>> +    case CORE_SET_OFF:
>>> +        ret =3D 0;
>>> +        break;
>>> +    case CORE_CLEAR_OFF:
>>> +        ret =3D 0;
>>> +        break;
>>> +    case CORE_BUF_20 ... CORE_BUF_38 + 4:
>>> +        index =3D (addr - CORE_BUF_20) >> 2;
>>> +        ret =3D s->buf[index];
>>> +        break;
>>> +    default:
>>> +        qemu_log_mask(LOG_UNIMP, "invalid read: %x", (uint32_t)addr=
);
>>> +        break;
>>> +    }
>>> +
>>> +    trace_loongson_ipi_read(size, (uint64_t)addr, ret);
>>> +    *data =3D ret;
>>> +    return MEMTX_OK;
>>> +}
>>> +
>>> +static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr ad=
dr,
>>> +                                            uint64_t *data,
>>> +                                            unsigned size, MemTxAtt=
rs
>>> attrs)
>>> +{
>>> +    LoongsonIPICommonState *ipi =3D opaque;
>>> +    IPICore *s;
>>> +
>>> +    if (attrs.requester_id >=3D ipi->num_cpu) {
>>> +        return MEMTX_DECODE_ERROR;
>>> +    }
>>> +
>>> +    s =3D &ipi->cpu[attrs.requester_id];
>>> +    return loongson_ipi_core_readl(s, addr, data, size, attrs);
>>> +}
>>> +
>>> +static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUSt=
ate
>>> *cpu,
>>> +                                 uint64_t val,
>>> +                                 hwaddr addr, MemTxAttrs attrs)
>>> +{
>>> +    int i, mask =3D 0, data =3D 0;
>>> +    AddressSpace *iocsr_as;
>>> +    LoongsonIPICommonClass *licc =3D LOONGSON_IPI_COMMON_GET_CLASS(=
ipi);
>>> +
>>> +    iocsr_as =3D NULL;
>>> +    if (licc->get_iocsr_as) {
>>> +        iocsr_as =3D licc->get_iocsr_as(cpu);
>>> +    }
>>> +
>>> +    if (!iocsr_as) {
>>> +        return MEMTX_DECODE_ERROR;
>>> +    }
>>> +
>>> +    /*
>>> +     * bit 27-30 is mask for byte writing,
>>> +     * if the mask is 0, we need not to do anything.
>>> +     */
>>> +    if ((val >> 27) & 0xf) {
>>> +        data =3D address_space_ldl_le(iocsr_as, addr, attrs, NULL);
>>> +        for (i =3D 0; i < 4; i++) {
>>> +            /* get mask for byte writing */
>>> +            if (val & (0x1 << (27 + i))) {
>>> +                mask |=3D 0xff << (i * 8);
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    data &=3D mask;
>>> +    data |=3D (val >> 32) & ~mask;
>>> +    address_space_stl_le(iocsr_as, addr, data, attrs, NULL);
>>> +
>>> +    return MEMTX_OK;
>>> +}
>>> +
>>> +static CPUState *get_cpu_by_arch_id(LoongsonIPICommonState *ipi,
>>> uint32_t cpuid)
>>> +{
>>> +    LoongsonIPICommonClass *licc =3D LOONGSON_IPI_COMMON_GET_CLASS(=
ipi);
>>> +
>>> +    if (licc->cpu_by_arch_id) {
>>> +        return licc->cpu_by_arch_id(cpuid);
>>> +    }
>>> +
>>> +    return cpu_by_arch_id(cpuid);
>>> +}
>>> +
>>> +static MemTxResult mail_send(LoongsonIPICommonState *ipi, uint64_t =
val,
>>> +                             MemTxAttrs attrs)
>>> +{
>>> +    uint32_t cpuid;
>>> +    hwaddr addr;
>>> +    CPUState *cs;
>>> +
>>> +    cpuid =3D extract32(val, 16, 10);
>>> +    cs =3D get_cpu_by_arch_id(ipi, cpuid);
>>> +    if (cs =3D=3D NULL) {
>>> +        return MEMTX_DECODE_ERROR;
>>> +    }
>>> +
>>> +    /* override requester_id */
>>> +    addr =3D SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
>>> +    attrs.requester_id =3D cs->cpu_index;
>>> +    return send_ipi_data(ipi, cs, val, addr, attrs);
>>> +}
>>> +
>>> +static MemTxResult any_send(LoongsonIPICommonState *ipi, uint64_t v=
al,
>>> +                            MemTxAttrs attrs)
>>> +{
>>> +    uint32_t cpuid;
>>> +    hwaddr addr;
>>> +    CPUState *cs;
>>> +
>>> +    cpuid =3D extract32(val, 16, 10);
>>> +    cs =3D get_cpu_by_arch_id(ipi, cpuid);
>>> +    if (cs =3D=3D NULL) {
>>> +        return MEMTX_DECODE_ERROR;
>>> +    }
>>> +
>>> +    /* override requester_id */
>>> +    addr =3D val & 0xffff;
>>> +    attrs.requester_id =3D cs->cpu_index;
>>> +    return send_ipi_data(ipi, cs, val, addr, attrs);
>>> +}
>>> +
>>> +static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr ad=
dr,
>>> +                                            uint64_t val, unsigned
>>> size,
>>> +                                            MemTxAttrs attrs)
>>> +{
>>> +    IPICore *s =3D opaque;
>>> +    LoongsonIPICommonState *ipi =3D s->ipi;
>>> +    int index =3D 0;
>>> +    uint32_t cpuid;
>>> +    uint8_t vector;
>>> +    CPUState *cs;
>>> +
>>> +    addr &=3D 0xff;
>>> +    trace_loongson_ipi_write(size, (uint64_t)addr, val);
>>> +    switch (addr) {
>>> +    case CORE_STATUS_OFF:
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "can not be written");
>>> +        break;
>>> +    case CORE_EN_OFF:
>>> +        s->en =3D val;
>>> +        break;
>>> +    case CORE_SET_OFF:
>>> +        s->status |=3D val;
>>> +        if (s->status !=3D 0 && (s->status & s->en) !=3D 0) {
>>> +            qemu_irq_raise(s->irq);
>>> +        }
>>> +        break;
>>> +    case CORE_CLEAR_OFF:
>>> +        s->status &=3D ~val;
>>> +        if (s->status =3D=3D 0 && s->en !=3D 0) {
>>> +            qemu_irq_lower(s->irq);
>>> +        }
>>> +        break;
>>> +    case CORE_BUF_20 ... CORE_BUF_38 + 4:
>>> +        index =3D (addr - CORE_BUF_20) >> 2;
>>> +        s->buf[index] =3D val;
>>> +        break;
>>> +    case IOCSR_IPI_SEND:
>>> +        cpuid =3D extract32(val, 16, 10);
>>> +        /* IPI status vector */
>>> +        vector =3D extract8(val, 0, 5);
>>> +        cs =3D get_cpu_by_arch_id(ipi, cpuid);
>>> +        if (cs =3D=3D NULL || cs->cpu_index >=3D ipi->num_cpu) {
>>> +            return MEMTX_DECODE_ERROR;
>>> +        }
>>> +        loongson_ipi_core_writel(&ipi->cpu[cs->cpu_index],
>>> CORE_SET_OFF,
>>> +                                 BIT(vector), 4, attrs);
>>> +        break;
>>> +    default:
>>> +        qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)add=
r);
>>> +        break;
>>> +    }
>>> +
>>> +    return MEMTX_OK;
>>> +}
>>> +
>>> +static MemTxResult loongson_ipi_iocsr_writel(void *opaque, hwaddr a=
ddr,
>>> +                                            uint64_t val, unsigned
>>> size,
>>> +                                            MemTxAttrs attrs)
>>> +{
>>> +    LoongsonIPICommonState *ipi =3D opaque;
>>> +    IPICore *s;
>>> +
>>> +    if (attrs.requester_id >=3D ipi->num_cpu) {
>>> +        return MEMTX_DECODE_ERROR;
>>> +    }
>>> +
>>> +    s =3D &ipi->cpu[attrs.requester_id];
>>> +    return loongson_ipi_core_writel(s, addr, val, size, attrs);
>>> +}
>>> +
>>> +static const MemoryRegionOps loongson_ipi_iocsr_ops =3D {
>>> +    .read_with_attrs =3D loongson_ipi_iocsr_readl,
>>> +    .write_with_attrs =3D loongson_ipi_iocsr_writel,
>>> +    .impl.min_access_size =3D 4,
>>> +    .impl.max_access_size =3D 4,
>>> +    .valid.min_access_size =3D 4,
>>> +    .valid.max_access_size =3D 8,
>>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>>> +};
>>> +
>>> +/* mail send and any send only support writeq */
>>> +static MemTxResult loongson_ipi_writeq(void *opaque, hwaddr addr,
>>> uint64_t val,
>>> +                                        unsigned size, MemTxAttrs
>>> attrs)
>>> +{
>>> +    MemTxResult ret =3D MEMTX_OK;
>>> +    LoongsonIPICommonState *ipi =3D opaque;
>>> +
>>> +    addr &=3D 0xfff;
>>> +    switch (addr) {
>>> +    case MAIL_SEND_OFFSET:
>>> +        ret =3D mail_send(ipi, val, attrs);
>>> +        break;
>>> +    case ANY_SEND_OFFSET:
>>> +        ret =3D any_send(ipi, val, attrs);
>>> +        break;
>>> +    default:
>>> +       break;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static const MemoryRegionOps loongson_ipi64_ops =3D {
>>> +    .write_with_attrs =3D loongson_ipi_writeq,
>>> +    .impl.min_access_size =3D 8,
>>> +    .impl.max_access_size =3D 8,
>>> +    .valid.min_access_size =3D 8,
>>> +    .valid.max_access_size =3D 8,
>>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>>> +};
>>> +
>>> +static void loongson_ipi_common_realize(DeviceState *dev, Error **e=
rrp)
>>> +{
>>> +    LoongsonIPICommonState *s =3D LOONGSON_IPI_COMMON(dev);
>>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>>> +    int i;
>>> +
>>> +    if (s->num_cpu =3D=3D 0) {
>>> +        error_setg(errp, "num-cpu must be at least 1");
>>> +        return;
>>> +    }
>>> +
>>> +    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev),
>>> +                          &loongson_ipi_iocsr_ops,
>>> +                          s, "loongson_ipi_iocsr", 0x48);
>>> +
>>> +    /* loongson_ipi_iocsr performs re-entrant IO through ipi_send */
>>> +    s->ipi_iocsr_mem.disable_reentrancy_guard =3D true;
>>> +
>>> +    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
>>> +
>>> +    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
>>> +                          &loongson_ipi64_ops,
>>> +                          s, "loongson_ipi64_iocsr", 0x118);
>>> +    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
>>> +
>>> +    s->cpu =3D g_new0(IPICore, s->num_cpu);
>>> +    if (s->cpu =3D=3D NULL) {
>>> +        error_setg(errp, "Memory allocation for IPICore faile");
>>> +        return;
>>> +    }
>>> +
>>> +    for (i =3D 0; i < s->num_cpu; i++) {
>>> +        s->cpu[i].ipi =3D s;
>>> +        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
>>> +    }
>>> +}
>>> +
>>> +static int loongson_ipi_pre_save(void *opaque)
>>> +{
>>> +    LoongsonIPICommonState *s =3D (LoongsonIPICommonState *)opaque;
>>> +    LoongsonIPICommonClass *c =3D LOONGSON_IPI_COMMON_GET_CLASS(s);
>>> +
>>> +    if (c->pre_save) {
>>> +        c->pre_save(s);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int loongson_ipi_post_load(void *opaque, int version_id)
>>> +{
>>> +    LoongsonIPICommonState *s =3D (LoongsonIPICommonState *)opaque;
>>> +    LoongsonIPICommonClass *c =3D LOONGSON_IPI_COMMON_GET_CLASS(s);
>>> +
>>> +    if (c->post_load) {
>>> +        c->post_load(s);
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_ipi_core =3D {
>>> +    .name =3D "ipi-single",
>>> +    .version_id =3D 2,
>>> +    .minimum_version_id =3D 2,
>>> +    .fields =3D (const VMStateField[]) {
>>> +        VMSTATE_UINT32(status, IPICore),
>>> +        VMSTATE_UINT32(en, IPICore),
>>> +        VMSTATE_UINT32(set, IPICore),
>>> +        VMSTATE_UINT32(clear, IPICore),
>>> +        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>> +
>>> +static const VMStateDescription vmstate_loongson_ipi =3D {
>>> +    /* Fixed name to keep compatible */
>>> +    .name =3D "loongson_ipi",
>>> +    .pre_save  =3D loongson_ipi_pre_save,
>>> +    .post_load =3D loongson_ipi_post_load,
>>> +    .version_id =3D 2,
>>> +    .minimum_version_id =3D 2,
>>> +    .fields =3D (const VMStateField[]) {
>>> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu,
>>> LoongsonIPICommonState,
>>> +                                       num_cpu, vmstate_ipi_core,
>>> IPICore),
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>> +
>>> +static Property ipi_properties[] =3D {
>>> +    DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, =
1),
>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void loongson_ipi_common_class_init(ObjectClass *klass, void
>>> *data)
>>> +{
>>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> +
>>> +    dc->realize =3D loongson_ipi_common_realize;
>>> +    device_class_set_props(dc, ipi_properties);
>>> +    dc->vmsd =3D &vmstate_loongson_ipi;
>>> +}
>>> +
>>> +static void loongson_ipi_common_finalize(Object *obj)
>>> +{
>>> +    LoongsonIPICommonState *s =3D LOONGSON_IPI_COMMON(obj);
>>> +
>>> +    g_free(s->cpu);
>>> +}
>>> +
>>> +static const TypeInfo loongson_ipi_common_info =3D {
>>> +    .name          =3D TYPE_LOONGSON_IPI_COMMON,
>>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>>> +    .instance_size =3D sizeof(LoongsonIPICommonState),
>>> +    .class_size    =3D sizeof(LoongsonIPICommonClass),
>>> +    .class_init    =3D loongson_ipi_common_class_init,
>>> +    .instance_finalize =3D loongson_ipi_common_finalize,
>>> +    .abstract =3D true,
>>> +};
>>> +
>>> +static void loongson_ipi_common_register_types(void)
>>> +{
>>> +    type_register_static(&loongson_ipi_common_info);
>>> +}
>>> +
>>> +type_init(loongson_ipi_common_register_types)
>>> diff --git a/include/hw/intc/loongson_ipi_common.h
>>> b/include/hw/intc/loongson_ipi_common.h
>>> new file mode 100644
>>> index 0000000000..1f074863e6
>>> --- /dev/null
>>> +++ b/include/hw/intc/loongson_ipi_common.h
>>> @@ -0,0 +1,71 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + * Loongson ipi interrupt header files
>>> + *
>>> + * Copyright (C) 2021 Loongson Technology Corporation Limited
>>> + */
>>> +
>>> +#ifndef HW_LOONGSON_IPI_COMMON_H
>>> +#define HW_LOONGSON_IPI_COMMON_H
>>> +
>>> +#include "hw/sysbus.h"
>>> +#include "hw/core/cpu.h"
>>> +#include "qom/object.h"
>>> +
>>> +/* Mainy used by iocsr read and write */
>>> +#define SMP_IPI_MAILBOX      0x1000ULL
>>> +#define CORE_STATUS_OFF       0x0
>>> +#define CORE_EN_OFF           0x4
>>> +#define CORE_SET_OFF          0x8
>>> +#define CORE_CLEAR_OFF        0xc
>>> +#define CORE_BUF_20           0x20
>>> +#define CORE_BUF_28           0x28
>>> +#define CORE_BUF_30           0x30
>>> +#define CORE_BUF_38           0x38
>>> +#define IOCSR_IPI_SEND        0x40
>>> +#define IOCSR_MAIL_SEND       0x48
>>> +#define IOCSR_ANY_SEND        0x158
>>> +
>>> +#define MAIL_SEND_ADDR        (SMP_IPI_MAILBOX + IOCSR_MAIL_SEND)
>>> +#define MAIL_SEND_OFFSET      0
>>> +#define ANY_SEND_OFFSET       (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
>>> +
>>> +#define IPI_MBX_NUM           4
>>> +
>>> +#define TYPE_LOONGSON_IPI_COMMON "loongson_ipi_common"
>>> +typedef struct LoongsonIPICommonClass LoongsonIPICommonClass;
>>> +typedef struct LoongsonIPICommonState LoongsonIPICommonState;
>>> +DECLARE_OBJ_CHECKERS(LoongsonIPICommonState, LoongsonIPICommonClass,
>>> +                     LOONGSON_IPI_COMMON, TYPE_LOONGSON_IPI_COMMON)
>>> +
>>> +typedef struct IPICore {
>>> +    LoongsonIPICommonState *ipi;
>>> +    uint32_t status;
>>> +    uint32_t en;
>>> +    uint32_t set;
>>> +    uint32_t clear;
>>> +    /* 64bit buf divide into 2 32bit buf */
>>> +    uint32_t buf[IPI_MBX_NUM * 2];
>>> +    qemu_irq irq;
>>> +} IPICore;
>>> +
>>> +struct LoongsonIPICommonState {
>>> +    SysBusDevice parent_obj;
>>> +    MemoryRegion ipi_iocsr_mem;
>>> +    MemoryRegion ipi64_iocsr_mem;
>>> +    uint32_t num_cpu;
>>> +    IPICore *cpu;
>>> +};
>>> +
>>> +struct LoongsonIPICommonClass {
>>> +    /*< private >*/
>>> +    SysBusDeviceClass parent_class;
>>> +    /*< public >*/
>>> +
>>> +    void (*pre_save)(LoongsonIPICommonState *s);
>>> +    void (*post_load)(LoongsonIPICommonState *s);
>>> +    AddressSpace *(*get_iocsr_as)(CPUState *cpu);
>>> +    CPUState *(*cpu_by_arch_id)(int64_t id);
>>> +};
>>> +
>>> +#endif
>>> --=20
>>> 2.39.3
>>

--=20
- Jiaxun

