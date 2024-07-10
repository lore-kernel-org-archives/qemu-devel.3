Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA9FC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRYb4-0007jU-94; Wed, 10 Jul 2024 10:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sRYb0-0007eD-Jt
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sRYav-0001Vk-Qh
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720622816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iw5wX2rpsZl5GUb2spQPJ7II/il/Yn/k7IAkkXxKaGI=;
 b=Gao3PEAda7JV0M89BLE/MUeNyFSbB/Z1wouOsorh8SPvEm6wgK3ctUZEox5DiBkMEhvCI7
 R7xe7kyuFd/XlVM/D6QD/WkOmtuXQukGnQpUOTbmQzNyvovicUKgW6FaX8Kkqhj9Amj6JU
 eRTfYUveBtKi/ZrFBifF37bn66oZk6w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-4DivWGboOcWgRcuPOjg6Rg-1; Wed, 10 Jul 2024 10:46:54 -0400
X-MC-Unique: 4DivWGboOcWgRcuPOjg6Rg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c99c1075c9so4984887a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622813; x=1721227613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iw5wX2rpsZl5GUb2spQPJ7II/il/Yn/k7IAkkXxKaGI=;
 b=jS0bDjK4KtaKH79n271QTgqn/9zRoAkXktJ6j8QrodBkXKqQmiW9oHl3FtpAjBPlqO
 KVuq/o/VBTZRE0buiKson7pbzZgvmQesIFBES2zO3S0NbFD7X6cJ6DrU+rTRXZ6hz0FU
 fOJyb7Kpci+cIN2E7GKngw1ZEwIe8hcfHwoE0QOg5h+LroZrXNKUN8rYITRFP723hyaS
 kSB4KLl3J6xFB1dtGsNDe6AG02GcRYujfEUr5b6uKKhsuIrUxQv0W+vV2Hea6gqJMHQ6
 zvB7+iQElaDhXF/w3I6JAS1KJPW8ms50dtzvQiK3q3vvOCGPxZvxlqsCN6hFOosRaCaH
 npTw==
X-Gm-Message-State: AOJu0YyIJMoHuP5Sgf12b8O6V1gfIEo7e/mrMCKxnUeJ7i4KazxYSZkl
 JUBCi/+X91aVDi/XGZZuIzd+urJyOIyRXMNSA8DBGKBiTT7LgMvopXYmBHhNgKfgPusGdI76xuE
 9VgGbkG10Bz5iV/abSgVOidoUyM1EiHDYa5+mF/+xbhbOBK6+5DWFJuOwsV6NowgJ6Cn/7l7qrW
 RW6qoeMW7ZQ53KjYaLen7tRUyapxQ=
X-Received: by 2002:a17:90b:68c:b0:2c9:5ecd:e3c5 with SMTP id
 98e67ed59e1d1-2ca35d3c6c1mr4159913a91.33.1720622813313; 
 Wed, 10 Jul 2024 07:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBQLXUTNvXtNAnQK/1dsll8y4A2VeZ74QJDUgzBS3DdSmYCqEMZgeglH7tCZ2URMjJbSOl4JuxgFWkNdBdAk8=
X-Received: by 2002:a17:90b:68c:b0:2c9:5ecd:e3c5 with SMTP id
 98e67ed59e1d1-2ca35d3c6c1mr4159877a91.33.1720622812867; Wed, 10 Jul 2024
 07:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-9-jsnow@redhat.com>
 <87sewihm6k.fsf@pond.sub.org>
 <CAFn=p-b6SDEpeN3rJc_g6puUR5RmP5CfxUb7bdy3pQRhsvmytQ@mail.gmail.com>
 <87frshajhm.fsf@pond.sub.org>
In-Reply-To: <87frshajhm.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 10 Jul 2024 10:46:40 -0400
Message-ID: <CAFn=p-Z35twCnvxo3HnYd6vRy7JfoSd8AQsx41UAE36V4BemLg@mail.gmail.com>
Subject: Re: [PATCH 8/8] qapi: remove "Example" doc section
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
Content-Type: multipart/alternative; boundary="0000000000008dd02f061ce5b7f4"
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

