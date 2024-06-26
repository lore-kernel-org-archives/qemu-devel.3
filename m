Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34669C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 07:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMNGr-0006cd-Ac; Wed, 26 Jun 2024 03:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMNGn-0006cG-PQ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:40:45 -0400
Received: from fhigh1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMNGl-00063C-KM
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:40:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 6BBC511403A0;
 Wed, 26 Jun 2024 03:40:41 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 26 Jun 2024 03:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719387641;
 x=1719474041; bh=Hmv5WvIOM9cRrd1NI/LNp1nh6tspIu+PsY6k+RrXjzw=; b=
 m+c6deknbtiWTaEs8AvXUctfmqasuH1MvOR0XoB5CSdeO9sy1tFW6HKi+dMWlIPE
 JA9HTKNpCdNBnEH0sk5sRYfSW04POp67rJrhb9a7Gxci1Iz3TdzywlQKtTjDDMP5
 4x9RaPlQNDg9InYJXQWta1JpRq/lKLxQ8c3AjETBVtWh7unTqVqsMBTffylzx663
 RGVM2IP68/Q2BZVH71GZ2imLS57oDUJLK4lX+lRtjqSuwUypULEvEDi6vNtUZRc9
 1O92UuNTOq4VJzjf+2bFP5M6HX89fvcoUUKsLSYF7emUp7aFKrNvcwbBaqbeAQrO
 dBmRFif4KeTPN2BtFIExTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719387641; x=
 1719474041; bh=Hmv5WvIOM9cRrd1NI/LNp1nh6tspIu+PsY6k+RrXjzw=; b=V
 lm6dNS6ILt8JGfZZdz1i1KxNTimyho9nQarx2VBtra8vWRu8bnwx+4BaOFs3zqPx
 sIdPT82gDVEBW4Txaq76sgcr7lkeR8WtWC0fquN3S2rR1wEMWgndEyxaK4Lq6vh3
 9K84m8tPUAaExfWOtRMYTmiauZDRoXk/PqFtg2M8hE2Lom36KcT/+CXzcfthU1fA
 rr+78Teo1o4Om4R9hapP53gg0v67LBdSI/ADX+WSHdDvFOw1JePfHECg+7HbBgGT
 1g0NOKE83PVdN0PAeoCloKgfzp/5Fa1Q3x7zjd1Y8wjamf55gdWm2PFa7RLaKuEj
 SPscVct/np2vO/IoEvnGA==
X-ME-Sender: <xms:-MV7ZlDMQNvY_FsdMns5jaG6MEzYB0vswyOKvcLSDFhlEPe2igKpvw>
 <xme:-MV7Zjj63JM6dVHaHGAMNdy9AYA1rwGWq0YCyFd7xmPwtY9hhbQXmlMUnWkJHJjEz
 Ar9P35e9KwwWGcKPc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddugdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:-MV7Zgky5bAvaXsUZ0hfhXbMERJ6Y9IhmoCwQQlwYFQRBJ_k5V9BXg>
 <xmx:-cV7ZvzPuW9FfnRW-IdrK0ECeywSoIyMArZw-7u_scLN1LcFCFL32A>
 <xmx:-cV7ZqS6jQNJqH7cUhGJCzdWm33DGZebXdfVVWBRUOPi6VYYZfPQ3w>
 <xmx:-cV7ZiZsHqEPa4J1ir1uFa8VaIFFc8Pq5ZarCt3sWYNx6YpiY2i-IQ>
 <xmx:-cV7ZgNTgNZlGlEIQ-J-cOkd4ouTOOEs6bjJv1bsmzR3QODvQjaRBCGD>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D875436A0074; Wed, 26 Jun 2024 03:40:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
MIME-Version: 1.0
Message-Id: <a08de6f3-3e7d-4ea4-8595-c047b4880a58@app.fastmail.com>
In-Reply-To: <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
 <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
Date: Wed, 26 Jun 2024 08:40:22 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Song Gao" <gaosong@loongson.cn>
Subject: Re: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.152;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh1-smtp.messagingengine.com
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
=8D=885:11=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
[...]
> It is different with existing implementation.
What do you mean? Isn't this the actual hardware behaviour?

