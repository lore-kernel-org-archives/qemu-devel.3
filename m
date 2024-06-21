Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2473BC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 07:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKYMh-0005bl-LP; Fri, 21 Jun 2024 03:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arthurtumanyan@gmail.com>)
 id 1sKYMe-0005ai-6O; Fri, 21 Jun 2024 03:07:17 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arthurtumanyan@gmail.com>)
 id 1sKYMc-0005pn-0V; Fri, 21 Jun 2024 03:07:15 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6f85f82ffeso197525166b.0; 
 Fri, 21 Jun 2024 00:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718953632; x=1719558432; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ORUD6LnC/VTY4eB9puSsgy+e06sWMOiVcmkT9sDwWkc=;
 b=lj/DOtv1IQsH92fltn4NZuatEfrTXTYyk1Cjw3P6H58izMWvK/I2CbN8GnXCP205Am
 y71ZQ5RTxE22kax0Q550Axj4dwiPHcPX2fFON1Rsg21Mnx4J7+kmWBmdB+J9Fjh0Y/w/
 t5pauoXyWgAs7BGHltg04DgDwmeZiVzw5wxkkarkOWrygaUBFOuLVY5CKjGjtlpLrYX7
 OdzXYO34z5PQDcaYMNHvg+LheOsVyLGoUXiMTZpigGvmTd2xs+Br77uUoFenNA4ZDc78
 vJYtNnKPLPMAflJln/KsVwRLvisF09OcTzYT+Tv+POSOpVRPdVs+EsFv9jdMthbeQH9t
 1QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718953632; x=1719558432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ORUD6LnC/VTY4eB9puSsgy+e06sWMOiVcmkT9sDwWkc=;
 b=w7WzlPYCbc293eKFqcTCxUAQ2k0ABSpeo9DId/P3FCDrCEp0lOVuA1tgJT4HkBRPmN
 tyK6SkbvD6fGuUxc3QE0lCmDJf5bQIDr0+XO5lQ95SAdSeF6SM63EOZt2SvlcVgi8j8U
 43i5TbZd0LJesUkfiUgelw1rz2ce8i75UC0ivEjQp4CFzg/2dbBBAeIYid3U+Z1bRpGB
 3IYVNAfwXLBfLdzrDCUhOmB+h/7DJ8ymYeSIrZZRCVeHeXnClnAUDVk18O/1A9r0xaRV
 lyqq8PpS0/xEW7Cx20VOPNSkhwQ4/GD/n+1fhrdB2d5gs8PK7Ulr/zkftJSgsYWSFi6y
 rFTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkgfTq5t3ly1WGXQ6oAsLx+dPE22aUAtp0cn9UcFmr/iPJ6tLXJylZL/WMIVrDlK2ebKKUYTYlZTMrDVW0F02Ccgoo3wNm1DdkmHLdcuPRgdaZQeI4NsHwOf4=
X-Gm-Message-State: AOJu0Yxi0wE/cZeVJqG2E54bAs8rg4NbwSaEhGw4VKug8wciPhSthBDm
 2t4HBREjxIF612IzUdm4t/OtVq+io3C++QMzzt49vIEWBimMVJxpJH9uLKPB7pL0hql3yG+2PAk
 TmQCDaNvzlaNBhxem1WKi6Gaknis=
X-Google-Smtp-Source: AGHT+IE92qsdwveFQDb56jP+qo3bQQtsPbkizXQzqNyEL8BymwnudgK6q9b8bvfidlZcLhvOXVuMPZYmfOJWW9yL9Ok=
X-Received: by 2002:a17:907:c089:b0:a6f:b193:7590 with SMTP id
 a640c23a62f3a-a6fb19375f7mr510011966b.14.1718953632015; Fri, 21 Jun 2024
 00:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <CADueUgQh-=vmoO9kqL589Xeuf_LOM_K2Rr-rBxwe8iArdNdzsA@mail.gmail.com>
 <6b1daa9c-6f37-4edb-86d4-782941f1bcca@redhat.com>
 <CAFEAcA-Yda=XXspi49Z+-7bmBP-DzL2kFMg_XfNxMviHuAX18w@mail.gmail.com>
 <CADueUgS1==4gAmNmTBLZzrnRUp9z2wxkce8+TcOeoR3w_Pg-bg@mail.gmail.com>
In-Reply-To: <CADueUgS1==4gAmNmTBLZzrnRUp9z2wxkce8+TcOeoR3w_Pg-bg@mail.gmail.com>
From: Arthur Tumanyan <arthurtumanyan@gmail.com>
Date: Fri, 21 Jun 2024 11:07:00 +0400
Message-ID: <CADueUgT4xDJft6On4j+oic65UcQRv_PcNSWJg-CcdBM8My3zow@mail.gmail.com>
Subject: Re: How to use designware-root-port and designware-root-host devices ?
To: peter.maydell@linaro.org
Cc: thuth@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 andrew.smirnov@gmail.com
Content-Type: multipart/alternative; boundary="0000000000009f2937061b6114f3"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=arthurtumanyan@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000009f2937061b6114f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I just tried to run mcimx7d-sabre machine this way:

${HOME}/cosim/usr/local/bin/qemu-system-arm -M mcimx7d-sabre -m 2G \
-kernel ${HOME}/cosim-arm/buildroot/output/images/uImage \
        --initrd ${HOME}/cosim-arm/buildroot/output/images/rootfs.cpio.gz \
-nographic \
-net nic -net user

and it just prints this and do nothing: *qemu-system-arm: warning: nic
imx.enet.1 has no peer*

