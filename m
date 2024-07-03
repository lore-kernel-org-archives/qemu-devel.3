Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE41AC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 15:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP1rR-0004w2-IC; Wed, 03 Jul 2024 11:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP1rD-0004lb-B3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 11:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP1rB-0003CO-4X
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 11:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720020313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gXJt/9duMwKa8n1FZRFyvBGSbksQ+zx71udi9mXfc6E=;
 b=QR/ef5tjRwbXQa4XvvCSIjg+uongmGoVo5oQcooUaartuPmfl69s1PugYz2VVuV49Git22
 6jsCpaitOe/1j1O8jixrOhy7H4mJuxYAC7YsZQYqfSf1pV9ghBxvovwT8IolQmxzIpfRsu
 ZCC+KHdD5RUT+Nx8pdwpe0R4bpvJ1/I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-4CdaZPN5OHCUChLVBCowfw-1; Wed, 03 Jul 2024 11:25:11 -0400
X-MC-Unique: 4CdaZPN5OHCUChLVBCowfw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c1a9e8d3b0so4823689a91.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 08:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720020310; x=1720625110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gXJt/9duMwKa8n1FZRFyvBGSbksQ+zx71udi9mXfc6E=;
 b=HVLEek+TcLaqbeZYD2wIMtDNX/5PbWENh7j045QlH45qSsfP3AghnAv4cpKSFfQuwr
 5pX612Y9/PXh1ASTJ4e3DJSUYeJqTzoBQe7rN0Tw24yLFu9G3dh0hWkFmH4Gd5qn5NRZ
 UhFDhxT0W7UjXoR0hfIIs+gpX0Ymj7FkJ6WocMSwbi5Wv4IwvvNAzNoLR8hzkx+JVCMA
 JVu1FmmGFy1kZuejSUbWTDHXUXORg8NME6QQveRLk4USz9LjPMCnNcP4A1Wd0z21m9gu
 kEogeNEVQwC+3TsULKwCvMEhEcoLkCZuFV7Rgg5VQPoiX5acWYJl444BaCzNb6sPkj76
 vtEg==
X-Gm-Message-State: AOJu0YxdXee5f54JjSbopKdb9ChS7Eq0vnXWBCi2gZOCBg3DcQpGUOqn
 eNPYNNjuUdMGWQHjok7GfKMxi1YWO7Fz6F6Tlhv4jPO/LrZ+IswNSpdVPIjYa3aMD1mdjwpxc+d
 8lfQBY+FjsJbNAb7ug6lbBFQ/gSTp4kXIRz5Qc+WS7R6Sor8UF74ThjDa0rnoFMiQHDBK5k5MbU
 pvRKRyf/e/cb8m4JkccN8iEVq6FiA=
X-Received: by 2002:a17:90a:ca8c:b0:2c3:40b6:293b with SMTP id
 98e67ed59e1d1-2c93d764d88mr9370096a91.39.1720020310329; 
 Wed, 03 Jul 2024 08:25:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+IWu7KSKukaUZ52PQOQziALxW0OPXL6acGxY0aJjVJnL3S4HVEVmaszylWOQL8jW6nY2F3lVM2uJpgMNw+XE=
X-Received: by 2002:a17:90a:ca8c:b0:2c3:40b6:293b with SMTP id
 98e67ed59e1d1-2c93d764d88mr9370080a91.39.1720020310005; Wed, 03 Jul 2024
 08:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240702195903.204007-1-jsnow@redhat.com>
 <20240702195903.204007-2-jsnow@redhat.com>
 <e0302039-dade-43a7-8bdb-a96d1df76f38@redhat.com>
 <CAFn=p-Yqi5umFBPtUYj2EFiRRA2E6VTgDi=TbuwoOSTs+s9OoA@mail.gmail.com>
 <CABgObfZik_bKuZffohNO1fMss+81kTzaHPEHSPu6H2MCoJVZ=w@mail.gmail.com>
In-Reply-To: <CABgObfZik_bKuZffohNO1fMss+81kTzaHPEHSPu6H2MCoJVZ=w@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 3 Jul 2024 11:24:57 -0400
Message-ID: <CAFn=p-atW1AiW8gX6nUm0DzhG4Qrf8A++vArJQhyUo2bTyPqtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Python: bump minimum sphinx version to 3.4.3
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000095c10d061c596f3d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000095c10d061c596f3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 8:12=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:

