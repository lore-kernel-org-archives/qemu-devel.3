Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C7FC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJETv-000831-1s; Mon, 17 Jun 2024 11:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJETs-00082m-Fa
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJETq-0001nT-OE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718638873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=93jQ5LOmSdkpRLGCfKdvmG8tFCA2k0ldvzsc3Js6xxc=;
 b=ZJeHkHXmWZpNgGmGEqS6DZ0lKtGKLZex5uGGr/VLqEPhs2g9BcVGNwII03fnuiX3k34jqf
 Kzf0X8spnh6dwpKCMNh6YVUKb3TgKyR9f4b8di4qeQpuJbQer2WCZlYYD1I5CWtufXzm+Z
 H41Q68oYH9nzQMCSMU5i5L9BkkHp5/w=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-YWll7sdpMCu3rileou223g-1; Mon, 17 Jun 2024 11:41:10 -0400
X-MC-Unique: YWll7sdpMCu3rileou223g-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1f733400d5fso52587815ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638869; x=1719243669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=93jQ5LOmSdkpRLGCfKdvmG8tFCA2k0ldvzsc3Js6xxc=;
 b=GwgxfOwRJPB5T1utF+shIX7Sl0U44AAWDe4Y2AF7lZZcLbBszKHhZIi+2jUVOAi/i/
 xdP0oIIB+FwN2lhC2jmcA2ATX+8qt1cBHZyDMVjPVsLY6hDpU+Pw1gTtULERB4cXXTmZ
 pGqeajovi09XRG2u6DxgAUgG63eeCUfSP9EptkPU7xKrkDNBZfIZnozohCxar/GNCF3U
 9/+LGGJN3QpCCavNQku/VhOCBTELte3JFi+tH8dzkcN1yJOxW9C8SRMXXCtONufnoDrX
 2RT8mihcjsLLRU1IgekLGTtYcVfdk/tWy1zHQxOh4SAwNNidwmNTyf04doSPobe4cK1e
 2elA==
X-Gm-Message-State: AOJu0YxDtgV8FcvRD092As+oSvneYvqOjWRsEjT11XiqaL4ZcfRtF07R
 TdLAvpDTlJfLwAXm9YvsIyGtRXz6IARAL1I/eMvXBCf7tt31CHbhKIO7W9XUEKk7RkiUeXcumx6
 vQe766apTpAQq8/ENKxbQ+hyn3ThZSMOdODXTtROGJeABkKc28PpRxWW1hxKsWEKQRO3XVkHIIk
 KAlRzHSNwmQ84u9bzSKgkzQvPqt4w=
X-Received: by 2002:a17:903:22cf:b0:1f8:66fb:1677 with SMTP id
 d9443c01a7336-1f866fb1c5dmr127581375ad.14.1718638869616; 
 Mon, 17 Jun 2024 08:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJMbLCIGaPWLLMxATu8TUGdOuFvfhzjUKN10KWHNwVv/RzwCY3M5bm1z8BmpHXI6UbAEdTsIWifHaWHG0e3Wg=
X-Received: by 2002:a17:903:22cf:b0:1f8:66fb:1677 with SMTP id
 d9443c01a7336-1f866fb1c5dmr127581125ad.14.1718638869212; Mon, 17 Jun 2024
 08:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-7-jsnow@redhat.com>
 <875xvepa64.fsf@pond.sub.org>
 <CAFn=p-YbP7tH8qxRapEDV5tF=5ShDXx9ULquwU_Mu0-un0i==g@mail.gmail.com>
 <878qz8ap79.fsf@pond.sub.org>
In-Reply-To: <878qz8ap79.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Jun 2024 11:40:57 -0400
Message-ID: <CAFn=p-YyNBhHvOtaoZ1COTEnQ2_XAs5OEyekuxNeWEDbUtmUag@mail.gmail.com>
Subject: Re: [PATCH 06/20] qapi/parser: fix comment parsing immediately
 following a doc block
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
Content-Type: multipart/alternative; boundary="0000000000004c0f26061b17cb03"
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

--0000000000004c0f26061b17cb03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:32=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, May 16, 2024 at 2:01=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > If a comment immediately follows a doc block, the parser doesn't
> ignore
> >> > that token appropriately. Fix that.
> >>
> >> Reproducer?
> >>
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  scripts/qapi/parser.py | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> >> > index 41b9319e5cb..161768b8b96 100644
> >> > --- a/scripts/qapi/parser.py
> >> > +++ b/scripts/qapi/parser.py
> >> > @@ -587,7 +587,7 @@ def get_doc(self) -> 'QAPIDoc':
> >> >                  line =3D self.get_doc_line()
> >> >                  first =3D False
> >> >
> >> > -        self.accept(False)
> >> > +        self.accept()
> >> >          doc.end()
> >> >          return doc
> >>
> >> Can't judge the fix without understanding the problem, and the problem
> >> will be easier to understand for me with a reproducer.
> >>
> >
> > audio.json:
> >
> > ```
> > ##
> > # =3D Audio
> > ##
> >
> > ##
> > # @AudiodevPerDirectionOptions:
> > #
> > # General audio backend options that are used for both playback and
> > # recording.
> > #
> > ```
> >
> > Modify this excerpt to have a comment after the "=3D Audio" header, say=
 for
