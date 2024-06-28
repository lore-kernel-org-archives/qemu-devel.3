Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2283C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 00:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMzrz-0003U2-Nz; Thu, 27 Jun 2024 20:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sMzry-0003Ts-DK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 20:53:42 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sMzrw-0005Od-Bp
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 20:53:42 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7201cb6cae1so17536a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 17:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719536019; x=1720140819; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X2PajZVcdpJStZJuKe6/EwdEXwjE9+qKdW5+641aC+U=;
 b=TQ3dUluDlnrFKsOZnQ2bjqDbg2emk22D0EHVhQ3Ijhx7VrJkIuRJVp4g5Jso9NDGTK
 EY8yLvgCHy1+ujNU/7dPyfiiKbn1RKauqn6CUk+RF0KnFA0bF7eX5iMK08A2X1aNq8/U
 F9UOhEwLOlebIfL9E2z43zq4sShs5vXl4YbZr0L40z89DFJrpTlseCIauRwcnkvovi0S
 J3uWoAneL+mOabAy6xI1L9Kq6xLhrnx6OIP44PJ99iEyGy9Tk9OhEt2VEGpqHNad6o1r
 12Z2GYNsRqzvBvWhkG78cSiuZApVJTIXqAoNhEtxrdF5e/4HU4VvxoeqWnfr9G5ZzsgQ
 jJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719536019; x=1720140819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X2PajZVcdpJStZJuKe6/EwdEXwjE9+qKdW5+641aC+U=;
 b=bfJZTTxT/9uSigUuJ217ZwlIGoFV3y0dSXPBpKlqZq2zUVY2oO4ax9IcVmqIPft7QT
 tTCnUCVhRI3aqKlR9oxdRaTSQtz5pVDOFSXkmJeLtW+DbaE1UOb3K+vCaGOiFxlQSb/J
 mppGsGvmnaEyLvlmBVrUfVWtahHl27Ke2OiXe+hg1Xzjl8AUMS28EMS5Ga0Yp5Xl9dSI
 ur51P4641vG7VsXf7JolCxedac/HmU7LfBz+nWs+U0smBsqPZ7xVzxf8l/v7j44iXs5f
 j3W9CGorSbTZZ4RgV1GHZvRDXGk+VeGfNgad9cA+5WMtSHCICviO60pi5I+ViAav0a17
 FlWw==
X-Gm-Message-State: AOJu0Yzq6sZUeF+qQA3EaW82wPLZcKYGHAQsJyek7vyBOwyzmgrfgRqL
 DJQcRpcZ7elildmfQ1wVXl7xdmEVGPn4imJDXZZQ5Z6DSytqfGprFxiGTdntV/0sHDEdaUktGMd
 GPvptkWBolHoWM0PZEzF6wh7Hu58=
X-Google-Smtp-Source: AGHT+IFyeK7dcVXqpIQ1GgQMxQRU7D8xx0V/YloLrjak62Kb2RXl8n7wdqMHUi0Fwxy9MpgqU93MFfUHgTQdqXriD0g=
X-Received: by 2002:a05:6a20:daa1:b0:1bd:2adb:8639 with SMTP id
 adf61e73a8af0-1bd2adb8b21mr9372224637.48.1719536018699; Thu, 27 Jun 2024
 17:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240627020207.630125-1-gregorhaas1997@gmail.com>
 <OSZPR01MB64532802F85690BB7C8BAA998DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <CAMqWt3rcN+y3ND34Rz9d5A32rNBh4MTRBNkx44wt_w22g61XUg@mail.gmail.com>
 <OSZPR01MB64535FCCEF207697E298CDE58DD02@OSZPR01MB6453.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB64535FCCEF207697E298CDE58DD02@OSZPR01MB6453.jpnprd01.prod.outlook.com>
From: Gregor Haas <gregorhaas1997@gmail.com>
Date: Thu, 27 Jun 2024 17:53:02 -0700
Message-ID: <CAMqWt3ohW8Fw2O3gdWh3pUQEqi2afD-bKLDp6B3UaBH89cp8vA@mail.gmail.com>
Subject: Re: [PATCH] hw/core/loader: allow loading larger ROMs
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000092bf9e061be8ad63"
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000092bf9e061be8ad63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xingtao,

Thank you for reproducing this -- I agree with your conclusion and will
send a v2 patchset momentarily.

Thank you,
Gregor

