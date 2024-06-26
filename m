Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC27C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 14:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMToW-0002mP-5d; Wed, 26 Jun 2024 10:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMToT-0002iK-T8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMToR-0002t8-Q7
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719412793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1f07OP/XdPY0ZoAjNE5FWSdjDGXlo+y5G+vtB24p+mQ=;
 b=h/6cnNj/mYfF5ZdnpVvYicrKaa7if1f6sEeFZ1XxMv2lQzy5Nhfq7604LbIjDarFNAWoIr
 L411/bw7mda632O3FVwV6lVu9HNj8ESoq4P/ZuTm1FUS5p/52jJCx6omVqCri6DD5KfjsC
 s8GRaFzcaDv29/rjz8Sr0yOCLqKky4o=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-cFc-E-FxOZWXaQ2d_3zLHw-1; Wed, 26 Jun 2024 10:39:50 -0400
X-MC-Unique: cFc-E-FxOZWXaQ2d_3zLHw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7065a9aea0aso7252346b3a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 07:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719412789; x=1720017589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1f07OP/XdPY0ZoAjNE5FWSdjDGXlo+y5G+vtB24p+mQ=;
 b=T6921oYhOfaXn0s6+ba+6wKWJDZZtGcMOwxntF7FRtFL0nzZdpiZOa2XPTfLB/a0x9
 H2PQI/Qy8LC/WOqwsp09b7wCSWr+KmY8RtbwRZiGqWQTTwn7qOt/8vH/8UiGnIM2DXyq
 W9H1YCy7APHiveBCjZhHhClK0wn//Acg3HG81XVs1mD9/3xdJotyyhsK1WHz+zmmEPYX
 8/aXvbjxznnkKiKErdElRuhgdxN7Yi3wyqNVtlIQ6tXUBs1XK+mYHEXzbr+VuokNfg1F
 znaqUGd0DpM04YPmgtucCaXGlYeAqFir7w92zr/kGosfVDvaXIFyS+UebYWWQoIpExo5
 V3xA==
X-Gm-Message-State: AOJu0Yw8m7w3NRWsPYt5zWnJdzfK8m+iukR/MX+3AlTWYJX6GZTPwCrL
 P2nmxyRCfziI+rUaYkFOZh6whgjL+cPdp8P+OIHgdgkkuJyB/LWjH8EDK0xQTRcGDnoqxAm6NAx
 PhsxJZtN+wtWfhgaB3zFbwaFPa3ov3Oi7Ll/+Qkkj8L8lDsKHTUEaec8BhlRGY8k7nwR24OaJm6
 kL7GHEP1Le0md84TZWTSblGx+Fm+c=
X-Received: by 2002:a05:6a21:32a0:b0:1b5:e2c8:dd0e with SMTP id
 adf61e73a8af0-1bcf7e3c9c8mr13655155637.9.1719412789559; 
 Wed, 26 Jun 2024 07:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFLiSHqD72cl33ag2JWlDjXapUv0m7IzHru3XghCXw2EgvHyATUxsIRMhws6GC5XtSeV+J7ytcV4lE+lWZpcA=
X-Received: by 2002:a05:6a21:32a0:b0:1b5:e2c8:dd0e with SMTP id
 adf61e73a8af0-1bcf7e3c9c8mr13655117637.9.1719412789180; Wed, 26 Jun 2024
 07:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-14-jsnow@redhat.com>
 <875xtwwad6.fsf@pond.sub.org>
In-Reply-To: <875xtwwad6.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Jun 2024 10:39:36 -0400
Message-ID: <CAFn=p-ZTXicwa0kjFhDaEx=aUcTUE1EsfGOy3T10FThTP1MTTw@mail.gmail.com>
Subject: Re: [PATCH 13/13] qapi: convert "Example" sections to rST
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
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
 Qemu-block <qemu-block@nongnu.org>, Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex.williamson@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000858bb0061bcbfcd4"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

