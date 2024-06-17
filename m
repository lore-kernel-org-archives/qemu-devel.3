Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE7AC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 21:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJJtB-0004g8-4E; Mon, 17 Jun 2024 17:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJJt9-0004f9-4l
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJJt6-0005HV-22
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718659659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4DTWjsqdHEquLooRH0GDqMV2SmhYU/0+qmRD4imGA4g=;
 b=OIMDG5u5BhTtLM0hXmp5zk0UK7guSOx1Ny63vQU4arDUylLSUFaq5wWWDIlsOWsNv0gi5T
 Y8aa43Ix5q+TsLyorRCgIkQtHKadJHDBOT3gdyhEsXCKqzHXU87F9Jg2t+a5LWp3SCR6zm
 IqX8t7MPdsf45ZCOQhV53V7ZItWJKi4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-cXrZIDMhPZ2WhlTSUJfIog-1; Mon, 17 Jun 2024 17:27:35 -0400
X-MC-Unique: cXrZIDMhPZ2WhlTSUJfIog-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1f98f733043so1898345ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 14:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718659649; x=1719264449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4DTWjsqdHEquLooRH0GDqMV2SmhYU/0+qmRD4imGA4g=;
 b=ANQtk/gjLAFAhOxqaaeTE0Gnbh2lx+lIAELLlDzUedErMy0o8cUMdnANrHXCFdZFJn
 HB7LQNpgaGBYRdquWS55kyAJ1EuiEko9JGlMQEE7HI6jSGdMdYhXkSOvfmxETPZINa30
 A8PEeslMvfnN2lUu1LyKD5dPOUm6Z/5gow5TvA5sgpB3U7veI0QTaejx1U2iKu2Ic09V
 IINUGElH/2HnCyOsG3CgGYPhbhpDglvkNJaOdHEsGi1BpsyLRXw/EJbWAVefiwLkSvV4
 so04aM+3/MuZ6624Kj9W9S6tmk6GP95uoz1MUjO1Fj3DIveFd5VtjCGVx6o4f6m34m3b
 TN/A==
X-Gm-Message-State: AOJu0Yz0341Tndw5KnTf3pCAziBJVy2DkZ63Kj/2bwpnxcDX61r4bBzm
 6rHgdRQ40h0bFZeh9qJ+tPWccp/H3p6nvQCCWPdgX5HJDPRIJQtTPQ1HkOzDDO8T9CeGdhUa0Gk
 3W9OUOwq/XBQ7VoD/g0OiLkKZ+eT2oE/e/qHXSE8fLzgSVybXEcV6P/x/05w0ISZPJDd+DYwngg
 eUbPcelItP8LvhYr+rlAB2abNT6jo=
X-Received: by 2002:a17:902:eccb:b0:1f7:19b7:98c6 with SMTP id
 d9443c01a7336-1f8625c065fmr136572685ad.12.1718659648868; 
 Mon, 17 Jun 2024 14:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO+6bnc7DNKvWCXWDpD74erYaPEMLNvQlzXGvTM54UwwX60UxDSGVGiUFfiQunOCcNlV9drcD9cYO7RJ18qcA=
X-Received: by 2002:a17:902:eccb:b0:1f7:19b7:98c6 with SMTP id
 d9443c01a7336-1f8625c065fmr136572275ad.12.1718659648223; Mon, 17 Jun 2024
 14:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-21-jsnow@redhat.com>
 <87r0czy4gz.fsf@pond.sub.org>
In-Reply-To: <87r0czy4gz.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Jun 2024 17:27:16 -0400
Message-ID: <CAFn=p-bdRZZtZMpN12JktjtA+tyx1wag_zdErpvEo=UXPoKa=g@mail.gmail.com>
Subject: Re: [PATCH 20/20] qapi: convert "Example" sections to rST
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
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
 qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d290b4061b1ca1b6"
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

