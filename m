Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967D8CCF9E5
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Oct 2025 05:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCtdh-0007pg-Aq; Sun, 26 Oct 2025 01:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vCtdc-0007p7-TV
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 01:49:56 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vCtda-0006nM-TK
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 01:49:56 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-430db938c09so1874035ab.2
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761457793; x=1762062593; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qeFPa1/Zflh4e7Htf5toZtXK8LIFeSL3rmsgxzDgbDU=;
 b=l2VKflYaaUDMC3KTaNoyqyKIQL3zSdfJ3ApgW35LBv3L4ZlZYngIuFQAKhbo7hVk4v
 BxumvOxNiRfsZqY1Ax4M/pBvyJPIBxQOFxcl5K3eFESHMdjeWDliEx0hk2yXpPDiOdAm
 Xf8eKvxWI/AjyfU8BiM+tt5nyUSwMazm4PC3Ln54ylxcUhkiIuEBWHcM1waRD846XjkR
 dCafXebWVDky2KJjwo61SVNTyqxNr2nqX7p0anoBQbmIEFh28biV1RcFh09YH88GpWyA
 0kW5QQhoRTRE24N6xFdn7nlWcODI4MoUg+YXsP7OLLwN4+aja9GdaNq6DFZsdeFa4PMw
 /71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761457793; x=1762062593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qeFPa1/Zflh4e7Htf5toZtXK8LIFeSL3rmsgxzDgbDU=;
 b=JJOonRJ4F/SRUiyAK39kGROjff1NMsAOeZ4gPmOi8NIemiVkOPAXbnuI0V48FoZ1uU
 akmBQokP0SU/2RwxESLgmSVmnh+2i7FdLAHGug2C0JXy+kbkKpQnQAiXiKGXkjlFGXWz
 HogfvfJgFGunmdidY0ZVdN4kO04pq3+M0u4P072SBvpU13xqoNKp55zyAkmgBDsYZyRZ
 5f5909JraqyXf4avIPhSa7s2nljDJ3V8pMz4LPx4Ijs7NRE8g2fncGfIvlR4STq3tWcn
 YpADs6y5lDvHl9Qbs4EjBp+V0+JRVGz97POJt//fzZm9KDwGNEii4f7Ph2cqqyHFGx7H
 0X9g==
X-Gm-Message-State: AOJu0YzeV0+GQJlK+XzN1HHp6eZYZLi8MHOpil5QJp186oNsEYVLSECA
 0DyajG2ct1kSb9ckqI8LvnbCgaSH3XMjLM6MzuYwo7VP6vMrSWWE26um/ARnQmFw4HJRi9N3TPH
 kXUjbVEUy0qX+J0zZoldspBVoML1GedQ=
X-Gm-Gg: ASbGnctbnBtvEY1Qa4DEoTvPYa2kWI+Shbw/SPer+nuKaTnmyx/1xDajRCD9RdHPlC6
 tX9/XHk0h7CwXHFUAtxxSKTC8r2/9zmDR1UcLbHqm9pRYiPOKwspXADJlc87UrrpEbnAtBL0sJk
 LXHlGTaV+Zr2HCv+TYQWWaLNrpFzmc+fCKRG0utBdA/66d1fRXPtlOoAiEQF0//IOXcv41puPis
 mmrr7G8XA7H9HJ5HNSSd2LTGvZNBzJvtYusePKBZC8omB7AMp1jiBQfubPJXQNDFhNQlFFWoqe/
 S+priEsIav+OUDwa1Za69y8Q1pYkZA==
