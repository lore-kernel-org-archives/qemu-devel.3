Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A79C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgVE-0006ij-Iy; Fri, 07 Mar 2025 17:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgVD-0006ib-EO
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgVB-0000k2-Ex
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741387748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b/KVdRmPN6bBHU7RWJqQSPEKF7ol7DlCUbiuoJU3OrM=;
 b=HKdY9/SqkywpCgiQEwxVuLecsGuAW/KsyTKUo46d+BGc3j+6FOSDSUGyihgUNICwHtsF1f
 kciqa7GNQ/5NDicHgHPqojIqM75DlI+tHQLXQavuvivw79JSVXHBNYLprsY+dgbowSWcMj
 sb/VQWahBPZLj9jvnufkJX/3Cu0678E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-K48t8w3ONEeV2PymrFTgcA-1; Fri, 07 Mar 2025 17:49:04 -0500
X-MC-Unique: K48t8w3ONEeV2PymrFTgcA-1
X-Mimecast-MFC-AGG-ID: K48t8w3ONEeV2PymrFTgcA_1741387744
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff6943febeso3852489a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387742; x=1741992542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b/KVdRmPN6bBHU7RWJqQSPEKF7ol7DlCUbiuoJU3OrM=;
 b=mrRXWYXdXxIMMHjYQD1WiGdv7jH/WuDNElvrmV7sojqRAJnGU3wHy6/S4Z75taRxfP
 ZGRnHSt/5VCme+D0VIMYHRZjXQc6C7v9hO2rFRfsGr1FVfOXQCacR08oW49jd1D9CKiG
 sUZ7+C7j0lxC2VhXGmS3LuRzItXU6UhtHYaa86pT9LCv8bXTfzlXxny9+80WKeqBtpZt
 6hW2g/hAY9YHtZzJfyrKwPu6UcpOsLQnYgCLbDLAdeUGmJIXa+GQDtemLpjNc7Y5Dzai
 9KOYXWCX9UiQHCi70VB3Yf1Rt0rO97n5EHGeLDZ7T53yZo03KnjlvbY4w2dlDBHtOA2e
 2NtA==
X-Gm-Message-State: AOJu0Yw3qvOhhZgVHIQoM5loq2IvkvLzusCoGCRDsr7VjNAI7B8Npn5Y
 JBaEfwF6HYvHsPOZCBMweG7UEl7romR+rVRQ3KWJCpvnuwJ453wp5VvHpcQNNsO4Rn4v08L+fR1
 5Vja4l6XwZAPVNlSBCIEyzMqspvIMXxG5JmzIWKhehiDP3UkHJMDonFroTbKwArZLBepqQ211zw
 mgg0zugDyrg6mKhkHWiHjGQqWd+A6GW4+d/Ms=
X-Gm-Gg: ASbGncukzzg1PXfVRseH5I88mRRnjYQKplqw3AgFXB33k9N1dX2uuBTr/MADtNo1D+u
 p2SpYeXc8inBcqHfSxHpHtBrep8VMZ4Vr2ea03r+7Bv/53/4E+ugxTAdlVtEMcts/PJxI9A==
X-Received: by 2002:a17:90a:c10f:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-2ffbc1474e7mr2007102a91.3.1741387741714; 
 Fri, 07 Mar 2025 14:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUearsEa7tt3Vgmuo2wU/7aLcqTvlv+XFYSNQULMZKDSfbm0OedkBhyXbcUoQvxKeoNuCcJyXGswJU+HMEIgk=
X-Received: by 2002:a17:90a:c10f:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-2ffbc1474e7mr2007086a91.3.1741387741419; Fri, 07 Mar 2025
 14:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-14-jsnow@redhat.com>
 <875xklqo4r.fsf@pond.sub.org>
In-Reply-To: <875xklqo4r.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Mar 2025 17:48:48 -0500
X-Gm-Features: AQ5f1JqttLQhFNvPejguag2nazKP6NTihVaT_YiDVRJ9AMh69GBacLshp9DnS3c
Message-ID: <CAFn=p-a_Hq=bkObhupTtQ_AreJ=Rfrx9Dr4cC4taFtbsCE6ZRA@mail.gmail.com>
Subject: Re: [PATCH 13/57] docs/qapi-domain: add "Arguments:" field lists
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000be7fde062fc86d9c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000be7fde062fc86d9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 2:46=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This adds special rendering for Sphinx's typed field lists.
> >
> > This patch does not add any QAPI-aware markup, rendering, or
> > cross-referencing for the type names, yet. That feature requires a
> > subclass to TypedField which will happen in its own commit quite a bit
> > later in this series; after all the basic fields and objects have been
> > established first.
> >
> > The syntax for this field is:
> >
> > :arg type name: description
> >    description cont'd
> >
> > You can omit the type or the description, but you cannot omit the name
> > -- if you do so, it degenerates into a "normal field list" entry, and
> > probably isn't what you want.
>
> Exuse my nitpicking...  "cannot omit" suggests omission is a hard error.
> The text after "--" suggests it isn't, it gives you something that
> "probably isn't what you want".  Which way does it actually behave?
>

Haha.

If you omit the name, the info field list entry degrades into a
rst-standard field list entry. Later in the series, I explicitly prohibit
that because it is definitely not what you want at all.

info field list =3D special processing is applied to group entries, labels
are added, add xrefs, etc
field list =3D regular definition list exactly as typed. I.e. the label wil=
l
be "arg:"


>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--000000000000be7fde062fc86d9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 2:46=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This adds special rendering for Sphinx&#39;s typed field lists.<br>
&gt;<br>
&gt; This patch does not add any QAPI-aware markup, rendering, or<br>
&gt; cross-referencing for the type names, yet. That feature requires a<br>
&gt; subclass to TypedField which will happen in its own commit quite a bit=
<br>
&gt; later in this series; after all the basic fields and objects have been=
<br>
&gt; established first.<br>
&gt;<br>
&gt; The syntax for this field is:<br>
&gt;<br>
&gt; :arg type name: description<br>
&gt;=C2=A0 =C2=A0 description cont&#39;d<br>
&gt;<br>
&gt; You can omit the type or the description, but you cannot omit the name=
<br>
&gt; -- if you do so, it degenerates into a &quot;normal field list&quot; e=
ntry, and<br>
&gt; probably isn&#39;t what you want.<br>
<br>
Exuse my nitpicking...=C2=A0 &quot;cannot omit&quot; suggests omission is a=
 hard error.<br>
The text after &quot;--&quot; suggests it isn&#39;t, it gives you something=
 that<br>
&quot;probably isn&#39;t what you want&quot;.=C2=A0 Which way does it actua=
lly behave?<br></blockquote><div><br></div><div>Haha.</div><div><br></div><=
div>If you omit the name, the info field list entry degrades into a rst-sta=
ndard field list entry. Later in the series, I explicitly prohibit that bec=
ause it is definitely not what you want at all.</div><div><br></div><div>in=
fo field list =3D special processing is applied to group entries, labels ar=
e added, add xrefs, etc</div><div>field list =3D regular definition list ex=
actly as typed. I.e. the label will be &quot;arg:&quot;</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--000000000000be7fde062fc86d9c--


