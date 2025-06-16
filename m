Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A9CC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 21:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRHg0-0002Pu-72; Mon, 16 Jun 2025 17:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRHfx-0002PT-SE
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 17:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRHfs-0001Gc-Gb
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 17:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750110447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WW+UJwk0B/mo5iDb8LUza0lMroJ8OS+uo5j9e+65NYk=;
 b=LZMUL1i9LKxeW3oF3/yi6gtH663MpYrG1qabzLJp266FJYcrGpUleC+jAsVMUzrzhlyo0h
 YmqdLrmdAZtXzUSjoKMvbpSUzB1uvM4CMFz7chutz8tGhTcO9gnKj/3ETGRT3gslgAiDIE
 3kK0G0X5BKUNGTdHE1iWoOQkxsM3Bu8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-OgvslpnpNsueaCdLZb4GPw-1; Mon, 16 Jun 2025 17:47:24 -0400
X-MC-Unique: OgvslpnpNsueaCdLZb4GPw-1
X-Mimecast-MFC-AGG-ID: OgvslpnpNsueaCdLZb4GPw_1750110444
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31327b2f8e4so4961042a91.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 14:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750110443; x=1750715243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WW+UJwk0B/mo5iDb8LUza0lMroJ8OS+uo5j9e+65NYk=;
 b=XeUeDbQoRw3Im7QpspvaNe8WH7j5yWkTyTwHmeZu1ws6aJZC3hLnkHWWQ6P1W89Be7
 4n+TCZc/VXYCeQvd9oOY5//TNJmEkyubdPn7EqM8BbvlHnmWQs+FEGGAM7cPtnX32q/6
 1HxQta3YBIStf2TV04jUQFw8DBrNTD5Egt3C1wbPFveI2LjM6C+CTC2+gbwdU0iibt9G
 Clgv4CziiG/lGr1c9QPBtxAELZpOX1QohfoglQlpCVJ62R4ltSYoKAU8TjxcsEbnN1BF
 pR6FbhLXnBuV9z0O6n8FiZQRJS1S7bZhjjeuVOSNwFUWKxqmcusCh/Nl/OW+Ku2rOShR
 q6HQ==
X-Gm-Message-State: AOJu0YzEyBGFWASQ5pM3a+Tg7/jGUZ7899lIIQxiEbA9k7qHCu3iK4NL
 GCEnphE9L8Dylc9MElRk/JqLvVuqDcZ3x9wilP7sRrrI5TWDe3J8WP9Aww7pT+Q8DLqSy7bHe97
 SojH55M8TgK7iiJQTyWqRQqo4K8g1gduTPYmBxWvlcqbrOpLc4mAlziu6mndE2ZueFb27maHVpt
 GvtxM0Ho5BziJacmzit4LE1bMkHwiwoko=
X-Gm-Gg: ASbGncu6h10wpU9U456g5JWX4bDc3igllXfeUBLwHQFB00GIHgWQt24ptHW7M17fdFj
 7x4BepsdaVEiUqmPCus1sqgtp4XxlCwlQ9Vn4JkboOFwqrHDfCL4n5JgPnzphT8vwXUpFbztXqj
 728fgjie11gTSXK/oOFw1MA2vL1uxnBeBoCl4=
X-Received: by 2002:a17:90b:540f:b0:311:b0ec:135f with SMTP id
 98e67ed59e1d1-313f1e22bf7mr16481060a91.30.1750110443437; 
 Mon, 16 Jun 2025 14:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOEOoHUtnKVIx3xnNMBpe31easwiu6BWDtI1fz7a65T7SdHYDoKpsHMYGjEWqVcGndnQb3S2dC7JJxd3vZDOI=
X-Received: by 2002:a17:90b:540f:b0:311:b0ec:135f with SMTP id
 98e67ed59e1d1-313f1e22bf7mr16481005a91.30.1750110442997; Mon, 16 Jun 2025
 14:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250612221051.1224565-1-jsnow@redhat.com>
 <20250612221051.1224565-2-jsnow@redhat.com>
 <87ecvjj4uy.fsf@pond.sub.org>
