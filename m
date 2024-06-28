Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4952C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDly-0006CN-D5; Fri, 28 Jun 2024 11:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sNDlv-0006Bt-SA
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sNDlt-0002bu-3p
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719589460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/AmSu9OmMoiQ80Mn8tEVefJ2XLJpJ0VEDuT2ZqhYLFs=;
 b=TkvL031LqADa4jDpSN3HOZ3YwQGoY5xM9l/28A4OxGLGh/4cUKRkLLUO4ub/xLxH94Pqew
 ZArEWqXiur5DMlbUnxqHHzbWtQZyP9G1Siy3gpYXHYM2XxvXH4Bh2ruBHLYLpc5/ze2r76
 yx/xgpcMwkEvC5OpMTmLCqtsIGCPSKE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-7Iz8OPqoP9aDIdZ0Ei1iBg-1; Fri, 28 Jun 2024 11:44:18 -0400
X-MC-Unique: 7Iz8OPqoP9aDIdZ0Ei1iBg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c924a5eda9so678202a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719589457; x=1720194257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/AmSu9OmMoiQ80Mn8tEVefJ2XLJpJ0VEDuT2ZqhYLFs=;
 b=srDJlJczEjeW9XY+0IuV9s/4AJTB0VzvWJQYooaPdRkG5g6h2Un7AnFdznoapFasqK
 hGO2OVfy2aUfRXC9Hp/q5/FVHX7V2HrD6fq7BNunI4dkP/mKRGKFHALkfEaNLnSK4bb6
 ClyTRWGc8kRXyUC7GUmbKdtgIkeeecFx5F9Sqn08M6xhsfpCWAP6P443o9EhmJt8xdrs
 XJzrfVlpI7WyY+ceITE3ZkKOJZ2xbGIz2JaXhBmn3YYnjuIPMrw5/lp0uK3viUmNfDZ7
 Tjv1/SR289i0qDwvlrLpFPAfbHcgxnnVdB+f8YAIpIrRYaYOSZzxnTiefwoGUvT2egjO
 D3LQ==
X-Gm-Message-State: AOJu0YxfTrrMGOpM2I+mZzH/XtjM46jVOn3XV6Yjeo6Yn9w0scKatRkc
 orSTzQvkgZwPWqiM+JmslGpuVWUPDk+OsVe9CLnfcRWPuyip1F3y8NbUoOh0LlVTu8dJgyxSdPK
 Dx9cbfGbfyci1o1vyGrYgBuMMewJkrQCvxgXXh7Pp5qOIW6hQAPC5adD9jLNT5o0/2HFeBkziEN
 3vB3w+IbWIyIwxSy8eauoIRbZb0fk=
X-Received: by 2002:a17:90a:7c06:b0:2c2:fe3d:3453 with SMTP id
 98e67ed59e1d1-2c86124c9f7mr13797119a91.18.1719589457372; 
 Fri, 28 Jun 2024 08:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHud+BcI2ZFVeItfEw5ILyZ924wkgJIAzv126OvJeNr8zz4Y5LSQXISmHR3OQzOFNG2WMN/1iFwuF5X0Zim2ac=
X-Received: by 2002:a17:90a:7c06:b0:2c2:fe3d:3453 with SMTP id
 98e67ed59e1d1-2c86124c9f7mr13797095a91.18.1719589456912; Fri, 28 Jun 2024
 08:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-11-jsnow@redhat.com>
 <87a5j5z96v.fsf@pond.sub.org>
In-Reply-To: <87a5j5z96v.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 28 Jun 2024 11:44:05 -0400
Message-ID: <CAFn=p-bnx4RdZDZg+HL2xvKNLKYRHetMV-xR5rjDwwR4uFb0rQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] qapi: convert "Note" sections to plain rST
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Mads Ynddal <mads@ynddal.dk>,
 Jiri Pirko <jiri@resnulli.us>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Michael Roth <michael.roth@amd.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Victor Toso de Carvalho <victortoso@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, Ani Sinha <anisinha@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>, Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Hanna Reitz <hreitz@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bd449e061bf51e03"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

