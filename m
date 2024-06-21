Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D89C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiH0-0004hd-Lb; Fri, 21 Jun 2024 13:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKiGw-0004gj-UI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKiGu-000184-AV
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718991719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlaS7F1hMhUuHNv4SVVW+Ko4I+RNQfRiPnBUujgq4/E=;
 b=URv3ELUo8TfK2AtNLzAtXWbnEO3Byox+sh7jShBZXM5f14r6OZJI3+QKFiQ1qEnQgd66FH
 nUr17kZUXGupUhTMj6Lv3WUlNm9FBqaCWcBoxj602CQF6H+HWFnIx5lIwy/Wob3H9MR8Sb
 GMLcGNDVXsasS61lQ2ZNx0Ovm9tK8x0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-RGD3phu5NwysrYMAcoH5yA-1; Fri, 21 Jun 2024 13:41:56 -0400
X-MC-Unique: RGD3phu5NwysrYMAcoH5yA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c8066074b5so1147606a91.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 10:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718991715; x=1719596515;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HlaS7F1hMhUuHNv4SVVW+Ko4I+RNQfRiPnBUujgq4/E=;
 b=o78wQ/o4HH3ZiNDu6g1tu0kwNRfYsO6ZHBPabwgVcCWDhSeNe6Wp892wuYXbVPy77R
 F/aVqMLsCp+9j4AYMNwlFDoRCNDQ3MN8IFxEyDd+WR+Mx0w12dY4tTorDh0koKUGNcaj
 zdmAnDi/ykRyegzSgZ5xbVfOb/W9gvSCAmMFhJpN4yW6zi9fmJXKefkiEQgrmB0Hc3jZ
 4RUFZ+CbNQ34iQWxGpbKR1FUpEY+r85LSS9ehfB41vURR5TrTDJVHz1CqVO4h1+MgAdY
 3CM18iA5DVMLBTifAneMpsZmT+pwNmIS3JhGv3vCHMSwTLSR6zwzZZ/kfqwYHjM0Y2P1
 TGzw==
X-Gm-Message-State: AOJu0YxFDrZvjPySCcVwqR4BpBTT5j9Vm8++Pen7/pbMpwKrW14QY6jk
 pxu/v43Fh0jSjM2FVcQQoayeBQY+NlBm/Os/pvh0VriJSL+ghjPeEH+bN3IhJ5CPEGqD+q5+D8k
 5K8c+h3y96OS7ZavAAsFPQ4yDexYUjK//NLQpQFyMa7Turs5DmeUtyZfPJNUi+zJEtCwdCIUPBj
 DZ3SmXeBd1JMzgZsP3YbK78AiNHlo=
X-Received: by 2002:a17:90a:17a2:b0:2c2:c6c8:8fc with SMTP id
 98e67ed59e1d1-2c83c1b3eafmr581432a91.2.1718991715320; 
 Fri, 21 Jun 2024 10:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbgFlm7RSOgkxaEzufMv6I4kNVSflmoV1Lfc0uyDVbIO+qFyEu1kOW1GIA58rjakdxNDfk5/o1GuHzfeks+JU=
X-Received: by 2002:a17:90a:17a2:b0:2c2:c6c8:8fc with SMTP id
 98e67ed59e1d1-2c83c1b3eafmr581382a91.2.1718991714887; Fri, 21 Jun 2024
 10:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
 <87wmmlyu64.fsf@pond.sub.org> <87iky3u47v.fsf@pond.sub.org>
 <CAFn=p-ZDQog-gS=oXPm2E+uQwa=AFodxP-TTCtLrXiOou3-McQ@mail.gmail.com>
 <CAFn=p-abtycUzRefg8hdAENtdKMeeyEe0sMCEXee2Grn9i8PDw@mail.gmail.com>
 <87v8221o3x.fsf@pond.sub.org>
In-Reply-To: <87v8221o3x.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 21 Jun 2024 13:41:43 -0400
Message-ID: <CAFn=p-bsEzEr6Ww11gtoBws1LqSHTPmch4O7osOqg45=CtejPw@mail.gmail.com>
Subject: Re: [PATCH 09/13] qapi: convert "Note" sections to plain rST
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
Content-Type: multipart/alternative; boundary="00000000000089c209061b69f23b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

