Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1EFC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 23:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRK16-00068B-AW; Tue, 09 Jul 2024 19:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sRK14-00067M-70
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 19:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sRK10-00036m-VS
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 19:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720566774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MqfZ2VWu8MiZ7MPYIzXJ2RlWQ0buz3m+vpqQ5t2WFeU=;
 b=XtA/R0rB8qN70/p9LdPfh7vqO4OiT6vDLjRJMOLbl6hE7QqAkJKEaxpgzx1f4wV4jrQe2G
 b/cq6KdWoP6c1LnJ7l110BTxVQhrt9xkPbyMqkk27GKdfUSk+xGCkwa7dZQ3s4QYiMDU3F
 Zqk3qRWIWAiFmYVa7mMkoyKx6YXdsPo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-cz05WMssO2qiW9yHQDlXEA-1; Tue, 09 Jul 2024 19:12:52 -0400
X-MC-Unique: cz05WMssO2qiW9yHQDlXEA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c963f358feso5510461a91.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 16:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720566771; x=1721171571;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MqfZ2VWu8MiZ7MPYIzXJ2RlWQ0buz3m+vpqQ5t2WFeU=;
 b=joVGdgul0qVZjMBT/yFdGAX60YqlTV/C/lSdo4cV62eaLZ2/NMKEkW4DR6Hv7igS3X
 Qz8qENywoGtCzvuyZObHhM3okdslwjJErdRk3B87O3s0ax2Vi4/0WoM/ylkhW/NMj2rs
 /r9jGsDKJ8Vk6qc728eBvtrMFpYZX71cuwdI+OpA+d0ylO8Qfv+EbsBFCF2+MpVOmoED
 pNb4w8uMTRYv0xYetbns4/vmAlD+UgZZREGr3T1pIOrT752uu0PmRaeB465NBEeEpyqk
 rE4ShRa7bAVRYAc8WUjzxUiL6qbDGipjTEm8cKVw2qfmxnTGCjvHBB+zCMJWkzzOeKQU
 Vqww==
X-Gm-Message-State: AOJu0YwTgDBErlU1T8lMAXLn0lsc2tmiXWlmXS3MQMeMB5OnhaqvsHR6
 GMdGwAiaqwQNhydQg2kJh4tdFT5l+w+6PLvsvB2ZL9VepRIFAFW5uTAZuAmD41B5rCjRn3Ho6s5
 NBAuUc9e6TZbcAo8FbgB/r5243y6dc9Ore4kJ3iSRGRh+j0hCLAMHFLP3KKLNRhslGsG5EW1N+b
 UiuxV5vKg8e3rpcxgaSQl6vgTm+58=
X-Received: by 2002:a17:90a:f491:b0:2c9:7fba:d88b with SMTP id
 98e67ed59e1d1-2ca35c27e0dmr3615590a91.14.1720566770998; 
 Tue, 09 Jul 2024 16:12:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB9n/fb49R8NVelbh58VJQplQC/zhv0ooWQtfSmig7CZWMaj1COBFEdTUEfhyH4Yi/6AnWGIJDsjB/N1nakQY=
X-Received: by 2002:a17:90a:f491:b0:2c9:7fba:d88b with SMTP id
 98e67ed59e1d1-2ca35c27e0dmr3615577a91.14.1720566770549; Tue, 09 Jul 2024
 16:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-9-jsnow@redhat.com>
 <87sewihm6k.fsf@pond.sub.org>
In-Reply-To: <87sewihm6k.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Jul 2024 19:12:38 -0400
Message-ID: <CAFn=p-b6SDEpeN3rJc_g6puUR5RmP5CfxUb7bdy3pQRhsvmytQ@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="0000000000002bea3b061cd8ab7d"
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

