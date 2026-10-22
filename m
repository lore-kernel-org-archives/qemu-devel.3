Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204D606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gx6pxVm8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJp2z-0003Nv-Lg; Thu, 22 Oct 2026 05:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJp2y-0003NV-6s
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:25:16 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJp2w-0000lm-6m
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:25:15 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4f699fe49b3so1107449b6e.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 02:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792661113; cv=none;
 d=google.com; s=arc-20260327;
 b=U2afrOC9CS8tXMZndY3/ymeuyIn6tKuNLABH7M0xNv8d0qIOotGp0rnq3YFb2s/0sI
 j27Phj81A/QRnrc8JDSb0zd5yxW+uvxBgnMZCUhFjiTtTUaudO2IJy7wjBqrHvY0fCAS
 awqPXVM27e3ZOnICq5F2QsqHZTxCetYnEi7paSZOQxHT7MWU77AZ9ua/sItl2cvki/g3
 hBtmWcicHjds+SLiifMH9yOIt+KzYhldj0UuDi//DxKi5dunLtmmHgTGABpeqNc2XwCS
 NnauCO1h4+Jx5TETzDupWaNWRkf78Mt+z77j1mZ2ijaTPJtypMO6DxNQjV1Z179sR4fp
 2z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mX66QcQ0dUmzG7zeMxqveq8tGDnmxoO5s36fZCWyHQc=;
 fh=CaWnO18l3T2JEm5Fha20AvFFAY3acH8IOPEOfr9q15k=;
 b=HkEmAe36+l1BADszhRjmGeXR+PA3FPJme7MHmQj3v3gabrv7wzTKF3YvKkq6toolgG
 NZG3GdsbQ9PWpU7uxoKH003yEuGtG8F5z1O8zuKFV2H1+t0fiZbdSD22985jCTY9y0w2
 rQin8UjjCydXbrQe8kBB55wUZQ2ep9gWKHP4Hv8Sh9q94+fli+CotBkiAE1S8h+Z9k9m
 jhDhItqism/ZpHyGRJMgUI5iVluqBPBHTsFQNMSkIcaOgtlzOKZMXXIPUEdytFsFhoNY
 9EtoD7ankGI9sa9MkZUPdO5rElUiGkYRFjsVARcV7hLz9GFtgCYk+GlJMvfikTDQSonT
 2YMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792661113; x=1793265913; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mX66QcQ0dUmzG7zeMxqveq8tGDnmxoO5s36fZCWyHQc=;
 b=Gx6pxVm82v1Vc1sGYVdJYWGYuUHzPkwRqlZ/wfgiGEnDZfawgqjAxH434PqM6xt/ys
 fkba+B2hv7PaejBy0W/JW0DCjCYJAl7aneQ+/X5eBA6/aJASeeCUL3zQHKnXxPC9cpFB
 S5mCIm85dzntKL8+JqM0rai0CKMUWjJS4pL36Pq2YdCMjAF1Z4uU/i905Xo6cOPI+/KG
 HepXe41vo/2SfM4PTaduPLwWWC1PmL/S7SsgwAE4MwJOK0krEt097hBDkQxdX/H45Qxc
 REA/Zy3j1y7EakELeEbRlqLITmQtGGuX48Yol382Km4O1aQXMB0ELx3EzF1XvdrQTZfm
 zNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792661113; x=1793265913;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mX66QcQ0dUmzG7zeMxqveq8tGDnmxoO5s36fZCWyHQc=;
 b=vnxCUXlnXmLY5V0QvM03TAvCAeyJDXWLI6P6rPMfwdltUxv5bvw0q89u4KKBURZbdO
 iupjdEnAIvwNZAcoivvUJtIPGvxSJZyHLeJg3CTG0dPPKFval6DgWcdRkdzxqXQEdoZj
 87AncCu+TpMhe3oh4xLKGNy5R06v55bTTfwwKOQ1E+By+E7eVvHETKPfsWW9MSj546hZ
 rYoqHeiqzMCHFVb3/TndBbqt4ZcxgliP1CBx744s5Pt0oin2bdQYPVJjZ/X9PrvVJgGC
 o+0+4gZNflvz7lcLwvAgiK4ZXek4nSPfSj7tS4lL0G/VKMGIVYbvluKNbQliAh97VmQj
 ZztQ==