--000000000000bd449e061bf51e03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024, 5:52=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
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
> > consistent in rendered HTML documentation. Markup is also re-aligned to
> > the de-facto standard of 3 spaces for directives.
> >
> > Update docs/devel/qapi-code-gen.rst to reflect the new paradigm, and
> > update the QAPI parser to prohibit "Note" sections while suggesting a
> > new syntax. The exact formatting to use is a matter of taste, but a goo=
d
> > candidate is simply:
> >
> > .. note:: lorem ipsum ...
> >    ... dolor sit amet ...
> >    ... consectetur adipiscing elit ...
> >
> > ... but there are other choices, too. The Sphinx readthedocs theme
> > offers theming for the following forms (capitalization unimportant); al=
l
> > are adorned with a (!) symbol (=EF=81=AA) in the title bar for rendered=
 HTML
> > docs.
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
> > directives. Several instances of "Notes:" have been converted to merely
> > ".. note::" where appropriate, but ".. admonition:: notes" is used in a
> > few places where we had an ordered list of multiple notes that would no=
t
> > make sense as standalone/separate admonitions.
>
> I looked for hunks that don't 1:1 replace "Note:" or "Notes:" by
> ".. note::."  Findings:
>
> * Two hunks replace by ".. caution::" instead.  Commit message got it.
>   Good.
>
> * Four hunks replace by ".. admonition:: notes", one of them as a test.
>   Commit message got it.  Good.
>
> * Three hunks split "Notes:" into multiple ".. note::".  Good, but could
>   be mentioned in commit message.
>

I meant to imply it when discussing when admonition was used, but yeah.


> * Two hunks drop "Note:", changing it into paragraph.  The paragraph
>   merges into the preceding "Example" section.  Good, but should be
>   mentioned in the commit message, or turned into a separate patch.
>

Eh. we got enough commits. I think it's helpful to keep the whole
conversion in one giant bang so that the diff is helpful in illustrating
all of the different types of conversions.

(In fact, even though I split out Example conversion for your sake in
review, I think it'd be helpful to squash them together on merge for the
same exact reason.)

Let's just amend the commit message.


> * One hunk adjusts a test case for the removal of the "Note:" tag.
>   Good, but could be mentioned in the commit message.
>
> Perhaps tweak the paragraph above:
>
>   This patch uses ".. note::" almost everywhere, with just two "caution"
>   directives. Several instances of "Notes:" have been converted to
>   merely ".. note::", or multiple ".. note::" where appropriate.
>   ".. admonition:: notes" is used in a few places where we had an
>   ordered list of multiple notes that would not make sense as
>   standalone/separate admonitions.  Two "Note:" following "Example:"
>   have been turned into ordinary paragraphs within the example.
>
> Okay?
>

Yep, suits me fine.


> > NOTE: Because qapidoc.py does not attempt to preserve source ordering o=
f
> > sections, the conversion of Notes from a "tagged section" to an
> > "untagged section" means that rendering order for some notes *may
> > change* as a result of this patch. The forthcoming qapidoc.py rewrite
> > strictly preserves source ordering in the rendered documentation, so
> > this issue will be rectified in the new generator.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com> [for block*.json]
>
> I dislike the indentation changes, and may revert them in my tree.
>

=F0=9F=98=A2

Would you take a patch adjusting the indent later, or will you then tell me
it's not worth the git blame fuzz? :)


> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
>