--0000000000002bea3b061cd8ab7d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:52=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Fully eliminate the "Example" sections in QAPI doc blocks now that they
> > have all been converted to arbitrary rST syntax using the
> > ".. qmp-example::" directive. Update tests to match.
> >
> > Migrating to the new syntax
> > ---------------------------
> >
> > The old "Example:" or "Examples:" section syntax is now caught as an
> > error, but "Example::" is stil permitted as explicit rST syntax for an
> > un-lexed, generic preformatted text block.
> >
> > ('Example' is not special in this case, any sentence that ends with "::=
"
> > will start an indented code block in rST.)
> >
> > Arbitrary rST for Examples is now possible, but it's strongly
> > recommended that documentation authors use the ".. qmp-example::"
> > directive for consistent visual formatting in rendered HTML docs. The
> > ":title:" directive option may be used to add extra information into th=
e
> > title bar for the example. The ":annotated:" option can be used to writ=
e
> > arbitrary rST instead, with nested "::" blocks applying QMP formatting
> > where desired.
> >
> > Other choices available are ".. code-block:: QMP" which will not create
> > an "Example:" box, or the short-form "::" code-block syntax which will
> > not apply QMP highlighting when used outside of the qmp-example
> > directive.
> >
> > Why?
> > ----
> >
> > This patch has several benefits:
> >
> > 1. Example sections can now be written more arbitrarily, mixing
> >    explanatory paragraphs and code blocks however desired.
> >
> > 2. Example sections can now use fully arbitrary rST.
> >
> > 3. All code blocks are now lexed and validated as QMP; increasing
> >    usability of the docs and ensuring validity of example snippets.
> >
> >    (To some extent - This patch only gaurantees it lexes correctly, not
> >    that it's valid under the JSON or QMP grammars. It will catch most
> >    small mistakes, however.)
> >
> > 4. Each qmp-example can be titled or annotated independently without
> >    bypassing the QMP lexer/validator.
> >
> >    (i.e. code blocks are now for *code* only, so we don't have to
> >    sacrifice exposition for having lexically valid examples.)
> >
> > NOTE: As with the "Notes" conversion patch,
>
> Commit d461c279737 (qapi: convert "Note" sections to plain rST).
>

Didn't have a stable commit ID at the time, will work it in if/when the
notes patches hit main.


>
> >                                             this patch (and those
> >       preceding) may change the rendering order for Examples in the
>
> The three preceding ones, to be precise.
>
> >       current generator. The forthcoming qapidoc rewrite will fix this
> >       by always generating documentation in source order.
>
> Conversions from "Example" section to plain reST may change order.  This
> patch converts a test, and the preceding three convert the real uses.
>
> Does any of the patches actually change order?
>

I do not actually know ...! It has the *potential* in the same exact way
that the notes patch did, but I don't actually know if it *did*. My hunch
is "no" because there's only one intermediate section we identified with
the notes series, but I didn't exhaustively prove it. That's why I used the
"may" weasel wording.


>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.rst    | 58 ++++++++++++++++++++++++++++-----
> >  scripts/qapi/parser.py          | 10 +++++-
> >  tests/qapi-schema/doc-good.json | 19 +++++++----
> >  tests/qapi-schema/doc-good.out  | 26 ++++++++++-----
> >  tests/qapi-schema/doc-good.txt  | 23 ++++++-------
> >  5 files changed, 98 insertions(+), 38 deletions(-)
> >
> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rs=
t
> > index ae97b335cbf..2e10a3cbd69 100644
> > --- a/docs/devel/qapi-code-gen.rst
> > +++ b/docs/devel/qapi-code-gen.rst
> > @@ -899,7 +899,7 @@ Documentation markup
> >  ~~~~~~~~~~~~~~~~~~~~
> >
> >  Documentation comments can use most rST markup.  In particular,
> > -a ``::`` literal block can be used for examples::
> > +a ``::`` literal block can be used for pre-formatted text::
> >
> >      # ::
> >      #
> > @@ -995,8 +995,8 @@ line "Features:", like this::
> >    # @feature: Description text
> >
> >  A tagged section begins with a paragraph that starts with one of the
> > -following words: "Since:", "Example:"/"Examples:", "Returns:",
> > -"Errors:", "TODO:".  It ends with the start of a new section.
> > +following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends wi=
th
> > +the start of a new section.
> >
> >  The second and subsequent lines of tagged sections must be indented
> >  like this::
> > @@ -1020,13 +1020,53 @@ detailing a relevant error condition. For
> example::
> >  A "Since: x.y.z" tagged section lists the release that introduced the
> >  definition.
> >
> > -An "Example" or "Examples" section is rendered entirely
> > -as literal fixed-width text.  "TODO" sections are not rendered at all
> > -(they are for developers, not users of QMP).  In other sections, the
> > -text is formatted, and rST markup can be used.
> > +"TODO" sections are not rendered at all (they are for developers, not
>
> Drop "at all"?
>

Sure.


>
> > +users of QMP).  In other sections, the text is formatted, and rST mark=
up
> > +can be used.
> > +
> > +QMP Examples can be added by using the ``.. qmp-example::``
> > +directive. In its simplest form, this can be used to contain a single
> > +QMP code block which accepts standard JSON syntax with additional serv=
er
> > +directionality indicators (``->`` and ``<-``), and elisions (``...``).
> > +
> > +Optionally, a plaintext title may be provided by using the ``:title:``
> > +directive option. If the title is omitted, the example title will
> > +default to "Example:".
> > +
> > +A simple QMP example::
> > +
> > +  # .. qmp-example::
> > +  #    :title: Using query-block
> > +  #
> > +  #    -> { "execute": "query-block" }
> > +  #    <- { ... }
> > +
> > +More complex or multi-step examples where exposition is needed before =
or
> > +between QMP code blocks can be created by using the ``:annotated:``
> > +directive option. When using this option, nested QMP code blocks must =
be
> > +entered explicitly with rST's ``::`` syntax.
>