X-Gm-Message-State: AFq9FYIZHluibTGFhIVLGLCbOdCqiRU5AnRzCHsvG//SBVsLGxMe/WIq
 EJbOfANnSI3+PfPsSYqqhNCO72PD066etKQeHlpw6LTZq/SwpBRv1s6lrEtvZWCEKsAJUmnUzFW
 3sjne/v7SWvBcUW4wHW5L817mmZb/Rz4=
X-Gm-Gg: AYBFou1SVsH0q/D345vzeHZaAxyVPTtoby+t0gUCwz9p9LfddQz6xSNEu9fZSLL4kdw
 vE8adZBhLgTD0LBxyx/jlUBTJLJ2iAT4LrYNxvZOpXGMaTLxEd5XWWHkGV9drlKicGXjvA2utmz
 HIlIemIXyVIXecTz3BiFzwFcolzWhZ5XnAnsDiFHAXij2t0w/qsGnLLw3Y3zZRvsCdURB1E+8FY
 3UlPa+E+o0mtLDgO3Fbn7ujf6EHtw0qobBQ5SopCiCjfmXH/aAtrwadM0YbPiLVXoyKLIB9hRET
 St4AY+W7/Mb/P7jcpJ6yrqBFXI/GhDFsXeK7mejWcREP3Pag+yPHV0fO7iCqn1y71/mcGQzSnbj
 8BLwAGkpP9r7La/hNfX+vF0vMpXrPtvFgsbqv5g==
X-Received: by 2002:a05:6808:3091:b0:53b:87e5:8c95 with SMTP id
 5614622812f47-5535818cfd6mr3754029b6e.37.1792661112717; Thu, 22 Oct 2026
 02:25:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022072238.319308-1-waysorrypub@gmail.com>
 <20261022072238.319308-3-waysorrypub@gmail.com>
 <20261022101845.381dd1a6@imammedo>
 <CAECqSzXF6a2P9-tz_xRP8+t_RQUYRjgsRhQtMygnRLJJtvHPTg@mail.gmail.com>
In-Reply-To: <CAECqSzXF6a2P9-tz_xRP8+t_RQUYRjgsRhQtMygnRLJJtvHPTg@mail.gmail.com>
From: way sorry <waysorrypub@gmail.com>
Date: Thu, 22 Oct 2026 17:25:00 +0800
X-Gm-Features: AclHuK_OBE03DFZA_cEqvG3CBG3QxVckQW8Q1l-4ydpB7o1ecEw7yzBI9oKnG_c
Message-ID: <CAECqSzWt5gP91iOnoGcKymSYp_O6vt8=7s6-Mg616S_VVREYbg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] hw/loongarch/virt-acpi-build: Drop UART _DSD clock
 and add _STA
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, 17746591750@163.com, maobibo@loongson.cn, 
 lixianglai@loongson.cn, jiaxun.yang@flygoat.com, mst@redhat.com, 
 anisinha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000d386c6065e6a7069"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=waysorrypub@gmail.com; helo=mail-oi1-x234.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000d386c6065e6a7069
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

One additional observation: QEMU's x86 ISA serial implementation explicitly
defines _STA =3D
0x0f in serial_isa_build_aml(), rather than relying on the ACPI default:

https://github.com/qemu/qemu/blob/8967b2fe1b2aaae3c29e207d85fab901d580a2dc/=
hw/char/serial-isa.c#L101

I think following the same approach for LoongArch UART would be reasonable
for consistency.

Thanks,
pillow