In-Reply-To: <87ecvjj4uy.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 16 Jun 2025 17:47:10 -0400
X-Gm-Features: AX0GCFtio_A5iE59jjIp5WF4ouZwAwv9WvEoyCNB10MSxPsTfOJiFBuqZb6DA8U
Message-ID: <CAFn=p-Zns1tq_GZ+DR_53ThXidwDywb14o-uVNcccAiNXb+Mvw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] docs: fix errors formatting in
 tests/qapi-schema/doc-good
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenwei Pi <pizhenwei@bytedance.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Jiri Pirko <jiri@resnulli.us>, 
 Ani Sinha <anisinha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, 
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Eric Blake <eblake@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 Lukas Straub <lukasstraub2@web.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fan Ni <fan.ni@samsung.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000045f4e00637b75778"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000045f4e00637b75778
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 7:36=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > If we remove the legacy parser, the doc-good.json formatting begins to
>
> "parser"?  You mean docs/sphinx/qapidoc_legacy.py, don't you?
>

Mmm... yes, I'm conflating the purpose of the series (removing the legacy
freeform doc parser) with what necessitated this change (switching to the
new doc *generator*)

Wiggly-brained, wiggly-mouthed.


>
> > fail because the body text is appended directly after the field list
> > entry, which is invalid rST syntax.
>
> We've been running the test suite with the legacy doc generator.
> Unwise; we should've switched to the new one right away.
>

Oops O:-)


>
> > Without this change, we see this error:
> >
> > /home/jsnow/src/qemu/docs/../tests/qapi-schema/doc-good.json:169:
> > WARNING: Field list ends without a blank line; unexpected
> > unindent. [docutils]
>
> The reporting is less than helpful.
>
> > And this intermediate rST source:
> >
> > tests/qapi-schema/doc-good.json:0167 |    :error:
> > tests/qapi-schema/doc-good.json:0168 |    some
> >
> > With this patch applied, we instead generate this source:
> >
> > tests/qapi-schema/doc-good.json:0167 |    :error:
> > tests/qapi-schema/doc-good.json:0168 |        - some
> >
> > which compiles successfully.
>
> Hmm.
>
> As far as I can tell, the problem is lack of indentation[*].
>
> By convention, the contents of an Errors: section is a list.
> docs/devel/qapi-code-gen.rst:
>
>     "Errors" sections should be formatted as an rST list, each entry
>     detailing a relevant error condition.  For example::
>
>      # Errors:
>      #     - If @device does not exist, DeviceNotFound
>      #     - Any other error returns a GenericError.
>
> This test case is the only instance of something else.
>
> It's just a convention, though.
>
> Your change to the positive test case makes some sense all the same; it
> should cover how we want the thing to be used.
>
> What I don't like is how the new doc generator fails when we fail to
> adhere to the convention.
>

I agree... it should probably generate ":error: some" instead, without the
newline. Bad, but valid.


>
> Here's docs/devel/qapi-code-gen.rst on tagged sections:
>
>     A tagged section begins with a paragraph that starts with one of the
>     following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends
> with
>     the start of a new section.
>
>     The second and subsequent lines of tagged sections must be indented
>     like this::
>
>      # TODO: Ut enim ad minim veniam, quis nostrud exercitation ullamco
>      #     laboris nisi ut aliquip ex ea commodo consequat.
>      #
>      #     Duis aute irure dolor in reprehenderit in voluptate velit esse
>      #     cillum dolore eu fugiat nulla pariatur.
>
> This tells us that
>
>     # Errors: some
>
> and
>
>     # Errors:
>     #     some
>
> and
>
>     # Errors: some
>     #     more
>
> should all work, just like for any other tag.  However, only the second
> one works in my testing.  With qapidoc_legacy.py, all three work.
>
> We can make Errors: unlike the other tags.  But it needs to be done
> properly, i.e. in scripts/qapi/parser.py (for decent error reporting),
> and documented in docs/devel/qapi-code-gen.rst.
>
> Keeping the QAPI domain accept what the generator generates might be
> easier.
>
> Thoughts?
>

I try not to have any as often as I can.

In seriousness, I need a good few minutes with the generator to understand
why this behaves strangely. Might need to switch to a different parser
routine in parser.py, or I might need to adjust the qapidoc generator. Not
entirely sure what's precisely wrong... If I can find something that's both
easy and clean I'll do that instead.

Probably a newline needs to be preserved in the source somewhere, and then
a newline needs to be *not* added to the generator. Something like that.

We can discuss turning our de-facto standard into an actual syntactical
requirement later; I think there might be some benefit to allowing multiple
errors sections that each become their own ":error:" info field list entry,
but I am not confident on that and am not ready to dive into it just yet. I
think it's definitely easier on the sphinx side but it might not be easier
on the QAPI side. We'll see...