--0000000000008dd02f061ce5b7f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:45=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Tue, Jul 9, 2024 at 6:52=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > Fully eliminate the "Example" sections in QAPI doc blocks now that
> they
> >> > have all been converted to arbitrary rST syntax using the
> >> > ".. qmp-example::" directive. Update tests to match.
> >> >
> >> > Migrating to the new syntax
> >> > ---------------------------
> >> >
> >> > The old "Example:" or "Examples:" section syntax is now caught as an
> >> > error, but "Example::" is stil permitted as explicit rST syntax for =
an
> >> > un-lexed, generic preformatted text block.
> >> >
> >> > ('Example' is not special in this case, any sentence that ends with
> "::"
> >> > will start an indented code block in rST.)
> >> >
> >> > Arbitrary rST for Examples is now possible, but it's strongly
> >> > recommended that documentation authors use the ".. qmp-example::"
> >> > directive for consistent visual formatting in rendered HTML docs. Th=
e
> >> > ":title:" directive option may be used to add extra information into
> the
> >> > title bar for the example. The ":annotated:" option can be used to
> write
> >> > arbitrary rST instead, with nested "::" blocks applying QMP formatti=
ng
> >> > where desired.
> >> >
> >> > Other choices available are ".. code-block:: QMP" which will not
> create
> >> > an "Example:" box, or the short-form "::" code-block syntax which wi=
ll
> >> > not apply QMP highlighting when used outside of the qmp-example
> >> > directive.
> >> >
> >> > Why?
> >> > ----
> >> >
> >> > This patch has several benefits:
> >> >
> >> > 1. Example sections can now be written more arbitrarily, mixing
> >> >    explanatory paragraphs and code blocks however desired.
> >> >
> >> > 2. Example sections can now use fully arbitrary rST.
> >> >
> >> > 3. All code blocks are now lexed and validated as QMP; increasing
> >> >    usability of the docs and ensuring validity of example snippets.
> >> >
> >> >    (To some extent - This patch only gaurantees it lexes correctly,
> not
> >> >    that it's valid under the JSON or QMP grammars. It will catch mos=
t
> >> >    small mistakes, however.)
> >> >
> >> > 4. Each qmp-example can be titled or annotated independently without
> >> >    bypassing the QMP lexer/validator.
> >> >
> >> >    (i.e. code blocks are now for *code* only, so we don't have to
> >> >    sacrifice exposition for having lexically valid examples.)
> >> >
> >> > NOTE: As with the "Notes" conversion patch,
> >>
> >> Commit d461c279737 (qapi: convert "Note" sections to plain rST).
> >>
> >
> > Didn't have a stable commit ID at the time, will work it in if/when the
> > notes patches hit main.
>
> They have.
>
> >> >                                             this patch (and those
> >> >       preceding) may change the rendering order for Examples in the
> >>
> >> The three preceding ones, to be precise.
> >>
> >> >       current generator. The forthcoming qapidoc rewrite will fix th=
is
> >> >       by always generating documentation in source order.
> >>
> >> Conversions from "Example" section to plain reST may change order.  Th=
is
> >> patch converts a test, and the preceding three convert the real uses.
> >>
> >> Does any of the patches actually change order?
> >
> > I do not actually know ...! It has the *potential* in the same exact wa=
y
> > that the notes patch did, but I don't actually know if it *did*. My hun=
ch
> > is "no" because there's only one intermediate section we identified wit=
h
> > the notes series, but I didn't exhaustively prove it. That's why I used
> the
> > "may" weasel wording.
>
> Alright, I checked.
>
> In documentation of command announce-self, the example moves from after
> the arguments to before.  Unwanted change.
>
> I can keep it in place if I insert a TODO before the example like this:
>
>     diff --git a/qapi/net.json b/qapi/net.json
>     index 9a723e56b5..50bfd5b681 100644
>     --- a/qapi/net.json
>     +++ b/qapi/net.json
>     @@ -930,6 +930,8 @@
>      # switches.  This can be useful when network bonds fail-over the
>      # active slave.
>      #
>     +# TODO: This line is a hack to separate the example from the body
>     +#
>      # .. qmp-example::
>      #
>      #     -> { "execute": "announce-self",
>
> I had to delete the .doctrees cache to make sphinx-build generate
> corrected output.
>
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  docs/devel/qapi-code-gen.rst    | 58
> ++++++++++++++++++++++++++++-----
> >> >  scripts/qapi/parser.py          | 10 +++++-
> >> >  tests/qapi-schema/doc-good.json | 19 +++++++----
> >> >  tests/qapi-schema/doc-good.out  | 26 ++++++++++-----
> >> >  tests/qapi-schema/doc-good.txt  | 23 ++++++-------
> >> >  5 files changed, 98 insertions(+), 38 deletions(-)
> >> >
> >> > diff --git a/docs/devel/qapi-code-gen.rst
> b/docs/devel/qapi-code-gen.rst
> >> > index ae97b335cbf..2e10a3cbd69 100644
> >> > --- a/docs/devel/qapi-code-gen.rst
> >> > +++ b/docs/devel/qapi-code-gen.rst
> >> > @@ -899,7 +899,7 @@ Documentation markup
> >> >  ~~~~~~~~~~~~~~~~~~~~
> >> >
> >> >  Documentation comments can use most rST markup.  In particular,
> >> > -a ``::`` literal block can be used for examples::
> >> > +a ``::`` literal block can be used for pre-formatted text::
> >> >
> >> >      # ::
> >> >      #
> >> > @@ -995,8 +995,8 @@ line "Features:", like this::
> >> >    # @feature: Description text
> >> >
> >> >  A tagged section begins with a paragraph that starts with one of th=
e
> >> > -following words: "Since:", "Example:"/"Examples:", "Returns:",
> >> > -"Errors:", "TODO:".  It ends with the start of a new section.
> >> > +following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends
> with
> >> > +the start of a new section.
> >> >
> >> >  The second and subsequent lines of tagged sections must be indented
> >> >  like this::
> >> > @@ -1020,13 +1020,53 @@ detailing a relevant error condition. For
> >> example::
> >> >  A "Since: x.y.z" tagged section lists the release that introduced t=
he
> >> >  definition.
> >> >
> >> > -An "Example" or "Examples" section is rendered entirely
> >> > -as literal fixed-width text.  "TODO" sections are not rendered at a=
ll
> >> > -(they are for developers, not users of QMP).  In other sections, th=
e
> >> > -text is formatted, and rST markup can be used.
> >> > +"TODO" sections are not rendered at all (they are for developers, n=
ot
> >>
> >> Drop "at all"?
> >>
> >
> > Sure.
> >
> >
> >>
> >> > +users of QMP).  In other sections, the text is formatted, and rST
> markup
> >> > +can be used.
> >> > +
> >> > +QMP Examples can be added by using the ``.. qmp-example::``
> >> > +directive. In its simplest form, this can be used to contain a sing=
le
> >> > +QMP code block which accepts standard JSON syntax with additional
> server
> >> > +directionality indicators (``->`` and ``<-``), and elisions
> (``...``).
> >> > +
> >> > +Optionally, a plaintext title may be provided by using the
> ``:title:``
> >> > +directive option. If the title is omitted, the example title will
> >> > +default to "Example:".
> >> > +
> >> > +A simple QMP example::
> >> > +
> >> > +  # .. qmp-example::
> >> > +  #    :title: Using query-block
> >> > +  #
> >> > +  #    -> { "execute": "query-block" }
> >> > +  #    <- { ... }
> >> > +
> >> > +More complex or multi-step examples where exposition is needed
> before or
> >> > +between QMP code blocks can be created by using the ``:annotated:``
> >> > +directive option. When using this option, nested QMP code blocks
> must be
> >> > +entered explicitly with rST's ``::`` syntax.
> >>
> >
> > Telling on myself: you can use .. code-block:: QMP too, but I figured
> > recommending "::" was shorter and sweeter. There are lots of minutiae
> here
> > for people who haven't spent a long time reading and writing rST, so I
> > tried to keep it short.
>
> Makes sense.
>
> >> > +
> >> > +Highlighting in non-QMP languages can be accomplished by using the
> >> > +``.. code-block:: lang`` directive, and non-highlighted text can be
> >> > +achieved by omitting the language argument.
> >> >
> >> >  For example::
> >> >
> >> > +  # .. qmp-example::
> >> > +  #    :annotated:
> >> > +  #    :title: A more complex demonstration
> >> > +  #
> >> > +  #    This is a more complex example that can use
> >> > +  #    ``arbitrary rST syntax`` in its exposition::
> >> > +  #
> >> > +  #      -> { "execute": "query-block" }
> >> > +  #      <- { ... }
> >> > +  #
> >> > +  #    Above, lengthy output has been omitted for brevity.
> >> > +
> >> > +
> >> > +Examples of complete definition documentation::
> >> > +
> >> >   ##
> >> >   # @BlockStats:
> >> >   #
> >> > @@ -1058,11 +1098,11 @@ For example::
> >> >   #
> >> >   # Since: 0.14
> >> >   #
> >> > - # Example:
> >> > + # .. qmp-example::
> >> >   #
> >> >   #     -> { "execute": "query-blockstats" }
> >> >   #     <- {
> >> > - #          ... lots of output ...
> >> > + #          ...
> >> >   #        }
> >> >   ##
> >> >   { 'command': 'query-blockstats',
> >> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> >> > index 6ad5663e545..adc85b5b394 100644
> >> > --- a/scripts/qapi/parser.py
> >> > +++ b/scripts/qapi/parser.py
> >> > @@ -553,7 +553,7 @@ def get_doc(self) -> 'QAPIDoc':
> >> >                      # Note: "sections" with two colons are left
> alone as
> >> >                      # rST markup and not interpreted as a section
> heading.
> >> >
> >> > -                    # TODO: Remove this error sometime in 2025 or s=
o
> >> > +                    # TODO: Remove these errors sometime in 2025 or
> so
> >> >                      # after we've fully transitioned to the new
> qapidoc
> >> >                      # generator.
> >> >
> >> > @@ -567,6 +567,14 @@ def get_doc(self) -> 'QAPIDoc':
> >> >                          )
> >> >                          raise QAPIParseError(self, emsg)
> >> >
> >> > +                    if 'Example' in match.group(1):
> >> > +                        emsg =3D (
> >> > +                            f"The '{match.group(1)}' section is no
> longer "
> >> > +                            "supported. Please use the '..
> qmp-example::' "
> >> > +                            "directive, or other suitable markup
> instead."
> >> > +                        )
> >> > +                        raise QAPIParseError(self, emsg)
> >> > +
> >> >                      doc.new_tagged_section(self.info,
> match.group(1))
> >> >                      text =3D line[match.end():]
> >> >                      if text:
> >> > diff --git a/tests/qapi-schema/doc-good.json
> b/tests/qapi-schema/doc-good.json
> >> > index 107123f8a8d..c71d65cd51f 100644
> >> > --- a/tests/qapi-schema/doc-good.json
> >> > +++ b/tests/qapi-schema/doc-good.json
> >> > @@ -172,12 +172,17 @@
> >> >  #
> >> >  #  Duis aute irure dolor
> >> >  #
> >> > -# Example:
> >> > +# .. qmp-example::
> >> > +#    :title: Ideal fast-food burger situation
> >> >  #
> >> > -#  -> in
> >> > -#  <- out
> >> > +#    -> "in"
> >> > +#    <- "out"
> >>
> >> Heh, trickery to make the text right of -> and <- JSON.
> >>
> >
> > O:-)
> >
> > It's maybe *slightly* bad form, but it does help illustrate how the new
> > directive is transformed when using text output modes in the test suite=
,
> so
> > I kept it. The new directive will simply not allow malformed JSON, so
> this
> > seemed like the simplest way to cheese that.
>
> I figure an alternative would be a more flexible "...".
>
> Two hunks up, you dumb one down:
>
>     - # Example:
>     + # .. qmp-example::
>       #
>       #     -> { "execute": "query-blockstats" }
>       #     <- {
>     - #          ... lots of output ...
>     + #          ...
>       #        }
>
> If qmp_lexer.py understood this more verbose ellipsis, we could use
> something like
>
>       #    -> ... input ...
>       #    <- ... output ...
>
> Worth the bother?  Certainly not just for tests.  Maybe for nicer
> examples in real documentation?  Up to you!
>

