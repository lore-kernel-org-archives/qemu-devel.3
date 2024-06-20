Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5F0C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJtH-0000QM-At; Thu, 20 Jun 2024 11:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKJtF-0000PV-Mw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKJtA-0002pY-Ll
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718897991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cbOqVbTycNjZyeGv5WvJWOarMSHPZdrqMQjU1gXziEU=;
 b=ivI0ruci4OgbUXMu29YEuG21yzsup3VAy/VbpVDgr+XD9hzaUwffs+ES+mfmdHyTgQRd6t
 aL2rJICZkI7Izp6TD0ec1h46ogKxmi9jHh74qYTdWDDeFLHQs/QiVvoh2QwpvFHU6RVHrJ
 UvDxOPdzmj/llC+/M63xvjxaNK/2ToM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-WlA0PsYRP16pAH7LKhx1Rw-1; Thu, 20 Jun 2024 11:39:49 -0400
X-MC-Unique: WlA0PsYRP16pAH7LKhx1Rw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c7a6ce23c2so1156339a91.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718897988; x=1719502788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cbOqVbTycNjZyeGv5WvJWOarMSHPZdrqMQjU1gXziEU=;
 b=tZxQM/PIbWR53ooNzyEi0HDWYqXjNxzU/yI5oUmOeLPpks4f2ytdniUboN0gvXZHuP
 dYAzvMUGMJu6FlM3T0PB0F7vIY4LlcWnUbScHWIDe3oQMxKSbKnpnBh6FEKrPfQOdYKG
 Se3xBayX+jV2+4PXlutznqOGjoJaMb18aBYon9CKe+1sfPvgmzh3zc61D+X04p1H5gqp
 lqxuouCFlpLhuKq/y/m6Tl3ZljZgSKCS0mNV5lEzKJCzxxSKXcIpbUFquAC5mM04V3w+
 gi9WTfaBEWrk3PGKNSRXR6EMGuqwoiVMhYnwuqt2I6oIpmxHmUcCaV2EF9LaWndFznjJ
 mUrw==
X-Gm-Message-State: AOJu0YwACdgvds1zbvsCeQKWRnWnJrSwV2UNY6YyNaq9wtLmtTAo1EUx
 S0xdfxMJ30QhowwnKXA5w0dMeuzCApYZ9gdYjZK+RAjjFM7zgv9FB+XDyl53tTbXn1myi04FNUP
 gncBTTmosEtTf3EVglixnfvD/Te3qUbywWgtNh17/B2HnmuH3wkVoBqXf6DR4DvCg0KqAXM31Hz
 fZumULAwt9OcEtlREeto8tpOSe9mw=
X-Received: by 2002:a17:90a:1281:b0:2c8:7ea:8f45 with SMTP id
 98e67ed59e1d1-2c807ea8fc3mr913455a91.35.1718897988466; 
 Thu, 20 Jun 2024 08:39:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzpz1FluVltnFauwLqKzfOCxunJJuZBCTH5RMxfFRkgve9DRJkXjtDA8oDJPaDRmWX9zhjL5EqaJQcNClWBpM=
X-Received: by 2002:a17:90a:1281:b0:2c8:7ea:8f45 with SMTP id
 98e67ed59e1d1-2c807ea8fc3mr913408a91.35.1718897987950; Thu, 20 Jun 2024
 08:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
 <87wmmlyu64.fsf@pond.sub.org>
In-Reply-To: <87wmmlyu64.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 20 Jun 2024 11:39:35 -0400
Message-ID: <CAFn=p-aF1_1dvEyihagePrgRF_d7=JDXLUttyJzcxbo355xoCQ@mail.gmail.com>
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
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex.williamson@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fa2e3d061b541f93"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

