Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AD4C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 22:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRJd7-0006OR-64; Tue, 09 Jul 2024 18:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sRJd5-0006Lp-72
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 18:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sRJd3-0006u7-If
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 18:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720565286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmIZhF6fQ4kzDnnKwQYK1Zcxjtozuj6fPyb3UeUlHcY=;
 b=aRFB9u+spBKy3o1YI2GjuXU2s/0vHil711H9zgbF+ImfOpQ3e9xGffUkmLDGGSM+aK3LhN
 /1bmRvMVG9dVIZM7OkALaj70EVgwXZfP8+0UaUrnMW2rWuA/pXOYt92dtej2LTlroT/sX5
 2jQ3Fgl4VGWFdUpthdCh5Uas4pi2TC0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-Zlbi2PvKMwutN2-j0iKp5w-1; Tue, 09 Jul 2024 18:48:03 -0400
X-MC-Unique: Zlbi2PvKMwutN2-j0iKp5w-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c96f6bed83so4449139a91.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 15:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720565283; x=1721170083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BmIZhF6fQ4kzDnnKwQYK1Zcxjtozuj6fPyb3UeUlHcY=;
 b=r5/T+/fP6N29vfXjafIxfgvYCy6+B1fiHCc4m3F/nZoOYzv80prBkp0R4w54d2yDEk
 M/7mk9wNtBKCdq2zv4NcQqEsqM5Ey8BhhDt9NUdRAmuTpKI29Jap6jA73JP7YXqVqDEc
 resGUuWO1+th+9a5m39mUVeAygzdTLxJUaZ5luwnunrKxnRwSVdsLIJMz9JrUM2nZg8+
 ocjidq+X/IRUKe5zHYFS86fHAcNeQyDlqp+f6J/HFL0AjMTW0IjrhPE0gO6Qyj/e5VdI
 gCqhoPP7SS9Am1pByWq/OZG6dzlnS28U8LT6kzwbreQCm7MV83GLaNocno5ARGuRcTRc
 LcwA==
X-Gm-Message-State: AOJu0YyaXCVc3ck3bO1AnPXB16wvb5k0G1RbpaSlRg9PtmqAKpkK9bhl
 g1/7YuNyEbL0aia/Up/Eksjn1l7PLhqV9v+R7Jn8HaV74KbuszaeZkdyTN5H+QDh68xWOPK7krO
 XSi+OiA0cXXP5m778C4WUsXSI6NR2TzgtQxoJIwFnVuNzXsllg8fbrgO3MZbpDANDxRmVLpz7ia
 45AjEwJ426fdpFQkhrKIH3jWxfTyI=
X-Received: by 2002:a17:90b:a14:b0:2c9:635b:7271 with SMTP id
 98e67ed59e1d1-2ca35c71f1fmr3371730a91.21.1720565282737; 
 Tue, 09 Jul 2024 15:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnWRCMJ+pcRvgNwI5IKBTqq1gfrvOqcf1mREF+5pOGaTAJJ88sU20q6r9G0juqNsgZZ3VzQ+u+yYz0fXA/zt0=
X-Received: by 2002:a17:90b:a14:b0:2c9:635b:7271 with SMTP id
 98e67ed59e1d1-2ca35c71f1fmr3371707a91.21.1720565282364; Tue, 09 Jul 2024
 15:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-4-jsnow@redhat.com>
 <878qyaj1n7.fsf@pond.sub.org>
In-Reply-To: <878qyaj1n7.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Jul 2024 18:47:50 -0400
Message-ID: <CAFn=p-bHyUvWY2yW7Sc8z+r2enTfeH62uMXvM4VwSVjRX3YMBg@mail.gmail.com>
Subject: Re: [PATCH 3/8] docs/qapidoc: add QMP highlighting to annotated
 qmp-example blocks
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, 
 Alex Williamson <alex.williamson@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: multipart/alternative; boundary="00000000000077fdd1061cd85216"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

--00000000000077fdd1061cd85216
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:33=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > For any code literal blocks inside of a qmp-example directive, apply an=
d
> > enforce the QMP lexer/highlighter to those blocks.
> >
> > This way, you won't need to write:
> >
> > ```
> > .. qmp-example::
> >    :annotated:
> >
> >    Blah blah
> >
> >    .. code-block:: QMP
> >
> >       -> { "lorem": "ipsum" }
> > ```
> >
> > But instead, simply:
> >
> > ```
> > .. qmp-example::
> >    :annotated:
> >
> >    Blah blah::
> >
> >      -> { "lorem": "ipsum" }
> > ```
> >
> > Once the directive block is exited, whatever the previous default
> > highlight language was will be restored; localizing the forced QMP
> > lexing to exclusively this directive.
> >
> > Note, if the default language is *already* QMP, this directive will not
> > generate and restore redundant highlight configuration nodes. We may
> > well decide that the default language ought to be QMP for any QAPI
> > reference pages, but this way the directive behaves consistently no
> > matter where it is used.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Sadly, the previous patch didn't add tests, so this patch's effect
> isn't as easy to observe as it could be.
>

Sorry O:-)

In truth, I never intended it to *not* have this feature, but thought it
was helpful to split out just the code responsible for this feature into
its own patch so its soul could be independently judged to see if it was
lighter than a feather.

(i.e., does the convenience justify the SLOC?)


>
> Acked-by: Markus Armbruster <armbru@redhat.com>
>

--00000000000077fdd1061cd85216
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 9, 2024 at 6:33=E2=80=AFA=
M Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsno=
w@redhat.com</a>&gt; writes:<br>
<br>
&gt; For any code literal blocks inside of a qmp-example directive, apply a=
nd<br>
&gt; enforce the QMP lexer/highlighter to those blocks.<br>
&gt;<br>
&gt; This way, you won&#39;t need to write:<br>
&gt;<br>
&gt; ```<br>
&gt; .. qmp-example::<br>
&gt;=C2=A0 =C2=A0 :annotated:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 Blah blah<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 .. code-block:: QMP<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; { &quot;lorem&quot;: &quot;ipsum&quot;=
 }<br>
&gt; ```<br>
&gt;<br>
&gt; But instead, simply:<br>
&gt;<br>
&gt; ```<br>
&gt; .. qmp-example::<br>
&gt;=C2=A0 =C2=A0 :annotated:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 Blah blah::<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -&gt; { &quot;lorem&quot;: &quot;ipsum&quot; }<br>
&gt; ```<br>
&gt;<br>
&gt; Once the directive block is exited, whatever the previous default<br>
&gt; highlight language was will be restored; localizing the forced QMP<br>
&gt; lexing to exclusively this directive.<br>
&gt;<br>
&gt; Note, if the default language is *already* QMP, this directive will no=
t<br>
&gt; generate and restore redundant highlight configuration nodes. We may<b=
r>
&gt; well decide that the default language ought to be QMP for any QAPI<br>
&gt; reference pages, but this way the directive behaves consistently no<br=
>
&gt; matter where it is used.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
Sadly, the previous patch didn&#39;t add tests, so this patch&#39;s effect<=
br>
isn&#39;t as easy to observe as it could be.<br></blockquote><div><br></div=
><div>Sorry O:-)</div><div><br></div><div>In truth, I never intended it to =
*not* have this feature, but thought it was helpful to split out just the c=
ode responsible for this feature into its own patch so its soul could be in=
dependently judged to see if it was lighter than a feather.</div><div><br><=
/div><div>(i.e., does the convenience justify the SLOC?)</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>&gt;<br>
</blockquote></div></div>

--00000000000077fdd1061cd85216--


