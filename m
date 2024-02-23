Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3B1C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 14:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdWw3-0000NZ-Kc; Fri, 23 Feb 2024 09:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rdWh3-0004ZY-Pu
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:38:29 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rdWh1-0002gD-Dq
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:38:29 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so627186a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 06:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708699105; x=1709303905; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TN5EcRDtZSAGnt//IbUB2QXiTqVCJuViKLlU/3gbOJY=;
 b=GfbE0ZC2R7w+Uk3LFLko2oW72LTOPQPGWjiaprxDs7GYbMFbnRo8hVSSR96ZxAPWWG
 eTs1mGMh4MhXk8AG+72Luga6447LhWSnDYk7u0QTOoNzfEqVbOcojZlU5XbnxM2kK3le
 EsguTSJbJlozjs33NnkXCEVg7hZbKHCcqzWoSSx8g9mIUaUkNkHjYNWY0zgOUvajsGkj
 CfFHZmXMI1/6PH7PsS119gqSiBYCgwusRphuBck8Wo7QAoVTDMICNBtgFqASxqHUQFNH
 K+EKVP9sQ/KU55g98wQN1TEq8yV8Z7FQUz8SmA6xJJsugkSMi7+Qlxppo6I3K4rVSI63
 V8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708699105; x=1709303905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TN5EcRDtZSAGnt//IbUB2QXiTqVCJuViKLlU/3gbOJY=;
 b=PBnF6xmXjI0IyD5La/SJWIw6J8B4dpkRlcwNOTmQ96AR0YOaY2ExMgtSQPmH7ee5+J
 4CCaT7bOhtpy5pWaJn3resvyL2CO85ljsqG6y/0mde0MW38icvj0f4UbRX3Yz7J0Vu1t
 rZ3SfFPhrjFHtKhYXc1aThLVna57brQ7XSYTQ0275ftBjjDRZ3Hlf53I5NTpSAwz3aZd
 4fg4X2sLUchy+7RIZjrPVofZruH95RJSGhb89AoLwFGOe3DPz3iOdGV0fJRbQEdyvlit
 3MHxE93m5dEnvFC7ypX3RGHtf+9Jja+S/yyOsih81p+VKDAu4YCIbMmTYh/dVuaK6U7j
 ePnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7BJjmr6vw1bw9lk/qbllIYqRSqIWcxQgBp52aPCXnoZ92d18MxSMXEf1TVs/Zvlk94rxAVovjIWmNE8XOuL2C5JtScKw=
X-Gm-Message-State: AOJu0Yyf+UlTB90EOayATYW8TjVPkjhS+v3RTgin9e5mkw/vXDhLa567
 x8Oj5k38rQU+H1YEAdOqQ1aZqNE8cPYGtKJO5+ZVcsH7c9UA6EeBw+WsjaAe4wlasePCS9YjJJ9
 1TpPfioP4tHYlVy6P1CnXEVRqCGc=
X-Google-Smtp-Source: AGHT+IFHJeARcWJzwshIMPD+TKqtno77dauaX39C1i/UVEyPXpecdm1vOWNI0R/DrV9UUITKSRscpFcvFuFj3+x2HBc=
X-Received: by 2002:aa7:d751:0:b0:565:396b:2c1 with SMTP id
 a17-20020aa7d751000000b00565396b02c1mr23233eds.8.1708699105325; Fri, 23 Feb
 2024 06:38:25 -0800 (PST)
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
In-Reply-To: <871q94ahui.fsf@draig.linaro.org>
From: Faiq Ali Sayed <faiqueali.109@gmail.com>
Date: Fri, 23 Feb 2024 15:38:15 +0100
Message-ID: <CAOpGCn+-T3e8arn0UPTM5-1gJu9626wP3=FHamXvUFW6NrDJcg@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Stefano Stabellini <stefano.stabellini@amd.com>
Content-Type: multipart/alternative; boundary="0000000000003374d906120d8345"
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

--0000000000003374d906120d8345
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So as far as my understanding, we provide these binaries using Qemu command
as depicted in the example you provided and there is no way I found to put
them into a single image.
Regarding the overlapping space, I don't have much idea but I think we
could provide a starting address separately to these images something like
addr=3D0x00100000.

