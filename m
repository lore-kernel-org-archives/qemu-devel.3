Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B329C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 10:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMPVM-0001UL-Hz; Wed, 26 Jun 2024 06:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMPVH-0001U2-C9
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 06:03:51 -0400
Received: from fout6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMPVF-0000F8-5G
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 06:03:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 548B313804E0;
 Wed, 26 Jun 2024 06:03:48 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 26 Jun 2024 06:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719396228;
 x=1719482628; bh=EU4XE3ChiOFv3NN9m422x1OFFgwPPE+qiKAwO0nhhW8=; b=
 ko3v1GjsKVq1DyiHgvmniV5HJkRE7iCuibqTZxfcNMwfRANdxqiRr3y8lPmnctaP
 IiuH4O6l1zM1xC0FCJezaY/hleImSkgjy9lySzg9di6NiFlhlLxLPBYu4zGMphaT
 OwiKscGRN007+XSP7dOFOzY6BQXyjltfZTCcVPufbFnILW01eg+dZjcPO4/uoM+L
 MB7iUMCatNhu/KYGtU6ErG3HRzLGpNp5qxUOaDMKV91BAMdWL7kTC3mIliOYY/ei
 4TrJkQGPFVryZv+qsvdhRsM3A3EA4khEfk7kCyCeyJjM6Of1RkUxJR8qQYHp7bzf
 FeugwzgqfOlhqJL9l65l2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719396228; x=
 1719482628; bh=EU4XE3ChiOFv3NN9m422x1OFFgwPPE+qiKAwO0nhhW8=; b=o
 +OuwazxOzUrN7jydlSuGdpFTCsCO4CPTUnWvdc2ee7nUtCzgZAoLs6qtANPdYM7A
 2m3CJlqLmRia0Ty34EROXlxNhJ0O8XfjZ5WUNG/TLYYWTlZF9xgK5M0LVVJB07Jn
 rbUBU/jDb6GeYEvfiFSsj6n+7/GofpWnVEeMBcAbaAbH2ekSfplF0jNK5Ip0IlaT
 5LBqdzksgvF4T8WcYc8qcfFW6mgyeoWCUsApmRltCa8FPPm7XuOapxf3OTgrQsum
 jJPEQsIOhHgAeADLdffo54jXup4oHw+7f3xXYrclqI+d1Q8KgHghaI4K974XVpPn
 nzOkCg0raNc/x7PVGhJ0w==
X-ME-Sender: <xms:g-d7Zj6BIu7Ob4-JbNUXDHbhfpQvaAcyfY5jFJWIHvWSjGy8FHs98A>
 <xme:g-d7Zo7X7JVLd3TftH4I4lPNasxZuTEE8fZ1zzZ3IOkaxZ5BA-EZfaWYQxC4UNhFE
 gmKKU-N9GorAP1nAoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddvgddvfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
 geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:g-d7ZqezyXG6GFlxMy8d4ArJnmnzcj6-dwPFg4cvuIrNt3Mg8BcY5w>
 <xmx:g-d7ZkL0IF9ZkBBVG6xjbVv8lMaT9udw-nPY-zxMklzLZiZTKXxi2g>
 <xmx:g-d7ZnIQl8FBL0jLLo2ASmlP6X2wEO-mPq04oSIikMQcw5h9eSOEHA>
 <xmx:g-d7ZtwIF6yws8Lc4x9ymA6Gf6T6xl7jQSIo8vE7KMXHWgpMdokt7Q>
 <xmx:hOd7ZkGCHVaZamGtU7_yQAf6fEFEgZ_8Nbt_js51BxZOh5lJp0_9otOS>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 81D9C36A0074; Wed, 26 Jun 2024 06:03:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
MIME-Version: 1.0
Message-Id: <6c5e124a-d16c-4b4f-8493-c71054d9ff68@app.fastmail.com>
In-Reply-To: <775c3f6c-d119-565a-ffbe-976e790da146@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
 <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
 <a08de6f3-3e7d-4ea4-8595-c047b4880a58@app.fastmail.com>
 <775c3f6c-d119-565a-ffbe-976e790da146@loongson.cn>
Date: Wed, 26 Jun 2024 11:03:12 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Song Gao" <gaosong@loongson.cn>
Subject: Re: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout6-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8826=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=888:51=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
> On 2024/6/26 =E4=B8=8B=E5=8D=883:40, Jiaxun Yang wrote:
>>=20
>>=20
>> =E5=9C=A82024=E5=B9=B46=E6=9C=8826=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=
=E5=8D=885:11=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
>> [...]
>>> It is different with existing implementation.
>> What do you mean? Isn't this the actual hardware behaviour?
>>=20
>>>
>>> With hw/intc/loongson_ipi.c, every vcpu has one ipi_mmio_mem, howeve=
r on
>>> loongarch ipi machine, there is no ipi_mmio_mem memory region.
>>> So if machine has 256 vcpus, there will be 256 ipi_mmio_mem memory
>>> regions. In function sysbus_init_mmio(), memory region can not exceed
>>> QDEV_MAX_MMIO (32).  With so many memory regions, it slows down memo=
ry
>>> region search speed also.
>> Ouch, never thought about that before, but I think we can control the
>> registration of sysbus_mmio with a device property or even ifdef so L=
oongArch
>> machine won't be affected.
>>=20
>> For MIPS loongson3-virt machine, our CPU number is capped, so that wo=
n't
>> be a problem.
>>=20
>> I'm currently travelling without access to my PC, I'll prepare a patch
>> as soon as I gain access again. Feel free to send a patch before me w=
ith
>> this approach if you desperately want to fix it.
>>=20
>>>
>>> void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
>>> {
>>>       int n;
>>>
>>>       assert(dev->num_mmio < QDEV_MAX_MMIO);
>>>       n =3D dev->num_mmio++;
>>>       dev->mmio[n].addr =3D -1;
>>>       dev->mmio[n].memory =3D memory;
>>> }
>>>
>>> Can we revert this patch? We want to do production usable by real us=
ers
>>> rather than show pure technology.
>>=20
>> I don't really get your point, we have at leat 4 real users requestin=
g SMP
>> support for loongson3-virt on gitlab issues, plus I need this to test
>> MIPS/Loongson64 SMP kernel.
>>=20
>> If there is a problem with your use case, we can fix it. Why we do wa=
nt to
>> remove the functionality when there is an easy fix?
> I do not think we have the ability to abstract hw and continuous=20
> maintenance for two different architecture, including you and me.

