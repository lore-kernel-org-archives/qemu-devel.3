Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42841C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 20:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpa4I-0008Hn-8v; Wed, 27 Mar 2024 16:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpa4G-0008Gz-8z
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 16:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpa4E-0004Lk-Rg
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 16:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711572013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krUHF2DrfUxOrhuT3iJBmQP1zr5vBXVBIFziYMSw8/Y=;
 b=fZ2rWhI1Xbo0WooXwYnkPM+7trKyVKodJX/vIw99wWRFwjt9F5cv6w9LANEQw0eqvrfuZD
 YhSCGH/t4RFWCDsw5uwcuOtu2NZ9XmhAQrqwPZzRjPOhQhsIkJHlFEb4TL9mrUHJb81X8d
 XHkQMiImi4yTrxW8trCXBMGXWhsBolw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-mzqv2e5ePS6zxdyHG6oahA-1; Wed, 27 Mar 2024 16:40:10 -0400
X-MC-Unique: mzqv2e5ePS6zxdyHG6oahA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33e7ef510aaso105519f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 13:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711572009; x=1712176809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krUHF2DrfUxOrhuT3iJBmQP1zr5vBXVBIFziYMSw8/Y=;
 b=MR1gGe2h4zW4e/NIK/uy6apTJ9uhI/7IBRAs9eXmPqehg7JbMcelGrr0HMgj5U0Fh1
 QyhfRmNzvqXnQnIkJ4RKtFbtxhfnwcirWtGPTvHtckelet23ZHGOuIcHbCoVNIGb26tW
 FKIjnos/r/U1CEygeOhHgivFHZAR+FeFhefciwg7K78TJmGocb94BLKXJhUpT+owUgdJ
 OVAIc3CM+tv3+cW6U1S/gM7bgbSHpGaozZW8Pbzi8Zspk/KKMXFAEyVYi1n9vhuGC7j2
 TmTknPaEJ8PydbvvyBUgoAA6H3i2eYI7ULUmmhPH+sWgXZtgBMHV155tCDqp9SKnx1zS
 GNCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUErCk9P52yHrVpGfGx2oJ+xrntgKUuHJ0+FWanfzILNbGZBPkarNRiZHhe28MXS+2+LACB/XXhbUKwMkqtvwW4gjDLbaA=
X-Gm-Message-State: AOJu0Ywh6McRDjtU/Dgf6AGj+J/xRyShNEhRy98LsWq7537a0FAlLt8W
 IJiC3pYJJTMfOzmjcNi47msUd9S0bcBRiGX50kGfzV9TZMV6iJT6PjGxqv3RvxZpRy1C2dlXT/f
 tkFOV8uHFj7qwRsS4M8W/l9zZz9AkPSeJLeVBUVxOMCshHk1JMYJWbW/hG64cPk0yKl5NfzLT0j
 ezo//2V7pgKZ14mVQDGQpvF5nYwIk=
X-Received: by 2002:adf:cd06:0:b0:33e:773c:ff6 with SMTP id
 w6-20020adfcd06000000b0033e773c0ff6mr989969wrm.46.1711572009492; 
 Wed, 27 Mar 2024 13:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXkarStpofujde81FvxJvvHh+jyq9+yHq+cqPK/Qo/S8PI4PIuDajYeke/tgx2pVp6Za9uL9zqDxkHwnEpRGE=
X-Received: by 2002:adf:cd06:0:b0:33e:773c:ff6 with SMTP id
 w6-20020adfcd06000000b0033e773c0ff6mr989948wrm.46.1711572009139; Wed, 27 Mar
 2024 13:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240326125104.90103-1-imammedo@redhat.com>
 <a4a0bb13-d6a0-4665-810d-ecd9a9fb89b1@redhat.com>
 <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
 <20240326171632.3cc7533d@imammedo.users.ipa.redhat.com>
 <ZgP5x3ECYGevla1-@redhat.com>
 <20240327140917.69d86539@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240327140917.69d86539@imammedo.users.ipa.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Mar 2024 21:39:57 +0100
Message-ID: <CABgObfbozdB=8ARjvGdkJ3yhMuHmZC6Ro47BYZA4YE2rFzyhRA@mail.gmail.com>
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Bernhard Beschow <shentey@gmail.com>, devel@lists.libvirt.org, 
 Richard Henderson <richard.henderson@linaro.org>, "S. Tsirkin,
 Michael" <mst@redhat.com>, qemu-trivial <qemu-trivial@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000009ce0220614aa69d5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000009ce0220614aa69d5
Content-Type: text/plain; charset="UTF-8"

Il mer 27 mar 2024, 14:09 Igor Mammedov <imammedo@redhat.com> ha scritto:

> It's question of whether we are willing to do unthinkable,
> i.e. to break QEMU <-> guest ABI for isapc case by removing
> corresponding fwcfg entries.
>

It's not unthinkable since it's unversioned.

we are loosing a chance to cleanup
> QEMU code base touching following
>
>     m->option_rom_has_mr = true;
>     m->rom_file_has_mr = false;
>     pcmc->pci_enabled = false;
>     pcmc->has_acpi_build = false;
>     pcmc->smbios_defaults = false;
>     pcmc->gigabyte_align = false;
> pcmc->smbios_legacy_mode = true;                  pcmc->has_reserved_memory
> = false;
>

Some of these can go away, for the others probably we can think of making
isapc a direct subclass of X86MachineState.

I would rather keep it because it's the only way to test userspace
interrupt injection in KVM.

Paolo

they are all marginal but in shared code, and removing them
> makes code a bit more easier to follow (especially when it
> comes to memory layout).
>
> > With regards,
> > Daniel
>
>

--0000000000009ce0220614aa69d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 27 mar 2024, 14:09 Igor Mammedov &lt;<a href=3D=
"mailto:imammedo@redhat.com">imammedo@redhat.com</a>&gt; ha scritto:</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
It&#39;s question of whether we are willing to do unthinkable,<br>
i.e. to break QEMU &lt;-&gt; guest ABI for isapc case by removing<br>
corresponding fwcfg entries.<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">It&#39;s not unthinkable since it&#39;s unversi=
oned.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">we are loosing a chance to cleanup<=
br>
QEMU code base touching following <br>
<br>
=C2=A0 =C2=A0 m-&gt;option_rom_has_mr =3D true;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br>
=C2=A0 =C2=A0 m-&gt;rom_file_has_mr =3D false;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
=C2=A0 =C2=A0 pcmc-&gt;pci_enabled =3D false;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
<br>
=C2=A0 =C2=A0 pcmc-&gt;has_acpi_build =3D false;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br>
=C2=A0 =C2=A0 pcmc-&gt;smbios_defaults =3D false;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br>
=C2=A0 =C2=A0 pcmc-&gt;gigabyte_align =3D false;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcmc=
-&gt;smbios_legacy_mode =3D true;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0 =C2=A0pcmc-&gt;has_reserved_memory =3D false;<br></bloc=
kquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Some of th=
ese can go away, for the others probably we can think of making isapc a dir=
ect subclass of X86MachineState.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I would rather keep it because it&#39;s the only way to test user=
space interrupt injection in KVM.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">they are all marginal but=
 in shared code, and removing them<br>
makes code a bit more easier to follow (especially when it<br>
comes to memory layout).<br>
<br>
&gt; With regards,<br>
&gt; Daniel<br>
<br>
</blockquote></div></div></div>

--0000000000009ce0220614aa69d5--