Based on what I see in the mcimx7d-sabre.c , it configures just very basic
things, no PCIe at all (may be I'm wrong ;) )

Is there any idea what goes wrong here ? Maybe someone has experience with
running this machine ?

Before starting to create my own virt machine I would like to know I'm not
missing the existing ways to run this.

Thanks in advance,
Arthur





On Thu, Jun 20, 2024 at 11:37=E2=80=AFPM Arthur Tumanyan <arthurtumanyan@gm=
ail.com>
wrote:

> Thanks for the answers, I could move forward a bit more. I'm going/I need
> to to create a "virt" machine with designware PCI controller for simulati=
on
> purposes. Will get back with progress in case anyone is interested in
> results. Thank you again for your time and support.
> Arthur
>
> On Thu, Jun 20, 2024, 23:05 Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On Thu, 20 Jun 2024 at 18:34, Thomas Huth <thuth@redhat.com> wrote:
>> >
>> > On 20/06/2024 10.28, Arthur Tumanyan wrote:
>> > >  From the other hand the device is declared as non pluggable:
>> > > dc->user_creatable =3D false;
>> >
>> > Well, that means that you cannot use those with "-device". They can
>> only be
>> > instantiated via the code that creates the machine.
>> >
>> > > Can you please help me to use designware-root-host/port devices ?
>> >
>> > It seems like the i.MX7 SABRE machine is using this device, so instead
>> of
>> > "-M virt", you could have a try with "-M mcimx7d-sabre" (and a kernel
>> that
>> > supports this machine) instead.
>>
>> Right -- these devices are the PCIe controller that's used on the i.MX7
>> and i.MX6 SoCs, and they're automatically created when you use a machine
>> type that uses one of those SoCs. The "virt" board doesn't use that
>> PCIe controller, it uses the "generic PCIe bridge" TYPE_GPEX_HOST
>> (and you automatically get a PCIe controller when you use the virt board=
).
>> You can't change the PCIe controller type of a QEMU machine from
>> the command line, you have to configure the guest to use the controller
>> the machine type provides.
>>
>> thanks
>> -- PMM
>>
>

--0000000000009f2937061b6114f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I just tried to run mcimx7d-sabre m=
achine this way:<br></div><div><br>${HOME}/cosim/usr/local/bin/qemu-system-=
arm -M mcimx7d-sabre -m 2G \<br>	-kernel ${HOME}/cosim-arm/buildroot/output=
/images/uImage \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0	--initrd ${HOME}/cosim-arm/=
buildroot/output/images/rootfs.cpio.gz \<br>	-nographic \<br>	-net nic -net=
 user=C2=A0<br></div><div><br></div><div>and it just prints this and do not=
hing:=C2=A0<b>qemu-system-arm: warning: nic imx.enet.1 has no peer</b></div=
><div><br></div><div>Based on what I see in the mcimx7d-sabre.c , it config=
ures just very basic things, no PCIe at all (may be I&#39;m wrong ;) )</div=
><div><br></div><div>Is there any idea what goes wrong here ? Maybe someone=
 has experience with running this machine ?</div><div><br></div><div>Before=
 starting to create my own virt machine I would like to know I&#39;m not mi=
ssing the existing ways to run this.</div><div><br></div><div>Thanks in adv=
ance,</div><div>Arthur</div><div><br></div><div><br></div><div><br></div><d=
iv><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Thu, Jun 20, 2024 at 11:37=E2=80=AFPM Arthur Tumanyan &lt;<=
a href=3D"mailto:arthurtumanyan@gmail.com">arthurtumanyan@gmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><p dir=
=3D"ltr">Thanks for the answers, I could move forward a bit more. I&#39;m g=
oing/I need to to create a &quot;virt&quot; machine with designware PCI con=
troller for simulation purposes. Will get back with progress in case anyone=
 is interested in results. Thank you again for your time and support.<br>
Arthur </p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jun 20, 2024, 23:05 Peter Maydell &lt;<a href=3D"mailto:peter.maydell@lin=
aro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 20 Jun 2024 at 1=
8:34, Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" rel=3D"noreferrer=
" target=3D"_blank">thuth@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On 20/06/2024 10.28, Arthur Tumanyan wrote:<br>
&gt; &gt;=C2=A0 From the other hand the device is declared as non pluggable=
:<br>
&gt; &gt; dc-&gt;user_creatable =3D false;<br>
&gt;<br>
&gt; Well, that means that you cannot use those with &quot;-device&quot;. T=
hey can only be<br>
&gt; instantiated via the code that creates the machine.<br>
&gt;<br>
&gt; &gt; Can you please help me to use designware-root-host/port devices ?=
<br>
&gt;<br>
&gt; It seems like the i.MX7 SABRE machine is using this device, so instead=
 of<br>
&gt; &quot;-M virt&quot;, you could have a try with &quot;-M mcimx7d-sabre&=
quot; (and a kernel that<br>
&gt; supports this machine) instead.<br>
<br>
Right -- these devices are the PCIe controller that&#39;s used on the i.MX7=
<br>
and i.MX6 SoCs, and they&#39;re automatically created when you use a machin=
e<br>
type that uses one of those SoCs. The &quot;virt&quot; board doesn&#39;t us=
e that<br>
PCIe controller, it uses the &quot;generic PCIe bridge&quot; TYPE_GPEX_HOST=
<br>
(and you automatically get a PCIe controller when you use the virt board).<=
br>
You can&#39;t change the PCIe controller type of a QEMU machine from<br>
the command line, you have to configure the guest to use the controller<br>
the machine type provides.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>
</blockquote></div>

--0000000000009f2937061b6114f3--