So as per your suggestion, I compared my images and I found that the image
does not show a virtual disk, and other commands like mkdir, do not have
these binaries.
So these binaries are not included at the time of image creation and I
don't exactly know that how can we add these binaries into the QNX image.

The Image that is currently installed in real hardware does not have a
debugging symbol, so I can't use GDB  to debug that.
Now I am looking for a way to create the correct QNX OS image for Qemu.

Any lead in this regard will be really helpful :)


BR!
Faiq

On Thu, Feb 22, 2024 at 11:55=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
> (adding the other ZyncMP maintainers to the CC)
>
> > On Wed, 21 Feb 2024 at 18:20, Faiq Ali Sayed <faiqueali.109@gmail.com>
> wrote:
> >>
> >>
> >>>
> >>> This is also useful information. I would suggest you look
> >>> at what the difference is between the image that boots and
> >>> the one that doesn't: is it the same format (and what format
> >>> is that)? is the way it is loaded on the real hardware the
> >>> same, or different?
> >>
> >>
> >> I am not able to distinguish between the images as they are in binary
> form,
> >> I noticed that the smaller size image can boot in Qemu.
> >> I normally put the image into an SD card of the real hardware to boot.
> >> so it is quite difficult for me now to distinguish.
> >>
> >>
> >>> From the debug info from gdb you provided, the file clearly
> >>> is not a raw binary file -- the initial bytes seem to be
> >>> largely ASCII text. So it might be that this image is in
> >>> a file format that whatever the real-hardware loader
> >>> recognizes, but QEMU doesn't, whereas the images you have
> >>> that work are really raw binaries. In that case you'd want
> >>> to convert the image somehow to a format QEMU can understand
> >>> (eg ELF, or raw-binary).
> >>
> >>
> >> ahh, that also makes sense, ok now let me try to convert the images,
> and let's see.
> >> Does Qemu provide such a tool or do you know any?
> >
> > We don't know what format these images are in, so hard
> > to say, but I would expect not (mostly QEMU's image
> > conversion handling is for filesystems, not guest
> > binaries). You'll probably do best to look on the QNX
> > and/or Xilinx side -- Xilinx should document what
> > file formats it is that their boot process accepts.
> > Your third-party vendor presumably also knows what
> > format it is that they're generating the image in.
>
> I did have a brief look through the Xilinx wiki pages to see if I could
> cobble together a test case for their PetaLinux images. A bunch of pages
> led to login walls which I assume are customer only. I did find:
>
>
> https://github.com/Xilinx/soc-prebuilt-firmware/tree/xlnx_rel_v2023.1/zcu=
102-zynqmp
>
> which has a number of the components for the firmware but there was no
> clear way to combine them into a single image. I did try just feeding
> the ELF's to the command line but there was a clash between zynqmp_fsbl
> and the bl31 (which I think is the normal ATF image).
>
>   ./qemu-system-aarch64 -M xlnx-zcu102 -audio none -smp 4 -serial
> mon:stdio -display none -s -S -device
> loader,file=3D/home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/zyn=
qmp_fsbl.elf
> -device
> loader,file=3D/home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/bl3=
1.elf,cpu-num=3D0
> -device
> loader,file=3D/home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/sys=
tem.dtb,addr=3D0x00100000
> -device
> loader,file=3D/home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/u-b=
oot.elf
> -dtb /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/system.dtb
>   qemu-system-aarch64: Some ROM regions are overlapping
>   These ROM regions might have been loaded by direct user request or by
> default.
>   They could be BIOS/firmware images, a guest kernel, initrd or some othe=
r
> file loaded into guest memory.
>   Check whether you intended to load all this guest code, and whether it
> has been built to load to the correct addresses.
>
>   The following two regions overlap (in the cpu-memory-0 address space):
>
> /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/zynqmp_fsbl.elf E=
LF
> program header segment 0 (addresses 0x00000000fffc0000 - 0x00000000fffe60=
58)
>     /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/bl31.elf ELF
> program header segment 0 (addresses 0x00000000fffe0000 - 0x00000000ffffe0=
00)
>
>   The following two regions overlap (in the cpu-memory-0 address space):
>     /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/bl31.elf ELF
> program header segment 0 (addresses 0x00000000fffe0000 - 0x00000000ffffe0=
00)
>
> /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/zynqmp_fsbl.elf E=
LF
> program header segment 1 (addresses 0x00000000fffe9e00 - 0x00000000fffe9e=
88)
>
> Most of the use cases on the Xilinx pages are hidden behind their launch
> scripts for their downstream fork. It would be nice if we could get at
> least one image published somewhere that we could add an avocado test
> for and hopefully an entry in the Arm system emulator pages (we have
> fairly complete docs for xlnx-versal-virt).
>
> >
> > -- PMM
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>