--000000000000fa2e3d061b541f93
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024, 8:49=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

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
>
> Scratch "... ..." and downcase "Update"?
>
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
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index b3de1fb6b3a..57598331c5c 100644
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
> > +# .. note:: If return value does not match the previous call to
> > +#    guest-fsfreeze-freeze, this likely means some freezable filesyste=
ms
> > +#    were unfrozen before this call, and that the filesystem state may
> > +#    have changed before issuing this command.
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
> Please don't change the indentation here.  I get the same output with
>
>   @@ -1461,7 +1462,7 @@
>    #     * POSIX: as defined by os-release(5)
>    #     * Windows: contains string "server" or "client"
>    #
>   -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
>   +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
>    #     @version, @version-id, @variant and @variant-id follow the
>    #     definition specified in os-release(5). Refer to the manual page
>    #     for exact description of the fields.  Their values are taken
>
>
> >  #
> >  # Since: 2.10
> >  ##
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index dfd6a6c5bee..53b06a94508 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -548,6 +548,21 @@ def get_doc(self) -> 'QAPIDoc':
> >                          r'(Returns|Errors|Since|Notes?|Examples?|TODO)=
:
> *',
> >                          line):
> >                      # tagged section
> > +
> > +                    # TODO: Remove this error sometime in 2025 or so
> > +                    # after we've fully transitioned to the new qapido=
c
> > +                    # generator.
> > +
> > +                    # See commit message for more markup suggestions
> O:-)
> > +                    if 'Note' in match.group(1):
> > +                        emsg =3D (
> > +                            f"The '{match.group(1)}' section is no
> longer "
> > +                            "supported. Please use rST's '.. note::' o=
r
> "
> > +                            "'.. admonition:: notes' directives, or
> another "
> > +                            "suitable admonition instead."
> > +                        )
> > +                        raise QAPIParseError(self, emsg)
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
> > index 8b39eb946af..4b338cc0186 100644
> > --- a/tests/qapi-schema/doc-good.json
> > +++ b/tests/qapi-schema/doc-good.json
> > @@ -29,7 +29,7 @@
> >  # - Second list
> >  #   Note: still in list
> >  #
> > -# Note: not in list
> > +# .. note:: not in list
>
> Uh...  see [*] below.
>
> >  #
> >  # 1. Third list
> >  #    is numbered
> > @@ -157,7 +157,7 @@
> >  # @cmd-feat1: a feature
> >  # @cmd-feat2: another feature
> >  #
> > -# Note: @arg3 is undocumented
> > +# .. note:: @arg3 is undocumented
> >  #
> >  # Returns: @Object
> >  #
> > @@ -165,7 +165,7 @@
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
>
> [*] This demonstrates the "Note: ..." is *not* recognized as a "Note"
> section before the patch (compare to the change we get for recognized
> sections below).
>
> Obscure fact: the doc parser recognizes tagged sections *only* in
> definition documentation.  Arguably a misfeature.
>
> Your series makes the misfeature even more obscure, because afterwards,
> the only tagged section left that could make sense in a free-form doc
> comment is "TODO".  Let's not worry about the misfeature now.
>

Right, it's gonna go away or be heavily reduced. A fish for another fry.


> Two sensible solutions:
>
> 1. Since the patch converts tagged sections, and this isn't, don't touch
> it.  If you feel you want to mention this in the commit message, go
> ahead.
>

Oh, uh. Alright. I wonder why I changed it then. I thought I was playing
error message whackamole with this one, but maybe I did do a regexp at some
point.

I'll leave it be if I can. If I can't, for some reason, then ...


> 2. Touch it anyway.  Do mention it in the commit message then.
>

... This, with why I couldn't leave it be.


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
> "Returns:" is only valid for commands, and this is a struct.  Let's use
> "TODO:" instead.
>

Weird that it didn't prohibit it. Bug?

--js

>

