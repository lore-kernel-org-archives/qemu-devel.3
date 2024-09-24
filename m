Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43776CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 19:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stAz8-0004xo-FL; Tue, 24 Sep 2024 15:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stAz4-0004w2-7J; Tue, 24 Sep 2024 15:14:03 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stAz0-0004ru-UC; Tue, 24 Sep 2024 15:14:01 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so930270366b.1; 
 Tue, 24 Sep 2024 12:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727205236; x=1727810036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+PQn8tvM0cxJ7dP/tXCqzEs1R6xoNkDxSRi6GA1i1o=;
 b=S7JydXyw7htI0Js4PcXEh4F6ZLAXwpOxMe/huah9ToOKo4PiI2n2EAzZH4uhjhoe7W
 Aa8CFdssTmLl2iTHl1AbrFmrKOpAZpGw5sKTiO44YKlrif0C3BiS3021+t63Xjh06bU/
 rol3Gh0DcQr1jQPs7eKFs/M8cIiMqf8vw/pjdwewvqepkvANpakcjStf/E+uafcqN3Ha
 HeYvy/x7cGvOTo2rtYnUQY20YxYs+r5GkT7rkfK71XY+NQMlT9vvIGEbdFv1CP+QqhoB
 bCfhqmT4lyXdQ9vIwuC4m/bRlC8HEkRzhUFtOHJGukBu/uqyCg6FsMS7+ReW+wCEAcfF
 HNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727205236; x=1727810036;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+PQn8tvM0cxJ7dP/tXCqzEs1R6xoNkDxSRi6GA1i1o=;
 b=MYQ9jIl0nHBUXtYGm8uE985sdFBCwwIqYzV9pz+dWTnIjDiJX+819PiW3iBn2TmuvS
 aBdcPAME/2Jsm2R0ifzS0XnQ31T3sCjmzWFLdzqUKXk/7jHsk95t1N1tw7h2gqdxUaNB
 qjibAlWeim2eeA3eCv72+0/5D0hos1KBimmJTW33pQv41zT0GDnMsWAoT+k4WuraqWSx
 egC5upcQhr3isIAYR1mnW5SXQNkOUURxaFM0rpvreuyYPzCggxkesoMjAa1oK/yVWsn/
 0oB1r18SQsf+hlZb0tBxpPU9wMfOh762tx4evFiLKfUmV9y3FEhqKfUMSciWwvMjhDur
 y+dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAPgiXApEHzwda+0SKJn0yqXbGkznilgaA1CJnoSR16ZKK+bpPwxG45DlCCRBbsEDyOB/Pr7Erl63O@nongnu.org,
 AJvYcCXLy54ANtGcg2CCRTJ15bvqsxQXmXPfDfO9DQNtIdbzBe/50iu1KIuikz4GZse7T/eRn/rmw0qaezU=@nongnu.org
X-Gm-Message-State: AOJu0YzBcz7HnBj5W7DTKCa8B4ND2+2Ei1/NpRxb7169Beg+zIxwmfNJ
 UvR4w3DYf5uephwvaIbt/bzI/Gu/P7Tpe8sUIEiKkp+OtI6BZyAd
X-Google-Smtp-Source: AGHT+IGNobc2tPAu8ZZgUmc49q2WvaZbdtgB+CBJZbqXha28ZfaKBB48c5QBuJmzesCA7rZZJkXEow==
X-Received: by 2002:a17:907:efcb:b0:a8d:250a:52a8 with SMTP id
 a640c23a62f3a-a93a0322f6emr30813666b.3.1727205235825; 
 Tue, 24 Sep 2024 12:13:55 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-172-208.77.11.pool.telefonica.de.
 [77.11.172.208]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930cad24sm119979266b.108.2024.09.24.12.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 12:13:55 -0700 (PDT)
Date: Tue, 24 Sep 2024 19:13:52 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_09/23=5D_hw/ppc/mpc8544=5Fguts=3A?=
 =?US-ASCII?Q?_Populate_POR_PLL_ratio_status_register?=
In-Reply-To: <da2c3d7a-8d75-0e7c-e47e-ab329d64841a@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-10-shentey@gmail.com>
 <3037d1f0-6e44-98ee-48fc-1bb206ebc624@eik.bme.hu>
 <56E67259-70A9-44E5-A3C2-6E40363A73C2@gmail.com>
 <da2c3d7a-8d75-0e7c-e47e-ab329d64841a@eik.bme.hu>
