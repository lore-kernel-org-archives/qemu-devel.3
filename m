Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218CDC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trh66-0005FF-Co; Mon, 10 Mar 2025 13:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1trh5m-00056E-50; Mon, 10 Mar 2025 13:39:06 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1trh5j-0004td-Cr; Mon, 10 Mar 2025 13:39:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3913cf69784so2604326f8f.1; 
 Mon, 10 Mar 2025 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741628339; x=1742233139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xr2Y+MevTuIvJzsA1IaemgzQ4R1hz38lboCWSlBzF2A=;
 b=Ax0dvtUo4tAeMjiRKWuKFtpDZVLxtkZV1L0fTHjYfzQw78o4gTkO+FCY4nRH1CkVMa
 WQ4mVvZLCdNz6HST2d+ybEvyw9Ol7+qqI/0ubwxCnIJpXaZbCAR5mVIT+VYbCi9RIOsp
 GIsFZSO87KkdgWByDJxj5wZM2kgT5lO7KqVM6dI8Fdirpg3MJa6ebPLw/R65dpdGrCXO
 SwcnZ0dyG/tnZpLQxO63tTRVsvh0snQcQdgRFXfTFxeDonhiEEt73MCA2nTdBAedailp
 h8QJ+WsZMAU8d7niYUqM5/dWKPIyWK8BMH6v9zruqRQAiJPlc6+uQPcIwrpHWUHXEtlM
 5/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741628339; x=1742233139;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xr2Y+MevTuIvJzsA1IaemgzQ4R1hz38lboCWSlBzF2A=;
 b=rgTYaWMLgdgc7WgN8nfLHrzUT/rkY0bSGDPu5Fni2Q1s8UsrV0lCYB0q/0pMMf0EP/
 tvWVz9UnL8VMzAfm377DQ6xT/SwxPbj7hCpbgyv/NA00EZhSd/K4hemGH1sT0RdRz30j
 0lT1qY0wU/CVknk8DaaULJ2uCbObUPjVndAGGXyGveCImkhyP8RFJNsqQy7g9TUoY5dQ
 5AaGYkzrg6iOrml6a6H2XaXJ59GiIfzJqZTSlQbVqwYRndA8nJM8/evAboAoqlqVxEKQ
 Gn0nuC/lqYieUpKhrjc1Eri7IaCz/fL7re+g1Jv8LLCvchbB7WoN0YUj3B85DwEgHshQ
 VYIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwnGse9qlDZKuk99zOydgjiAARx6QEeP0Jw2oaXJDZydtQz1NkTr7pgEpW9vEP67UjuviFru0EtOA=@nongnu.org,
 AJvYcCVJjn892WKLmo4A8G6H9tCtXBJerWPdaV4gI8oGe3db9MT4+Dcrl3eYSAvK4Ob3DbEpq9kHLNFoZQ==@nongnu.org,
 AJvYcCVOpq99Qva/pfc7bXzAaREd3nYagGLQfQcQp71hNcI1bEVPCF9s6DGv8wHwxS5CDlHUhu1xluZYwUzTnA==@nongnu.org
X-Gm-Message-State: AOJu0Yw4ZdLClAqD0YcGxH9msz9OrVwgjZHfqOclrIwWSU7MhmZzGk6W
 kAGY80vdm6fMnRjqKRkAXsLuy/FNlsLkGPOVEy1bvZe1pa1fagIV
X-Gm-Gg: ASbGncsMWDL29SJSf79QF0EiJZpfzMEYX5xVUBfQNXfCqsU/lzfADkEZ4ixexrCrfBA
 J5WlO/wRzfEE0ngWVh3GNEAZN7DAh84FVlruGW6QukUrqnHxmC/EWktztnFJQF/GJFtxByacuVi
 RvzCt/OGV4Om5p9vKIftdAiJ+sGo3SXbcn2X+f30nyNWXB86LOeNFidEvoNRmKALr0CPVDP9mhs
 vMhF2ghBfgxB9QVkR3hhhsKRyAxuN+gaKuHYVp+DvZhf7IxAngmPtnAIu/R+icik1izX9GAWdhW
 ppCqyisLQy8IzImH4OFQ7dCR0JNEu+3P06+XWjXCekuJNo74e/VLC5vO7CgJbdS1ZZw1H+ozSNz
 TJlzvUNIOJN4Pm4qKGFRA1upbwjJkzCFXZt2lXJY/+bPcZghL8wBJ
X-Google-Smtp-Source: AGHT+IHKfmMY1bv/Xrw/mkW/zMOk3DMhE1rtX0XPgAz7znAya9xYZJhsc+Q3w+LrUaudOl1NZ3ta4Q==
X-Received: by 2002:a05:6000:18a3:b0:391:1473:2a08 with SMTP id
 ffacd0b85a97d-39132d08b84mr12040374f8f.7.1741628339095; 
 Mon, 10 Mar 2025 10:38:59 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2dbb-fc00-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:2dbb:fc00:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac27e72fbadsm413946366b.154.2025.03.10.10.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:38:58 -0700 (PDT)
