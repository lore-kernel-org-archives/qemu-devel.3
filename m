Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBFFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 20:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUB3z-000144-P9; Wed, 17 Jul 2024 16:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sUB3y-00012m-1h
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 16:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sUB3w-0000sm-Dt
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 16:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721247343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7pop8qL8fJOk/iBn8zRjLyuL6vDxs5lT+ZwYX1D3Kk=;
 b=AqJ/D3sZjoYB96uBgi9Z9y8AkBDJ+/o+42J0lqp9WQ+gj6ywUPFeCyl+O5sWj6R3VL+/M7
 q13+z1RY5Dj0d/kpD03Lu+3SC/Pf8HFOCvdravJaut5CE1gQDNfcJwLfdq5WEBzrE3SWW2
 uZG/T3/jPQq+Ce4z7pIKpN+FhYN7w7k=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-AH-G2gcTO9O4By2gk--rvA-1; Wed, 17 Jul 2024 16:15:41 -0400
X-MC-Unique: AH-G2gcTO9O4By2gk--rvA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2cb656e4d97so98069a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 13:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721247337; x=1721852137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G7pop8qL8fJOk/iBn8zRjLyuL6vDxs5lT+ZwYX1D3Kk=;
 b=wFu3kwAFNxP4NCzlkA8cXIJR9PZVshziIpzKJ6OUsVqn86tz0fktDPb5H3qiaWvO4X
 UXcIcQpaJ2XY5ogV0jFsU1uXAD8HgqKx1j5KEFGsQ7927qjrfAHMKQ0bn7PBbqS/IQl7
 nwgZ/nwmpLOOoxT8U+zzT2CBY3wn/Tx5igc/CyuOoTPzSxRxxcw60XSe/PsDueL8XLzn
 HziaLZzGP9kkAB7IYKyqJlkWBBPnNlaPJn7qlgOv/t5CAPxaSHNoy8kQ2L3HNyJFZtiC
 +V75eR+U4MiUbBANLoFSTyow+gBu/LEQANCTtLxLtDvxa4lOn/H6+RBTO38F+DfGNYCl
 0o6A==
X-Gm-Message-State: AOJu0Ywx3eo8zrNHYoK0BOjjrN5Tyrm2LC6ANFe3jUEMmK8xYcKHAPfw
 6nIr1KU4peKJrSGT30isnU57tJ3/7davChDZ5sSjwHmzbhHxvRt0ZFzKDx9bO+6PJNu3i82zNXz
 bdW2hIXhmMbFfW1v7+aohMvz+xKTrpKPE3edSapAZVmlI2s9cPmyTn17/RH95FpDesFvg1KQe2W
 14+sM/JQXSvHQNCTINKaoqtYZ7BdI=
X-Received: by 2002:a17:90a:9a6:b0:2c9:7aea:2188 with SMTP id
 98e67ed59e1d1-2cb5246ec1cmr2179807a91.2.1721247337310; 
 Wed, 17 Jul 2024 13:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8ojkOz1O0B9GSv7VZ5a5MbZSDamrxfWd6eVxp03RvZ9Rezq2nSQqDwZUuMlvFcwu6lojZWAhiS9TBvj75QJw=
X-Received: by 2002:a17:90a:9a6:b0:2c9:7aea:2188 with SMTP id
 98e67ed59e1d1-2cb5246ec1cmr2179788a91.2.1721247336952; Wed, 17 Jul 2024
 13:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240717021312.606116-1-jsnow@redhat.com>
 <20240717021312.606116-7-jsnow@redhat.com>
 <87ttgoh39g.fsf@pond.sub.org>
In-Reply-To: <87ttgoh39g.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 Jul 2024 16:15:24 -0400
Message-ID: <CAFn=p-b=+wRJP6fi-hshan1-UgfdvaJGTxPc5YtYZSx-r_ryYw@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] qapi: convert "Example" sections without titles
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Qemu-block <qemu-block@nongnu.org>, 
 Lukas Straub <lukasstraub2@web.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mads Ynddal <mads@ynddal.dk>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Michael Roth <michael.roth@amd.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Ani Sinha <anisinha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001714d9061d772047"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000001714d9061d772047
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024, 3:44=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Use the no-option form of ".. qmp-example::" to convert any Examples
> > that do not have any form of caption or explanation whatsoever. Note
> > that in a few cases, example sections are split into two or more
> > separate example blocks. This is only done stylistically to create a
> > delineation between two or more logically independent examples.
> >
> > See commit-3: "docs/qapidoc: create qmp-example directive", for a
> >               detailed explanation of this custom directive syntax.
> >
> > See commit+3: "qapi: remove "Example" doc section" for a detailed
> >               explanation of why.
> >
> > Note: an empty "TODO" line was added to announce-self to keep the
> > example from floating up into the body; this will be addressed more
> > rigorously in the new qapidoc generator.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> [...]
>
> > diff --git a/qapi/run-state.json b/qapi/run-state.json
> > index 4d40c88876c..ab7116680b3 100644
> > --- a/qapi/run-state.json
> > +++ b/qapi/run-state.json
>
> [...]
>
> > @@ -469,7 +469,7 @@
> >  #
> >  # Since: 9.1
> >  #
> > -# Example:
> > +# ..qmp-example::
>
> Lacks a space, output is messed up.  Can fix in my tree.
>

Whoops. Wish rST was a bit pickier sometimes...


> >  #
> >  #     <- { "event": "GUEST_PVSHUTDOWN",
> >  #          "timestamp": { "seconds": 1648245259, "microseconds": 89377=
1
> } }
>
> [...]
>
> R-by stands.
>
>

--0000000000001714d9061d772047
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jul 17, 2024, 3:44=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Use the no-option form of &quot;.. qmp-example::&quot; to convert any =
Examples<br>
&gt; that do not have any form of caption or explanation whatsoever. Note<b=
r>
&gt; that in a few cases, example sections are split into two or more<br>
&gt; separate example blocks. This is only done stylistically to create a<b=
r>
&gt; delineation between two or more logically independent examples.<br>
&gt;<br>
&gt; See commit-3: &quot;docs/qapidoc: create qmp-example directive&quot;, =
for a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0detailed explana=
tion of this custom directive syntax.<br>
&gt;<br>
&gt; See commit+3: &quot;qapi: remove &quot;Example&quot; doc section&quot;=
 for a detailed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0explanation of w=
hy.<br>
&gt;<br>
&gt; Note: an empty &quot;TODO&quot; line was added to announce-self to kee=
p the<br>
&gt; example from floating up into the body; this will be addressed more<br=
>
&gt; rigorously in the new qapidoc generator.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qapi/run-state.json b/qapi/run-state.json<br>
&gt; index 4d40c88876c..ab7116680b3 100644<br>
&gt; --- a/qapi/run-state.json<br>
&gt; +++ b/qapi/run-state.json<br>
<br>
[...]<br>
<br>
&gt; @@ -469,7 +469,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 9.1<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# ..qmp-example::<br>
<br>
Lacks a space, output is messed up.=C2=A0 Can fix in my tree.<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Whoops. Wish r=
ST was a bit pickier sometimes...</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;event&quot;: &quot;GUEST_PVSH=
UTDOWN&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;timestamp&quot;: { &qu=
ot;seconds&quot;: 1648245259, &quot;microseconds&quot;: 893771 } }<br>
<br>
[...]<br>
<br>
R-by stands.<br>
<br>
</blockquote></div></div></div>

--0000000000001714d9061d772047--