--000000000000858bb0061bcbfcd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024, 1:18=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Eliminate the "Example" sections in QAPI doc blocks, converting them
> > into QMP example code blocks. This is generally done in this patch by
> > converting "Example:" or "Examples:" lines into ".. code-block:: QMP"
> > lines.
>
> [...]
>
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 85a14bb4308..849358b6387 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
>
> [...]
>
> > @@ -336,7 +338,35 @@
> >  #           }
> >  #        }
> >  #
> > -#     5. Migration is being performed and XBZRLE is active:
> > +# .. code-block:: QMP
> > +#    :caption: Example: Migration is being performed and XBZRLE is
> active
> > +#
> > +#     -> { "execute": "query-migrate" }
> > +#     <- {
> > +#           "return":{
> > +#              "status":"active",
> > +#              "total-time":12345,
> > +#              "setup-time":12345,
> > +#              "expected-downtime":12345,
> > +#              "ram":{
> > +#                 "total":1057024,
> > +#                 "remaining":1053304,
> > +#                 "transferred":3720,
> > +#                 "duplicate":123,
> > +#                 "normal":123,
> > +#                 "normal-bytes":123456,
> > +#                 "dirty-sync-count":15
> > +#              },
> > +#              "disk":{
> > +#                 "total":20971520,
> > +#                 "remaining":20880384,
> > +#                 "transferred":91136
> > +#              }
> > +#           }
> > +#        }
> > +#
> > +# .. code-block:: QMP
> > +#    :caption: Example: Migration is being performed and XBZRLE is
> active
> >  #
> >  #     -> { "execute": "query-migrate" }
> >  #     <- {
>
> Example accidentally duplicated.
>

Fixed this yesterday, oopsie. I think this was a rebase goof.


>
> [...]
>
> > diff --git a/tests/qapi-schema/doc-good.json
> b/tests/qapi-schema/doc-good.json
> > index 4b338cc0186..2774a7ce14d 100644
> > --- a/tests/qapi-schema/doc-good.json
> > +++ b/tests/qapi-schema/doc-good.json
> > @@ -46,11 +46,13 @@
> >  #
> >  # Duis aute irure dolor
> >  #
> > -# Example:
> > +# .. code-block:: QMP
> > +#    :caption: Example:
>
> See [*] below.
>
> >  #
> >  # -> in
> >  # <- out
> > -# Examples:
> > +# .. code-block::
> > +#
>
> Likewise.
>
> >  # - *verbatim*
> >  # - {braces}
> >  ##
> > @@ -172,12 +174,13 @@
> >  #
> >  #  Duis aute irure dolor
> >  #
> > -# Example:
> > +# .. code-block::
> >  #
> >  #  -> in
> >  #  <- out
> >  #
> > -# Examples:
> > +# .. code-block::
> > +#
> >  #  - *verbatim*
> >  #  - {braces}
> >  #
> > @@ -196,7 +199,7 @@
> >  # @cmd-feat1: a feature
> >  # @cmd-feat2: another feature
> >  #
> > -# Example:
> > +# .. code-block::
> >  #
> >  #  -> in
> >  #
> > diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> > index 2c9b4e419cb..347b9cb7134 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -93,11 +93,13 @@ Notes:
> >
> >  Duis aute irure dolor
> >
> > -Example:
> > +.. code-block:: QMP
> > +   :caption: Example:
>
> [*] This demonstrates the "Example: ..." is *not* recognized as a
> "Example" section before the patch (compare to the change we get for
> recognized sections below).
>
> I pointed out the same issue for "Note" in review of PATCH 9, and
> suggested ways to resolve it.  Pick a way there, and use it here as well
>

ACK


> >
> >  -> in
> >  <- out
> > -Examples:
> > +.. code-block::
> > +
> >  - *verbatim*
> >  - {braces}
> >  doc symbol=3DEnum
> > @@ -184,10 +186,14 @@ frobnicate
> >   - Ut enim ad minim veniam
> >
> >   Duis aute irure dolor
> > -    section=3DExample
> > +
> > +.. code-block::
> > +
> >   -> in
> >   <- out
> > -    section=3DExamples
> > +
> > +.. code-block::
> > +
> >   - *verbatim*
> >   - {braces}
> >      section=3DSince
> > @@ -199,7 +205,9 @@ If you're bored enough to read this, go see a video
> of boxed cats
> >  a feature
> >      feature=3Dcmd-feat2
> >  another feature
> > -    section=3DExample
> > +    section=3DNone
> > +.. code-block::
> > +
> >   -> in
> >
> >   <- out
> > diff --git a/tests/qapi-schema/doc-good.txt
> b/tests/qapi-schema/doc-good.txt
> > index b89f35d5476..1bd31f0938d 100644
> > --- a/tests/qapi-schema/doc-good.txt
> > +++ b/tests/qapi-schema/doc-good.txt
> > @@ -35,7 +35,10 @@ Duis aute irure dolor
> >
> >  Example:
> >
> > --> in <- out Examples: - *verbatim* - {braces}
> > +-> in <- out .. code-block:
>
> Looks like Sphinx didn't recognize the .. code-block: directive.
> Generator bug?
>

Honestly, not sure. Depends on what generates the plaintext...

... on IRC just now you say it's a Sphinx builder. I'll investigate why
this happens before resending.



