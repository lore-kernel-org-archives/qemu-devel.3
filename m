Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8D3C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0G3-0003MQ-RS; Mon, 19 May 2025 09:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1uH0Fz-0003La-3Y
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:10:16 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1uH0Fw-0003EL-Mm
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:10:14 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-601dfef6a8dso1849506a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 06:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747660210; x=1748265010; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XW3GfoL3iMZTNM1WIcYcWGmXmNmE0cY5T93QYwSMzcc=;
 b=ZkWSQKF1cTi3Lk5y3ngv2Nt7gdid1wQ8SBBmFe/n9DINWt0L1F1pJne/UjrmI/cxz/
 9OKUyxVDqIuQ3a5AoPMmAXs1r4lC1GUp976y94iScBCrXydV2clf66IUFn6utV1IJ+dB
 UAR24W8sKvOT7+7MXKS6PIaHct5ZNQFag34z2m25tZH+Mpvwh/WSlGd8PvICvdjdJpPa
 MBfOZqniWhxXdYnDH5cBH2gPzSSdGFbU856LyQmR57nXfnwPcI6eAYCiFpcpQLSCL30z
 xg4mjvEn6+rGzyzIY/2m+WLr+VT/tyjlCO13KhUalwYpeLQeMw8uDWOwh68dTiu5HZtn
 HbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747660210; x=1748265010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XW3GfoL3iMZTNM1WIcYcWGmXmNmE0cY5T93QYwSMzcc=;
 b=XoRsCu6WQzJreObEV+3/wuIaz6DTvFQiN2zLG04gQjI2UuzmXUvHhncRtC7YIKHP/H
 8jpdCfkjZVG/H4Ir+C3tL++k0xQ2raFW1mcl3IktFvs4oN0MDVkgkYd29Kc996jerL9u
 5haHQyhLIUACziTXgG8nF4fvc4MjlTZd/kC+IdLtkrgY928bYvdhpLAaErv7ebkZ/VQa
 0nNlGFOGE5X1NeD8eiwjuJ86A1IijnnG+hH+Vvl06hDDfmkwryGdlofeUfjuPFAi9F6p
 YLYpGK2iYCMICmiZNbCtoo3CTLnZD1zgh/9ZRzz4SZS9hs/9XnHy5IbJEmD4lAJd/mxb
 jcmw==
X-Gm-Message-State: AOJu0YwtM7qTlk0LTbgr5/irO8OV0YXFjWo1dmtgSJgUgREW0/3n9LoH
 lmKNv5xjHtlPfY5WXs6amaXP6vr8If6rDhMD/Np9vre2xJmpcs6e30YdbSfWnIo0Pwb/omzvulw
 J2cp6U1O7xWqkVruRlLJx0veL0TgDF24=
X-Gm-Gg: ASbGncs2xc2qCoNU+s32OBMmtoARCWPKY9IN06uSfLLGwX7SN3/QRIq+b8AlyGrH6Ot
 C7JSwF0K1c16LsASEChW2Sg1k5lddOVJMCbrFs7btnFrnAZphdXn4B4SK34x+sXKPQxZXF1Swol
 i6ASKhsxmqhf6FiD4KC2/ES6dCLOf+Y/md
X-Google-Smtp-Source: AGHT+IGPiulYLSHlgtmFObtmCLBWabbIC1leosk6fzzzNHBGXeXVQ794czA/XqCIVExSDzN5V0At7SmYYPJngJAquK4=
X-Received: by 2002:a05:6402:35cc:b0:601:fd36:6f12 with SMTP id
 4fb4d7f45d1cf-601fd367669mr1104018a12.1.1747660209393; Mon, 19 May 2025
 06:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250403191340.53343-1-dominik.b.czarnota@gmail.com>
 <87jz6zw4vx.fsf@draig.linaro.org> <87ecwksqnc.fsf@draig.linaro.org>
In-Reply-To: <87ecwksqnc.fsf@draig.linaro.org>
From: Dominik Czarnota <dominik.b.czarnota@gmail.com>
Date: Mon, 19 May 2025 15:09:33 +0200
X-Gm-Features: AX0GCFuPncuijFQ6ktQCM3uR6sDbWxNLR5kzMgJ4rbj_OjEX0k-5fKSqcKn3UPY
Message-ID: <CABEVAa3HLntehkW0+jHLajbfhagiXg+8d5SG_MR0uzeC8OnEsQ@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: Implement qGDBServerVersion packet
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, gustavo.romero@linaro.org, 
 richard.henderson@linaro.org, philmd@linaro.org, 
 manos.pitsidianakis@linaro.org, 
 "Patryk 'patryk4815' Sondej" <patryk.sondej@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f8211906357cd94d"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=dominik.b.czarnota@gmail.com; helo=mail-ed1-x52f.google.com
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

