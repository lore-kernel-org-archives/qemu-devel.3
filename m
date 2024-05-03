Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65172C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 19:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2z2X-0005Z7-AF; Fri, 03 May 2024 15:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1s2z2V-0005YC-6o; Fri, 03 May 2024 15:57:51 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1s2z2T-00012c-AF; Fri, 03 May 2024 15:57:50 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6153d85053aso101787b3.0; 
 Fri, 03 May 2024 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714766267; x=1715371067; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cxy5I3qFqegg9o6TUkAnNa/wB20b3zBgd4M5pvNyG88=;
 b=XmcT7tAt1bdduy55E1J2oPQ/PbVYFXuc3H63Fh3cIdK2gkQLz0dTYsqC3zZCdRk3LH
 7O1NQZAR58sZdcF2eVSNyiJ2BpICEDlEkX+beK1i+4PDGU+r4x0tSgxT7sYeXkaZ08rq
 Ri0jp1+BxHLd41rtZfunhyxY8XEB48UV8sNAYw4UfrfRCLgClB15K1sGwJ0hCSLQ3aor
 4fI9G4qwS/lLOIJkgWAlkCvD9g0tj/6an5Ow2EP5ibngu218jnjkMvKp17vYfZ4jCtdB
 eA6WysmHW5azPIVtsL4J44R1ww/h8C/5dDH1dOESsWugDWgdAV5aBOOY2JP5IG+i28C1
 wrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714766267; x=1715371067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cxy5I3qFqegg9o6TUkAnNa/wB20b3zBgd4M5pvNyG88=;
 b=e2f4QT19crXTdJ13UBISakc2t/RpH3KEqQW6D4byKVciOTWdZcoALpXu+3aZqxhbT7
 qbCPFIejG4XY2kCk0u+rN4BXhzQyalD5B9EnfNtoQtJ5j+M83K+l+z+OBh3yaNVx3SU7
 b8ctvfQk/H63NK+Jw7IyPp0eftGcKIroEHvlhYBXenCumyjtKns+PhFKKunV/tkdiIKP
 v/JHtji99Tuy2eJgt8oXi2QkUcm5zdWI/ko/HOAFkNZj9L5aXo5ptokdKr+cZ2l6B7Hx
 79p2YIscgkKCiS+V7rmub+feKACO4eU1XVi1Fdw3LRvguZp/7m5p2r0YiTex7jciWqC0
 oHNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHXTmdOe1Kkxmd+cejjOtg5uDycEpOKVjffKG90IiOZjTeN1viztQnYCPexLmMsa+hzkFcVmeHjoo+PPifok2N/Dm6l8hD7kkbQI3MN5vvYP1GN+zNMb1/e+pwatzS3uxyRV7Q7UFQN3KAEMW00gBhmdc=
X-Gm-Message-State: AOJu0YyAE5ByR+yOVKruG86f5o7mtLYDmvtQojxGSfw/OwKtoL8FhKz8
 xMypFEd/+PkKKdDA9YU2gnsFMHKugOG2Li7vCsz4SzkxjN76HPldJ2uERvSOmH2KSQ70tCQfus5
 Qt0aO0vik2aYNUyXI/Irx7OqMKRk=
X-Google-Smtp-Source: AGHT+IHvBLqIUtLtGVmhAxc4cfveAHJnXHjojAt4dMDpjpEpMbXLrRAdzD5RxpAjaBF4SK/GidysDPCVqb3FUTC0imE=
X-Received: by 2002:a81:a041:0:b0:61a:b0bc:934c with SMTP id
 x62-20020a81a041000000b0061ab0bc934cmr3669080ywg.3.1714766267097; Fri, 03 May
 2024 12:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240415151845.1564201-1-peter.maydell@linaro.org>
 <CAFEAcA86Frw=GcWdjOgXsbP+9dgGjQpxP79k=nKshPm9LK0QVQ@mail.gmail.com>
 <CABtshVRrPv8uUuX3C2k1BPkS4-_0HQH6aKiMFmLr1B1bck-+Pg@mail.gmail.com>
 <CAPan3Wp7jzm+ErEi0LR+F0acOggt94FPfJCYb-VEUGriiZnPtw@mail.gmail.com>
 <CAFEAcA8FS=6mn754LGs6KGDahm0vyifiK9P2i57i_TsKvPqUOw@mail.gmail.com>