After all it=E2=80=99s the same IP block, I fail to see any reason to im=
plement it separately.

I perfectly understand that piece of hardware IP and I fix broken stuff =
in this driver time by time.

I understand how does it work on LoongArch systems so I make my best eff=
ort to cover LoongArch part.

There might be some edge cases that I missed, and I=E2=80=99ll be thankf=
ul for reports or assistance.

The approach of shared drivers for LoongArch/MIPS works so well in kerne=
l development, for QEMU I believe it=E2=80=99s also desirable.

I=E2=80=99m not asking you or Loongson to maintain any MIPS/Loongson rel=
ated features, I=E2=80=99ll take care of them if things go wrong.

>lp
> So I suggest that different files will be better for the present. Afte=
r=20
> one year or later, if we have further understanding about system, it i=
s=20
> ok to merge them into one file.

If there is anything not clear to you on both MIPS and LoongArch side pl=
ease let me know, I=E2=80=99m happy to help.

We promote code reuse in QEMU to minimize maintenance burden.

Thanks

>
> Regards
> Bibo Mao
>>=20
>> It=E2=80=99s not only the features necessary for you that made QEMU a=
n outstanding
>> project; it=E2=80=99s everything coming together that completes it.
>>=20
>> Thanks
>> - Jiaxun
>>>
>>> Regards
>>> Bibo Mao
>>>
>>>> -
>>>> -    s->cpu =3D g_new0(IPICore, s->num_cpu);
>>>> -    if (s->cpu =3D=3D NULL) {
>>>> -        error_setg(errp, "Memory allocation for ExtIOICore faile");
>>>> -        return;
>>>> -    }
>>>> -
>>>> -    for (i =3D 0; i < s->num_cpu; i++) {
>>>> -        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
>>>> -    }
>>>> -}
>>>> -
>>>> -static const VMStateDescription vmstate_ipi_core =3D {
>>>> -    .name =3D "ipi-single",
>>>> -    .version_id =3D 2,
>>>> -    .minimum_version_id =3D 2,
>>>> -    .fields =3D (const VMStateField[]) {
>>>> -        VMSTATE_UINT32(status, IPICore),
>>>> -        VMSTATE_UINT32(en, IPICore),
>>>> -        VMSTATE_UINT32(set, IPICore),
>>>> -        VMSTATE_UINT32(clear, IPICore),
>>>> -        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
>>>> -        VMSTATE_END_OF_LIST()
>>>> -    }
>>>> -};
>>>> -
>>>> -static const VMStateDescription vmstate_loongarch_ipi =3D {
>>>> -    .name =3D TYPE_LOONGARCH_IPI,
>>>> -    .version_id =3D 2,
>>>> -    .minimum_version_id =3D 2,
>>>> -    .fields =3D (const VMStateField[]) {
>>>> -        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchIPI, nu=
m_cpu,
>>>> -                         vmstate_ipi_core, IPICore),
>>>> -        VMSTATE_END_OF_LIST()
>>>> -    }
>>>> -};
>>>> -
>>>> -static Property ipi_properties[] =3D {
>>>> -    DEFINE_PROP_UINT32("num-cpu", LoongArchIPI, num_cpu, 1),
>>>> -    DEFINE_PROP_END_OF_LIST(),
>>>> -};
>>>> -
>>>> -static void loongarch_ipi_class_init(ObjectClass *klass, void *dat=
a)
>>>> -{
>>>> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
>>>> -
>>>> -    dc->realize =3D loongarch_ipi_realize;
>>>> -    device_class_set_props(dc, ipi_properties);
>>>> -    dc->vmsd =3D &vmstate_loongarch_ipi;
>>>> -}
>>>> -
>>>> -static void loongarch_ipi_finalize(Object *obj)
>>>> -{
>>>> -    LoongArchIPI *s =3D LOONGARCH_IPI(obj);
>>>> -
>>>> -    g_free(s->cpu);
>>>> -}
>>>> -
>>>> -static const TypeInfo loongarch_ipi_info =3D {
>>>> -    .name          =3D TYPE_LOONGARCH_IPI,
>>>> -    .parent        =3D TYPE_SYS_BUS_DEVICE,
>>>> -    .instance_size =3D sizeof(LoongArchIPI),
>>>> -    .class_init    =3D loongarch_ipi_class_init,
>>>> -    .instance_finalize =3D loongarch_ipi_finalize,
>>>> -};
>>>> -
>>>> -static void loongarch_ipi_register_types(void)
>>>> -{
>>>> -    type_register_static(&loongarch_ipi_info);
>>>> -}
>>>> -
>>>> -type_init(loongarch_ipi_register_types)
>>>>
>>

--=20
- Jiaxun

