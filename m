Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2307DD0E6C7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNrfE-0003Gx-Vv; Tue, 25 Nov 2025 06:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNrew-000330-9y
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:56:43 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNres-0001Ts-R3
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:56:37 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779d8286d8so5328195e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 03:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764071791; x=1764676591; darn=nongnu.org;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kyw4befvI18aymVdMUr3l27qAPs4Z/qz6RNj8ukU1M=;
 b=O+g92Q9g9z4u0Rtn1y0IVbHFYod1yBNC2IoupR3EWLvpgeDNXjcOfuohrCYfeGt774
 5f8us6IQk3NRy74FViuDROfm90hoP+jsGDYDwMS6S4gZdOEyEqU/s+Quio+5xnwIFUI1
 ORB2Me/cbRtNxfOulcEmOccnVLxawdYauKXJRZbcginohBFjx5Ci/857w3Ew6Rl3sR/S
 a6t6Nq81+/aheMf4BX8TuUO3YS5xC6IAnTAu3cKQBiKXN1Ndk2bfDfBUq1fdWbzqqqRg
 eW72V3LsXpG9nuj9+d56Koay4wr4vf0S4eFakVL6xnv7OcfjhOzqqklgCVf390fHh3ae
 nD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764071791; x=1764676591;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7kyw4befvI18aymVdMUr3l27qAPs4Z/qz6RNj8ukU1M=;
 b=n2dVBiK2eVjBk0KmENzExxogRmYqPIIWEGWz0pqmau9KremXHrButPftffOsOGmRxs
 QR64b/mpy4+Vny8uYoz5zIjH1IB62LHtSY072NZkZQ3BmKLwKSdR2QcnqJAzuD9/C+Wv
 U60YoUve09HzEvU+OIriZG7ejj48GTDkLj2i624/p3YpY3SjS73J39ww6bQMc7tcfxdp
 eD2yu6ryb+0gKQrwrTqA7rFLVvYE3/IRVZtUzZHO6E2hQs0z6wYmfGmkeqSbOI6xl7lj
 iDSWqMhAXSGM0pXN3CvSHXQFhAobplQB+nLN+UK4myD/DInIevGvPhFD2bFZw/ISH0MV
 72VQ==
X-Gm-Message-State: AOJu0YwTAg4g0AsTZhsGy+GISW1EQjG5mkiuFJ+g+blmRUHDOGBrDoCJ
 i0G2OqALEXO0G/ufxuoFa5+pNaVlZHs7oGYAN3uy6NpnXZ8lQs0mmXx58QgBSMuyOaU=
X-Gm-Gg: ASbGncuLY+1cLqYAxAwYQiuojbopNojIjtusdNEOk7qDO6XwoFlkxw6jVUWGUPaGMLJ
 S4Se+o+O7G2SFxbjr+b2as7MUTJQS92hhT8bsSjJnLUoCGYKfyh49LFYZ9GObIHBWA8IttC6JqV
 G8O5Ndauby2FdF/B7jJ7J2XjDd6sPzT/v8jxWi8Ygq6NKU4bltdT5MrCDeJmfd3qZw88qujFzWs
 5L9nSJCpOJtuWgSP7CObzcf16ymyx0lE8l1xmVkPL1GevSeEAjFkB5nyZv9VcdaS/Tm3HwAovO+
 +blBJgMBfTYVQnsfrYqq9ZdYOEwazvUqLDA81+p4Th2EDfMwGF1pFkud1Su9AL5JPn+dt28niBH
 yh5AGI+U/7HS/YTilhH9OKPkUxBVQN+BsiHXTAGW90iHdRi/bPwaLqsErk8TJihIIkNSFMKBapc
 k=
X-Google-Smtp-Source: AGHT+IFZTloe7LfpQtOsFEgjeDg6mpCEPL60xSAbEXBCcFV273O4wWK1+hQSkcnsrqw5+pCP+XgO5A==
X-Received: by 2002:a05:600c:1551:b0:477:555b:3411 with SMTP id
 5b1f17b1804b1-477c2ef91d3mr80375375e9.1.1764071790520; 
 Tue, 25 Nov 2025 03:56:30 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-477bf3ba1b4sm251521605e9.15.2025.11.25.03.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 03:56:30 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 12:55:54 +0100
