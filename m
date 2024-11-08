Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9792D5E15A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 11:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9NBE-0000iR-Ke; Fri, 08 Nov 2024 06:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t9NBD-0000iH-8F
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 06:29:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t9NBB-0002sE-CJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 06:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731065367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BVDH3DfM1mw2XVPTVLMsuSSBuYt3gEqumDFVVDjOpJM=;
 b=f5fe2JoEvrZzY+ZLbFAsb4fR4L8Ib0msxzAHq9VQpjY+PjGvC7BtlFLI8eX0SL7gBQ+ik4
 lf1GaNEa2/cjJeZoF6QCI/PdFdHmlDTVgyEdCCixOg9S6mNY6fljsDZdEFloUOWVM+DlIp
 uYH18bgjRAegkJRX964b8CL6S/bBqho=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-7F1Zc-d0PcavbUkxxeCX8A-1; Fri, 08 Nov 2024 06:29:25 -0500
X-MC-Unique: 7F1Zc-d0PcavbUkxxeCX8A-1
X-Mimecast-MFC-AGG-ID: 7F1Zc-d0PcavbUkxxeCX8A
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d38310949cso29536096d6.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 03:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731065360; x=1731670160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BVDH3DfM1mw2XVPTVLMsuSSBuYt3gEqumDFVVDjOpJM=;
 b=lcPt00VGuYRtXJITFAvpnwoZxnKEpqUysOjJoB5cWYBzYBW+Bk8jQdNNSfqwA2afb9
 eDI4bUyd6jSTQcII1hPqebEe62LIraUaK0TgTZyBdykCxrFSUDcIOZnXaK9mFCRX8f2H
 THTCBBtNlOKouz6VFAYerMr/XHgucoUnG1dNRfAYfhr1fh5oYNhyPwhELtBZ0dK5xNI+
 wAWHVT/l+8xN4FICpGHNXpGevXGx9MC2aC1YbZmtdJ0n9fNaqbnGHAq4XDsOshq6TwCh
 xmcPtECnq8j91Zdo2t01hi65FtnXM0xqKZSe6MI6TedMLIOcYadAHWCQZ3i1fob719Ud
 G7BA==
X-Gm-Message-State: AOJu0YzKDGBNDplbd9tAhiRJjdtlz8kqo9TT8t73KO3ibRIj9hb6ZUB6
 Pz/2AdoIlOOl4HFlx2+jaoB64t/8uOJRj2XnqbP7yCMBN1PDfjjufdmlKy8pPZNS7ONNfGAORfr
 a1AVz9AgIoPQRk1Tw4WVOMKQPcYtotdmVumL/zxQ4IP4+sHClhhYIWfITFOy9t8J0FRv3afsFu3
 MXeyHqcezUdlPjFnFZ1GVdRHHeG2QfYzxuySQ=
X-Received: by 2002:a05:6214:3bc3:b0:6cb:832e:9267 with SMTP id
 6a1803df08f44-6d39e107921mr34601246d6.7.1731065360370; 
 Fri, 08 Nov 2024 03:29:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqA4ue3Sh5e+XtyIirxDkixS5NOJCKCu36J4tJIaCHfQeQzArQpONDIkniNAY05lpdwsTY5w/zzt8COOlxS2w=
X-Received: by 2002:a05:6214:3bc3:b0:6cb:832e:9267 with SMTP id
 6a1803df08f44-6d39e107921mr34601006d6.7.1731065360058; Fri, 08 Nov 2024
 03:29:20 -0800 (PST)
MIME-Version: 1.0
References: <20241107104001.66039-1-kkostiuk@redhat.com>
 <CAFEAcA-Pmf2H06q+mvb8bPA42DCQvBeCXsKcqqGcy-Bxf+3D2A@mail.gmail.com>
In-Reply-To: <CAFEAcA-Pmf2H06q+mvb8bPA42DCQvBeCXsKcqqGcy-Bxf+3D2A@mail.gmail.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 8 Nov 2024 13:29:09 +0200
Message-ID: <CAPMcbCrkFCU59FyA9KOiLaMBLPeOTbgeqd3HPBJED1e59dH04A@mail.gmail.com>
Subject: Re: [PULL 0/3] QGA fixes for guest_network_get_route command for 9.2
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000deab1a0626650ff2"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--000000000000deab1a0626650ff2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Please update me regarding the coverity issues. Is everything fixed or not?

Best Regards,
Konstantin Kostiuk.


On Fri, Nov 8, 2024 at 12:22=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Thu, 7 Nov 2024 at 10:40, Konstantin Kostiuk <kkostiuk@redhat.com>
> wrote:
> >
> > The following changes since commit
> f15f7273ea55472d5904c53566c82369d81214c1:
> >
> >   Merge tag 'pull-target-arm-20241105' of
> https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-05
> 21:27:18 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-11-07
> >
> > for you to fetch changes up to 5ab1c032e6eea810142eb918c57222464482756f=
:
> >
> >   qemu-ga: Avoiding freeing line prematurely (2024-11-07 12:28:20 +0200=
)
> >
> > ----------------------------------------------------------------
> > qga-pull-2024-11-07
> >
>
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
> for any user-visible changes.
>
> -- PMM
>
>

--000000000000deab1a0626650ff2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter,</div><div><br></div><div>Please update me r=
egarding the coverity issues. Is everything fixed or not?</div><div><br cle=
ar=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Kons=
tantin Kostiuk.</div></div></div></div><br></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 8, 2024 at 12:22=E2=
=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">pete=
r.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Thu, 7 Nov 2024 at 10:40, Konstantin Kostiuk &lt;<a =
href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</=
a>&gt; wrote:<br>
&gt;<br>
&gt; The following changes since commit f15f7273ea55472d5904c53566c82369d81=
214c1:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Merge tag &#39;pull-target-arm-20241105&#39; of <a href=3D=
"https://git.linaro.org/people/pmaydell/qemu-arm" rel=3D"noreferrer" target=
=3D"_blank">https://git.linaro.org/people/pmaydell/qemu-arm</a> into stagin=
g (2024-11-05 21:27:18 +0000)<br>
&gt;<br>
&gt; are available in the Git repository at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://github.com/kostyanf14/qemu.git" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/kostyanf14/qemu.git</a> ta=
gs/qga-pull-2024-11-07<br>
&gt;<br>
&gt; for you to fetch changes up to 5ab1c032e6eea810142eb918c57222464482756=
f:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0qemu-ga: Avoiding freeing line prematurely (2024-11-07 12:=
28:20 +0200)<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; qga-pull-2024-11-07<br>
&gt;<br>
<br>
<br>
Applied, thanks.<br>
<br>
Please update the changelog at <a href=3D"https://wiki.qemu.org/ChangeLog/9=
.2" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/ChangeLog/9.=
2</a><br>
for any user-visible changes.<br>
<br>
-- PMM<br>
<br>
</blockquote></div>

--000000000000deab1a0626650ff2--