>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  tests/qapi-schema/doc-good.json | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/qapi-schema/doc-good.json
> b/tests/qapi-schema/doc-good.json
> > index 14b808f9090..6dcde8fd7e8 100644
> > --- a/tests/qapi-schema/doc-good.json
> > +++ b/tests/qapi-schema/doc-good.json
> > @@ -165,7 +165,8 @@
> >  #
> >  # Returns: @Object
> >  #
> > -# Errors: some
> > +# Errors:
> > +#     - some
> >  #
> >  # TODO: frobnicate
> >  #
>
> Fails "make check".  Fixup appended.
>

Strange. How'd I find this issue and fix it if I wasn't running the tests?
Uhm, sorry. Sloppy of me.


>
>
>
> [*] Evidence:
>
>     # Errors:
>     #     - some
>
> which expands into
>
>     :error:
>         - some
>
> and
>
>     # Errors:
>     #     some
>
> which expands into
>
>     :error:
>         some
>
> both work.
>
> docs/devel/qapi-domain.rst:
>
>     ``:error:``
>     -----------
>
>     Document the error condition(s) of a QAPI command.
>
>     :availability: This field list is only available in the body of the
>                    Command directive.
> --> :syntax: ``:error: Lorem ipsum dolor sit amet ...``
>     :type: `sphinx.util.docfields.Field
>            <
> https://pydoc.dev/sphinx/latest/sphinx.util.docfields.Field.html?private=
=3D1
> >`_
>
>     The format of the :errors: field list description is free-form rST. T=
he
>     alternative spelling ":errors:" is also permitted, but strictly
>     analogous.
>
>     Example::
>
>        .. qapi:command:: block-job-set-speed
>           :since: 1.1
>
>           Set maximum speed for a background block operation.
>
>           This command can only be issued when there is an active block
> job.
>
>           Throttling can be disabled by setting the speed to 0.
>
>           :arg string device: The job identifier.  This used to be a devi=
ce
>               name (hence the name of the parameter), but since QEMU 2.7 =
it
>               can have other values.
>           :arg int speed: the maximum speed, in bytes per second, or 0 fo=
r
>               unlimited.  Defaults to 0.
> -->       :error:
> -->           - If no background operation is active on this device,
> -->             DeviceNotActive
>
> This makes me expect
>
>     :error: some
>
> also works.  However, the obvious
>
>     # Errors: some
>
> produces
>
>     :error:
>     some
>
> which doesn't work.
>
>
> diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> index dc8352eed4..3711cf5480 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -176,7 +176,7 @@ another feature
>      section=3DReturns
>  @Object
>      section=3DErrors
> -some
> +    - some
>      section=3DTodo
>  frobnicate
>      section=3DPlain
> diff --git a/tests/qapi-schema/doc-good.txt
> b/tests/qapi-schema/doc-good.txt
> index 17a1d56ef1..e54cc95f4a 100644
> --- a/tests/qapi-schema/doc-good.txt
> +++ b/tests/qapi-schema/doc-good.txt
> @@ -207,7 +207,7 @@ Returns
>  Errors
>  ~~~~~~
>
> -some
> +* some
>
>  Notes:
>
>
>

--00000000000045f4e00637b75778
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 16,=
 2025 at 7:36=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; If we remove the legacy parser, the doc-good.json formatting begins to=
<br>
<br>
&quot;parser&quot;?=C2=A0 You mean docs/sphinx/qapidoc_legacy.py, don&#39;t=
 you?<br></blockquote><div><br></div><div>Mmm... yes, I&#39;m conflating th=
e purpose of the series (removing the legacy freeform doc parser) with what=
 necessitated this change (switching to the new doc *generator*)<br></div><=
