Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB641C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHO1H-00063S-4H; Wed, 12 Jun 2024 09:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sHO1F-000633-Sk
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sHO1E-0005HS-3h
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GFr3fZmqM7guIIyHjGunMfMnnDi4exUIFHXwNN3VOCo=;
 b=VkrFWkr7ffAKmvRG9WXW9ogG9BXKrrEeYzoGdYS5jrXHXSiZN4Bnn0UFuAUyFyfTAqFNPu
 cP6pfj+2Xcro5dhM4LJveTG+dh9PStS3HuiAVtFsxJSYN1KwWrzarW5qjTrrhHL7bpnWm7
 Sy6FEbFXac82IJerwNnuAA/hlnn4rYk=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-8lk1QQaKOgSxJRY1gH_4MQ-1; Wed, 12 Jun 2024 09:28:01 -0400
X-MC-Unique: 8lk1QQaKOgSxJRY1gH_4MQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-254dfc90aadso2322316fac.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718198881; x=1718803681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFr3fZmqM7guIIyHjGunMfMnnDi4exUIFHXwNN3VOCo=;
 b=V5+MRGWz7u6G5dXK8ppvbAnD3z02WPD2UQbfvt+3pmDBTLOXheofOMQA1UlsAPqL1j
 C40VjVnwxeX6wCms0uyBxPJvkvWFl3uFe0DYjEvjiBLMMRMlrngUuT2dPrlsEGIhJanp
 /Iji64IItJBtKdeQbwbNTVuZroDfvlRhGNEXQu8xsf+lOTfltFoe3x+v7AIRX7ly95Rj
 X0JA/Z9LVY9mWfZgsRJH5D4mfe1WpXw0VANKIX5Cr9fJL/vhgiMgeQHNB9Hq0i5JVgiI
 qnc4yVLOvE0lhbRQda5HoKmOL4CHcrRhIx7jUJuOX0yd/8/DzN2UaUE7M5l35VVWwQqZ
 BSeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyzD2etJ0NrfxFzPlzyRvc3lFOLLGIfC8u8eqE6zHhE0paDBCSZT1Q1ZpNLBya9d62aeFovnJbrHl0Pe4O3UURbW8hNNU=
X-Gm-Message-State: AOJu0YzrAqCFPq2N6QWRItQzdYC+Mm5HHKiF6koH5SrTkeCKr0ce7xuI
 FTcFVpTuTC6GhuYWLE+NWzq5QiJmjaumsSbHm+972RAXsW+DD1wZTJL1j5PGGti+dEnRINCicsX
 tEPFdOx56fLdLRT680OVj9PSLU52/5H/amzL+fZnkisE8vVbd5SrFSzR6EoM5THPHbGcfVoAgP+
 1LsL1rw1+PhvTsdnz67WpHBjUzENI=
X-Received: by 2002:a05:6870:b151:b0:24c:a395:1957 with SMTP id
 586e51a60fabf-25514cdf739mr2372846fac.26.1718198880956; 
 Wed, 12 Jun 2024 06:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQxJmBL3D57Ppw2OuLinmOPonGXzuV+mrhp7pPqShYRHY0ihK1dSzYGxiB+Yrgto8WbtqnRMHDXGTCyagm6bg=
X-Received: by 2002:a05:6870:b151:b0:24c:a395:1957 with SMTP id
 586e51a60fabf-25514cdf739mr2372821fac.26.1718198880618; Wed, 12 Jun 2024
 06:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-22-philmd@linaro.org>
 <87mswx5n63.fsf@pond.sub.org>
 <18739a67-84bb-4fd3-adb6-0db0f0eb7af1@linaro.org>
 <87plsmfgxq.fsf@pond.sub.org>
In-Reply-To: <87plsmfgxq.fsf@pond.sub.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 12 Jun 2024 16:27:49 +0300
Message-ID: <CAPMcbCqPya2bV1y=WG=DXMCtc_b1N3AybrMbYM=Uoqbqkfvewg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 21/22] qapi: Inline and remove QERR_UNSUPPORTED
 definition
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000eeeb83061ab15977"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000eeeb83061ab15977
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus and Philippe,

I agree to remove QERR_UNSUPPORTED and have more specific errors
or even remove the functions from the schema in some cases instead of
copy-paste QERR_UNSUPPORTED from platform to platform.

Best Regards,
Konstantin Kostiuk.


On Wed, Jun 12, 2024 at 4:07=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
> > Michael, Konstantin, QERR_UNSUPPORTED is only used by QGA.
> >
> > Do you mind giving our maintainer's position on Markus
> > analysis so we can know how to proceed with this definition?
>
> Daniel Berrang=C3=A9 recently posted patches that get rid of most instanc=
es
> of QERR_UNSUPPORTED:
>
>     [PATCH 00/20] qga: clean up command source locations and conditionals
>
> https://lore.kernel.org/qemu-devel/20240604134933.220112-1-berrange@redha=
t.com/
>
> I pointed out a possible opportunity to remove even more.
>
> I think we should let the dust settle there, then figure out how to
> eliminate remaining QERR_UNSUPPORTED, if any.
>
>

--000000000000eeeb83061ab15977
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Markus and Philippe,</div><div><br></div><div>I ag=
ree to remove QERR_UNSUPPORTED and have more specific errors</div><div>or e=
ven remove the functions from the schema in some cases instead of</div><div=
>copy-paste QERR_UNSUPPORTED from platform to platform.<br></div><div><br><=
/div><div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D=
"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Konstantin =
Kostiuk.</div></div></div></div><br></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 12, 2024 at 4:07=E2=
=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@=
redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.=
org" target=3D"_blank">philmd@linaro.org</a>&gt; writes:<br>
<br>
&gt; Michael, Konstantin, QERR_UNSUPPORTED is only used by QGA.<br>
&gt;<br>
&gt; Do you mind giving our maintainer&#39;s position on Markus<br>
&gt; analysis so we can know how to proceed with this definition?<br>
<br>
Daniel Berrang=C3=A9 recently posted patches that get rid of most instances=
<br>
of QERR_UNSUPPORTED:<br>
<br>
=C2=A0 =C2=A0 [PATCH 00/20] qga: clean up command source locations and cond=
itionals<br>
=C2=A0 =C2=A0 <a href=3D"https://lore.kernel.org/qemu-devel/20240604134933.=
220112-1-berrange@redhat.com/" rel=3D"noreferrer" target=3D"_blank">https:/=
/lore.kernel.org/qemu-devel/20240604134933.220112-1-berrange@redhat.com/</a=
><br>
<br>
I pointed out a possible opportunity to remove even more.<br>
<br>
I think we should let the dust settle there, then figure out how to<br>
eliminate remaining QERR_UNSUPPORTED, if any.<br>
<br>
</blockquote></div>

--000000000000eeeb83061ab15977--


