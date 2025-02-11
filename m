Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D46C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 17:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thtxA-0001hf-QP; Tue, 11 Feb 2025 12:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1thtx7-0001hJ-Ds
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:21:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1thtx3-0005kI-Sg
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739294495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=agW0Q94mU7hjkM7nGhiHqYJ5GyP1jPfHxsAcIQlbRrY=;
 b=di876ns3VMCqjY5fT7wmjni6xQmc0leqJNp5XIjX/NG/O3fxzGGRBxc05s5AvSU/r2i8hj
 8syceomO3+1Fvs0zEj93e+UbgkqoKSW+cLoQxNzP9cVym1ALP36C8d1djkF9nS3VntK8z7
 G+gQxVI6/XWwXVM41pBRvIHsqBcF/+k=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-kx9oLjp2NRqeywcUXT5AaQ-1; Tue, 11 Feb 2025 12:21:30 -0500
X-MC-Unique: kx9oLjp2NRqeywcUXT5AaQ-1
X-Mimecast-MFC-AGG-ID: kx9oLjp2NRqeywcUXT5AaQ
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2f9c02f54f2so11747636a91.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 09:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739294490; x=1739899290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=agW0Q94mU7hjkM7nGhiHqYJ5GyP1jPfHxsAcIQlbRrY=;
 b=bdTpptvg4wysCnmLBR9UjWCZibuEZcJ6nF7NjtUwr3NEUi9xRl6kxpF+Cy4fQ1PO3S
 JLpxThkYxSbThqCkZdgXuyHlJD9EPfsYJSIxKQ9bPGHNrCUu6XgGY5ybej5dMHFNVwJG
 Q3BEq+X1b5D+PDXvRBFDN1/+Re8zfv/UQfQwXuq5kO2hbTm1e+c370nRFGGpHoV0gwnV
 JmdwTt1SC05T9EemwTTllwAQVDOE/5vKtT6b7eSY98pX3tCZIelQ75sWZpsrxhvCcbSH
 VWXGAitmv58v97dIEDxB06JTVkw0ISUs9dCW16XmXM900mRt+6Q7qm+PGOGamkw1pPAV
 klqg==
X-Gm-Message-State: AOJu0Yxz056z340UqTa/upAvk1nxCPWHq0kOt2ZTGDtzAgerVhhsIYmu
 rIweR6L/d1rFHTltEXSKcBUJnHL0CqLNIEzFK3TYYXw00hnN0qQ/tnCxdXr13CK0W2uEaM7SCVB
 vLhemYr8hBC4bRd83mr3j9oqNo+3j/jxbGH0IYXTm0BeizEjq2io6N41XFWwZazMK6ZrbXJephh
 C9vkoJTUzGAtGdro93kC9cnLWCNug=
X-Gm-Gg: ASbGnctdRwiQly+ilyTYFudmFfJtZZDTNQPH8O/NM89lBrbWbvkBay4LBD0soUprkAn
 HzPvgrUhX1g+hTtrPd92EiJ0AKeZw5mqiACUHYUupL+2gIllPt4bpSiX+gRZU+wh9fKZTNEkKa2
 9XMv21gE8tTs4CHAZQdg==
X-Received: by 2002:a17:90b:3596:b0:2ee:bf84:4fe8 with SMTP id
 98e67ed59e1d1-2fa243eaa37mr24985360a91.30.1739294489622; 
 Tue, 11 Feb 2025 09:21:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm1n/SfAVOGRoWIYQlNy/ZWhovnLfVDWJLm6Qy4Mg+AYXAMYO5yUVSamfuNju0UIIWdvpxenDy30sCdYhemVo=
X-Received: by 2002:a17:90b:3596:b0:2ee:bf84:4fe8 with SMTP id
 98e67ed59e1d1-2fa243eaa37mr24985326a91.30.1739294489320; Tue, 11 Feb 2025
 09:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-2-jsnow@redhat.com>
 <87msestu08.fsf@pond.sub.org>
