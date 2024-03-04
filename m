Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBBFC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 15:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhAYo-0004PI-6p; Mon, 04 Mar 2024 10:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rhAYm-0004Ou-Ou
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 10:49:00 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rhAYk-0002UJ-Ht
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 10:49:00 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so6495198a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 07:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709567336; x=1710172136; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2BGXxOgPid4Tk5glP0CYS0gAwsFHTbjnJw7PpQuMCQ=;
 b=hVyKXJPnSX/S50JLh9j0VWnQibvXUTBXOaRC3rfeQtNGEotvwBqtVmIUmTRqTv/s1U
 OgnUp+GkRAwPj4jobQPB+upr0IQEcn26LcQk8aOqgWkJnSoDfSVMpcnvGVWVFHIg3iKz
 VZTEq1rlhTiVZao8s35jTYD5+7QoSdZJLEo2OaGWLmWWamlubBADFK6cMxNpi/8SK37H
 2931iPUzF+vVv6mL1xuuceQWOMMExFSbSgmWEEuEKMCr786alUzH3ky7zCL5GmwXOpGo
 QCk/3YL/2F0EOeUHQAqFFVQV/OXY+BCnnKXN/mXzNR90PKfvzLLSFe8A7/BwS6NXCGHA
 42nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709567336; x=1710172136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y2BGXxOgPid4Tk5glP0CYS0gAwsFHTbjnJw7PpQuMCQ=;
 b=fv7TZfMwIkVIdk8ak8q2xe+G1jhyUaO+5JAdDNz4lHJxt5wKb5ZfoXCRo7OI+IenvD
 NwyKYwwpzuRVebUDpBCKsF6XZRBwybbyUWZAdvrupcqqHIofQ6zFK6YB4OnNGaduat59
 cD5Tdx5zumxaZMoIr4NtlmRyf/32CAO+X5uNRyhUCM3g0D0BEXlvv+Yc7e+jhhMXvBl9
 +k/FkPjX0U41A6ACi2IWbCgSg1w9jDtOaoeM6kyeNQwH1aDh26qU6VwpYxZM8nnTRFW/
 zeFYbQuAin0+SNLeUJeye2s587QFMlZevd/rknwWg3DHlzicwKnKIZK0goJRlD1YPfdW
 XQTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNhS6E96Twf7wf2zOEhn+GTwWbD4g7ltwbI6su+OhbYq92XNLG6f4Yoiabd2UsdEtTmoT0M3nJziTlJ/aiKF8NEv/cv5c=
X-Gm-Message-State: AOJu0YwaxcAAIHDX7miKHJCQOWt1NYwPqDXJyFMDhFzvDUyKytzJRd7T
 gX1MQLmDSiLZMmqZ7KDqirMnesiB552TigzE0F4RerTCYCqCH9I5XLYzKuSWEyhuWgfQrAUGRa6
 bbKnUEyVVLLL7rgyqzEM6xjzKH1o=
X-Google-Smtp-Source: AGHT+IGiRvguvcDan3OzoAgHnRZVnA/viyOqpvNq/QUIkdQFW3rLNzkqz/wv3/ajz7wR6tPzUppMrrDntgUSGZ+qmGE=
X-Received: by 2002:aa7:c38e:0:b0:566:f81:41a1 with SMTP id
 k14-20020aa7c38e000000b005660f8141a1mr6228421edq.22.1709567335686; Mon, 04
 Mar 2024 07:48:55 -0800 (PST)
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
 <CAOpGCn+PhxqRb=UjKM=z1q79u_iCH=RKW1=DDGUbWnBf4Q0kog@mail.gmail.com>
 <CAJ307EhpocLQ5p+MU++pTpotMuDTCedzNGWohvm6F02LXkhcrA@mail.gmail.com>
In-Reply-To: <CAJ307EhpocLQ5p+MU++pTpotMuDTCedzNGWohvm6F02LXkhcrA@mail.gmail.com>
From: Faiq Ali Sayed <faiqueali.109@gmail.com>
Date: Mon, 4 Mar 2024 16:48:44 +0100
Message-ID: <CAOpGCnLGkTSNbURwgXRL7GqcuyCPpJEJhPFpqhQb-RGn73H4gw@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Stefano Stabellini <stefano.stabellini@amd.com>
Content-Type: multipart/alternative; boundary="000000000000c368cc0612d7a9b6"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=faiqueali.109@gmail.com; helo=mail-ed1-x533.google.com
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

--000000000000c368cc0612d7a9b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

>I wasn't aware that such a command exists. However, the --run option
>seems to call the script "runimage". You might want to take a look at
>the options being set or maybe simply retrieve the qemu command line
>created by it (if that's not how you created your first command line).

>Sorry to not be more helpful.

This is actually the main concern, how can I get the internal command of
QNX, how do I know how QNX calls Qemu.
let me investigate it more and yes thanks for your time and support.
Thanks :)