> > +
> > +   - *verbatim*
> > +   - {braces}
> >
> >
> >  "Enum" (Enum)
> > @@ -219,17 +222,9 @@ Notes:
> >
> >  Duis aute irure dolor
> >
> > -
> > -Example
> > -~~~~~~~
> > -
> >     -> in
> >     <- out
> >
> > -
> > -Examples
> > -~~~~~~~~
> > -
> >     - *verbatim*
> >     - {braces}
> >
> > @@ -260,10 +255,6 @@ Features
> >  "cmd-feat2"
> >     another feature
> >
> > -
> > -Example
> > -~~~~~~~
> > -
> >     -> in
> >
> >     <- out
>
> Rendering to text now loses the "Example" heading.
>
> We render to manual pages in addition to HTML.  Looks like we don't lose
> "Example" there.  Odd.
>
> We render to text only for diffing purposes.  The loss there could
> perhaps be tolerated.  Still, could you avoid it with reasonable effort?
>

I've rewritten how Examples are handled; I'll check to see how they render
to plaintext and see what can be done.

>

--000000000000858bb0061bcbfcd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jun 26, 2024, 1:18=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"norefer=
rer">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Eliminate the &quot;Example&quot; sections in QAPI doc blocks, convert=
ing them<br>
&gt; into QMP example code blocks. This is generally done in this patch by<=
br>
&gt; converting &quot;Example:&quot; or &quot;Examples:&quot; lines into &q=
uot;.. code-block:: QMP&quot;<br>
&gt; lines.<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index 85a14bb4308..849358b6387 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
<br>
[...]<br>
<br>
&gt; @@ -336,7 +338,35 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A05. Migration is being performed and XBZRLE is ac=
tive:<br>
&gt; +# .. code-block:: QMP<br>
&gt; +#=C2=A0 =C2=A0 :caption: Example: Migration is being performed and XB=
ZRLE is active<br>
&gt; +#<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;query-migrate=
&quot; }<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0&lt;- {<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;return&quot;:{<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;:=
&quot;active&quot;,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;total-time&qu=
ot;:12345,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;setup-time&qu=
ot;:12345,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;expected-down=
time&quot;:12345,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ram&quot;:{<b=
r>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
total&quot;:1057024,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
remaining&quot;:1053304,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
transferred&quot;:3720,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
duplicate&quot;:123,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
normal&quot;:123,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
normal-bytes&quot;:123456,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
dirty-sync-count&quot;:15<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;disk&quot;:{<=
br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
total&quot;:20971520,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
remaining&quot;:20880384,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
transferred&quot;:91136<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +#<br>
&gt; +# .. code-block:: QMP<br>
&gt; +#=C2=A0 =C2=A0 :caption: Example: Migration is being performed and XB=
ZRLE is active<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;query-mi=
grate&quot; }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- {<br>
<br>
Example accidentally duplicated.<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Fixed this yesterday, oopsie. I think this =
was a rebase goof.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
[...]<br>
<br>
&gt; diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-g=
ood.json<br>
&gt; index 4b338cc0186..2774a7ce14d 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.json<br>
&gt; +++ b/tests/qapi-schema/doc-good.json<br>
&gt; @@ -46,11 +46,13 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Duis aute irure dolor<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. code-block:: QMP<br>
&gt; +#=C2=A0 =C2=A0 :caption: Example:<br>
<br>
See [*] below.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # -&gt; in<br>
&gt;=C2=A0 # &lt;- out<br>
&gt; -# Examples:<br>
&gt; +# .. code-block::<br>
&gt; +#<br>
<br>
Likewise.<br>
<br>
&gt;=C2=A0 # - *verbatim*<br>
&gt;=C2=A0 # - {braces}<br>
&gt;=C2=A0 ##<br>
&gt; @@ -172,12 +174,13 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 Duis aute irure dolor<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. code-block::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 -&gt; in<br>
&gt;=C2=A0 #=C2=A0 &lt;- out<br>
&gt;=C2=A0 #<br>
&gt; -# Examples:<br>
&gt; +# .. code-block::<br>
&gt; +#<br>
&gt;=C2=A0 #=C2=A0 - *verbatim*<br>
&gt;=C2=A0 #=C2=A0 - {braces}<br>
&gt;=C2=A0 #<br>
&gt; @@ -196,7 +199,7 @@<br>
&gt;=C2=A0 # @cmd-feat1: a feature<br>
&gt;=C2=A0 # @cmd-feat2: another feature<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. code-block::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 -&gt; in<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-go=
od.out<br>
&gt; index 2c9b4e419cb..347b9cb7134 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.out<br>
&gt; +++ b/tests/qapi-schema/doc-good.out<br>
&gt; @@ -93,11 +93,13 @@ Notes:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Duis aute irure dolor<br>
&gt;=C2=A0 <br>
&gt; -Example:<br>
&gt; +.. code-block:: QMP<br>
&gt; +=C2=A0 =C2=A0:caption: Example:<br>
<br>
[*] This demonstrates the &quot;Example: ...&quot; is *not* recognized as a=
<br>
&quot;Example&quot; section before the patch (compare to the change we get =
for<br>
recognized sections below).<br>
<br>
I pointed out the same issue for &quot;Note&quot; in review of PATCH 9, and=
<br>
suggested ways to resolve it.=C2=A0 Pick a way there, and use it here as we=
ll<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">ACK</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><br>
&gt;=C2=A0 <br>
&gt;=C2=A0 -&gt; in<br>
&gt;=C2=A0 &lt;- out<br>
&gt; -Examples:<br>
&gt; +.. code-block::<br>
&gt; +<br>
&gt;=C2=A0 - *verbatim*<br>
&gt;=C2=A0 - {braces}<br>
&gt;=C2=A0 doc symbol=3DEnum<br>
&gt; @@ -184,10 +186,14 @@ frobnicate<br>
&gt;=C2=A0 =C2=A0- Ut enim ad minim veniam<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0Duis aute irure dolor<br>
&gt; -=C2=A0 =C2=A0 section=3DExample<br>
&gt; +<br>
&gt; +.. code-block::<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0-&gt; in<br>
&gt;=C2=A0 =C2=A0&lt;- out<br>
&gt; -=C2=A0 =C2=A0 section=3DExamples<br>
&gt; +<br>
&gt; +.. code-block::<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0- *verbatim*<br>
&gt;=C2=A0 =C2=A0- {braces}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DSince<br>
&gt; @@ -199,7 +205,9 @@ If you&#39;re bored enough to read this, go see a =
video of boxed cats<br>
&gt;=C2=A0 a feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Dcmd-feat2<br>
&gt;=C2=A0 another feature<br>
&gt; -=C2=A0 =C2=A0 section=3DExample<br>
&gt; +=C2=A0 =C2=A0 section=3DNone<br>
&gt; +.. code-block::<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0-&gt; in<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0&lt;- out<br>
&gt; diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-go=
od.txt<br>
&gt; index b89f35d5476..1bd31f0938d 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.txt<br>
&gt; +++ b/tests/qapi-schema/doc-good.txt<br>
&gt; @@ -35,7 +35,10 @@ Duis aute irure dolor<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Example:<br>
&gt;=C2=A0 <br>
&gt; --&gt; in &lt;- out Examples: - *verbatim* - {braces}<br>
&gt; +-&gt; in &lt;- out .. code-block:<br>
<br>
Looks like Sphinx didn&#39;t recognize the .. code-block: directive.<br>
Generator bug?<br></blockquote></div></div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Honestly, not sure. Depends on what generates the plaintext..=
.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">... on IRC just =
now you say it&#39;s a Sphinx builder. I&#39;ll investigate why this happen=
s before resending.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0- *verbatim*<br>
&gt; +=C2=A0 =C2=A0- {braces}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 &quot;Enum&quot; (Enum)<br>
&gt; @@ -219,17 +222,9 @@ Notes:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Duis aute irure dolor<br>
&gt;=C2=A0 <br>
&gt; -<br>
&gt; -Example<br>
&gt; -~~~~~~~<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0-&gt; in<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;- out<br>
&gt;=C2=A0 <br>
&gt; -<br>
&gt; -Examples<br>
&gt; -~~~~~~~~<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0- *verbatim*<br>
&gt;=C2=A0 =C2=A0 =C2=A0- {braces}<br>
&gt;=C2=A0 <br>
&gt; @@ -260,10 +255,6 @@ Features<br>
&gt;=C2=A0 &quot;cmd-feat2&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0another feature<br>
&gt;=C2=A0 <br>
&gt; -<br>
&gt; -Example<br>
&gt; -~~~~~~~<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0-&gt; in<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;- out<br>
<br>
Rendering to text now loses the &quot;Example&quot; heading.<br>
<br>
We render to manual pages in addition to HTML.=C2=A0 Looks like we don&#39;=
t lose<br>
&quot;Example&quot; there.=C2=A0 Odd.<br>
<br>
We render to text only for diffing purposes.=C2=A0 The loss there could<br>
perhaps be tolerated.=C2=A0 Still, could you avoid it with reasonable effor=
t?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">I&#39;ve rewritten how Examples are handled; I&#39;ll check to see how th=
ey render to plaintext and see what can be done.</div><div dir=3D"auto"><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000858bb0061bcbfcd4--


