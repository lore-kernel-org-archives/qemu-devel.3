Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227E4CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETyd-0000wo-15; Thu, 30 Oct 2025 10:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vETyY-0000rq-Tn
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vETyK-0001Pu-Lo
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=avCY1hlGyBZK0pmtgUoh4yZzaxSU4Nu3njqRInDUgWU=;
 b=IEQl37HZhnRsyUvSLLL+GM3UjbubUe2HAnlrWlQabLHV5EQIGepVuwkmvlrbtmoyAc/dho
 qO1197jJBdyFAu5kV2aDeOCjNyunO1z1TohUSjm7KBRpyclxiA6S9JMz5yVIbdpO1oNUWS
 G3tody1Ty0+noGx3necTQ/G8YBWDKi0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-MNqokhEsNLK3sgO1jAHOIg-1; Thu, 30 Oct 2025 10:49:42 -0400
X-MC-Unique: MNqokhEsNLK3sgO1jAHOIg-1
X-Mimecast-MFC-AGG-ID: MNqokhEsNLK3sgO1jAHOIg_1761835781
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-745c3f7e569so13182037b3.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 07:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761835781; x=1762440581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avCY1hlGyBZK0pmtgUoh4yZzaxSU4Nu3njqRInDUgWU=;
 b=aK7pG5VXb2hJbryimSRgCkGktJgawIr9Vrzfxxu9Z4aW+o5kwS7zeDh1E1z+crgaQS
 TTiT3bOPF2lA5DRX+JgmgpYb6uEtJzsZrklGy3rA6fGXRMzo18ZSAb8NDmTR8p+MT8Ps
 0/2/xHAPB7Lcn53Om72D/e2zU2MUEBX5gUa0Ay41mkqKeRC2xWyXz27c8r5WBvLS6gnV
 metugM5VJqJ2I4tU4DPO5DryI6a2rfwNWcCWHgq9v+dB20tBoVRBaNEvZt28u3G49+jL
 SFkWpLw8VfGRwDjZ+bsVLWTehjSzGu7RgoR/zxKyl6Ylc+VY4TJHdQYWWOAX2WM9dAsJ
 Tq0A==
X-Gm-Message-State: AOJu0YyZguHrPGtY+34XOl7pQTJ1NwSWeaLNzCLWw2etpvIQ6SPkbqAJ
 QkEPLj4pt2eYJ5LiysbRRKCu5TIMTAuQ3RNc8QQZ/LYY5oFoVSmUAQEe2wx/GvaNsd7AJGIcndr
 2mLkTiMjL+pVLrzFfbnN0SfYnbI4fiWNyheQIhROFn+sezv71x53B56QOHq/AlhFWhuyrpUwXOn
 SXSYj+0Exlk2QN6D4LwITETRtbM8Injd81PH98gm8=
X-Gm-Gg: ASbGnctrqNfkgDhnQJn/F7nfyvsFShnfW+U+5kT3K8hdhhvcmM8fbOFB33ssu/oE8Sl
 RFmzJnDIcqegTh0zlBvJr1kR768L28Fu0dX5moF29EsHq3yFwEKkJgFTCIBZSIlKIhPcv+tdfik
 8xWaXCoVoD+cf8zWQzx5XPLsXP6s+2u1lYI0jJJnA6ZdiB8UFx30ND37NBlpxyESEfxS0eJLLun
 jQ2X+/qzeLLF6s=
X-Received: by 2002:a05:690c:6a86:b0:780:f794:6e21 with SMTP id
 00721157ae682-78638e30e25mr55070267b3.24.1761835781080; 
 Thu, 30 Oct 2025 07:49:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD/hkIMnfFHmiLd35CBodaxMKHSPADLmc5slosMZZZ7ZvAbzI5EJIiVLSgeYxTZUwuwWHVo6Qm9rXfRFr3s6Q=