X-Google-Smtp-Source: AGHT+IGvlwbVGDWgQ7898L+OV3wnvGvNBbKHpnPfPFrLFuvX6gjaRicdN4LZsYGxj/SOyI86qrw12akFQOcGrGEo6OI=
X-Received: by 2002:a05:6e02:214f:b0:431:da8d:b40 with SMTP id
 e9e14a558f8ab-431da8d0e94mr64203445ab.4.1761457792581; Sat, 25 Oct 2025
 22:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <CAJOT6qN-n7LpVnLO-5CpOUF8z-j1Ogi=6cJBvvKZc-Eh5tHVzA@mail.gmail.com>
 <a410ac54-d1dc-aa67-d1d7-690b2495e9df@eik.bme.hu>
In-Reply-To: <a410ac54-d1dc-aa67-d1d7-690b2495e9df@eik.bme.hu>
From: Yogesh Vyas <yvyas1991@gmail.com>
Date: Sun, 26 Oct 2025 11:19:41 +0530
X-Gm-Features: AWmQ_bnJC5hZ7Xx632IXaVcrVs0i8gYl-JPQEoX4pUIIs6kAjlY511UDHXdms1U
Message-ID: <CAJOT6qN4QYRdNR-oQV8JSv_074umiHB==_dyemX01+FsNiqPOQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Pegasos2 clean up and pegasos1 emulation
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000003830b0642095a57"
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=yvyas1991@gmail.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000003830b0642095a57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 5:37=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:

> On Sun, 19 Oct 2025, Yogesh Vyas wrote:
> > When I run QEMU with the ROM option, the machine boots successfully wit=
h
> > the below command:
> >
> > qemu-system-ppc64 -machine pegasos2 -bios pegasos2.rom \
> >                  -cdrom debian-8.11.0-powerpc-netinst.iso \
> >                  -device VGA,romfile=3D"" -serial stdio
> >
> > However, when I try to boot the machine without the ROM using VOF, the
> > machine does not come up and no logs appear on stdout:
> >
> > qemu-system-ppc64 -machine pegasos2 -serial stdio \
> >                  -kernel vmlinuz-chrp.initrd -append "---" \
> >                  -cdrom debian-8.11.0-powerpc-netinst.iso
> >
> > Please let me know if I am missing any parameters or setup required for
> > booting via VOF on Pegasos2.
> >
> > Documentation referred: qemu/docs/system/ppc/amigang.rst
>
> Maybe you did not use the right vmlinuz-chrp.initrd. Pegasos2 is a 32 bit
> machine so you need /install/powerpc/vmlinuz-chrp.initrd for it (see in
> the /install/pegasos script that is used with firmware). Even if you call
> it from qemu-system-ppc64 which includes both 32 bit and 64 bit machines
> but does not make 32 bit machines 64 bit so you still need the 32 bit OS.
>
>
Hi Balaton,
I am using 32bit images only and looks like VOF boot works with the distro
provided Qemu (both ppc and pp64), however doesn't work with upstream Qemu
for VOF.

yogi@fedora:~/work/images$ file vmlinuz-chrp.initrd
vmlinuz-chrp.initrd: ELF 32-bit MSB executable, PowerPC or cisco 4500,
version 1 (SYSV), statically linked, not stripped

yogi@fedora:~/work/images$ file debian-8.11.0-powerpc-netinst.iso
debian-8.11.0-powerpc-netinst.iso: ISO 9660 CD-ROM filesystem data (DOS/MBR
boot sector) 'Debian 8.11.0 ppc 1'

Qemu distro version:
yogi@fedora:~/work/images$ qemu-system-ppc --version
QEMU emulator version 9.2.4 (qemu-9.2.4-2.fc42)
Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
yogi@fedora:~/work/images$ qemu-system-ppc64 --version
QEMU emulator version 9.2.4 (qemu-9.2.4-2.fc42)
Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers

When using upstream Qemu (both ppc and pp64) with VOF it just gets stuck
with no console output. Am I missing something?

I also tried applying the patches from
https://lore.kernel.org/qemu-devel/cover.1761346145.git.balaton@eik.bme.hu/=
T/#t
but still the same issue.

Regards,
Yogesh



> Regards,
> BALATON Zoltan
>