--00000000000089c209061b69f23b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 8:23=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, Jun 20, 2024 at 11:46=E2=80=AFAM John Snow <jsnow@redhat.com> w=
rote:
> >
> >>
> >>
> >> On Thu, Jun 20, 2024, 9:35=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com>
> wrote:
> >>
> >>> Markus Armbruster <armbru@redhat.com> writes:
> >>>
> >>> > John Snow <jsnow@redhat.com> writes:
> >>>
> >>> [...]
> >>>
> >>> >> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> >>> >> index b3de1fb6b3a..57598331c5c 100644
> >>> >> --- a/qga/qapi-schema.json
> >>> >> +++ b/qga/qapi-schema.json
> >>>
> >>> [...]
> >>>
> >>> >> @@ -631,8 +632,8 @@
> >>> >>  # Errors:
> >>> >>  #     - If hybrid suspend is not supported, Unsupported
> >>> >>  #
> >>> >> -# Notes: It's strongly recommended to issue the guest-sync comman=
d
> >>> >> -#     before sending commands when the guest resumes
> >>> >> +# .. note:: It's strongly recommended to issue the guest-sync
> command
> >>> >> +#    before sending commands when the guest resumes.
> >>> >>  #
> >>> >>  # Since: 1.1
> >>> >>  ##
> >>> >> @@ -1461,16 +1462,15 @@
> >>> >>  #     * POSIX: as defined by os-release(5)
> >>> >>  #     * Windows: contains string "server" or "client"
> >>> >>  #
> >>> >> -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
> >>> >> -#     @version, @version-id, @variant and @variant-id follow the
> >>> >> -#     definition specified in os-release(5). Refer to the manual
> page
> >>> >> -#     for exact description of the fields.  Their values are take=
n
> >>> >> -#     from the os-release file.  If the file is not present in th=
e
> >>> >> -#     system, or the values are not present in the file, the fiel=
ds
> >>> >> -#     are not included.
> >>> >> +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
> >>> >> +#    @version, @version-id, @variant and @variant-id follow the
> >>> >> +#    definition specified in os-release(5). Refer to the manual
> page
> >>> for
> >>> >> +#    exact description of the fields.  Their values are taken fro=
m
> the
> >>> >> +#    os-release file.  If the file is not present in the system, =
or
> >>> the
> >>> >> +#    values are not present in the file, the fields are not
> included.
> >>> >>  #
> >>> >> -#     On Windows the values are filled from information gathered
> from
> >>> >> -#     the system.
> >>> >> +#    On Windows the values are filled from information gathered
> from
> >>> >> +#    the system.
> >>> >
> >>> > Please don't change the indentation here.  I get the same output wi=
th
> >>> >
> >>> >   @@ -1461,7 +1462,7 @@
> >>> >    #     * POSIX: as defined by os-release(5)
> >>> >    #     * Windows: contains string "server" or "client"
> >>> >    #
> >>> >   -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
> >>> >   +# .. note:: On POSIX systems the fields @id, @name, @pretty-name=
,
> >>> >    #     @version, @version-id, @variant and @variant-id follow the
> >>> >    #     definition specified in os-release(5). Refer to the manual
> page
> >>> >    #     for exact description of the fields.  Their values are tak=
en
> >>>
> >>> I'm blind.  Actually, you change indentation of subsequent lines from=
 4
