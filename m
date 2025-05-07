Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E571BC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 11:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCcvf-0001zg-SX; Wed, 07 May 2025 07:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1uCcvb-0001x5-8Y
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:27:10 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1uCcvY-0005Bn-9x
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:27:06 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so1259685166b.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746617222; x=1747222022; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vUOrb2GgTKI8PG+smL+yMuUWqP8gfZ9z5f876OOMT4E=;
 b=E9El6QnbimGMt55+hmgFIU45GgSW/dhQ8+z/IRPudj1L+O1+2Izx+toz/xbyohhdZV
 jqNO8JuN6ysPtcVhYuOQM2xhyzdMd6J3TmRZ0yamZBzyk1Y8Tv6vvxjfWZBQP12Xh27w
 dggoOHDhsbPJny1NRGGB4oJKZ4P6CRPiZyg63JaEEk9TkzgV0lDntP6vmVXvUBwamkfH
 dklxGFHg+lzINlMqEvqE1gIucfW3z9EHnhoINguefYR6KtgniGn2pO/aSJW1w54uBKyS
 1MGIgUuLugg54e4qfhCms8SqXbfB9Dtanwvd7Gj//nrzmQ47rwKdrEHA8pCCl45TnkN3
 mtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746617222; x=1747222022;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vUOrb2GgTKI8PG+smL+yMuUWqP8gfZ9z5f876OOMT4E=;
 b=HKzTiJvITayjg7vjGUtllhz7em8oEaZU37eoxLf9OliGmkmH89/49Klq8bNPGUM7g5
 t2jkXM4HOb1TF8GM/gg/TAjZBJDHQvKiSCdAXVncLjthL/42qkem1Pdvcf9/pG0vQaWI
 PxLqlJ5UYTKl2VkMI2wUd8AhooN0Q+5LsXOT83kimOCE0LLE+25VJE5ZuyQzcAmq0Edp
 5F8PWFyhHtpg6P3ZbzW6fWlBKRuW4j26Gil5dg1W8hWHAPD9Kz+veARWpBG33ThYz4Iz
 jITwOUxRPeRocL+p52H6K/JPUcekHkkHjwdCESwSliQNP4hgP4O1uextWmXe0t/GUCs/
 y89A==
X-Gm-Message-State: AOJu0Yyu2U4kVZSfjlvRoH4GDU6u+WymlRteHWXDpTkc8DPErxCGUGkU
 qNfzpi2Rhjen3B0BbTQlHEnKXvlbeyExcGZelk4yZgK2DL7q0Q2tk2o62xF7QxZAIT/HZBVVv/R
 uHqKMkJXPG/T54CXVyAif9CJCVV0=
X-Gm-Gg: ASbGncuy9n+JwlhCG2Ii34VM7rWm6b5NvS5AtG7cM4oUjgRLr6xa3aS1Cu6zugcHkUv
 L1XuR390bbU3Stu0nEdU30GT8ua/dVi0a6XVrGplmq14BreH4U5TcBn/evpzsJ5DopdIW4126DS
 2AOHcDTa4Sf1dgvhs9DX0Cjw==
X-Google-Smtp-Source: AGHT+IEmH1Ieu5H6RswmLurTj/KE5/Mpzg8SXV26myrw5nUoV5PVCxZvjB6nEuodorzcq5UDnOvRAfpCSeZpiKwMREY=
X-Received: by 2002:a17:907:d406:b0:ace:4df8:b0c6 with SMTP id
 a640c23a62f3a-ad1e8d0525cmr271822966b.38.1746617221449; Wed, 07 May 2025
 04:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250404102603.59936-1-dominik.b.czarnota@gmail.com>
 <87ecx7w3qk.fsf@draig.linaro.org>