--000000000000f8211906357cd94d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

On Mon, 19 May 2025 at 14:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com> writes:
> >
> >> This commit adds support for the `qGDBServerVersion` packet to the qem=
u
> >> gdbstub  which could be used by clients to detect the QEMU version
> >> (and, e.g., use a workaround for known bugs).
> >>
> >> This packet is not documented/standarized by GDB but it was implemente=
d
> >> by LLDB gdbstub [0] and is helpful for projects like Pwndbg [1].
> >>
> >> This has been implemented by Patryk, who I included in Co-authored-by
> >> and who asked me to send the patch.
> >>
> >> [0]
> https://lldb.llvm.org/resources/lldbgdbremote.html#qgdbserverversion
> >> [1] https://github.com/pwndbg/pwndbg/issues/2648
> >>
> >> Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
> >> Signed-off-by: Dominik 'Disconnect3d' Czarnota
> >> <dominik.b.czarnota@gmail.com>
> >
> > Hmm:
> >
> > cc -m64 -Ilibuser.a.p -I. -I../.. -Iqapi -Itrace -Iui -Iui/shader
> > -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> > -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2=
 -g
> > -fstack-protector-strong -Wempty-body -Wendif-labels
> > -Wexpansion-to-defined -Wformat-security -Wformat-y2k
> > -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self
> > -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
> > -Wold-style-declaration -Wold-style-definition -Wredundant-decls
> > -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
> > -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
> > -Wno-shift-negative-value -isystem
> > /home/alex/lsrc/qemu.git/linux-headers -isystem linux-headers -iquote
> > . -iquote /home/alex/lsrc/qemu.git -iquote
> > /home/alex/lsrc/qemu.git/include -iquote
> > /home/alex/lsrc/qemu.git/host/include/x86_64 -iquote
> > /home/alex/lsrc/qemu.git/host/include/generic -iquote
> > /home/alex/lsrc/qemu.git/tcg/i386 -pthread -mcx16 -msse2 -D_GNU_SOURCE
> > -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
> > -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero
> > -fzero-call-used-regs=3Dused-gpr -fPIE -DCONFIG_USER_ONLY
> > -DCOMPILING_SYSTEM_VS_USER -MD -MQ libuser.a.p/gdbstub_gdbstub.c.o -MF
> > libuser.a.p/gdbstub_gdbstub.c.o.d -o libuser.a.p/gdbstub_gdbstub.c.o
> > -c ../../gdbstub/gdbstub.c
> > ../../gdbstub/gdbstub.c: In function =E2=80=98handle_query_gdb_server_v=
ersion=E2=80=99:
> > ../../gdbstub/gdbstub.c:1603:74: error: implicit declaration of functio=
n
> =E2=80=98target_name=E2=80=99 [-Werror=3Dimplicit-function-declaration]
> >  1603 |     g_string_printf(gdbserver_state.str_buf,
> "name:qemu-%s;version:%s;", target_name(), QEMU_VERSION);
> >       |
>         ^~~~~~~~~~~
> > ../../gdbstub/gdbstub.c:1603:74: error: nested extern declaration of
> =E2=80=98target_name=E2=80=99 [-Werror=3Dnested-externs]
> > ../../gdbstub/gdbstub.c:1603:46: error: format =E2=80=98%s=E2=80=99 exp=
ects argument of
> type =E2=80=98char *=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=
=99 [-Werror=3Dformat=3D]
> >  1603 |     g_string_printf(gdbserver_state.str_buf,
> "name:qemu-%s;version:%s;", target_name(), QEMU_VERSION);
> >       |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~~~~~~~~~~
> >       |
>         |
> >       |
>         int
> > cc1: all warnings being treated as errors
> >
> > where did target_name() come from and/or go to?
>
> I fixed the include so queued to gdbstub/next, thanks.
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--000000000000f8211906357cd94d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks!</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 19 May 2025 at 14:59,=
 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee=
@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" t=
arget=3D"_blank">alex.bennee@linaro.org</a>&gt; writes:<br>
<br>
&gt; Dominik &#39;Disconnect3d&#39; Czarnota &lt;<a href=3D"mailto:dominik.=
b.czarnota@gmail.com" target=3D"_blank">dominik.b.czarnota@gmail.com</a>&gt=
; writes:<br>
&gt;<br>
&gt;&gt; This commit adds support for the `qGDBServerVersion` packet to the=
 qemu<br>
