Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E14C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6zW-0001OL-95; Fri, 01 Mar 2024 12:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rg6zT-000113-R3
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:48:11 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rg6zR-0000mE-ST
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:48:11 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56648955ac5so3405099a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709315287; x=1709920087; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u/9dzJ2mXmywRiGKTIE8fQelBegAZok8brLUSg9rig0=;
 b=UFMrF6U+XscGNjfMTW4IeaJECxBF8DhE3BPhMPo8gy4gJCZ5H0xYAYDyHWl4Ew6/oO
 rd8sEIiSnC3eT7THsQdV5pRm0NvD6UwDcCrVjdV+qpl3GM/dSiGxLcBDQTnMXM4ZOkJK
 f84Dtb+ALW/uYuk8HERibiYvXrAWb+LA15Z02dkjen/n8e/qwCoTYplC380bv7MhoWNY
 /B4Yz2jqkpedtL68Sb1kA+ftSzzmIvPwtbIHog9mk9FKJbatHRJkAmVhmzmMmXMXFxc4
 QUjNCIUhASuPmLwiArnkQO9rcQ91iPO8KZCR9YWXkt25yk4yFFkQSZYSLv+C9HW3bUx2
 auvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709315287; x=1709920087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u/9dzJ2mXmywRiGKTIE8fQelBegAZok8brLUSg9rig0=;
 b=lfSmPycFGixz1+bk0XNRRKRqE32jAKpvZ9dIKNZRzlgBlm1faQDsyMZmxGNuMVNRKg
 fzYpm28rVQm9Ow1qsErhjelRbDLnaL0z4Y5aRjrtrjSE+cuRl+hhqcNy5rIuv0cgtKOR
 5SsAiwU8rIi/SqYyfStezb8JhPrDErNsH8qLtKc29VrhUwQU6Syb9fzg+e8l83lyEP03
 AB4TUKUp5+B8ECM3kFA6NcqobEiuz7vkWdOd8N1EX4DEWyHG6zAnNxLkD5rCtPhG9nBN
 DZQiYDYripPs3eUi50pfaSzAeUiA4U2iUjDZO1HiTDl0hzbWa8ZakpAhmx9atrYg8fDi
 qvQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxzN0MHW9/b03mU7dMnC0HFKkvjH/zeRS5a3fCi4/tCTmt+9eiaRvKilMMeRqzAGEW8bCZQWgGoi4HlnYrPnLNx98RXwU=
X-Gm-Message-State: AOJu0Yys5CLLa+a7F/FeDxdhUzNSeHhGAXCom4e01PpdY1no+ZcgXMpD
 rtG6tyxSP31WitNhByV8JPH0P7Ox8t6UJO3OzRIv7wGCEeTkrxwBTcZNlcJirQmBHHUHAhNT61i
 ExnDGGCqJYmlHsQB8G9XmrFRLhno=
X-Google-Smtp-Source: AGHT+IFk4DGI00bG/0cd56DqyRrovl4fHsgYnidzdm4xSYiLRvyVN9UmVFh8fwAWwxXDsAQwZ9vVRAFl0bqujgKYrUA=
X-Received: by 2002:a05:6402:3493:b0:566:f67e:3f72 with SMTP id
 v19-20020a056402349300b00566f67e3f72mr447838edc.12.1709315287083; Fri, 01 Mar
 2024 09:48:07 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 <87y1bfawik.fsf@draig.linaro.org>
 <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
 <CAFEAcA-03JYx9szd3FrQ_786gaRLWCJVHeMgjBxxvgH85f-78A@mail.gmail.com>
 <CAOpGCn+vQ7wupMqeH8ZLarT0c4gD85R6cgRqBMhVeAXtZ1F_Mg@mail.gmail.com>
 <CAFEAcA9Yp=ObPhgagAbf2Ev=6=D+9sCfHC_HCxPUr2JgvWa4oQ@mail.gmail.com>
 <CAOpGCn+BHsVPG1_2-avx6Ex10dc-nKYuVv=3VTct=MYRb4TmYw@mail.gmail.com>
 <CAFEAcA9_MDHQyQ6q76OpUXgEO9f_osS23oMhyTC4vNSBqtD1-A@mail.gmail.com>
 <871q94ahui.fsf@draig.linaro.org>
 <CAOpGCn+-T3e8arn0UPTM5-1gJu9626wP3=FHamXvUFW6NrDJcg@mail.gmail.com>
 <CAJ307EgMiRDLaHD1P8_EBLwhLct6z+Wp15sXTqMV83F0mC1sLA@mail.gmail.com>