div><br></div><div>Wiggly-brained, wiggly-mouthed.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; fail because the body text is appended directly after the field list<b=
r>
&gt; entry, which is invalid rST syntax.<br>
<br>
We&#39;ve been running the test suite with the legacy doc generator.<br>
Unwise; we should&#39;ve switched to the new one right away.<br></blockquot=
e><div><br></div><div>Oops O:-)</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
&gt; Without this change, we see this error:<br>
&gt;<br>
&gt; /home/jsnow/src/qemu/docs/../tests/qapi-schema/doc-good.json:169:<br>
&gt; WARNING: Field list ends without a blank line; unexpected<br>
&gt; unindent. [docutils]<br>
<br>
The reporting is less than helpful.<br>
<br>
&gt; And this intermediate rST source:<br>
&gt;<br>
&gt; tests/qapi-schema/doc-good.json:0167 |=C2=A0 =C2=A0 :error:<br>
&gt; tests/qapi-schema/doc-good.json:0168 |=C2=A0 =C2=A0 some<br>
&gt;<br>
&gt; With this patch applied, we instead generate this source:<br>
&gt;<br>
&gt; tests/qapi-schema/doc-good.json:0167 |=C2=A0 =C2=A0 :error:<br>
&gt; tests/qapi-schema/doc-good.json:0168 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 - so=
me<br>
&gt;<br>
&gt; which compiles successfully.<br>
<br>
Hmm.<br>
<br>
As far as I can tell, the problem is lack of indentation[*].<br>
<br>
By convention, the contents of an Errors: section is a list.<br>
docs/devel/qapi-code-gen.rst:<br>
<br>
=C2=A0 =C2=A0 &quot;Errors&quot; sections should be formatted as an rST lis=
t, each entry<br>
=C2=A0 =C2=A0 detailing a relevant error condition.=C2=A0 For example::<br>
<br>
=C2=A0 =C2=A0 =C2=A0# Errors:<br>
=C2=A0 =C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0- If @device does not exist, Devic=
eNotFound<br>
=C2=A0 =C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0- Any other error returns a Generi=
cError.<br>
<br>
This test case is the only instance of something else.<br>
<br>
It&#39;s just a convention, though.<br>
<br>
Your change to the positive test case makes some sense all the same; it<br>
should cover how we want the thing to be used.<br>
<br>
What I don&#39;t like is how the new doc generator fails when we fail to<br=
>
adhere to the convention.<br></blockquote><div><br></div><div>I agree... it=
 should probably generate &quot;:error: some&quot; instead, without the new=
line. Bad, but valid.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
Here&#39;s docs/devel/qapi-code-gen.rst on tagged sections:<br>
<br>
=C2=A0 =C2=A0 A tagged section begins with a paragraph that starts with one=
 of the<br>
=C2=A0 =C2=A0 following words: &quot;Since:&quot;, &quot;Returns:&quot;, &q=
uot;Errors:&quot;, &quot;TODO:&quot;.=C2=A0 It ends with<br>
=C2=A0 =C2=A0 the start of a new section.<br>
<br>
=C2=A0 =C2=A0 The second and subsequent lines of tagged sections must be in=
dented<br>
=C2=A0 =C2=A0 like this::<br>
<br>
=C2=A0 =C2=A0 =C2=A0# TODO: Ut enim ad minim veniam, quis nostrud exercitat=
ion ullamco<br>
=C2=A0 =C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0laboris nisi ut aliquip ex ea comm=
odo consequat.<br>
=C2=A0 =C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0Duis aute irure dolor in reprehend=
erit in voluptate velit esse<br>
=C2=A0 =C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0cillum dolore eu fugiat nulla pari=
atur.<br>
<br>
This tells us that<br>
<br>
=C2=A0 =C2=A0 # Errors: some<br>
<br>
and<br>
<br>
=C2=A0 =C2=A0 # Errors:<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0some<br>
<br>
and<br>
<br>
=C2=A0 =C2=A0 # Errors: some<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0more<br>
<br>
should all work, just like for any other tag.=C2=A0 However, only the secon=
d<br>
one works in my testing.=C2=A0 With qapidoc_legacy.py, all three work.<br>
<br>
We can make Errors: unlike the other tags.=C2=A0 But it needs to be done<br=
>
properly, i.e. in scripts/qapi/parser.py (for decent error reporting),<br>
and documented in docs/devel/qapi-code-gen.rst.<br>
<br>
Keeping the QAPI domain accept what the generator generates might be<br>
easier.<br>
<br>
Thoughts?<br></blockquote><div><br></div><div>I try not to have any as ofte=
n as I can.</div><div><br></div><div>In seriousness, I need a good few minu=
tes with the generator to understand why this behaves strangely. Might need=
 to switch to a different parser routine in parser.py, or I might need to a=