On Thu, Jun 27, 2024 at 5:44=E2=80=AFPM Xingtao Yao (Fujitsu) <
yaoxt.fnst@fujitsu.com> wrote:

> Hi, Gregor
>
>
>
> >rom: file fw_payload.bin: read error: rc=3D2147479552 (expected 23037603=
92)
> >qemu-system-riscv64: could not load firmware 'fw_payload.bin'
>
> Thanks, I was able to reproduce the problem when the images size is
> larger than 2147479552.
>
>
>
> I found that in my test environment, the maximum value returned by a read
> operation is 2147479552,
>
> which was affected by the operating system.
>
>
>
> We can find this limitation in the man page:
>
> NOTES
>
>        The types size_t and ssize_t are, respectively, unsigned and
> signed integer data types specified by POSIX.1.
>
>
>
>        On Linux, read() (and similar system calls) will transfer at most
> 0x7ffff000 (2,147,479,552) bytes, returning the number of bytes actually
> transferred.  (This is true on both
>
>        32-bit and 64-bit systems.)
>
>
>
>
>
> > +    do {
>
> > +        rc =3D read(fd, &rom->data[sz], rom->datasize);
>
> > +        if (rc =3D=3D -1) {
>
> > +                fprintf(stderr, "rom: file %-20s: read error: %s\n",
>
> > +                        rom->name, strerror(errno));
>
> > +                goto err;
>
> > +        }
>
> > +        sz +=3D rc;
>
> > +    } while (sz !=3D rom->datasize);
>
> I think we can use load_image_size() instead.
>
>
>
>
>
>
>
>
>
> *From:* Gregor Haas <gregorhaas1997@gmail.com>
> *Sent:* Friday, June 28, 2024 1:35 AM
> *To:* Yao, Xingtao/=E5=A7=9A =E5=B9=B8=E6=B6=9B <yaoxt.fnst@fujitsu.com>
> *Cc:* qemu-devel@nongnu.org; philmd@linaro.org;
> richard.henderson@linaro.org
> *Subject:* Re: [PATCH] hw/core/loader: allow loading larger ROMs
>
>
>
> Hi Xingtao,
>
> > Can you reproduce this issue?
> Absolutely! I encountered this when trying to load an OpenSBI payload
> firmware using the bios option for the QEMU RISC-V virt board. These
> payload firmwares bundle the entire next boot stage, which in my case is =
a
> build of the Linux kernel (which is a standard configuration, supported b=
y
> tools such as Buildroot [1]). My kernel (configured with the default 64-b=
it
> RISC-V configuration) comes in at 9.8M, which is copied into the OpenSBI
> firmware of final size 10M. Then, I run the following QEMU command:
>
> qemu-system-riscv64 -machine virt -m 4G -nographic -bios fw_payload.bin
>
> and get the following output:
>
> rom: file fw_payload.bin: read error: rc=3D2147479552 (expected 230376039=
2)
> qemu-system-riscv64: could not load firmware 'fw_payload.bin'
>
> This is from my development machine, running Arch Linux with kernel 6.9.6
> and root filesystem ZFS 2.2.4. Please let me know if you'd like me to mak=
e
> a minimal reproducer for this, or if you need any more information.
>
> Thanks,
> Gregor
>
> [1]
> https://github.com/buildroot/buildroot/blob/master/boot/opensbi/Config.in=
#L95
>
>
>
> On Wed, Jun 26, 2024 at 11:11=E2=80=AFPM Xingtao Yao (Fujitsu) <
> yaoxt.fnst@fujitsu.com> wrote:
>
> Hi, Gregor
> >
> > The read() syscall is not guaranteed to return all data from a file. Th=
e
> > default ROM loader implementation currently does not take this into
> account,
> > instead failing if all bytes are not read at once. This change wraps th=
e
> > read() syscall in a do/while loop to ensure all bytes of the ROM are
> read.
> Can you reproduce this issue?
>
> Thanks
> Xingtao
>
>

--00000000000092bf9e061be8ad63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Xingtao,<br><br>Thank you for reproducing this -- I agr=
ee with your conclusion and will<br>send a v2 patchset momentarily.<br><br>=
Thank you,<br>Gregor</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Thu, Jun 27, 2024 at 5:44=E2=80=AFPM Xingtao Yao (Fu=
jitsu) &lt;<a href=3D"mailto:yaoxt.fnst@fujitsu.com">yaoxt.fnst@fujitsu.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<div class=3D"msg-6989318239840215191">







