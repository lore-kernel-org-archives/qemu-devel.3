Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904D7606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nzA+cpPO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnDw-0003pW-7e; Thu, 22 Oct 2026 03:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJnDt-0003iR-1g
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:28:25 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJnDr-0000Qv-1E
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:28:24 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-53a448f86e0so833989b6e.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792654101; cv=none;
 d=google.com; s=arc-20260327;
 b=THFCAwVz+7Liwglj5DvXT+R4cyA1dTiYapIAwFOt85aX1OC/x/JsAHkk2YX69H+UwI
 5xjngfQnDpFtmT5EAozPto3C81DULVW+eCi23HYiWWU5diE1UBqXsUQcL4vLYicTivqL
 0L3UaR2+6BrPPYoHwNZtBBkkWfDPQTGTFBYBb7h8gHnicNFslQovlgDWki75GR78m7M2
 lY1tTMsGFh45A0+Z68+Q5FYhv400DBy4K2VmVZjtTWa3yfSJ28FJqrLw9/TJ93l7r7di
 i+ugz+6RiiL/CHnIDXB2sAzvNrXo2SSKDkkoxFjXl40MscYxxvlzuKtr2qOQMHdzfECr
 OrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1kzjINiXgW6wvbZ532zErTWYum3saLsmuRmwUwpu/FY=;
 fh=LI9aekGwGBHYPRDMpgVmM6TEkl/g4MNgSCqW5BVJNKg=;
 b=oPWs794dDHFCo/K4S1DvzE3rzWKzgiI3RFBHrHhFCsv2qdCcJiTHMVOV1GUBo0ggfE
 ZhlFkBfhXLXUjmYNZZgxIvN9xFU4M4v3T5QlYYSartoCNYsZpLclLylGCYGA7m62X77u
 Mz/XI9K91uvyGDjUjSqGGmwAxbpJsQqukAbt6FIfBfbwVI39BGhuf+jrFIYExYLQLXMk
 T3k0JIoYwZEvQpptpySSIHXk15pgwzhRnrxbucQ5DNVzWk0Rj6wfAEt1ztqrPRObhNbO
 obnyOgdaQaBid7Ex2pbOJSTkltsKO9hNJIamMs59FEeiiGx/qOdG+8wqWaQM9kVkBJIj
 dezg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792654101; x=1793258901; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1kzjINiXgW6wvbZ532zErTWYum3saLsmuRmwUwpu/FY=;
 b=nzA+cpPO187RSmrRJXxVya9bHayFtDfXdHf2GwP3R6sip3hxA+ryXFHUoWTuUwtJMO
 EqId/cHUQO+o0z8abs3LIngqv8AsR5005dtUSyBP+Klbt7dLdY1IEtBwRR1nlF07UptO
 uirQDdPuqPdX4B+Na2kmAr3CFH79PmAfFyc8eDGdKi2LuM9khIaxvznGmn1XuTOat2cj
 Yei04TQxBTLb+7dlY7WTh5ncEBZ/y5uD/pU2KtZJP+31FGf0A4+yGlbjo9YKbO/ope4n
 7ywnOSRiWF/8rtS+E8rTREAWInGxA150EWQ1D7P5WKjuqLSBIBIHVx+54ZVOh/4fQvJu
 mVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792654101; x=1793258901;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1kzjINiXgW6wvbZ532zErTWYum3saLsmuRmwUwpu/FY=;
 b=25g30i3hsasQZTiOch4pjog1yIMKqzctsT7L/6/YBhL8LL6daZhZZ990EfTFh+ZYjq
 U7lrNwdMsR51YaplPxtfzWft39cx74QQyqRxYdL6BSyoZE9IGhAvtncbU8Jyjd5H0iRQ
 Is3kMpdi+qY2X5q6a8FIfbrWricNn6Swl7PsLqbYeQ8avdeQbxl4u2JE13f63DGqJmFS
 rUEPQm3bERUPyEg7tSvGpQUzac4ZDPrrWVA9hyy+eG/GmyqUOzQ5PvgzGEUMSPlwsZoL
 8ttXtkglRSwLrQaUx2CIDWT36akjsZB2nCIUyQesdXr4f5Jo7ENg78OKgOdznRplwylg
 1hPQ==
