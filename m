Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C573EC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 17:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGNc-00037T-RL; Mon, 17 Jun 2024 13:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJGNZ-00036z-Nt
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJGNX-0000jH-I8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718646170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2iH2avmUGLmY35A4rTBBzlKbE39Hh8bZpQcKOwGn7s4=;
 b=GL6dmz/ecF04eYWIUBg72QuOHR81UfHeUgTw+XCXNBGECTp5hiGOcdtF/Ou9g6Uj/L9Mc0
 pAzZfLELHybJxSUYIr7Uxk2IhlgaSc0sZtUcLOQMq7TjERmFDUUtLBmsnM/b6bm+pIRXMf
 mchyPNJdJu8c4r1+DQxazz/dHc1gfmE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-PxIJIgWbOkWdt8c1tDMNNg-1; Mon, 17 Jun 2024 13:42:45 -0400
X-MC-Unique: PxIJIgWbOkWdt8c1tDMNNg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c2db1fc2fbso4789830a91.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 10:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718646164; x=1719250964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2iH2avmUGLmY35A4rTBBzlKbE39Hh8bZpQcKOwGn7s4=;
 b=qFYHd5+2vh19MDT92csqBfO/2nAnsf/VbHW4Pk0b/yCkRy30gAbSiqF/NzfaeWD3+/
 06WFUalDU5ox8DSRm1sJ9whlybyWtF7dJv2dhogCCLZlwrgc+MX3pjtrUS7Y6P/s3Njz
 nTkIl8K4IaNy8NFf9dyutQrf2CUS7MHZwSNhMhhW3ls/QJ3e9G6j7riX7Oho8cxKO2c0
 sEEKnfYsiKqKB2S6D6cY89RLiWDizWaaErt7p/7PquTRV1ZT0kybMLGB0gGARguOkePp
 fzUMIhOWWDH6BpFkjRfAMWKNFV324t59HM1y0Q/dvncSCCpsG+6KY+vm0mNdmgvb021Q
 3Mtg==
X-Gm-Message-State: AOJu0YzRvBoDs8kBbkp56VKXNL/Z+wMEBncD6Z8ngR3Y6iUgzwZowWNm
 swLwmdDgVmZ1tj5cEfA2791eM9dkrUb29JY0Uug4m8dudsB9uq4kUhg+FWtoOFC1tVMM2dnYx/n
 2hgBxaBZXDvRJSDkrQSGt1Wp4BII57V9ay5XxYs7Kd0YOcfnOyFCO+CotYnN9sPpd9pP88lSEuP
 krh2gTAuV4WfWN28l+gsa7j1TNDIo=
X-Received: by 2002:a17:90a:c7d0:b0:2c3:3cee:7d7b with SMTP id
 98e67ed59e1d1-2c4da9ceaa8mr10700651a91.0.1718646164285; 
 Mon, 17 Jun 2024 10:42:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGdS0KjKgewO2ZADxUItM9y3B1ZYA2xZ7daAiT8Eq8OBZCVX6WcNlLoAn842RWHxZgrIEnCgzdIjo1nWdTQ8s=
X-Received: by 2002:a17:90a:c7d0:b0:2c3:3cee:7d7b with SMTP id
 98e67ed59e1d1-2c4da9ceaa8mr10700600a91.0.1718646163756; Mon, 17 Jun 2024
 10:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-14-jsnow@redhat.com>
 <871q4z5039.fsf@pond.sub.org>
In-Reply-To: <871q4z5039.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Jun 2024 13:42:31 -0400
Message-ID: <CAFn=p-a1kkP7V6C_c2UD7K50XzBtaweHfKU08oQ9fonnpjZmQQ@mail.gmail.com>
Subject: Re: [PATCH 13/20] docs/qapidoc: fix nested parsing under untagged
 sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Mads Ynddal <mads@ynddal.dk>, 
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000015ed6d061b197e38"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--00000000000015ed6d061b197e38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024, 5:46=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Sphinx does not like sections without titles, because it wants to
> > convert every section into a reference. When there is no title, it
> > struggles to do this and transforms the tree inproperly.
> >
> > Depending on the rST used, this may result in an assertion error deep i=
n
> > the docutils HTMLWriter.
>
> I'm getting vibes of someone having had hours of "fun" with Sphinx...
>
> Can you give you an idea of how a reproducer would look like?
>

Yes - this is necessary for captioned example blocks that appear in
untagged sections, because those have titles.

