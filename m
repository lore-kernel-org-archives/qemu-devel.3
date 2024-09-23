Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F0BCF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 22:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssr7t-0003UE-3S; Mon, 23 Sep 2024 18:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssr7m-0003Sa-8j; Mon, 23 Sep 2024 18:01:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssr7k-0000Zt-MJ; Mon, 23 Sep 2024 18:01:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so62553005e9.0; 
 Mon, 23 Sep 2024 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727128898; x=1727733698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRAbus4TJeL9tc+h9rOhk7ATGIoo/PDdrPX/tnleOLQ=;
 b=E0i6DV5BAA1mmIjZKmPDtqZb5fE+28TNmmqVlXmDHUM24TAnBGSzRTgYO/2/xwv9g0
 mTv3hfA4XZPEG/cMO9TuoIFsA0v207HFXHzyeZIlngqQgUxzvPMyJ/qzRH+Ry0XGPKUp
 zuQTbBzbJ0/jBf7R5loEHjmoGZ4L7XPNFqnf+RcxZarD5uOwRZWG7thgxiWF/zeTmRpK
 8dx3cN64xt/pcrw7jOzeHBEnyywzbUT1xcGZqokf8tMuNBrb7tfGjT064oeeXXIMos1y
 yC+TAFGOOWnb3+rjro+kNvpixr807OAO9+H9sL+gWoH/UrdEinpel7GD3bLC+DngmT45
 0JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727128898; x=1727733698;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tRAbus4TJeL9tc+h9rOhk7ATGIoo/PDdrPX/tnleOLQ=;
 b=Uwi8w/7cukVhSozJCJGf+dB9ONiOjcDOybgqwqbJ5SNiA/3t62oAUybfIrN5/YFs1S
 ZlgbbDwzemhPksX6DsgYJRjK5+zxefGxSksfSAZwDZm5NfBlF8i2XZEMxtuo0hK8y1KH
 Ltiy4UZks7gCn9MCtAR3J0qQ0WCg82nCfnoiiFP2nlD2IzxOW9Sh+IYEvdiTyGmBEWus
 QyisHid+4CWqmCn7khH8i58Zmg1cALft8M3aD3x+GbLMblTJUk18fy3dZUfI/Cfk3HC6
 j8iGlucLsf53C/G7/FAX4ErbbanX0BWJB1rfnu1X2h/RkjoOG84ewcROZB1hiSdNIZu1
 VOEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4MF2aty3/4cO9OAiBJCUPIUcbvVTdDNdBXQUFgusuVDwR6E8Ydyry8cDPu/wPBLiVHK7DC/sjocg=@nongnu.org,
 AJvYcCU9FXIqriklsVsGN2xHfDrex1GjyK1jjUG4fWmP/7ohBJDW4Pr6DWuD0ROeknrJZ3gQZBe5rHHqOxfy@nongnu.org
X-Gm-Message-State: AOJu0YzYIauwKEHPj2/UTXQsk7eq3yNG1m6VfBsTnytUjFogCxwQBpwE
 rYiU2AYxZSb/Zsv4rtgiRiokmf+aPeX3E+2YLuJ5O3MVBXst2TjP
X-Google-Smtp-Source: AGHT+IExT5lzUxS2tYDZM/0UbyiH/c90pg2lu57+3mr9/8l/rH0qmIs4/AMWSCbAjWkj7u9w29fxwA==
X-Received: by 2002:a05:6000:d0a:b0:374:c328:620a with SMTP id
 ffacd0b85a97d-37a422c7647mr10462499f8f.29.1727128898111; 
 Mon, 23 Sep 2024 15:01:38 -0700 (PDT)
Received: from [127.0.0.1] ([81.19.4.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9393138b18sm5270166b.215.2024.09.23.15.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2024 15:01:37 -0700 (PDT)
Date: Mon, 23 Sep 2024 22:01:35 +0000
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
Subject: Re: [PATCH 11/23] hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
In-Reply-To: <424c5118-c638-4e83-9796-8858b7fba78b@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-12-shentey@gmail.com>
 <424c5118-c638-4e83-9796-8858b7fba78b@eik.bme.hu>
Message-ID: <FEA742CA-ED2A-4D17-B9E7-A670A400D7FA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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



Am 23=2E September 2024 10:49:53 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/i2c/mpc_i2c=2Ec | 20 ++++++++------------
>> 1 file changed, 8 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/hw/i2c/mpc_i2c=2Ec b/hw/i2c/mpc_i2c=2Ec
>> index 3d79c15653=2E=2E16f4309ea9 100644
>> --- a/hw/i2c/mpc_i2c=2Ec
>> +++ b/hw/i2c/mpc_i2c=2Ec
>> @@ -20,7 +20,6 @@
>> #include "qemu/osdep=2Eh"
>> #include "hw/i2c/i2c=2Eh"
>> #include "hw/irq=2Eh"
>> -#include "qemu/module=2Eh"
>> #include "hw/sysbus=2Eh"
>> #include "migration/vmstate=2Eh"
>> #include "qom/object=2Eh"
>> @@ -345,16 +344,13 @@ static void mpc_i2c_class_init(ObjectClass *klass=
, void *data)
>>     dc->desc =3D "MPC I2C Controller";
>> }
>>=20
>> -static const TypeInfo mpc_i2c_type_info =3D {
>> -    =2Ename          =3D TYPE_MPC_I2C,
>> -    =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>> -    =2Einstance_size =3D sizeof(MPCI2CState),
>> -    =2Eclass_init    =3D mpc_i2c_class_init,
>> +static const TypeInfo types[] =3D {
>> +    {
>> +        =2Ename          =3D TYPE_MPC_I2C,
>> +        =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>> +        =2Einstance_size =3D sizeof(MPCI2CState),
>> +        =2Eclass_init    =3D mpc_i2c_class_init,
>> +    },
>> };
>>=20
>> -static void mpc_i2c_register_types(void)
>> -{
>> -    type_register_static(&mpc_i2c_type_info);
>> -}
>> -
>> -type_init(mpc_i2c_register_types)
>> +DEFINE_TYPES(types)
>
>What's the advantage of this when we have a single device? For these devi=
ces this looks like just code churn to me=2E

It is still shorter and also more modern style=2E As a nice side effect it=
 also helps in my experimental branch (which may never ship)=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