&gt;&gt; gdbstub=C2=A0 which could be used by clients to detect the QEMU ve=
rsion<br>
&gt;&gt; (and, e.g., use a workaround for known bugs).<br>
&gt;&gt;<br>
&gt;&gt; This packet is not documented/standarized by GDB but it was implem=
ented<br>
&gt;&gt; by LLDB gdbstub [0] and is helpful for projects like Pwndbg [1].<b=
r>
&gt;&gt;<br>
&gt;&gt; This has been implemented by Patryk, who I included in Co-authored=
-by<br>
&gt;&gt; and who asked me to send the patch.<br>
&gt;&gt;<br>
&gt;&gt; [0] <a href=3D"https://lldb.llvm.org/resources/lldbgdbremote.html#=
qgdbserverversion" rel=3D"noreferrer" target=3D"_blank">https://lldb.llvm.o=
rg/resources/lldbgdbremote.html#qgdbserverversion</a><br>
&gt;&gt; [1] <a href=3D"https://github.com/pwndbg/pwndbg/issues/2648" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/pwndbg/pwndbg/issues/2=
648</a><br>
&gt;&gt;<br>
&gt;&gt; Co-authored-by: Patryk &#39;patryk4815&#39; Sondej &lt;<a href=3D"=
mailto:patryk.sondej@gmail.com" target=3D"_blank">patryk.sondej@gmail.com</=
a>&gt;<br>
&gt;&gt; Signed-off-by: Dominik &#39;Disconnect3d&#39; Czarnota<br>
&gt;&gt; &lt;<a href=3D"mailto:dominik.b.czarnota@gmail.com" target=3D"_bla=
nk">dominik.b.czarnota@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Hmm:<br>
&gt;<br>
&gt; cc -m64 -Ilibuser.a.p -I. -I../.. -Iqapi -Itrace -Iui -Iui/shader<br>
&gt; -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include<b=
r>
&gt; -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O=
2 -g<br>
&gt; -fstack-protector-strong -Wempty-body -Wendif-labels<br>
&gt; -Wexpansion-to-defined -Wformat-security -Wformat-y2k<br>
&gt; -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self<br>
&gt; -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs<br>
&gt; -Wold-style-declaration -Wold-style-definition -Wredundant-decls<br>
&gt; -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla<br>
&gt; -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi<br>
&gt; -Wno-shift-negative-value -isystem<br>
&gt; /home/alex/lsrc/qemu.git/linux-headers -isystem linux-headers -iquote<=
br>
&gt; . -iquote /home/alex/lsrc/qemu.git -iquote<br>
&gt; /home/alex/lsrc/qemu.git/include -iquote<br>
&gt; /home/alex/lsrc/qemu.git/host/include/x86_64 -iquote<br>
&gt; /home/alex/lsrc/qemu.git/host/include/generic -iquote<br>
&gt; /home/alex/lsrc/qemu.git/tcg/i386 -pthread -mcx16 -msse2 -D_GNU_SOURCE=
<br>
&gt; -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing<br>
&gt; -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero<br>
&gt; -fzero-call-used-regs=3Dused-gpr -fPIE -DCONFIG_USER_ONLY<br>
&gt; -DCOMPILING_SYSTEM_VS_USER -MD -MQ libuser.a.p/gdbstub_gdbstub.c.o -MF=
<br>
&gt; libuser.a.p/gdbstub_gdbstub.c.o.d -o libuser.a.p/gdbstub_gdbstub.c.o<b=
r>
&gt; -c ../../gdbstub/gdbstub.c<br>
&gt; ../../gdbstub/gdbstub.c: In function =E2=80=98handle_query_gdb_server_=
version=E2=80=99:<br>
&gt; ../../gdbstub/gdbstub.c:1603:74: error: implicit declaration of functi=
on =E2=80=98target_name=E2=80=99 [-Werror=3Dimplicit-function-declaration]<=
br>
&gt;=C2=A0 1603 |=C2=A0 =C2=A0 =C2=A0g_string_printf(gdbserver_state.str_bu=
f, &quot;name:qemu-%s;version:%s;&quot;, target_name(), QEMU_VERSION);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~=
~~~~~~<br>
&gt; ../../gdbstub/gdbstub.c:1603:74: error: nested extern declaration of =
=E2=80=98target_name=E2=80=99 [-Werror=3Dnested-externs]<br>
&gt; ../../gdbstub/gdbstub.c:1603:46: error: format =E2=80=98%s=E2=80=99 ex=
pects argument of type =E2=80=98char *=E2=80=99, but argument 3 has type =
=E2=80=98int=E2=80=99 [-Werror=3Dformat=3D]<br>
&gt;=C2=A0 1603 |=C2=A0 =C2=A0 =C2=A0g_string_printf(gdbserver_state.str_bu=
f, &quot;name:qemu-%s;version:%s;&quot;, target_name(), QEMU_VERSION);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~=C2=
=A0 ~~~~~~~~~~~~~<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int<b=
r>
&gt; cc1: all warnings being treated as errors<br>
&gt;<br>
&gt; where did target_name() come from and/or go to?<br>
<br>
I fixed the include so queued to gdbstub/next, thanks.<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--000000000000f8211906357cd94d--