Date: Mon, 10 Mar 2025 17:38:57 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-block@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_14/14=5D_hw/sd/sdhci=3A_Rem?=
 =?US-ASCII?Q?ove_unnecessary_=27endianness=27_property?=
In-Reply-To: <e58acfaf-5255-4710-ad34-7331401ffa86@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
 <20250310000620.70120-15-philmd@linaro.org>
 <d97b9dd5-e569-636d-8ee7-b1a48c402429@eik.bme.hu>
 <0fa157de-ee4e-4b7f-b08e-bdf65e1840ad@linaro.org>
 <6ecc3790-e5a1-4d02-aefa-c6d632936a6a@roeck-us.net>
 <e58acfaf-5255-4710-ad34-7331401ffa86@linaro.org>
Message-ID: <E66E09F3-0E28-44D7-972C-1E72D789E9E0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42b.google.com
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



Am 10=2E M=C3=A4rz 2025 17:31:57 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>On 10/3/25 16:56, Guenter Roeck wrote:
>> On 3/10/25 08:27, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 10/3/25 15:09, BALATON Zoltan wrote:
>>>> On Mon, 10 Mar 2025, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> The previous commit removed the single use of instance
>>>>> setting the "endianness" property=2E
>>>>>=20
>>>>> Since classes can register their io_ops with correct
>>>>> endianness, no need to support different ones=2E
>>>>>=20
>>>>> Remove the code related to SDHCIState::endianess field=2E
>>>>>=20
>>>>> Remove the now unused SDHCIState::io_ops field, since we
>>>>> directly use the class one=2E
>>>>>=20
>>>>> Suggested-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>>>> ---
>>>>> hw/sd/sdhci-internal=2Eh |=C2=A0 1 -
>>>>> include/hw/sd/sdhci=2Eh=C2=A0 |=C2=A0 2 --
>>>>> hw/sd/sdhci=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 33 +++------------------------------
>>>>> 3 files changed, 3 insertions(+), 33 deletions(-)
>>>>>=20
>>>>> diff --git a/hw/sd/sdhci-internal=2Eh b/hw/sd/sdhci-internal=2Eh
>>>>> index d99a8493db2=2E=2Ee4da6c831d1 100644
>>>>> --- a/hw/sd/sdhci-internal=2Eh
>>>>> +++ b/hw/sd/sdhci-internal=2Eh
>>>>> @@ -308,7 +308,6 @@ extern const VMStateDescription sdhci_vmstate;
>>>>> #define SDHC_CAPAB_REG_DEFAULT 0x057834b4
>>>>>=20
>>>>> #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
>>>>> -=C2=A0=C2=A0=C2=A0 DEFINE_PROP_UINT8("endianness", _state, endianne=
ss, DEVICE_LITTLE_ENDIAN), \
>>>>> =C2=A0=C2=A0=C2=A0 DEFINE_PROP_UINT8("sd-spec-version", _state, sd_s=
pec_version, 2), \
>>>>> =C2=A0=C2=A0=C2=A0 DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NO=
T_SUPPORTED), \
>>>>> =C2=A0=C2=A0=C2=A0 \
>>>>> diff --git a/include/hw/sd/sdhci=2Eh b/include/hw/sd/sdhci=2Eh
>>>>> index e8fced5eedc=2E=2E1016a5b5b77 100644
>>>>> --- a/include/hw/sd/sdhci=2Eh
>>>>> +++ b/include/hw/sd/sdhci=2Eh
>>>>> @@ -54,7 +54,6 @@ struct SDHCIState {
>>>>> =C2=A0=C2=A0=C2=A0 AddressSpace sysbus_dma_as;
>>>>> =C2=A0=C2=A0=C2=A0 AddressSpace *dma_as;
>>>>> =C2=A0=C2=A0=C2=A0 MemoryRegion *dma_mr;
>>>>> -=C2=A0=C2=A0=C2=A0 const MemoryRegionOps *io_ops;
>>>>>=20
>>>>> =C2=A0=C2=A0=C2=A0 QEMUTimer *insert_timer;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* timer for 'changing' sd card=2E */
>>>>> =C2=A0=C2=A0=C2=A0 QEMUTimer *transfer_timer;
>>>>> @@ -105,7 +104,6 @@ struct SDHCIState {
>>>>>=20
>>>>> =C2=A0=C2=A0=C2=A0 /* Configurable properties */
>>>>> =C2=A0=C2=A0=C2=A0 uint32_t quirks;
>>>>> -=C2=A0=C2=A0=C2=A0 uint8_t endianness;
>>>>> =C2=A0=C2=A0=C2=A0 uint8_t sd_spec_version;
>>>>> =C2=A0=C2=A0=C2=A0 uint8_t uhs_mode;
>>>>> };
>>>>> diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>>>>> index 47e4bd1a610=2E=2Ecbb9f4ae8c0 100644
>>>>> --- a/hw/sd/sdhci=2Ec
>>>>> +++ b/hw/sd/sdhci=2Ec
>>>>> @@ -1391,17 +1391,6 @@ sdhci_write(void *opaque, hwaddr offset, uint=
64_t val, unsigned size)
>>>>> }
>>>>>=20
>>>>> static const MemoryRegionOps sdhci_mmio_le_ops =3D {
>>>>> -=C2=A0=C2=A0=C2=A0 =2Eread =3D sdhci_read,
>>>>> -=C2=A0=C2=A0=C2=A0 =2Ewrite =3D sdhci_write,
>>>>> -=C2=A0=C2=A0=C2=A0 =2Evalid =3D {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Emin_access_size =3D 1=
,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Emax_access_size =3D 4=
,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Eunaligned =3D false
>>>>> -=C2=A0=C2=A0=C2=A0 },
>>>>> -=C2=A0=C2=A0=C2=A0 =2Eendianness =3D DEVICE_LITTLE_ENDIAN,
>>>>> -};
>>>>> -
>>>>> -static const MemoryRegionOps sdhci_mmio_be_ops =3D {
>>>>> =C2=A0=C2=A0=C2=A0 =2Eread =3D sdhci_read,
>>>>> =C2=A0=C2=A0=C2=A0 =2Ewrite =3D sdhci_write,
>>>>> =C2=A0=C2=A0=C2=A0 =2Eimpl =3D {
>>>>> @@ -1413,7 +1402,7 @@ static const MemoryRegionOps sdhci_mmio_be_ops=
 =3D {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Emax_access_size =3D 4,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Eunaligned =3D false
>>>>> =C2=A0=C2=A0=C2=A0 },
>>>>> -=C2=A0=C2=A0=C2=A0 =2Eendianness =3D DEVICE_BIG_ENDIAN,
>>>>> +=C2=A0=C2=A0=C2=A0 =2Eendianness =3D DEVICE_LITTLE_ENDIAN,
>>>>> };
>>>>>=20
>>>>> static void sdhci_init_readonly_registers(SDHCIState *s, Error **err=
p)
>>>>> @@ -1467,23 +1456,6 @@ void sdhci_common_realize(SDHCIState *s, Erro=
r **errp)
>>>>> =C2=A0=C2=A0=C2=A0 SDHCIClass *sc =3D s->sc;
>>>>> =C2=A0=C2=A0=C2=A0 const char *class_name =3D object_get_typename(OB=
JECT(s));
>>>>>=20
>>>>> -=C2=A0=C2=A0=C2=A0 s->io_ops =3D sc->io_ops ?: &sdhci_mmio_le_ops;
>>>>> -=C2=A0=C2=A0=C2=A0 switch (s->endianness) {
>>>>> -=C2=A0=C2=A0=C2=A0 case DEVICE_LITTLE_ENDIAN:
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* s->io_ops is little e=
ndian by default */
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>> -=C2=A0=C2=A0=C2=A0 case DEVICE_BIG_ENDIAN:
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->io_ops !=3D &sdhc=
i_mmio_le_ops) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
error_setg(errp, "SD controller doesn't support big endianness");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->io_ops =3D &sdhci_mmi=
o_be_ops;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>> -=C2=A0=C2=A0=C2=A0 default:
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Incorr=
ect endianness");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>> -
>>>>> =C2=A0=C2=A0=C2=A0 sdhci_init_readonly_registers(s, errp);
>>>>> =C2=A0=C2=A0=C2=A0 if (*errp) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>> @@ -1493,7 +1465,7 @@ void sdhci_common_realize(SDHCIState *s, Error=
 **errp)
>>>>> =C2=A0=C2=A0=C2=A0 s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
>>>>>=20
>>>>> =C2=A0=C2=A0=C2=A0 assert(sc->iomem_size >=3D SDHC_REGISTERS_MAP_SIZ=
E);
>>>>> -=C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->iomem, OBJECT(s), s->i=
o_ops, s, class_name,
>>>>> +=C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->iomem, OBJECT(s), sc->=
io_ops, s, class_name,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sc->iomem_size);
>>>>> }
>>>>>=20
>>>>> @@ -1578,6 +1550,7 @@ void sdhci_common_class_init(ObjectClass *klas=
s, const void *data)
>>>>> =C2=A0=C2=A0=C2=A0 dc->vmsd =3D &sdhci_vmstate;
>>>>> =C2=A0=C2=A0=C2=A0 device_class_set_legacy_reset(dc, sdhci_poweron_r=
eset);
>>>>>=20
>>>>> +=C2=A0=C2=A0=C2=A0 sc->io_ops =3D &sdhci_mmio_le_ops;
>>>>=20
>>>> You call common_class_init in subclass class_inits last so this would=
 overwrite what subclass has set, doesn't it? I think you either have to ch=
ange order in subclass class_init methods or not set this here=2E
>>>=20
>>> Oops=2E=2E=2E I'm surprised tests passed=2E Do we have coverage for sd=
hci on
>>> e500 machines? Or are we only testing them via virtio PCI block storag=
e?
>>=20
>> Not sure if that is what you are asking, but I have been testing it wit=
h
>> sdhci-pci for a long time (not this series, though)=2E
>
>I'm referring to the Freescale eSDHC controller of PPC e500 machines
>(see previous patch)=2E

I think testing SDHCI is generally difficult since the images need to be r=
esized to a power of two=2E Any idea how to do this with the new functional=
 tests?

