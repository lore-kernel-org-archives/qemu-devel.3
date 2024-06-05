Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2844CC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 10:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEo3s-0006Kg-NE; Wed, 05 Jun 2024 06:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEo3r-0006K1-0O
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:40:07 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEo3o-00065j-94
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:40:06 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-44027277ebdso7150861cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 03:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717584003; x=1718188803; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1FT/ljV2FWlGKKe3IoVAqAIGuz9qJBfJq+Gf/KQcjmY=;
 b=SgyXcb6k7g/n0ex2yHzPD9wypcwBZIdb71TmxITjJ6OvWm7/eBrp2vtTnoaI0WoSdy
 pMKA0/c32Z6IuSD08RzWi0qvjJ5dOwzRSJdJvuNxnsyN+zSmmFmM2TWv59mLyjVPf3HW
 B8AQ6gL8ATdpDEGvnnC+9VeNHRmFSmGXbIEpYx45L57xAfNiNRqNR4a7mRtOBDVN5L/z
 nFN5IxhW9Y6qM9AlI/Qu97jvj7vs0TnBOUf8ZEjE7aN9XItQVjVy9Fw7hc0loKTon47+
 jebyqiy26RXcxEuYpvXIcAlp6Sdfn5ySCRWGo9aQykH5kIOhyQbvxThdgel3RNjOm9e1
 vZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717584003; x=1718188803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1FT/ljV2FWlGKKe3IoVAqAIGuz9qJBfJq+Gf/KQcjmY=;
 b=CYiSxMiTM2rJjme9L2gvY89MguHqSVOQJLP/bAwgEgCmNeiXoQx/264EctCwwq/5uK
 8SAGvwQ1Pxu57AZoB0VGYmOGkGUUletc2dLAIwWO2BFcgOaZcqnsSJatx0gC2wbaXmKF
 A8ZBijDWKl6pIHLwcl5NsV9UfDFZeUdVVVsCh4OSipQ+Ah+txPX3BraoDcqWEEH2c++H
 +h1c0TW73SP1R9Bz+sh7COTA/5gBNyy65lPUjCsCwJ0tEibyphPm+F6slyqPd2ItKTb0
 QZ44zUtCTAYt4gdENVhYoUujOpg2QiXx3zif/VHesQJCaSqyjTLPHdXXIHP77LUQbpa1
 /L4A==
X-Gm-Message-State: AOJu0YyjEktHvK+k9T2vUegl2CFIdoeO1YQbHWSh64b3+rcdPdcBY1W+
 hEGxLxTRCdalhpi/meRgPLaMOxrCbEn+KL7wOEY8lxPkK7gx8mEwmYEJt2z3m2K/v4JsEbNG0TA
 jDK79/5OjZeCxc1SZO5wM3ufnntU=
X-Google-Smtp-Source: AGHT+IFQGkdHvS9dQ4a8sWR+BtIzv5GmG8Pp1J0iE1rqaTdFQcCfHj+fariLCWoQdKBEitHShBguPDlgPTL9uobp7L8=
X-Received: by 2002:ac8:7f08:0:b0:440:2214:9232 with SMTP id
 d75a77b69052e-4402b6c5547mr20558891cf.58.1717584003057; Wed, 05 Jun 2024
 03:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-21-berrange@redhat.com>
 <CAJ+F1CKE412ZvLJQRSfvO_gV1irUyQxP0xZ+Ejfuqf=QxeS+Tg@mail.gmail.com>
In-Reply-To: <CAJ+F1CKE412ZvLJQRSfvO_gV1irUyQxP0xZ+Ejfuqf=QxeS+Tg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Jun 2024 14:39:52 +0400
Message-ID: <CAJ+F1C+HuyCaVfWWYfxjmEAU9kYjsC+odQB3WRFSTjKjTiBiBw@mail.gmail.com>
Subject: Re: [PATCH 20/20] qga: centralize logic for disabling/enabling
 commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005fd063061a22303e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

--0000000000005fd063061a22303e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 5, 2024 at 2:37=E2=80=AFPM Marc-Andr=C3=A9 Lureau <marcandre.lu=
reau@gmail.com>
wrote:

> Hi
>
> On Tue, Jun 4, 2024 at 5:51=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
> wrote:
>
>> It is confusing having many different pieces of code enabling and
>> disabling commands, and it is not clear that they all have the same
>> semantics, especially wrt prioritization of the block/allow lists.
>>
>> Centralizing the code in a single method "ga_apply_command_filters"
>> will provide a strong guarantee of consistency and clarify the
>> intended behaviour.
>>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>
>
> The clean up is very much welcome and looks correct, but it crashes:
>
> Thread 1 "qemu-ga" received signal SIGSEGV, Segmentation fault.
> 0x000055555557db4f in ga_command_is_allowed (cmd=3D0x555555632800,
> state=3D0x555555633710) at ../qga/main.c:430
> 430    if (config->allowedrpcs) {
> (gdb) bt
> #0  0x000055555557db4f in ga_command_is_allowed (cmd=3D0x555555632800,
> state=3D0x555555633710) at ../qga/main.c:430
> #1  ga_apply_command_filters_iter (cmd=3D0x555555632800,
> opaque=3D0x555555633710) at ../qga/main.c:473
> #2  0x000055555559ef81 in qmp_for_each_command (cmds=3Dcmds@entry=3D0x555=
55562c2b0
> <ga_commands>, fn=3Dfn@entry=3D0x55555557db30
> <ga_apply_command_filters_iter>, opaque=3Dopaque@entry=3D0x555555633710)
>     at ../qapi/qmp-registry.c:93
> #3  0x0000555555571436 in ga_apply_command_filters (state=3D0x55555563371=
0)
> at ../qga/main.c:492
> #4  initialize_agent (config=3D0x555555632760, socket_activation=3D0) at
> ../qga/main.c:1452
> #5  main (argc=3D<optimized out>, argv=3D<optimized out>) at ../qga/main.=
c:1646
> (gdb) p state.config
> $1 =3D (GAConfig *) 0x0
>
> (meson test fails too)
>
> I wonder why s->config is set so late in initialize_agent(). Moving it
> earlier seems to solve the issue, but reviewing all code paths is tedious=
..
>

Actually, there seems to be few ->config users, and they don't check if
it's NULL. So I guess it's ok to move it earlier.

--=20
Marc-Andr=C3=A9 Lureau

--0000000000005fd063061a22303e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 5, 2024 at 2:37=E2=80=
=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.c=
om">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tu=
e, Jun 4, 2024 at 5:51=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"ma=
ilto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">It is confus=
ing having many different pieces of code enabling and<br>
disabling commands, and it is not clear that they all have the same<br>
semantics, especially wrt prioritization of the block/allow lists.<br>
<br>
Centralizing the code in a single method &quot;ga_apply_command_filters&quo=
t;<br>
will provide a strong guarantee of consistency and clarify the<br>
intended behaviour.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>The clean up is very much welcome and looks correct, but it c=
rashes:</div><div><br></div><div>Thread 1 &quot;qemu-ga&quot; received sign=
al SIGSEGV, Segmentation fault.<br>0x000055555557db4f in ga_command_is_allo=
wed (cmd=3D0x555555632800, state=3D0x555555633710) at ../qga/main.c:430<br>=
430	 =C2=A0 =C2=A0if (config-&gt;allowedrpcs) {<br>(gdb) bt<br>#0 =C2=A00x0=
00055555557db4f in ga_command_is_allowed (cmd=3D0x555555632800, state=3D0x5=
55555633710) at ../qga/main.c:430<br>#1 =C2=A0ga_apply_command_filters_iter=
 (cmd=3D0x555555632800, opaque=3D0x555555633710) at ../qga/main.c:473<br>#2=
 =C2=A00x000055555559ef81 in qmp_for_each_command (cmds=3Dcmds@entry=3D0x55=
555562c2b0 &lt;ga_commands&gt;, fn=3Dfn@entry=3D0x55555557db30 &lt;ga_apply=
_command_filters_iter&gt;, opaque=3Dopaque@entry=3D0x555555633710)<br>=C2=
=A0 =C2=A0 at ../qapi/qmp-registry.c:93<br>#3 =C2=A00x0000555555571436 in g=
a_apply_command_filters (state=3D0x555555633710) at ../qga/main.c:492<br>#4=
 =C2=A0initialize_agent (config=3D0x555555632760, socket_activation=3D0) at=
 ../qga/main.c:1452<br>#5 =C2=A0main (argc=3D&lt;optimized out&gt;, argv=3D=
&lt;optimized out&gt;) at ../qga/main.c:1646<br>(gdb) p state.config<br>$1 =
=3D (GAConfig *) 0x0</div><div><br></div><div><div>(meson test fails too)</=
div><div><br></div>I wonder why s-&gt;config is set so late in initialize_a=
gent(). Moving it earlier seems to solve the issue, but reviewing all code =
paths is tedious..<br></div></div></div></blockquote><div><br></div><div>Ac=
tually, there seems to be few -&gt;config users, and they don&#39;t check i=
f it&#39;s NULL. So I guess it&#39;s ok to move it earlier. <br></div></div=
><br><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" =
class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000005fd063061a22303e--