Good idea. I'll have to see if it's easy to get the lexer to realize both
"..." and "...(etc)..." as tokens without accidentally eating legitimate
JSON between. Probably a standalone patch/miniseries.


>
> >> >  #
> >> > -# Examples:
> >> > +# Examples::
> >> > +#
> >> > +#  - Not a QMP code block
> >> > +#  - Merely a preformatted code block literal
> >> > +#  It isn't even an rST list.
> >> >  #  - *verbatim*
> >> >  #  - {braces}
> >>
> >
> > (And here, we test the use of non-QMP code block literals, esp. after t=
he
> > qmp-example directive, proving that language settings have been restore=
d
> to
> > defaults.)
>
> Appreciated.
>
> >> >  #
> >> > @@ -199,11 +204,11 @@
> >> >  # @cmd-feat1: a feature
> >> >  # @cmd-feat2: another feature
> >> >  #
> >> > -# Example:
> >> > +# .. qmp-example::
> >> >  #
> >> > -#  -> in
> >> > +#    -> "this example"
> >> >  #
> >> > -#  <- out
> >> > +#    <- "has no title"
> >>
> >> Same trickery.
> >>
> >
> > Do you want that changed ... ?
>
> It's just a test, good enough.
>
> >> >  ##
> >> >  { 'command': 'cmd-boxed', 'boxed': true,
> >> >    'data': 'Object',
> >> > diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> >> > index bd876b6542d..eee18cd436a 100644
> >> > --- a/tests/qapi-schema/doc-good.out
> >> > +++ b/tests/qapi-schema/doc-good.out
> >> > @@ -184,13 +184,21 @@ frobnicate
> >> >   - Ut enim ad minim veniam
> >> >
> >> >   Duis aute irure dolor
> >> > -    section=3DExample
> >> > - -> in
> >> > - <- out
> >> > -    section=3DExamples
> >> > +
> >> > +.. qmp-example::
> >> > +   :title: Ideal fast-food burger situation
> >> > +
> >> > +   -> "in"
> >> > +   <- "out"
> >> > +
> >> > +Examples::
> >> > +
> >> > + - Not a QMP code block
> >> > + - Merely a preformatted code block literal
> >> > + It isn't even an rST list.
> >> >   - *verbatim*
> >> >   - {braces}
> >> > -    section=3DNone
> >> > +
> >> >  Note::
> >> >     Ceci n'est pas une note
> >> >      section=3DSince
> >> > @@ -202,10 +210,12 @@ If you're bored enough to read this, go see a
> video of boxed cats
> >> >  a feature
> >> >      feature=3Dcmd-feat2
> >> >  another feature
> >> > -    section=3DExample
> >> > - -> in
> >> > +    section=3DNone
> >> > +.. qmp-example::
> >> >
> >> > - <- out
> >> > +   -> "this example"
> >> > +
> >> > +   <- "has no title"
> >> >  doc symbol=3DEVT_BOXED
> >> >      body=3D
> >> >
> >> > diff --git a/tests/qapi-schema/doc-good.txt
> b/tests/qapi-schema/doc-good.txt
> >> > index 30d457e5488..cb37db606a6 100644
> >> > --- a/tests/qapi-schema/doc-good.txt
> >> > +++ b/tests/qapi-schema/doc-good.txt
> >> > @@ -217,17 +217,16 @@ Notes:
> >> >
> >> >  Duis aute irure dolor
> >> >
> >> > +Example: Ideal fast-food burger situation:
> >>
> >
> > No comment on the american making fast food burger jokes? :-(
>
> I chuckled, but no witticism came to me, so...
> >
> >> >
> >> > -Example
> >> > -~~~~~~~
> >> > +   -> "in"
> >> > +   <- "out"
> >> >
> >> > -   -> in
> >> > -   <- out
> >> > -
> >> > -
> >> > -Examples
> >> > -~~~~~~~~
> >> > +Examples:
> >> >
> >> > +   - Not a QMP code block
> >> > +   - Merely a preformatted code block literal
> >> > +   It isn't even an rST list.
> >> >     - *verbatim*
> >> >     - {braces}
> >> >
> >> > @@ -261,13 +260,11 @@ Features
> >> >  "cmd-feat2"
> >> >     another feature
> >> >
> >> > +Example::
> >> >
> >> > -Example
> >> > -~~~~~~~
> >> > +   -> "this example"
> >> >
> >> > -   -> in
> >> > -
> >> > -   <- out
> >> > +   <- "has no title"
> >> >
> >> >
> >> >  "EVT_BOXED" (Event)
> >>
> >
> > Does this adequately resolve your qualms about .txt rendering for
> examples?
>
> I think you mean my "Rendering to text now loses the "Example" heading"
> on "[PATCH 13/13] qapi: convert "Example" sections to rST".  The diff
> above demonstrates it's no longer lost.
>
> There's a tiny issue you may or may not want to address: an example
> isn't always separated by a blank line.  To reproduce, add my TODO hack
> to announce-self, and examine qemu-qmp-ref.txt:
>
>     "announce-self" (Command)
>     -------------------------
>
>     Trigger generation of broadcast RARP frames to update network
>     switches.  This can be useful when network bonds fail-over the active
>     slave.
>
>
>     Arguments
>     ~~~~~~~~~
>
> --> The members of "AnnounceParameters"
> --> Example::
>
>        -> { "execute": "announce-self",
>             "arguments": {
>                 "initial": 50, "max": 550, "rounds": 10, "step": 50,
>                 "interfaces": ["vn2", "vn3"], "id": "bob" } }
>        <- { "return": {} }
>
>
Oh, uh. I'm not sure how to fix that right away, but I'll try. No promises.

--0000000000008dd02f061ce5b7f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 10, 2024 at 1:45=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsn=
ow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Tue, Jul 9, 2024 at 6:52=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Fully eliminate the &quot;Example&quot; sections in QAPI doc =
blocks now that they<br>
&gt;&gt; &gt; have all been converted to arbitrary rST syntax using the<br>
&gt;&gt; &gt; &quot;.. qmp-example::&quot; directive. Update tests to match=
.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Migrating to the new syntax<br>
&gt;&gt; &gt; ---------------------------<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The old &quot;Example:&quot; or &quot;Examples:&quot; section=
 syntax is now caught as an<br>
&gt;&gt; &gt; error, but &quot;Example::&quot; is stil permitted as explici=
t rST syntax for an<br>
&gt;&gt; &gt; un-lexed, generic preformatted text block.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; (&#39;Example&#39; is not special in this case, any sentence =
that ends with &quot;::&quot;<br>
&gt;&gt; &gt; will start an indented code block in rST.)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Arbitrary rST for Examples is now possible, but it&#39;s stro=
ngly<br>
&gt;&gt; &gt; recommended that documentation authors use the &quot;.. qmp-e=
xample::&quot;<br>
&gt;&gt; &gt; directive for consistent visual formatting in rendered HTML d=
ocs. The<br>
&gt;&gt; &gt; &quot;:title:&quot; directive option may be used to add extra=
 information into the<br>
&gt;&gt; &gt; title bar for the example. The &quot;:annotated:&quot; option=
 can be used to write<br>
&gt;&gt; &gt; arbitrary rST instead, with nested &quot;::&quot; blocks appl=
ying QMP formatting<br>
&gt;&gt; &gt; where desired.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Other choices available are &quot;.. code-block:: QMP&quot; w=
hich will not create<br>
&gt;&gt; &gt; an &quot;Example:&quot; box, or the short-form &quot;::&quot;=
 code-block syntax which will<br>
&gt;&gt; &gt; not apply QMP highlighting when used outside of the qmp-examp=
le<br>
&gt;&gt; &gt; directive.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Why?<br>
&gt;&gt; &gt; ----<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This patch has several benefits:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 1. Example sections can now be written more arbitrarily, mixi=
ng<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 explanatory paragraphs and code blocks however d=
esired.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 2. Example sections can now use fully arbitrary rST.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 3. All code blocks are now lexed and validated as QMP; increa=
sing<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 usability of the docs and ensuring validity of e=
xample snippets.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 (To some extent - This patch only gaurantees it =
lexes correctly, not<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 that it&#39;s valid under the JSON or QMP gramma=
rs. It will catch most<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 small mistakes, however.)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 4. Each qmp-example can be titled or annotated independently =
without<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 bypassing the QMP lexer/validator.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 (i.e. code blocks are now for *code* only, so we=
 don&#39;t have to<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 sacrifice exposition for having lexically valid =
examples.)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; NOTE: As with the &quot;Notes&quot; conversion patch,<br>
&gt;&gt;<br>
&gt;&gt; Commit d461c279737 (qapi: convert &quot;Note&quot; sections to pla=
in rST).<br>
&gt;&gt;<br>
&gt;<br>
&gt; Didn&#39;t have a stable commit ID at the time, will work it in if/whe=
n the<br>
&gt; notes patches hit main.<br>
<br>
They have.<br>
<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0this patch (and those<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0preceding) may change the rendering=
 order for Examples in the<br>
&gt;&gt;<br>
&gt;&gt; The three preceding ones, to be precise.<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0current generator. The forthcoming =
qapidoc rewrite will fix this<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0by always generating documentation =
in source order.<br>
&gt;&gt;<br>
&gt;&gt; Conversions from &quot;Example&quot; section to plain reST may cha=
nge order.=C2=A0 This<br>
&gt;&gt; patch converts a test, and the preceding three convert the real us=
es.<br>
&gt;&gt;<br>
&gt;&gt; Does any of the patches actually change order?<br>
&gt;<br>
&gt; I do not actually know ...! It has the *potential* in the same exact w=
ay<br>
&gt; that the notes patch did, but I don&#39;t actually know if it *did*. M=
y hunch<br>
&gt; is &quot;no&quot; because there&#39;s only one intermediate section we=
 identified with<br>
&gt; the notes series, but I didn&#39;t exhaustively prove it. That&#39;s w=
hy I used the<br>
&gt; &quot;may&quot; weasel wording.<br>
<br>
Alright, I checked.<br>
<br>
In documentation of command announce-self, the example moves from after<br>
the arguments to before.=C2=A0 Unwanted change.<br>
<br>
I can keep it in place if I insert a TODO before the example like this:<br>
<br>
=C2=A0 =C2=A0 diff --git a/qapi/net.json b/qapi/net.json<br>
=C2=A0 =C2=A0 index 9a723e56b5..50bfd5b681 100644<br>
=C2=A0 =C2=A0 --- a/qapi/net.json<br>
=C2=A0 =C2=A0 +++ b/qapi/net.json<br>
=C2=A0 =C2=A0 @@ -930,6 +930,8 @@<br>
=C2=A0 =C2=A0 =C2=A0# switches.=C2=A0 This can be useful when network bonds=
 fail-over the<br>
=C2=A0 =C2=A0 =C2=A0# active slave.<br>
=C2=A0 =C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0 +# TODO: This line is a hack to separate the example from the=
 body<br>
=C2=A0 =C2=A0 +#<br>
=C2=A0 =C2=A0 =C2=A0# .. qmp-example::<br>
=C2=A0 =C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot=
;announce-self&quot;,<br>
<br>
I had to delete the .doctrees cache to make sphinx-build generate<br>
corrected output.<br>
<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 docs/devel/qapi-code-gen.rst=C2=A0 =C2=A0 | 58 ++++++++=
++++++++++++++++++++-----<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 10 +++++-<br>
&gt;&gt; &gt;=C2=A0 tests/qapi-schema/doc-good.json | 19 +++++++----<br>
&gt;&gt; &gt;=C2=A0 tests/qapi-schema/doc-good.out=C2=A0 | 26 ++++++++++---=
--<br>
&gt;&gt; &gt;=C2=A0 tests/qapi-schema/doc-good.txt=C2=A0 | 23 ++++++-------=
<br>
&gt;&gt; &gt;=C2=A0 5 files changed, 98 insertions(+), 38 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-c=
ode-gen.rst<br>
&gt;&gt; &gt; index ae97b335cbf..2e10a3cbd69 100644<br>
&gt;&gt; &gt; --- a/docs/devel/qapi-code-gen.rst<br>
&gt;&gt; &gt; +++ b/docs/devel/qapi-code-gen.rst<br>
&gt;&gt; &gt; @@ -899,7 +899,7 @@ Documentation markup<br>
&gt;&gt; &gt;=C2=A0 ~~~~~~~~~~~~~~~~~~~~<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 Documentation comments can use most rST markup.=C2=A0 I=
n particular,<br>
&gt;&gt; &gt; -a ``::`` literal block can be used for examples::<br>
&gt;&gt; &gt; +a ``::`` literal block can be used for pre-formatted text::<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 # ::<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 #<br>
&gt;&gt; &gt; @@ -995,8 +995,8 @@ line &quot;Features:&quot;, like this::<b=
r>
&gt;&gt; &gt;=C2=A0 =C2=A0 # @feature: Description text<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 A tagged section begins with a paragraph that starts wi=
th one of the<br>
&gt;&gt; &gt; -following words: &quot;Since:&quot;, &quot;Example:&quot;/&q=
uot;Examples:&quot;, &quot;Returns:&quot;,<br>
&gt;&gt; &gt; -&quot;Errors:&quot;, &quot;TODO:&quot;.=C2=A0 It ends with t=
he start of a new section.<br>
&gt;&gt; &gt; +following words: &quot;Since:&quot;, &quot;Returns:&quot;, &=
quot;Errors:&quot;, &quot;TODO:&quot;.=C2=A0 It ends with<br>
&gt;&gt; &gt; +the start of a new section.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 The second and subsequent lines of tagged sections must=
 be indented<br>
&gt;&gt; &gt;=C2=A0 like this::<br>
&gt;&gt; &gt; @@ -1020,13 +1020,53 @@ detailing a relevant error condition.=
 For<br>
&gt;&gt; example::<br>
&gt;&gt; &gt;=C2=A0 A &quot;Since: x.y.z&quot; tagged section lists the rel=
ease that introduced the<br>
&gt;&gt; &gt;=C2=A0 definition.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -An &quot;Example&quot; or &quot;Examples&quot; section is re=
ndered entirely<br>
&gt;&gt; &gt; -as literal fixed-width text.=C2=A0 &quot;TODO&quot; sections=
 are not rendered at all<br>
&gt;&gt; &gt; -(they are for developers, not users of QMP).=C2=A0 In other =
sections, the<br>
&gt;&gt; &gt; -text is formatted, and rST markup can be used.<br>
&gt;&gt; &gt; +&quot;TODO&quot; sections are not rendered at all (they are =
for developers, not<br>
&gt;&gt;<br>
&gt;&gt; Drop &quot;at all&quot;?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Sure.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; +users of QMP).=C2=A0 In other sections, the text is formatte=
d, and rST markup<br>
&gt;&gt; &gt; +can be used.<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +QMP Examples can be added by using the ``.. qmp-example::``<=
br>
&gt;&gt; &gt; +directive. In its simplest form, this can be used to contain=
 a single<br>
&gt;&gt; &gt; +QMP code block which accepts standard JSON syntax with addit=
ional server<br>
&gt;&gt; &gt; +directionality indicators (``-&gt;`` and ``&lt;-``), and eli=
sions (``...``).<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +Optionally, a plaintext title may be provided by using the `=
`:title:``<br>
&gt;&gt; &gt; +directive option. If the title is omitted, the example title=
 will<br>
&gt;&gt; &gt; +default to &quot;Example:&quot;.<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +A simple QMP example::<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 # .. qmp-example::<br>
&gt;&gt; &gt; +=C2=A0 #=C2=A0 =C2=A0 :title: Using query-block<br>
&gt;&gt; &gt; +=C2=A0 #<br>
&gt;&gt; &gt; +=C2=A0 #=C2=A0 =C2=A0 -&gt; { &quot;execute&quot;: &quot;que=
ry-block&quot; }<br>
&gt;&gt; &gt; +=C2=A0 #=C2=A0 =C2=A0 &lt;- { ... }<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +More complex or multi-step examples where exposition is need=
ed before or<br>
&gt;&gt; &gt; +between QMP code blocks can be created by using the ``:annot=
ated:``<br>
&gt;&gt; &gt; +directive option. When using this option, nested QMP code bl=
ocks must be<br>
&gt;&gt; &gt; +entered explicitly with rST&#39;s ``::`` syntax.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Telling on myself: you can use .. code-block:: QMP too, but I figured<=
br>
&gt; recommending &quot;::&quot; was shorter and sweeter. There are lots of=
 minutiae here<br>
&gt; for people who haven&#39;t spent a long time reading and writing rST, =
so I<br>
&gt; tried to keep it short.<br>
<br>
Makes sense.<br>
<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +Highlighting in non-QMP languages can be accomplished by usi=
ng the<br>
&gt;&gt; &gt; +``.. code-block:: lang`` directive, and non-highlighted text=
 can be<br>
&gt;&gt; &gt; +achieved by omitting the language argument.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 For example::<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +=C2=A0 # .. qmp-example::<br>
&gt;&gt; &gt; +=C2=A0 #=C2=A0 =C2=A0 :annotated:<br>
&gt;&gt; &gt; +=C2=A0 #=C2=A0 =C2=A0 :title: A more complex demonstration<b=
r>
&gt;&gt; &gt; +=C2=A0 #<br>
&gt;&gt; &gt; +=C2=A0 #=C2=A0 =C2=A0 This is a more complex example that ca=
n use<br>
&gt;&gt; &gt; +=C2=A0 #=C2=A0 =C2=A0 ``arbitrary rST syntax`` in its exposi=
tion::<br>
&gt;&gt; &gt; +=C2=A0 #<br>
&gt;&gt; &gt; +=C2=A0 #=C2=A0 =C2=A0 =C2=A0 -&gt; { &quot;execute&quot;: &q=
uot;query-block&quot; }<br>
&gt;&gt; &gt; +=C2=A0 #=C2=A0 =C2=A0 =C2=A0 &lt;- { ... }<br>
&gt;&gt; &gt; +=C2=A0 #<br>
&gt;&gt; &gt; +=C2=A0 #=C2=A0 =C2=A0 Above, lengthy output has been omitted=
 for brevity.<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +Examples of complete definition documentation::<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0##<br>