--000000000000d290b4061b1ca1b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:39=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Eliminate the "Example" sections in QAPI doc blocks, converting them
> > into QMP example code blocks. This is generally done by converting
> > "Example:" or "Examples:" lines into ".. code-block:: QMP" lines.
> >
> > This patch does also allow for the use of the rST syntax "Example::" by
> > exempting double-colon syntax from the QAPI doc parser, but that form i=
s
> > not used by this conversion patch. The phrase "Example" here is not
> > special, it is the double-colon syntax that transforms the following
> > block into a code-block. By default, *this* form does not apply QMP
> > highlighting.
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
> > 4. Each code-block can be captioned independently without bypassing the
> >    QMP lexer/validator.
> >
> > For any sections with more than one example, examples are split up into
> > multiple code-block regions. If annotations are present, those
> > annotations are converted into code-block captions instead, e.g.
> >
> > ```
> > Examples:
> >
> >    1. Lorem Ipsum
> >
> >    -> { "foo": "bar" }
> > ```
> >
> > Is rewritten as:
> >
> > ```
> > .. code-block:: QMP
> >    :caption: Example: Lorem Ipsum
> >
> >    -> { "foo": "bar" }
> > ```
> >
> > This process was only semi-automated:
> >
> > 1. Replace "Examples?:" sections with sed:
> >
> > sed -i 's|# Example:|# .. code-block:: QMP|' *.json
> > sed -i 's|# Examples:|# .. code-block:: QMP|' *.json
> >
> > 2. Identify sections that no longer parse successfully by attempting th=
e
> >    doc build, convert annotations into captions manually.
> >    (Tedious, oh well.)
> >
> > 3. Add captions where still needed:
> >
> > sed -zi 's|# .. code-block:: QMP\n#\n|# .. code-block:: QMP\n#
> :caption: Example\n#\n|g' *.json
> >
> > Not fully ideal, but hopefully not something that has to be done very
> > often. (Or ever again.)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/acpi.json                  |   6 +-
> >  qapi/block-core.json            | 120 ++++++++++++++++----------
> >  qapi/block.json                 |  60 +++++++------
> >  qapi/char.json                  |  36 ++++++--
> >  qapi/control.json               |  16 ++--
> >  qapi/dump.json                  |  12 ++-
> >  qapi/machine-target.json        |   3 +-
> >  qapi/machine.json               |  79 ++++++++++-------
> >  qapi/migration.json             | 145 +++++++++++++++++++++++---------
> >  qapi/misc-target.json           |  33 +++++---
> >  qapi/misc.json                  |  48 +++++++----
> >  qapi/net.json                   |  30 +++++--
> >  qapi/pci.json                   |   6 +-
> >  qapi/qapi-schema.json           |   6 +-
> >  qapi/qdev.json                  |  15 +++-
> >  qapi/qom.json                   |  20 +++--
> >  qapi/replay.json                |  12 ++-
> >  qapi/rocker.json                |  12 ++-
> >  qapi/run-state.json             |  45 ++++++----
> >  qapi/tpm.json                   |   9 +-
> >  qapi/trace.json                 |   6 +-
> >  qapi/transaction.json           |   3 +-
> >  qapi/ui.json                    |  62 +++++++++-----
> >  qapi/virtio.json                |  38 +++++----
> >  qapi/yank.json                  |   6 +-
> >  scripts/qapi/parser.py          |  15 +++-
> >  tests/qapi-schema/doc-good.json |  12 +--
> >  tests/qapi-schema/doc-good.out  |  17 ++--
> >  tests/qapi-schema/doc-good.txt  |  17 +---
> >  29 files changed, 574 insertions(+), 315 deletions(-)
>
> Missing: update of docs/devel/qapi-code-gen.rst.
>
> > diff --git a/qapi/acpi.json b/qapi/acpi.json
> > index aa4dbe57943..3da01f1b7fc 100644
> > --- a/qapi/acpi.json
> > +++ b/qapi/acpi.json
> > @@ -111,7 +111,8 @@
> >  #
> >  # Since: 2.1
> >  #
> > -# Example:
> > +# .. code-block:: QMP
> > +#    :caption: Example
>
> I wish this was a bit less verbose.  Oh well, we'll live.
>

We can create a custom directive that assumes a default caption; e.g.