Message-Id: <DEHR8WGZCTQW.3GFZR4PZNGOAH@ventanamicro.com>
To: "Drew Fustini" <fustini@kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH 3/7] hw/riscv: implement CBQRI capacity controller
Cc: <qemu-devel@nongnu.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <Alistair.Francis@wdc.com>, "Weiwei Li"
 <liwei1518@gmail.com>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Nicolas
 Pitre" <npitre@baylibre.com>, =?utf-8?q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>, "Atish Kumar Patra" <atishp@rivosinc.com>, "Atish
 Patra" <atish.patra@linux.dev>, "Vasudevan Srinivasan" <vasu@rivosinc.com>,
 "yunhui cui" <cuiyunhui@bytedance.com>, "Chen Pei"
 <cp0613@linux.alibaba.com>, <guo.wenjia23@zte.com.cn>,
 <liu.qingtao2@zte.com.cn>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-3-3392fc760e48@kernel.org>
 <DEDROLF9I9YQ.2MQIEGB7I4BKH@ventanamicro.com> <aSDCmrvONUgvzqbV@x1>
 <DEH356RBYAIG.IS7SP4D5XLIQ@ventanamicro.com> <aSSl6+i5fa4+kD3Q@x1>
In-Reply-To: <aSSl6+i5fa4+kD3Q@x1>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-11-24T10:37:31-08:00, Drew Fustini <fustini@kernel.org>:
> On Mon, Nov 24, 2025 at 06:02:37PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>> 2025-11-21T11:50:50-08:00, Drew Fustini <fustini@kernel.org>:
>> > On Thu, Nov 20, 2025 at 08:25:44PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 =
wrote:
>> >> 2025-11-19T16:42:19-08:00, Drew Fustini <fustini@kernel.org>:
>> >> > +static void riscv_cbqri_cc_realize(DeviceState *dev, Error **errp)
>> >> > +{
>> >> > +    RiscvCbqriCapacityState *cc =3D RISCV_CBQRI_CC(dev);
>> >> > +
>> >> > +    if (!cc->mmio_base) {
>> >> > +        error_setg(errp, "mmio_base property not set");
>> >> > +        return;
>> >> > +    }
>> >> > +
>> >> > +    assert(cc->mon_counters =3D=3D NULL);
>> >> > +    cc->mon_counters =3D g_new0(MonitorCounter, cc->nb_mcids);
>> >> > +
>> >> > +    assert(cc->alloc_blockmasks =3D=3D NULL);
>> >> > +    uint64_t *end =3D get_blockmask_location(cc, cc->nb_rcids, 0);
>> >> > +    unsigned int blockmasks_size =3D end - cc->alloc_blockmasks;
>> >> > +    cc->alloc_blockmasks =3D g_new0(uint64_t, blockmasks_size);
>> >> > +
>> >> > +    memory_region_init_io(&cc->mmio, OBJECT(dev), &riscv_cbqri_cc_=
ops,
>> >> > +                          cc, TYPE_RISCV_CBQRI_CC".mmio", 4 * 1024=
);
>> >>=20
>> >> Shouldn't the region size take cc->ncblks into account?
>> >> (A bitmask for 2^16 ids is 8kB.)
>> >
>> > cc_block_mask field is BMW / 8. In the case of NCBLKS of 12 and NCBLKS
>> > of 16, both end up with a BMW of 64 which would be 8 bytes. I think th=
e
>> > the only reason the allocation is 4KB is that is meant to be aligned t=
o
>> > the page size. Otherwise, the capacity controller register layout is
>> > pretty small.
>>=20
>> I understood NCBLKS as the amount of bits in the capacity bitmask, and
>> NCBLKS in encoded in a 16 bit field, which means up to 65536 bits.
>> Is there a lower limit?
>
> Ah, yes, thank you for correcting me. NCBLKS can be 2^16 therefore BMW
> can be 8 KB:=20
>
> x =3D 65536
> x +=3D 63 =3D> 65599
> x /=3D 64 =3D> 1024
> x *=3D 64 =3D> BMW is 65536 bits
> cc_block_mask =3D BMW/8 =3D 8192 bytes
>
> This would yield capacity register layout:
>
> cc_capabilities	8
> cc_mon_ctl	8
> cc_mon_ctr_val	8
> cc_alloc_ctl	8
> cc_block_mask	8192
> cc_cunits	8
>
> Thus I think the mmio size would need to be: (BMW/8) + 40
>
> In the max NCBLKS case, that would be 8,232 bytes. I am wondering if
> that a problem as it would not be aligned on a 4 KB page boundary. Do
> you think that would be a problem?

memory_region_init_io will handle it, and I think it is actually better
to specify the exact size.

Thanks.

