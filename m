Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF476C3DA42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 22:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRJmj-0008Ec-S6; Tue, 09 Jul 2024 18:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sRJmh-0008De-Su
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 18:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sRJmg-00005r-0J
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 18:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720565885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4iJoE5Hs29PxE+Mdnortydb9eMhzhciJCftEwnjQ34=;
 b=Biyc3W5EHE3Io/AwNUISS674xI8KCGiiJGbXatxJwo0/2IWy0lzthWm5mNxyNM2dKaCwzZ
 +2XBpvHjgpg0dO4eqlh33AndLXprr+RzK/NNjs22qwd0/mlIE9XcHHU9pXv+lQA40Ay3Of
 IjoWlSSg3ekc4Ui0EJnPI7t4W30kAdA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-BxEuyOfiMYuVnvf-tBks7w-1; Tue, 09 Jul 2024 18:58:01 -0400
X-MC-Unique: BxEuyOfiMYuVnvf-tBks7w-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c963f358feso5499903a91.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 15:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720565880; x=1721170680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h4iJoE5Hs29PxE+Mdnortydb9eMhzhciJCftEwnjQ34=;
 b=gxSUKk183X146wgigwGw3Okm6UJ/DAqaOd/Dzt8SYgEX8oikMsdAXzJwcq/PdFeU1c
 5ET20nlIPmVP/JDlW4hLVlG3XMzpymZIqZVfwa+FVDnFyld3BODuC317OJrWNSIAxD8d
 mgefhV+U3gyO0VxufDMYg4qQ+eWERVPTibHyhlzDkU0uRKqY2q8FZTUFc6xkfyWmmwJU
 sNMlYdh9Ozn0tqXSwJYSeeKJD8BZml9gyOFdBtIF7CRffvGWrvBUQy9F2m//gWkG+oP9
 2nvcyMC+pYq8fMVo2XM5DkToFOlzzxtRCCj1Sx/bEwrgnXsPBhSVwFTQijP0bJ3AvsTq
 TRhA==
X-Gm-Message-State: AOJu0YzEXIrP3dY0zGtOWdpKm7DpR7BpLuGe5c21TuscMlQMMO9OFBeS
 Gn/9JWHcDHZwMhzxvQj30PncAX5tCfAtTSXnPpqFd6I2KhonWz/O/+SIAX+K9gnYGIGe+dKgF8c
 KEY28nbxzPqcEfmTcE9Ik4wNHVp2lPSrLnbD5BDa7X5Ogqs3O4lHZD14OPxJwNCObrdnQUlWO6z
 IZeLe+F/hiVWpe4qAaDn/t9AtICTo=
X-Received: by 2002:a17:90b:682:b0:2c9:6ae7:20e4 with SMTP id
 98e67ed59e1d1-2ca35d86262mr3093753a91.45.1720565880221; 
 Tue, 09 Jul 2024 15:58:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5c2WQ2zfFZhostrvZUj5UiV4gncHkC9HJUnwpYEehSlKOTuLNj18aaVWRzPdxcBkQ6YI7HZMggn9+uIuOei8=
X-Received: by 2002:a17:90b:682:b0:2c9:6ae7:20e4 with SMTP id
 98e67ed59e1d1-2ca35d86262mr3093723a91.45.1720565879829; Tue, 09 Jul 2024
 15:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-8-jsnow@redhat.com>
 <87o776g5m7.fsf@pond.sub.org>
In-Reply-To: <87o776g5m7.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Jul 2024 18:57:47 -0400
Message-ID: <CAFn=p-bYytcxxVOPDpVFVhsaYetFeTG4DuoLQJFyXCrtPiWcOw@mail.gmail.com>
Subject: Re: [PATCH 7/8] qapi: convert "Example" sections with longer prose
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
Content-Type: multipart/alternative; boundary="000000000000148e54061cd8767a"
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