In-Reply-To: <CAJ307EgMiRDLaHD1P8_EBLwhLct6z+Wp15sXTqMV83F0mC1sLA@mail.gmail.com>
From: Faiq Ali Sayed <faiqueali.109@gmail.com>
Date: Fri, 1 Mar 2024 18:47:55 +0100
Message-ID: <CAOpGCn+PhxqRb=UjKM=z1q79u_iCH=RKW1=DDGUbWnBf4Q0kog@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Stefano Stabellini <stefano.stabellini@amd.com>
Content-Type: multipart/alternative; boundary="0000000000007ef07606129cfa1b"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=faiqueali.109@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000007ef07606129cfa1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cl=C3=A9ment,

So the output of the command
|  $ qemu-system-aarch64 -M xlnx-zcu102 -m 4G -no-reboot -nographic
-kernel qnx.img
is

$ pulseaudio: set_sink_input_volume() failed
$ pulseaudio: Reason: Invalid argument
$ pulseaudio: set_sink_input_mute() failed
$ pulseaudio: Reason: Invalid argument

I am not using the "mkifs" rather I am using the command below..

$ mkqnximage --type=3Dqemu --arch=3Daarch64le --build  --ssh-ident=3Dnone

if I use the --run option with the command it creates a VM which is working
fine.
but when I use this image, with qemu command terminal is getting stuck.


BR!
Faiq



On Fri, Mar 1, 2024 at 4:29=E2=80=AFPM Cl=C3=A9ment Chigot <chigot@adacore.=
com> wrote:

> Hi Faiq,
>
> On Fri, Feb 23, 2024 at 3:55=E2=80=AFPM Faiq Ali Sayed <faiqueali.109@gma=
il.com>
> wrote:
> >
> > So as far as my understanding, we provide these binaries using Qemu
> command as depicted in the example you provided and there is no way I fou=
nd
> to put them into a single image.
> > Regarding the overlapping space, I don't have much idea but I think we
> could provide a starting address separately to these images something lik=
e
> addr=3D0x00100000.
>
> Where is this 0x00100000 address coming from ? Could you confirm with
> "readelf -h" that this is the entry point of your image ?
>
> Alternatively and that's what we used locally, qemu is able to guess
> the entry point of an image, when passed from -kernel. Therefore, our
> command simply looks like:
>   |  $ qemu-system-aarch64 -M xlnx-zcu102 -m 4G -no-reboot -nographic
> -kernel qnx.img
>
> I'm not the one having built the qnx.img we're using. But it looks
> pretty standard at the first look, made with "mkifs" and the kernel
> specs from zcu102 evaluation kit.
>
> Hope it helps,
> Cl=C3=A9ment
>
> > So as per your suggestion, I compared my images and I found that the
> image does not show a virtual disk, and other commands like mkdir, do not
> have these binaries.
> > So these binaries are not included at the time of image creation and I
> don't exactly know that how can we add these binaries into the QNX image.
> >
> > The Image that is currently installed in real hardware does not have a
> debugging symbol, so I can't use GDB  to debug that.
> > Now I am looking for a way to create the correct QNX OS image for Qemu.
> >
> > Any lead in this regard will be really helpful :)
> >
>


--=20
Kind Regard-
Faiq Ali Sayed