Telling on myself: you can use .. code-block:: QMP too, but I figured
recommending "::" was shorter and sweeter. There are lots of minutiae here
for people who haven't spent a long time reading and writing rST, so I
tried to keep it short.


> > +
> > +Highlighting in non-QMP languages can be accomplished by using the
> > +``.. code-block:: lang`` directive, and non-highlighted text can be
> > +achieved by omitting the language argument.
> >
> >  For example::
> >
> > +  # .. qmp-example::
> > +  #    :annotated:
> > +  #    :title: A more complex demonstration
> > +  #
> > +  #    This is a more complex example that can use
> > +  #    ``arbitrary rST syntax`` in its exposition::
> > +  #
> > +  #      -> { "execute": "query-block" }
> > +  #      <- { ... }
> > +  #
> > +  #    Above, lengthy output has been omitted for brevity.
> > +
> > +
> > +Examples of complete definition documentation::
> > +
> >   ##
> >   # @BlockStats:
> >   #
> > @@ -1058,11 +1098,11 @@ For example::
> >   #
> >   # Since: 0.14
> >   #
> > - # Example:
> > + # .. qmp-example::
> >   #
> >   #     -> { "execute": "query-blockstats" }
> >   #     <- {
> > - #          ... lots of output ...
> > + #          ...
> >   #        }
> >   ##
> >   { 'command': 'query-blockstats',
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 6ad5663e545..adc85b5b394 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -553,7 +553,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                      # Note: "sections" with two colons are left alone =
as
> >                      # rST markup and not interpreted as a section
> heading.
> >
> > -                    # TODO: Remove this error sometime in 2025 or so
> > +                    # TODO: Remove these errors sometime in 2025 or so
> >                      # after we've fully transitioned to the new qapido=
c
> >                      # generator.
> >
> > @@ -567,6 +567,14 @@ def get_doc(self) -> 'QAPIDoc':
> >                          )
> >                          raise QAPIParseError(self, emsg)
> >
> > +                    if 'Example' in match.group(1):
> > +                        emsg =3D (
> > +                            f"The '{match.group(1)}' section is no
> longer "
> > +                            "supported. Please use the '..
> qmp-example::' "
> > +                            "directive, or other suitable markup
> instead."
> > +                        )
> > +                        raise QAPIParseError(self, emsg)
> > +
> >                      doc.new_tagged_section(self.info, match.group(1))
> >                      text =3D line[match.end():]
> >                      if text:
> > diff --git a/tests/qapi-schema/doc-good.json
> b/tests/qapi-schema/doc-good.json
> > index 107123f8a8d..c71d65cd51f 100644
> > --- a/tests/qapi-schema/doc-good.json
> > +++ b/tests/qapi-schema/doc-good.json
> > @@ -172,12 +172,17 @@
> >  #
> >  #  Duis aute irure dolor
> >  #
> > -# Example:
> > +# .. qmp-example::
> > +#    :title: Ideal fast-food burger situation
> >  #
> > -#  -> in
> > -#  <- out
> > +#    -> "in"
> > +#    <- "out"
>
> Heh, trickery to make the text right of -> and <- JSON.
>

O:-)

It's maybe *slightly* bad form, but it does help illustrate how the new
directive is transformed when using text output modes in the test suite, so
I kept it. The new directive will simply not allow malformed JSON, so this
seemed like the simplest way to cheese that.


>
> >  #
> > -# Examples:
> > +# Examples::
> > +#
> > +#  - Not a QMP code block
> > +#  - Merely a preformatted code block literal
> > +#  It isn't even an rST list.
> >  #  - *verbatim*
> >  #  - {braces}
>

(And here, we test the use of non-QMP code block literals, esp. after the
qmp-example directive, proving that language settings have been restored to
defaults.)


