Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DC8C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJITR-0002YH-7M; Mon, 17 Jun 2024 15:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJITP-0002XV-76
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJITH-0006nf-3U
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718654214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oVYQAL19Zho5RN2llQBeyneluHulnLsovIOu9eFLXg4=;
 b=bCUcRB21srw/sZnyN1GnLvUjoEOGQyM2efF+M98tOW91RDcODVI4AjkingLSCbMbb/NwFc
 noXBEImyL6ReAVJPRgaRyhIxGXkilYSVjODnvn9XbBLg3MwlBY+P0vzOEGPZsXqF3I8npS
 GFf7JcEftj1QTXCxk90UA909wzdMwvE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-Ifc0mOoRMLuxIZjuf0I13w-1; Mon, 17 Jun 2024 15:56:52 -0400
X-MC-Unique: Ifc0mOoRMLuxIZjuf0I13w-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1f70b2475e7so38867695ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 12:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718654211; x=1719259011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oVYQAL19Zho5RN2llQBeyneluHulnLsovIOu9eFLXg4=;
 b=lBTowH7PCtiqOImFIDo+38etws41UfAIXvhJQFZxazpMTkJK8fp43fMAoM1pk3Z4oE
 f4TKPZGP00ZaBcmeZehKcaGG8BuyqN0dxG/DQITfM9DFWNKHPwvmzJzQ0LMEn7LrTJoP
 Pvnu5V1rBi1krabDIlJ0vHbYzNsDqcKeKfSMAVjbi3kf7GKmjyMZbfbguSQ8Jac4++2j
 ifHCZUMiZYZmXrT9bQno3pMM02ktHQRSa+9mzFDlj70p1LcxP7av+jTHUT35V5D620Un
 hZQfqikq8ho7+PnhAc9W0PVqk3bFjCFBE7Qq5tzkUsCx7nlYsPig5Fulu76A2H5pd7qK
 q9TA==
X-Gm-Message-State: AOJu0YzwXMzPrZfxZpoiQBQaxx9VOaQw2VgoS+GchTQxZ3EpHlQ3WYQZ
 1uU043Vd+A9XZ8p2nsnQCHZw3Juj//BZK19bwmHxjuc+P7HQh+/RrzyMI1VH5M0xPDBZlQZXMf0
 ss2eZbdIo+wLBru7bK+hj5r4NTUYSe5LaxyoC865hXsaRbPRDb7tDt5G4WWQPS7lZY8qHWyJlqI
 0C7pSW8SUq+4rkRuMSRRB0ks1WoTQ=
X-Received: by 2002:a17:902:e552:b0:1f7:92b:4e6f with SMTP id
 d9443c01a7336-1f8627caaf5mr120500575ad.29.1718654210319; 
 Mon, 17 Jun 2024 12:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrrCJ07Y4RNaIAPc7l2FAVwEe0M49nm+V//+PFNgqlQr4nDpZ0NLPMXZCNyFNYvrWzHU9xffgyO251H5X7kpk=
X-Received: by 2002:a17:902:e552:b0:1f7:92b:4e6f with SMTP id
 d9443c01a7336-1f8627caaf5mr120500105ad.29.1718654209517; Mon, 17 Jun 2024
 12:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-20-jsnow@redhat.com>
 <87msnnzlj8.fsf@pond.sub.org>
In-Reply-To: <87msnnzlj8.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Jun 2024 15:56:36 -0400
Message-ID: <CAFn=p-aZO54tiX=ebziayAkUZpR2wjGthpArcSOYxwz+iHU3pA@mail.gmail.com>
Subject: Re: [PATCH 19/20] qapi: convert "Note" sections to plain rST
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
Content-Type: multipart/alternative; boundary="000000000000a68a4e061b1b5dd6"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000a68a4e061b1b5dd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024, 9:44=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > We do not need a dedicated section for notes. By eliminating a speciall=
y
> > parsed section, these notes can be treated as normal rST paragraphs in
> > the new QMP reference manual, and can be placed and styled much more
> > flexibly.
> >
> > Update the QAPI parser to now prohibit special "Note" sections while
> > suggesting a new syntax.
> >
> > The exact formatting to use is a matter of taste, but a good candidate
> > is simply:
> >
> > .. note:: lorem ipsum ...
> >
> > but there are other choices, too. The Sphinx readthedocs theme offers
> > theming for the following forms (capitalization unimportant); all are
> > adorned with a (!) symbol in the title bar for rendered HTML docs.
>

Store this paragraph in your L1 cache for a moment ...

>
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
> > This patch uses ".. notes::" almost everywhere, with just two "caution"
> > directives. ".. admonition:: notes" is used in a few places where we ha=
d
> > an ordered list of multiple notes.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block-core.json                          | 30 +++----
> >  qapi/block.json                               |  2 +-
> >  qapi/char.json                                | 12 +--
> >  qapi/control.json                             | 15 ++--
> >  qapi/dump.json                                |  2 +-
> >  qapi/introspect.json                          |  6 +-
> >  qapi/machine-target.json                      | 26 +++---
> >  qapi/machine.json                             | 47 +++++-----
> >  qapi/migration.json                           | 12 +--
> >  qapi/misc.json                                | 88 +++++++++----------
> >  qapi/net.json                                 |  6 +-
> >  qapi/pci.json                                 |  7 +-
> >  qapi/qdev.json                                | 30 +++----
> >  qapi/qom.json                                 | 19 ++--
> >  qapi/rocker.json                              | 16 ++--
> >  qapi/run-state.json                           | 18 ++--
> >  qapi/sockets.json                             | 10 +--
> >  qapi/stats.json                               | 22 ++---
> >  qapi/transaction.json                         |  8 +-
> >  qapi/ui.json                                  | 29 +++---
> >  qapi/virtio.json                              | 12 +--
> >  qga/qapi-schema.json                          | 48 +++++-----
> >  scripts/qapi/parser.py                        |  9 ++
> >  tests/qapi-schema/doc-empty-section.err       |  2 +-
> >  tests/qapi-schema/doc-empty-section.json      |  2 +-
> >  tests/qapi-schema/doc-good.json               |  6 +-
> >  tests/qapi-schema/doc-good.out                | 10 ++-
> >  tests/qapi-schema/doc-good.txt                | 14 ++-
> >  .../qapi-schema/doc-interleaved-section.json  |  2 +-
> >  29 files changed, 258 insertions(+), 252 deletions(-)
>
> Missing: update of docs/devel/qapi-code-gen.rst.  Something like
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index f453bd3546..1a4e240adb 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -995,14 +995,13 @@ line "Features:", like this::
>    # @feature: Description text
>
>  A tagged section begins with a paragraph that starts with one of the
> -following words: "Note:"/"Notes:", "Since:", "Example:"/"Examples:",
> -"Returns:", "Errors:", "TODO:".  It ends with the start of a new
> -section.
> +following words: "Since:", "Example:"/"Examples:", "Returns:",
> +"Errors:", "TODO:".  It ends with the start of a new section.
>
>  The second and subsequent lines of tagged sections must be indented
>  like this::
>
> - # Note: Ut enim ad minim veniam, quis nostrud exercitation ullamco
> + # TODO: Ut enim ad minim veniam, quis nostrud exercitation ullamco
>   #     laboris nisi ut aliquip ex ea commodo consequat.
>   #
>   #     Duis aute irure dolor in reprehenderit in voluptate velit esse
>
>
Done.


> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 64fe5240cc9..530af40404d 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -1510,7 +1510,7 @@
> >  # @mode: whether and how QEMU should create a new image, default is
> >  #     'absolute-paths'.
> >  #
> > -# Note: Either @device or @node-name must be set but not both.
> > +# .. note:: Either @device or @node-name must be set but not both.
>
> The commit message talks about ".. Note::", but you actually use
> ".. note::".  Is there a difference?
>

Retrieve paragraph from L1 cache.

Nope! Sphinx RTD theme docs use capitals sporadically, but it's case
insensitive. I stuck with all lowercase everywhere in the patches, but the
capitalization in the commit message came directly from the Sphinx RTD
theme documentation.