djust the qapidoc generator. Not entirely sure what&#39;s precisely wrong..=
. If I can find something that&#39;s both easy and clean I&#39;ll do that i=
nstead.</div><div><br></div><div>Probably a newline needs to be preserved i=
n the source somewhere, and then a newline needs to be *not* added to the g=
enerator. Something like that.</div><div><br></div><div>We can discuss turn=
ing our de-facto standard into an actual syntactical requirement later; I t=
hink there might be some benefit to allowing multiple errors sections that =
each become their own &quot;:error:&quot; info field list entry, but I am n=
ot confident on that and am not ready to dive into it just yet. I think it&=
#39;s definitely easier on the sphinx side but it might not be easier on th=
e QAPI side. We&#39;ll see...</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.json | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-g=
ood.json<br>
&gt; index 14b808f9090..6dcde8fd7e8 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.json<br>
&gt; +++ b/tests/qapi-schema/doc-good.json<br>
&gt; @@ -165,7 +165,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Returns: @Object<br>
&gt;=C2=A0 #<br>
&gt; -# Errors: some<br>
&gt; +# Errors:<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0- some<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # TODO: frobnicate<br>
&gt;=C2=A0 #<br>
<br>
Fails &quot;make check&quot;.=C2=A0 Fixup appended.<br></blockquote><div><b=
r></div><div>Strange. How&#39;d I find this issue and fix it if I wasn&#39;=
t running the tests? Uhm, sorry. Sloppy of me.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
<br>
[*] Evidence:<br>
<br>
=C2=A0 =C2=A0 # Errors:<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0- some<br>
<br>
which expands into<br>
<br>
=C2=A0 =C2=A0 :error:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - some<br>
<br>
and<br>
<br>
=C2=A0 =C2=A0 # Errors:<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0some<br>
<br>
which expands into<br>
<br>
=C2=A0 =C2=A0 :error:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 some<br>
<br>
both work.<br>
<br>
docs/devel/qapi-domain.rst:<br>
<br>
=C2=A0 =C2=A0 ``:error:``<br>
=C2=A0 =C2=A0 -----------<br>
<br>
=C2=A0 =C2=A0 Document the error condition(s) of a QAPI command.<br>
<br>
=C2=A0 =C2=A0 :availability: This field list is only available in the body =
of the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Comman=
d directive.<br>
--&gt; :syntax: ``:error: Lorem ipsum dolor sit amet ...``<br>
=C2=A0 =C2=A0 :type: `sphinx.util.docfields.Field<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://pydoc.dev/s=
phinx/latest/sphinx.util.docfields.Field.html?private=3D1" rel=3D"noreferre=
r" target=3D"_blank">https://pydoc.dev/sphinx/latest/sphinx.util.docfields.=
Field.html?private=3D1</a>&gt;`_<br>
<br>
=C2=A0 =C2=A0 The format of the :errors: field list description is free-for=
m rST. The<br>
=C2=A0 =C2=A0 alternative spelling &quot;:errors:&quot; is also permitted, =
but strictly<br>
=C2=A0 =C2=A0 analogous.<br>
<br>
=C2=A0 =C2=A0 Example::<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.. qapi:command:: block-job-set-speed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :since: 1.1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Set maximum speed for a background block=
 operation.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 This command can only be issued when the=
re is an active block job.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Throttling can be disabled by setting th=
e speed to 0.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :arg string device: The job identifier.=
=C2=A0 This used to be a device<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name (hence the name of th=
e parameter), but since QEMU 2.7 it<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 can have other values.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :arg int speed: the maximum speed, in by=
tes per second, or 0 for<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlimited.=C2=A0 Defaults =
to 0.<br>
--&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0:error:<br>
--&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- If no background operation=
 is active on this device,<br>
--&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceNotActive<br>
<br>
This makes me expect<br>
<br>
=C2=A0 =C2=A0 :error: some<br>
<br>
also works.=C2=A0 However, the obvious<br>
<br>
=C2=A0 =C2=A0 # Errors: some<br>
<br>
produces<br>
<br>
=C2=A0 =C2=A0 :error:<br>
=C2=A0 =C2=A0 some<br>
<br>
which doesn&#39;t work.<br>
<br>
<br>
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t<br>
index dc8352eed4..3711cf5480 100644<br>
--- a/tests/qapi-schema/doc-good.out<br>
+++ b/tests/qapi-schema/doc-good.out<br>
@@ -176,7 +176,7 @@ another feature<br>
=C2=A0 =C2=A0 =C2=A0section=3DReturns<br>
=C2=A0@Object<br>
=C2=A0 =C2=A0 =C2=A0section=3DErrors<br>
-some<br>
+=C2=A0 =C2=A0 - some<br>
=C2=A0 =C2=A0 =C2=A0section=3DTodo<br>
=C2=A0frobnicate<br>
=C2=A0 =C2=A0 =C2=A0section=3DPlain<br>
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.tx=
t<br>
index 17a1d56ef1..e54cc95f4a 100644<br>
--- a/tests/qapi-schema/doc-good.txt<br>
+++ b/tests/qapi-schema/doc-good.txt<br>
@@ -207,7 +207,7 @@ Returns<br>
=C2=A0Errors<br>
=C2=A0~~~~~~<br>
<br>
-some<br>
+* some<br>
<br>
=C2=A0Notes:<br>
<br>
<br>
</blockquote></div></div>

--00000000000045f4e00637b75778--