> >>> to 3 *everywhere*.  I guess you do that to make subsequent lines line
> up
> >>> with the directive, here "note".
> >>>
> >>> Everywhere else, we indent such lines by 4.  Hmm.  How terrible would
> it
> >>> be not to mess with the alignment?
> >>>
> >>> If we want to use 3 for directives, is it worth pointing out in the
> >>> commit message?
> >>>
> >>> [...]
> >>>
> >>
> >> Let me look up some conventions and see what's the most prominent... a=
s
> >> well as testing what emacs does by default (or if emacs can be
> configured
> >> to do what we want with in-tree style config. Warning: I am functional=
ly
> >> inept at emacs lisp. Warning 2x: [neo]vi[m] users, you're entirely on
> your
> >> own. I'm sorry.)
> >>
> >> I use three myself by force of habit and have some mild reluctance to
> >> respin for that reason, but ... guess we ought to be consistent if we
> can.
> >>
> >> (No idea where my habit came from. Maybe it is just because it looks
> nice
> >> to me and no other reason.)
> >>
> >> ((I have no plans, nor desire, to write any kind of checker to enforce
> >> this, though - sorry.))
> >>
> >
> > Sphinx doc uses three spaces:
> >
> https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#d=
irectives
> >
> > ... but it warns that it's arbitrary; but it seems common to align with
> the
> > directive.
> >
> > *
> >
> https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#footno=
tes
> >    footnotes require "at least 3" spaces
> >
> > *
> >
> https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#direct=
ives
> >   directives are only required to be "indented" but the amount isn't
> > specified. rst docs use three.
> >
> > I'm happy with three; I don't believe we need to make it consistent wit=
h
> > e.g. our home-spun field list syntax (arguments, features) or with code
> > blocks. I think whatever looks good in the source is fine, and I think
> > three looks good for directives. I don't think we need to require this,
> but
> > I can mention in the commit message that I chose it for the sake of
> > aesthetics and for parity with what most rST docs appear to use.
>
> My reason for four spaces is reducing churn.  To see by how much, I
> redid your change.  I found a few more notes that don't start with a
> capital letter, or don't end with a period.
>

^ Guess I'll re-audit for v2. Hang on to the list of cases you found.

(Sorry for the churn, though. I obviously don't mind it as much as you do,
but I suspect I'm a lot less nimble with fiddling through git history than
you are and find the value of avoiding churn to be ... lower than you do,
in general. Respecting reviewer time is a strong argument, I apologize that
some non-mechanical changes snuck into the patch. The downside of hacking
together a very large series.)


>
> Anyway, your diffstat:
>
>  30 files changed, 266 insertions(+), 255 deletions(-)
>
> Mine:
>
>  30 files changed, 134 insertions(+), 119 deletions(-)
>
> A fair bit easier to review.
>
> > Note: emacs behavior for wrapping paragraphs in our QAPI files does not
> > create an indent if there isn't already one. I think convincing emacs t=
o
> > apply rST rules inside of a JSON file we lie and call a Python file mig=
ht
> > be beyond my ability to do quickly.
>
> Permit me a digression...
>
> We have rST in comments.
>
> Python has rST in doc strings.
>
> JSON has neither comments nor doc strings, but since we use it just for
> the file name extension, that's irrelevant.
>
> Could Emacs help us more if we used Pythony doc strings instead of
> comments?
>

No idea. Could it? O:-)

(OK, OK, let me see...)

No, apparently not.


> End of digression.
>
> > The default behavior for my emacs (which I haven't customized very much=
,
> if
> > at all) in our source tree for *.rst files is to wrap directive lines
> with
> > a three space indent.
>
> Valid point.
>
> > So, I'm happy saying this is a good way to do it.
>
> If we decide to tweak indentation, we should do so in a separate patch
> that does absolutely nothing but tweak indentation.
>

I'd rather not spend all my time undoing and then redoing this patch for
the benefit of burying git history behind *two* mass-change patches,
please...

--00000000000089c209061b69f23b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 21, 2024 at 8:23=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsn=
ow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Jun 20, 2024 at 11:46=E2=80=AFAM John Snow &lt;<a href=3D"mail=
to:jsnow@redhat.com" target=3D"_blank">jsnow@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Jun 20, 2024, 9:35=E2=80=AFAM Markus Armbruster &lt;<a hre=
f=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; =
wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank">armbru@redhat.com</a>&gt; writes:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [...]<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.j=
son<br>
&gt;&gt;&gt; &gt;&gt; index b3de1fb6b3a..57598331c5c 100644<br>
&gt;&gt;&gt; &gt;&gt; --- a/qga/qapi-schema.json<br>
&gt;&gt;&gt; &gt;&gt; +++ b/qga/qapi-schema.json<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [...]<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; @@ -631,8 +632,8 @@<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 # Errors:<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If hybrid suspend is not=
 supported, Unsupported<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 #<br>
&gt;&gt;&gt; &gt;&gt; -# Notes: It&#39;s strongly recommended to issue the =
guest-sync command<br>
&gt;&gt;&gt; &gt;&gt; -#=C2=A0 =C2=A0 =C2=A0before sending commands when th=
e guest resumes<br>
&gt;&gt;&gt; &gt;&gt; +# .. note:: It&#39;s strongly recommended to issue t=
he guest-sync command<br>
&gt;&gt;&gt; &gt;&gt; +#=C2=A0 =C2=A0 before sending commands when the gues=
t resumes.<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 #<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 # Since: 1.1<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 ##<br>
&gt;&gt;&gt; &gt;&gt; @@ -1461,16 +1462,15 @@<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0* POSIX: as defined by os-=
release(5)<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0* Windows: contains string=
 &quot;server&quot; or &quot;client&quot;<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 #<br>
&gt;&gt;&gt; &gt;&gt; -# Notes: On POSIX systems the fields @id, @name, @pr=
etty-name,<br>
&gt;&gt;&gt; &gt;&gt; -#=C2=A0 =C2=A0 =C2=A0@version, @version-id, @variant=
 and @variant-id follow the<br>