> >  #
> >  ##
> >  { 'struct': 'BlockdevSnapshotSync',
> > @@ -1616,9 +1616,9 @@
> >  #
> >  # @unstable: Member @x-perf is experimental.
> >  #
> > -# Note: @on-source-error and @on-target-error only affect background
> > -#     I/O.  If an error occurs during a guest write request, the
> > -#     device's rerror/werror actions will be used.
> > +# .. note:: @on-source-error and @on-target-error only affect backgrou=
nd
> > +#    I/O.  If an error occurs during a guest write request, the device=
's
> > +#    rerror/werror actions will be used.
> >  #
> >  # Since: 4.2
> >  ##
> > @@ -5534,8 +5534,8 @@
> >  #     after this event and must be repaired (Since 2.2; before, every
> >  #     BLOCK_IMAGE_CORRUPTED event was fatal)
> >  #
> > -# Note: If action is "stop", a STOP event will eventually follow the
> > -#     BLOCK_IO_ERROR event.
> > +# .. note:: If action is "stop", a STOP event will eventually follow t=
he
> > +#    BLOCK_IO_ERROR event.
> >  #
> >  # Example:
> >  #
> > @@ -5581,8 +5581,8 @@
> >  #     field is a debugging aid for humans, it should not be parsed by
> >  #     applications) (since: 2.2)
> >  #
> > -# Note: If action is "stop", a STOP event will eventually follow the
> > -#     BLOCK_IO_ERROR event
> > +# .. note:: If action is "stop", a STOP event will eventually follow t=
he
> > +#    BLOCK_IO_ERROR event.
>
> You're adding a period.  Okay, but please mention it in the commit
> message.
>

OK. When hoisting notes into little visual boxes I felt it looked naked
without the punctuation, so I just went for it. Sorry.


> >  #
> >  # Since: 0.13
> >  #
> > @@ -5720,8 +5720,8 @@
> >  #
> >  # @speed: rate limit, bytes per second
> >  #
> > -# Note: The "ready to complete" status is always reset by a
> > -#     @BLOCK_JOB_ERROR event
> > +# .. note:: The "ready to complete" status is always reset by a
> > +#    @BLOCK_JOB_ERROR event.
>
> Likewise.  Not going to point this out again.
>

I just need to update the commit message, yeah?.


> >  #
> >  # Since: 1.3
> >  #
> > @@ -5974,7 +5974,7 @@
> >  #
> >  # @sectors-count: failed read operation sector count
> >  #
> > -# Note: This event is rate-limited.
> > +# .. note:: This event is rate-limited.
> >  #
> >  # Since: 2.0
> >  #
> > @@ -6005,7 +6005,7 @@
> >  #
> >  # @sectors-count: failed read operation sector count
> >  #
> > -# Note: This event is rate-limited.
> > +# .. note:: This event is rate-limited.
> >  #
> >  # Since: 2.0
> >  #
> > @@ -6037,9 +6037,9 @@
> >  #
> >  # @name: the name of the internal snapshot to be created
> >  #
> > -# Notes: In transaction, if @name is empty, or any snapshot matching
> > -#     @name exists, the operation will fail.  Only some image formats
> > -#     support it, for example, qcow2, and rbd.
> > +# .. note:: In a transaction, if @name is empty or any snapshot matchi=
ng
> > +#    @name exists, the operation will fail.  Only some image formats
> > +#    support it; for example, qcow2, and rbd.
>
> You're fixing up prose.  Welcome, but put it in a separate patch,
> please, to keep this one mechanical.
>

Couldn't help it while auditing every last notebox. (:

OK, separate patch...


> >  #
> >  # Since: 1.7
> >  ##
> > diff --git a/qapi/block.json b/qapi/block.json
> > index 5de99fe09d9..ea81d9e1921 100644
> > --- a/qapi/block.json
> > +++ b/qapi/block.json
> > @@ -113,7 +113,7 @@
> >  # Errors:
> >  #     - If @device is not a valid block device, DeviceNotFound
> >  #
> > -# Notes: Ejecting a device with no media results in success
> > +# .. note:: Ejecting a device with no media results in success.
> >  #
> >  # Since: 0.14
> >  #
> > diff --git a/qapi/char.json b/qapi/char.json
> > index ab4c23976ed..0f39c2d5cdf 100644
> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -21,8 +21,8 @@
> >  #     backend (e.g. with the chardev=3D... option) is in open or close=
d
> >  #     state (since 2.1)
> >  #
> > -# Notes: @filename is encoded using the QEMU command line character
> > -#     device encoding.  See the QEMU man page for details.
> > +# .. note:: @filename is encoded using the QEMU command line character
> > +#    device encoding.  See the QEMU man page for details.
> >  #
> >  # Since: 0.14
> >  ##
> > @@ -387,9 +387,9 @@
> >  #
> >  # @rows: console height, in chars
> >  #
> > -# Note: the options are only effective when the VNC or SDL graphical
> > -#     display backend is active.  They are ignored with the GTK,
> > -#     Spice, VNC and D-Bus display backends.
> > +# .. note:: The options are only effective when the VNC or SDL graphic=
al
> > +#    display backend is active.  They are ignored with the GTK, Spice,
> > +#    VNC and D-Bus display backends.
>
> You're capitalizing the beginning of the note text.  Good, because the
> generated HTML wants that.  But please mention it in the commit message.
>
> More below; not going to point it out.
>

OK; so long as the commit message mentions it, we don't need to make note
of each time I do it, right...?


> >  #
> >  # Since: 1.5
> >  ##
> > @@ -805,7 +805,7 @@
> >  #
> >  # @open: true if the guest has opened the virtio-serial port
> >  #
> > -# Note: This event is rate-limited.
> > +# .. note:: This event is rate-limited.
> >  #
> >  # Since: 2.1
> >  #
> > diff --git a/qapi/control.json b/qapi/control.json
> > index 10c906fa0e7..2498e5dd6ba 100644
> > --- a/qapi/control.json
> > +++ b/qapi/control.json
> > @@ -22,14 +22,13 @@
> >  #          "arguments": { "enable": [ "oob" ] } }
> >  #     <- { "return": {} }
> >  #
> > -# Notes: This command is valid exactly when first connecting: it must
> > -#     be issued before any other command will be accepted, and will
> > -#     fail once the monitor is accepting other commands.  (see qemu
> > -#     docs/interop/qmp-spec.rst)
> > +# .. note:: This command is valid exactly when first connecting: it mu=
st
> > +#    be issued before any other command will be accepted, and will fai=
l
> > +#    once the monitor is accepting other commands.
> > +#    (see :doc:`/interop/qmp-spec`)
>
> You're adding markup to make a reference work.  Welcome, but put it in a
> separate patch, please, to keep this one mechanical.
>

Whoops. This snuck in. I do have a growing markup change patch...


> >  #
> > -#     The QMP client needs to explicitly enable QMP capabilities,
> > -#     otherwise all the QMP capabilities will be turned off by
> > -#     default.
> > +# .. note:: The QMP client needs to explicitly enable QMP capabilities=
,
> > +#    otherwise all the QMP capabilities will be turned off by default.
> >  #
> >  # Since: 0.13
> >  ##
> > @@ -150,7 +149,7 @@
> >  #          ]
> >  #        }
> >  #
> > -# Note: This example has been shortened as the real response is too
> > +#     Note: This example has been shortened as the real response is to=
o
> >  #     long.
>
> Your commit message lists a number of conversions.  This one isn't among
> them.
>
> The next patch reverts the indentation and drops "Note: ":
>
>    -#     Note: This example has been shortened as the real response is t=
oo
>    -#     long.
>    +# This example has been shortened as the real response is too long.
>
> Hmm.  Swap the two patches?  Perhaps not worth the bother now.  Squash
> the next patch's change into this one?
>

Yeah, OK. (The problem was that this began being picked up as a note
section in its own right, but I thought it wasn't appropriate in this case,
but needed to avoid the parser complaining about the old Note: section.)


> A few more below.
>
> >  ##
> >  { 'command': 'query-commands', 'returns': ['CommandInfo'],
> > diff --git a/qapi/dump.json b/qapi/dump.json
> > index 2fa9504d864..f9aee7ea1dd 100644
> > --- a/qapi/dump.json
> > +++ b/qapi/dump.json
> > @@ -90,7 +90,7 @@
> >  #     and @length is not allowed to be specified with non-elf @format
> >  #     at the same time (since 2.0)
> >  #
> > -# Note: All boolean arguments default to false
> > +# .. note:: All boolean arguments default to false.
> >  #
> >  # Since: 1.2
> >  #
> > diff --git a/qapi/introspect.json b/qapi/introspect.json
> > index b041b02ba8c..b15052ec21a 100644
> > --- a/qapi/introspect.json
> > +++ b/qapi/introspect.json
> > @@ -41,9 +41,9 @@
> >  #     names are guaranteed to be unique (no name will be duplicated
> >  #     with different meta-types).
> >  #
> > -# Note: the QAPI schema is also used to help define *internal*
> > -#     interfaces, by defining QAPI types.  These are not part of the
> > -#     QMP wire ABI, and therefore not returned by this command.
> > +# .. note:: The QAPI schema is also used to help define *internal*
> > +#    interfaces, by defining QAPI types.  These are not part of the QM=
P
> > +#    wire ABI, and therefore not returned by this command.
> >  #
> >  # Since: 2.5
> >  ##
> > diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> > index 29428530923..a8d9ec87f59 100644
> > --- a/qapi/machine-target.json
> > +++ b/qapi/machine-target.json
> > @@ -49,15 +49,15 @@
> >  #     to be migration-safe, but allows tooling to get an insight and
> >  #     work with model details.
> >  #
> > -# Note: When a non-migration-safe CPU model is expanded in static
> > -#     mode, some features enabled by the CPU model may be omitted,
> > -#     because they can't be implemented by a static CPU model
> > -#     definition (e.g. cache info passthrough and PMU passthrough in
> > -#     x86). If you need an accurate representation of the features
> > -#     enabled by a non-migration-safe CPU model, use @full.  If you
> > -#     need a static representation that will keep ABI compatibility
> > -#     even when changing QEMU version or machine-type, use @static
> > -#     (but keep in mind that some features may be omitted).
> > +# .. note:: When a non-migration-safe CPU model is expanded in static
> > +#    mode, some features enabled by the CPU model may be omitted,
> > +#    because they can't be implemented by a static CPU model definitio=
n
> > +#    (e.g. cache info passthrough and PMU passthrough in x86). If you
> > +#    need an accurate representation of the features enabled by a
> > +#    non-migration-safe CPU model, use @full.  If you need a static
> > +#    representation that will keep ABI compatibility even when changin=
g
> > +#    QEMU version or machine-type, use @static (but keep in mind that
> > +#    some features may be omitted).
> >  #
> >  # Since: 2.8
> >  ##
> > @@ -175,8 +175,8 @@
> >  #     - if a model contains an unknown cpu definition name, unknown
> >  #       properties or properties with wrong types.
> >  #
> > -# Note: this command isn't specific to s390x, but is only implemented
> > -#     on this architecture currently.
> > +# .. note:: This command isn't specific to s390x, but is only
> > +#    implemented on this architecture currently.
> >  #
> >  # Since: 2.8
> >  ##
> > @@ -229,8 +229,8 @@
> >  #     - if a model contains an unknown cpu definition name, unknown
> >  #       properties or properties with wrong types.
> >  #
> > -# Note: this command isn't specific to s390x, but is only implemented
> > -#     on this architecture currently.
> > +# .. note:: This command isn't specific to s390x, but is only
> > +#    implemented on this architecture currently.
> >  #
> >  # Since: 2.8
> >  ##
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 35cca12ba41..e9c9bef940d 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -24,9 +24,9 @@
> >  #
> >  # @avr: since 5.1
> >  #
> > -# Notes: The resulting QMP strings can be appended to the
> > -#     "qemu-system-" prefix to produce the corresponding QEMU
> > -#     executable name.  This is true even for "qemu-system-x86_64".
> > +# .. note:: The resulting QMP strings can be appended to the
> > +#    "qemu-system-" prefix to produce the corresponding QEMU executabl=
e
> > +#    name.  This is true even for "qemu-system-x86_64".
> >  #
> >  # Since: 3.0
> >  ##
> > @@ -305,8 +305,9 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Notes: If no UUID was specified for the guest, a null UUID is
> > -#     returned.
> > +# .. note:: If no UUID was specified for the guest, a null UUID is
> > +#    returned.
> > +#
> >  ##
> >  { 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
> >
> > @@ -367,10 +368,10 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Notes: A guest may or may not respond to this command.  This command
> > -#     returning does not indicate that a guest has accepted the
> > -#     request or that it has shut down.  Many guests will respond to
> > -#     this command by prompting the user in some way.
> > +# .. note:: A guest may or may not respond to this command.  This
> > +#    command returning does not indicate that a guest has accepted the
> > +#    request or that it has shut down.  Many guests will respond to th=
is
> > +#    command by prompting the user in some way.
> >  #
> >  # Example:
> >  #
> > @@ -389,8 +390,8 @@
> >  #
> >  # Since: 1.1
> >  #
> > -# Note: prior to 4.0, this command does nothing in case the guest
> > -#     isn't suspended.
> > +# .. note:: Prior to 4.0, this command does nothing in case the guest
> > +#    isn't suspended.
> >  #
> >  # Example:
> >  #
> > @@ -440,8 +441,8 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Note: prior to 2.1, this command was only supported for x86 and s390
> > -#     VMs
> > +# .. note:: Prior to 2.1, this command was only supported for x86 and
> > +#    s390 VMs
> >  #
> >  # Example:
> >  #
> > @@ -838,7 +839,7 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Notes: Errors were not reliably returned until 1.1
> > +# .. caution:: Errors were not reliably returned until 1.1.
> >  #
> >  # Example:
> >  #
> > @@ -864,7 +865,7 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Notes: Errors were not reliably returned until 1.1
> > +# .. caution:: Errors were not reliably returned until 1.1.
> >  #
> >  # Example:
> >  #
> > @@ -994,8 +995,8 @@
> >  #
> >  # @thread-id: thread number within the core the CPU  belongs to
> >  #
> > -# Note: management should be prepared to pass through additional
> > -#     properties with device_add.
> > +# .. note:: Management should be prepared to pass through additional
> > +#    properties with device_add.
> >  #
> >  # Since: 2.7
> >  ##
> > @@ -1122,9 +1123,9 @@
> >  #       the KVM kernel module cannot support it, KVMMissingCap
> >  #     - If no balloon device is present, DeviceNotActive
> >  #
> > -# Notes: This command just issues a request to the guest.  When it
> > -#     returns, the balloon size may not have changed.  A guest can
> > -#     change the balloon size independent of this command.
> > +# .. note:: This command just issues a request to the guest.  When it
> > +#    returns, the balloon size may not have changed.  A guest can chan=
ge
> > +#    the balloon size independent of this command.
> >  #
> >  # Since: 0.14
> >  #
> > @@ -1184,7 +1185,7 @@
> >  # @actual: the logical size of the VM in bytes Formula used:
> >  #     logical_vm_size =3D vm_ram_size - balloon_size
> >  #
> > -# Note: this event is rate-limited.
> > +# .. note:: This event is rate-limited.
> >  #
> >  # Since: 1.2
> >  #
> > @@ -1246,7 +1247,7 @@
> >  # Emitted when the hv-balloon driver receives a "STATUS" message from
> >  # the guest.
> >  #
> > -# Note: this event is rate-limited.
> > +# .. note:: This event is rate-limited.
> >  #
> >  # Since: 8.2
> >  #
> > @@ -1591,7 +1592,7 @@
> >  #
> >  # @qom-path: path to the device object in the QOM tree (since 6.2)
> >  #
> > -# Note: this event is rate-limited.
> > +# .. note:: This event is rate-limited.
> >  #
> >  # Since: 5.1
> >  #
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 89047d46c7c..a7b8ff138e3 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1428,8 +1428,8 @@
> >  #
> >  # Cancel the current executing migration process.
> >  #
> > -# Notes: This command succeeds even if there is no migration process
> > -#     running.
> > +# .. note:: This command succeeds even if there is no migration proces=
s
> > +#    running.
> >  #
> >  # Since: 0.14
> >  #
> > @@ -1561,16 +1561,16 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Notes:
> > +# .. admonition:: Notes
> >  #
> >  #     1. The 'query-migrate' command should be used to check
> >  #        migration's progress and final result (this information is
> >  #        provided by the 'status' member)
> >  #
> > -#     2. All boolean arguments default to false
> > +#     2. All boolean arguments default to false.
> >  #
> >  #     3. The user Monitor's "detach" argument is invalid in QMP and
> > -#        should not be used
> > +#        should not be used.
> >  #
> >  #     4. The uri argument should have the Uniform Resource Identifier
> >  #        of default destination VM. This connection will be bound to
> > @@ -1644,7 +1644,7 @@
> >  #
> >  # Since: 2.3
> >  #
> > -# Notes:
> > +# .. admonition:: Notes
> >  #
> >  #     1. It's a bad idea to use a string for the uri, but it needs to
> >  #        stay compatible with -incoming and the format of the uri is
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 4b41e15dcd4..b04efbadec6 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -103,9 +103,9 @@
> >  #
> >  # Returns a list of information about each iothread.
> >  #
> > -# Note: this list excludes the QEMU main loop thread, which is not
> > -#     declared using the -object iothread command-line option.  It is
> > -#     always the main thread of the process.
> > +# .. note:: This list excludes the QEMU main loop thread, which is not
> > +#    declared using the ``-object iothread`` command-line option.  It =
is
> > +#    always the main thread of the process.
>
> You're adding markup.  Welcome, but put it in a separate patch, please,
> to keep this one mechanical.
>

OK


> >  #
> >  # Returns: a list of @IOThreadInfo for each iothread
> >  #
> > @@ -136,13 +136,13 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Notes: This function will succeed even if the guest is already in
> > -#     the stopped state.  In "inmigrate" state, it will ensure that
> > -#     the guest remains paused once migration finishes, as if the -S
> > -#     option was passed on the command line.
> > +# .. note:: This function will succeed even if the guest is already in
> > +#    the stopped state.  In "inmigrate" state, it will ensure that the
> > +#    guest remains paused once migration finishes, as if the ``-S``
> > +#    option was passed on the command line.
>
> Likewise.
>

;_;


> >  #
> > -#     In the "suspended" state, it will completely stop the VM and
> > -#     cause a transition to the "paused" state.  (Since 9.0)
> > +#    In the "suspended" state, it will completely stop the VM and caus=
e
> > +#    a transition to the "paused" state.  (Since 9.0)
> >  #
> >  # Example:
> >  #
> > @@ -158,15 +158,15 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Notes: This command will succeed if the guest is currently running.
> > -#     It will also succeed if the guest is in the "inmigrate" state;
> > -#     in this case, the effect of the command is to make sure the
> > -#     guest starts once migration finishes, removing the effect of the
> > -#     -S command line option if it was passed.
> > +# .. note:: This command will succeed if the guest is currently runnin=
g.
> > +#    It will also succeed if the guest is in the "inmigrate" state; in
> > +#    this case, the effect of the command is to make sure the guest
> > +#    starts once migration finishes, removing the effect of the ``-S``
> > +#    command line option if it was passed.
>
> Likewise.
>
> >  #
> > -#     If the VM was previously suspended, and not been reset or woken,
> > -#     this command will transition back to the "suspended" state.
> > -#     (Since 9.0)
> > +#    If the VM was previously suspended, and not been reset or woken,
> > +#    this command will transition back to the "suspended" state.  (Sin=
ce
> > +#    9.0)
> >  #
> >  # Example:
> >  #
> > @@ -219,18 +219,18 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Notes: This command only exists as a stop-gap.  Its use is highly
> > -#     discouraged.  The semantics of this command are not guaranteed:
> > -#     this means that command names, arguments and responses can
> > -#     change or be removed at ANY time.  Applications that rely on
> > -#     long term stability guarantees should NOT use this command.
> > +# .. note:: This command only exists as a stop-gap.  Its use is highly
> > +#    discouraged.  The semantics of this command are not guaranteed:
> > +#    this means that command names, arguments and responses can change
> > +#    or be removed at ANY time.  Applications that rely on long term
> > +#    stability guarantees should NOT use this command.
> >  #
> > -#     Known limitations:
> > +#    Known limitations:
> >  #
> > -#     * This command is stateless, this means that commands that
> > -#       depend on state information (such as getfd) might not work
> > +#    * This command is stateless, this means that commands that
> > +#      depend on state information (such as getfd) might not work.
> >  #
> > -#     * Commands that prompt the user for data don't currently work
> > +#    * Commands that prompt the user for data don't currently work.
> >  #
> >  # Example:
> >  #
> > @@ -252,11 +252,11 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Notes: If @fdname already exists, the file descriptor assigned to it
> > -#     will be closed and replaced by the received file descriptor.
> > +# .. note:: If @fdname already exists, the file descriptor assigned to
> > +#    it will be closed and replaced by the received file descriptor.
> >  #
> > -#     The 'closefd' command can be used to explicitly close the file
> > -#     descriptor when it is no longer needed.
> > +#    The 'closefd' command can be used to explicitly close the file
> > +#    descriptor when it is no longer needed.
> >  #
> >  # Example:
> >  #
> > @@ -279,11 +279,11 @@
> >  #
> >  # Since: 8.0
> >  #
> > -# Notes: If @fdname already exists, the file descriptor assigned to it
> > -#     will be closed and replaced by the received file descriptor.
> > +# .. note:: If @fdname already exists, the file descriptor assigned to
> > +#    it will be closed and replaced by the received file descriptor.
> >  #
> > -#     The 'closefd' command can be used to explicitly close the file
> > -#     descriptor when it is no longer needed.
> > +#    The 'closefd' command can be used to explicitly close the file
> > +#    descriptor when it is no longer needed.
> >  #
> >  # Example:
> >  #
> > @@ -339,10 +339,9 @@
> >  #     - If file descriptor was not received, GenericError
> >  #     - If @fdset-id is a negative value, GenericError
> >  #
> > -# Notes:
> > -#     The list of fd sets is shared by all monitor connections.
> > +# .. note:: The list of fd sets is shared by all monitor connections.
> >  #
> > -#     If @fdset-id is not specified, a new fd set will be created.
> > +# .. note:: If @fdset-id is not specified, a new fd set will be create=
d.
> >  #
> >  # Since: 1.2
> >  #
> > @@ -370,11 +369,10 @@
> >  #
> >  # Since: 1.2
> >  #
> > -# Notes:
> > -#     The list of fd sets is shared by all monitor connections.
> > +# .. note:: The list of fd sets is shared by all monitor connections.
> >  #
> > -#     If @fd is not specified, all file descriptors in @fdset-id will
> > -#     be removed.
> > +# .. note:: If @fd is not specified, all file descriptors in @fdset-id
> > +#    will be removed.
> >  #
> >  # Example:
> >  #
> > @@ -420,7 +418,7 @@
> >  #
> >  # Since: 1.2
> >  #
> > -# Note: The list of fd sets is shared by all monitor connections.
> > +# .. note:: The list of fd sets is shared by all monitor connections.
> >  #
> >  # Example:
> >  #
> > @@ -561,9 +559,9 @@
> >  #
> >  # @qom-path: path to the RTC object in the QOM tree
> >  #
> > -# Note: This event is rate-limited.  It is not guaranteed that the RTC
> > -#     in the system implements this event, or even that the system has
> > -#     an RTC at all.
> > +# .. note:: This event is rate-limited.  It is not guaranteed that the
> > +#    RTC in the system implements this event, or even that the system
> > +#    has an RTC at all.
> >  #
> >  # Since: 0.13
> >  #
> > diff --git a/qapi/net.json b/qapi/net.json
> > index dc616d010f0..4ac7fdc7e6c 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -22,9 +22,9 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Notes: Not all network adapters support setting link status.  This
> > -#     command will succeed even if the network adapter does not
> > -#     support link status notification.
> > +# .. note:: Not all network adapters support setting link status.  Thi=
s
> > +#    command will succeed even if the network adapter does not support
> > +#    link status notification.
> >  #
> >  # Example:
> >  #
> > diff --git a/qapi/pci.json b/qapi/pci.json
> > index 08bf6958634..f51159a2c4c 100644
> > --- a/qapi/pci.json
> > +++ b/qapi/pci.json
> > @@ -146,8 +146,8 @@
> >  #
> >  # @regions: a list of the PCI I/O regions associated with the device
> >  #
> > -# Notes: the contents of @class_info.desc are not stable and should
> > -#     only be treated as informational.
> > +# .. note:: The contents of @class_info.desc are not stable and should
> > +#    only be treated as informational.
> >  #
> >  # Since: 0.14
> >  ##
> > @@ -311,7 +311,8 @@
> >  #           ]
> >  #        }
> >  #
> > -# Note: This example has been shortened as the real response is too
> > +#     Note: This example has been shortened as the real response is to=
o
> >  #     long.
> > +#
> >  ##
> >  { 'command': 'query-pci', 'returns': ['PciInfo'] }
> > diff --git a/qapi/qdev.json b/qapi/qdev.json
> > index facaa0bc6a2..d031fc3590d 100644
> > --- a/qapi/qdev.json
> > +++ b/qapi/qdev.json
> > @@ -20,9 +20,9 @@
> >  # Returns: a list of ObjectPropertyInfo describing a devices
> >  #     properties
> >  #
> > -# Note: objects can create properties at runtime, for example to
> > -#     describe links between different devices and/or objects.  These
> > -#     properties are not included in the output of this command.
> > +# .. note:: Objects can create properties at runtime, for example to
> > +#    describe links between different devices and/or objects.  These
> > +#    properties are not included in the output of this command.
> >  #
> >  # Since: 1.2
> >  ##
> > @@ -51,7 +51,7 @@
> >  #     supports JSON syntax without the reference counting leak that
> >  #     broke hot-unplug
> >  #
> > -# Notes:
> > +# .. admonition:: Notes
> >  #
> >  #     1. Additional arguments depend on the type.
> >  #
> > @@ -59,8 +59,8 @@
> >  #        the 'docs/qdev-device-use.txt' file.
> >  #
> >  #     3. It's possible to list device properties by running QEMU with
> > -#        the "-device DEVICE,help" command-line argument, where DEVICE
> > -#        is the device's name
> > +#        the ``-device DEVICE,help`` command-line argument, where DEVI=
CE
> > +#        is the device's name.
>
> Likewise.
>
> >  #
> >  # Example:
> >  #
> > @@ -92,15 +92,15 @@
> >  # Errors:
> >  #     - If @id is not a valid device, DeviceNotFound
> >  #
> > -# Notes: When this command completes, the device may not be removed
> > -#     from the guest.  Hot removal is an operation that requires guest
> > -#     cooperation.  This command merely requests that the guest begin
> > -#     the hot removal process.  Completion of the device removal
> > -#     process is signaled with a DEVICE_DELETED event.  Guest reset
> > -#     will automatically complete removal for all devices.  If a
> > -#     guest-side error in the hot removal process is detected, the
> > -#     device will not be removed and a DEVICE_UNPLUG_GUEST_ERROR event
> > -#     is sent.  Some errors cannot be detected.
> > +# .. note:: When this command completes, the device may not be removed
> > +#    from the guest.  Hot removal is an operation that requires guest
> > +#    cooperation.  This command merely requests that the guest begin t=
he
> > +#    hot removal process.  Completion of the device removal process is
> > +#    signaled with a DEVICE_DELETED event.  Guest reset will
> > +#    automatically complete removal for all devices.  If a guest-side
> > +#    error in the hot removal process is detected, the device will not
> > +#    be removed and a DEVICE_UNPLUG_GUEST_ERROR event is sent.  Some
> > +#    errors cannot be detected.
> >  #
> >  # Since: 0.14
> >  #
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 8f0601859b1..e927f4a3c5d 100644
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
> >  { 'command': 'qom-list-properties',
> > @@ -608,12 +608,11 @@
> >  #     older to allow migration with newer QEMU versions.
> >  #     (default: false generally, but true for machine types <=3D 4.0)
> >  #
> > -# Note: prealloc=3Dtrue and reserve=3Dfalse cannot be set at the same
> > -#     time.  With reserve=3Dtrue, the behavior depends on the operatin=
g
> > -#     system: for example, Linux will not reserve swap space for
> > -#     shared file mappings -- "not applicable". In contrast,
> > -#     reserve=3Dfalse will bail out if it cannot be configured
> > -#     accordingly.
> > +# .. note:: prealloc=3Dtrue and reserve=3Dfalse cannot be set at the s=
ame
> > +#    time.  With reserve=3Dtrue, the behavior depends on the operating
> > +#    system: for example, Linux will not reserve swap space for shared
> > +#    file mappings -- "not applicable". In contrast, reserve=3Dfalse w=
ill
> > +#    bail out if it cannot be configured accordingly.
> >  #
> >  # Since: 2.1
> >  ##
> > diff --git a/qapi/rocker.json b/qapi/rocker.json
> > index f5225eb62cc..9f95e638309 100644
> > --- a/qapi/rocker.json
> > +++ b/qapi/rocker.json
> > @@ -138,8 +138,8 @@
> >  #
> >  # @ip-dst: IP header destination address
> >  #
> > -# Note: optional members may or may not appear in the flow key
> > -#     depending if they're relevant to the flow key.
> > +# .. note:: Optional members may or may not appear in the flow key
> > +#    depending if they're relevant to the flow key.
> >  #
> >  # Since: 2.4
> >  ##
> > @@ -168,8 +168,8 @@
> >  #
> >  # @ip-tos: IP header TOS field
> >  #
> > -# Note: optional members may or may not appear in the flow mask
> > -#     depending if they're relevant to the flow mask.
> > +# .. note:: Optional members may or may not appear in the flow mask
> > +#    depending if they're relevant to the flow mask.
> >  #
> >  # Since: 2.4
> >  ##
> > @@ -195,8 +195,8 @@
> >  #
> >  # @out-pport: physical output port
> >  #
> > -# Note: optional members may or may not appear in the flow action
> > -#     depending if they're relevant to the flow action.
> > +# .. note:: Optional members may or may not appear in the flow action
> > +#    depending if they're relevant to the flow action.
> >  #
> >  # Since: 2.4
> >  ##
> > @@ -288,8 +288,8 @@
> >  #
> >  # @ttl-check: perform TTL check
> >  #
> > -# Note: optional members may or may not appear in the group depending
> > -#     if they're relevant to the group type.
> > +# .. note:: Optional members may or may not appear in the group
> depending
> > +#    if they're relevant to the group type.
> >  #
> >  # Since: 2.4
> >  ##
> > diff --git a/qapi/run-state.json b/qapi/run-state.json
> > index f8773f23b29..252d7d6afa7 100644
> > --- a/qapi/run-state.json
> > +++ b/qapi/run-state.json
> > @@ -146,9 +146,9 @@
> >  # @reason: The @ShutdownCause which resulted in the SHUTDOWN.
> >  #     (since 4.0)
> >  #
> > -# Note: If the command-line option "-no-shutdown" has been specified,
> > -#     qemu will not exit, and a STOP event will eventually follow the
> > -#     SHUTDOWN event
> > +# .. note:: If the command-line option ``-no-shutdown`` has been
> > +#    specified, qemu will not exit, and a STOP event will eventually
> > +#    follow the SHUTDOWN event.
>
> Likewise.
>
> >  #
> >  # Since: 0.12
> >  #
> > @@ -247,8 +247,8 @@
> >  # saved on disk, for example, S4 state, which is sometimes called
> >  # hibernate state
> >  #
> > -# Note: QEMU shuts down (similar to event @SHUTDOWN) when entering
> > -#     this state
> > +# .. note:: QEMU shuts down (similar to event @SHUTDOWN) when entering
> > +#    this state.
> >  #
> >  # Since: 1.2
> >  #
> > @@ -281,11 +281,11 @@
> >  #
> >  # @action: action that has been taken
> >  #
> > -# Note: If action is "reset", "shutdown", or "pause" the WATCHDOG
> > -#     event is followed respectively by the RESET, SHUTDOWN, or STOP
> > -#     events
> > +# .. note:: If action is "reset", "shutdown", or "pause" the WATCHDOG
> > +#    event is followed respectively by the RESET, SHUTDOWN, or STOP
> > +#    events.
> >  #
> > -# Note: This event is rate-limited.
> > +# .. note:: This event is rate-limited.
> >  #
> >  # Since: 0.13
> >  #
> > diff --git a/qapi/sockets.json b/qapi/sockets.json
> > index aa97c897687..f46113ab1b8 100644
> > --- a/qapi/sockets.json
> > +++ b/qapi/sockets.json
> > @@ -104,8 +104,8 @@
> >  #
> >  # @port: port
> >  #
> > -# Note: string types are used to allow for possible future hostname or
> > -#     service resolution support.
> > +# .. note:: string types are used to allow for possible future hostnam=
e
> > +#    or service resolution support.
> >  #
> >  # Since: 2.8
> >  ##
> > @@ -179,9 +179,9 @@
> >  #
> >  # @type: Transport type
> >  #
> > -# Note: This type is deprecated in favor of SocketAddress.  The
> > -#     difference between SocketAddressLegacy and SocketAddress is that
> > -#     the latter has fewer {} on the wire.
> > +# .. note:: This type is deprecated in favor of SocketAddress.  The
> > +#    difference between SocketAddressLegacy and SocketAddress is that
> > +#    the latter has fewer ``{}`` on the wire.
>
> Likewise.
>
> >  #
> >  # Since: 1.3
> >  ##
> > diff --git a/qapi/stats.json b/qapi/stats.json
> > index c4a9f3ff70e..683929b2322 100644
> > --- a/qapi/stats.json
> > +++ b/qapi/stats.json
> > @@ -254,17 +254,17 @@
> >  #
> >  # @provider: a provider to restrict the query to.
> >  #
> > -# Note: runtime-collected statistics and their names fall outside
> > -#     QEMU's usual deprecation policies.  QEMU will try to keep the
> > -#     set of available data stable, together with their names, but
> > -#     will not guarantee stability at all costs; the same is true of
> > -#     providers that source statistics externally, e.g. from Linux.
> > -#     For example, if the same value is being tracked with different
> > -#     names on different architectures or by different providers, one
> > -#     of them might be renamed.  A statistic might go away if an
> > -#     algorithm is changed or some code is removed; changing a default
> > -#     might cause previously useful statistics to always report 0.
> > -#     Such changes, however, are expected to be rare.
> > +# .. note:: runtime-collected statistics and their names fall outside
> > +#    QEMU's usual deprecation policies.  QEMU will try to keep the set
> > +#    of available data stable, together with their names, but will not
> > +#    guarantee stability at all costs; the same is true of providers
> > +#    that source statistics externally, e.g. from Linux.  For example,
> > +#    if the same value is being tracked with different names on
> > +#    different architectures or by different providers, one of them
> > +#    might be renamed.  A statistic might go away if an algorithm is
> > +#    changed or some code is removed; changing a default might cause
> > +#    previously useful statistics to always report 0.  Such changes,
> > +#    however, are expected to be rare.
> >  #
> >  # Since: 7.1
> >  ##
> > diff --git a/qapi/transaction.json b/qapi/transaction.json
> > index 07afc269d54..bcb05fdedd6 100644
> > --- a/qapi/transaction.json
> > +++ b/qapi/transaction.json
> > @@ -237,10 +237,10 @@
> >  # Errors:
> >  #     - Any errors from commands in the transaction
> >  #
> > -# Note: The transaction aborts on the first failure.  Therefore, there
> > -#     will be information on only one failed operation returned in an
> > -#     error condition, and subsequent actions will not have been
> > -#     attempted.
> > +# .. note:: The transaction aborts on the first failure.  Therefore,
> > +#    there will be information on only one failed operation returned i=
n
> > +#    an error condition, and subsequent actions will not have been
> > +#    attempted.
> >  #
> >  # Since: 1.1
> >  #
> > diff --git a/qapi/ui.json b/qapi/ui.json
> > index 2d0aa407aca..ec72998e28e 100644
> > --- a/qapi/ui.json
> > +++ b/qapi/ui.json
> > @@ -103,11 +103,10 @@
> >  #     - '+INT' where INT is the number of seconds from now (integer)
> >  #     - 'INT' where INT is the absolute time in seconds
> >  #
> > -# Notes: Time is relative to the server and currently there is no way
> > -#     to coordinate server time with client time.  It is not
> > -#     recommended to use the absolute time version of the @time
> > -#     parameter unless you're sure you are on the same machine as the
> > -#     QEMU instance.
> > +# .. note:: Time is relative to the server and currently there is no w=
ay
> > +#    to coordinate server time with client time.  It is not recommende=
d
> > +#    to use the absolute time version of the @time parameter unless
> > +#    you're sure you are on the same machine as the QEMU instance.
> >  #
> >  # Since: 7.0
> >  ##
> > @@ -268,7 +267,7 @@
> >  # @unknown: No information is available about mouse mode used by the
> >  #     spice server.
> >  #
> > -# Note: spice/enums.h has a SpiceMouseMode already, hence the name.
> > +# .. note:: spice/enums.h has a SpiceMouseMode already, hence the name=
.
> >  #
> >  # Since: 1.1
> >  ##
> > @@ -697,9 +696,9 @@
> >  #
> >  # Since: 1.1
> >  #
> > -# Notes: An empty password in this command will set the password to
> > -#     the empty string.  Existing clients are unaffected by executing
> > -#     this command.
> > +# .. note:: An empty password in this command will set the password to
> > +#    the empty string.  Existing clients are unaffected by executing
> > +#    this command.
> >  ##
> >  { 'command': 'change-vnc-password',
> >    'data': { 'password': 'str' },
> > @@ -714,8 +713,8 @@
> >  #
> >  # @client: client information
> >  #
> > -# Note: This event is emitted before any authentication takes place,
> > -#     thus the authentication ID is not provided
> > +# .. note:: This event is emitted before any authentication takes plac=
e,
> > +#    thus the authentication ID is not provided.
> >  #
> >  # Since: 0.13
> >  #
> > @@ -1260,10 +1259,10 @@
> >  #
> >  # Since: 2.6
> >  #
> > -# Note: The consoles are visible in the qom tree, under
> > -#     /backend/console[$index]. They have a device link and head
> > -#     property, so it is possible to map which console belongs to
> > -#     which device and display.
> > +# .. note:: The consoles are visible in the qom tree, under
> > +#    ``/backend/console[$index]``. They have a device link and head
> > +#    property, so it is possible to map which console belongs to which
> > +#    device and display.
>
> Likewise.
>
> >  #
> >  # Examples:
> >  #
> > diff --git a/qapi/virtio.json b/qapi/virtio.json
> > index 74fc27c7029..b91f3cdd0df 100644
> > --- a/qapi/virtio.json
> > +++ b/qapi/virtio.json
> > @@ -559,12 +559,12 @@
> >  #
> >  # Returns: VirtQueueStatus of the VirtQueue
> >  #
> > -# Notes: last_avail_idx will not be displayed in the case where the
> > -#     selected VirtIODevice has a running vhost device and the
> > -#     VirtIODevice VirtQueue index (queue) does not exist for the
> > -#     corresponding vhost device vhost_virtqueue.  Also,
> > -#     shadow_avail_idx will not be displayed in the case where the
> > -#     selected VirtIODevice has a running vhost device.
> > +# .. note:: last_avail_idx will not be displayed in the case where the
> > +#    selected VirtIODevice has a running vhost device and the
> > +#    VirtIODevice VirtQueue index (queue) does not exist for the
> > +#    corresponding vhost device vhost_virtqueue.  Also, shadow_avail_i=
dx
> > +#    will not be displayed in the case where the selected VirtIODevice
> > +#    has a running vhost device.
> >  #
> >  # Since: 7.2
> >  #
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index b3de1fb6b3a..1273d85bb5f 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -422,8 +422,9 @@
> >  # Returns: GuestFsfreezeStatus ("thawed", "frozen", etc., as defined
> >  #     below)
> >  #
> > -# Note: This may fail to properly report the current state as a result
> > -#     of some other guest processes having issued an fs freeze/thaw.
> > +# .. note:: This may fail to properly report the current state as a
> > +#    result of some other guest processes having issued an fs
> > +#    freeze/thaw.
> >  #
> >  # Since: 0.15.0
> >  ##
> > @@ -443,9 +444,9 @@
> >  #
> >  # Returns: Number of file systems currently frozen.
> >  #
> > -# Note: On Windows, the command is implemented with the help of a
> > -#     Volume Shadow-copy Service DLL helper.  The frozen state is
> > -#     limited for up to 10 seconds by VSS.
> > +# .. note:: On Windows, the command is implemented with the help of a
> > +#    Volume Shadow-copy Service DLL helper.  The frozen state is limit=
ed
> > +#    for up to 10 seconds by VSS.
> >  #
> >  # Since: 0.15.0
> >  ##
> > @@ -479,10 +480,10 @@
> >  #
> >  # Returns: Number of file systems thawed by this call
> >  #
> > -# Note: if return value does not match the previous call to
> > -#     guest-fsfreeze-freeze, this likely means some freezable
> > -#     filesystems were unfrozen before this call, and that the
> > -#     filesystem state may have changed before issuing this command.
> > +# .. note:: If the return value does not match the previous call to
> > +#    guest-fsfreeze-freeze, this likely means some freezable filesyste=
ms
> > +#    were unfrozen before this call, and that the filesystem state may
> > +#    have changed before issuing this command.
>
> Prose again.
>

Okey dokey.


> >  #
> >  # Since: 0.15.0
> >  ##
> > @@ -560,8 +561,8 @@
> >  # Errors:
> >  #     - If suspend to disk is not supported, Unsupported
> >  #
> > -# Notes: It's strongly recommended to issue the guest-sync command
> > -#     before sending commands when the guest resumes
> > +# .. note:: It's strongly recommended to issue the guest-sync command
> > +#    before sending commands when the guest resumes.
> >  #
> >  # Since: 1.1
> >  ##
> > @@ -596,8 +597,8 @@
> >  # Errors:
> >  #     - If suspend to ram is not supported, Unsupported
> >  #
> > -# Notes: It's strongly recommended to issue the guest-sync command
> > -#     before sending commands when the guest resumes
> > +# .. note:: It's strongly recommended to issue the guest-sync command
> > +#    before sending commands when the guest resumes.
> >  #
> >  # Since: 1.1
> >  ##
> > @@ -631,8 +632,8 @@
> >  # Errors:
> >  #     - If hybrid suspend is not supported, Unsupported
> >  #
> > -# Notes: It's strongly recommended to issue the guest-sync command
> > -#     before sending commands when the guest resumes
> > +# .. note:: It's strongly recommended to issue the guest-sync command
> > +#    before sending commands when the guest resumes.
> >  #
> >  # Since: 1.1
> >  ##
> > @@ -1461,16 +1462,15 @@
> >  #     * POSIX: as defined by os-release(5)
> >  #     * Windows: contains string "server" or "client"
> >  #
> > -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
> > -#     @version, @version-id, @variant and @variant-id follow the
> > -#     definition specified in os-release(5). Refer to the manual page
> > -#     for exact description of the fields.  Their values are taken
> > -#     from the os-release file.  If the file is not present in the
> > -#     system, or the values are not present in the file, the fields
> > -#     are not included.
> > +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
> > +#    @version, @version-id, @variant and @variant-id follow the
> > +#    definition specified in os-release(5). Refer to the manual page f=
or
> > +#    exact description of the fields.  Their values are taken from the
> > +#    os-release file.  If the file is not present in the system, or th=
e
> > +#    values are not present in the file, the fields are not included.
> >  #
> > -#     On Windows the values are filled from information gathered from
> > -#     the system.
> > +#    On Windows the values are filled from information gathered from
> > +#    the system.
>
> Accidental indentation change?
>

I don't think so; the original heading seems to suggest that there is a
sequence of notes; "On POSIX" ... "On Windows". This indentation change
keeps this information in the same note box.


> >  #
> >  # Since: 2.10
> >  ##
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 3cd8e7ee295..8b1da96124e 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -557,6 +557,15 @@ def get_doc(self) -> 'QAPIDoc':
> >                          r'(Returns|Errors|Since|Notes?|Examples?|TODO)=
:
> *',
> >                          line):
> >                      # tagged section
> > +
> > +                    if 'Note' in match.group(1):
> > +                        emsg =3D (
> > +                            f"The '{match.group(1)}' section is
> deprecated."
> > +                            " Please use rST's '.. note::' directive o=
r
> "
> > +                            "another suitable admonition instead."
> > +                        )
> > +                        raise QAPIParseError(self, emsg)
>
> This isn't merely deprecated, it's a hard error.
>

Fair enuff....


> > +
> >                      doc.new_tagged_section(self.info, match.group(1))
> >                      text =3D line[match.end():]
> >                      if text:
> > diff --git a/tests/qapi-schema/doc-empty-section.err
> b/tests/qapi-schema/doc-empty-section.err
> > index 5f03a6d733f..711a0d629c2 100644
> > --- a/tests/qapi-schema/doc-empty-section.err
> > +++ b/tests/qapi-schema/doc-empty-section.err
> > @@ -1 +1 @@
> > -doc-empty-section.json:6: text required after 'Note:'
> > +doc-empty-section.json:6: text required after 'Errors:'
> > diff --git a/tests/qapi-schema/doc-empty-section.json
> b/tests/qapi-schema/doc-empty-section.json
> > index f3384e9a3bb..f179d3eff6d 100644
> > --- a/tests/qapi-schema/doc-empty-section.json
> > +++ b/tests/qapi-schema/doc-empty-section.json
> > @@ -3,6 +3,6 @@
> >  ##
> >  # @foo:
> >  #
> > -# Note:
> > +# Errors:
> >  ##
> >  { 'command': 'foo', 'data': {'a': 'int'} }
> > diff --git a/tests/qapi-schema/doc-good.json
> b/tests/qapi-schema/doc-good.json
> > index de38a386e8f..0a294eb324e 100644
> > --- a/tests/qapi-schema/doc-good.json
> > +++ b/tests/qapi-schema/doc-good.json
> > @@ -29,7 +29,7 @@
> >  # - Second list
> >  #   Note: still in list
> >  #
> > -# Note: not in list
> > +# .. note:: not in list
> >  #
> >  # 1. Third list
> >  #    is numbered
> > @@ -155,7 +155,7 @@
> >  # @cmd-feat1: a feature
> >  # @cmd-feat2: another feature
> >  #
> > -# Note: @arg3 is undocumented
> > +# .. note:: @arg3 is undocumented
> >  #
> >  # Returns: @Object
> >  #
> > @@ -163,7 +163,7 @@
> >  #
> >  # TODO: frobnicate
> >  #
> > -# Notes:
> > +# .. admonition:: Notes
> >  #
> >  #  - Lorem ipsum dolor sit amet
> >  #  - Ut enim ad minim veniam
> > diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> > index 435f6e6d768..2c9b4e419cb 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -76,7 +76,7 @@ Not in list
> >  - Second list
> >    Note: still in list
> >
> > -Note: not in list
> > +.. note:: not in list
> >
> >  1. Third list
> >     is numbered
> > @@ -169,15 +169,17 @@ description starts on the same line
> >  a feature
> >      feature=3Dcmd-feat2
> >  another feature
> > -    section=3DNote
> > -@arg3 is undocumented
> > +    section=3DNone
> > +.. note:: @arg3 is undocumented
> >      section=3DReturns
> >  @Object
> >      section=3DErrors
> >  some
> >      section=3DTODO
> >  frobnicate
> > -    section=3DNotes
> > +    section=3DNone
> > +.. admonition:: Notes
> > +
> >   - Lorem ipsum dolor sit amet
> >   - Ut enim ad minim veniam
> >
> > diff --git a/tests/qapi-schema/doc-good.txt
> b/tests/qapi-schema/doc-good.txt
> > index 847db70412d..b89f35d5476 100644
> > --- a/tests/qapi-schema/doc-good.txt
> > +++ b/tests/qapi-schema/doc-good.txt
> > @@ -17,7 +17,9 @@ Not in list
> >
> >  * Second list Note: still in list
> >
> > -Note: not in list
> > +Note:
> > +
> > +  not in list
> >
> >  1. Third list is numbered
> >
> > @@ -193,11 +195,9 @@ Features
> >  "cmd-feat2"
> >     another feature
> >
> > +Note:
> >
> > -Note
> > -~~~~
> > -
> > -"arg3" is undocumented
> > +  "arg3" is undocumented
> >
> >
> >  Returns
> > @@ -211,9 +211,7 @@ Errors
> >
> >  some
> >
> > -
> > -Notes
> > -~~~~~
> > +Notes:
> >
> >  * Lorem ipsum dolor sit amet
> >
> > diff --git a/tests/qapi-schema/doc-interleaved-section.json
> b/tests/qapi-schema/doc-interleaved-section.json
> > index adb29e98daa..b26bc0bbb79 100644
> > --- a/tests/qapi-schema/doc-interleaved-section.json
> > +++ b/tests/qapi-schema/doc-interleaved-section.json
> > @@ -10,7 +10,7 @@
> >  #
> >  #           bao
> >  #
> > -# Note: a section.
> > +# Returns: a section.
> >  #
> >  # @foobar: catch this
> >  #
>
> I love this, and want it merged as soon as possible.  Can we spin this
> off into its own series along with its dependencies?  Feel free to throw
> in uncontroversial small fry.  Perhaps
>
>     qapi: linter fixups
>     docs/qapidoc: delint a tiny portion of the module
>     qapi/parser: preserve indentation in QAPIDoc sections
>     qapi/parser: fix comment parsing immediately following a doc block
>     docs/qapidoc: fix nested parsing under untagged sections
>     qapi: fix non-compliant JSON examples
>     qapi: ensure all errors sections are uniformly typset
>     qapi: convert "Note" sections to plain rST
>     qapi: convert "Example" sections to rST
>
> Has just one trivial conflict for me.
>

Yeah, this works ... I fixed up the prose/markup changes you pointed out
above and stuck them in separate patches. I need to go through the Examples
feedback still, but as of now:

jsnow@scv ~/s/q/qapi (sphinx-domain-prereqs-docs)> stg series --description
+ do-not-merge-add-some-ad-hoc   # [DO-NOT-MERGE]: Add some ad-hoc linting
helpers.
+ qapi-linter-fixups             # qapi: linter fixups
+ docs-qapidoc-delint-a-tiny     # docs/qapidoc: delint a tiny portion of
the module
+ qapi-parser-preserve           # qapi/parser: preserve indentation in
QAPIDoc sections
+ qapi-parser-fix-comment        # qapi/parser: fix comment parsing
immediately following a doc block
+ docs-qapidoc-fix-nested        # docs/qapidoc: fix nested parsing under
untagged sections
+ qapi-fix-non-compliant-json    # qapi: fix non-compliant JSON examples
+ qapi-ensure-all-errors         # qapi: ensure all errors sections are
uniformly typset
+ qapi-convert-note-sections-to  # qapi: convert "Note" sections to plain
rST
+ qapi-update-prose-in-note      # qapi: Update prose in Note blocks
> qapi-add-markup-to-note-blocks # qapi: Add markup to note blocks
- qapi-convert-example-sections  # qapi: convert "Example" sections to rST

Onwards to the Examples patch, ...

>

--000000000000a68a4e061b1b5dd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 14, 2024, 9:44=E2=80=AFAM=
 Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blan=
k">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=3D"noreferrer" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; We do not need a dedicated section for notes. By eliminating a special=
ly<br>
&gt; parsed section, these notes can be treated as normal rST paragraphs in=
<br>
&gt; the new QMP reference manual, and can be placed and styled much more<b=
r>
&gt; flexibly.<br>
&gt;<br>
&gt; Update the QAPI parser to now prohibit special &quot;Note&quot; sectio=
ns while<br>
&gt; suggesting a new syntax.<br>
&gt;<br>
&gt; The exact formatting to use is a matter of taste, but a good candidate=
<br>
&gt; is simply:<br>
&gt;<br>
&gt; .. note:: lorem ipsum ...<br>
&gt;<br>
&gt; but there are other choices, too. The Sphinx readthedocs theme offers<=
br>
&gt; theming for the following forms (capitalization unimportant); all are<=
br>
&gt; adorned with a (!) symbol in the title bar for rendered HTML docs.<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Stor=
e this paragraph in your L1 cache for a moment ...</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
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
&gt; This patch uses &quot;.. notes::&quot; almost everywhere, with just tw=
o &quot;caution&quot;<br>
&gt; directives. &quot;.. admonition:: notes&quot; is used in a few places =
where we had<br>
&gt; an ordered list of multiple notes.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=
=3D"noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/block-core.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 30 +++----<br>
&gt;=C2=A0 qapi/block.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
&gt;=C2=A0 qapi/char.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 +--<br>
&gt;=C2=A0 qapi/control.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 ++--<br>
&gt;=C2=A0 qapi/dump.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-=
<br>
&gt;=C2=A0 qapi/introspect.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +-<br>
&gt;=C2=A0 qapi/machine-target.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 26 +++---<br>
&gt;=C2=A0 qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 47 +++++-----<=
br>
&gt;=C2=A0 qapi/migration.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 +--<br>
&gt;=C2=A0 qapi/misc.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 88 +++++++=
++----------<br>
&gt;=C2=A0 qapi/net.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 6 +-<br>
&gt;=C2=A0 qapi/pci.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 7 +-<br>
&gt;=C2=A0 qapi/qdev.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 30 +++----=
<br>
&gt;=C2=A0 qapi/qom.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 19 +=
+--<br>
&gt;=C2=A0 qapi/rocker.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 16 ++--<br>
&gt;=C2=A0 qapi/run-state.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 ++--<br>
&gt;=C2=A0 qapi/sockets.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +--<br>
&gt;=C2=A0 qapi/stats.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 22 ++---<br=
>
&gt;=C2=A0 qapi/transaction.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +-<br>
&gt;=C2=A0 qapi/ui.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 29 +++=
---<br>
&gt;=C2=A0 qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 +--<br>
&gt;=C2=A0 qga/qapi-schema.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 48 +++++-----<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 ++<br>
&gt;=C2=A0 tests/qapi-schema/doc-empty-section.err=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 tests/qapi-schema/doc-empty-section.json=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +-<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 10 ++-<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 14 ++-<br>
&gt;=C2=A0 .../qapi-schema/doc-interleaved-section.json=C2=A0 |=C2=A0 2 +-<=
br>
&gt;=C2=A0 29 files changed, 258 insertions(+), 252 deletions(-)<br>
<br>
Missing: update of docs/devel/qapi-code-gen.rst.=C2=A0 Something like<br>
<br>
diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst<br=
>
index f453bd3546..1a4e240adb 100644<br>
--- a/docs/devel/qapi-code-gen.rst<br>
+++ b/docs/devel/qapi-code-gen.rst<br>
@@ -995,14 +995,13 @@ line &quot;Features:&quot;, like this::<br>
=C2=A0 =C2=A0# @feature: Description text<br>
<br>
=C2=A0A tagged section begins with a paragraph that starts with one of the<=
br>
-following words: &quot;Note:&quot;/&quot;Notes:&quot;, &quot;Since:&quot;,=
 &quot;Example:&quot;/&quot;Examples:&quot;,<br>
-&quot;Returns:&quot;, &quot;Errors:&quot;, &quot;TODO:&quot;.=C2=A0 It end=
s with the start of a new<br>
-section.<br>
+following words: &quot;Since:&quot;, &quot;Example:&quot;/&quot;Examples:&=
quot;, &quot;Returns:&quot;,<br>
+&quot;Errors:&quot;, &quot;TODO:&quot;.=C2=A0 It ends with the start of a =
new section.<br>
<br>
=C2=A0The second and subsequent lines of tagged sections must be indented<b=
r>
=C2=A0like this::<br>
<br>
- # Note: Ut enim ad minim veniam, quis nostrud exercitation ullamco<br>
+ # TODO: Ut enim ad minim veniam, quis nostrud exercitation ullamco<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0laboris nisi ut aliquip ex ea commodo consequat=
.<br>
=C2=A0 #<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0Duis aute irure dolor in reprehenderit in volup=
tate velit esse<br>
<br></blockquote><div><br></div><div>Done.<br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
&gt;<br>
&gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; index 64fe5240cc9..530af40404d 100644<br>
&gt; --- a/qapi/block-core.json<br>
&gt; +++ b/qapi/block-core.json<br>
&gt; @@ -1510,7 +1510,7 @@<br>
&gt;=C2=A0 # @mode: whether and how QEMU should create a new image, default=
 is<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&#39;absolute-paths&#39;.<br>
&gt;=C2=A0 #<br>
&gt; -# Note: Either @device or @node-name must be set but not both.<br>
&gt; +# .. note:: Either @device or @node-name must be set but not both.<br=
>
<br>
The commit message talks about &quot;.. Note::&quot;, but you actually use<=
br>
&quot;.. note::&quot;.=C2=A0 Is there a difference?<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Retrieve paragraph from =
L1 cache.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Nope! Sp=
hinx RTD theme docs use capitals sporadically, but it&#39;s case insensitiv=
e. I stuck with all lowercase everywhere in the patches, but the capitaliza=
tion in the commit message came directly from the Sphinx RTD theme document=
ation.<br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;struct&#39;: &#39;BlockdevSnapshotSync&#39;,<br>
&gt; @@ -1616,9 +1616,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @unstable: Member @x-perf is experimental.<br>
&gt;=C2=A0 #<br>
&gt; -# Note: @on-source-error and @on-target-error only affect background<=
br>
&gt; -#=C2=A0 =C2=A0 =C2=A0I/O.=C2=A0 If an error occurs during a guest wri=
te request, the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0device&#39;s rerror/werror actions will be used.=
<br>
&gt; +# .. note:: @on-source-error and @on-target-error only affect backgro=
und<br>
&gt; +#=C2=A0 =C2=A0 I/O.=C2=A0 If an error occurs during a guest write req=
uest, the device&#39;s<br>
&gt; +#=C2=A0 =C2=A0 rerror/werror actions will be used.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 4.2<br>
&gt;=C2=A0 ##<br>
&gt; @@ -5534,8 +5534,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0after this event and must be repaired (Sinc=
e 2.2; before, every<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0BLOCK_IMAGE_CORRUPTED event was fatal)<br>
&gt;=C2=A0 #<br>
&gt; -# Note: If action is &quot;stop&quot;, a STOP event will eventually f=
ollow the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0BLOCK_IO_ERROR event.<br>
&gt; +# .. note:: If action is &quot;stop&quot;, a STOP event will eventual=
ly follow the<br>
&gt; +#=C2=A0 =C2=A0 BLOCK_IO_ERROR event.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -5581,8 +5581,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0field is a debugging aid for humans, it sho=
uld not be parsed by<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0applications) (since: 2.2)<br>
&gt;=C2=A0 #<br>
&gt; -# Note: If action is &quot;stop&quot;, a STOP event will eventually f=
ollow the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0BLOCK_IO_ERROR event<br>
&gt; +# .. note:: If action is &quot;stop&quot;, a STOP event will eventual=
ly follow the<br>
&gt; +#=C2=A0 =C2=A0 BLOCK_IO_ERROR event.<br>
<br>
You&#39;re adding a period.=C2=A0 Okay, but please mention it in the commit=
<br>
message.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">OK. When hoisting notes into little visual boxes I felt it looked=
 naked without the punctuation, so I just went for it. Sorry.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.13<br>
&gt;=C2=A0 #<br>
&gt; @@ -5720,8 +5720,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @speed: rate limit, bytes per second<br>
&gt;=C2=A0 #<br>
&gt; -# Note: The &quot;ready to complete&quot; status is always reset by a=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0@BLOCK_JOB_ERROR event<br>
&gt; +# .. note:: The &quot;ready to complete&quot; status is always reset =
by a<br>
&gt; +#=C2=A0 =C2=A0 @BLOCK_JOB_ERROR event.<br>
<br>
Likewise.=C2=A0 Not going to point this out again.<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">I just need to update the=
 commit message, yeah?.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.3<br>
&gt;=C2=A0 #<br>
&gt; @@ -5974,7 +5974,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @sectors-count: failed read operation sector count<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This event is rate-limited.<br>
&gt; +# .. note:: This event is rate-limited.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.0<br>
&gt;=C2=A0 #<br>
&gt; @@ -6005,7 +6005,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @sectors-count: failed read operation sector count<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This event is rate-limited.<br>
&gt; +# .. note:: This event is rate-limited.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.0<br>
&gt;=C2=A0 #<br>
&gt; @@ -6037,9 +6037,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @name: the name of the internal snapshot to be created<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: In transaction, if @name is empty, or any snapshot matching<=
br>
&gt; -#=C2=A0 =C2=A0 =C2=A0@name exists, the operation will fail.=C2=A0 Onl=
y some image formats<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0support it, for example, qcow2, and rbd.<br>
&gt; +# .. note:: In a transaction, if @name is empty or any snapshot match=
ing<br>
&gt; +#=C2=A0 =C2=A0 @name exists, the operation will fail.=C2=A0 Only some=
 image formats<br>
&gt; +#=C2=A0 =C2=A0 support it; for example, qcow2, and rbd.<br>
<br>
You&#39;re fixing up prose.=C2=A0 Welcome, but put it in a separate patch,<=
br>
please, to keep this one mechanical.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Couldn&#39;t help it while auditing e=
very last notebox. (:<br><br></div><div>OK, separate patch...<br></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.7<br>
&gt;=C2=A0 ##<br>
&gt; diff --git a/qapi/block.json b/qapi/block.json<br>
&gt; index 5de99fe09d9..ea81d9e1921 100644<br>
&gt; --- a/qapi/block.json<br>
&gt; +++ b/qapi/block.json<br>
&gt; @@ -113,7 +113,7 @@<br>
&gt;=C2=A0 # Errors:<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If @device is not a valid block device, D=
eviceNotFound<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: Ejecting a device with no media results in success<br>
&gt; +# .. note:: Ejecting a device with no media results in success.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/char.json b/qapi/char.json<br>
&gt; index ab4c23976ed..0f39c2d5cdf 100644<br>
&gt; --- a/qapi/char.json<br>
&gt; +++ b/qapi/char.json<br>
&gt; @@ -21,8 +21,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0backend (e.g. with the chardev=3D... option=
) is in open or closed<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0state (since 2.1)<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: @filename is encoded using the QEMU command line character<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0device encoding.=C2=A0 See the QEMU man page for=
 details.<br>
&gt; +# .. note:: @filename is encoded using the QEMU command line characte=
r<br>
&gt; +#=C2=A0 =C2=A0 device encoding.=C2=A0 See the QEMU man page for detai=
ls.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 ##<br>
&gt; @@ -387,9 +387,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @rows: console height, in chars<br>
&gt;=C2=A0 #<br>
&gt; -# Note: the options are only effective when the VNC or SDL graphical<=
br>
&gt; -#=C2=A0 =C2=A0 =C2=A0display backend is active.=C2=A0 They are ignore=
d with the GTK,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Spice, VNC and D-Bus display backends.<br>
&gt; +# .. note:: The options are only effective when the VNC or SDL graphi=
cal<br>
&gt; +#=C2=A0 =C2=A0 display backend is active.=C2=A0 They are ignored with=
 the GTK, Spice,<br>
&gt; +#=C2=A0 =C2=A0 VNC and D-Bus display backends.<br>
<br>
You&#39;re capitalizing the beginning of the note text.=C2=A0 Good, because=
 the<br>
generated HTML wants that.=C2=A0 But please mention it in the commit messag=
e.<br>
<br>
More below; not going to point it out.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">OK; so long as the commit message men=
tions it, we don&#39;t need to make note of each time I do it, right...?</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.5<br>
&gt;=C2=A0 ##<br>
&gt; @@ -805,7 +805,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @open: true if the guest has opened the virtio-serial port<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This event is rate-limited.<br>
&gt; +# .. note:: This event is rate-limited.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.1<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/control.json b/qapi/control.json<br>
&gt; index 10c906fa0e7..2498e5dd6ba 100644<br>
&gt; --- a/qapi/control.json<br>
&gt; +++ b/qapi/control.json<br>
&gt; @@ -22,14 +22,13 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &qu=
ot;enable&quot;: [ &quot;oob&quot; ] } }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: This command is valid exactly when first connecting: it must=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0be issued before any other command will be accep=
ted, and will<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0fail once the monitor is accepting other command=
s.=C2=A0 (see qemu<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0docs/interop/qmp-spec.rst)<br>
&gt; +# .. note:: This command is valid exactly when first connecting: it m=
ust<br>
&gt; +#=C2=A0 =C2=A0 be issued before any other command will be accepted, a=
nd will fail<br>
&gt; +#=C2=A0 =C2=A0 once the monitor is accepting other commands.<br>
&gt; +#=C2=A0 =C2=A0 (see :doc:`/interop/qmp-spec`)<br>
<br>
You&#39;re adding markup to make a reference work.=C2=A0 Welcome, but put i=
t in a<br>
separate patch, please, to keep this one mechanical.<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Whoops. This snuck in. =
I do have a growing markup change patch...</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0The QMP client needs to explicitly enable QMP ca=
pabilities,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0otherwise all the QMP capabilities will be turne=
d off by<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0default.<br>
&gt; +# .. note:: The QMP client needs to explicitly enable QMP capabilitie=
s,<br>
&gt; +#=C2=A0 =C2=A0 otherwise all the QMP capabilities will be turned off =
by default.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.13<br>
&gt;=C2=A0 ##<br>
&gt; @@ -150,7 +149,7 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This example has been shortened as the real response is too<b=
r>
&gt; +#=C2=A0 =C2=A0 =C2=A0Note: This example has been shortened as the rea=
l response is too<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0long.<br>
<br>
Your commit message lists a number of conversions.=C2=A0 This one isn&#39;t=
 among<br>
them.<br>
<br>
The next patch reverts the indentation and drops &quot;Note: &quot;:<br>
<br>
=C2=A0 =C2=A0-#=C2=A0 =C2=A0 =C2=A0Note: This example has been shortened as=
 the real response is too<br>
=C2=A0 =C2=A0-#=C2=A0 =C2=A0 =C2=A0long.<br>
=C2=A0 =C2=A0+# This example has been shortened as the real response is too=
 long.<br>
<br>
Hmm.=C2=A0 Swap the two patches?=C2=A0 Perhaps not worth the bother now.=C2=
=A0 Squash<br>
the next patch&#39;s change into this one?<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Yeah, OK. (The problem was that t=
his began being picked up as a note section in its own right, but I thought=
 it wasn&#39;t appropriate in this case, but needed to avoid the parser com=
plaining about the old Note: section.)<br></div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
<br>
A few more below.<br>
<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;query-commands&#39;, &#39;returns&#39;=
: [&#39;CommandInfo&#39;],<br>
&gt; diff --git a/qapi/dump.json b/qapi/dump.json<br>
&gt; index 2fa9504d864..f9aee7ea1dd 100644<br>
&gt; --- a/qapi/dump.json<br>
&gt; +++ b/qapi/dump.json<br>
&gt; @@ -90,7 +90,7 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0and @length is not allowed to be specified =
with non-elf @format<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0at the same time (since 2.0)<br>
&gt;=C2=A0 #<br>
&gt; -# Note: All boolean arguments default to false<br>
&gt; +# .. note:: All boolean arguments default to false.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.2<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/introspect.json b/qapi/introspect.json<br>
&gt; index b041b02ba8c..b15052ec21a 100644<br>
&gt; --- a/qapi/introspect.json<br>
&gt; +++ b/qapi/introspect.json<br>
&gt; @@ -41,9 +41,9 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0names are guaranteed to be unique (no name =
will be duplicated<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0with different meta-types).<br>
&gt;=C2=A0 #<br>
&gt; -# Note: the QAPI schema is also used to help define *internal*<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0interfaces, by defining QAPI types.=C2=A0 These =
are not part of the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0QMP wire ABI, and therefore not returned by this=
 command.<br>
&gt; +# .. note:: The QAPI schema is also used to help define *internal*<br=
>
&gt; +#=C2=A0 =C2=A0 interfaces, by defining QAPI types.=C2=A0 These are no=
t part of the QMP<br>
&gt; +#=C2=A0 =C2=A0 wire ABI, and therefore not returned by this command.<=
br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.5<br>
&gt;=C2=A0 ##<br>
&gt; diff --git a/qapi/machine-target.json b/qapi/machine-target.json<br>
&gt; index 29428530923..a8d9ec87f59 100644<br>
&gt; --- a/qapi/machine-target.json<br>
&gt; +++ b/qapi/machine-target.json<br>
&gt; @@ -49,15 +49,15 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0to be migration-safe, but allows tooling to=
 get an insight and<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0work with model details.<br>
&gt;=C2=A0 #<br>
&gt; -# Note: When a non-migration-safe CPU model is expanded in static<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0mode, some features enabled by the CPU model may=
 be omitted,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0because they can&#39;t be implemented by a stati=
c CPU model<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0definition (e.g. cache info passthrough and PMU =
passthrough in<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0x86). If you need an accurate representation of =
the features<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0enabled by a non-migration-safe CPU model, use @=
full.=C2=A0 If you<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0need a static representation that will keep ABI =
compatibility<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0even when changing QEMU version or machine-type,=
 use @static<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0(but keep in mind that some features may be omit=
ted).<br>
&gt; +# .. note:: When a non-migration-safe CPU model is expanded in static=
<br>
&gt; +#=C2=A0 =C2=A0 mode, some features enabled by the CPU model may be om=
itted,<br>
&gt; +#=C2=A0 =C2=A0 because they can&#39;t be implemented by a static CPU =
model definition<br>
&gt; +#=C2=A0 =C2=A0 (e.g. cache info passthrough and PMU passthrough in x8=
6). If you<br>
&gt; +#=C2=A0 =C2=A0 need an accurate representation of the features enable=
d by a<br>
&gt; +#=C2=A0 =C2=A0 non-migration-safe CPU model, use @full.=C2=A0 If you =
need a static<br>
&gt; +#=C2=A0 =C2=A0 representation that will keep ABI compatibility even w=
hen changing<br>
&gt; +#=C2=A0 =C2=A0 QEMU version or machine-type, use @static (but keep in=
 mind that<br>
&gt; +#=C2=A0 =C2=A0 some features may be omitted).<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.8<br>
&gt;=C2=A0 ##<br>
&gt; @@ -175,8 +175,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- if a model contains an unknown cpu defini=
tion name, unknown<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0properties or properties with wrong =
types.<br>
&gt;=C2=A0 #<br>
&gt; -# Note: this command isn&#39;t specific to s390x, but is only impleme=
nted<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0on this architecture currently.<br>
&gt; +# .. note:: This command isn&#39;t specific to s390x, but is only<br>
&gt; +#=C2=A0 =C2=A0 implemented on this architecture currently.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.8<br>
&gt;=C2=A0 ##<br>
&gt; @@ -229,8 +229,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- if a model contains an unknown cpu defini=
tion name, unknown<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0properties or properties with wrong =
types.<br>
&gt;=C2=A0 #<br>
&gt; -# Note: this command isn&#39;t specific to s390x, but is only impleme=
nted<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0on this architecture currently.<br>
&gt; +# .. note:: This command isn&#39;t specific to s390x, but is only<br>
&gt; +#=C2=A0 =C2=A0 implemented on this architecture currently.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.8<br>
&gt;=C2=A0 ##<br>
&gt; diff --git a/qapi/machine.json b/qapi/machine.json<br>
&gt; index 35cca12ba41..e9c9bef940d 100644<br>
&gt; --- a/qapi/machine.json<br>
&gt; +++ b/qapi/machine.json<br>
&gt; @@ -24,9 +24,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @avr: since 5.1<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: The resulting QMP strings can be appended to the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0&quot;qemu-system-&quot; prefix to produce the c=
orresponding QEMU<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0executable name.=C2=A0 This is true even for &qu=
ot;qemu-system-x86_64&quot;.<br>
&gt; +# .. note:: The resulting QMP strings can be appended to the<br>
&gt; +#=C2=A0 =C2=A0 &quot;qemu-system-&quot; prefix to produce the corresp=
onding QEMU executable<br>
&gt; +#=C2=A0 =C2=A0 name.=C2=A0 This is true even for &quot;qemu-system-x8=
6_64&quot;.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 3.0<br>
&gt;=C2=A0 ##<br>
&gt; @@ -305,8 +305,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: If no UUID was specified for the guest, a null UUID is<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0returned.<br>
&gt; +# .. note:: If no UUID was specified for the guest, a null UUID is<br=
>
&gt; +#=C2=A0 =C2=A0 returned.<br>
&gt; +#<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;struct&#39;: &#39;UuidInfo&#39;, &#39;data&#39;: {&#39;UU=
ID&#39;: &#39;str&#39;} }<br>
&gt;=C2=A0 <br>
&gt; @@ -367,10 +368,10 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: A guest may or may not respond to this command.=C2=A0 This c=
ommand<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0returning does not indicate that a guest has acc=
epted the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0request or that it has shut down.=C2=A0 Many gue=
sts will respond to<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0this command by prompting the user in some way.<=
br>
&gt; +# .. note:: A guest may or may not respond to this command.=C2=A0 Thi=
s<br>
&gt; +#=C2=A0 =C2=A0 command returning does not indicate that a guest has a=
ccepted the<br>
&gt; +#=C2=A0 =C2=A0 request or that it has shut down.=C2=A0 Many guests wi=
ll respond to this<br>
&gt; +#=C2=A0 =C2=A0 command by prompting the user in some way.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -389,8 +390,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.1<br>
&gt;=C2=A0 #<br>
&gt; -# Note: prior to 4.0, this command does nothing in case the guest<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0isn&#39;t suspended.<br>
&gt; +# .. note:: Prior to 4.0, this command does nothing in case the guest=
<br>
&gt; +#=C2=A0 =C2=A0 isn&#39;t suspended.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -440,8 +441,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Note: prior to 2.1, this command was only supported for x86 and s39=
0<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0VMs<br>
&gt; +# .. note:: Prior to 2.1, this command was only supported for x86 and=
<br>
&gt; +#=C2=A0 =C2=A0 s390 VMs<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -838,7 +839,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: Errors were not reliably returned until 1.1<br>
&gt; +# .. caution:: Errors were not reliably returned until 1.1.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -864,7 +865,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: Errors were not reliably returned until 1.1<br>
&gt; +# .. caution:: Errors were not reliably returned until 1.1.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -994,8 +995,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @thread-id: thread number within the core the CPU=C2=A0 belong=
s to<br>
&gt;=C2=A0 #<br>
&gt; -# Note: management should be prepared to pass through additional<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0properties with device_add.<br>
&gt; +# .. note:: Management should be prepared to pass through additional<=
br>
&gt; +#=C2=A0 =C2=A0 properties with device_add.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.7<br>
&gt;=C2=A0 ##<br>
&gt; @@ -1122,9 +1123,9 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0the KVM kernel module cannot support=
 it, KVMMissingCap<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If no balloon device is present, DeviceNo=
tActive<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: This command just issues a request to the guest.=C2=A0 When =
it<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0returns, the balloon size may not have changed.=
=C2=A0 A guest can<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0change the balloon size independent of this comm=
and.<br>
&gt; +# .. note:: This command just issues a request to the guest.=C2=A0 Wh=
en it<br>
&gt; +#=C2=A0 =C2=A0 returns, the balloon size may not have changed.=C2=A0 =
A guest can change<br>
&gt; +#=C2=A0 =C2=A0 the balloon size independent of this command.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; @@ -1184,7 +1185,7 @@<br>
&gt;=C2=A0 # @actual: the logical size of the VM in bytes Formula used:<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0logical_vm_size =3D vm_ram_size - balloon_s=
ize<br>
&gt;=C2=A0 #<br>
&gt; -# Note: this event is rate-limited.<br>
&gt; +# .. note:: This event is rate-limited.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.2<br>
&gt;=C2=A0 #<br>
&gt; @@ -1246,7 +1247,7 @@<br>
&gt;=C2=A0 # Emitted when the hv-balloon driver receives a &quot;STATUS&quo=
t; message from<br>
&gt;=C2=A0 # the guest.<br>
&gt;=C2=A0 #<br>
&gt; -# Note: this event is rate-limited.<br>
&gt; +# .. note:: This event is rate-limited.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 8.2<br>
&gt;=C2=A0 #<br>
&gt; @@ -1591,7 +1592,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @qom-path: path to the device object in the QOM tree (since 6.=
2)<br>
&gt;=C2=A0 #<br>
&gt; -# Note: this event is rate-limited.<br>
&gt; +# .. note:: This event is rate-limited.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 5.1<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index 89047d46c7c..a7b8ff138e3 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
&gt; @@ -1428,8 +1428,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Cancel the current executing migration process.<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: This command succeeds even if there is no migration process<=
br>
&gt; -#=C2=A0 =C2=A0 =C2=A0running.<br>
&gt; +# .. note:: This command succeeds even if there is no migration proce=
ss<br>
&gt; +#=C2=A0 =C2=A0 running.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; @@ -1561,16 +1561,16 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Notes:<br>
&gt; +# .. admonition:: Notes<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A01. The &#39;query-migrate&#39; command shou=
ld be used to check<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration&#39;s progress and final =
result (this information is<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 provided by the &#39;status&#39; me=
mber)<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A02. All boolean arguments default to false<br>
&gt; +#=C2=A0 =C2=A0 =C2=A02. All boolean arguments default to false.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A03. The user Monitor&#39;s &quot;detach&quot=
; argument is invalid in QMP and<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 should not be used<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 should not be used.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A04. The uri argument should have the Uniform=
 Resource Identifier<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 of default destination VM. This con=
nection will be bound to<br>
&gt; @@ -1644,7 +1644,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.3<br>
&gt;=C2=A0 #<br>
&gt; -# Notes:<br>
&gt; +# .. admonition:: Notes<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A01. It&#39;s a bad idea to use a string for =
the uri, but it needs to<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 stay compatible with -incoming and =
the format of the uri is<br>
&gt; diff --git a/qapi/misc.json b/qapi/misc.json<br>
&gt; index 4b41e15dcd4..b04efbadec6 100644<br>
&gt; --- a/qapi/misc.json<br>
&gt; +++ b/qapi/misc.json<br>
&gt; @@ -103,9 +103,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Returns a list of information about each iothread.<br>
&gt;=C2=A0 #<br>
&gt; -# Note: this list excludes the QEMU main loop thread, which is not<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0declared using the -object iothread command-line=
 option.=C2=A0 It is<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0always the main thread of the process.<br>
&gt; +# .. note:: This list excludes the QEMU main loop thread, which is no=
t<br>
&gt; +#=C2=A0 =C2=A0 declared using the ``-object iothread`` command-line o=
ption.=C2=A0 It is<br>
&gt; +#=C2=A0 =C2=A0 always the main thread of the process.<br>
<br>
You&#39;re adding markup.=C2=A0 Welcome, but put it in a separate patch, pl=
ease,<br>
to keep this one mechanical.<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">OK</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Returns: a list of @IOThreadInfo for each iothread<br>
&gt;=C2=A0 #<br>
&gt; @@ -136,13 +136,13 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: This function will succeed even if the guest is already in<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0the stopped state.=C2=A0 In &quot;inmigrate&quot=
; state, it will ensure that<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0the guest remains paused once migration finishes=
, as if the -S<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0option was passed on the command line.<br>
&gt; +# .. note:: This function will succeed even if the guest is already i=
n<br>
&gt; +#=C2=A0 =C2=A0 the stopped state.=C2=A0 In &quot;inmigrate&quot; stat=
e, it will ensure that the<br>
&gt; +#=C2=A0 =C2=A0 guest remains paused once migration finishes, as if th=
e ``-S``<br>
&gt; +#=C2=A0 =C2=A0 option was passed on the command line.<br>
<br>
Likewise.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">;_;</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0In the &quot;suspended&quot; state, it will comp=
letely stop the VM and<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0cause a transition to the &quot;paused&quot; sta=
te.=C2=A0 (Since 9.0)<br>
&gt; +#=C2=A0 =C2=A0 In the &quot;suspended&quot; state, it will completely=
 stop the VM and cause<br>
&gt; +#=C2=A0 =C2=A0 a transition to the &quot;paused&quot; state.=C2=A0 (S=
ince 9.0)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -158,15 +158,15 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: This command will succeed if the guest is currently running.=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0It will also succeed if the guest is in the &quo=
t;inmigrate&quot; state;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0in this case, the effect of the command is to ma=
ke sure the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0guest starts once migration finishes, removing t=
he effect of the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0-S command line option if it was passed.<br>
&gt; +# .. note:: This command will succeed if the guest is currently runni=
ng.<br>
&gt; +#=C2=A0 =C2=A0 It will also succeed if the guest is in the &quot;inmi=
grate&quot; state; in<br>
&gt; +#=C2=A0 =C2=A0 this case, the effect of the command is to make sure t=
he guest<br>
&gt; +#=C2=A0 =C2=A0 starts once migration finishes, removing the effect of=
 the ``-S``<br>