--00000000000003830b0642095a57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Oct 19,=
 2025 at 5:37=E2=80=AFPM BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.b=
me.hu">balaton@eik.bme.hu</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On Sun, 19 Oct 2025, Yogesh Vyas wrote:<br>
&gt; When I run QEMU with the ROM option, the machine boots successfully wi=
th<br>
&gt; the below command:<br>
&gt;<br>
&gt; qemu-system-ppc64 -machine pegasos2 -bios pegasos2.rom \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -cdrom d=
ebian-8.11.0-powerpc-netinst.iso \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -device =
VGA,romfile=3D&quot;&quot; -serial stdio<br>
&gt;<br>
&gt; However, when I try to boot the machine without the ROM using VOF, the=
<br>
&gt; machine does not come up and no logs appear on stdout:<br>
&gt;<br>
&gt; qemu-system-ppc64 -machine pegasos2 -serial stdio \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -kernel =
vmlinuz-chrp.initrd -append &quot;---&quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -cdrom d=
ebian-8.11.0-powerpc-netinst.iso<br>
&gt;<br>
&gt; Please let me know if I am missing any parameters or setup required fo=
r<br>
&gt; booting via VOF on Pegasos2.<br>
&gt;<br>
&gt; Documentation referred: qemu/docs/system/ppc/amigang.rst<br>
<br>
Maybe you did not use the right vmlinuz-chrp.initrd. Pegasos2 is a 32 bit <=
br>
machine so you need /install/powerpc/vmlinuz-chrp.initrd for it (see in <br=
>
the /install/pegasos script that is used with firmware). Even if you call <=
br>
it from qemu-system-ppc64 which includes both 32 bit and 64 bit machines <b=
r>
but does not make 32 bit machines 64 bit so you still need the 32 bit OS.<b=
r>
<br></blockquote><div><br></div><div>Hi Balaton,</div><div>I am using 32bit=
=C2=A0images only and looks like VOF boot works with the distro provided Qe=
mu (both ppc and pp64), however doesn&#39;t work with upstream Qemu for VOF=
.</div><div><br></div><div>yogi@fedora:~/work/images$ file vmlinuz-chrp.ini=
trd<br>vmlinuz-chrp.initrd: ELF 32-bit MSB executable, PowerPC or cisco 450=
0, version 1 (SYSV), statically linked, not stripped</div><div><br></div><d=
iv>yogi@fedora:~/work/images$ file debian-8.11.0-powerpc-netinst.iso <br>de=
bian-8.11.0-powerpc-netinst.iso: ISO 9660 CD-ROM filesystem data (DOS/MBR b=
oot sector) &#39;Debian 8.11.0 ppc 1&#39;</div><div><br></div><div>Qemu dis=
tro version:=C2=A0</div><div>yogi@fedora:~/work/images$ qemu-system-ppc --v=
ersion<br>QEMU emulator version 9.2.4 (qemu-9.2.4-2.fc42)<br>Copyright (c) =
2003-2024 Fabrice Bellard and the QEMU Project developers<br>yogi@fedora:~/=
work/images$ qemu-system-ppc64 --version<br>QEMU emulator version 9.2.4 (qe=
mu-9.2.4-2.fc42)<br>Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Pr=
oject developers</div><div><br></div><div>When using upstream Qemu (both pp=
c and pp64) with VOF it just gets stuck with no console=C2=A0output. Am I m=
issing something?</div><div><br></div><div>I also tried applying the patche=
s from=C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/cover.1761346145.=
git.balaton@eik.bme.hu/T/#t">https://lore.kernel.org/qemu-devel/cover.17613=
46145.git.balaton@eik.bme.hu/T/#t</a> but still the same issue.</div><div><=
br></div><div>Regards,</div><div>Yogesh</div><div><br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
Regards,<br>
BALATON Zoltan<br>
</blockquote></div></div>

--00000000000003830b0642095a57--

