Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F79C61CE7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uND1W-0007FM-GP; Thu, 05 Jun 2025 12:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uND16-00074X-UQ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uND15-0000nW-2Z
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749139226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2arhQkSqQ5QDu2ry/bbqpb4fS7bGF/7rT2F4p3Z2sBs=;
 b=Roay3l1NmgkhOR1absN1Ctt2iOGrkiyrEyvlcVAlFRRTCG7CvDvKYT012CLxqJ07GnEiWS
 ukeVvSlFWRJjSN6Ck5cvbMe3uIhCxCWf3zVeFHnbnJqsgY0Jx026IlbdkfCUOpIIkAu+Y/
 BqJGGWqde4xxRwjvRpR1vaDNntvTtPA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-dZGQJTJdPcGf7VFpIxx73w-1; Thu, 05 Jun 2025 12:00:24 -0400
X-MC-Unique: dZGQJTJdPcGf7VFpIxx73w-1
X-Mimecast-MFC-AGG-ID: dZGQJTJdPcGf7VFpIxx73w_1749139224
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b26e73d375aso1156420a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749139224; x=1749744024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2arhQkSqQ5QDu2ry/bbqpb4fS7bGF/7rT2F4p3Z2sBs=;
 b=LyMagOtZZX6jZUeldtAlNPmfDNxnAEVwu7zA3DWglm2pviFWghRw1AtoZjrHCKjsPz
 yKl3NZphbJvVvK7LWMYYKFklOdxTS1md3jvWF+etjr+4VTQxMdFkzuZeurbY0LS+RZrx
 Z4yovAqa1ShfHGOA9KHSHg+O1UqK6GlV9SDb3GnGrWppQCVOTiEKvxekBW8J73Kdqu1m
 uCzrMcEAkhPOu5G1ddif1nCJm1XVF0pced1bP5MoRPbmQZPZ5BWhwn1vqFc7GJlT9WME
 j2i+ibj315NCBprwl9JZNNR+bIr3Y8kXdKsixN3/izP6Lns6b99lEnGmNgmMmkvNqVdg
 fwOw==
X-Gm-Message-State: AOJu0YwX5yfjnYsD9P+H17QelbPCIg2tENWMMVnD1ClTa2V2UITnxDRe
 GGTkNiyEFrQWH2NYSnjnYKYtRz8W8kNMp73kiedqGHbbQAms8H3siEcJ0x5CgSGoPqLFz7F61oG
 QElsbl+aDGi5lbXhzjH0CCq9IvlzNMXS4jadhL/ADnfJmEWAU7be2Hqpjk8aeuDWpIph9WKzKHk
 CGtqbl3FYwh5yTidAYPodzoduZJ5fRrjw=
X-Gm-Gg: ASbGncvXs+QitawW8FK48oFgh2lj99I0xhar4hjTdF3Jom+4dI2ZkJhYlPN6A50DvSa
 tziKXfgvrZQANYJS3gP5lHNMBbl/sl1kYTItkzhe3wdYtpEKlFpS3mXS4zhSNRUz/QW0q4yj9al
 C3etMUaRsp2u5Vk4JhwkueeyDU
X-Received: by 2002:a17:90a:dfcd:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-31347699392mr325166a91.33.1749139223691; 
 Thu, 05 Jun 2025 09:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAj5t5IjjCQ+2OmSq5qjFfTSQrEdxb5URaYKmEctfMeVeFQql6fG7lDFIcRUZXredr3YYrmLavy7MeYzuFxRQ=
X-Received: by 2002:a17:90a:dfcd:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-31347699392mr325064a91.33.1749139222874; Thu, 05 Jun 2025
 09:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250604200354.459501-1-jsnow@redhat.com>
 <87bjr2n1as.fsf@pond.sub.org>
In-Reply-To: <87bjr2n1as.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 5 Jun 2025 12:00:10 -0400
X-Gm-Features: AX0GCFtiv1q3mXRIOlXY6VAOEG96dtIWR0gAtQD97EWv1oyvJNiBlVHu3562BGI
Message-ID: <CAFn=p-Yxm1-yGCdNzEfmuUsTL2tzyb_eppxsQTpgkft+T_x6jw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] python: add QAPI and qapidoc et al to python tests
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000af6380636d5367b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000000af6380636d5367b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 2:35=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Hiya, this series turns on automated linting for scripts/qapi,
> > docs/sphinx/qapidoc.py and docs/sphinx/qapi_domain.py.
> >
> > This includes flake8/isort/pylint/mypy for scripts/qapi, but omits mypy
> > from the Sphinx plugins owing to my inability to strictly type the
> > extensions given the wide versions of Sphinx we actually support.
> >
> > [Maybe this will change soon, but it's not true just yet.]
> >
> > Though I have been using black in my own development, I have not yet
> > enabled it anywhere automatically. Maybe soon.
>
> You lost my series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> :)


Didn't expect to need to manually copy it forward to a v5 ...!

Thanks,
--js

--0000000000000af6380636d5367b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 5, =
2025 at 2:35=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Hiya, this series turns on automated linting for scripts/qapi,<br>
&gt; docs/sphinx/qapidoc.py and docs/sphinx/qapi_domain.py.<br>
&gt;<br>
&gt; This includes flake8/isort/pylint/mypy for scripts/qapi, but omits myp=
y<br>
&gt; from the Sphinx plugins owing to my inability to strictly type the<br>
&gt; extensions given the wide versions of Sphinx we actually support.<br>
&gt;<br>
&gt; [Maybe this will change soon, but it&#39;s not true just yet.]<br>
&gt;<br>
&gt; Though I have been using black in my own development, I have not yet<b=
r>
&gt; enabled it anywhere automatically. Maybe soon.<br>
<br>
You lost my series<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank">armbru@redhat.com</a>&gt;<br>
<br>
:)</blockquote><div><br></div><div>Didn&#39;t expect to need to manually co=
py it forward to a v5 ...!</div><div><br></div><div>Thanks,</div><div>--js =
<br></div></div></div>

--0000000000000af6380636d5367b--