> >  #
> > @@ -199,11 +204,11 @@
> >  # @cmd-feat1: a feature
> >  # @cmd-feat2: another feature
> >  #
> > -# Example:
> > +# .. qmp-example::
> >  #
> > -#  -> in
> > +#    -> "this example"
> >  #
> > -#  <- out
> > +#    <- "has no title"
>
> Same trickery.
>

Do you want that changed ... ?


>
> >  ##
> >  { 'command': 'cmd-boxed', 'boxed': true,
> >    'data': 'Object',
> > diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> > index bd876b6542d..eee18cd436a 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -184,13 +184,21 @@ frobnicate
> >   - Ut enim ad minim veniam
> >
> >   Duis aute irure dolor
> > -    section=3DExample
> > - -> in
> > - <- out
> > -    section=3DExamples
> > +
> > +.. qmp-example::
> > +   :title: Ideal fast-food burger situation
> > +
> > +   -> "in"
> > +   <- "out"
> > +
> > +Examples::
> > +
> > + - Not a QMP code block
> > + - Merely a preformatted code block literal
> > + It isn't even an rST list.
> >   - *verbatim*
> >   - {braces}
> > -    section=3DNone
> > +
> >  Note::
> >     Ceci n'est pas une note
> >      section=3DSince
> > @@ -202,10 +210,12 @@ If you're bored enough to read this, go see a
> video of boxed cats
> >  a feature
> >      feature=3Dcmd-feat2
> >  another feature
> > -    section=3DExample
> > - -> in
> > +    section=3DNone
> > +.. qmp-example::
> >
> > - <- out
> > +   -> "this example"
> > +
> > +   <- "has no title"
> >  doc symbol=3DEVT_BOXED
> >      body=3D
> >
> > diff --git a/tests/qapi-schema/doc-good.txt
> b/tests/qapi-schema/doc-good.txt
> > index 30d457e5488..cb37db606a6 100644
> > --- a/tests/qapi-schema/doc-good.txt
> > +++ b/tests/qapi-schema/doc-good.txt
> > @@ -217,17 +217,16 @@ Notes:
> >
> >  Duis aute irure dolor
> >
> > +Example: Ideal fast-food burger situation:
>

No comment on the american making fast food burger jokes? :-(


> >
> > -Example
> > -~~~~~~~
> > +   -> "in"
> > +   <- "out"
> >
> > -   -> in
> > -   <- out
> > -
> > -
> > -Examples
> > -~~~~~~~~
> > +Examples:
> >
> > +   - Not a QMP code block
> > +   - Merely a preformatted code block literal
> > +   It isn't even an rST list.
> >     - *verbatim*
> >     - {braces}
> >
> > @@ -261,13 +260,11 @@ Features
> >  "cmd-feat2"
> >     another feature
> >
> > +Example::
> >
> > -Example
> > -~~~~~~~
> > +   -> "this example"
> >
> > -   -> in
> > -
> > -   <- out
> > +   <- "has no title"
> >
> >
> >  "EVT_BOXED" (Event)
>

Does this adequately resolve your qualms about .txt rendering for examples?

--js

--0000000000002bea3b061cd8ab7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 9, 2024 at 6:52=E2=80=AFA=
M Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsno=
w@redhat.com</a>&gt; writes:<br>
<br>
&gt; Fully eliminate the &quot;Example&quot; sections in QAPI doc blocks no=
w that they<br>
&gt; have all been converted to arbitrary rST syntax using the<br>
&gt; &quot;.. qmp-example::&quot; directive. Update tests to match.<br>
&gt;<br>
&gt; Migrating to the new syntax<br>
&gt; ---------------------------<br>
&gt;<br>
&gt; The old &quot;Example:&quot; or &quot;Examples:&quot; section syntax i=
s now caught as an<br>
&gt; error, but &quot;Example::&quot; is stil permitted as explicit rST syn=
tax for an<br>
&gt; un-lexed, generic preformatted text block.<br>
&gt;<br>
&gt; (&#39;Example&#39; is not special in this case, any sentence that ends=
 with &quot;::&quot;<br>
&gt; will start an indented code block in rST.)<br>
&gt;<br>
&gt; Arbitrary rST for Examples is now possible, but it&#39;s strongly<br>
&gt; recommended that documentation authors use the &quot;.. qmp-example::&=
quot;<br>
&gt; directive for consistent visual formatting in rendered HTML docs. The<=
br>
&gt; &quot;:title:&quot; directive option may be used to add extra informat=
ion into the<br>
&gt; title bar for the example. The &quot;:annotated:&quot; option can be u=
sed to write<br>
&gt; arbitrary rST instead, with nested &quot;::&quot; blocks applying QMP =
formatting<br>
&gt; where desired.<br>
&gt;<br>
&gt; Other choices available are &quot;.. code-block:: QMP&quot; which will=
 not create<br>
&gt; an &quot;Example:&quot; box, or the short-form &quot;::&quot; code-blo=
ck syntax which will<br>
&gt; not apply QMP highlighting when used outside of the qmp-example<br>
&gt; directive.<br>
&gt;<br>
&gt; Why?<br>
&gt; ----<br>
&gt;<br>
&gt; This patch has several benefits:<br>
&gt;<br>
&gt; 1. Example sections can now be written more arbitrarily, mixing<br>
&gt;=C2=A0 =C2=A0 explanatory paragraphs and code blocks however desired.<b=
r>
&gt;<br>
&gt; 2. Example sections can now use fully arbitrary rST.<br>
&gt;<br>
&gt; 3. All code blocks are now lexed and validated as QMP; increasing<br>
&gt;=C2=A0 =C2=A0 usability of the docs and ensuring validity of example sn=
ippets.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 (To some extent - This patch only gaurantees it lexes cor=
rectly, not<br>
&gt;=C2=A0 =C2=A0 that it&#39;s valid under the JSON or QMP grammars. It wi=
ll catch most<br>
&gt;=C2=A0 =C2=A0 small mistakes, however.)<br>
&gt;<br>
&gt; 4. Each qmp-example can be titled or annotated independently without<b=
r>
&gt;=C2=A0 =C2=A0 bypassing the QMP lexer/validator.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 (i.e. code blocks are now for *code* only, so we don&#39;=
t have to<br>
&gt;=C2=A0 =C2=A0 sacrifice exposition for having lexically valid examples.=
)<br>
&gt;<br>
&gt; NOTE: As with the &quot;Notes&quot; conversion patch,<br>
<br>
Commit d461c279737 (qapi: convert &quot;Note&quot; sections to plain rST).<=
br></blockquote><div><br></div><div>Didn&#39;t have a stable commit ID at t=
he time, will work it in if/when the notes patches hit main.<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0this patch (and those<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0preceding) may change the rendering order fo=
r Examples in the<br>
<br>
The three preceding ones, to be precise.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0current generator. The forthcoming qapidoc r=
ewrite will fix this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0by always generating documentation in source=
 order.<br>
<br>
Conversions from &quot;Example&quot; section to plain reST may change order=
.=C2=A0 This<br>
patch converts a test, and the preceding three convert the real uses.<br>
<br>
Does any of the patches actually change order?<br></blockquote><div><br></d=
iv><div>I do not actually know ...! It has the *potential* in the same exac=
t way that the notes patch did, but I don&#39;t actually know if it *did*. =
My hunch is &quot;no&quot; because there&#39;s only one intermediate sectio=
n we identified with the notes series, but I didn&#39;t exhaustively prove =
it. That&#39;s why I used the &quot;may&quot; weasel wording.<br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/devel/qapi-code-gen.rst=C2=A0 =C2=A0 | 58 +++++++++++++++++=
+++++++++++-----<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++=
+++-<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.json | 19 +++++++----<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out=C2=A0 | 26 ++++++++++-----<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.txt=C2=A0 | 23 ++++++-------<br>
&gt;=C2=A0 5 files changed, 98 insertions(+), 38 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.r=
st<br>
&gt; index ae97b335cbf..2e10a3cbd69 100644<br>
&gt; --- a/docs/devel/qapi-code-gen.rst<br>
&gt; +++ b/docs/devel/qapi-code-gen.rst<br>
&gt; @@ -899,7 +899,7 @@ Documentation markup<br>
&gt;=C2=A0 ~~~~~~~~~~~~~~~~~~~~<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Documentation comments can use most rST markup.=C2=A0 In particu=
lar,<br>
&gt; -a ``::`` literal block can be used for examples::<br>
&gt; +a ``::`` literal block can be used for pre-formatted text::<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 # ::<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #<br>
&gt; @@ -995,8 +995,8 @@ line &quot;Features:&quot;, like this::<br>
&gt;=C2=A0 =C2=A0 # @feature: Description text<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 A tagged section begins with a paragraph that starts with one of=
 the<br>
&gt; -following words: &quot;Since:&quot;, &quot;Example:&quot;/&quot;Examp=
les:&quot;, &quot;Returns:&quot;,<br>
&gt; -&quot;Errors:&quot;, &quot;TODO:&quot;.=C2=A0 It ends with the start =
of a new section.<br>
&gt; +following words: &quot;Since:&quot;, &quot;Returns:&quot;, &quot;Erro=
rs:&quot;, &quot;TODO:&quot;.=C2=A0 It ends with<br>
&gt; +the start of a new section.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 The second and subsequent lines of tagged sections must be inden=
ted<br>
&gt;=C2=A0 like this::<br>
&gt; @@ -1020,13 +1020,53 @@ detailing a relevant error condition. For exam=
ple::<br>
&gt;=C2=A0 A &quot;Since: x.y.z&quot; tagged section lists the release that=
 introduced the<br>
&gt;=C2=A0 definition.<br>
&gt;=C2=A0 <br>
&gt; -An &quot;Example&quot; or &quot;Examples&quot; section is rendered en=
tirely<br>
&gt; -as literal fixed-width text.=C2=A0 &quot;TODO&quot; sections are not =
rendered at all<br>
&gt; -(they are for developers, not users of QMP).=C2=A0 In other sections,=
 the<br>
&gt; -text is formatted, and rST markup can be used.<br>
&gt; +&quot;TODO&quot; sections are not rendered at all (they are for devel=
opers, not<br>
<br>
Drop &quot;at all&quot;?<br></blockquote><div><br></div><div>Sure.<br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +users of QMP).=C2=A0 In other sections, the text is formatted, and rS=
T markup<br>
&gt; +can be used.<br>
&gt; +<br>
&gt; +QMP Examples can be added by using the ``.. qmp-example::``<br>
&gt; +directive. In its simplest form, this can be used to contain a single=
<br>
&gt; +QMP code block which accepts standard JSON syntax with additional ser=
ver<br>
&gt; +directionality indicators (``-&gt;`` and ``&lt;-``), and elisions (``=
...``).<br>
&gt; +<br>
&gt; +Optionally, a plaintext title may be provided by using the ``:title:`=
`<br>
&gt; +directive option. If the title is omitted, the example title will<br>
&gt; +default to &quot;Example:&quot;.<br>
&gt; +<br>
&gt; +A simple QMP example::<br>
&gt; +<br>
&gt; +=C2=A0 # .. qmp-example::<br>
&gt; +=C2=A0 #=C2=A0 =C2=A0 :title: Using query-block<br>
&gt; +=C2=A0 #<br>
&gt; +=C2=A0 #=C2=A0 =C2=A0 -&gt; { &quot;execute&quot;: &quot;query-block&=
quot; }<br>
&gt; +=C2=A0 #=C2=A0 =C2=A0 &lt;- { ... }<br>
&gt; +<br>
&gt; +More complex or multi-step examples where exposition is needed before=
 or<br>
&gt; +between QMP code blocks can be created by using the ``:annotated:``<b=
r>
&gt; +directive option. When using this option, nested QMP code blocks must=
 be<br>
&gt; +entered explicitly with rST&#39;s ``::`` syntax.<br></blockquote><div=
><br></div><div>Telling on myself: you can use .. code-block:: QMP too, but=
 I figured recommending &quot;::&quot; was shorter and sweeter. There are l=
ots of minutiae here for people who haven&#39;t spent a long time reading a=
nd writing rST, so I tried to keep it short.<br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +Highlighting in non-QMP languages can be accomplished by using the<br=
>
&gt; +``.. code-block:: lang`` directive, and non-highlighted text can be<b=
r>
&gt; +achieved by omitting the language argument.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 For example::<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 # .. qmp-example::<br>
&gt; +=C2=A0 #=C2=A0 =C2=A0 :annotated:<br>
&gt; +=C2=A0 #=C2=A0 =C2=A0 :title: A more complex demonstration<br>
&gt; +=C2=A0 #<br>
&gt; +=C2=A0 #=C2=A0 =C2=A0 This is a more complex example that can use<br>
&gt; +=C2=A0 #=C2=A0 =C2=A0 ``arbitrary rST syntax`` in its exposition::<br=
>
&gt; +=C2=A0 #<br>
&gt; +=C2=A0 #=C2=A0 =C2=A0 =C2=A0 -&gt; { &quot;execute&quot;: &quot;query=
-block&quot; }<br>
&gt; +=C2=A0 #=C2=A0 =C2=A0 =C2=A0 &lt;- { ... }<br>
&gt; +=C2=A0 #<br>
&gt; +=C2=A0 #=C2=A0 =C2=A0 Above, lengthy output has been omitted for brev=
ity.<br>
&gt; +<br>
&gt; +<br>
&gt; +Examples of complete definition documentation::<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0##<br>
&gt;=C2=A0 =C2=A0# @BlockStats:<br>
&gt;=C2=A0 =C2=A0#<br>
&gt; @@ -1058,11 +1098,11 @@ For example::<br>
&gt;=C2=A0 =C2=A0#<br>
&gt;=C2=A0 =C2=A0# Since: 0.14<br>
&gt;=C2=A0 =C2=A0#<br>
&gt; - # Example:<br>
&gt; + # .. qmp-example::<br>
&gt;=C2=A0 =C2=A0#<br>
&gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;qu=
ery-blockstats&quot; }<br>
&gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0&lt;- {<br>
&gt; - #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ... lots of output ...<br>
&gt; + #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0##<br>
&gt;=C2=A0 =C2=A0{ &#39;command&#39;: &#39;query-blockstats&#39;,<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index 6ad5663e545..adc85b5b394 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -553,7 +553,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # Note: &quot;sections&quot; with two colons are left alone as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # rST markup and not interpreted as a section heading.<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # TODO: Remove this error sometime in 2025 or so<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # TODO: Remove these errors sometime in 2025 or so<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # after we&#39;ve fully transitioned to the new qapidoc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # generator.<br>
&gt;=C2=A0 <br>
&gt; @@ -567,6 +567,14 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(self, emsg)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if &#39;Example&#39; in match.group(1):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 emsg =3D (<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;The &#39;{match.group(1)}&#39; section =
is no longer &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;supported. Please use the &#39;.. qmp-ex=
ample::&#39; &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;directive, or other suitable markup inst=
ead.&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 raise QAPIParseError(self, emsg)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 doc.new_tagged_section(<a href=3D"http://self.info" rel=3D"noreferre=
r" target=3D"_blank">self.info</a>, match.group(1))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 text =3D line[match.end():]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if text:<br>
&gt; diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-g=
ood.json<br>
&gt; index 107123f8a8d..c71d65cd51f 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.json<br>
&gt; +++ b/tests/qapi-schema/doc-good.json<br>
&gt; @@ -172,12 +172,17 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 Duis aute irure dolor<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. qmp-example::<br>
&gt; +#=C2=A0 =C2=A0 :title: Ideal fast-food burger situation<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 -&gt; in<br>
&gt; -#=C2=A0 &lt;- out<br>
&gt; +#=C2=A0 =C2=A0 -&gt; &quot;in&quot;<br>
&gt; +#=C2=A0 =C2=A0 &lt;- &quot;out&quot;<br>
<br>
Heh, trickery to make the text right of -&gt; and &lt;- JSON.<br></blockquo=
te><div><br></div><div>O:-)</div><div><br></div><div>It&#39;s maybe *slight=
ly* bad form, but it does help illustrate how the new directive is transfor=
med when using text output modes in the test suite, so I kept it. The new d=
irective will simply not allow malformed JSON, so this seemed like the simp=
lest way to cheese that.<br></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt; -# Examples:<br>
&gt; +# Examples::<br>
&gt; +#<br>
&gt; +#=C2=A0 - Not a QMP code block<br>
&gt; +#=C2=A0 - Merely a preformatted code block literal<br>
&gt; +#=C2=A0 It isn&#39;t even an rST list.<br>
&gt;=C2=A0 #=C2=A0 - *verbatim*<br>
&gt;=C2=A0 #=C2=A0 - {braces}<br></blockquote><div><br></div><div>(And here=
, we test the use of non-QMP code block literals, esp. after the qmp-exampl=
e directive, proving that language settings have been restored to defaults.=
)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
&gt;=C2=A0 #<br>
&gt; @@ -199,11 +204,11 @@<br>
&gt;=C2=A0 # @cmd-feat1: a feature<br>
&gt;=C2=A0 # @cmd-feat2: another feature<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 -&gt; in<br>
&gt; +#=C2=A0 =C2=A0 -&gt; &quot;this example&quot;<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 &lt;- out<br>
&gt; +#=C2=A0 =C2=A0 &lt;- &quot;has no title&quot;<br>
<br>
Same trickery.<br></blockquote><div><br></div><div>Do you want that changed=
 ... ?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;cmd-boxed&#39;, &#39;boxed&#39;: true,=
<br>
&gt;=C2=A0 =C2=A0 &#39;data&#39;: &#39;Object&#39;,<br>
&gt; diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-go=
od.out<br>
&gt; index bd876b6542d..eee18cd436a 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.out<br>
&gt; +++ b/tests/qapi-schema/doc-good.out<br>
&gt; @@ -184,13 +184,21 @@ frobnicate<br>
&gt;=C2=A0 =C2=A0- Ut enim ad minim veniam<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0Duis aute irure dolor<br>
&gt; -=C2=A0 =C2=A0 section=3DExample<br>
&gt; - -&gt; in<br>
&gt; - &lt;- out<br>
&gt; -=C2=A0 =C2=A0 section=3DExamples<br>
&gt; +<br>
&gt; +.. qmp-example::<br>
&gt; +=C2=A0 =C2=A0:title: Ideal fast-food burger situation<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0-&gt; &quot;in&quot;<br>
&gt; +=C2=A0 =C2=A0&lt;- &quot;out&quot;<br>
&gt; +<br>
&gt; +Examples::<br>
&gt; +<br>
&gt; + - Not a QMP code block<br>
&gt; + - Merely a preformatted code block literal<br>
&gt; + It isn&#39;t even an rST list.<br>
&gt;=C2=A0 =C2=A0- *verbatim*<br>
&gt;=C2=A0 =C2=A0- {braces}<br>
&gt; -=C2=A0 =C2=A0 section=3DNone<br>
&gt; +<br>
&gt;=C2=A0 Note::<br>
&gt;=C2=A0 =C2=A0 =C2=A0Ceci n&#39;est pas une note<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DSince<br>
&gt; @@ -202,10 +210,12 @@ If you&#39;re bored enough to read this, go see =
a video of boxed cats<br>
&gt;=C2=A0 a feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Dcmd-feat2<br>
&gt;=C2=A0 another feature<br>
&gt; -=C2=A0 =C2=A0 section=3DExample<br>
&gt; - -&gt; in<br>
&gt; +=C2=A0 =C2=A0 section=3DNone<br>
&gt; +.. qmp-example::<br>
&gt;=C2=A0 <br>
&gt; - &lt;- out<br>
&gt; +=C2=A0 =C2=A0-&gt; &quot;this example&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0&lt;- &quot;has no title&quot;<br>
&gt;=C2=A0 doc symbol=3DEVT_BOXED<br>
&gt;=C2=A0 =C2=A0 =C2=A0 body=3D<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-go=
od.txt<br>
&gt; index 30d457e5488..cb37db606a6 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.txt<br>
&gt; +++ b/tests/qapi-schema/doc-good.txt<br>
&gt; @@ -217,17 +217,16 @@ Notes:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Duis aute irure dolor<br>
&gt;=C2=A0 <br>
&gt; +Example: Ideal fast-food burger situation:<br></blockquote><div><br><=
/div><div>No comment on the american making fast food burger jokes? :-(<br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 <br>
&gt; -Example<br>
&gt; -~~~~~~~<br>
&gt; +=C2=A0 =C2=A0-&gt; &quot;in&quot;<br>
&gt; +=C2=A0 =C2=A0&lt;- &quot;out&quot;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0-&gt; in<br>
&gt; -=C2=A0 =C2=A0&lt;- out<br>
&gt; -<br>
&gt; -<br>
&gt; -Examples<br>
&gt; -~~~~~~~~<br>
&gt; +Examples:<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0- Not a QMP code block<br>
&gt; +=C2=A0 =C2=A0- Merely a preformatted code block literal<br>
&gt; +=C2=A0 =C2=A0It isn&#39;t even an rST list.<br>
&gt;=C2=A0 =C2=A0 =C2=A0- *verbatim*<br>
&gt;=C2=A0 =C2=A0 =C2=A0- {braces}<br>
&gt;=C2=A0 <br>
&gt; @@ -261,13 +260,11 @@ Features<br>
&gt;=C2=A0 &quot;cmd-feat2&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0another feature<br>
&gt;=C2=A0 <br>
&gt; +Example::<br>
&gt;=C2=A0 <br>
&gt; -Example<br>
&gt; -~~~~~~~<br>
&gt; +=C2=A0 =C2=A0-&gt; &quot;this example&quot;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0-&gt; in<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0&lt;- out<br>
&gt; +=C2=A0 =C2=A0&lt;- &quot;has no title&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 &quot;EVT_BOXED&quot; (Event)<br></blockquote><div><br></div><di=
v>Does this adequately resolve your qualms about .txt rendering for example=
s?</div><div><br></div><div>--js <br></div></div></div>

--0000000000002bea3b061cd8ab7d--


