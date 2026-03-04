Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB9CEB7EB6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxikh-0001FU-23; Wed, 04 Mar 2026 04:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxikR-0001BG-06
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:42:31 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxikM-0007wG-V4
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:42:29 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b8a3f2bcso2407800f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 01:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772617337; x=1773222137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTLl1aQL5VZvOfSF61QILN3tARcDbPTY7qmSIJwbLIA=;
 b=VVFA3Q8eClWhOG81xLkHUrzsmurbBYxJoQIp+N+4MHTHdfq9g54z98RDFwar610HRo
 sudFfh6AMrH6X+IrckOmmzgJQkOwVsRnKS01k1zI6to36AyOHYNmC7UA0GctA/3oBnrE
 0hJuDv0dz9uoea0qQ8Qp14kYwcrgYk5RkUo67nCLLOtBY8tg2kut0QtmCfQKHMfdF6G4
 viv1wtOZrDdcqkuZsW4ya4EiyWDlgPNHbv4K0T0hX1/DwptVQ392Ro+F79TGwvVlMUrW
 pS7aIlvLiqqlrW99cOhozBiubKCKM+ITVISOnp94LuiTqy8LXPrsTrmhzy67roxxsX1Q
 56cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772617337; x=1773222137;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NTLl1aQL5VZvOfSF61QILN3tARcDbPTY7qmSIJwbLIA=;
 b=q0eQCfTJBLVT3QVxHkxfxySPhBakaIyedFQ2PWuSm1DRm/hyIRXWkT4OSCvNv6U7lR
 mNdAo1yFGG4V5bFUEE3xpgqVV/lxMHSOoYWsXma4icSTfwoiq0DqmoTROj4z0CgXyXLN
 lOH3YaMHe9tn7Sy+niYNYynuCdC1XfP57va2OFCE5/hzywVqeVP9i2cvT7QptIIj6h8n
 In+A0Xxb2cgYBoNZ1QwsXtAr29tZPSi5o9bykoZupJ4cdhI+VXq6sX87+uHp8fQbno8k
 QDQSoZ9k2OBneiURE4bZXf71GaoJ22fTcEq6VYQbme0pX7Tr3gG5LiNHF9Z9B47+6d2n
 Z8dQ==
X-Gm-Message-State: AOJu0YzH7igrU6EdZdbAT1bt0dhYeW0uVjnVSMHG4epwFFZHX+ZUfOVi
 VtdTkndqFldWCNFB0GFgoZrtsoKgVPNlS51K/j8f1Z0b7yVtXwV6arsh
X-Gm-Gg: ATEYQzzUvoXtAc0ahA8jCfROElLfsHHOHf2g56e1SIl05GvlEgaYeifYANRBlEIqi2J
 kgU87PhJSY9OFxzYmWU9nZR+qoWaNUZyxNfhSCQqi7In39rCCKjOINB1CPbVqYgEs/oZdgyV/bB
 6sL9duauBHr1phOiv9L7YiLYXmCtC4OTo918rnjCKtgiHwFudHEDL9+XfElhe6ryBv9seEmo3at
 W6K/JsfLZNmhe+Kmqbzi3ESqSfU0+ve4AP4bVQNWc0BdTqkfSeaNMWHCVBfFavhis2LIAFK9qry
 IJk21B2iOK8Wdnf3+esKpkuzSsI3Vqt4oOD5XsY2v+aApsx270GIWDdREx3kN2bdlA9OYnMwj2b
 nS1n/yjfslJKtjp5cujhYRJTZD0KhTrFgGTSsYGsPlr5qmAh48hLz89IIUgmXDiD0gURPGuFjtB
 kgg6rDuiaDHEdQmeEY5XDvcwpH3TYzNWAphNr96TI/1Cm8egelnNpwbGzK5G97VMr7jQoGfrTh+
 PoT2ntzk6Hp
X-Received: by 2002:a05:600c:8284:b0:477:7af8:c8ad with SMTP id
 5b1f17b1804b1-485198a3e3amr20890555e9.31.1772617336808; 
 Wed, 04 Mar 2026 01:42:16 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-077-191-023-054.77.191.pool.telefonica.de. [77.191.23.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851a895553sm20680165e9.1.2026.03.04.01.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 01:42:16 -0800 (PST)
Date: Wed, 04 Mar 2026 08:45:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 11/13] hw/char/serial: Keep MemoryRegionOps private
In-Reply-To: <d77f00da-83b9-4499-5458-305eaf9f1470@eik.bme.hu>
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-12-shentey@gmail.com>
 <8a363801-914d-7870-3b1b-a4c9182ba4cc@eik.bme.hu>
 <d77f00da-83b9-4499-5458-305eaf9f1470@eik.bme.hu>
Message-ID: <725AC957-EB25-4FEC-8AFC-8C6FB9293509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 4=2E M=C3=A4rz 2026 01:33:34 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Tue, 3 Mar 2026, BALATON Zoltan wrote:
>> On Tue, 3 Mar 2026, Bernhard Beschow wrote:
>>> Rather than requiring users of TYPE_SERIAL to initialize the MMIO regi=
on
>>> themselves, make it generic enough to be configured via properties=2E =
This
>>> makes TYPE_SERIAL more self-contained and prepares it for being turned
>>> into a SysBusDevice=2E
>>>=20
>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>> ---
>>> include/hw/char/serial-mm=2Eh |  3 --
>>> include/hw/char/serial=2Eh    |  4 +-
>>> hw/char/diva-gsp=2Ec          |  5 ---
>>> hw/char/serial-isa=2Ec        |  1 -
>>> hw/char/serial-mm=2Ec         | 51 -------------------------
>>> hw/char/serial-pci-multi=2Ec  |  5 ---
>>> hw/char/serial-pci=2Ec        |  1 -
>>> hw/char/serial=2Ec            | 76 ++++++++++++++++++++++++++++++-----=
--
>>> 8 files changed, 66 insertions(+), 80 deletions(-)
>>>=20
>>> diff --git a/include/hw/char/serial-mm=2Eh b/include/hw/char/serial-mm=
=2Eh
>>> index 0076bdc061=2E=2E4c18e2a609 100644
>>> --- a/include/hw/char/serial-mm=2Eh
>>> +++ b/include/hw/char/serial-mm=2Eh
>>> @@ -39,9 +39,6 @@ struct SerialMM {
>>>     SysBusDevice parent;
>>>=20
>>>     SerialState serial;
>>> -
>>> -    uint8_t regshift;
>>> -    uint8_t endianness;
>>> };
>>=20
>> This effectively makes TYPE_SERIAL the same as TYPE_SERIAL_MM so you co=
uld just merge the two and have everything embed a SERIAL_MM device=2E But =
the idea here is to make TYPE_SERIAL a superclass of all serial devices and=
 SERIAL_MM is the memory mapped version=2E Memory mapped devices are usuall=
y SysBusDevices but others are not so this seems to be trying to model thin=
gs in the wrong way=2E Maybe you could just add accessor functions to TYPE_=
SERIAL to get the memory regions and use that from subclasses to avoid poki=
ng in the state struct and not try to reuse SysBusDevice for this=2E
>
>Or instead of TYPE_SERIAL exporting memory regions it could export ops or=
 functions for it (like PCI IDE or PCI does) and let subclasses implement t=
he regions that call these exported functions with the register layout they=
 need?

You mean by pushing the MemoryRegion objects into the individual users, i=
=2Ee=2E every user would provide its own io attribute? That would certainly=
 work and I've proposed that before (I think in the series where we made se=
rial-isa moveable)=2E That was criticized so I went with the current approa=
ch=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