--=20
Kind Regard-
Faiq Ali Sayed

--0000000000003374d906120d8345
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So as far as my understanding, we provide these binaries u=
sing Qemu command as depicted in the example you provided and there is no w=
ay I found to put them into a single image.<div>Regarding the overlapping s=
pace, I don&#39;t have much idea but I think we could provide a starting ad=
dress separately to these images something like addr=3D0x00100000.</div><di=
v><br></div><div>So as per your suggestion,=C2=A0I compared my images and I=
 found that the image does not show a virtual disk, and other commands like=
 mkdir, do not have these binaries.</div><div>So these binaries are not inc=
luded at the time of image creation and I don&#39;t exactly know that how c=
an we add these binaries into the QNX image.</div><div><br></div><div>The I=
mage that is currently installed in real hardware does not have a debugging=
 symbol, so I can&#39;t use GDB=C2=A0 to debug that.</div><div>Now I am loo=
king for a way to create the correct QNX OS image for Qemu.</div><div><br><=
/div><div>Any lead in this regard will be really helpful :)</div><div><br><=
/div><div><br></div><div>BR!</div><div>Faiq</div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 22, 2024 at 11=
:55=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; writes:<br>
<br>
(adding the other ZyncMP maintainers to the CC)<br>
<br>
&gt; On Wed, 21 Feb 2024 at 18:20, Faiq Ali Sayed &lt;<a href=3D"mailto:fai=
queali.109@gmail.com" target=3D"_blank">faiqueali.109@gmail.com</a>&gt; wro=
te:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This is also useful information. I would suggest you look<br>
&gt;&gt;&gt; at what the difference is between the image that boots and<br>
&gt;&gt;&gt; the one that doesn&#39;t: is it the same format (and what form=
at<br>
&gt;&gt;&gt; is that)? is the way it is loaded on the real hardware the<br>
&gt;&gt;&gt; same, or different?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I am not able to distinguish between the images as they are in bin=
ary form,<br>
&gt;&gt; I noticed that the smaller size image can boot in Qemu.<br>
&gt;&gt; I normally put the image into an SD card of the real hardware to b=
oot.<br>
&gt;&gt; so it is quite difficult for me now to distinguish.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; From the debug info from gdb you provided, the file clearly<br=
>
&gt;&gt;&gt; is not a raw binary file -- the initial bytes seem to be<br>
&gt;&gt;&gt; largely ASCII text. So it might be that this image is in<br>
&gt;&gt;&gt; a file format that whatever the real-hardware loader<br>
&gt;&gt;&gt; recognizes, but QEMU doesn&#39;t, whereas the images you have<=
br>
&gt;&gt;&gt; that work are really raw binaries. In that case you&#39;d want=
<br>
&gt;&gt;&gt; to convert the image somehow to a format QEMU can understand<b=
r>
&gt;&gt;&gt; (eg ELF, or raw-binary).<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ahh, that also makes sense, ok now let me try to convert the image=
s, and let&#39;s see.<br>
&gt;&gt; Does Qemu provide such a tool or do you know any?<br>
&gt;<br>
&gt; We don&#39;t know what format these images are in, so hard<br>
&gt; to say, but I would expect not (mostly QEMU&#39;s image<br>
&gt; conversion handling is for filesystems, not guest<br>
&gt; binaries). You&#39;ll probably do best to look on the QNX<br>
&gt; and/or Xilinx side -- Xilinx should document what<br>
&gt; file formats it is that their boot process accepts.<br>
&gt; Your third-party vendor presumably also knows what<br>
&gt; format it is that they&#39;re generating the image in.<br>
<br>
I did have a brief look through the Xilinx wiki pages to see if I could<br>
cobble together a test case for their PetaLinux images. A bunch of pages<br=
>
led to login walls which I assume are customer only. I did find:<br>
<br>
=C2=A0 <a href=3D"https://github.com/Xilinx/soc-prebuilt-firmware/tree/xlnx=
_rel_v2023.1/zcu102-zynqmp" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/Xilinx/soc-prebuilt-firmware/tree/xlnx_rel_v2023.1/zcu102-zynqmp</=
a><br>
<br>
which has a number of the components for the firmware but there was no<br>
clear way to combine them into a single image. I did try just feeding<br>
the ELF&#39;s to the command line but there was a clash between zynqmp_fsbl=
<br>
and the bl31 (which I think is the normal ATF image).<br>
<br>
=C2=A0 ./qemu-system-aarch64 -M xlnx-zcu102 -audio none -smp 4 -serial mon:=
stdio -display none -s -S -device loader,file=3D/home/alex/lsrc/tests/testc=
ases/zcu102-zyncmp-prebuilds/zynqmp_fsbl.elf -device loader,file=3D/home/al=
ex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/bl31.elf,cpu-num=3D0 -devic=
e loader,file=3D/home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/sys=
tem.dtb,addr=3D0x00100000 -device loader,file=3D/home/alex/lsrc/tests/testc=
ases/zcu102-zyncmp-prebuilds/u-boot.elf=C2=A0 -dtb /home/alex/lsrc/tests/te=
stcases/zcu102-zyncmp-prebuilds/system.dtb<br>
=C2=A0 qemu-system-aarch64: Some ROM regions are overlapping<br>
=C2=A0 These ROM regions might have been loaded by direct user request or b=
y default.<br>
=C2=A0 They could be BIOS/firmware images, a guest kernel, initrd or some o=
ther file loaded into guest memory.<br>
=C2=A0 Check whether you intended to load all this guest code, and whether =
it has been built to load to the correct addresses.<br>
<br>
=C2=A0 The following two regions overlap (in the cpu-memory-0 address space=
):<br>
=C2=A0 =C2=A0 /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/zynqm=
p_fsbl.elf ELF program header segment 0 (addresses 0x00000000fffc0000 - 0x0=
0000000fffe6058)<br>
=C2=A0 =C2=A0 /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/bl31.=
elf ELF program header segment 0 (addresses 0x00000000fffe0000 - 0x00000000=
ffffe000)<br>
<br>
=C2=A0 The following two regions overlap (in the cpu-memory-0 address space=
):<br>
=C2=A0 =C2=A0 /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/bl31.=
elf ELF program header segment 0 (addresses 0x00000000fffe0000 - 0x00000000=
ffffe000)<br>
=C2=A0 =C2=A0 /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/zynqm=
p_fsbl.elf ELF program header segment 1 (addresses 0x00000000fffe9e00 - 0x0=
0000000fffe9e88)<br>
<br>
Most of the use cases on the Xilinx pages are hidden behind their launch<br=
>
scripts for their downstream fork. It would be nice if we could get at<br>
least one image published somewhere that we could add an avocado test<br>
for and hopefully an entry in the Arm system emulator pages (we have<br>
fairly complete docs for xlnx-versal-virt).<br>
<br>
&gt;<br>
&gt; -- PMM<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div dir=3D"ltr">
<div><span style=3D"color:rgb(34,34,34)">Kind Regard-</span><br style=3D"co=
lor:rgb(34,34,34)"><div dir=3D"ltr" style=3D"color:rgb(34,34,34)"><div dir=
=3D"ltr"><div dir=3D"ltr"><font color=3D"#073763">Faiq Ali Sayed</font></di=
v></div></div></div>
<div><font style=3D"background-color:rgb(255,255,255)" size=3D"1"><br></fon=
t></div><br></div></div></div>

--0000000000003374d906120d8345--