In-Reply-To: <87msestu08.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 11 Feb 2025 12:21:17 -0500
X-Gm-Features: AWEUYZlugDOM6eqCLsb4sVuULZs9Qvs_L3S5flrk5Z2HblBsVaAcIeQLBcsk-Pg
Message-ID: <CAFn=p-ZWE4SOmYksxs4XNeeSwQXSeCz+NXPCfwY16V6kWeQ3QQ@mail.gmail.com>
Subject: Re: [PATCH 01/42] docs/qapidoc: support header-less freeform sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>, 
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003232ed062de10e79"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000003232ed062de10e79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025, 9:51=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > The code as written can't handle if a header isn't found and will crash=
,
> > because `node` will be uninitialized. If we don't have a section title,
> > create a generic block to insert text into instead.
>
> Suggest to show input that makes it crash.  Something like
>
>   The code as written crashes when a free-form documentation block
>   doesn't start with a heading or subheading, like so
>
>       ##
>       # Just text, no heading.
>       ##
>
>   The code then uses `node` uninitialized.
>
>   To fix, create a generic block to insert the doc text into.
>


Okeydokey. Simple enough, thanks.


> > (This patch also removes a lingering pylint warning in the QAPIDoc
> > implementation that prevents getting a clean baseline to use for
> > forthcoming additions.)
> >
> > I am not attempting to *fully* clean up the existing QAPIDoc
> > implementation in pylint because I intend to delete it anyway; this
> > patch merely accomplishes a baseline under a specific pylint
> > configuration:
> >
> > PYTHONPATH=3D../../scripts/ pylint --disable=3Dfixme,too-many-lines,\
> > consider-using-f-string,missing-docstring,unused-argument,\
> > too-many-arguments,too-many-positional-arguments,\
> > too-many-public-methods \
> > qapidoc.py
> >
> > (under at least pylint 3.3.1; more robust tamping down of the
> > environment needed to consistently perform checks will happen later -
> > hopefully soon, sorry for the inconvenience.)
> >
> > This at least ensures there aren't regressions outside of these general
> > warnings in the new qapidoc.py code to be committed.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Fixes: 43e0d14ee09a (docs/sphinx: fix extra stuff in TOC after freeform
> QMP sections)
>

Ah, yep. You got it. Thanks for reviewing this mammoth project.

>

--0000000000003232ed062de10e79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 11, 2025, 9:51=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; The code as written can&#39;t handle if a header isn&#39;t found and w=
ill crash,<br>
&gt; because `node` will be uninitialized. If we don&#39;t have a section t=
itle,<br>
&gt; create a generic block to insert text into instead.<br>
<br>
Suggest to show input that makes it crash.=C2=A0 Something like<br>
<br>
=C2=A0 The code as written crashes when a free-form documentation block<br>
=C2=A0 doesn&#39;t start with a heading or subheading, like so<br>
<br>
=C2=A0 =C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 =C2=A0 # Just text, no heading.<br>
=C2=A0 =C2=A0 =C2=A0 ##<br>
<br>
=C2=A0 The code then uses `node` uninitialized.<br>
<br>
=C2=A0 To fix, create a generic block to insert the doc text into.<br></blo=
ckquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Okeydokey. Simple enough, thanks.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_containe=
r"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<br>
&gt; (This patch also removes a lingering pylint warning in the QAPIDoc<br>
&gt; implementation that prevents getting a clean baseline to use for<br>
&gt; forthcoming additions.)<br>
&gt;<br>
&gt; I am not attempting to *fully* clean up the existing QAPIDoc<br>
&gt; implementation in pylint because I intend to delete it anyway; this<br=
>
&gt; patch merely accomplishes a baseline under a specific pylint<br>
&gt; configuration:<br>
&gt;<br>
&gt; PYTHONPATH=3D../../scripts/ pylint --disable=3Dfixme,too-many-lines,\<=
br>
&gt; consider-using-f-string,missing-docstring,unused-argument,\<br>
&gt; too-many-arguments,too-many-positional-arguments,\<br>
&gt; too-many-public-methods \<br>
&gt; qapidoc.py<br>
&gt;<br>
&gt; (under at least pylint 3.3.1; more robust tamping down of the<br>
&gt; environment needed to consistently perform checks will happen later -<=
br>
&gt; hopefully soon, sorry for the inconvenience.)<br>
&gt;<br>
&gt; This at least ensures there aren&#39;t regressions outside of these ge=
neral<br>
&gt; warnings in the new qapidoc.py code to be committed.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
Fixes: 43e0d14ee09a (docs/sphinx: fix extra stuff in TOC after freeform QMP=
 sections)<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Ah, yep. You got it. Thanks for reviewing this mammoth project.=
=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000003232ed062de10e79--