--000000000000148e54061cd8767a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:35=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > These examples require longer explanations or have explanations that
> > require markup to look reasonable when rendered and so use the longer
> > form of the ".. qmp-example::" directive.
> >
> > By using the :annotated: option, the content in the example block is
> > assumed *not* to be a code block literal and is instead parsed as norma=
l
> > rST - with the exception that any code literal blocks after `::` will
> > assumed to be a QMP code literal block.
> >
> > Note: There's one title-less conversion in this patch that comes along
> > for the ride because it's part of a larger "Examples" block that was
> > better to convert all at once.
> >
> > See commit-5: "docs/qapidoc: create qmp-example directive", for a
> >               detailed explanation of this custom directive syntax.
> >
> > See commit+1: "qapi: remove "Example" doc section" for a detailed
> >               explanation of why.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block.json     | 26 ++++++++++++++++----------
> >  qapi/machine.json   | 30 ++++++++++++++++++++----------
> >  qapi/migration.json |  7 +++++--
> >  qapi/virtio.json    | 24 ++++++++++++++++++------
> >  4 files changed, 59 insertions(+), 28 deletions(-)
> >
> > diff --git a/qapi/block.json b/qapi/block.json
> > index 5ddd061e964..d95e9fd8140 100644
> > --- a/qapi/block.json
> > +++ b/qapi/block.json
> > @@ -545,31 +545,37 @@
> >  #
> >  # Since: 4.0
> >  #
> > -# Example:
> > +# .. qmp-example::
> > +#    :annotated:
> >  #
> > -#     Set new histograms for all io types with intervals
> > -#     [0, 10), [10, 50), [50, 100), [100, +inf):
> > +#    Set new histograms for all io types with intervals
> > +#    [0, 10), [10, 50), [50, 100), [100, +inf)::
> >  #
> >  #     -> { "execute": "block-latency-histogram-set",
> >  #          "arguments": { "id": "drive0",
> >  #                         "boundaries": [10, 50, 100] } }
> >  #     <- { "return": {} }
> >  #
> > -# Example:
> > +# .. qmp-example::
> > +#    :annotated:
> >  #
> > -#     Set new histogram only for write, other histograms will remain
> > -#     not changed (or not created):
> > +#    Set new histogram only for write, other histograms will remain
> > +#    not changed (or not created)::
> >  #
> >  #     -> { "execute": "block-latency-histogram-set",
> >  #          "arguments": { "id": "drive0",
> >  #                         "boundaries-write": [10, 50, 100] } }
> >  #     <- { "return": {} }
> >  #
> > -# Example:
> > +# .. qmp-example::
> > +#    :annotated:
> >  #
> > -#     Set new histograms with the following intervals:
> > -#       read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
> > -#       write: [0, 1000), [1000, 5000), [5000, +inf)
> > +#    Set new histograms with the following intervals:
> > +#
> > +#    - read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
> > +#    - write: [0, 1000), [1000, 5000), [5000, +inf)
> > +#
> > +#    ::
> >  #
> >  #     -> { "execute": "block-latency-histogram-set",
> >  #          "arguments": { "id": "drive0",
>    #                         "boundaries": [10, 50, 100],
>    #                         "boundaries-write": [1000, 5000] } }
>    #     <- { "return": {} }
>    #
>    # .. qmp-example::
>    #    :title: Remove all latency histograms
>    #
>    #     -> { "execute": "block-latency-histogram-set",
>    #          "arguments": { "id": "drive0" } }
>    #     <- { "return": {} }
>    ##
>
> I think using :annotated: for this one as well will look better.
>

Sure, why not. I tried to minimize more complex rewrites as a rule, but
it's no problem to change the styling to taste.


>
> [...]
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
>

--000000000000148e54061cd8767a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 9, 2024 at 7:35=E2=80=AFA=
M Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsno=
w@redhat.com</a>&gt; writes:<br>
<br>
&gt; These examples require longer explanations or have explanations that<b=
r>
&gt; require markup to look reasonable when rendered and so use the longer<=
br>
&gt; form of the &quot;.. qmp-example::&quot; directive.<br>
&gt;<br>
&gt; By using the :annotated: option, the content in the example block is<b=
r>
&gt; assumed *not* to be a code block literal and is instead parsed as norm=
al<br>
&gt; rST - with the exception that any code literal blocks after `::` will<=
br>
&gt; assumed to be a QMP code literal block.<br>
&gt;<br>
&gt; Note: There&#39;s one title-less conversion in this patch that comes a=
long<br>
&gt; for the ride because it&#39;s part of a larger &quot;Examples&quot; bl=
ock that was<br>
&gt; better to convert all at once.<br>
&gt;<br>
&gt; See commit-5: &quot;docs/qapidoc: create qmp-example directive&quot;, =
for a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0detailed explana=
tion of this custom directive syntax.<br>
&gt;<br>
&gt; See commit+1: &quot;qapi: remove &quot;Example&quot; doc section&quot;=
 for a detailed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0explanation of w=