--000000000000fa2e3d061b541f93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jun 19, 2024, 8:49=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
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
<br>
Scratch &quot;... ...&quot; and downcase &quot;Update&quot;?<br>
<br>
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
.html#admonitions" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo.html#admonitions</a><br=
>
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
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; Acked-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt; [for block*=
.json]<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt; index b3de1fb6b3a..57598331c5c 100644<br>
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
&gt; +# .. note:: If return value does not match the previous call to<br>
&gt; +#=C2=A0 =C2=A0 guest-fsfreeze-freeze, this likely means some freezabl=
e filesystems<br>
&gt; +#=C2=A0 =C2=A0 were unfrozen before this call, and that the filesyste=
m state may<br>
&gt; +#=C2=A0 =C2=A0 have changed before issuing this command.<br>
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
Please don&#39;t change the indentation here.=C2=A0 I get the same output w=
ith<br>
<br>
=C2=A0 @@ -1461,7 +1462,7 @@<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0* POSIX: as defined by os-release(5)<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0* Windows: contains string &quot;server&q=
uot; or &quot;client&quot;<br>
=C2=A0 =C2=A0#<br>
=C2=A0 -# Notes: On POSIX systems the fields @id, @name, @pretty-name,<br>
=C2=A0 +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,<b=
r>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0@version, @version-id, @variant and @vari=
ant-id follow the<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0definition specified in os-release(5). Re=
fer to the manual page<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0for exact description of the fields.=C2=
=A0 Their values are taken<br>
<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.10<br>
&gt;=C2=A0 ##<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index dfd6a6c5bee..53b06a94508 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -548,6 +548,21 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 r&#39;(Returns|Errors|Since|Notes?|Examples?|TODO): *&=
#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 line):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # tagged section<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # TODO: Remove this error sometime in 2025 or so<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # after we&#39;ve fully transitioned to the new qapidoc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # generator.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # See commit message for more markup suggestions O:-)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if &#39;Note&#39; in match.group(1):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 emsg =3D (<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;The &#39;{match.group(1)}&#39; section =
is no longer &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;supported. Please use rST&#39;s &#39;.. =
note::&#39; or &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&#39;.. admonition:: notes&#39; directiv=
es, or another &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;suitable admonition instead.&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 raise QAPIParseError(self, emsg)<br>
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
&gt; index 8b39eb946af..4b338cc0186 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.json<br>
&gt; +++ b/tests/qapi-schema/doc-good.json<br>
&gt; @@ -29,7 +29,7 @@<br>
&gt;=C2=A0 # - Second list<br>
&gt;=C2=A0 #=C2=A0 =C2=A0Note: still in list<br>
&gt;=C2=A0 #<br>
&gt; -# Note: not in list<br>
&gt; +# .. note:: not in list<br>
<br>
Uh...=C2=A0 see [*] below.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # 1. Third list<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 is numbered<br>
&gt; @@ -157,7 +157,7 @@<br>
&gt;=C2=A0 # @cmd-feat1: a feature<br>
&gt;=C2=A0 # @cmd-feat2: another feature<br>
&gt;=C2=A0 #<br>
&gt; -# Note: @arg3 is undocumented<br>
&gt; +# .. note:: @arg3 is undocumented<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Returns: @Object<br>
&gt;=C2=A0 #<br>
&gt; @@ -165,7 +165,7 @@<br>
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
<br>
[*] This demonstrates the &quot;Note: ...&quot; is *not* recognized as a &q=
uot;Note&quot;<br>
section before the patch (compare to the change we get for recognized<br>
sections below).<br>
<br>
Obscure fact: the doc parser recognizes tagged sections *only* in<br>
definition documentation.=C2=A0 Arguably a misfeature.<br>
<br>
Your series makes the misfeature even more obscure, because afterwards,<br>
the only tagged section left that could make sense in a free-form doc<br>
comment is &quot;TODO&quot;.=C2=A0 Let&#39;s not worry about the misfeature=
 now.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Right, it&#39;s gonna go away or be heavily reduced. A fish for anothe=
r fry.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
<br>
Two sensible solutions:<br>
<br>
1. Since the patch converts tagged sections, and this isn&#39;t, don&#39;t =
touch<br>
it.=C2=A0 If you feel you want to mention this in the commit message, go<br=
>
ahead.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Oh, uh. Alright. I wonder why I changed it then. I thought I was play=
ing error message whackamole with this one, but maybe I did do a regexp at =
some point.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#39;ll lea=
ve it be if I can. If I can&#39;t, for some reason, then ...</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
2. Touch it anyway.=C2=A0 Do mention it in the commit message then.<br></bl=
ockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">... This=
, with why I couldn&#39;t leave it be.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
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
&quot;Returns:&quot; is only valid for commands, and this is a struct.=C2=
=A0 Let&#39;s use<br>
&quot;TODO:&quot; instead.<br></blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Weird that it didn&#39;t prohibit it. Bug?</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">--js</div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000fa2e3d061b541f93--