--000000000000bd449e061bf51e03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jun 28, 2024, 5:52=E2=80=AFAM Markus Armbruste=
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
&gt; consistent in rendered HTML documentation. Markup is also re-aligned t=
o<br>
&gt; the de-facto standard of 3 spaces for directives.<br>
&gt;<br>
&gt; Update docs/devel/qapi-code-gen.rst to reflect the new paradigm, and<b=
r>
&gt; update the QAPI parser to prohibit &quot;Note&quot; sections while sug=
gesting a<br>
&gt; new syntax. The exact formatting to use is a matter of taste, but a go=
od<br>
&gt; candidate is simply:<br>
&gt;<br>
&gt; .. note:: lorem ipsum ...<br>
&gt;=C2=A0 =C2=A0 ... dolor sit amet ...<br>
&gt;=C2=A0 =C2=A0 ... consectetur adipiscing elit ...<br>
&gt;<br>
&gt; ... but there are other choices, too. The Sphinx readthedocs theme<br>
&gt; offers theming for the following forms (capitalization unimportant); a=
ll<br>
&gt; are adorned with a (!) symbol (=EF=81=AA) in the title bar for rendere=
d HTML<br>
&gt; docs.<br>
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
&gt; directives. Several instances of &quot;Notes:&quot; have been converte=
d to merely<br>
&gt; &quot;.. note::&quot; where appropriate, but &quot;.. admonition:: not=
es&quot; is used in a<br>
&gt; few places where we had an ordered list of multiple notes that would n=
ot<br>
&gt; make sense as standalone/separate admonitions.<br>
<br>
I looked for hunks that don&#39;t 1:1 replace &quot;Note:&quot; or &quot;No=
tes:&quot; by<br>
&quot;.. note::.&quot;=C2=A0 Findings:<br>
<br>
* Two hunks replace by &quot;.. caution::&quot; instead.=C2=A0 Commit messa=
ge got it.<br>
=C2=A0 Good.<br>
<br>
* Four hunks replace by &quot;.. admonition:: notes&quot;, one of them as a=
 test.<br>
=C2=A0 Commit message got it.=C2=A0 Good.<br>
<br>
* Three hunks split &quot;Notes:&quot; into multiple &quot;.. note::&quot;.=
=C2=A0 Good, but could<br>
=C2=A0 be mentioned in commit message.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I meant to imply it when discussing w=
hen admonition was used, but yeah.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
* Two hunks drop &quot;Note:&quot;, changing it into paragraph.=C2=A0 The p=
aragraph<br>
=C2=A0 merges into the preceding &quot;Example&quot; section.=C2=A0 Good, b=
ut should be<br>
=C2=A0 mentioned in the commit message, or turned into a separate patch.<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Eh.=
 we got enough commits. I think it&#39;s helpful to keep the whole conversi=
on in one giant bang so that the diff is helpful in illustrating all of the=
 different types of conversions.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">(In fact, even though I split out Example conversion for your sak=
e in review, I think it&#39;d be helpful to squash them together on merge f=
or the same exact reason.)</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Let&#39;s just amend the commit message.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
* One hunk adjusts a test case for the removal of the &quot;Note:&quot; tag=
.<br>
=C2=A0 Good, but could be mentioned in the commit message.<br>
<br>
Perhaps tweak the paragraph above:<br>
<br>
=C2=A0 This patch uses &quot;.. note::&quot; almost everywhere, with just t=
wo &quot;caution&quot;<br>
=C2=A0 directives. Several instances of &quot;Notes:&quot; have been conver=
ted to<br>
=C2=A0 merely &quot;.. note::&quot;, or multiple &quot;.. note::&quot; wher=
e appropriate.<br>
=C2=A0 &quot;.. admonition:: notes&quot; is used in a few places where we h=
ad an<br>
=C2=A0 ordered list of multiple notes that would not make sense as<br>
=C2=A0 standalone/separate admonitions.=C2=A0 Two &quot;Note:&quot; followi=
ng &quot;Example:&quot;<br>
=C2=A0 have been turned into ordinary paragraphs within the example.<br>
<br>
Okay?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Yep, suits me fine.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; NOTE: Because qapidoc.py does not attempt to preserve source ordering =
of<br>
&gt; sections, the conversion of Notes from a &quot;tagged section&quot; to=
 an<br>
&gt; &quot;untagged section&quot; means that rendering order for some notes=
 *may<br>
&gt; change* as a result of this patch. The forthcoming qapidoc.py rewrite<=
br>
&gt; strictly preserves source ordering in the rendered documentation, so<b=
r>
&gt; this issue will be rectified in the new generator.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; Acked-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt; [for block*=
.json]<br>
<br>
I dislike the indentation changes, and may revert them in my tree.<br></blo=
ckquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=F0=9F=98=
=A2</div><div dir=3D"auto"><br></div><div dir=3D"auto">Would you take a pat=
ch adjusting the indent later, or will you then tell me it&#39;s not worth =
the git blame fuzz? :)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000bd449e061bf51e03--