.. qapi:example::

    ... blah blah blah ...

And if you want to override it, you'd just

.. qapi:example::
    :caption: Lorem Ipsum ...

    ... blah blah blah ...

Interested? (I kept this patch vanilla to avoid getting fancy, but there
are fanciness options available if you'd like them.)


>
> >  #
> >  #     -> { "execute": "query-acpi-ospm-status" }
> >  #     <- { "return": [ { "device": "d1", "slot": "0", "slot-type":
> "DIMM", "source": 1, "status": 0},
>
> This is rendered as a light green box with the caption on top, in
> italics and centered.  I'm not sure I like the use of the caption.  The
> previous patch's Note boxes look nicer.
>

We can change that with styling - my dedicated CSS intern was busy with
finals when I wrote this patch ;)


>
> The contents of the box is highlighted.  I am sure I like that.
>

Yes.

[...]

> -# Example:
> > -#
> > -#     Set new histograms for all io types with intervals
> > -#     [0, 10), [10, 50), [50, 100), [100, +inf):
> > +# .. code-block:: QMP
> > +#    :caption: Example:
> > +#      Set new histograms for all io types with intervals
> > +#      [0, 10), [10, 50), [50, 100), [100, +inf):
>
> Captions long enough to be rendered as multiple lines look particularly
> bad to me.  The centering...
>

Will attempt to address it with CSS. I do agree, just wasn't time to hammer
it out.

[...]


> > @@ -134,7 +136,8 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Example:
> > +# .. code-block:: QMP
> > +#    :caption: Example
> >  #
> >  #     -> { "execute": "query-commands" }
> >  #     <- {
> > @@ -149,8 +152,8 @@
> >  #          ]
> >  #        }
> >  #
> > -#     Note: This example has been shortened as the real response is to=
o
> > -#     long.
> > +# This example has been shortened as the real response is too long.
>
> Squash into the previous patch?
>

OK

[...]


> > diff --git a/qapi/pci.json b/qapi/pci.json
> > index f51159a2c4c..9192212661b 100644
> > --- a/qapi/pci.json
> > +++ b/qapi/pci.json
> > @@ -182,7 +182,8 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Example:
> > +# .. code-block:: QMP
> > +#    :caption: Example
> >  #
> >  #     -> { "execute": "query-pci" }
> >  #     <- { "return": [
> > @@ -311,8 +312,7 @@
> >  #           ]
> >  #        }
> >  #
> > -#     Note: This example has been shortened as the real response is to=
o
> > -#     long.
> > +# This example has been shortened as the real response is too long.
>
> Squash into the previous patch?
>

OK


>
> >  #
> >  ##
> >  { 'command': 'query-pci', 'returns': ['PciInfo'] }
> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> > index 5e33da7228f..66fbcbd3619 100644
> > --- a/qapi/qapi-schema.json
> > +++ b/qapi/qapi-schema.json
> > @@ -20,11 +20,7 @@
> >  # understand.  However, in real protocol usage, they're emitted as a
> >  # single line.
> >  #
> > -# Also, the following notation is used to denote data flow:
> > -#
> > -# Example:
> > -#
> > -# ::
> > +# Also, the following notation is used to denote data flow::
> >  #
> >  #   -> data issued by the Client
> >  #   <- Server data response
>
> No use of caption here.  Looks better, I think.
>

OK - Let me play around with the styling, because I do want to have some
kind of form option available for cargo-culting to add captions or an
explanation of some kind. If I can't make it look good with CSS, I'll
capitulate and mark them up as alternating normal paragraphs and examples.

Forbidding "Examples?:" was just an easy way to make sure I converted
everything; and especially to catch any late merges ... I am hesitant to go
that route for maintainability. But, if you want to volunteer to play
whack-a-mole for the next few releases, then...

(Also, this example doesn't use the QMP lexer, because it's not real QMP.
It could be cajoled by making the lines string values, for example - or
making it a more representative example that actually resembles QMP.)