>
> With hw/intc/loongson_ipi.c, every vcpu has one ipi_mmio_mem, however =
on=20
> loongarch ipi machine, there is no ipi_mmio_mem memory region.
> So if machine has 256 vcpus, there will be 256 ipi_mmio_mem memory=20
> regions. In function sysbus_init_mmio(), memory region can not exceed
> QDEV_MAX_MMIO (32).  With so many memory regions, it slows down memory
> region search speed also.
Ouch, never thought about that before, but I think we can control the
registration of sysbus_mmio with a device property or even ifdef so Loon=
gArch
machine won't be affected.

For MIPS loongson3-virt machine, our CPU number is capped, so that won't
be a problem.

I'm currently travelling without access to my PC, I'll prepare a patch
as soon as I gain access again. Feel free to send a patch before me with
this approach if you desperately want to fix it.

>
> void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
> {
>      int n;
>
>      assert(dev->num_mmio < QDEV_MAX_MMIO);
>      n =3D dev->num_mmio++;
>      dev->mmio[n].addr =3D -1;
>      dev->mmio[n].memory =3D memory;
> }
>
> Can we revert this patch? We want to do production usable by real user=
s=20
> rather than show pure technology.

I don't really get your point, we have at leat 4 real users requesting S=
MP
support for loongson3-virt on gitlab issues, plus I need this to test
MIPS/Loongson64 SMP kernel.

If there is a problem with your use case, we can fix it. Why we do want =
to
remove the functionality when there is an easy fix?

It=E2=80=99s not only the features necessary for you that made QEMU an o=
utstanding
project; it=E2=80=99s everything coming together that completes it.

Thanks
- Jiaxun
>
> Regards
> Bibo Mao
>
>> -
>> -    s->cpu =3D g_new0(IPICore, s->num_cpu);
>> -    if (s->cpu =3D=3D NULL) {
>> -        error_setg(errp, "Memory allocation for ExtIOICore faile");
>> -        return;
>> -    }
>> -
>> -    for (i =3D 0; i < s->num_cpu; i++) {
>> -        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
>> -    }
>> -}
>> -
>> -static const VMStateDescription vmstate_ipi_core =3D {
>> -    .name =3D "ipi-single",
>> -    .version_id =3D 2,
>> -    .minimum_version_id =3D 2,
>> -    .fields =3D (const VMStateField[]) {
>> -        VMSTATE_UINT32(status, IPICore),
>> -        VMSTATE_UINT32(en, IPICore),
>> -        VMSTATE_UINT32(set, IPICore),
>> -        VMSTATE_UINT32(clear, IPICore),
>> -        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
>> -        VMSTATE_END_OF_LIST()
>> -    }
>> -};
>> -
>> -static const VMStateDescription vmstate_loongarch_ipi =3D {
>> -    .name =3D TYPE_LOONGARCH_IPI,
>> -    .version_id =3D 2,
>> -    .minimum_version_id =3D 2,
>> -    .fields =3D (const VMStateField[]) {
>> -        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchIPI, num_=
cpu,
>> -                         vmstate_ipi_core, IPICore),
>> -        VMSTATE_END_OF_LIST()
>> -    }
>> -};
>> -
>> -static Property ipi_properties[] =3D {
>> -    DEFINE_PROP_UINT32("num-cpu", LoongArchIPI, num_cpu, 1),
>> -    DEFINE_PROP_END_OF_LIST(),
>> -};
>> -
>> -static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
>> -{
>> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> -
>> -    dc->realize =3D loongarch_ipi_realize;
>> -    device_class_set_props(dc, ipi_properties);
>> -    dc->vmsd =3D &vmstate_loongarch_ipi;
>> -}
>> -
>> -static void loongarch_ipi_finalize(Object *obj)
>> -{
>> -    LoongArchIPI *s =3D LOONGARCH_IPI(obj);
>> -
>> -    g_free(s->cpu);
>> -}
>> -
>> -static const TypeInfo loongarch_ipi_info =3D {
>> -    .name          =3D TYPE_LOONGARCH_IPI,
>> -    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> -    .instance_size =3D sizeof(LoongArchIPI),
>> -    .class_init    =3D loongarch_ipi_class_init,
>> -    .instance_finalize =3D loongarch_ipi_finalize,
>> -};
>> -
>> -static void loongarch_ipi_register_types(void)
>> -{
>> -    type_register_static(&loongarch_ipi_info);
>> -}
>> -
>> -type_init(loongarch_ipi_register_types)
>>

--=20
- Jiaxun