&gt;&gt; &gt;=C2=A0 =C2=A0# @BlockStats:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0#<br>
&gt;&gt; &gt; @@ -1058,11 +1098,11 @@ For example::<br>
&gt;&gt; &gt;=C2=A0 =C2=A0#<br>
&gt;&gt; &gt;=C2=A0 =C2=A0# Since: 0.14<br>
&gt;&gt; &gt;=C2=A0 =C2=A0#<br>
&gt;&gt; &gt; - # Example:<br>
&gt;&gt; &gt; + # .. qmp-example::<br>
&gt;&gt; &gt;=C2=A0 =C2=A0#<br>
&gt;&gt; &gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;:=
 &quot;query-blockstats&quot; }<br>
&gt;&gt; &gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0&lt;- {<br>
&gt;&gt; &gt; - #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ... lots of output ...<=
br>
&gt;&gt; &gt; + #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt;&gt; &gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;=C2=A0 =C2=A0##<br>
&gt;&gt; &gt;=C2=A0 =C2=A0{ &#39;command&#39;: &#39;query-blockstats&#39;,<=
br>
&gt;&gt; &gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<=
br>
&gt;&gt; &gt; index 6ad5663e545..adc85b5b394 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/parser.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/parser.py<br>
&gt;&gt; &gt; @@ -553,7 +553,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;=
:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 # Note: &quot;sections&quot; with two colons are left alone =
as<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 # rST markup and not interpreted as a section heading.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 # TODO: Remove this error sometime in 2025 or so<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 # TODO: Remove these errors sometime in 2025 or so<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 # after we&#39;ve fully transitioned to the new qapidoc<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 # generator.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; @@ -567,6 +567,14 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39=
;:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(self, emsg)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if &#39;Example&#39; in match.group(1):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 emsg =3D (<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;The &#39;{match.group(1)}&#39=
; section is no longer &quot;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;supported. Please use the &#39=
;.. qmp-example::&#39; &quot;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;directive, or other suitable m=
arkup instead.&quot;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(self, emsg)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 doc.new_tagged_section(<a href=3D"http://self.info" rel=3D"n=
oreferrer" target=3D"_blank">self.info</a>, match.group(1))<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 text =3D line[match.end():]<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if text:<br>
&gt;&gt; &gt; diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-sch=
ema/doc-good.json<br>
&gt;&gt; &gt; index 107123f8a8d..c71d65cd51f 100644<br>
&gt;&gt; &gt; --- a/tests/qapi-schema/doc-good.json<br>
&gt;&gt; &gt; +++ b/tests/qapi-schema/doc-good.json<br>
&gt;&gt; &gt; @@ -172,12 +172,17 @@<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 Duis aute irure dolor<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; -# Example:<br>
&gt;&gt; &gt; +# .. qmp-example::<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 :title: Ideal fast-food burger situation<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; -#=C2=A0 -&gt; in<br>
&gt;&gt; &gt; -#=C2=A0 &lt;- out<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 -&gt; &quot;in&quot;<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 &lt;- &quot;out&quot;<br>
&gt;&gt;<br>
&gt;&gt; Heh, trickery to make the text right of -&gt; and &lt;- JSON.<br>
&gt;&gt;<br>
&gt;<br>
&gt; O:-)<br>
&gt;<br>
&gt; It&#39;s maybe *slightly* bad form, but it does help illustrate how th=
e new<br>
&gt; directive is transformed when using text output modes in the test suit=
e, so<br>
&gt; I kept it. The new directive will simply not allow malformed JSON, so =
this<br>
&gt; seemed like the simplest way to cheese that.<br>
<br>
I figure an alternative would be a more flexible &quot;...&quot;.<br>
<br>
Two hunks up, you dumb one down:<br>
<br>
=C2=A0 =C2=A0 - # Example:<br>
=C2=A0 =C2=A0 + # .. qmp-example::<br>
=C2=A0 =C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quo=
t;query-blockstats&quot; }<br>
=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- {<br>
=C2=A0 =C2=A0 - #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ... lots of output ...<=
br>
=C2=A0 =C2=A0 + #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
If qmp_lexer.py understood this more verbose ellipsis, we could use<br>
something like<br>
<br>
=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 -&gt; ... input ...<br>
=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 &lt;- ... output ...<br>
<br>
Worth the bother?=C2=A0 Certainly not just for tests.=C2=A0 Maybe for nicer=
<br>
examples in real documentation?=C2=A0 Up to you!<br></blockquote><div><br><=
/div><div>Good idea. I&#39;ll have to see if it&#39;s easy to get the lexer=
 to realize both &quot;...&quot; and &quot;...(etc)...&quot; as tokens with=
out accidentally eating legitimate JSON between. Probably a standalone patc=
h/miniseries.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; -# Examples:<br>
&gt;&gt; &gt; +# Examples::<br>
&gt;&gt; &gt; +#<br>
&gt;&gt; &gt; +#=C2=A0 - Not a QMP code block<br>
&gt;&gt; &gt; +#=C2=A0 - Merely a preformatted code block literal<br>
&gt;&gt; &gt; +#=C2=A0 It isn&#39;t even an rST list.<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 - *verbatim*<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 - {braces}<br>
&gt;&gt;<br>
&gt;<br>
&gt; (And here, we test the use of non-QMP code block literals, esp. after =
the<br>
&gt; qmp-example directive, proving that language settings have been restor=
ed to<br>
&gt; defaults.)<br>
<br>
Appreciated.<br>
<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; @@ -199,11 +204,11 @@<br>
&gt;&gt; &gt;=C2=A0 # @cmd-feat1: a feature<br>
&gt;&gt; &gt;=C2=A0 # @cmd-feat2: another feature<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; -# Example:<br>
&gt;&gt; &gt; +# .. qmp-example::<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; -#=C2=A0 -&gt; in<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 -&gt; &quot;this example&quot;<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; -#=C2=A0 &lt;- out<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 &lt;- &quot;has no title&quot;<br>
&gt;&gt;<br>
&gt;&gt; Same trickery.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Do you want that changed ... ?<br>
<br>
It&#39;s just a test, good enough.<br>
<br>
&gt;&gt; &gt;=C2=A0 ##<br>
&gt;&gt; &gt;=C2=A0 { &#39;command&#39;: &#39;cmd-boxed&#39;, &#39;boxed&#3=
9;: true,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 &#39;data&#39;: &#39;Object&#39;,<br>
&gt;&gt; &gt; diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-sche=
ma/doc-good.out<br>
&gt;&gt; &gt; index bd876b6542d..eee18cd436a 100644<br>
&gt;&gt; &gt; --- a/tests/qapi-schema/doc-good.out<br>
&gt;&gt; &gt; +++ b/tests/qapi-schema/doc-good.out<br>
&gt;&gt; &gt; @@ -184,13 +184,21 @@ frobnicate<br>
&gt;&gt; &gt;=C2=A0 =C2=A0- Ut enim ad minim veniam<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0Duis aute irure dolor<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 section=3DExample<br>
&gt;&gt; &gt; - -&gt; in<br>
&gt;&gt; &gt; - &lt;- out<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 section=3DExamples<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +.. qmp-example::<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0:title: Ideal fast-food burger situation<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0-&gt; &quot;in&quot;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0&lt;- &quot;out&quot;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +Examples::<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; + - Not a QMP code block<br>
&gt;&gt; &gt; + - Merely a preformatted code block literal<br>
&gt;&gt; &gt; + It isn&#39;t even an rST list.<br>
&gt;&gt; &gt;=C2=A0 =C2=A0- *verbatim*<br>
&gt;&gt; &gt;=C2=A0 =C2=A0- {braces}<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 section=3DNone<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 Note::<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Ceci n&#39;est pas une note<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 section=3DSince<br>
&gt;&gt; &gt; @@ -202,10 +210,12 @@ If you&#39;re bored enough to read this=
, go see a video of boxed cats<br>
&gt;&gt; &gt;=C2=A0 a feature<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 feature=3Dcmd-feat2<br>
&gt;&gt; &gt;=C2=A0 another feature<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 section=3DExample<br>
&gt;&gt; &gt; - -&gt; in<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 section=3DNone<br>
&gt;&gt; &gt; +.. qmp-example::<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - &lt;- out<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0-&gt; &quot;this example&quot;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0&lt;- &quot;has no title&quot;<br>
&gt;&gt; &gt;=C2=A0 doc symbol=3DEVT_BOXED<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 body=3D<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-sche=
ma/doc-good.txt<br>
&gt;&gt; &gt; index 30d457e5488..cb37db606a6 100644<br>
&gt;&gt; &gt; --- a/tests/qapi-schema/doc-good.txt<br>
&gt;&gt; &gt; +++ b/tests/qapi-schema/doc-good.txt<br>
&gt;&gt; &gt; @@ -217,17 +217,16 @@ Notes:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 Duis aute irure dolor<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +Example: Ideal fast-food burger situation:<br>
&gt;&gt;<br>
&gt;<br>
&gt; No comment on the american making fast food burger jokes? :-(<br>
<br>
I chuckled, but no witticism came to me, so...<br>
&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -Example<br>
&gt;&gt; &gt; -~~~~~~~<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0-&gt; &quot;in&quot;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0&lt;- &quot;out&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0-&gt; in<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0&lt;- out<br>
&gt;&gt; &gt; -<br>
&gt;&gt; &gt; -<br>
&gt;&gt; &gt; -Examples<br>
&gt;&gt; &gt; -~~~~~~~~<br>
&gt;&gt; &gt; +Examples:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0- Not a QMP code block<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0- Merely a preformatted code block literal<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0It isn&#39;t even an rST list.<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0- *verbatim*<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0- {braces}<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; @@ -261,13 +260,11 @@ Features<br>
&gt;&gt; &gt;=C2=A0 &quot;cmd-feat2&quot;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0another feature<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +Example::<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -Example<br>
&gt;&gt; &gt; -~~~~~~~<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0-&gt; &quot;this example&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0-&gt; in<br>
&gt;&gt; &gt; -<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0&lt;- out<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0&lt;- &quot;has no title&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 &quot;EVT_BOXED&quot; (Event)<br>
&gt;&gt;<br>
&gt;<br>
&gt; Does this adequately resolve your qualms about .txt rendering for exam=
ples?<br>
<br>
I think you mean my &quot;Rendering to text now loses the &quot;Example&quo=
t; heading&quot;<br>
on &quot;[PATCH 13/13] qapi: convert &quot;Example&quot; sections to rST&qu=
ot;.=C2=A0 The diff<br>
above demonstrates it&#39;s no longer lost.<br>
<br>
There&#39;s a tiny issue you may or may not want to address: an example<br>
isn&#39;t always separated by a blank line.=C2=A0 To reproduce, add my TODO=
 hack<br>
to announce-self, and examine qemu-qmp-ref.txt:<br>
<br>
=C2=A0 =C2=A0 &quot;announce-self&quot; (Command)<br>
=C2=A0 =C2=A0 -------------------------<br>
<br>
=C2=A0 =C2=A0 Trigger generation of broadcast RARP frames to update network=
<br>
=C2=A0 =C2=A0 switches.=C2=A0 This can be useful when network bonds fail-ov=
er the active<br>
=C2=A0 =C2=A0 slave.<br>
<br>
<br>
=C2=A0 =C2=A0 Arguments<br>
=C2=A0 =C2=A0 ~~~~~~~~~<br>
<br>
--&gt; The members of &quot;AnnounceParameters&quot;<br>
--&gt; Example::<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;announce-self=
&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;initial&quot;=
: 50, &quot;max&quot;: 550, &quot;rounds&quot;: 10, &quot;step&quot;: 50,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;interfaces&qu=
ot;: [&quot;vn2&quot;, &quot;vn3&quot;], &quot;id&quot;: &quot;bob&quot; } =
}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
<br></blockquote><div><br></div><div>Oh, uh. I&#39;m not sure how to fix th=
at right away, but I&#39;ll try. No promises. <br></div></div></div>

--0000000000008dd02f061ce5b7f4--