>
> > diff --git a/qapi/qdev.json b/qapi/qdev.json
> > index d031fc3590d..cfe403fea20 100644
> > --- a/qapi/qdev.json
> > +++ b/qapi/qdev.json
> > @@ -62,7 +62,8 @@
> >  #        the ``-device DEVICE,help`` command-line argument, where DEVI=
CE
> >  #        is the device's name.
> >  #
> > -# Example:
> > +# .. code-block:: QMP
> > +#    :caption: Example
> >  #
> >  #     -> { "execute": "device_add",
> >  #          "arguments": { "driver": "e1000", "id": "net1",
>
> How does
>
>    # Example:
>   +# .. code-block:: QMP
>    #
>    #     -> { "execute": "device_add",
>    #          "arguments": { "driver": "e1000", "id": "net1",
>
> look?  Requires nerfing the error you add to parser.py.
>

Undesirable, IMO -- but "Example::" alongside an option to choose the QMP
lexer by default for QMP docs may be acceptable. I can demo some choices
for you on a screenshare call if you'd like to workshop this aesthetic
choice out together.

[...]


> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 8b1da96124e..afc0b444034 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -554,9 +554,12 @@ def get_doc(self) -> 'QAPIDoc':
> >                      no_more_args =3D True
> >                      intro =3D False
> >                  elif match :=3D re.match(
> > -                        r'(Returns|Errors|Since|Notes?|Examples?|TODO)=
:
> *',
> > +
> r'(Returns|Errors|Since|Notes?|Examples?(?!::)|TODO)'
> > +                        r': *',
> >                          line):
>
> Hmm, I wonder...
>
>
> https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#l=
iteral-blocks
> has:
>
>     Literal code blocks (ref) are introduced by ending a paragraph with
>     the special marker ::.
>
> Not capturing regular rST markup like
>
>     Example::
>
>         mumble mumble
>
> for our own purposes makes sense.  But it makes exactly as much sense
> for any of the tags, doesn'it?
>
> Should we instead change the regexp to match only when there's a
> *single* colon?
>

OK. My regexp-fu is maybe weak, but I think I can just put (?!::): at the
end of this regex without tying it to Examples, and I'll move that into its
own patch.

>
>
> > -                    # tagged section
> > +                    # tagged section.
>
> Spurious comment change.
>

A *beautiful* comment change. An *inspired* comment change.

(OK, removing it...)


>
> > +                    # Examples sections followed by two colons are
> excluded;
> > +                    # those are raw rST syntax!
> >
> >                      if 'Note' in match.group(1):
> >                          emsg =3D (
> > @@ -566,6 +569,14 @@ def get_doc(self) -> 'QAPIDoc':
> >                          )
> >                          raise QAPIParseError(self, emsg)
> >
> > +                    if match.group(1).startswith("Example"):
> > +                        emsg =3D (
> > +                            f"The '{match.group(1)}' section is
> deprecated. "
> > +                            "Please use rST's '.. code-block:: QMP'
> directive,"
> > +                            " 'Example::', or other suitable markup
> instead."
> > +                        )
> > +                        raise QAPIParseError(self, emsg)
> > +
>
> I guess this will be helpful while people get used to the changed
> syntax.  Once they are, I'd like to get rid of it.  Same for "Note"
> right above.
>

Yeah - the thinking was that it would help buffer the transitional period
and could be removed after a release or two. I'll update the phrasing to
not use "deprecated", also.


>
> >                      doc.new_tagged_section(self.info, match.group(1))
> >                      text =3D line[match.end():]
> >                      if text:
> > diff --git a/tests/qapi-schema/doc-good.json
> b/tests/qapi-schema/doc-good.json
> > index 0a294eb324e..57e2e591938 100644
> > --- a/tests/qapi-schema/doc-good.json
> > +++ b/tests/qapi-schema/doc-good.json
> > @@ -46,11 +46,12 @@
> >  #
> >  # Duis aute irure dolor
> >  #
> > -# Example:
> > +# .. code-block:: QMP
>
> No captions here?
>

They aren't *required*, I just liked having a dedicated place to put 'em in
the rendered output for our real docs.

[...]