X-Gm-Message-State: AFq9FYJxLNh6bi0Za6fBYJznE3MP5xcGReDDFc0rN3wR5g1WPFTUaB+f
 jgIr+greGp6nSGyR1igVIc+TAvCD92kMByNWNr6zWvxwkEnuFzxibnrCAAb09n/HL29UEoH+n2Q
 EEDJAq9uWBRpev/35tcupT7SE4TkxNYQ=
X-Gm-Gg: AYBFou2eoFhzDFdnpvbvwyBYQmMP5Z4zR75pw1Qd6aMJzM0W5MfpfnY0DV4tU2eiFv0
 NYt8BHXBkrFC38qHtvXla5ApIS/i/IsCcgdtfnZVLKgXnQD3s406gZ8/Qn3XgKuJqD8tPEIGMbG
 ah2FCKeiR1TgH7BHUwzQ3psBovKhcr5fBXWGf+Qf83Wh5FMuKPLbvci5II/OifH2+4sQGVqWssx
 YKAeE1Kjn+5EyvuRQjMhj4CZ2Rq9qV4BAZz/jBxyabjLrk9FkiHqKSHEVJUr/S2sKVngkMjPg2C
 IG75oBoCqGGdfLqM3BzyUbfxeyS60FlbaZ9oqpdETqlQNKFtf04ePhLauaXx/O42jXoUIFKsE+b
 cK0+veb5vP4urbAWFs5lLxsqSm44yVVdNG2XP
X-Received: by 2002:a05:6808:1917:b0:4d6:2545:b12a with SMTP id
 5614622812f47-5535fbb3d0amr3072019b6e.26.1792654101388; Thu, 22 Oct 2026
 00:28:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021135322.473781-1-waysorrypub@gmail.com>
 <20261021135322.473781-3-waysorrypub@gmail.com>
 <48483527-13dd-bf40-bb90-bef7aacf5bb9@loongson.cn>
In-Reply-To: <48483527-13dd-bf40-bb90-bef7aacf5bb9@loongson.cn>
From: way sorry <waysorrypub@gmail.com>
Date: Thu, 22 Oct 2026 15:28:08 +0800
X-Gm-Features: AclHuK_PHXSOyqYWXMqwRClELHpusZEXaHlfRK9noWNJDeBkv2DrPomOYc2xYn8
Message-ID: <CAECqSzWrN_QYM=6yhGSFtJo9Y3svPN5uVATrQJsww=0j3+et4A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hw/loongarch/virt: Drop UART _DSD/_CCA and add _STA
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, 17746591750@163.com, lixianglai@loongson.cn, 
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com, 
 anisinha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000eb22be065e68cee5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=waysorrypub@gmail.com; helo=mail-oi1-x22b.google.com
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
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000eb22be065e68cee5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, all

Agreed. The reset baud rate is 9600, while 115200 is the baudbase.

I've sent v4 with a separate patch correcting the FDT UART clock
to 1843200 Hz. I've alse carried your Reviewed-by on the ACPI patch.

Thanks,
pillow

On Thu, Oct 22, 2026 at 9:22=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:

>
>
> On 2026/10/21 =E4=B8=8B=E5=8D=889:53, pillow wrote:
> > The UART _DSD contains only a clock property, which has a typo
> > ("clock-frenquency") and the key/value order is reversed. The declared
> > 100 MHz also does not match the current QEMU model.
> >
> > The Linux PNP serial driver uses uartclk =3D 1843200 Hz by default, and
> > the QEMU UART uses baudbase =3D 115200. These correspond as
> > uartclk / 16 =3D baudbase (1843200 / 16 =3D 115200), so the Linux defau=
lt
> baudrate =3D uartclk / 16 / divider, the default divider is 12, so the
> default baudrate is 9600. It can be referenced in function serial_reset()=
:
>      /* Default to 9600 baud, 1 start bit, 8 data bits */
>      s->divider =3D 0x0C;
>
> The clock freq in FDT table should be changed with 1843200 rather than
> 100000000, however it may be another issue.
>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>
> > clock is consistent with the QEMU model. Since the clock property is
> > the only content of the _DSD, remove the entire _DSD rather than
> > keeping an empty one. The QEMU x86 ISA serial ACPI description also
> > does not provide a clock property, which is consistent with this
> > change.
> >
> > Also drop _CCA because the emulated UART does not support DMA, and add
> > _STA =3D 0x0f to indicate the device is present, enable, should be
> > shown and functioning properly.
> >
> > Signed-off-by: pillow <waysorrypub@gmail.com>
> > ---
> >   hw/loongarch/virt-acpi-build.c | 12 +-----------
> >   1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/hw/loongarch/virt-acpi-build.c
> b/hw/loongarch/virt-acpi-build.c
> > index 54965f0..55c7641 100644
> > --- a/hw/loongarch/virt-acpi-build.c
> > +++ b/hw/loongarch/virt-acpi-build.c
> > @@ -314,7 +314,6 @@ static void build_uart_device_aml(Aml *table, int
> index)
> >   {
> >       Aml *dev;
> >       Aml *crs;
> > -    Aml *pkg0, *pkg1, *pkg2;
> >       Aml *scope;
> >       uint32_t uart_irq;
> >       uint64_t base;
> > @@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, int
> index)
> >       dev =3D aml_device("COM%d", index);
> >       aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
> >       aml_append(dev, aml_name_decl("_UID", aml_int(index)));
> > -    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> > +    aml_append(dev, aml_name_decl("_STA", aml_int(0x0f)));
> >       crs =3D aml_resource_template();
> >       aml_append(crs,
> >           aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED=
,
> > @@ -335,15 +334,6 @@ static void build_uart_device_aml(Aml *table, int
> index)
> >       aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL,
> AML_ACTIVE_HIGH,
> >                                     AML_SHARED, &uart_irq, 1));
> >       aml_append(dev, aml_name_decl("_CRS", crs));
> > -    pkg0 =3D aml_package(0x2);
> > -    aml_append(pkg0, aml_int(0x05F5E100));
> > -    aml_append(pkg0, aml_string("clock-frenquency"));
> > -    pkg1 =3D aml_package(0x1);
> > -    aml_append(pkg1, pkg0);
> > -    pkg2 =3D aml_package(0x2);
> > -    aml_append(pkg2,
> aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
> > -    aml_append(pkg2, pkg1);
> > -    aml_append(dev, aml_name_decl("_DSD", pkg2)); >
>  aml_append(scope, dev);
> >       aml_append(table, scope);
> >   }
> >
>
>

--000000000000eb22be065e68cee5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, all<br><br>Agreed. The reset baud rate is 9600, while =
115200 is the baudbase.<div><br></div><div>I&#39;ve sent v4 with a separate=
 patch correcting the FDT UART clock</div><div>to 1843200 Hz. I&#39;ve alse=
 carried your Reviewed-by on the ACPI patch.<br><br>Thanks,<br>pillow</div>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Thu, Oct 22, 2026 at 9:22=E2=80=AFAM Bibo Mao &lt;=