BR!
Faiq

On Mon, Mar 4, 2024 at 10:37=E2=80=AFAM Cl=C3=A9ment Chigot <chigot@adacore=
.com> wrote:

> On Fri, Mar 1, 2024 at 6:48=E2=80=AFPM Faiq Ali Sayed <faiqueali.109@gmai=
l.com>
> wrote:
> >
> > Hi Cl=C3=A9ment,
> >
> > So the output of the command
> > |  $ qemu-system-aarch64 -M xlnx-zcu102 -m 4G -no-reboot -nographic
> > -kernel qnx.img
> > is
> >
> > $ pulseaudio: set_sink_input_volume() failed
> > $ pulseaudio: Reason: Invalid argument
> > $ pulseaudio: set_sink_input_mute() failed
> > $ pulseaudio: Reason: Invalid argument
> >
> > I am not using the "mkifs" rather I am using the command below..
>
> I guess we disabled some options when we built our kernels to allow a
> simple command line. However, I don't know which ones.
>
> > $ mkqnximage --type=3Dqemu --arch=3Daarch64le --build  --ssh-ident=3Dno=
ne
> >
> > if I use the --run option with the command it creates a VM which is
> working fine.
> > but when I use this image, with qemu command terminal is getting stuck.
>
> I wasn't aware that such a command exists. However, the --run option
> seems to call the script "runimage". You might want to take a look at
> the options being set or maybe simply retrieve the qemu command line
> created by it (if that's not how you created your first command line).
>
> Sorry to not be more helpful.
>
> Cl=C3=A9ment
>
> > BR!
> > Faiq
> >
> >
> >
> > On Fri, Mar 1, 2024 at 4:29=E2=80=AFPM Cl=C3=A9ment Chigot <chigot@adac=
ore.com>
> wrote:
> >>
> >> Hi Faiq,
> >>
> >> On Fri, Feb 23, 2024 at 3:55=E2=80=AFPM Faiq Ali Sayed <faiqueali.109@=
gmail.com>
> wrote:
> >> >
> >> > So as far as my understanding, we provide these binaries using Qemu
> command as depicted in the example you provided and there is no way I fou=
nd
> to put them into a single image.
> >> > Regarding the overlapping space, I don't have much idea but I think
> we could provide a starting address separately to these images something
> like addr=3D0x00100000.
> >>
> >> Where is this 0x00100000 address coming from ? Could you confirm with
> >> "readelf -h" that this is the entry point of your image ?
> >>
> >> Alternatively and that's what we used locally, qemu is able to guess
> >> the entry point of an image, when passed from -kernel. Therefore, our
> >> command simply looks like:
> >>   |  $ qemu-system-aarch64 -M xlnx-zcu102 -m 4G -no-reboot -nographic
> >> -kernel qnx.img
> >>
> >> I'm not the one having built the qnx.img we're using. But it looks
> >> pretty standard at the first look, made with "mkifs" and the kernel
> >> specs from zcu102 evaluation kit.
> >>
> >> Hope it helps,
> >> Cl=C3=A9ment
> >>
> >> > So as per your suggestion, I compared my images and I found that the
> image does not show a virtual disk, and other commands like mkdir, do not
> have these binaries.
> >> > So these binaries are not included at the time of image creation and
> I don't exactly know that how can we add these binaries into the QNX imag=
e.
> >> >
> >> > The Image that is currently installed in real hardware does not have
> a debugging symbol, so I can't use GDB  to debug that.
> >> > Now I am looking for a way to create the correct QNX OS image for
> Qemu.
> >> >
> >> > Any lead in this regard will be really helpful :)
> >> >
> >
> >
> >
> > --
> > Kind Regard-
> > Faiq Ali Sayed
> >
> >
>


--=20
Kind Regard-
Faiq Ali Sayed

--000000000000c368cc0612d7a9b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div><span style=3D"color:rgb=
(116,27,71)">&gt;I wasn&#39;t aware that such a command exists. However, th=
e --run option<br>
&gt;seems to call the script &quot;runimage&quot;. You might want to take a=
 look at<br>
&gt;the options being set or maybe simply retrieve the qemu command line<br=
>
&gt;created by it (if that&#39;s not how you created your first command lin=
e).<br></span>
</div><div><span style=3D"color:rgb(116,27,71)"><br></span></div><div><span=
 style=3D"color:rgb(116,27,71)">&gt;Sorry to not be more helpful.<br></span=
></div><div><font color=3D"#888888"><br></font></div><div>This is actually =
the main concern, how can I get the internal command of QNX, how do I know =
how QNX calls Qemu.</div><div>let me investigate it more and yes thanks for=
 your time and support.</div><div>Thanks :)<br></div><div><br></div><div>BR=