> I want this just as much as the previous patch.
>
>
okie-dokey, I'll include it in the mini-fork of the pre-req series.

--000000000000d290b4061b1ca1b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 14, 2024 at 10:39=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Eliminate the &quot;Example&quot; sections in QAPI doc blocks, convert=
ing them<br>
&gt; into QMP example code blocks. This is generally done by converting<br>
&gt; &quot;Example:&quot; or &quot;Examples:&quot; lines into &quot;.. code=
-block:: QMP&quot; lines.<br>
&gt;<br>
&gt; This patch does also allow for the use of the rST syntax &quot;Example=
::&quot; by<br>
&gt; exempting double-colon syntax from the QAPI doc parser, but that form =
is<br>
&gt; not used by this conversion patch. The phrase &quot;Example&quot; here=
 is not<br>
&gt; special, it is the double-colon syntax that transforms the following<b=
r>
&gt; block into a code-block. By default, *this* form does not apply QMP<br=
>
&gt; highlighting.<br>
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
&gt; 4. Each code-block can be captioned independently without bypassing th=
e<br>
&gt;=C2=A0 =C2=A0 QMP lexer/validator.<br>
&gt;<br>
&gt; For any sections with more than one example, examples are split up int=
o<br>
&gt; multiple code-block regions. If annotations are present, those<br>
&gt; annotations are converted into code-block captions instead, e.g.<br>
&gt;<br>
&gt; ```<br>
&gt; Examples:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 1. Lorem Ipsum<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 -&gt; { &quot;foo&quot;: &quot;bar&quot; }<br>
&gt; ```<br>
&gt;<br>
&gt; Is rewritten as:<br>
&gt;<br>
&gt; ```<br>
&gt; .. code-block:: QMP<br>
&gt;=C2=A0 =C2=A0 :caption: Example: Lorem Ipsum<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 -&gt; { &quot;foo&quot;: &quot;bar&quot; }<br>
&gt; ```<br>
&gt;<br>
&gt; This process was only semi-automated:<br>
&gt;<br>
&gt; 1. Replace &quot;Examples?:&quot; sections with sed:<br>
&gt;<br>
&gt; sed -i &#39;s|# Example:|# .. code-block:: QMP|&#39; *.json<br>
&gt; sed -i &#39;s|# Examples:|# .. code-block:: QMP|&#39; *.json<br>
&gt;<br>
&gt; 2. Identify sections that no longer parse successfully by attempting t=
he<br>
&gt;=C2=A0 =C2=A0 doc build, convert annotations into captions manually.<br=
>
&gt;=C2=A0 =C2=A0 (Tedious, oh well.)<br>
&gt;<br>
&gt; 3. Add captions where still needed:<br>
&gt;<br>
&gt; sed -zi &#39;s|# .. code-block:: QMP\n#\n|# .. code-block:: QMP\n#=C2=
=A0 =C2=A0 :caption: Example\n#\n|g&#39; *.json<br>
&gt;<br>
&gt; Not fully ideal, but hopefully not something that has to be done very<=
br>
&gt; often. (Or ever again.)<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/acpi.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 qapi/block-core.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
120 ++++++++++++++++----------<br>
&gt;=C2=A0 qapi/block.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 60 +++++++------<br>
&gt;=C2=A0 qapi/char.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 36 ++++++--<br>
&gt;=C2=A0 qapi/control.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 16 ++--<br>
&gt;=C2=A0 qapi/dump.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 12 ++-<br>
&gt;=C2=A0 qapi/machine-target.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +-<br>
&gt;=C2=A0 qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 79 ++++++++++-------<br>
&gt;=C2=A0 qapi/migration.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 145 +++++++++++++++++++++++---------<br>
&gt;=C2=A0 qapi/misc-target.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 33 +++++---<br>
&gt;=C2=A0 qapi/misc.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 48 +++++++----<br>
&gt;=C2=A0 qapi/net.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 30 +++++--<br>
&gt;=C2=A0 qapi/pci.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 qapi/qapi-schema.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 qapi/qdev.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 15 +++-<br>
&gt;=C2=A0 qapi/qom.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 20 +++--<br>
&gt;=C2=A0 qapi/replay.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 12 ++-<br>
&gt;=C2=A0 qapi/rocker.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 12 ++-<br>
&gt;=C2=A0 qapi/run-state.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 45 ++++++----<br>
&gt;=C2=A0 qapi/tpm.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 +-<br>
&gt;=C2=A0 qapi/trace.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 qapi/transaction.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 qapi/ui.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 62 +++++++++-----<br>
&gt;=C2=A0 qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 38 +++++----<br>
&gt;=C2=A0 qapi/yank.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 15 +++-<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.json |=C2=A0 12 +--<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out=C2=A0 |=C2=A0 17 ++--<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.txt=C2=A0 |=C2=A0 17 +---<br>
&gt;=C2=A0 29 files changed, 574 insertions(+), 315 deletions(-)<br>
<br>
Missing: update of docs/devel/qapi-code-gen.rst.<br>
<br>
&gt; diff --git a/qapi/acpi.json b/qapi/acpi.json<br>
&gt; index aa4dbe57943..3da01f1b7fc 100644<br>
&gt; --- a/qapi/acpi.json<br>
&gt; +++ b/qapi/acpi.json<br>
&gt; @@ -111,7 +111,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.1<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. code-block:: QMP<br>
&gt; +#=C2=A0 =C2=A0 :caption: Example<br>
<br>
I wish this was a bit less verbose.=C2=A0 Oh well, we&#39;ll live.<br></blo=
ckquote><div><br></div><div>We can create a custom directive that assumes a=
 default caption; e.g.</div><div><br></div><div>.. qapi:example::</div><div=
