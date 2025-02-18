Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AC2C021AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 21:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkVHC-0000uL-67; Tue, 18 Feb 2025 16:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkVHA-0000tu-9Q
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:37:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkVH7-0004rO-5r
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739914622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EfO+JZoYCDRXEPvOe7hijxnWLexxdWDM/fYah6FmNxY=;
 b=gCxfc328ojq7DdCQpsl2vUO3QX1Q4vN0TAb/G0FCqYb9k62qvuz2DFpuNVRMdpVW60j9IY
 ksI6XIZjg5mMVMu0wohrpGagzTP0mQDD8oKe2HTH+m1W8C9mnI2ItAuUFOKBsf1hmNMZNJ
 mLbTQdYX6U4yfyw2N2GoGLyeYOO/7To=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-9uqjeGURPfKeQPKe8Rsm_Q-1; Tue, 18 Feb 2025 16:36:59 -0500
X-MC-Unique: 9uqjeGURPfKeQPKe8Rsm_Q-1
X-Mimecast-MFC-AGG-ID: 9uqjeGURPfKeQPKe8Rsm_Q_1739914618
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fc3e239675so12283487a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 13:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739914618; x=1740519418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EfO+JZoYCDRXEPvOe7hijxnWLexxdWDM/fYah6FmNxY=;
 b=WDZB1BkJ900s9kujLOEDUl0YxExLCLe66ZQohpazMVw/wNZuDiDHCu7RJq6UUvVECd
 UK62Esn9ZoHO+ju2riIkxPAsKoWpRj0wFAvdZn3WOJdtEpnnkU2A5C7HS4Y/x//yqcEW
 DvFbMJwIOtvFxdEnghJ21WE5l98DzbIofffWOUIhiuiNec2KVsF7Q6QZJkkzBC/6y1mF
 BY2l3M3rHjnNVo+zpnZlicPQkcMESe2jDx+oDZe77iX7wMCafZ/zLmFw2c2GHs7o2A2h
 VQjNU4cKFCiKJ18H5OiY5OBeEVsMh+OaksfCElfbDW7Etmo5S4LlO0SZLTlXMSuiWJfn
 h85Q==
X-Gm-Message-State: AOJu0Yw8qz8cVb0jEk5+l1BFjBtZfucYsDbxzu9YO5g1I925rHSYRzq1
 9LHP1PZmSM0ZImyOZt8ziONLQmpffRKRxvt3ut72Ji9F0rTeWA1P+bbHoi8hFpifPNQAz56KMIC
 30hTuwyDlPyszYZfJtmVXluALl4jqejmuYKipVQtg/ZkDYQuD+dL21YYED1xtlhkbk0w6k/ZM3Z
 aHmxUUiZZHFDV7tZN9tuhNi71aQj4=
X-Gm-Gg: ASbGncuL5gUkm4ypMBl2LTvYjhhjSFvXiMgSP48wh6VnMAWxsFKOxdnKO2UxXy+W+u3
 d4Nhgl44BJmt70PKg5RxGeSyKXKc/6EJ3Bvc29602o2VMLl5lRLftoT+N601CJFgAr7A97uqUCa
 qFBR45fjNxN5IHm7YauA==
X-Received: by 2002:a17:90b:3809:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-2fc411509b7mr25529745a91.33.1739914617964; 
 Tue, 18 Feb 2025 13:36:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyC+gt9eKq5p87OOq8SPcHCvmiXy/9PTBtV8YLsllJ1Y9zllgJJnUW5tUbcfK8aERrTY+se88GXphOa6L43ME=
X-Received: by 2002:a17:90b:3809:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-2fc411509b7mr25529713a91.33.1739914617613; Tue, 18 Feb 2025
 13:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-29-jsnow@redhat.com>
 <87ed03r0qc.fsf@pond.sub.org>
In-Reply-To: <87ed03r0qc.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Feb 2025 16:36:46 -0500
X-Gm-Features: AWEUYZkL_Q8s6pLqlrSf7JtguM0prCSeDE9knvwS7ty37C5TMfxUXgxjB2lyix4
Message-ID: <CAFn=p-YNBAD66dMScLCrAAAbaJ=KJ8_h-iJJ4BEKVb99DrEogw@mail.gmail.com>
Subject: Re: [PATCH 28/42] qapi/parser: prohibit untagged sections between
 tagged sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
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
Content-Type: multipart/alternative; boundary="000000000000b90222062e71703e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