<div lang=3D"JA" style=3D"overflow-wrap: break-word;">
<div class=3D"m_-6989318239840215191WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi, </span>
<span lang=3D"EN-US">Gregor</span><span lang=3D"EN-US"><u></u><u></u></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;</span><span lang=3D"EN-US"=
>rom: file
<span class=3D"m_-6989318239840215191SpellE">fw_payload.bin</span>: read er=
ror: <span class=3D"m_-6989318239840215191SpellE">rc</span>=3D2147479552 (e=
xpected 2303760392)<br>
</span><span lang=3D"EN-US">&gt;</span><span lang=3D"EN-US">qemu-system-ris=
cv64: could not load firmware &#39;<span class=3D"m_-6989318239840215191Spe=
llE">fw_payload.bin</span>&#39;</span><span lang=3D"EN-US"><u></u><u></u></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks, I was able to reproduce=
 the problem</span><span lang=3D"EN-US"> when the images size is larger tha=
n
</span><span lang=3D"EN-US">2147479552</span><span lang=3D"EN-US">.<u></u><=
u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I found that in my test environ=
ment, the maximum value returned by a read operation is 2147479552,
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">which was affected by the opera=
ting system.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">We can find this limitation in =
the man page:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">NOTES<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><span>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
</span>The types <span class=3D"m_-6989318239840215191SpellE">size_t</span>=
 and <span class=3D"m_-6989318239840215191SpellE">ssize_t</span> are, respe=