> > instance if you were to take out that intro paragraph and transform it
> into
> > a comment that preceded the AudiodevPerDirectionOptions doc block.
> >
> > e.g.
> >
> > ```
> > ##
> > # =3D Audio
> > ##
> >
> > # Lorem Ipsum
> >
> > ##
> > # @AudiodevPerDirectionOptions:
> > ```
> >
> > the parser breaks because the line I changed that primes the next token
> is
> > still set to "not ignore comments", but that breaks the parser and give=
s
> a
> > rather unhelpful message:
> >
> > ../qapi/audio.json:13:1: junk after '##' at start of documentation
> comment
>
> When ._parse()'s loop sees a comment token in .tok, it expects it to be
> the start of a doc comment block (because any other comments are to be
> skipped).  It then calls .get_doc(), which expects the same.  The
> unexpected comment token then triggers .get_doc()'s check for junk after
> '##'.
>
> > Encountered when converting developer commentary from documentation
> > paragraphs to mere QAPI comments.
>
> Your fix is correct.
>
> It's actually a regression.  Please add
>
>     Fixes: 3d035cd2cca6 (qapi: Rewrite doc comment parser)
>
> to the commit message.
>
> Let's add a reproducer to tests/qapi-schema/doc-good.json right in this
> patch, e.g.
>
> diff --git a/tests/qapi-schema/doc-good.json
> b/tests/qapi-schema/doc-good.json
> index de38a386e8..8b39eb946a 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -55,6 +55,8 @@
>  # - {braces}
>  ##
>
> +# Not a doc comment
> +
>  ##
>  # @Enum:
>  #
>

Okey-dokey, all set.

--js

--0000000000004c0f26061b17cb03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 10:32=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, May 16, 2024 at 2:01=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; If a comment immediately follows a doc block, the parser does=
n&#39;t ignore<br>
&gt;&gt; &gt; that token appropriately. Fix that.<br>
&gt;&gt;<br>
&gt;&gt; Reproducer?<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/parser.py | 2 +-<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<=
br>
&gt;&gt; &gt; index 41b9319e5cb..161768b8b96 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/parser.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/parser.py<br>
&gt;&gt; &gt; @@ -587,7 +587,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;=
:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 line =3D self.get_doc_line()<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 first =3D False<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.accept(False)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.accept()<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.end()<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return doc<br>
&gt;&gt;<br>
&gt;&gt; Can&#39;t judge the fix without understanding the problem, and the=
 problem<br>
&gt;&gt; will be easier to understand for me with a reproducer.<br>
&gt;&gt;<br>
&gt;<br>
&gt; audio.json:<br>
&gt;<br>
&gt; ```<br>
&gt; ##<br>
&gt; # =3D Audio<br>
&gt; ##<br>
&gt;<br>
&gt; ##<br>
&gt; # @AudiodevPerDirectionOptions:<br>
&gt; #<br>
&gt; # General audio backend options that are used for both playback and<br=
>
&gt; # recording.<br>
&gt; #<br>
&gt; ```<br>
&gt;<br>
&gt; Modify this excerpt to have a comment after the &quot;=3D Audio&quot; =
header, say for<br>
&gt; instance if you were to take out that intro paragraph and transform it=
 into<br>
&gt; a comment that preceded the AudiodevPerDirectionOptions doc block.<br>
&gt;<br>
&gt; e.g.<br>
&gt;<br>
&gt; ```<br>
&gt; ##<br>
&gt; # =3D Audio<br>
&gt; ##<br>
&gt;<br>
&gt; # Lorem Ipsum<br>
&gt;<br>
&gt; ##<br>
&gt; # @AudiodevPerDirectionOptions:<br>
&gt; ```<br>
&gt;<br>
&gt; the parser breaks because the line I changed that primes the next toke=
n is<br>
&gt; still set to &quot;not ignore comments&quot;, but that breaks the pars=
er and gives a<br>
&gt; rather unhelpful message:<br>
&gt;<br>
&gt; ../qapi/audio.json:13:1: junk after &#39;##&#39; at start of documenta=
tion comment<br>
<br>
When ._parse()&#39;s loop sees a comment token in .tok, it expects it to be=
<br>
the start of a doc comment block (because any other comments are to be<br>
skipped).=C2=A0 It then calls .get_doc(), which expects the same.=C2=A0 The=
<br>
unexpected comment token then triggers .get_doc()&#39;s check for junk afte=
r<br>
&#39;##&#39;.<br>
<br>
&gt; Encountered when converting developer commentary from documentation<br=
>
&gt; paragraphs to mere QAPI comments.<br>
<br>
Your fix is correct.<br>
<br>
It&#39;s actually a regression.=C2=A0 Please add<br>
<br>
=C2=A0 =C2=A0 Fixes: 3d035cd2cca6 (qapi: Rewrite doc comment parser)<br>
<br>
to the commit message.<br>
<br>
Let&#39;s add a reproducer to tests/qapi-schema/doc-good.json right in this=
<br>
patch, e.g.<br>
<br>
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son<br>
index de38a386e8..8b39eb946a 100644<br>
--- a/tests/qapi-schema/doc-good.json<br>
+++ b/tests/qapi-schema/doc-good.json<br>
@@ -55,6 +55,8 @@<br>
=C2=A0# - {braces}<br>
=C2=A0##<br>
<br>
+# Not a doc comment<br>
+<br>
=C2=A0##<br>
=C2=A0# @Enum:<br>
=C2=A0#<br></blockquote><div><br></div><div>Okey-dokey, all set.</div><div>=
<br></div><div>--js <br></div></div></div>

--0000000000004c0f26061b17cb03--


