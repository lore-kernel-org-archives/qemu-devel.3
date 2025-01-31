Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B864DC02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyGN-00022d-Ke; Fri, 31 Jan 2025 16:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <onebigemail@gmail.com>)
 id 1tdyGM-00021F-1N
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:09:18 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <onebigemail@gmail.com>)
 id 1tdyGJ-000857-Ur
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:09:17 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab6d4810332so38806466b.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738357754; x=1738962554; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GHriA1JVBTyLxUQMJn1prS2++unY+un0wHZdtSZ3+Oo=;
 b=Bspn3K5NtonwYNWK4jP1Q7Eai5hvNSCTTEMIjaq4bvLrjlP2E/pmHVRjPkjXDVzVif
 SQoVnlLjL0Zh4aMdCikQTGAmaSlG2bSsoKi9XBAz5Qr8x+XeKUKUFIhocaIfg1NjgxK8
 FHHoT0aIrSX0LqJoOsS6ZUW25hXSdVBmIQLVOBRbfMsA36r+EL9dXvllNsJ0NWJiidDL
 SFttKwSwx6vZhzyu94shwaKAbcJpJ99ySYILqHtQDfDe9QVToVM8slDmv1FKb0mb/6gh
 Nee7gikPT8A0dDwsGcmBkfQmlgrgBNukC34mnCXFIPdzNd4qqSl/vKo7MBDB5qGEjfwh
 +TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357754; x=1738962554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GHriA1JVBTyLxUQMJn1prS2++unY+un0wHZdtSZ3+Oo=;
 b=jTEiRDlcEiSQKcWUmTc06qDQW7moyW49kU6EugvnbbdvSWLTDYyRTBfPsPuTCz4aIZ
 hTu8jxMe/4cV+MQPcSHKNZpslUlWj3TEb72bOibVyXyCvJl0QPqOjXbGzzRWcviLiEXf
 sZrt/vZSJHjMjAUIsdeT0N1aqZiyOuQ5c8hik5LtQWhWEzBFKyy7Cc6zFbnWVDlJ+w/9
 YkOEaCG2jkhzVE7nvI1wZwKejzDnwveYbyF78VNTF07pkCx2IuyqYMJ9ZmoHKoRyqg9i
 YnptLiYS1yPmNG7FmgeqirHijKOxrCPBYQNeADVmlmFRFFp3ziSRrXWA+5L55/5jKhYA
 Iu4Q==
X-Gm-Message-State: AOJu0YxPAJca6kPrUSAz7Xf9juI87fJ3g6MtrgGFSyYri+abq8HEGzi1
 WMhLqTWq7+WHR5UpzchKvolIuEJsn9ILesHoMzs2iJAkl0aD/PSOkmH8ymUbPaMtOUONfr1zoqH
 /yYoIA9Nq67dNGIEC5lWDCV28myQ=
X-Gm-Gg: ASbGncsoc7gOsdsN62bSBE1ClD48kHFdPwyvzbq0VICJWBgMgBIDBSEcsc9UjrIbBYX
 jeZWUuZDPd26UOOO8AeKH8+Byf8uh+bmIkZDTOjopjUwIv+3yw5n059P3iUaKetgS+9JjSgDxnw
 ==
X-Google-Smtp-Source: AGHT+IFXqQ935AgJ1WYwbLG009gK3eGSo+lr2VDBkFsoPKtmpBME4Tln+LIAmsoJx1yCZmwgI6Zz3EP8pimbKhwQBiA=
X-Received: by 2002:a17:907:60d2:b0:ab6:eec4:c9c2 with SMTP id
 a640c23a62f3a-ab6eec4d883mr279690866b.7.1738357753445; Fri, 31 Jan 2025
 13:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20250131175716.3218600-1-lacraig3@gmail.com>
 <1f2ceb5a-e40f-42c3-beb2-e3839e0229fd@linaro.org>
In-Reply-To: <1f2ceb5a-e40f-42c3-beb2-e3839e0229fd@linaro.org>
From: Luke Craig <lacraig3@gmail.com>
Date: Fri, 31 Jan 2025 16:09:03 -0500
X-Gm-Features: AWEUYZmrdOkIDDQwr1kxeeIwKucaLKMY-hUHAAJjorCHNCMEQ9xvWkdpVQ6uqv4
Message-ID: <CAHEB4Fi7KRpEwyQ3sw2z4sdS+opjtofb+AKpo9_CEEMiFtmsMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] plugins: add tb convenience functions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000063127f062d06f422"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=onebigemail@gmail.com; helo=mail-ej1-x629.google.com
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

--00000000000063127f062d06f422
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pierrick,

Thank you for your reply.

I have submitted a new patch series with commits signed off.

Thanks!
-Luke

On Fri, Jan 31, 2025, 2:53=E2=80=AFPM Pierrick Bouvier <pierrick.bouvier@li=
naro.org>
wrote:

> Hi Luke,
>
> On 1/31/25 09:57, Luke Craig wrote:
> > This PR extends the plugin API with two functions which allow convenien=
t
> access around tbs.
> >
> > The first, qemu_plugin_tb_size, provides a mechanism for determining th=
e
> total size of a translation block.
> >
> > The second, qemu_plugin_tb_get_insn_by_vaddr, allows users to get a
> reference to an instruction by its virtual address rather than just its
> index.
> >
> > In response to feedback from Pierrick I have updated the implementation
> of qemu_plugin_tb_size.
> >
> > Additionally, I have added these functions to the insn.c test plugin in
> response to Alex's feedback.
> >
> > Lastly, I'll provide a reply to Alex's feeback (repeated below):
> >
> >> But the general comment is this is an example of tying the plugin API
> >> too deeply with the internals of the translator. Why does a plugin nee=
d
> >> to know what is an implementation detail?
> >
> > Finding the line between implementation detail and relevant to plugins
> is challenging, but I submitted this change because I found myself
> implementing these functions in plugins. If you'd like for me to enumerat=
e
> examples where knowing the tb_size is relevant to analysis I'd be happy t=
o
> submit some.
> >
> > Luke Craig (3):
> >    plugin: extend API with qemu_plugin_tb_get_insn_by_vaddr
> >    plugin: extend API with qemu_plugin_tb_size
> >    plugins: extend insn test for new convenience functions
> >
>
> For all the series,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>
> >   include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
> >   plugins/api.c              | 20 ++++++++++++++++++++
> >   tests/tcg/plugins/insn.c   | 10 ++++++++++
> >   3 files changed, 51 insertions(+)
> >
>
> To accept this series, commits should be signed off [1].
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emai=
ls-must-include-a-signed-off-by-line
>
> Thanks,
> Pierrick
>

--00000000000063127f062d06f422
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Pierrick,</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Thank you for your reply.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">I have submitted a new patch series with commits signed off.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks!</div><div dir=3D=
"auto">-Luke<br><br><div class=3D"gmail_quote gmail_quote_container" dir=3D=
"auto"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 31, 2025, 2:53=E2=
=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org=
">pierrick.bouvier@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">Hi Luke,<br>
<br>
On 1/31/25 09:57, Luke Craig wrote:<br>
&gt; This PR extends the plugin API with two functions which allow convenie=
nt access around tbs.<br>
&gt; <br>
&gt; The first, qemu_plugin_tb_size, provides a mechanism for determining t=
he total size of a translation block.<br>
&gt; <br>
&gt; The second, qemu_plugin_tb_get_insn_by_vaddr, allows users to get a re=
ference to an instruction by its virtual address rather than just its index=
.<br>
&gt; <br>
&gt; In response to feedback from Pierrick I have updated the implementatio=
n of qemu_plugin_tb_size.<br>
&gt; <br>
&gt; Additionally, I have added these functions to the insn.c test plugin i=
n response to Alex&#39;s feedback.<br>
&gt; <br>
&gt; Lastly, I&#39;ll provide a reply to Alex&#39;s feeback (repeated below=
):<br>
&gt; <br>
&gt;&gt; But the general comment is this is an example of tying the plugin =
API<br>
&gt;&gt; too deeply with the internals of the translator. Why does a plugin=
 need<br>
&gt;&gt; to know what is an implementation detail?<br>
&gt; <br>
&gt; Finding the line between implementation detail and relevant to plugins=
 is challenging, but I submitted this change because I found myself impleme=
nting these functions in plugins. If you&#39;d like for me to enumerate exa=
mples where knowing the tb_size is relevant to analysis I&#39;d be happy to=
 submit some.<br>
&gt; <br>
&gt; Luke Craig (3):<br>
&gt;=C2=A0 =C2=A0 plugin: extend API with qemu_plugin_tb_get_insn_by_vaddr<=
br>
&gt;=C2=A0 =C2=A0 plugin: extend API with qemu_plugin_tb_size<br>
&gt;=C2=A0 =C2=A0 plugins: extend insn test for new convenience functions<b=
r>
&gt; <br>
<br>
For all the series,<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro=
.org" target=3D"_blank" rel=3D"noreferrer">pierrick.bouvier@linaro.org</a>&=
gt;<br>
<br>
&gt;=C2=A0 =C2=A0include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0plugins/api.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 20 ++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0tests/tcg/plugins/insn.c=C2=A0 =C2=A0| 10 ++++++++++<br>
&gt;=C2=A0 =C2=A03 files changed, 51 insertions(+)<br>
&gt; <br>
<br>
To accept this series, commits should be signed off [1].<br>
<a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch.html#p=
atch-emails-must-include-a-signed-off-by-line" rel=3D"noreferrer noreferrer=
" target=3D"_blank">https://www.qemu.org/docs/master/devel/submitting-a-pat=
ch.html#patch-emails-must-include-a-signed-off-by-line</a><br>
<br>
Thanks,<br>
Pierrick<br>
</blockquote></div></div></div>

--00000000000063127f062d06f422--

