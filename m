Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EC3C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKi8r-0007lk-Cq; Fri, 21 Jun 2024 13:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKi8p-0007lU-GC
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKi8n-00088C-DA
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718991216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dqk142mszqs0b6WhBsjOEAuDLsXnf4feWpg9ZCM1uak=;
 b=Ccg8YgG0IFfVUj3a/P2MhXvpG+jmnQrzRBoOQW0S2wvaRNv+K4ZX1Hey08EyBJ0xli6kJ0
 /YqUNq5DF14jY9UviA+hJfo0TsQY4e4jbgNx2I3RVLQypAGLGSi8E5l6r/08NR367HY1uc
 1lC87MuBymeT/bCYfP9+b3Fomi4akHo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-wT2cg2H1O3um7uFBQLFN7Q-1; Fri, 21 Jun 2024 13:33:34 -0400
X-MC-Unique: wT2cg2H1O3um7uFBQLFN7Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c30144b103so1880495a91.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 10:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718991214; x=1719596014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dqk142mszqs0b6WhBsjOEAuDLsXnf4feWpg9ZCM1uak=;
 b=Q92T71dCgBO66gydsS32APFTkEXcbc/8jEgggG9Mgxmap89T2xP3dad7jNH0ZfEWmq
 UxYT3prgy1jDfhrHm+0guqy4z2ZJuPjEDt0+9y8UPjy24nXET70TJGDqeS/t5DP8yeEd
 H2Q7miuczqm7F3OEjT9KyI+esJtuNqTmkg6D0Ak9Jrsb1L4FB+EZjeM09ZRYgh7GLLAr
 FeUDqGF1oxrgXX6xqMgPljvDE/xUe7zAPxqjVmIygARitjiPjToWLOFPlM/kEDvR1R+G
 rvcTL8z0rsXOWxiIX5xsBEh1ImpfZV+qyq7vCn8/lUrq25y5OFhUkf6ZYeRi1VNeZci0
 fMZw==
X-Gm-Message-State: AOJu0YzTRuk0nC/o4c3IK79IxDN0bynugLCmmI2JbwDSHrv75lf+dSL9
 1Ly9EY/0XnkTItdH0bS4s9frqf7sWKmTyKYyWNpJRqQti5N7/Uze7Faa5r6e8lINUqqTcFebiOm
 zBPK07jL6BpTyJzT6PSHhccKxKrgAGARVlDO9hkA2Pkd/J4X/ABVSv6BRydgIfuqlZ+Klcjlk5X
 Pz2y9ORR7abcsq3gU9ySNWBxHuzDw=
X-Received: by 2002:a17:90a:d494:b0:2c2:c3f5:33c3 with SMTP id
 98e67ed59e1d1-2c83c1d4e6cmr584338a91.6.1718991213686; 
 Fri, 21 Jun 2024 10:33:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFKOUdlSo5nkWZo0ohY+m+jbB+AHHyLuirJ6WkDW5QqzUv0lgWFiGGkbOS53HMsneXOYS9sSK9Sr3/wqDidLA=
X-Received: by 2002:a17:90a:d494:b0:2c2:c3f5:33c3 with SMTP id
 98e67ed59e1d1-2c83c1d4e6cmr584291a91.6.1718991213200; Fri, 21 Jun 2024
 10:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
 <87a5je33cg.fsf@pond.sub.org>
In-Reply-To: <87a5je33cg.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 21 Jun 2024 13:33:21 -0400
Message-ID: <CAFn=p-bYbNmUVZzatE6PQOz7w9ady44bFj8Z4+61ibTYHAuw4g@mail.gmail.com>
Subject: Re: [PATCH 09/13] qapi: convert "Note" sections to plain rST
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Victor Toso de Carvalho <victortoso@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, 
 Jiri Pirko <jiri@resnulli.us>, Alex Williamson <alex.williamson@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a2a1ab061b69d4d0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