> On Wed, Jul 3, 2024 at 2:06=E2=80=AFPM John Snow <jsnow@redhat.com> wrote=
:
> > On Wed, Jul 3, 2024, 4:00=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >> On 7/2/24 21:59, John Snow wrote:
> >> > With RHEL 8 support retired (It's been two years today since RHEL 9
> >> > came out), our very oldest build platform version of Sphinx is now
> >> > 3.4.3; and keeping backwards compatibility for versions as old as v1=
.6
> >> > when using domain extensions is a lot of work we don't need to do.
> >>
> >> Technically that's unrelated: thanks to your venv work, :) builds on
> >> RHEL 8 / CentOS Stream 8 do not pick the platform Sphinx, because it
> >> runs under Python 3.6.  Therefore the version included in RHEL 8 does
> >> not matter for picking the minimum supported Sphinx version.
> >
> > I think I can't mandate 4.x because of RHEL 9 builds though, and offlin=
e
> requirements.
>
> Offline requirements are not a problem; on RHEL 8 you just have to
> install with pip in order to build docs offline. But yes, RHEL 9 is
> still using platform Python and therefore 3.4.3 remains the limit even
> after we stop supporting bullseye.
>

To be clear I mean offline, isolated RPM builds under RHEL9 where I don't
think we can utilize PyPI at all; and vendoring Sphinx is I think not a
practical option due to the number of dependencies and non-pure Python deps=
.

It's not a problem for developer workflow, just downstream packaging.

Luckily OpenSUSE offers newer Sphinx, but RHEL doesn't yet. Maybe that can
be rectified eventually - possibly after 3.8 is EOL and there is increased
demand for newer Python packages to be made available in RHEL... but not
yet, today.


>
> Paolo
>
>
Thanks for the ack O:-)

--00000000000095c10d061c596f3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 3, 2024 at 8:12=E2=80=AFA=
M Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Wed, Jul 3, 2024 at 2:06=E2=80=AFPM John Snow &lt;<a href=3D"mailto:j=
snow@redhat.com" target=3D"_blank">jsnow@redhat.com</a>&gt; wrote:<br>
&gt; On Wed, Jul 3, 2024, 4:00=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mail=
to:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; wrote=
:<br>
&gt;&gt; On 7/2/24 21:59, John Snow wrote:<br>
&gt;&gt; &gt; With RHEL 8 support retired (It&#39;s been two years today si=
nce RHEL 9<br>
&gt;&gt; &gt; came out), our very oldest build platform version of Sphinx i=
s now<br>
&gt;&gt; &gt; 3.4.3; and keeping backwards compatibility for versions as ol=
d as v1.6<br>
&gt;&gt; &gt; when using domain extensions is a lot of work we don&#39;t ne=
ed to do.<br>
&gt;&gt;<br>
&gt;&gt; Technically that&#39;s unrelated: thanks to your venv work, :) bui=
lds on<br>
&gt;&gt; RHEL 8 / CentOS Stream 8 do not pick the platform Sphinx, because =
it<br>
&gt;&gt; runs under Python 3.6.=C2=A0 Therefore the version included in RHE=
L 8 does<br>
&gt;&gt; not matter for picking the minimum supported Sphinx version.<br>
&gt;<br>
&gt; I think I can&#39;t mandate 4.x because of RHEL 9 builds though, and o=
ffline requirements.<br>
<br>
Offline requirements are not a problem; on RHEL 8 you just have to<br>
install with pip in order to build docs offline. But yes, RHEL 9 is<br>
still using platform Python and therefore 3.4.3 remains the limit even<br>
after we stop supporting bullseye.<br></blockquote><div><br></div><div>To b=
e clear I mean offline, isolated RPM builds under RHEL9 where I don&#39;t t=
hink we can utilize PyPI at all; and vendoring Sphinx is I think not a prac=
tical option due to the number of dependencies and non-pure Python deps.</d=
iv><div><br></div><div>It&#39;s not a problem for developer workflow, just =
downstream packaging.</div><div><br></div><div>Luckily OpenSUSE offers newe=
r Sphinx, but RHEL doesn&#39;t yet. Maybe that can be rectified eventually =
- possibly after 3.8 is EOL and there is increased demand for newer Python =
packages to be made available in RHEL... but not yet, today.<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Paolo<br>
<br></blockquote><div><br></div><div>Thanks for the ack O:-) <br></div></di=
v></div>

--00000000000095c10d061c596f3d--