ctively, unsigned and signed integer data types specified by POSIX.1.<u></u=
><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><span>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
</span>On Linux, read() (and similar system calls) will transfer at most 0x=
7ffff000 (2,147,479,552) bytes, returning the number of bytes actually tran=
sferred.<span>=C2=A0
</span>(This is true on both<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><span>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
</span>32-bit and 64-bit systems.)<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; +<span>=C2=A0=C2=A0=C2=A0
</span>do {<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; +<span>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
</span><span class=3D"m_-6989318239840215191SpellE">rc</span> =3D read(<spa=
n class=3D"m_-6989318239840215191SpellE">fd</span>, &amp;rom-&gt;data[<span=
 class=3D"m_-6989318239840215191SpellE">sz</span>], rom-&gt;<span class=3D"=
m_-6989318239840215191SpellE">datasize</span>);</span><span lang=3D"EN-US">=
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; +<span>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
</span>if (rc =3D=3D -1) {<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; +<span>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span><span class=3D"m_-6989318239840215191SpellE">fprintf</span>(stderr, =
&quot;rom: file %-20s: read error: %s\n&quot;,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; +<span>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span>rom-&gt;name, <span class=3D"m_-6989318239840215191SpellE">strerror<=
/span>(<span class=3D"m_-6989318239840215191SpellE">errno</span>));<u></u><=
u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; +<span>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span><span class=3D"m_-6989318239840215191SpellE">goto</span> err;<u></u>=
<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; +<span>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
</span>}<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; +<span>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
</span><span class=3D"m_-6989318239840215191SpellE">sz</span> +=3D <span cl=
ass=3D"m_-6989318239840215191SpellE">rc</span>;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; +<span>=C2=A0=C2=A0=C2=A0
</span>} while (<span class=3D"m_-6989318239840215191SpellE">sz</span> !=3D=
 rom-&gt;<span class=3D"m_-6989318239840215191SpellE">datasize</span>);</sp=
an><span lang=3D"EN-US"><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I think we can use
<span class=3D"m_-6989318239840215191SpellE">load_image_size</span>() inste=
ad.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><u></u>=C2=A0<u></u></span></p>
<div style=3D"border-width:medium medium medium 1.5pt;border-style:none non=
e none solid;border-color:currentcolor currentcolor currentcolor blue;paddi=
ng:0mm 0mm 0mm 4pt">
<div>
<div style=3D"border-width:1pt medium medium;border-style:solid none none;b=
order-color:rgb(225,225,225) currentcolor currentcolor;padding:3pt 0mm 0mm"=
>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11pt;font=
-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-US=
" style=3D"font-size:11pt;font-family:&quot;Calibri&quot;,sans-serif"> Greg=
or Haas
 &lt;<a href=3D"mailto:gregorhaas1997@gmail.com" target=3D"_blank">gregorha=
as1997@gmail.com</a>&gt; <br>
<b>Sent:</b> Friday, June 28, 2024 1:35 AM<br>
<b>To:</b> Yao, Xingtao/</span><span lang=3D"ZH-CN" style=3D"font-size:11pt=
">=E5=A7=9A</span><span lang=3D"ZH-CN" style=3D"font-size:11pt;font-family:=
&quot;Calibri&quot;,sans-serif">
</span><span lang=3D"ZH-CN" style=3D"font-size:11pt">=E5=B9=B8=E6=B6=9B</sp=
an><span lang=3D"EN-US" style=3D"font-size:11pt;font-family:&quot;Calibri&q=
uot;,sans-serif">
 &lt;<a href=3D"mailto:yaoxt.fnst@fujitsu.com" target=3D"_blank">yaoxt.fnst=
@fujitsu.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-=
devel@nongnu.org</a>; <a href=3D"mailto:philmd@linaro.org" target=3D"_blank=
">philmd@linaro.org</a>; <a href=3D"mailto:richard.henderson@linaro.org" ta=
rget=3D"_blank">richard.henderson@linaro.org</a><br>
<b>Subject:</b> Re: [PATCH] hw/core/loader: allow loading larger ROMs<u></u=
><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Xingtao,<br>
<br>
&gt; Can you reproduce this issue?<br>
Absolutely! I encountered this when trying to load an OpenSBI payload<br>
firmware using the bios option for the QEMU RISC-V virt board. These<br>
payload firmwares bundle the entire next boot stage, which in my case is a<=
br>
build of the Linux kernel (which is a standard configuration, supported by<=
br>
tools such as Buildroot [1]). My kernel (configured with the default 64-bit=
<br>
RISC-V configuration) comes in at 9.8M, which is copied into the OpenSBI<br=
>
firmware of final size 10M. Then, I run the following QEMU command:<br>
<br>
qemu-system-riscv64 -machine virt -m 4G -nographic -bios fw_payload.bin<br>
<br>
and get the following output:<br>
<br>
rom: file fw_payload.bin: read error: rc=3D2147479552 (expected 2303760392)=
<br>
qemu-system-riscv64: could not load firmware &#39;fw_payload.bin&#39;<br>
<br>
This is from my development machine, running Arch Linux with kernel 6.9.6<b=
r>
and root filesystem ZFS 2.2.4. Please let me know if you&#39;d like me to m=
ake<br>
a minimal reproducer for this, or if you need any more information.<br>
<br>
Thanks,<br>
Gregor<br>
<br>
[1] <a href=3D"https://github.com/buildroot/buildroot/blob/master/boot/open=
sbi/Config.in#L95" target=3D"_blank">
https://github.com/buildroot/buildroot/blob/master/boot/opensbi/Config.in#L=
95</a><u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><span lang=3D"EN-US"><u=
></u>=C2=A0<u></u></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">On Wed, Jun 26, 2024 at 11:11</=
span><span lang=3D"EN-US" style=3D"font-family:&quot;Cambria Math&quot;,ser=
if">=E2=80=AF</span><span lang=3D"EN-US">PM Xingtao Yao (Fujitsu) &lt;<a hr=
ef=3D"mailto:yaoxt.fnst@fujitsu.com" target=3D"_blank">yaoxt.fnst@fujitsu.c=
om</a>&gt;
 wrote:<u></u><u></u></span></p>
</div>
<blockquote style=3D"border-width:medium medium medium 1pt;border-style:non=
e none none solid;border-color:currentcolor currentcolor currentcolor rgb(2=
04,204,204);padding:0mm 0mm 0mm 6pt;margin-left:4.8pt;margin-right:0mm">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi, Gregor<br>
&gt; <br>
&gt; The read() syscall is not guaranteed to return all data from a file. T=
he<br>
&gt; default ROM loader implementation currently does not take this into ac=
count,<br>
&gt; instead failing if all bytes are not read at once. This change wraps t=
he<br>
&gt; read() syscall in a do/while loop to ensure all bytes of the ROM are r=
ead.<br>
Can you reproduce this issue? <br>
<br>
Thanks<br>
Xingtao<u></u><u></u></span></p>
</blockquote>
</div>
</div>
</div>
</div>

</div></blockquote></div>

--00000000000092bf9e061be8ad63--