<a href=3D"mailto:maobibo@loongson.cn">maobibo@loongson.cn</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 2026/10/21 =E4=B8=8B=E5=8D=889:53, pillow wrote:<br>
&gt; The UART _DSD contains only a clock property, which has a typo<br>
&gt; (&quot;clock-frenquency&quot;) and the key/value order is reversed. Th=
e declared<br>
&gt; 100 MHz also does not match the current QEMU model.<br>
&gt; <br>
&gt; The Linux PNP serial driver uses uartclk =3D 1843200 Hz by default, an=
d<br>
&gt; the QEMU UART uses baudbase =3D 115200. These correspond as<br>
&gt; uartclk / 16 =3D baudbase (1843200 / 16 =3D 115200), so the Linux defa=
ult<br>
baudrate =3D uartclk / 16 / divider, the default divider is 12, so the <br>
default baudrate is 9600. It can be referenced in function serial_reset():<=
br>
=C2=A0 =C2=A0 =C2=A0/* Default to 9600 baud, 1 start bit, 8 data bits */<br=
>
=C2=A0 =C2=A0 =C2=A0s-&gt;divider =3D 0x0C;<br>
<br>
The clock freq in FDT table should be changed with 1843200 rather than <br>
100000000, however it may be another issue.<br>
<br>
Reviewed-by: Bibo Mao &lt;<a href=3D"mailto:maobibo@loongson.cn" target=3D"=
_blank">maobibo@loongson.cn</a>&gt;<br>
<br>
&gt; clock is consistent with the QEMU model. Since the clock property is<b=
r>
&gt; the only content of the _DSD, remove the entire _DSD rather than<br>
&gt; keeping an empty one. The QEMU x86 ISA serial ACPI description also<br=
>
&gt; does not provide a clock property, which is consistent with this<br>
&gt; change.<br>
&gt; <br>
&gt; Also drop _CCA because the emulated UART does not support DMA, and add=
<br>
&gt; _STA =3D 0x0f to indicate the device is present, enable, should be<br>
&gt; shown and functioning properly.<br>
&gt; <br>
&gt; Signed-off-by: pillow &lt;<a href=3D"mailto:waysorrypub@gmail.com" tar=
get=3D"_blank">waysorrypub@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/loongarch/virt-acpi-build.c | 12 +-----------<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 11 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-b=
uild.c<br>
&gt; index 54965f0..55c7641 100644<br>
&gt; --- a/hw/loongarch/virt-acpi-build.c<br>
&gt; +++ b/hw/loongarch/virt-acpi-build.c<br>
&gt; @@ -314,7 +314,6 @@ static void build_uart_device_aml(Aml *table, int =
index)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Aml *dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Aml *crs;<br>
&gt; -=C2=A0 =C2=A0 Aml *pkg0, *pkg1, *pkg2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Aml *scope;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t uart_irq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t base;<br>
&gt; @@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, int =
index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dev =3D aml_device(&quot;COM%d&quot;, index)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(dev, aml_name_decl(&quot;_HID&quo=
t;, aml_string(&quot;PNP0501&quot;)));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(dev, aml_name_decl(&quot;_UID&quo=
t;, aml_int(index)));<br>
&gt; -=C2=A0 =C2=A0 aml_append(dev, aml_name_decl(&quot;_CCA&quot;, aml_int=
(1)));<br>
&gt; +=C2=A0 =C2=A0 aml_append(dev, aml_name_decl(&quot;_STA&quot;, aml_int=
(0x0f)));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0crs =3D aml_resource_template();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(crs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aml_qword_memory(AML_POS_DECOD=
E, AML_MIN_FIXED, AML_MAX_FIXED,<br>
&gt; @@ -335,15 +334,6 @@ static void build_uart_device_aml(Aml *table, int=
 index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(crs, aml_interrupt(AML_CONSUMER, =
AML_LEVEL, AML_ACTIVE_HIGH,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AML_SHARED, &=
amp;uart_irq, 1));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(dev, aml_name_decl(&quot;_CRS&quo=
t;, crs));<br>
&gt; -=C2=A0 =C2=A0 pkg0 =3D aml_package(0x2);<br>
&gt; -=C2=A0 =C2=A0 aml_append(pkg0, aml_int(0x05F5E100));<br>
&gt; -=C2=A0 =C2=A0 aml_append(pkg0, aml_string(&quot;clock-frenquency&quot=
;));<br>
&gt; -=C2=A0 =C2=A0 pkg1 =3D aml_package(0x1);<br>
&gt; -=C2=A0 =C2=A0 aml_append(pkg1, pkg0);<br>
&gt; -=C2=A0 =C2=A0 pkg2 =3D aml_package(0x2);<br>
&gt; -=C2=A0 =C2=A0 aml_append(pkg2, aml_touuid(&quot;DAFFD814-6EBA-4D8C-8A=
91-BC9BBF4AA301&quot;));<br>
&gt; -=C2=A0 =C2=A0 aml_append(pkg2, pkg1);<br>
&gt; -=C2=A0 =C2=A0 aml_append(dev, aml_name_decl(&quot;_DSD&quot;, pkg2));=
 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(scope, dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(table, scope);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000eb22be065e68cee5--