In-Reply-To: <87ecx7w3qk.fsf@draig.linaro.org>
From: Dominik Czarnota <dominik.b.czarnota@gmail.com>
Date: Wed, 7 May 2025 13:26:24 +0200
X-Gm-Features: ATxdqUGK4zF-p0rkHPxoubNerGg0qMcVd9UtG6wIv2KttCn_9rNKZ_s3Ya53kWQ
Message-ID: <CABEVAa1WSYFjxJ-am6UNzZD+JCbyyPmawQhD+-oSxcNkVsQoGA@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: Implement qqemu.Pid packet
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, gustavo.romero@linaro.org, 
 richard.henderson@linaro.org, philmd@linaro.org, 
 manos.pitsidianakis@linaro.org, 
 "Patryk 'patryk4815' Sondej" <patryk.sondej@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000000b107d06348a03c2"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=dominik.b.czarnota@gmail.com; helo=mail-ej1-x630.google.com
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

--0000000000000b107d06348a03c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We need the `qqemu.Pid` packet only for the QEMU system part in order to
figure out the page tables and to do it efficiently. We do have a fallback
to using `monitor info mem` but it is slow, (iirc) doesn't provide all the
necessary information and (iirc) isn't implemented on all architectures.

Also, is the QEMU own pid leak such a problem? There are worse issues than
that available with current features though I believe they are not really
security issues. I will detail this in a private email to you.

Best,
Dominik 'Disconnect3d' Czarnota

On Fri, 2 May 2025 at 15:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:

> Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com> writes:
>
> > This patch adds support for the `qqemu.Pid` packet to the qemu
> > gdbstub which can be used by clients to get the QEMU process PID.
> >
> > This is useful for plugins like Pwndbg [0] or gdb-pt-dump in order to
> > inspect the QEMU process memory through the /proc/self/{maps,mem}
> > interfaces. Without this feature, they have to rely on doing an
> > unreliable pgrep/ps output processing.
>
> That seems a little thin a reason for QEMU to expose its own PID. For
> user-mode you can already get that detail through anything using
> gdb_append_thread_id().
>
> For system-mode leaking QEMU's own pid seems like an information leak at
> best. There are modes like semihosting which give a remote even more
> power but you need to at least opt in to that.
>
> >
> > This patch has been developed by Patryk, who I included in the
> > Co-authored-by and who asked me to send the patch.
> >
> > [0] https://github.com/pwndbg/pwndbg
> > [1] https://github.com/martinradev/gdb-pt-dump
> >
> > Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
> > Signed-off-by: Dominik 'Disconnect3d' Czarnota <
> dominik.b.czarnota@gmail.com>
> > ---
> >  gdbstub/gdbstub.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> > index 282e13e163..a077c2c5ed 100644
> > --- a/gdbstub/gdbstub.c
> > +++ b/gdbstub/gdbstub.c
> > @@ -1746,6 +1746,12 @@ static void handle_query_qemu_supported(GArray
> *params, void *user_ctx)
> >      gdb_put_strbuf();
> >  }
> >
> > +static void handle_query_qemu_pid(GArray *params, void *user_ctx)
> > +{
> > +    g_string_printf(gdbserver_state.str_buf, "F%x", getpid());
> > +    gdb_put_strbuf();
> > +}
> > +
> >  static const GdbCmdParseEntry gdb_gen_query_set_common_table[] =3D {
> >      /* Order is important if has same prefix */
> >      {
> > @@ -1902,6 +1908,10 @@ static const GdbCmdParseEntry
> gdb_gen_query_table[] =3D {
> >          .handler =3D handle_query_qemu_supported,
> >          .cmd =3D "qemu.Supported",
> >      },
> > +    {
> > +        .handler =3D handle_query_qemu_pid,
> > +        .cmd =3D "qemu.Pid",
> > +    },
> >  #ifndef CONFIG_USER_ONLY
> >      {
> >          .handler =3D gdb_handle_query_qemu_phy_mem_mode,
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000000b107d06348a03c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>We need the `qqemu.Pid` packet only for the QEM=
U system part in order to figure out the page tables and to do it efficient=
ly. We do have a fallback to using `monitor info mem` but it is slow, (iirc=
) doesn&#39;t provide all the necessary information and (iirc) isn&#39;t im=
plemented on all architectures.<br><br>Also, is the QEMU own pid leak such =
a problem? There are worse issues than that available with current features=
 though I believe they are not really security issues. I will detail this i=
n a private email to you.<br><br>Best,<br>Dominik &#39;Disconnect3d&#39; Cz=
arnota<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Fri, 2 May 2025 at 15:18, Alex Benn=C3=
=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Do=
minik &#39;Disconnect3d&#39; Czarnota &lt;<a href=3D"mailto:dominik.b.czarn=
ota@gmail.com" target=3D"_blank">dominik.b.czarnota@gmail.com</a>&gt; write=
s:<br>
<br>
&gt; This patch adds support for the `qqemu.Pid` packet to the qemu<br>
&gt; gdbstub which can be used by clients to get the QEMU process PID.<br>
&gt;<br>
&gt; This is useful for plugins like Pwndbg [0] or gdb-pt-dump in order to<=
br>
&gt; inspect the QEMU process memory through the /proc/self/{maps,mem}<br>
&gt; interfaces. Without this feature, they have to rely on doing an<br>
&gt; unreliable pgrep/ps output processing.<br>
<br>
That seems a little thin a reason for QEMU to expose its own PID. For<br>
user-mode you can already get that detail through anything using<br>
gdb_append_thread_id().<br>
<br>
For system-mode leaking QEMU&#39;s own pid seems like an information leak a=
t<br>
best. There are modes like semihosting which give a remote even more<br>
power but you need to at least opt in to that.<br>
<br>
&gt;<br>
&gt; This patch has been developed by Patryk, who I included in the<br>
&gt; Co-authored-by and who asked me to send the patch.<br>
&gt;<br>
&gt; [0] <a href=3D"https://github.com/pwndbg/pwndbg" rel=3D"noreferrer" ta=
rget=3D"_blank">https://github.com/pwndbg/pwndbg</a><br>
&gt; [1] <a href=3D"https://github.com/martinradev/gdb-pt-dump" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/martinradev/gdb-pt-dump</a><br=
>
&gt;<br>
&gt; Co-authored-by: Patryk &#39;patryk4815&#39; Sondej &lt;<a href=3D"mail=
to:patryk.sondej@gmail.com" target=3D"_blank">patryk.sondej@gmail.com</a>&g=
t;<br>
&gt; Signed-off-by: Dominik &#39;Disconnect3d&#39; Czarnota &lt;<a href=3D"=
mailto:dominik.b.czarnota@gmail.com" target=3D"_blank">dominik.b.czarnota@g=
mail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 gdbstub/gdbstub.c | 10 ++++++++++<br>
&gt;=C2=A0 1 file changed, 10 insertions(+)<br>
&gt;<br>
&gt; diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c<br>
&gt; index 282e13e163..a077c2c5ed 100644<br>
&gt; --- a/gdbstub/gdbstub.c<br>
&gt; +++ b/gdbstub/gdbstub.c<br>
&gt; @@ -1746,6 +1746,12 @@ static void handle_query_qemu_supported(GArray =
*params, void *user_ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 gdb_put_strbuf();<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void handle_query_qemu_pid(GArray *params, void *user_ctx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_string_printf(gdbserver_state.str_buf, &quot;F%x&quot=
;, getpid());<br>
&gt; +=C2=A0 =C2=A0 gdb_put_strbuf();<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static const GdbCmdParseEntry gdb_gen_query_set_common_table[] =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Order is important if has same prefix */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt; @@ -1902,6 +1908,10 @@ static const GdbCmdParseEntry gdb_gen_query_tab=
le[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .handler =3D handle_query_qemu_suppo=
rted,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cmd =3D &quot;qemu.Supported&quot;,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .handler =3D handle_query_qemu_pid,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cmd =3D &quot;qemu.Pid&quot;,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt;=C2=A0 #ifndef CONFIG_USER_ONLY<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .handler =3D gdb_handle_query_qemu_p=
hy_mem_mode,<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--0000000000000b107d06348a03c2--