--0000000000007ef07606129cfa1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Cl=C3=A9ment,</div><div><br></div><div>So the outp=
ut of the command <br></div><div> <span style=3D"background-color:rgb(243,2=
43,243)">|=C2=A0 $ qemu-system-aarch64 -M xlnx-zcu102 -m 4G -no-reboot -nog=
raphic<br>
-kernel qnx.img</span></div><div></div><div>is <br></div><div></div><div><b=
r></div><div>$ pulseaudio: set_sink_input_volume() failed<br>$ pulseaudio: =
Reason: Invalid argument<br>$ pulseaudio: set_sink_input_mute() failed<br>$=
 pulseaudio: Reason: Invalid argument</div><div></div><div><br></div><div>I=
 am not using the &quot;mkifs&quot; rather I am using the command below..</=
div><div><br></div><div>$ mkqnximage --type=3Dqemu --arch=3Daarch64le --bui=
ld=C2=A0 --ssh-ident=3Dnone</div><div><br></div><div>if I use the --run opt=
ion with the command it creates a VM which is working fine.</div><div>but w=
hen I use this image, with qemu command terminal is getting stuck.</div><di=
v><br></div><div><br></div><div>BR!</div><div>Faiq<br></div><div><br></div>=
<div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Mar 1, 2024 at 4:29=E2=80=AFPM Cl=C3=A9ment Chigot =
&lt;<a href=3D"mailto:chigot@adacore.com">chigot@adacore.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Faiq,<br>
<br>
On Fri, Feb 23, 2024 at 3:55=E2=80=AFPM Faiq Ali Sayed &lt;<a href=3D"mailt=
o:faiqueali.109@gmail.com" target=3D"_blank">faiqueali.109@gmail.com</a>&gt=
; wrote:<br>
&gt;<br>
&gt; So as far as my understanding, we provide these binaries using Qemu co=
mmand as depicted in the example you provided and there is no way I found t=
o put them into a single image.<br>
&gt; Regarding the overlapping space, I don&#39;t have much idea but I thin=
k we could provide a starting address separately to these images something =
like addr=3D0x00100000.<br>
<br>
Where is this 0x00100000 address coming from ? Could you confirm with<br>
&quot;readelf -h&quot; that this is the entry point of your image ?<br>
<br>
Alternatively and that&#39;s what we used locally, qemu is able to guess<br=
>
the entry point of an image, when passed from -kernel. Therefore, our<br>
command simply looks like:<br>
=C2=A0 |=C2=A0 $ qemu-system-aarch64 -M xlnx-zcu102 -m 4G -no-reboot -nogra=
phic<br>
-kernel qnx.img<br>
<br>
I&#39;m not the one having built the qnx.img we&#39;re using. But it looks<=
br>
pretty standard at the first look, made with &quot;mkifs&quot; and the kern=
el<br>
specs from zcu102 evaluation kit.<br>
<br>
Hope it helps,<br>
Cl=C3=A9ment<br>
<br>
&gt; So as per your suggestion, I compared my images and I found that the i=
mage does not show a virtual disk, and other commands like mkdir, do not ha=
ve these binaries.<br>
&gt; So these binaries are not included at the time of image creation and I=
 don&#39;t exactly know that how can we add these binaries into the QNX ima=
ge.<br>
&gt;<br>
&gt; The Image that is currently installed in real hardware does not have a=
 debugging symbol, so I can&#39;t use GDB=C2=A0 to debug that.<br>
&gt; Now I am looking for a way to create the correct QNX OS image for Qemu=
.<br>
&gt;<br>
&gt; Any lead in this regard will be really helpful :)<br>
&gt;<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div dir=3D"ltr">
<div><span style=3D"color:rgb(34,34,34)">Kind Regard-</span><br style=3D"co=
lor:rgb(34,34,34)"><div dir=3D"ltr" style=3D"color:rgb(34,34,34)"><div dir=
=3D"ltr"><div dir=3D"ltr"><font color=3D"#073763">Faiq Ali Sayed</font></di=
v></div></div></div>
<div><font style=3D"background-color:rgb(255,255,255)" size=3D"1"><br></fon=
t></div><br></div></div></div>

--0000000000007ef07606129cfa1b--