><br></div><div>=C2=A0=C2=A0=C2=A0 ... blah blah blah ...</div><div><br></d=
iv><div>And if you want to override it, you&#39;d just</div><div><br></div>=
<div>.. qapi:example::</div><div>=C2=A0=C2=A0=C2=A0 :caption: Lorem Ipsum .=
..</div><div><br></div><div>=C2=A0=C2=A0=C2=A0 ... blah blah blah ...</div>=
<div><br></div><div>Interested? (I kept this patch vanilla to avoid getting=
 fancy, but there are fanciness options available if you&#39;d like them.)<=
/div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;query-ac=
pi-ospm-status&quot; }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: [ { &quot;devic=
e&quot;: &quot;d1&quot;, &quot;slot&quot;: &quot;0&quot;, &quot;slot-type&q=
uot;: &quot;DIMM&quot;, &quot;source&quot;: 1, &quot;status&quot;: 0},<br>
<br>
This is rendered as a light green box with the caption on top, in<br>
italics and centered.=C2=A0 I&#39;m not sure I like the use of the caption.=
=C2=A0 The<br>
previous patch&#39;s Note boxes look nicer.<br></blockquote><div><br></div>=
<div>We can change that with styling - my dedicated CSS intern was busy wit=
h finals when I wrote this patch ;)<br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
The contents of the box is highlighted.=C2=A0 I am sure I like that.<br></b=
lockquote><div><br></div><div>Yes.<br></div><div>=C2=A0</div><div>[...]</di=
v><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; -# Example:<br>
&gt; -#<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Set new histograms for all io types with interva=
ls<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0[0, 10), [10, 50), [50, 100), [100, +inf):<br>
&gt; +# .. code-block:: QMP<br>
&gt; +#=C2=A0 =C2=A0 :caption: Example:<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 Set new histograms for all io types with interv=
als<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 [0, 10), [10, 50), [50, 100), [100, +inf):<br>
<br>
Captions long enough to be rendered as multiple lines look particularly<br>
bad to me.=C2=A0 The centering...<br></blockquote><div><br></div><div>Will =
attempt to address it with CSS. I do agree, just wasn&#39;t time to hammer =
it out.<br></div><div><br></div><div>[...] <br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
&gt; @@ -134,7 +136,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. code-block:: QMP<br>
&gt; +#=C2=A0 =C2=A0 :caption: Example<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;query-co=
mmands&quot; }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- {<br>
&gt; @@ -149,8 +152,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Note: This example has been shortened as the rea=
l response is too<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0long.<br>
&gt; +# This example has been shortened as the real response is too long.<b=
r>
<br>
Squash into the previous patch?<br></blockquote><div><br></div><div>OK</div=
><div><br></div><div>[...]<br></div><div>=C2=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; diff --git a/qapi/pci.json b/qapi/pci.json<br>
&gt; index f51159a2c4c..9192212661b 100644<br>
&gt; --- a/qapi/pci.json<br>
&gt; +++ b/qapi/pci.json<br>
&gt; @@ -182,7 +182,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. code-block:: QMP<br>
&gt; +#=C2=A0 =C2=A0 :caption: Example<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;query-pc=
i&quot; }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: [<br>
&gt; @@ -311,8 +312,7 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Note: This example has been shortened as the rea=
l response is too<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0long.<br>
&gt; +# This example has been shortened as the real response is too long.<b=
r>
<br>
Squash into the previous patch?<br></blockquote><div><br></div><div>OK<br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;query-pci&#39;, &#39;returns&#39;: [&#=
39;PciInfo&#39;] }<br>
&gt; diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json<br>
&gt; index 5e33da7228f..66fbcbd3619 100644<br>
&gt; --- a/qapi/qapi-schema.json<br>
&gt; +++ b/qapi/qapi-schema.json<br>
&gt; @@ -20,11 +20,7 @@<br>
&gt;=C2=A0 # understand.=C2=A0 However, in real protocol usage, they&#39;re=
 emitted as a<br>
&gt;=C2=A0 # single line.<br>
&gt;=C2=A0 #<br>
&gt; -# Also, the following notation is used to denote data flow:<br>
&gt; -#<br>
&gt; -# Example:<br>
&gt; -#<br>
&gt; -# ::<br>
&gt; +# Also, the following notation is used to denote data flow::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0-&gt; data issued by the Client<br>
&gt;=C2=A0 #=C2=A0 =C2=A0&lt;- Server data response<br>
<br>
No use of caption here.=C2=A0 Looks better, I think.<br></blockquote><div><=
br></div><div>OK - Let me play around with the styling, because I do want t=
o have some kind of form option available for cargo-culting to add captions=
 or an explanation of some kind. If I can&#39;t make it look good with CSS,=
 I&#39;ll capitulate and mark them up as alternating normal paragraphs and =
examples.</div><div><br></div><div>Forbidding &quot;Examples?:&quot; was ju=
st an easy way to make sure I converted everything; and especially to catch=
 any late merges ... I am hesitant to go that route for maintainability. Bu=
t, if you want to volunteer to play whack-a-mole for the next few releases,=
 then...<br></div><div><br></div><div>(Also, this example doesn&#39;t use t=
he QMP lexer, because it&#39;s not real QMP. It could be cajoled by making =
the lines string values, for example - or making it a more representative e=
xample that actually resembles QMP.)<br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/qapi/qdev.json b/qapi/qdev.json<br>
&gt; index d031fc3590d..cfe403fea20 100644<br>
&gt; --- a/qapi/qdev.json<br>
&gt; +++ b/qapi/qdev.json<br>
&gt; @@ -62,7 +62,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 the ``-device DEVICE,help`` command=
-line argument, where DEVICE<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 is the device&#39;s name.<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. code-block:: QMP<br>
&gt; +#=C2=A0 =C2=A0 :caption: Example<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;device_a=
dd&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &qu=
ot;driver&quot;: &quot;e1000&quot;, &quot;id&quot;: &quot;net1&quot;,<br>
<br>
How does<br>
<br>
=C2=A0 =C2=A0# Example:<br>
=C2=A0 +# .. code-block:: QMP<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;device=
_add&quot;,<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &=
quot;driver&quot;: &quot;e1000&quot;, &quot;id&quot;: &quot;net1&quot;,<br>
<br>
look?=C2=A0 Requires nerfing the error you add to parser.py.<br></blockquot=
e><div><br></div><div>Undesirable, IMO -- but &quot;Example::&quot; alongsi=
de an option to choose the QMP lexer by default for QMP docs may be accepta=
ble. I can demo some choices for you on a screenshare call if you&#39;d lik=
e to workshop this aesthetic choice out together.</div><div><br></div><div>=
[...]<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index 8b1da96124e..afc0b444034 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -554,9 +554,12 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 no_more_args =3D True<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 intro =3D False<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif mat=
ch :=3D re.match(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 r&#39;(Returns|Errors|Since|Notes?|Examples?|TODO): *&#39;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 r&#39;(Returns|Errors|Since|Notes?|Examples?(?!::)|TODO)&#39=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 r&#39;: *&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 line):<br>
<br>
Hmm, I wonder...<br>
<br>
<a href=3D"https://www.sphinx-doc.org/en/master/usage/restructuredtext/basi=
cs.html#literal-blocks" rel=3D"noreferrer" target=3D"_blank">https://www.sp=
hinx-doc.org/en/master/usage/restructuredtext/basics.html#literal-blocks</a=
> has:<br>
<br>
=C2=A0 =C2=A0 Literal code blocks (ref) are introduced by ending a paragrap=
h with<br>
=C2=A0 =C2=A0 the special marker ::.<br>
<br>
Not capturing regular rST markup like<br>
<br>
=C2=A0 =C2=A0 Example::<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mumble mumble<br>
<br>
for our own purposes makes sense.=C2=A0 But it makes exactly as much sense<=
br>
for any of the tags, doesn&#39;it?<br>
<br>
Should we instead change the regexp to match only when there&#39;s a<br>
*single* colon?<br></blockquote><div><br></div><div>OK. My regexp-fu is may=
be weak, but I think I can just put (?!::): at the end of this regex withou=
t tying it to Examples, and I&#39;ll move that into its own patch.<br></div=
>=C2=A0<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # tagged section<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # tagged section.<br>
<br>
Spurious comment change.<br></blockquote><div><br></div><div>A *beautiful* =
comment change. An *inspired* comment change.</div><div><br></div><div>(OK,=
 removing it...)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # Examples sections followed by two colons are excluded;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # those are raw rST syntax!<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if &#39;Note&#39; in match.group(1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 emsg =3D (<br>
&gt; @@ -566,6 +569,14 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(self, emsg)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if match.group(1).startswith(&quot;Example&quot;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 emsg =3D (<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;The &#39;{match.group(1)}&#39; section =
is deprecated. &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Please use rST&#39;s &#39;.. code-block:=
: QMP&#39; directive,&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; &#39;Example::&#39;, or other suitable =
markup instead.&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 raise QAPIParseError(self, emsg)<br>
&gt; +<br>
<br>
I guess this will be helpful while people get used to the changed<br>
syntax.=C2=A0 Once they are, I&#39;d like to get rid of it.=C2=A0 Same for =
&quot;Note&quot;<br>
right above.<br></blockquote><div><br></div><div>Yeah - the thinking was th=
at it would help buffer the transitional period and could be removed after =
a release or two. I&#39;ll update the phrasing to not use &quot;deprecated&=
quot;, also.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 doc.new_tagged_section(<a href=3D"http://self.info" rel=3D"noreferre=
r" target=3D"_blank">self.info</a>, match.group(1))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 text =3D line[match.end():]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if text:<br>
&gt; diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-g=
ood.json<br>
&gt; index 0a294eb324e..57e2e591938 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.json<br>
&gt; +++ b/tests/qapi-schema/doc-good.json<br>
&gt; @@ -46,11 +46,12 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Duis aute irure dolor<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. code-block:: QMP<br>
<br>
No captions here?<br></blockquote><div><br></div><div>They aren&#39;t *requ=
ired*, I just liked having a dedicated place to put &#39;em in the rendered=
 output for our real docs.<br></div><div>=C2=A0</div><div>[...]</div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I want this just as much as the previous patch.<br>
<br></blockquote><div><br></div><div>okie-dokey, I&#39;ll include it in the=
 mini-fork of the pre-req series. <br></div></div></div>

--000000000000d290b4061b1ca1b6--