In-Reply-To: <CAFEAcA8FS=6mn754LGs6KGDahm0vyifiK9P2i57i_TsKvPqUOw@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 3 May 2024 21:57:36 +0200
Message-ID: <CAPan3Wrkm+hJKoxXa_Q6WtQHvsZWOB819UWS-CBeeAzpvb44NQ@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado: update sunxi kernel from armbian to 6.6.16
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Strahinja Jankovic <strahinjapjankovic@gmail.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Beniamino Galvani <b.galvani@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000039292d06179222f3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000039292d06179222f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:12=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Mon, 29 Apr 2024 at 21:40, Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
> >
> > Hi Peter, Strahinja,
> >
> > I can confirm that the orangepi-pc and cubieboard based tests are
> working OK using the newer kernel 6.6.16:
> >
> >   $ ARMBIAN_ARTIFACTS_CACHED=3Dyes AVOCADO_ALLOW_LARGE_STORAGE=3Dyes
> ./build/pyvenv/bin/avocado --show=3Dapp,console run -t machine:orangepi-p=
c -t
> machine:cubieboard tests/avocado/boot_linux_console.py
> >   ...
> >   RESULTS    : PASS 7 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0
> | CANCEL 1
> >   JOB TIME   : 177.65 s
> >
> > So for this patch:
> > Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>
> Great, thanks. (I'll put this patch into an upcoming arm pullreq.)
>
> > About the BootLinuxConsole.test_arm_orangepi_bionic_20_08 test, I'd be
> happy to provide a patch to revive that test.
> > Since that test is no longer working without having the image available=
,
> this could also be a good moment to re-consider if armbian is really the
> best input for testing
> > the orangepi-pc board. The image is relatively larger and slower
> compared to other images, like the two openwrt based tests for cubieboard
> and bpim2u.
> >
> > After some searching I've found that Openwrt also has orangepi-pc
> support:
> >   https://openwrt.org/toh/xunlong/orange_pi_pc
> >
> > That image works fine with our emulated orangepi-pc board:
> >
> > $ qemu-system-arm -M orangepi-pc -sd
> openwrt-23.05.0-sunxi-cortexa7-xunlong_orangepi-pc-ext4-sdcard.img
> -nographic
>
> > Using openwrt also for the orangepi-pc test instead of armbian also
> gives some consistency between the various tests, to some degree. What ar=
e
> you opinions on this?
>
> Yeah, seems reasonable. My main thing to think about would be
> that to understand what extra coverage this gives us that we
> don't already have (there's no point running a ton of tests
> which all amount to "boot a Linux kernel to a shell prompt").
> It looks like what we get from this one is that we are testing
> the "boot off an SD card image via u-boot" flow -- is that right?
>

Yes, correct.
Okey, I'll try to find some time the coming days to prepare a patch that
replaces test_arm_orangepi_bionic_20_08 with a test that uses openwrt
instead.

Niek



>
> thanks
> -- PMM
>


--=20
Niek Linnenbank

--00000000000039292d06179222f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 30, 2024 at 4:12=E2=80=AF=
PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Mon, 29 Apr 2024 at 21:40, Niek Linnenbank &lt;<a href=3D"=
mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com=
</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Peter, Strahinja,<br>
&gt;<br>
&gt; I can confirm that the orangepi-pc and cubieboard based tests are work=
ing OK using the newer kernel 6.6.16:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0$ ARMBIAN_ARTIFACTS_CACHED=3Dyes AVOCADO_ALLOW_LARGE_STORA=
GE=3Dyes ./build/pyvenv/bin/avocado --show=3Dapp,console run -t machine:ora=
ngepi-pc -t machine:cubieboard tests/avocado/boot_linux_console.py<br>
&gt;=C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0RESULTS=C2=A0 =C2=A0 : PASS 7 | ERROR 0 | FAIL 0 | SKIP 0 =
| WARN 0 | INTERRUPT 0 | CANCEL 1<br>
&gt;=C2=A0 =C2=A0JOB TIME=C2=A0 =C2=A0: 177.65 s<br>
&gt;<br>
&gt; So for this patch:<br>
&gt; Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmai=
l.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; Tested-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.=
com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
<br>
Great, thanks. (I&#39;ll put this patch into an upcoming arm pullreq.)<br>
<br>
&gt; About the BootLinuxConsole.test_arm_orangepi_bionic_20_08 test, I&#39;=
d be happy to provide a patch to revive that test.<br>
&gt; Since that test is no longer working without having the image availabl=
e, this could also be a good moment to re-consider if armbian is really the=
 best input for testing<br>
&gt; the orangepi-pc board. The image is relatively larger and slower compa=
red to other images, like the two openwrt based tests for cubieboard and bp=
im2u.<br>
&gt;<br>
&gt; After some searching I&#39;ve found that Openwrt also has orangepi-pc =
support:<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://openwrt.org/toh/xunlong/orange_pi_pc" r=
el=3D"noreferrer" target=3D"_blank">https://openwrt.org/toh/xunlong/orange_=
pi_pc</a><br>
&gt;<br>
&gt; That image works fine with our emulated orangepi-pc board:<br>
&gt;<br>
&gt; $ qemu-system-arm -M orangepi-pc -sd openwrt-23.05.0-sunxi-cortexa7-xu=
nlong_orangepi-pc-ext4-sdcard.img -nographic<br>
<br>
&gt; Using openwrt also for the orangepi-pc test instead of armbian also gi=
ves some consistency between the various tests, to some degree. What are yo=
u opinions on this?<br>
<br>
Yeah, seems reasonable. My main thing to think about would be<br>
that to understand what extra coverage this gives us that we<br>
don&#39;t already have (there&#39;s no point running a ton of tests<br>
which all amount to &quot;boot a Linux kernel to a shell prompt&quot;).<br>
It looks like what we get from this one is that we are testing<br>
the &quot;boot off an SD card image via u-boot&quot; flow -- is that right?=
<br></blockquote><div><br></div><div>Yes, correct.</div><div>Okey, I&#39;ll=
 try to find some time the coming days to prepare a patch that replaces tes=
t_arm_orangepi_bionic_20_08 with a test that uses openwrt instead.</div><di=
v><br></div><div>Niek<br></div><div><br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div>Niek Linnenbank<br><br></div></div></div></div>

--00000000000039292d06179222f3--