X-Received: by 2002:a05:690c:6a86:b0:780:f794:6e21 with SMTP id
 00721157ae682-78638e30e25mr55069817b3.24.1761835780611; Thu, 30 Oct 2025
 07:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-2-jsnow@redhat.com>
 <65b02307-35c9-46ab-bef3-2b5a9e7e082d@redhat.com>
In-Reply-To: <65b02307-35c9-46ab-bef3-2b5a9e7e082d@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 30 Oct 2025 10:49:29 -0400
X-Gm-Features: AWmQ_bms078nOXjE1tEREHLbSA1txRWd1vvznhZdN8YsUdNr-UpG-1hanwde6DA
Message-ID: <CAFn=p-aqazgRzKTXxpN8rNk8R=LEzkKFuuHuf_EjcwJSDRxZUA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] python/mkvenv: ensure HAVE_LIB variables are
 actually constants
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000db3f050642615bee"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000db3f050642615bee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025, 3:51=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote:

> On 28/10/2025 23.03, John Snow wrote:
> > Pylint 4.x has refined checking for variable names that behave as
> > constants vs ones that do not; unfortunately our tricky import machiner=
y
> > is perceived as these variables being re-assigned.
> >
> > Add a temporary variable with an underscore and assign to the global
> > constants precisely once to alleviate this new nag message.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   python/scripts/mkvenv.py | 24 ++++++++++++++++--------
> >   python/setup.cfg         |  1 +
> >   2 files changed, 17 insertions(+), 8 deletions(-)
>
> ...> diff --git a/python/setup.cfg b/python/setup.cfg
> > index d7f5dc7bafe..f40f11396c9 100644
> > --- a/python/setup.cfg
> > +++ b/python/setup.cfg
> > @@ -159,6 +159,7 @@ good-names=3Di,
> >              c,   # for c in string: ...
> >              T,   # for TypeVars. See pylint#3401
> >              SocketAddrT,  # Not sure why this is invalid.
> > +           _import_ok,  # For mkvenv import trickery and compatibility
> pre-4.x
>
> Out of curiosity, is it really necessary to add _import_ok to good-names,
> or
> is this just for being on the safe side for future changes in pylint?
>

It's for the older versions... they still think it's a constant and want it
uppercased.


> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>

--000000000000db3f050642615bee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025, 3:51=E2=80=
=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 28/10/2025 23.03,=
 John Snow wrote:<br>
&gt; Pylint 4.x has refined checking for variable names that behave as<br>
&gt; constants vs ones that do not; unfortunately our tricky import machine=
ry<br>
&gt; is perceived as these variables being re-assigned.<br>
&gt; <br>
&gt; Add a temporary variable with an underscore and assign to the global<b=
r>
&gt; constants precisely once to alleviate this new nag message.<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0python/scripts/mkvenv.py | 24 ++++++++++++++++--------<br>
&gt;=C2=A0 =C2=A0python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
1 +<br>
&gt;=C2=A0 =C2=A02 files changed, 17 insertions(+), 8 deletions(-)<br>
<br>
...&gt; diff --git a/python/setup.cfg b/python/setup.cfg<br>
&gt; index d7f5dc7bafe..f40f11396c9 100644<br>
&gt; --- a/python/setup.cfg<br>
&gt; +++ b/python/setup.cfg<br>
&gt; @@ -159,6 +159,7 @@ good-names=3Di,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c,=C2=A0 =C2=A0# for c=
 in string: ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 T,=C2=A0 =C2=A0# for T=
ypeVars. See pylint#3401<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SocketAddrT,=C2=A0 # N=
ot sure why this is invalid.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_import_ok,=C2=A0 # For mkve=
nv import trickery and compatibility pre-4.x<br>
<br>
Out of curiosity, is it really necessary to add _import_ok to good-names, o=
r <br>
is this just for being on the safe side for future changes in pylint?<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39=
;s for the older versions... they still think it&#39;s a constant and want =
it uppercased.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Anyway,<br>
Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000db3f050642615bee--