hy.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/block.json=C2=A0 =C2=A0 =C2=A0| 26 ++++++++++++++++--------=
--<br>
&gt;=C2=A0 qapi/machine.json=C2=A0 =C2=A0| 30 ++++++++++++++++++++---------=
-<br>
&gt;=C2=A0 qapi/migration.json |=C2=A0 7 +++++--<br>
&gt;=C2=A0 qapi/virtio.json=C2=A0 =C2=A0 | 24 ++++++++++++++++++------<br>
&gt;=C2=A0 4 files changed, 59 insertions(+), 28 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/block.json b/qapi/block.json<br>
&gt; index 5ddd061e964..d95e9fd8140 100644<br>
&gt; --- a/qapi/block.json<br>
&gt; +++ b/qapi/block.json<br>
&gt; @@ -545,31 +545,37 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 4.0<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. qmp-example::<br>
&gt; +#=C2=A0 =C2=A0 :annotated:<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Set new histograms for all io types with interva=
ls<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0[0, 10), [10, 50), [50, 100), [100, +inf):<br>
&gt; +#=C2=A0 =C2=A0 Set new histograms for all io types with intervals<br>
&gt; +#=C2=A0 =C2=A0 [0, 10), [10, 50), [50, 100), [100, +inf)::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;block-la=
tency-histogram-set&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &qu=
ot;id&quot;: &quot;drive0&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;boundaries&quot;: [10, 50, 100] } }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. qmp-example::<br>
&gt; +#=C2=A0 =C2=A0 :annotated:<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Set new histogram only for write, other histogra=
ms will remain<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0not changed (or not created):<br>
&gt; +#=C2=A0 =C2=A0 Set new histogram only for write, other histograms wil=
l remain<br>
&gt; +#=C2=A0 =C2=A0 not changed (or not created)::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;block-la=
tency-histogram-set&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &qu=
ot;id&quot;: &quot;drive0&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;boundaries-write&quot;: [10, 50, 100] } }<=
br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. qmp-example::<br>
&gt; +#=C2=A0 =C2=A0 :annotated:<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Set new histograms with the following intervals:=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0read, flush: [0, 10), [10, 50), [50, 100)=
, [100, +inf)<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0write: [0, 1000), [1000, 5000), [5000, +i=
nf)<br>
&gt; +#=C2=A0 =C2=A0 Set new histograms with the following intervals:<br>
&gt; +#<br>
&gt; +#=C2=A0 =C2=A0 - read, flush: [0, 10), [10, 50), [50, 100), [100, +in=
f)<br>
&gt; +#=C2=A0 =C2=A0 - write: [0, 1000), [1000, 5000), [5000, +inf)<br>
&gt; +#<br>
&gt; +#=C2=A0 =C2=A0 ::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;block-la=
tency-histogram-set&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &qu=
ot;id&quot;: &quot;drive0&quot;,<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;boundaries&quot;: [10, 50, 100],<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;boundaries-write&quot;: [1000, 5000] }=
 }<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# .. qmp-example::<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 :title: Remove all latency histograms<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;block-=
latency-histogram-set&quot;,<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &=
quot;id&quot;: &quot;drive0&quot; } }<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
=C2=A0 =C2=A0##<br>
<br>
I think using :annotated: for this one as well will look better.<br></block=
quote><div><br></div><div>Sure, why not. I tried to minimize more complex r=
ewrites as a rule, but it&#39;s no problem to change the styling to taste.<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
[...]<br>
<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank">armbru@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--000000000000148e54061cd8767a--