&gt;&gt;&gt; &gt;&gt; -#=C2=A0 =C2=A0 =C2=A0definition specified in os-rele=
ase(5). Refer to the manual page<br>
&gt;&gt;&gt; &gt;&gt; -#=C2=A0 =C2=A0 =C2=A0for exact description of the fi=
elds.=C2=A0 Their values are taken<br>
&gt;&gt;&gt; &gt;&gt; -#=C2=A0 =C2=A0 =C2=A0from the os-release file.=C2=A0=
 If the file is not present in the<br>
&gt;&gt;&gt; &gt;&gt; -#=C2=A0 =C2=A0 =C2=A0system, or the values are not p=
resent in the file, the fields<br>
&gt;&gt;&gt; &gt;&gt; -#=C2=A0 =C2=A0 =C2=A0are not included.<br>
&gt;&gt;&gt; &gt;&gt; +# .. note:: On POSIX systems the fields @id, @name, =
@pretty-name,<br>
&gt;&gt;&gt; &gt;&gt; +#=C2=A0 =C2=A0 @version, @version-id, @variant and @=
variant-id follow the<br>
&gt;&gt;&gt; &gt;&gt; +#=C2=A0 =C2=A0 definition specified in os-release(5)=
. Refer to the manual page<br>
&gt;&gt;&gt; for<br>
&gt;&gt;&gt; &gt;&gt; +#=C2=A0 =C2=A0 exact description of the fields.=C2=
=A0 Their values are taken from the<br>
&gt;&gt;&gt; &gt;&gt; +#=C2=A0 =C2=A0 os-release file.=C2=A0 If the file is=
 not present in the system, or<br>
&gt;&gt;&gt; the<br>
&gt;&gt;&gt; &gt;&gt; +#=C2=A0 =C2=A0 values are not present in the file, t=
he fields are not included.<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 #<br>
&gt;&gt;&gt; &gt;&gt; -#=C2=A0 =C2=A0 =C2=A0On Windows the values are fille=
d from information gathered from<br>
&gt;&gt;&gt; &gt;&gt; -#=C2=A0 =C2=A0 =C2=A0the system.<br>
&gt;&gt;&gt; &gt;&gt; +#=C2=A0 =C2=A0 On Windows the values are filled from=
 information gathered from<br>
&gt;&gt;&gt; &gt;&gt; +#=C2=A0 =C2=A0 the system.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Please don&#39;t change the indentation here.=C2=A0 I get=
 the same output with<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0@@ -1461,7 +1462,7 @@<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0* POSIX: as defined by =
os-release(5)<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0* Windows: contains str=
ing &quot;server&quot; or &quot;client&quot;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 #<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0-# Notes: On POSIX systems the fields @id, @n=
ame, @pretty-name,<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0+# .. note:: On POSIX systems the fields @id,=
 @name, @pretty-name,<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0@version, @version-id, =
@variant and @variant-id follow the<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0definition specified in=
 os-release(5). Refer to the manual page<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0for exact description o=