Message-ID: <3A538E68-B44E-4BA6-B48B-B411D108369C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
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



Am 24=2E September 2024 09:59:21 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>> Am 23=2E September 2024 10:43:19 UTC schrieb BALATON Zoltan <balaton@ei=
k=2Ebme=2Ehu>:
>>> On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>>>> Populate this read-only register with some arbitrary values which avo=
ids
>>>> U-Boot's get_clocks() to hang()=2E
>>>=20
>>> Maybe this should be a property settable by the machine as each board =
may have different values and it may need to use the correct value for the =
machine=2E
>>=20
>> I actually considered this but went with the pragmatic solution to avoi=
d over-engineering=2E In particular, I wanted to avoid further machine-spec=
itic attributes in the machine class struct=2E Or do you expect a new e500 =
machine to be added? In that case I'd set above arbitrary values as default=
 and expect a new machine to override these properties=2E
>
>Can't override if there's no property for it=2E There's one machine I may=
 be interested in that uses a Freescale e500 SoC=2E That one seems to use 0=
x0606180c for this value which I think corresponds to 0/1 Ratio both 3:1, D=
DR Ratio 12:1 and Plat Ratio 6:1=2E I think one property to set the 32 bit =
value without individual fields would be enough and we can put comments nex=
t to the value if needed to note what components it comes from=2E Or if you=
 just need any value here maybe you could take this one then that would be =
good for me as well=2E

Let's use your numbers then without a property=2E Any specific machine I s=
hould mention in the commit message? Tabor?

> (I have some patches adding second i2c bus and SPD data that are needed =
for U-Boot for memory detection but it needs more clean up before I can sub=
mit it and also waiting for these patches to avoid conflict=2E)

Neat=2E That means we'll get DDR3 support?

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>> ---
>>>> hw/ppc/mpc8544_guts=2Ec | 12 ++++++++++++
>>>> 1 file changed, 12 insertions(+)
>>>>=20
>>>> diff --git a/hw/ppc/mpc8544_guts=2Ec b/hw/ppc/mpc8544_guts=2Ec
>>>> index e3540b0281=2E=2E6688fd44c3 100644
>>>> --- a/hw/ppc/mpc8544_guts=2Ec
>>>> +++ b/hw/ppc/mpc8544_guts=2Ec
>>>> @@ -29,6 +29,12 @@
>>>> #define MPC8544_GUTS_RSTCR_RESET      0x02
>>>>=20
>>>> #define MPC8544_GUTS_ADDR_PORPLLSR    0x00
>>>> +REG32(GUTS_PORPLLSR, 0x00)
>>>> +    FIELD(GUTS_PORPLLSR, E500_1_RATIO, 16, 6)
>>>> +    FIELD(GUTS_PORPLLSR, E500_0_RATIO, 16, 6)
>>>> +    FIELD(GUTS_PORPLLSR, DDR_RATIO, 9, 5)
>>>> +    FIELD(GUTS_PORPLLSR, PLAT_RATIO, 1, 5)
>>>> +
>>>> #define MPC8544_GUTS_ADDR_PORBMSR     0x04
>>>> #define MPC8544_GUTS_ADDR_PORIMPSCR   0x08
>>>> #define MPC8544_GUTS_ADDR_PORDEVSR    0x0C
>>>> @@ -75,6 +81,12 @@ static uint64_t mpc8544_guts_read(void *opaque, hw=
addr addr,
>>>>=20
>>>>     addr &=3D MPC8544_GUTS_MMIO_SIZE - 1;
>>>>     switch (addr) {
>>>> +    case MPC8544_GUTS_ADDR_PORPLLSR:
>>>> +        value =3D FIELD_DP32(value, GUTS_PORPLLSR, E500_1_RATIO, 3);=
 /* 3:2 */
>>>> +        value =3D FIELD_DP32(value, GUTS_PORPLLSR, E500_0_RATIO, 3);=
 /* 3:2 */
>>>> +        value =3D FIELD_DP32(value, GUTS_PORPLLSR, DDR_RATIO, 6); /*=
 6:1 */
>>>> +        value =3D FIELD_DP32(value, GUTS_PORPLLSR, PLAT_RATIO, 4); /=
* 4:1 */
>>>> +        break;
>>>>     case MPC8544_GUTS_ADDR_PVR:
>>>>         value =3D env->spr[SPR_PVR];
>>>>         break;
>>>>=20
>>=20
>>=20