--000000000000b90222062e71703e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 4:06=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This is being done primarily to ensure consistency between the source
> > documents and the final, rendered HTML output. Because
> > member/feature/returns sections will always appear in a visually groupe=
d
> > element in the HTML output, prohibiting free paragraphs between those
> > sections ensures ordering consistency between source and the final
> > render.
> >
> > Additionally, prohibiting such "middle" text paragraphs allows us to
> > classify all plain text sections as either "intro" or "detail"
> > sections, because these sections must either appear before structured
> > elements ("intro") or afterwards ("detail").
> >
> > This keeps the inlining algorithm simpler with fewer "splice" points
> > when inlining multiple documentation blocks.
>
> Mention the two "middle" paragraphs you have to eliminate in this patch?
>

OK; I will mention that this patch adjusts the source documentation but I
won't go into detail on which. You can read the patch to find out easily
enough.


>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/net.json                   |  4 ++--
> >  qapi/qom.json                   |  4 ++--
> >  scripts/qapi/parser.py          | 16 ++++++++++++++++
> >  tests/qapi-schema/doc-good.json |  4 ++--
> >  tests/qapi-schema/doc-good.out  |  4 ++--
> >  tests/qapi-schema/doc-good.txt  |  8 ++++----
> >  6 files changed, 28 insertions(+), 12 deletions(-)
> >
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 2739a2f4233..49bc7de64e9 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -655,13 +655,13 @@
> >  #     this to zero disables this function.  This member is mutually
> >  #     exclusive with @reconnect.  (default: 0) (Since: 9.2)
> >  #
> > -# Only SocketAddress types 'unix', 'inet' and 'fd' are supported.
> > -#
> >  # Features:
> >  #
> >  # @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
> >  #     instead.
> >  #
> > +# Only SocketAddress types 'unix', 'inet' and 'fd' are supported.
> > +#
> >  # Since: 7.2
> >  ##
> >  { 'struct': 'NetdevStreamOptions',
>
> The text moved applies to member @addr.  You're moving it even farther
> away from @addr.  Move it into @addr instead?  Could be done as a
> separate cleanup patch to keep this one as simple as possible; matter of
> taste.
>

Mmm, I was doing a mechanical hacksaw job here, admittedly. I can do a more
tactful adjustment. I think it should be in this patch in order to preserve
the context of precisely *why* it was juggled around, because I admit in
this one case it is a slight downgrade.

Moving it into @addr.


>
> The same text is in NetdevDgramOptions below, where it applies to both
> @remote and @local.  It just happens to follow @remote and @local
> immediately, because there are no other members and no features.  Hmm.
>
> Ideally, we'd have a way to put such notes next to the stuff they apply
> to without having to rely on happy accidents like "no features".
> Alternatively, have a way to link stuff and note.  Footnotes?  Food for
> thought, not demand.
>

Yes, we discussed this at KVM Forum and I was dreaming of some complicated
solution like "section-details: " or something that allows us to add
amendments to documentation regions that aren't associated with any one
particular member or feature, but can be inserted visually at that point.

I know it's a capability you'd like to preserve, but I think we only use it
once, so I'd be happy to push this off until a bit later and just suffer
the indignity of slightly suboptimal documentation in one spot until then
in exchange for the massive upgrade everywhere else.

What would help a good deal is if you could brainstorm some source syntax
that you think would be pleasant for the purpose, and then for my end I can
worry about how to munge the docutils tree and HTML renderer to make it
happen in some pleasing way.

For now... "Figure out how to add notes or footnotes to the members section
as a whole" added to the "for later" part of my tasklist?


>
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 28ce24cd8d0..11277d1f84c 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -195,12 +195,12 @@
> >  #
> >  # @typename: the type name of an object
> >  #
> > +# Returns: a list of ObjectPropertyInfo describing object properties
> > +#
> >  # .. note:: Objects can create properties at runtime, for example to
> >  #    describe links between different devices and/or objects.  These
> >  #    properties are not included in the output of this command.
> >  #
> > -# Returns: a list of ObjectPropertyInfo describing object properties
> > -#
> >  # Since: 2.12
> >  ##
>
> This move is fine.  Placing notes at the end is more common already.
>
> >  { 'command': 'qom-list-properties',
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index b2f77ffdd7a..c5d2b950a82 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -500,6 +500,20 @@ def get_doc(self) -> 'QAPIDoc':
> >              self.accept(False)
> >              line =3D self.get_doc_line()
> >              have_tagged =3D False
> > +            no_more_tags =3D False
> > +
> > +            def _tag_check(what: str) -> None:
> > +                if what in ('TODO', 'Since'):
> > +                    return
> > +
> > +                if no_more_tags:
> > +                    raise QAPIParseError(
> > +                        self,
> > +                        f"{what!r} section cannot appear after free "
> > +                        "paragraphs that follow other tagged sections.=
 "
> > +                        "Move this section upwards with the preceding =
"
> > +                        "tagged sections."
> > +                    )
>
> Why !r conversion?
>

It just adds quotes so it'll print like: "Returns" section cannot appear
after ...
I thought it looked nicer codewise than: f'"{what}" section cannot appear
after ...'


> Error messages should be a single, short phrase, no punctuation at the
> end.  Sometimes a helpful hint is desirable.  Here's one in expr.py:
>

>         raise QAPISemError(
>             info,
>             "%s has unknown key%s %s\nValid keys are %s."
>             % (source, 's' if len(unknown) > 1 else '',
>                pprint(unknown), pprint(allowed)))
>

Cold day in hell when I successfully remember to omit the punctuation. Will
rephrase and fix.


>
> Needs a negative test case.
>

Yes, I didn't add any new tests because I was being lazy and wanted to see
which things you'd toss out before I had to write them. No reason to do all
that work in advance of review. Please ask for tests wherever you feel they
are required and I'll add them. In this case, I knew you had some qualms
about this patch, so I was hesitant ...


>
> Aside: we should probably convert most string interpolation to f-strings
> en masse at some point.
>

Yeah, just putting it off because the review for that sounds like a hassle
;)
I can do a mechanical conversion to get you started and then let you
finesse it if you want?
We can share the pain.

If you really wanna have a flag day about it, we can just run the black
formatter on everything and get it all over with at once...

later stuff, to be clear.


>
> >
> >              while line is not None:
> >                  # Blank lines
> > @@ -513,6 +527,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                      if doc.features:
> >                          raise QAPIParseError(
> >                              self, "duplicated 'Features:' line")
> > +                    _tag_check("Features")
> >                      self.accept(False)
> >                      line =3D self.get_doc_line()
> >                      while line =3D=3D '':
> > @@ -576,6 +591,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                          )
> >                          raise QAPIParseError(self, emsg)
> >
> > +                    _tag_check(match.group(1))
> >                      doc.new_tagged_section(
> >                          self.info,
> >                          QAPIDoc.Kind.from_string(match.group(1))
> > diff --git a/tests/qapi-schema/doc-good.json
> b/tests/qapi-schema/doc-good.json
> > index f64bf38d854..14b2091b08f 100644
> > --- a/tests/qapi-schema/doc-good.json
> > +++ b/tests/qapi-schema/doc-good.json
> > @@ -157,12 +157,12 @@
> >  # @cmd-feat1: a feature
> >  # @cmd-feat2: another feature
> >  #
> > -# .. note:: @arg3 is undocumented
> > -#
> >  # Returns: @Object
> >  #
> >  # Errors: some
> >  #
> > +# .. note:: @arg3 is undocumented
> > +#
>
> This used to be right next to @arg1 and arg2 (commit 80d1f2e4a5d) until
> commit 79598c8a634 added features in between.  This patch adds more
> stuff there.  Right next is clearly the best spot, but this is just a
> test, so it doesn't really matter.  Related: NetdevDgramOptions' note
> discussed above.
>

So long as it doesn't disturb the point of what is being tested. It's not
always directly clear when adjusting the good doc what precisely is being
tested.


>
> >  # TODO: frobnicate
> >  #
> >  # .. admonition:: Notes
>
> [...]
>
>

--000000000000b90222062e71703e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 12,=
 2025 at 4:06=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This is being done primarily to ensure consistency between the source<=
br>
&gt; documents and the final, rendered HTML output. Because<br>
&gt; member/feature/returns sections will always appear in a visually group=
ed<br>
&gt; element in the HTML output, prohibiting free paragraphs between those<=
br>
&gt; sections ensures ordering consistency between source and the final<br>
&gt; render.<br>
&gt;<br>
&gt; Additionally, prohibiting such &quot;middle&quot; text paragraphs allo=
ws us to<br>
&gt; classify all plain text sections as either &quot;intro&quot; or &quot;=
detail&quot;<br>
&gt; sections, because these sections must either appear before structured<=
br>
&gt; elements (&quot;intro&quot;) or afterwards (&quot;detail&quot;).<br>
&gt;<br>
&gt; This keeps the inlining algorithm simpler with fewer &quot;splice&quot=
; points<br>
&gt; when inlining multiple documentation blocks.<br>
<br>
Mention the two &quot;middle&quot; paragraphs you have to eliminate in this=
 patch?<br></blockquote><div><br></div><div>OK; I will mention that this pa=
tch adjusts the source documentation but I won&#39;t go into detail on whic=
h. You can read the patch to find out easily enough.</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/net.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
&gt;=C2=A0 qapi/qom.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 16 ++=
++++++++++++++<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.json |=C2=A0 4 ++--<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out=C2=A0 |=C2=A0 4 ++--<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.txt=C2=A0 |=C2=A0 8 ++++----<br>
&gt;=C2=A0 6 files changed, 28 insertions(+), 12 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/net.json b/qapi/net.json<br>
&gt; index 2739a2f4233..49bc7de64e9 100644<br>
&gt; --- a/qapi/net.json<br>
&gt; +++ b/qapi/net.json<br>
&gt; @@ -655,13 +655,13 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0this to zero disables this function.=C2=A0 =
This member is mutually<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0exclusive with @reconnect.=C2=A0 (default: =
0) (Since: 9.2)<br>
&gt;=C2=A0 #<br>
&gt; -# Only SocketAddress types &#39;unix&#39;, &#39;inet&#39; and &#39;fd=
&#39; are supported.<br>
&gt; -#<br>
&gt;=C2=A0 # Features:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @deprecated: Member @reconnect is deprecated.=C2=A0 Use @recon=
nect-ms<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0instead.<br>
&gt;=C2=A0 #<br>
&gt; +# Only SocketAddress types &#39;unix&#39;, &#39;inet&#39; and &#39;fd=
&#39; are supported.<br>
&gt; +#<br>
&gt;=C2=A0 # Since: 7.2<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;struct&#39;: &#39;NetdevStreamOptions&#39;,<br>
<br>
The text moved applies to member @addr.=C2=A0 You&#39;re moving it even far=
ther<br>
away from @addr.=C2=A0 Move it into @addr instead?=C2=A0 Could be done as a=
<br>
separate cleanup patch to keep this one as simple as possible; matter of<br=
>
taste.<br></blockquote><div><br></div><div>Mmm, I was doing a mechanical ha=
cksaw job here, admittedly. I can do a more tactful adjustment. I think it =
should be in this patch in order to preserve the context of precisely *why*=
 it was juggled around, because I admit in this one case it is a slight dow=
ngrade.</div><div><br></div><div>Moving it into <a class=3D"gmail_plusreply=
" id=3D"plusReplyChip-2">@addr.</a></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
The same text is in NetdevDgramOptions below, where it applies to both<br>
@remote and @local.=C2=A0 It just happens to follow @remote and @local<br>
immediately, because there are no other members and no features.=C2=A0 Hmm.=
<br>
<br>
Ideally, we&#39;d have a way to put such notes next to the stuff they apply=
<br>
to without having to rely on happy accidents like &quot;no features&quot;.<=
br>
Alternatively, have a way to link stuff and note.=C2=A0 Footnotes?=C2=A0 Fo=
od for<br>
thought, not demand.<br></blockquote><div><br></div><div>Yes, we discussed =
this at KVM Forum and I was dreaming of some complicated solution like &quo=
t;section-details: &quot; or something that allows us to add amendments to =
documentation regions that aren&#39;t associated with any one particular me=
mber or feature, but can be inserted visually at that point.</div><div><br>=
</div><div>I know it&#39;s a capability you&#39;d like to preserve, but I t=
hink we only use it once, so I&#39;d be happy to push this off until a bit =
later and just suffer the indignity of slightly suboptimal documentation in=
 one spot until then in exchange for the massive upgrade everywhere else.</=
div><div><br></div><div>What would help a good deal is if you could brainst=
orm some source syntax that you think would be pleasant for the purpose, an=
d then for my end I can worry about how to munge the docutils tree and HTML=
 renderer to make it happen in some pleasing way.</div><div><br></div><div>=
For now... &quot;Figure out how to add notes or footnotes to the members se=
ction as a whole&quot; added to the &quot;for later&quot; part of my taskli=
st?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt; diff --git a/qapi/qom.json b/qapi/qom.json<br>
&gt; index 28ce24cd8d0..11277d1f84c 100644<br>
&gt; --- a/qapi/qom.json<br>
&gt; +++ b/qapi/qom.json<br>
&gt; @@ -195,12 +195,12 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @typename: the type name of an object<br>
&gt;=C2=A0 #<br>
&gt; +# Returns: a list of ObjectPropertyInfo describing object properties<=
br>
&gt; +#<br>
&gt;=C2=A0 # .. note:: Objects can create properties at runtime, for exampl=
e to<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 describe links between different devices and/or o=
bjects.=C2=A0 These<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 properties are not included in the output of this=
 command.<br>
&gt;=C2=A0 #<br>
&gt; -# Returns: a list of ObjectPropertyInfo describing object properties<=
br>
&gt; -#<br>
&gt;=C2=A0 # Since: 2.12<br>
&gt;=C2=A0 ##<br>
<br>
This move is fine.=C2=A0 Placing notes at the end is more common already.<b=
r>
<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;qom-list-properties&#39;,<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index b2f77ffdd7a..c5d2b950a82 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -500,6 +500,20 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.accept(False)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D self.get_doc_=
line()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 have_tagged =3D False<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_more_tags =3D False<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def _tag_check(what: str) -=
&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if what in (&=
#39;TODO&#39;, &#39;Since&#39;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if no_more_ta=
gs:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 raise QAPIParseError(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 self,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 f&quot;{what!r} section cannot appear after free &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;paragraphs that follow other tagged sections. &quot;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;Move this section upwards with the preceding &quot;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;tagged sections.&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 )<br>
<br>
Why !r conversion?<br></blockquote><div><br></div><div>It just adds quotes =
so it&#39;ll print like: &quot;Returns&quot; section cannot appear after ..=
. <br></div><div>I thought it looked nicer codewise than: f&#39;&quot;{what=
}&quot; section cannot appear after ...&#39;</div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
Error messages should be a single, short phrase, no punctuation at the<br>
end.=C2=A0 Sometimes a helpful hint is desirable.=C2=A0 Here&#39;s one in e=
xpr.py:<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISemError(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s has unknown key%s %s\nVa=
lid keys are %s.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 % (source, &#39;s&#39; if len(unk=
nown) &gt; 1 else &#39;&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pprint(unknown), ppr=
int(allowed)))<br></blockquote><div><br></div><div>Cold day in hell when I =
successfully remember to omit the punctuation. Will rephrase and fix.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Needs a negative test case.<br></blockquote><div><br></div><div>Yes, I didn=
&#39;t add any new tests because I was being lazy and wanted to see which t=
hings you&#39;d toss out before I had to write them. No reason to do all th=
at work in advance of review. Please ask for tests wherever you feel they a=
re required and I&#39;ll add them. In this case, I knew you had some qualms=
 about this patch, so I was hesitant ...</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