f the fields.=C2=A0 Their values are taken<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;m blind.=C2=A0 Actually, you change indentation of subse=
quent lines from 4<br>
&gt;&gt;&gt; to 3 *everywhere*.=C2=A0 I guess you do that to make subsequen=
t lines line up<br>
&gt;&gt;&gt; with the directive, here &quot;note&quot;.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Everywhere else, we indent such lines by 4.=C2=A0 Hmm.=C2=A0 H=
ow terrible would it<br>
&gt;&gt;&gt; be not to mess with the alignment?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If we want to use 3 for directives, is it worth pointing out i=
n the<br>
&gt;&gt;&gt; commit message?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [...]<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Let me look up some conventions and see what&#39;s the most promin=
ent... as<br>
&gt;&gt; well as testing what emacs does by default (or if emacs can be con=
figured<br>
&gt;&gt; to do what we want with in-tree style config. Warning: I am functi=
onally<br>
&gt;&gt; inept at emacs lisp. Warning 2x: [neo]vi[m] users, you&#39;re enti=
rely on your<br>
&gt;&gt; own. I&#39;m sorry.)<br>
&gt;&gt;<br>
&gt;&gt; I use three myself by force of habit and have some mild reluctance=
 to<br>
&gt;&gt; respin for that reason, but ... guess we ought to be consistent if=
 we can.<br>
&gt;&gt;<br>
&gt;&gt; (No idea where my habit came from. Maybe it is just because it loo=
ks nice<br>
&gt;&gt; to me and no other reason.)<br>
&gt;&gt;<br>
&gt;&gt; ((I have no plans, nor desire, to write any kind of checker to enf=
orce<br>
&gt;&gt; this, though - sorry.))<br>
&gt;&gt;<br>
&gt;<br>
&gt; Sphinx doc uses three spaces:<br>
&gt; <a href=3D"https://www.sphinx-doc.org/en/master/usage/restructuredtext=
/basics.html#directives" rel=3D"noreferrer" target=3D"_blank">https://www.s=
phinx-doc.org/en/master/usage/restructuredtext/basics.html#directives</a><b=
r>
&gt;<br>
&gt; ... but it warns that it&#39;s arbitrary; but it seems common to align=
 with the<br>
&gt; directive.<br>
&gt;<br>
&gt; *<br>
&gt; <a href=3D"https://docutils.sourceforge.io/docs/ref/rst/restructuredte=
xt.html#footnotes" rel=3D"noreferrer" target=3D"_blank">https://docutils.so=
urceforge.io/docs/ref/rst/restructuredtext.html#footnotes</a><br>
&gt;=C2=A0 =C2=A0 footnotes require &quot;at least 3&quot; spaces<br>
&gt;<br>
&gt; *<br>
&gt; <a href=3D"https://docutils.sourceforge.io/docs/ref/rst/restructuredte=
xt.html#directives" rel=3D"noreferrer" target=3D"_blank">https://docutils.s=
ourceforge.io/docs/ref/rst/restructuredtext.html#directives</a><br>
&gt;=C2=A0 =C2=A0directives are only required to be &quot;indented&quot; bu=
t the amount isn&#39;t<br>
&gt; specified. rst docs use three.<br>
&gt;<br>
&gt; I&#39;m happy with three; I don&#39;t believe we need to make it consi=
stent with<br>
&gt; e.g. our home-spun field list syntax (arguments, features) or with cod=
e<br>
&gt; blocks. I think whatever looks good in the source is fine, and I think=
<br>
&gt; three looks good for directives. I don&#39;t think we need to require =
this, but<br>
&gt; I can mention in the commit message that I chose it for the sake of<br=
>
&gt; aesthetics and for parity with what most rST docs appear to use.<br>
<br>
My reason for four spaces is reducing churn.=C2=A0 To see by how much, I<br=
>
redid your change.=C2=A0 I found a few more notes that don&#39;t start with=
 a<br>
capital letter, or don&#39;t end with a period.<br></blockquote><div><br></=
div><div>^ Guess I&#39;ll re-audit for v2. Hang on to the list of cases you=
 found.</div><div><br></div><div>(Sorry for the churn, though. I obviously =
don&#39;t mind it as much as you do, but I suspect I&#39;m a lot less nimbl=
e with fiddling through git history than you are and find the value of avoi=
ding churn to be ... lower than you do, in general. Respecting reviewer tim=
e is a strong argument, I apologize that some non-mechanical changes snuck =
into the patch. The downside of hacking together a very large series.)<br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Anyway, your diffstat:<br>
<br>
=C2=A030 files changed, 266 insertions(+), 255 deletions(-)<br>
<br>
Mine:<br>
<br>
=C2=A030 files changed, 134 insertions(+), 119 deletions(-)<br>
<br>
A fair bit easier to review.<br>
<br>
&gt; Note: emacs behavior for wrapping paragraphs in our QAPI files does no=
t<br>
&gt; create an indent if there isn&#39;t already one. I think convincing em=
acs to<br>
&gt; apply rST rules inside of a JSON file we lie and call a Python file mi=
ght<br>
&gt; be beyond my ability to do quickly.<br>
<br>
Permit me a digression...<br>
<br>
We have rST in comments.<br>
<br>
Python has rST in doc strings.<br>
<br>
JSON has neither comments nor doc strings, but since we use it just for<br>
the file name extension, that&#39;s irrelevant.<br>
<br>
Could Emacs help us more if we used Pythony doc strings instead of<br>
comments?<br></blockquote><div><br></div><div>No idea. Could it? O:-)</div>=
<div><br></div><div>(OK, OK, let me see...)</div><div><br></div><div>No, ap=
parently not.<br></div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
End of digression.<br>
<br>
&gt; The default behavior for my emacs (which I haven&#39;t customized very=
 much, if<br>
&gt; at all) in our source tree for *.rst files is to wrap directive lines =
with<br>
&gt; a three space indent.<br>
<br>
Valid point.<br>
<br>
&gt; So, I&#39;m happy saying this is a good way to do it.<br>
<br>
If we decide to tweak indentation, we should do so in a separate patch<br>
that does absolutely nothing but tweak indentation.<br></blockquote><div><b=
r></div><div>I&#39;d rather not spend all my time undoing and then redoing =
this patch for the benefit of burying git history behind *two* mass-change =
patches, please... <br></div></div></div>

--00000000000089c209061b69f23b--