!<br></div><div>Faiq<br></div><div></div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 4, 2024 at 10:37=E2=80=
=AFAM Cl=C3=A9ment Chigot &lt;<a href=3D"mailto:chigot@adacore.com">chigot@=
adacore.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Fri, Mar 1, 2024 at 6:48=E2=80=AFPM Faiq Ali Sayed &lt;<a hre=
f=3D"mailto:faiqueali.109@gmail.com" target=3D"_blank">faiqueali.109@gmail.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Cl=C3=A9ment,<br>
&gt;<br>
&gt; So the output of the command<br>
&gt; |=C2=A0 $ qemu-system-aarch64 -M xlnx-zcu102 -m 4G -no-reboot -nograph=
ic<br>
&gt; -kernel qnx.img<br>
&gt; is<br>
&gt;<br>
&gt; $ pulseaudio: set_sink_input_volume() failed<br>
&gt; $ pulseaudio: Reason: Invalid argument<br>
&gt; $ pulseaudio: set_sink_input_mute() failed<br>
&gt; $ pulseaudio: Reason: Invalid argument<br>
&gt;<br>
&gt; I am not using the &quot;mkifs&quot; rather I am using the command bel=
ow..<br>
<br>
I guess we disabled some options when we built our kernels to allow a<br>
simple command line. However, I don&#39;t know which ones.<br>
<br>
&gt; $ mkqnximage --type=3Dqemu --arch=3Daarch64le --build=C2=A0 --ssh-iden=
t=3Dnone<br>
&gt;<br>
&gt; if I use the --run option with the command it creates a VM which is wo=
rking fine.<br>
&gt; but when I use this image, with qemu command terminal is getting stuck=
.<br>
<br>
I wasn&#39;t aware that such a command exists. However, the --run option<br=
>
seems to call the script &quot;runimage&quot;. You might want to take a loo=
k at<br>
the options being set or maybe simply retrieve the qemu command line<br>
created by it (if that&#39;s not how you created your first command line).<=
br>
<br>
Sorry to not be more helpful.<br>
<br>
Cl=C3=A9ment<br>
<br>
&gt; BR!<br>
&gt; Faiq<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Mar 1, 2024 at 4:29=E2=80=AFPM Cl=C3=A9ment Chigot &lt;<a href=
=3D"mailto:chigot@adacore.com" target=3D"_blank">chigot@adacore.com</a>&gt;=
 wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Faiq,<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Feb 23, 2024 at 3:55=E2=80=AFPM Faiq Ali Sayed &lt;<a href=
=3D"mailto:faiqueali.109@gmail.com" target=3D"_blank">faiqueali.109@gmail.c=
om</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; So as far as my understanding, we provide these binaries usin=
g Qemu command as depicted in the example you provided and there is no way =
I found to put them into a single image.<br>
&gt;&gt; &gt; Regarding the overlapping space, I don&#39;t have much idea b=
ut I think we could provide a starting address separately to these images s=
omething like addr=3D0x00100000.<br>
&gt;&gt;<br>
&gt;&gt; Where is this 0x00100000 address coming from ? Could you confirm w=
ith<br>
&gt;&gt; &quot;readelf -h&quot; that this is the entry point of your image =
?<br>
&gt;&gt;<br>
&gt;&gt; Alternatively and that&#39;s what we used locally, qemu is able to=
 guess<br>
&gt;&gt; the entry point of an image, when passed from -kernel. Therefore, =
our<br>
&gt;&gt; command simply looks like:<br>
&gt;&gt;=C2=A0 =C2=A0|=C2=A0 $ qemu-system-aarch64 -M xlnx-zcu102 -m 4G -no=
-reboot -nographic<br>
&gt;&gt; -kernel qnx.img<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m not the one having built the qnx.img we&#39;re using. But =
it looks<br>
&gt;&gt; pretty standard at the first look, made with &quot;mkifs&quot; and=
 the kernel<br>
&gt;&gt; specs from zcu102 evaluation kit.<br>
&gt;&gt;<br>
&gt;&gt; Hope it helps,<br>
&gt;&gt; Cl=C3=A9ment<br>
&gt;&gt;<br>
&gt;&gt; &gt; So as per your suggestion, I compared my images and I found t=
hat the image does not show a virtual disk, and other commands like mkdir, =
do not have these binaries.<br>
&gt;&gt; &gt; So these binaries are not included at the time of image creat=
ion and I don&#39;t exactly know that how can we add these binaries into th=
e QNX image.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The Image that is currently installed in real hardware does n=
ot have a debugging symbol, so I can&#39;t use GDB=C2=A0 to debug that.<br>
&gt;&gt; &gt; Now I am looking for a way to create the correct QNX OS image=
 for Qemu.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Any lead in this regard will be really helpful :)<br>
&gt;&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Kind Regard-<br>
&gt; Faiq Ali Sayed<br>
&gt;<br>
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

--000000000000c368cc0612d7a9b6--