Aside: we should probably convert most string interpolation to f-strings<br=
>
en masse at some point.<br></blockquote><div><br></div><div>Yeah, just putt=
ing it off because the review for that sounds like a hassle ;)</div><div>I =
can do a mechanical conversion to get you started and then let you finesse =
it if you want?</div><div>We can share the pain.</div><div><br></div><div>I=
f you really wanna have a flag day about it, we can just run the black form=
atter on everything and get it all over with at once...</div><div><br></div=
><div>later stuff, to be clear.</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while line is not None=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Blank =
lines<br>
&gt; @@ -513,6 +527,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if doc.features:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self, &quot;duplicated &#39;Features:&#3=
9; line&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 _tag_check(&quot;Features&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 self.accept(False)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 line =3D self.get_doc_line()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 while line =3D=3D &#39;&#39;:<br>
&gt; @@ -576,6 +591,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(self, emsg)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 _tag_check(match.group(1))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 doc.new_tagged_section(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer" target=
=3D"_blank">self.info</a>,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 QAPIDoc.Kind.from_string(match.group(1))<br>
&gt; diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-g=
ood.json<br>
&gt; index f64bf38d854..14b2091b08f 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.json<br>
&gt; +++ b/tests/qapi-schema/doc-good.json<br>
&gt; @@ -157,12 +157,12 @@<br>
&gt;=C2=A0 # @cmd-feat1: a feature<br>
&gt;=C2=A0 # @cmd-feat2: another feature<br>
&gt;=C2=A0 #<br>
&gt; -# .. note:: @arg3 is undocumented<br>
&gt; -#<br>
&gt;=C2=A0 # Returns: @Object<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Errors: some<br>
&gt;=C2=A0 #<br>
&gt; +# .. note:: @arg3 is undocumented<br>
&gt; +#<br>
<br>
This used to be right next to @arg1 and arg2 (commit 80d1f2e4a5d) until<br>
commit 79598c8a634 added features in between.=C2=A0 This patch adds more<br=
>
stuff there.=C2=A0 Right next is clearly the best spot, but this is just a<=
br>
test, so it doesn&#39;t really matter.=C2=A0 Related: NetdevDgramOptions&#3=
9; note<br>
discussed above.<br></blockquote><div><br></div><div>So long as it doesn&#3=
9;t disturb the point of what is being tested. It&#39;s not always directly=
 clear when adjusting the good doc what precisely is being tested.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 # TODO: frobnicate<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # .. admonition:: Notes<br>
<br>
[...]<br>
<br>
</blockquote></div></div>

--000000000000b90222062e71703e--