--000000000000a2a1ab061b69d4d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 8:08=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > We do not need a dedicated section for notes. By eliminating a speciall=
y
> > parsed section, these notes can be treated as normal rST paragraphs in
> > the new QMP reference manual, and can be placed and styled much more
> > flexibly.
> >
> > Convert all existing "Note" and "Notes" sections to pure rST. As part o=
f
> > the conversion, capitalize the first letter of each sentence and add
> > trailing punctuation where appropriate to ensure notes look sensible an=
d
> > consistent in rendered HTML documentation.
> >
> > Update docs/devel/qapi-code-gen.rst to reflect the new paradigm, and ..=
.
> >
> > ... Update the QAPI parser to prohibit "Note" sections while suggesting
> > a new syntax. The exact formatting to use is a matter of taste, but a
> > good candidate is simply:
> >
> > .. note:: lorem ipsum ...
> >
> > ... but there are other choices, too. The Sphinx readthedocs theme
> > offers theming for the following forms (capitalization unimportant); al=
l
> > are adorned with a (!) symbol in the title bar for rendered HTML docs.
> >
> > See
> >
> https://sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo.html#admoniti=
ons
> > for examples of each directive/admonition in use.
> >
> > These are rendered in orange:
> >
> > .. Attention:: ...
> > .. Caution:: ...
> > .. WARNING:: ...
> >
> > These are rendered in red:
> >
> > .. DANGER:: ...
> > .. Error:: ...
> >
> > These are rendered in green:
> >
> > .. Hint:: ...
> > .. Important:: ...
> > .. Tip:: ...
> >
> > These are rendered in blue:
> >
> > .. Note:: ...
> > .. admonition:: custom title
> >
> >    admonition body text
> >
> > This patch uses ".. note::" almost everywhere, with just two "caution"
> > directives. ".. admonition:: notes" is used in a few places where we ha=
d
> > an ordered list of multiple notes that would not make sense as
> > standalone/separate admonitions.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com> [for block*.json]
>
> [...]
>
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 8bd299265e3..5bfa0ded42c 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -195,12 +195,12 @@
> >  #
> >  # @typename: the type name of an object
> >  #
> > -# Note: objects can create properties at runtime, for example to
> > -#     describe links between different devices and/or objects.  These
> > -#     properties are not included in the output of this command.
> > -#
> >  # Returns: a list of ObjectPropertyInfo describing object properties
> >  #
> > +# .. note:: Objects can create properties at runtime, for example to
> > +#    describe links between different devices and/or objects.  These
> > +#    properties are not included in the output of this command.
> > +#
> >  # Since: 2.12
> >  ##
>
> You move the note.  Commit message doesn't tell why.
>
> >  { 'command': 'qom-list-properties',
>
> [...]
>

"v2" of this series now declines to move the note in this patch and instead
moves it in a separate patch that also enforces source order more strictly
so that the move can be explained in detail.

Rendering order diverges from source order briefly as a result; I will
mention that in the commit message instead.

(I don't think it's easy or worth doing to re-order the patches such that
source and render order never diverge; too much engineering for so
temporary a minor issue. Not to mention the source and render order is
already divergent in many places, so I don't think it's a regression so
much as it is a temporary .... lateralgression?)

--000000000000a2a1ab061b69d4d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 21, 2024 at 8:08=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsn=
ow@redhat.com</a>&gt; writes:<br>
<br>
&gt; We do not need a dedicated section for notes. By eliminating a special=
ly<br>
&gt; parsed section, these notes can be treated as normal rST paragraphs in=
<br>
&gt; the new QMP reference manual, and can be placed and styled much more<b=
r>
&gt; flexibly.<br>
&gt;<br>
&gt; Convert all existing &quot;Note&quot; and &quot;Notes&quot; sections t=
o pure rST. As part of<br>
&gt; the conversion, capitalize the first letter of each sentence and add<b=
r>
&gt; trailing punctuation where appropriate to ensure notes look sensible a=
nd<br>
&gt; consistent in rendered HTML documentation.<br>
&gt;<br>
&gt; Update docs/devel/qapi-code-gen.rst to reflect the new paradigm, and .=
..<br>
&gt;<br>
&gt; ... Update the QAPI parser to prohibit &quot;Note&quot; sections while=
 suggesting<br>
&gt; a new syntax. The exact formatting to use is a matter of taste, but a<=
br>
&gt; good candidate is simply:<br>
&gt;<br>
&gt; .. note:: lorem ipsum ...<br>
&gt;<br>
&gt; ... but there are other choices, too. The Sphinx readthedocs theme<br>
&gt; offers theming for the following forms (capitalization unimportant); a=
ll<br>
&gt; are adorned with a (!) symbol in the title bar for rendered HTML docs.=
<br>
&gt;<br>
&gt; See<br>
&gt; <a href=3D"https://sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo=
.html#admonitions" rel=3D"noreferrer" target=3D"_blank">https://sphinx-rtd-=
theme.readthedocs.io/en/stable/demo/demo.html#admonitions</a><br>
&gt; for examples of each directive/admonition in use.<br>
&gt;<br>
&gt; These are rendered in orange:<br>
&gt;<br>
&gt; .. Attention:: ...<br>
&gt; .. Caution:: ...<br>
&gt; .. WARNING:: ...<br>
&gt;<br>
&gt; These are rendered in red:<br>
&gt;<br>
&gt; .. DANGER:: ...<br>
&gt; .. Error:: ...<br>
&gt;<br>
&gt; These are rendered in green:<br>
&gt;<br>
&gt; .. Hint:: ...<br>
&gt; .. Important:: ...<br>
&gt; .. Tip:: ...<br>
&gt;<br>
&gt; These are rendered in blue:<br>
&gt;<br>
&gt; .. Note:: ...<br>
&gt; .. admonition:: custom title<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 admonition body text<br>
&gt;<br>
&gt; This patch uses &quot;.. note::&quot; almost everywhere, with just two=
 &quot;caution&quot;<br>
&gt; directives. &quot;.. admonition:: notes&quot; is used in a few places =
where we had<br>
&gt; an ordered list of multiple notes that would not make sense as<br>
&gt; standalone/separate admonitions.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; Acked-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank">stefanha@redhat.com</a>&gt; [for block*.json]<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qapi/qom.json b/qapi/qom.json<br>
&gt; index 8bd299265e3..5bfa0ded42c 100644<br>
&gt; --- a/qapi/qom.json<br>
&gt; +++ b/qapi/qom.json<br>
&gt; @@ -195,12 +195,12 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @typename: the type name of an object<br>
&gt;=C2=A0 #<br>
&gt; -# Note: objects can create properties at runtime, for example to<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0describe links between different devices and/or =
objects.=C2=A0 These<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0properties are not included in the output of thi=
s command.<br>
&gt; -#<br>
&gt;=C2=A0 # Returns: a list of ObjectPropertyInfo describing object proper=
ties<br>
&gt;=C2=A0 #<br>
&gt; +# .. note:: Objects can create properties at runtime, for example to<=
br>
&gt; +#=C2=A0 =C2=A0 describe links between different devices and/or object=
s.=C2=A0 These<br>
&gt; +#=C2=A0 =C2=A0 properties are not included in the output of this comm=
and.<br>
&gt; +#<br>
&gt;=C2=A0 # Since: 2.12<br>
&gt;=C2=A0 ##<br>
<br>
You move the note.=C2=A0 Commit message doesn&#39;t tell why.<br>
<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;qom-list-properties&#39;,<br>
<br>
[...]<br></blockquote><div><br></div><div>&quot;v2&quot; of this series now=
 declines to move the note in this patch and instead moves it in a separate=
 patch that also enforces source order more strictly so that the move can b=
e explained in detail. <br></div><div><br></div><div>Rendering order diverg=
es from source order briefly as a result; I will mention that in the commit=
 message instead.<br><br></div><div>(I don&#39;t think it&#39;s easy or wor=
th doing to re-order the patches such that source and render order never di=
verge; too much engineering for so temporary a minor issue. Not to mention =
the source and render order is already divergent in many places, so I don&#=
39;t think it&#39;s a regression so much as it is a temporary .... lateralg=
ression?)<br></div></div></div>

--000000000000a2a1ab061b69d4d0--