&gt; +#=C2=A0 =C2=A0 command line option if it was passed.<br>
<br>
Likewise.<br>
<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0If the VM was previously suspended, and not been=
 reset or woken,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0this command will transition back to the &quot;s=
uspended&quot; state.<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0(Since 9.0)<br>
&gt; +#=C2=A0 =C2=A0 If the VM was previously suspended, and not been reset=
 or woken,<br>
&gt; +#=C2=A0 =C2=A0 this command will transition back to the &quot;suspend=
ed&quot; state.=C2=A0 (Since<br>
&gt; +#=C2=A0 =C2=A0 9.0)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -219,18 +219,18 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: This command only exists as a stop-gap.=C2=A0 Its use is hig=
hly<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0discouraged.=C2=A0 The semantics of this command=
 are not guaranteed:<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0this means that command names, arguments and res=
ponses can<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0change or be removed at ANY time.=C2=A0 Applicat=
ions that rely on<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0long term stability guarantees should NOT use th=
is command.<br>
&gt; +# .. note:: This command only exists as a stop-gap.=C2=A0 Its use is =
highly<br>
&gt; +#=C2=A0 =C2=A0 discouraged.=C2=A0 The semantics of this command are n=
ot guaranteed:<br>
&gt; +#=C2=A0 =C2=A0 this means that command names, arguments and responses=
 can change<br>
&gt; +#=C2=A0 =C2=A0 or be removed at ANY time.=C2=A0 Applications that rel=
y on long term<br>
&gt; +#=C2=A0 =C2=A0 stability guarantees should NOT use this command.<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Known limitations:<br>
&gt; +#=C2=A0 =C2=A0 Known limitations:<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0* This command is stateless, this means that com=
mands that<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0depend on state information (such as getf=
d) might not work<br>
&gt; +#=C2=A0 =C2=A0 * This command is stateless, this means that commands =
that<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 depend on state information (such as getfd) mig=
ht not work.<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0* Commands that prompt the user for data don&#39=
;t currently work<br>
&gt; +#=C2=A0 =C2=A0 * Commands that prompt the user for data don&#39;t cur=
rently work.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -252,11 +252,11 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: If @fdname already exists, the file descriptor assigned to i=
t<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0will be closed and replaced by the received file=
 descriptor.<br>
&gt; +# .. note:: If @fdname already exists, the file descriptor assigned t=
o<br>
&gt; +#=C2=A0 =C2=A0 it will be closed and replaced by the received file de=
scriptor.<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0The &#39;closefd&#39; command can be used to exp=
licitly close the file<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0descriptor when it is no longer needed.<br>
&gt; +#=C2=A0 =C2=A0 The &#39;closefd&#39; command can be used to explicitl=
y close the file<br>
&gt; +#=C2=A0 =C2=A0 descriptor when it is no longer needed.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -279,11 +279,11 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 8.0<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: If @fdname already exists, the file descriptor assigned to i=
t<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0will be closed and replaced by the received file=
 descriptor.<br>
&gt; +# .. note:: If @fdname already exists, the file descriptor assigned t=
o<br>
&gt; +#=C2=A0 =C2=A0 it will be closed and replaced by the received file de=
scriptor.<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0The &#39;closefd&#39; command can be used to exp=
licitly close the file<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0descriptor when it is no longer needed.<br>
&gt; +#=C2=A0 =C2=A0 The &#39;closefd&#39; command can be used to explicitl=
y close the file<br>
&gt; +#=C2=A0 =C2=A0 descriptor when it is no longer needed.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -339,10 +339,9 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If file descriptor was not received, Gene=
ricError<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If @fdset-id is a negative value, Generic=
Error<br>
&gt;=C2=A0 #<br>
&gt; -# Notes:<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0The list of fd sets is shared by all monitor con=
nections.<br>
&gt; +# .. note:: The list of fd sets is shared by all monitor connections.=
<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0If @fdset-id is not specified, a new fd set will=
 be created.<br>
&gt; +# .. note:: If @fdset-id is not specified, a new fd set will be creat=
ed.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.2<br>
&gt;=C2=A0 #<br>
&gt; @@ -370,11 +369,10 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.2<br>
&gt;=C2=A0 #<br>
&gt; -# Notes:<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0The list of fd sets is shared by all monitor con=
nections.<br>
&gt; +# .. note:: The list of fd sets is shared by all monitor connections.=
<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0If @fd is not specified, all file descriptors in=
 @fdset-id will<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0be removed.<br>
&gt; +# .. note:: If @fd is not specified, all file descriptors in @fdset-i=
d<br>
&gt; +#=C2=A0 =C2=A0 will be removed.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -420,7 +418,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.2<br>
&gt;=C2=A0 #<br>
&gt; -# Note: The list of fd sets is shared by all monitor connections.<br>
&gt; +# .. note:: The list of fd sets is shared by all monitor connections.=
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -561,9 +559,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @qom-path: path to the RTC object in the QOM tree<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This event is rate-limited.=C2=A0 It is not guaranteed that t=
he RTC<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0in the system implements this event, or even tha=
t the system has<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0an RTC at all.<br>
&gt; +# .. note:: This event is rate-limited.=C2=A0 It is not guaranteed th=
at the<br>
&gt; +#=C2=A0 =C2=A0 RTC in the system implements this event, or even that =
the system<br>
&gt; +#=C2=A0 =C2=A0 has an RTC at all.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.13<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/net.json b/qapi/net.json<br>
&gt; index dc616d010f0..4ac7fdc7e6c 100644<br>
&gt; --- a/qapi/net.json<br>
&gt; +++ b/qapi/net.json<br>
&gt; @@ -22,9 +22,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: Not all network adapters support setting link status.=C2=A0 =
This<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0command will succeed even if the network adapter=
 does not<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0support link status notification.<br>
&gt; +# .. note:: Not all network adapters support setting link status.=C2=
=A0 This<br>
&gt; +#=C2=A0 =C2=A0 command will succeed even if the network adapter does =
not support<br>
&gt; +#=C2=A0 =C2=A0 link status notification.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/pci.json b/qapi/pci.json<br>
&gt; index 08bf6958634..f51159a2c4c 100644<br>
&gt; --- a/qapi/pci.json<br>
&gt; +++ b/qapi/pci.json<br>
&gt; @@ -146,8 +146,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @regions: a list of the PCI I/O regions associated with the de=
vice<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: the contents of @class_info.desc are not stable and should<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0only be treated as informational.<br>
&gt; +# .. note:: The contents of @class_info.desc are not stable and shoul=
d<br>
&gt; +#=C2=A0 =C2=A0 only be treated as informational.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 ##<br>
&gt; @@ -311,7 +311,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This example has been shortened as the real response is too<b=
r>
&gt; +#=C2=A0 =C2=A0 =C2=A0Note: This example has been shortened as the rea=
l response is too<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0long.<br>
&gt; +#<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;query-pci&#39;, &#39;returns&#39;: [&#=
39;PciInfo&#39;] }<br>
&gt; diff --git a/qapi/qdev.json b/qapi/qdev.json<br>
&gt; index facaa0bc6a2..d031fc3590d 100644<br>
&gt; --- a/qapi/qdev.json<br>
&gt; +++ b/qapi/qdev.json<br>
&gt; @@ -20,9 +20,9 @@<br>
&gt;=C2=A0 # Returns: a list of ObjectPropertyInfo describing a devices<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0properties<br>
&gt;=C2=A0 #<br>
&gt; -# Note: objects can create properties at runtime, for example to<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0describe links between different devices and/or =
objects.=C2=A0 These<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0properties are not included in the output of thi=
s command.<br>
&gt; +# .. note:: Objects can create properties at runtime, for example to<=
br>
&gt; +#=C2=A0 =C2=A0 describe links between different devices and/or object=
s.=C2=A0 These<br>
&gt; +#=C2=A0 =C2=A0 properties are not included in the output of this comm=
and.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.2<br>
&gt;=C2=A0 ##<br>
&gt; @@ -51,7 +51,7 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0supports JSON syntax without the reference =
counting leak that<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0broke hot-unplug<br>
&gt;=C2=A0 #<br>
&gt; -# Notes:<br>
&gt; +# .. admonition:: Notes<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A01. Additional arguments depend on the type.=
<br>
&gt;=C2=A0 #<br>
&gt; @@ -59,8 +59,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 the &#39;docs/qdev-device-use.txt&#=
39; file.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A03. It&#39;s possible to list device propert=
ies by running QEMU with<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 the &quot;-device DEVICE,help&quot; comm=
and-line argument, where DEVICE<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 is the device&#39;s name<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 the ``-device DEVICE,help`` command-line=
 argument, where DEVICE<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 is the device&#39;s name.<br>
<br>
Likewise.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Example:<br>
&gt;=C2=A0 #<br>
&gt; @@ -92,15 +92,15 @@<br>
&gt;=C2=A0 # Errors:<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If @id is not a valid device, DeviceNotFo=
und<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: When this command completes, the device may not be removed<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0from the guest.=C2=A0 Hot removal is an operatio=
n that requires guest<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0cooperation.=C2=A0 This command merely requests =
that the guest begin<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0the hot removal process.=C2=A0 Completion of the=
 device removal<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0process is signaled with a DEVICE_DELETED event.=
=C2=A0 Guest reset<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0will automatically complete removal for all devi=
ces.=C2=A0 If a<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0guest-side error in the hot removal process is d=
etected, the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0device will not be removed and a DEVICE_UNPLUG_G=
UEST_ERROR event<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0is sent.=C2=A0 Some errors cannot be detected.<b=
r>
&gt; +# .. note:: When this command completes, the device may not be remove=
d<br>
&gt; +#=C2=A0 =C2=A0 from the guest.=C2=A0 Hot removal is an operation that=
 requires guest<br>
&gt; +#=C2=A0 =C2=A0 cooperation.=C2=A0 This command merely requests that t=
he guest begin the<br>
&gt; +#=C2=A0 =C2=A0 hot removal process.=C2=A0 Completion of the device re=
moval process is<br>
&gt; +#=C2=A0 =C2=A0 signaled with a DEVICE_DELETED event.=C2=A0 Guest rese=
t will<br>
&gt; +#=C2=A0 =C2=A0 automatically complete removal for all devices.=C2=A0 =
If a guest-side<br>
&gt; +#=C2=A0 =C2=A0 error in the hot removal process is detected, the devi=
ce will not<br>
&gt; +#=C2=A0 =C2=A0 be removed and a DEVICE_UNPLUG_GUEST_ERROR event is se=
nt.=C2=A0 Some<br>
&gt; +#=C2=A0 =C2=A0 errors cannot be detected.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/qom.json b/qapi/qom.json<br>
&gt; index 8f0601859b1..e927f4a3c5d 100644<br>
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
&gt;=C2=A0 { &#39;command&#39;: &#39;qom-list-properties&#39;,<br>
&gt; @@ -608,12 +608,11 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0older to allow migration with newer QEMU ve=
rsions.<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0(default: false generally, but true for mac=
hine types &lt;=3D 4.0)<br>
&gt;=C2=A0 #<br>
&gt; -# Note: prealloc=3Dtrue and reserve=3Dfalse cannot be set at the same=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0time.=C2=A0 With reserve=3Dtrue, the behavior de=
pends on the operating<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0system: for example, Linux will not reserve swap=
 space for<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0shared file mappings -- &quot;not applicable&quo=
t;. In contrast,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0reserve=3Dfalse will bail out if it cannot be co=
nfigured<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0accordingly.<br>
&gt; +# .. note:: prealloc=3Dtrue and reserve=3Dfalse cannot be set at the =
same<br>
&gt; +#=C2=A0 =C2=A0 time.=C2=A0 With reserve=3Dtrue, the behavior depends =
on the operating<br>
&gt; +#=C2=A0 =C2=A0 system: for example, Linux will not reserve swap space=
 for shared<br>
&gt; +#=C2=A0 =C2=A0 file mappings -- &quot;not applicable&quot;. In contra=
st, reserve=3Dfalse will<br>
&gt; +#=C2=A0 =C2=A0 bail out if it cannot be configured accordingly.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.1<br>
&gt;=C2=A0 ##<br>
&gt; diff --git a/qapi/rocker.json b/qapi/rocker.json<br>
&gt; index f5225eb62cc..9f95e638309 100644<br>
&gt; --- a/qapi/rocker.json<br>
&gt; +++ b/qapi/rocker.json<br>
&gt; @@ -138,8 +138,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @ip-dst: IP header destination address<br>
&gt;=C2=A0 #<br>
&gt; -# Note: optional members may or may not appear in the flow key<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0depending if they&#39;re relevant to the flow ke=
y.<br>
&gt; +# .. note:: Optional members may or may not appear in the flow key<br=
>
&gt; +#=C2=A0 =C2=A0 depending if they&#39;re relevant to the flow key.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.4<br>
&gt;=C2=A0 ##<br>
&gt; @@ -168,8 +168,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @ip-tos: IP header TOS field<br>
&gt;=C2=A0 #<br>
&gt; -# Note: optional members may or may not appear in the flow mask<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0depending if they&#39;re relevant to the flow ma=
sk.<br>
&gt; +# .. note:: Optional members may or may not appear in the flow mask<b=
r>
&gt; +#=C2=A0 =C2=A0 depending if they&#39;re relevant to the flow mask.<br=
>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.4<br>
&gt;=C2=A0 ##<br>
&gt; @@ -195,8 +195,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @out-pport: physical output port<br>
&gt;=C2=A0 #<br>
&gt; -# Note: optional members may or may not appear in the flow action<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0depending if they&#39;re relevant to the flow ac=
tion.<br>
&gt; +# .. note:: Optional members may or may not appear in the flow action=
<br>
&gt; +#=C2=A0 =C2=A0 depending if they&#39;re relevant to the flow action.<=
br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.4<br>
&gt;=C2=A0 ##<br>
&gt; @@ -288,8 +288,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @ttl-check: perform TTL check<br>
&gt;=C2=A0 #<br>
&gt; -# Note: optional members may or may not appear in the group depending=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0if they&#39;re relevant to the group type.<br>
&gt; +# .. note:: Optional members may or may not appear in the group depen=
ding<br>
&gt; +#=C2=A0 =C2=A0 if they&#39;re relevant to the group type.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.4<br>
&gt;=C2=A0 ##<br>
&gt; diff --git a/qapi/run-state.json b/qapi/run-state.json<br>
&gt; index f8773f23b29..252d7d6afa7 100644<br>
&gt; --- a/qapi/run-state.json<br>
&gt; +++ b/qapi/run-state.json<br>
&gt; @@ -146,9 +146,9 @@<br>
&gt;=C2=A0 # @reason: The @ShutdownCause which resulted in the SHUTDOWN.<br=
>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0(since 4.0)<br>
&gt;=C2=A0 #<br>
&gt; -# Note: If the command-line option &quot;-no-shutdown&quot; has been =
specified,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0qemu will not exit, and a STOP event will eventu=
ally follow the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0SHUTDOWN event<br>
&gt; +# .. note:: If the command-line option ``-no-shutdown`` has been<br>
&gt; +#=C2=A0 =C2=A0 specified, qemu will not exit, and a STOP event will e=
ventually<br>
&gt; +#=C2=A0 =C2=A0 follow the SHUTDOWN event.<br>
<br>
Likewise.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.12<br>
&gt;=C2=A0 #<br>
&gt; @@ -247,8 +247,8 @@<br>
&gt;=C2=A0 # saved on disk, for example, S4 state, which is sometimes calle=
d<br>
&gt;=C2=A0 # hibernate state<br>
&gt;=C2=A0 #<br>
&gt; -# Note: QEMU shuts down (similar to event @SHUTDOWN) when entering<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0this state<br>
&gt; +# .. note:: QEMU shuts down (similar to event @SHUTDOWN) when enterin=
g<br>
&gt; +#=C2=A0 =C2=A0 this state.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.2<br>
&gt;=C2=A0 #<br>
&gt; @@ -281,11 +281,11 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @action: action that has been taken<br>
&gt;=C2=A0 #<br>
&gt; -# Note: If action is &quot;reset&quot;, &quot;shutdown&quot;, or &quo=
t;pause&quot; the WATCHDOG<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0event is followed respectively by the RESET, SHU=
TDOWN, or STOP<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0events<br>
&gt; +# .. note:: If action is &quot;reset&quot;, &quot;shutdown&quot;, or =
&quot;pause&quot; the WATCHDOG<br>
&gt; +#=C2=A0 =C2=A0 event is followed respectively by the RESET, SHUTDOWN,=
 or STOP<br>
&gt; +#=C2=A0 =C2=A0 events.<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This event is rate-limited.<br>
&gt; +# .. note:: This event is rate-limited.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.13<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/sockets.json b/qapi/sockets.json<br>
&gt; index aa97c897687..f46113ab1b8 100644<br>
&gt; --- a/qapi/sockets.json<br>
&gt; +++ b/qapi/sockets.json<br>
&gt; @@ -104,8 +104,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @port: port<br>
&gt;=C2=A0 #<br>
&gt; -# Note: string types are used to allow for possible future hostname o=
r<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0service resolution support.<br>
&gt; +# .. note:: string types are used to allow for possible future hostna=
me<br>
&gt; +#=C2=A0 =C2=A0 or service resolution support.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.8<br>
&gt;=C2=A0 ##<br>
&gt; @@ -179,9 +179,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @type: Transport type<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This type is deprecated in favor of SocketAddress.=C2=A0 The<=
br>
&gt; -#=C2=A0 =C2=A0 =C2=A0difference between SocketAddressLegacy and Socke=
tAddress is that<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0the latter has fewer {} on the wire.<br>
&gt; +# .. note:: This type is deprecated in favor of SocketAddress.=C2=A0 =
The<br>
&gt; +#=C2=A0 =C2=A0 difference between SocketAddressLegacy and SocketAddre=
ss is that<br>
&gt; +#=C2=A0 =C2=A0 the latter has fewer ``{}`` on the wire.<br>
<br>
Likewise.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.3<br>
&gt;=C2=A0 ##<br>
&gt; diff --git a/qapi/stats.json b/qapi/stats.json<br>
&gt; index c4a9f3ff70e..683929b2322 100644<br>
&gt; --- a/qapi/stats.json<br>
&gt; +++ b/qapi/stats.json<br>
&gt; @@ -254,17 +254,17 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @provider: a provider to restrict the query to.<br>
&gt;=C2=A0 #<br>
&gt; -# Note: runtime-collected statistics and their names fall outside<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0QEMU&#39;s usual deprecation policies.=C2=A0 QEM=
U will try to keep the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0set of available data stable, together with thei=
r names, but<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0will not guarantee stability at all costs; the s=
ame is true of<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0providers that source statistics externally, e.g=
. from Linux.<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0For example, if the same value is being tracked =
with different<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0names on different architectures or by different=
 providers, one<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0of them might be renamed.=C2=A0 A statistic migh=
t go away if an<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0algorithm is changed or some code is removed; ch=
anging a default<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0might cause previously useful statistics to alwa=
ys report 0.<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Such changes, however, are expected to be rare.<=
br>
&gt; +# .. note:: runtime-collected statistics and their names fall outside=
<br>
&gt; +#=C2=A0 =C2=A0 QEMU&#39;s usual deprecation policies.=C2=A0 QEMU will=
 try to keep the set<br>
&gt; +#=C2=A0 =C2=A0 of available data stable, together with their names, b=
ut will not<br>
&gt; +#=C2=A0 =C2=A0 guarantee stability at all costs; the same is true of =
providers<br>
&gt; +#=C2=A0 =C2=A0 that source statistics externally, e.g. from Linux.=C2=
=A0 For example,<br>
&gt; +#=C2=A0 =C2=A0 if the same value is being tracked with different name=
s on<br>
&gt; +#=C2=A0 =C2=A0 different architectures or by different providers, one=
 of them<br>
&gt; +#=C2=A0 =C2=A0 might be renamed.=C2=A0 A statistic might go away if a=
n algorithm is<br>
&gt; +#=C2=A0 =C2=A0 changed or some code is removed; changing a default mi=
ght cause<br>
&gt; +#=C2=A0 =C2=A0 previously useful statistics to always report 0.=C2=A0=
 Such changes,<br>
&gt; +#=C2=A0 =C2=A0 however, are expected to be rare.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 7.1<br>
&gt;=C2=A0 ##<br>
&gt; diff --git a/qapi/transaction.json b/qapi/transaction.json<br>
&gt; index 07afc269d54..bcb05fdedd6 100644<br>
&gt; --- a/qapi/transaction.json<br>
&gt; +++ b/qapi/transaction.json<br>
&gt; @@ -237,10 +237,10 @@<br>
&gt;=C2=A0 # Errors:<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- Any errors from commands in the transacti=
on<br>
&gt;=C2=A0 #<br>
&gt; -# Note: The transaction aborts on the first failure.=C2=A0 Therefore,=
 there<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0will be information on only one failed operation=
 returned in an<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0error condition, and subsequent actions will not=
 have been<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0attempted.<br>
&gt; +# .. note:: The transaction aborts on the first failure.=C2=A0 Theref=
ore,<br>
&gt; +#=C2=A0 =C2=A0 there will be information on only one failed operation=
 returned in<br>
&gt; +#=C2=A0 =C2=A0 an error condition, and subsequent actions will not ha=
ve been<br>
&gt; +#=C2=A0 =C2=A0 attempted.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.1<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/ui.json b/qapi/ui.json<br>
&gt; index 2d0aa407aca..ec72998e28e 100644<br>
&gt; --- a/qapi/ui.json<br>
&gt; +++ b/qapi/ui.json<br>
&gt; @@ -103,11 +103,10 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- &#39;+INT&#39; where INT is the number of=
 seconds from now (integer)<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- &#39;INT&#39; where INT is the absolute t=
ime in seconds<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: Time is relative to the server and currently there is no way=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0to coordinate server time with client time.=C2=
=A0 It is not<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0recommended to use the absolute time version of =
the @time<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0parameter unless you&#39;re sure you are on the =
same machine as the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0QEMU instance.<br>
&gt; +# .. note:: Time is relative to the server and currently there is no =
way<br>
&gt; +#=C2=A0 =C2=A0 to coordinate server time with client time.=C2=A0 It i=
s not recommended<br>
&gt; +#=C2=A0 =C2=A0 to use the absolute time version of the @time paramete=
r unless<br>
&gt; +#=C2=A0 =C2=A0 you&#39;re sure you are on the same machine as the QEM=
U instance.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 7.0<br>
&gt;=C2=A0 ##<br>
&gt; @@ -268,7 +267,7 @@<br>
&gt;=C2=A0 # @unknown: No information is available about mouse mode used by=
 the<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0spice server.<br>
&gt;=C2=A0 #<br>
&gt; -# Note: spice/enums.h has a SpiceMouseMode already, hence the name.<b=
r>
&gt; +# .. note:: spice/enums.h has a SpiceMouseMode already, hence the nam=
e.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.1<br>
&gt;=C2=A0 ##<br>
&gt; @@ -697,9 +696,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.1<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: An empty password in this command will set the password to<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0the empty string.=C2=A0 Existing clients are una=
ffected by executing<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0this command.<br>
&gt; +# .. note:: An empty password in this command will set the password t=
o<br>
&gt; +#=C2=A0 =C2=A0 the empty string.=C2=A0 Existing clients are unaffecte=
d by executing<br>
&gt; +#=C2=A0 =C2=A0 this command.<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;change-vnc-password&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;data&#39;: { &#39;password&#39;: &#39;str&#39; },<br=
>
&gt; @@ -714,8 +713,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @client: client information<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This event is emitted before any authentication takes place,<=
br>
&gt; -#=C2=A0 =C2=A0 =C2=A0thus the authentication ID is not provided<br>
&gt; +# .. note:: This event is emitted before any authentication takes pla=
ce,<br>
&gt; +#=C2=A0 =C2=A0 thus the authentication ID is not provided.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.13<br>
&gt;=C2=A0 #<br>
&gt; @@ -1260,10 +1259,10 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.6<br>
&gt;=C2=A0 #<br>
&gt; -# Note: The consoles are visible in the qom tree, under<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0/backend/console[$index]. They have a device lin=
k and head<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0property, so it is possible to map which console=
 belongs to<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0which device and display.<br>
&gt; +# .. note:: The consoles are visible in the qom tree, under<br>
&gt; +#=C2=A0 =C2=A0 ``/backend/console[$index]``. They have a device link =
and head<br>
&gt; +#=C2=A0 =C2=A0 property, so it is possible to map which console belon=
gs to which<br>
&gt; +#=C2=A0 =C2=A0 device and display.<br>
<br>
Likewise.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Examples:<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/virtio.json b/qapi/virtio.json<br>
&gt; index 74fc27c7029..b91f3cdd0df 100644<br>
&gt; --- a/qapi/virtio.json<br>
&gt; +++ b/qapi/virtio.json<br>
&gt; @@ -559,12 +559,12 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Returns: VirtQueueStatus of the VirtQueue<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: last_avail_idx will not be displayed in the case where the<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0selected VirtIODevice has a running vhost device=
 and the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0VirtIODevice VirtQueue index (queue) does not ex=
ist for the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0corresponding vhost device vhost_virtqueue.=C2=
=A0 Also,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0shadow_avail_idx will not be displayed in the ca=
se where the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0selected VirtIODevice has a running vhost device=
.<br>
&gt; +# .. note:: last_avail_idx will not be displayed in the case where th=
e<br>
&gt; +#=C2=A0 =C2=A0 selected VirtIODevice has a running vhost device and t=
he<br>
&gt; +#=C2=A0 =C2=A0 VirtIODevice VirtQueue index (queue) does not exist fo=
r the<br>
&gt; +#=C2=A0 =C2=A0 corresponding vhost device vhost_virtqueue.=C2=A0 Also=
, shadow_avail_idx<br>
&gt; +#=C2=A0 =C2=A0 will not be displayed in the case where the selected V=
irtIODevice<br>
&gt; +#=C2=A0 =C2=A0 has a running vhost device.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 7.2<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt; index b3de1fb6b3a..1273d85bb5f 100644<br>
&gt; --- a/qga/qapi-schema.json<br>
&gt; +++ b/qga/qapi-schema.json<br>
&gt; @@ -422,8 +422,9 @@<br>
&gt;=C2=A0 # Returns: GuestFsfreezeStatus (&quot;thawed&quot;, &quot;frozen=
&quot;, etc., as defined<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0below)<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This may fail to properly report the current state as a resul=
t<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0of some other guest processes having issued an f=
s freeze/thaw.<br>
&gt; +# .. note:: This may fail to properly report the current state as a<b=
r>
&gt; +#=C2=A0 =C2=A0 result of some other guest processes having issued an =
fs<br>
&gt; +#=C2=A0 =C2=A0 freeze/thaw.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.15.0<br>
&gt;=C2=A0 ##<br>
&gt; @@ -443,9 +444,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Returns: Number of file systems currently frozen.<br>
&gt;=C2=A0 #<br>
&gt; -# Note: On Windows, the command is implemented with the help of a<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Volume Shadow-copy Service DLL helper.=C2=A0 The=
 frozen state is<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0limited for up to 10 seconds by VSS.<br>
&gt; +# .. note:: On Windows, the command is implemented with the help of a=
<br>
&gt; +#=C2=A0 =C2=A0 Volume Shadow-copy Service DLL helper.=C2=A0 The froze=
n state is limited<br>
&gt; +#=C2=A0 =C2=A0 for up to 10 seconds by VSS.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.15.0<br>
&gt;=C2=A0 ##<br>
&gt; @@ -479,10 +480,10 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Returns: Number of file systems thawed by this call<br>
&gt;=C2=A0 #<br>
&gt; -# Note: if return value does not match the previous call to<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0guest-fsfreeze-freeze, this likely means some fr=
eezable<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0filesystems were unfrozen before this call, and =
that the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0filesystem state may have changed before issuing=
 this command.<br>
&gt; +# .. note:: If the return value does not match the previous call to<b=
r>
&gt; +#=C2=A0 =C2=A0 guest-fsfreeze-freeze, this likely means some freezabl=
e filesystems<br>
&gt; +#=C2=A0 =C2=A0 were unfrozen before this call, and that the filesyste=
m state may<br>
&gt; +#=C2=A0 =C2=A0 have changed before issuing this command.<br>
<br>
Prose again.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Okey dokey.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.15.0<br>
&gt;=C2=A0 ##<br>
&gt; @@ -560,8 +561,8 @@<br>
&gt;=C2=A0 # Errors:<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If suspend to disk is not supported, Unsu=
pported<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: It&#39;s strongly recommended to issue the guest-sync comman=
d<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0before sending commands when the guest resumes<b=
r>
&gt; +# .. note:: It&#39;s strongly recommended to issue the guest-sync com=
mand<br>
&gt; +#=C2=A0 =C2=A0 before sending commands when the guest resumes.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.1<br>
&gt;=C2=A0 ##<br>
&gt; @@ -596,8 +597,8 @@<br>
&gt;=C2=A0 # Errors:<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If suspend to ram is not supported, Unsup=
ported<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: It&#39;s strongly recommended to issue the guest-sync comman=
d<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0before sending commands when the guest resumes<b=
r>
&gt; +# .. note:: It&#39;s strongly recommended to issue the guest-sync com=
mand<br>
&gt; +#=C2=A0 =C2=A0 before sending commands when the guest resumes.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.1<br>
&gt;=C2=A0 ##<br>
&gt; @@ -631,8 +632,8 @@<br>
&gt;=C2=A0 # Errors:<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If hybrid suspend is not supported, Unsup=
ported<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: It&#39;s strongly recommended to issue the guest-sync comman=
d<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0before sending commands when the guest resumes<b=
r>
&gt; +# .. note:: It&#39;s strongly recommended to issue the guest-sync com=
mand<br>
&gt; +#=C2=A0 =C2=A0 before sending commands when the guest resumes.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.1<br>
&gt;=C2=A0 ##<br>
&gt; @@ -1461,16 +1462,15 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0* POSIX: as defined by os-release(5)<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0* Windows: contains string &quot;server&quo=
t; or &quot;client&quot;<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: On POSIX systems the fields @id, @name, @pretty-name,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0@version, @version-id, @variant and @variant-id =
follow the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0definition specified in os-release(5). Refer to =
the manual page<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0for exact description of the fields.=C2=A0 Their=
 values are taken<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0from the os-release file.=C2=A0 If the file is n=
ot present in the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0system, or the values are not present in the fil=
e, the fields<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0are not included.<br>
&gt; +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,<br>
&gt; +#=C2=A0 =C2=A0 @version, @version-id, @variant and @variant-id follow=
 the<br>
&gt; +#=C2=A0 =C2=A0 definition specified in os-release(5). Refer to the ma=
nual page for<br>
&gt; +#=C2=A0 =C2=A0 exact description of the fields.=C2=A0 Their values ar=
e taken from the<br>
&gt; +#=C2=A0 =C2=A0 os-release file.=C2=A0 If the file is not present in t=
he system, or the<br>
&gt; +#=C2=A0 =C2=A0 values are not present in the file, the fields are not=
 included.<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0On Windows the values are filled from informatio=
n gathered from<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0the system.<br>
&gt; +#=C2=A0 =C2=A0 On Windows the values are filled from information gath=
ered from<br>
&gt; +#=C2=A0 =C2=A0 the system.<br>
<br>
Accidental indentation change?<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">I don&#39;t think so; the original heading se=
ems to suggest that there is a sequence of notes; &quot;On POSIX&quot; ... =
&quot;On Windows&quot;. This indentation change keeps this information in t=
he same note box.<br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.10<br>
&gt;=C2=A0 ##<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index 3cd8e7ee295..8b1da96124e 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -557,6 +557,15 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 r&#39;(Returns|Errors|Since|Notes?|Examples?|TODO): *&=
#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 line):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # tagged section<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if &#39;Note&#39; in match.group(1):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 emsg =3D (<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;The &#39;{match.group(1)}&#39; section =
is deprecated.&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; Please use rST&#39;s &#39;.. note::&#39=
; directive or &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;another suitable admonition instead.&quo=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 raise QAPIParseError(self, emsg)<br>
<br>
This isn&#39;t merely deprecated, it&#39;s a hard error.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Fair enuff....</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 doc.new_tagged_section(<a href=3D"http://self.info" rel=3D"noreferre=
r noreferrer" target=3D"_blank">self.info</a>, match.group(1))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 text =3D line[match.end():]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if text:<br>
&gt; diff --git a/tests/qapi-schema/doc-empty-section.err b/tests/qapi-sche=
ma/doc-empty-section.err<br>
&gt; index 5f03a6d733f..711a0d629c2 100644<br>
&gt; --- a/tests/qapi-schema/doc-empty-section.err<br>
&gt; +++ b/tests/qapi-schema/doc-empty-section.err<br>
&gt; @@ -1 +1 @@<br>
&gt; -doc-empty-section.json:6: text required after &#39;Note:&#39;<br>
&gt; +doc-empty-section.json:6: text required after &#39;Errors:&#39;<br>
&gt; diff --git a/tests/qapi-schema/doc-empty-section.json b/tests/qapi-sch=
ema/doc-empty-section.json<br>
&gt; index f3384e9a3bb..f179d3eff6d 100644<br>
&gt; --- a/tests/qapi-schema/doc-empty-section.json<br>
&gt; +++ b/tests/qapi-schema/doc-empty-section.json<br>
&gt; @@ -3,6 +3,6 @@<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @foo:<br>
&gt;=C2=A0 #<br>
&gt; -# Note:<br>
&gt; +# Errors:<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;foo&#39;, &#39;data&#39;: {&#39;a&#39;=
: &#39;int&#39;} }<br>
&gt; diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-g=
ood.json<br>
&gt; index de38a386e8f..0a294eb324e 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.json<br>
&gt; +++ b/tests/qapi-schema/doc-good.json<br>
&gt; @@ -29,7 +29,7 @@<br>
&gt;=C2=A0 # - Second list<br>
&gt;=C2=A0 #=C2=A0 =C2=A0Note: still in list<br>
&gt;=C2=A0 #<br>
&gt; -# Note: not in list<br>
&gt; +# .. note:: not in list<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # 1. Third list<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 is numbered<br>
&gt; @@ -155,7 +155,7 @@<br>
&gt;=C2=A0 # @cmd-feat1: a feature<br>
&gt;=C2=A0 # @cmd-feat2: another feature<br>
&gt;=C2=A0 #<br>
&gt; -# Note: @arg3 is undocumented<br>
&gt; +# .. note:: @arg3 is undocumented<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Returns: @Object<br>
&gt;=C2=A0 #<br>
&gt; @@ -163,7 +163,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # TODO: frobnicate<br>
&gt;=C2=A0 #<br>
&gt; -# Notes:<br>
&gt; +# .. admonition:: Notes<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 - Lorem ipsum dolor sit amet<br>
&gt;=C2=A0 #=C2=A0 - Ut enim ad minim veniam<br>
&gt; diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-go=
od.out<br>
&gt; index 435f6e6d768..2c9b4e419cb 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.out<br>
&gt; +++ b/tests/qapi-schema/doc-good.out<br>
&gt; @@ -76,7 +76,7 @@ Not in list<br>
&gt;=C2=A0 - Second list<br>
&gt;=C2=A0 =C2=A0 Note: still in list<br>
&gt;=C2=A0 <br>
&gt; -Note: not in list<br>
&gt; +.. note:: not in list<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 1. Third list<br>
&gt;=C2=A0 =C2=A0 =C2=A0is numbered<br>
&gt; @@ -169,15 +169,17 @@ description starts on the same line<br>
&gt;=C2=A0 a feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Dcmd-feat2<br>
&gt;=C2=A0 another feature<br>
&gt; -=C2=A0 =C2=A0 section=3DNote<br>
&gt; -@arg3 is undocumented<br>
&gt; +=C2=A0 =C2=A0 section=3DNone<br>
&gt; +.. note:: @arg3 is undocumented<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DReturns<br>
&gt;=C2=A0 @Object<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DErrors<br>
&gt;=C2=A0 some<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DTODO<br>
&gt;=C2=A0 frobnicate<br>
&gt; -=C2=A0 =C2=A0 section=3DNotes<br>
&gt; +=C2=A0 =C2=A0 section=3DNone<br>
&gt; +.. admonition:: Notes<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0- Lorem ipsum dolor sit amet<br>
&gt;=C2=A0 =C2=A0- Ut enim ad minim veniam<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-go=
od.txt<br>
&gt; index 847db70412d..b89f35d5476 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.txt<br>
&gt; +++ b/tests/qapi-schema/doc-good.txt<br>
&gt; @@ -17,7 +17,9 @@ Not in list<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 * Second list Note: still in list<br>
&gt;=C2=A0 <br>
&gt; -Note: not in list<br>
&gt; +Note:<br>
&gt; +<br>
&gt; +=C2=A0 not in list<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 1. Third list is numbered<br>
&gt;=C2=A0 <br>
&gt; @@ -193,11 +195,9 @@ Features<br>
&gt;=C2=A0 &quot;cmd-feat2&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0another feature<br>
&gt;=C2=A0 <br>
&gt; +Note:<br>
&gt;=C2=A0 <br>
&gt; -Note<br>
&gt; -~~~~<br>
&gt; -<br>
&gt; -&quot;arg3&quot; is undocumented<br>
&gt; +=C2=A0 &quot;arg3&quot; is undocumented<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Returns<br>
&gt; @@ -211,9 +211,7 @@ Errors<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 some<br>
&gt;=C2=A0 <br>
&gt; -<br>
&gt; -Notes<br>
&gt; -~~~~~<br>
&gt; +Notes:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 * Lorem ipsum dolor sit amet<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qapi-schema/doc-interleaved-section.json b/tests/qa=
pi-schema/doc-interleaved-section.json<br>
&gt; index adb29e98daa..b26bc0bbb79 100644<br>
&gt; --- a/tests/qapi-schema/doc-interleaved-section.json<br>
&gt; +++ b/tests/qapi-schema/doc-interleaved-section.json<br>
&gt; @@ -10,7 +10,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bao<br>
&gt;=C2=A0 #<br>
&gt; -# Note: a section.<br>
&gt; +# Returns: a section.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @foobar: catch this<br>
&gt;=C2=A0 #<br>
<br>
I love this, and want it merged as soon as possible.=C2=A0 Can we spin this=
<br>
off into its own series along with its dependencies?=C2=A0 Feel free to thr=
ow<br>
in uncontroversial small fry.=C2=A0 Perhaps<br>
<br>
=C2=A0 =C2=A0 qapi: linter fixups<br>
=C2=A0 =C2=A0 docs/qapidoc: delint a tiny portion of the module<br>
=C2=A0 =C2=A0 qapi/parser: preserve indentation in QAPIDoc sections<br>
=C2=A0 =C2=A0 qapi/parser: fix comment parsing immediately following a doc =
block<br>
=C2=A0 =C2=A0 docs/qapidoc: fix nested parsing under untagged sections<br>
=C2=A0 =C2=A0 qapi: fix non-compliant JSON examples<br>
=C2=A0 =C2=A0 qapi: ensure all errors sections are uniformly typset<br>
=C2=A0 =C2=A0 qapi: convert &quot;Note&quot; sections to plain rST<br>
=C2=A0 =C2=A0 qapi: convert &quot;Example&quot; sections to rST<br>
<br>
Has just one trivial conflict for me.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Yeah, this works ... I fixed up the p=
rose/markup changes you pointed out above and stuck them in separate patche=
s. I need to go through the Examples feedback still, but as of now:</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">jsnow@scv ~/s/q/qapi (sphinx-do=
main-prereqs-docs)&gt; stg series --description<br>+ do-not-merge-add-some-=
ad-hoc =C2=A0 # [DO-NOT-MERGE]: Add some ad-hoc linting helpers.<br>+ qapi-=
linter-fixups =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # qapi: linter fixu=
ps<br>+ docs-qapidoc-delint-a-tiny =C2=A0 =C2=A0 # docs/qapidoc: delint a t=
iny portion of the module<br>+ qapi-parser-preserve =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 # qapi/parser: preserve indentation in QAPIDoc sections<br>+ =
qapi-parser-fix-comment =C2=A0 =C2=A0 =C2=A0 =C2=A0# qapi/parser: fix comme=
nt parsing immediately following a doc block<br>+ docs-qapidoc-fix-nested =
=C2=A0 =C2=A0 =C2=A0 =C2=A0# docs/qapidoc: fix nested parsing under untagge=
d sections<br>+ qapi-fix-non-compliant-json =C2=A0 =C2=A0# qapi: fix non-co=
mpliant JSON examples<br>+ qapi-ensure-all-errors =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 # qapi: ensure all errors sections are uniformly typset<br>+ qapi-conve=
rt-note-sections-to =C2=A0# qapi: convert &quot;Note&quot; sections to plai=
n rST<br>+ qapi-update-prose-in-note =C2=A0 =C2=A0 =C2=A0# qapi: Update pro=
se in Note blocks<br>&gt; qapi-add-markup-to-note-blocks # qapi: Add markup=
 to note blocks<br>- qapi-convert-example-sections =C2=A0# qapi: convert &q=
uot;Example&quot; sections to rST</div><div dir=3D"auto"><br></div><div>Onw=
ards to the Examples patch, ...<br></div><div dir=3D"auto"><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>
</div>

--000000000000a68a4e061b1b5dd6--