On Thu, Oct 22, 2026 at 5:01=E2=80=AFPM way sorry <waysorrypub@gmail.com> w=
rote:

> Hi Igor,
>
> The _STA method was added in response to Bibo's review comment on the
> original patch, where
> he explicitly suggested adding _STA.
>
> I understand your concern that omitting _STA already implies 0x0f.
> However, the two review
> comments seem to suggest different approaches.
>
> I'm happy to split the changes into separate patches as required. For
> _STA, though, I'd
> appreciate it if we could first agree on whether it should be added or
> omitted, so I have a clear
> direction for the next version.
>
> Thanks,
> pillow
>
> On Thu, Oct 22, 2026 at 4:18=E2=80=AFPM Igor Mammedov <imammedo@redhat.co=
m> wrote:
>
>> On Thu, 22 Oct 2026 15:22:36 +0800
>> pillow <waysorrypub@gmail.com> wrote:
>>
>> ...
>> > @@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, int
>> index)
>> ...
>> > +    aml_append(dev, aml_name_decl("_STA", aml_int(0x0f)));
>>
>> also is it really necessary? Doesn't missing _STA imply 0xF already?
>>
>> >      crs =3D aml_resource_template();
>> >      aml_append(crs,
>> >          aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED=
,
>>
>>

--000000000000d386c6065e6a7069
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Igor,<div><br></div><div>One additional observation: QE=
MU&#39;s x86 ISA serial implementation explicitly defines _STA =3D</div><di=
v>0x0f in serial_isa_build_aml(), rather than relying on the ACPI default:<=
/div><div><br></div><div><a href=3D"https://github.com/qemu/qemu/blob/8967b=
2fe1b2aaae3c29e207d85fab901d580a2dc/hw/char/serial-isa.c#L101">https://gith=
ub.com/qemu/qemu/blob/8967b2fe1b2aaae3c29e207d85fab901d580a2dc/hw/char/seri=
al-isa.c#L101</a><br><br>I think following the same approach for LoongArch =
UART would be reasonable for consistency.</div><div><br></div><div>Thanks,<=
/div><div>pillow</div></div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 22, 2026 at 5:01=E2=
=80=AFPM way sorry &lt;<a href=3D"mailto:waysorrypub@gmail.com">waysorrypub=
@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr">Hi Igor,<div><br></div><div>The _STA method was=
 added in response to Bibo&#39;s review comment on the original patch, wher=
e</div><div>he explicitly suggested adding _STA.</div><div><br></div><div>I=
 understand your concern that omitting _STA already implies 0x0f. However, =
the two review</div><div>comments seem to suggest different approaches.</di=
v><div><br></div><div>I&#39;m happy to split the changes into separate patc=
hes as required. For _STA, though, I&#39;d</div><div>appreciate it if we co=
uld first agree on whether it should be added or omitted, so I have a clear=
</div><div>direction for the next version.</div><div><br></div><div>Thanks,=
</div><div>pillow</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">On Thu, Oct 22, 2026 at 4:18=E2=80=AFPM Igor Mammedo=
v &lt;<a href=3D"mailto:imammedo@redhat.com" target=3D"_blank">imammedo@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Thu, 22 Oct 2026 15:22:36 +0800<br>
pillow &lt;<a href=3D"mailto:waysorrypub@gmail.com" target=3D"_blank">wayso=
rrypub@gmail.com</a>&gt; wrote:<br>
<br>
...<br>
&gt; @@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, int =
index)<br>
...<br>
&gt; +=C2=A0 =C2=A0 aml_append(dev, aml_name_decl(&quot;_STA&quot;, aml_int=
(0x0f)));<br>
<br>
also is it really necessary? Doesn&#39;t missing _STA imply 0xF already?<br=
>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 crs =3D aml_resource_template();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 aml_append(crs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_qword_memory(AML_POS_DECODE, AML=
_MIN_FIXED, AML_MAX_FIXED,<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000d386c6065e6a7069--