When the sphinx html writer encounters a title under a section without a
title field, it malforms the tree (I cannot give you an example of this
easily, it's deep in the bowels) and produces an assertion error.

If you want to see it explode for yourself, just modify any untagged
section to include a captioned codeblock and watch it die.

If you apply either the note or Example conversion patches without this
fix, the old generator will choke. (Note patch dies because of my use of
".. admonition:: Notes", which also creates a title element.)

Simply put - docutils can tolerate title-less sections, Sphinx cannot. (And
it is not graceful about it.)


> > When parsing an untagged section (free paragraphs), skip making a hollo=
w
> > section and instead append the parse results to the prior section.
> >
> > Many Bothans died to bring us this information.
>
> Terribly sad.
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 34e95bd168d..cfc0cf169ef 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -286,14 +286,20 @@ def _nodes_for_sections(self, doc):
> >              if section.tag and section.tag =3D=3D 'TODO':
> >                  # Hide TODO: sections
> >                  continue
> > +
> > +            if not section.tag:
> > +                # Sphinx cannot handle sectionless titles;
> > +                # Instead, just append the results to the prior sectio=
n.
> > +                container =3D nodes.container()
> > +                self._parse_text_into_node(section.text, container)
> > +                nodelist +=3D container.children
> > +                continue
> > +
> >              snode =3D self._make_section(section.tag)
> > -            if section.tag and section.tag.startswith('Example'):
> > +            if section.tag.startswith('Example'):
> >                  snode +=3D self._nodes_for_example(dedent(section.text=
))
> >              else:
> > -                self._parse_text_into_node(
> > -                    dedent(section.text) if section.tag else
> section.text,
> > -                    snode,
> > -                )
> > +                self._parse_text_into_node(dedent(section.text), snode=
)
> >              nodelist.append(snode)
> >          return nodelist
>
> Looks plausible.  I lack the Sphinx-fu to say more.
>

Recommend just observing a before/after; the hash changes but the output
doesn't meaningfully change.

I intend to remove the old generator when we're done, so I think this is
probably safe to wave through with an ACK so long as there isn't
tremendously obvious regression (And, I have tested these patches from 3.x
to 7.x so I do not believe there is any compat risk.)

>

--00000000000015ed6d061b197e38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jun 14, 2024, 5:46=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Sphinx does not like sections without titles, because it wants to<br>
&gt; convert every section into a reference. When there is no title, it<br>
&gt; struggles to do this and transforms the tree inproperly.<br>
&gt;<br>
&gt; Depending on the rST used, this may result in an assertion error deep =
in<br>
&gt; the docutils HTMLWriter.<br>
<br>
I&#39;m getting vibes of someone having had hours of &quot;fun&quot; with S=
phinx...<br>
<br>
Can you give you an idea of how a reproducer would look like?<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes - this is =
necessary for captioned example blocks that appear in untagged sections, be=
cause those have titles.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>When the sphinx html writer encounters a title under a section without a t=
itle field, it malforms the tree (I cannot give you an example of this easi=
ly, it&#39;s deep in the bowels) and produces an assertion error.</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">If you want to see it explode for=
 yourself, just modify any untagged section to include a captioned codebloc=
k and watch it die.</div><div dir=3D"auto"><br></div><div dir=3D"auto">If y=
ou apply either the note or Example conversion patches without this fix, th=
e old generator will choke. (Note patch dies because of my use of &quot;.. =
admonition:: Notes&quot;, which also creates a title element.)</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Simply put - docutils can tolerate t=
itle-less sections, Sphinx cannot. (And it is not graceful about it.)</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
&gt; When parsing an untagged section (free paragraphs), skip making a holl=
ow<br>
&gt; section and instead append the parse results to the prior section.<br>
&gt;<br>
&gt; Many Bothans died to bring us this information.<br>
<br>
Terribly sad.<br>
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 16 +++++++++++-----<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 34e95bd168d..cfc0cf169ef 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -286,14 +286,20 @@ def _nodes_for_sections(self, doc):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.tag and sec=
tion.tag =3D=3D &#39;TODO&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Hide T=
ODO: sections<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not section.tag:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sphinx cann=
ot handle sectionless titles;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Instead, ju=
st append the results to the prior section.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 container =3D=
 nodes.container()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._parse_t=
ext_into_node(section.text, container)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nodelist +=3D=
 container.children<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snode =3D self._make_s=
ection(section.tag)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.tag and section.=
tag.startswith(&#39;Example&#39;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.tag.startswith(&=
#39;Example&#39;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snode +=
=3D self._nodes_for_example(dedent(section.text))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._parse_t=
ext_into_node(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 dedent(section.text) if section.tag else section.text,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 snode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._parse_t=
ext_into_node(dedent(section.text), snode)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nodelist.append(snode)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return nodelist<br>
<br>
Looks plausible.=C2=A0 I lack the Sphinx-fu to say more.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Recommend just obse=
rving a before/after; the hash changes but the output doesn&#39;t meaningfu=
lly change.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I intend to =
remove the old generator when we&#39;re done, so I think this is probably s=
afe to wave through with an ACK so long as there isn&#39;t tremendously obv=
ious regression (And, I have tested these patches from 3.x to 7.x so I do n=
ot believe there is any compat risk.)</div><div dir=3D"auto"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000015ed6d061b197e38--


