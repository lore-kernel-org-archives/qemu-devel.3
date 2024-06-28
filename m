Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB90CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDFA-0008CR-S7; Fri, 28 Jun 2024 11:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sNDF9-0008C0-Ib
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sNDF7-00025m-5e
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719587426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R/6BqdRiRvfzk7F5Yv/08zqyX1le2lhOixVMA0Ujovs=;
 b=WnCHglQt8PDp3YRULWDo0WpNWPr09LA1g8oIqhMt2Q8utIeEtEb4h03pD6w5tCCpukGSxe
 Y8m1ZW0hgRQ1FVQGKrE7FhV000h9rmmMg09IFISeZZIO0TGUcHUxUzHXYUS8cXOXD+WYT0
 6jPuTqXQvvq+MeIE37qLW8yQQ5f9oLM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-lMHAL3huPqeqj_7DdXX0Xw-1; Fri, 28 Jun 2024 11:10:25 -0400
X-MC-Unique: lMHAL3huPqeqj_7DdXX0Xw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-715e59afb63so672840a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719587424; x=1720192224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R/6BqdRiRvfzk7F5Yv/08zqyX1le2lhOixVMA0Ujovs=;
 b=G0prPXiHBquWvtRbc6DWrvSJzLyWP2lGoQ0qnOXvg5FWG1PYBcSeZxUJaJTgsXQFhp
 e9sP3w+fi6SwbCSmAdR83c2jhbcpxdBum1ts8ONjcdcmPIDQJMfvySV5AfXsKvhnmBJr
 siWDlWuQZFTyYvCRS1Z+Q5Y1+9g7HMRAjC9kNsxtzOWlFeDdfad6oa5Hii4F8nOg5eVS
 8t+BBGSKW5GmOQArpOyRmeM6h1at2wn3/kA6L7Qeo4eIcCBwGS0/RgK9aOMis2eYn3aI
 GAZAfSn7BiNIARQd/o+Y66l2WBt/ngx+lNPrHgrZIOZgIDx76TKcpPo0450nazQdMVND
 b7kg==
X-Gm-Message-State: AOJu0YwXnnL8YhMX2IzeYd07osKaltAFGWr6rxrBMhg3wU52aGWhXTbK
 28C1jqXeBztvA4mDjvFDJ9POl8CB6imZ8N8isElLuejgQss5p+dnEiBIjdxtAIxC3IyTvbRI+Kh
 Km2AigaTcE7xhp6ozwIrTK4D90k0zdf3zb6vBpNPcvGQrP0SVUldQe0UI7hfH5fl4o8NNF0OtRL
 lViAKN+d1Z4c+QdEWZWw62SY2cCeQ=
X-Received: by 2002:a17:903:32ce:b0:1f9:b9ed:e84e with SMTP id
 d9443c01a7336-1fa23f1f37dmr188475385ad.58.1719587424211; 
 Fri, 28 Jun 2024 08:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeIxR+aeUgKNi54eBAYjxvwc0Mto2ENZVwfLRESAFG8Yobszx0rrrZJUixZpBgPDX6f7KnO81TdWrmDVjsrVQ=
X-Received: by 2002:a17:903:32ce:b0:1f9:b9ed:e84e with SMTP id
 d9443c01a7336-1fa23f1f37dmr188475025ad.58.1719587423796; Fri, 28 Jun 2024
 08:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-8-jsnow@redhat.com>
 <87r0chzelz.fsf@pond.sub.org>
In-Reply-To: <87r0chzelz.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 28 Jun 2024 11:10:11 -0400
Message-ID: <CAFn=p-aPJact6oMq_yMqDwUhY2vmsAtPe4jt5U1FW300MrMEuQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/21] docs/qapidoc: fix nested parsing under untagged
 sections
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
Content-Type: multipart/alternative; boundary="0000000000008e5c5c061bf4a592"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

--0000000000008e5c5c061bf4a592
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024, 3:55=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Sphinx does not like sections without titles, because it wants to
> > convert every section into a reference. When there is no title, it
> > struggles to do this and transforms the tree inproperly.
> >
> > Depending on the rST used, this may result in an assertion error deep i=
n
> > the docutils HTMLWriter.
> >
> > (Observed when using ".. admonition:: Notes" under such a section - Whe=
n
> > this is transformed with its own <title> element, Sphinx is fooled into
> > believing this title belongs to the section and incorrect mutates the
> > docutils tree, leading to errors during rendering time.)
> >
> > When parsing an untagged section (free paragraphs), skip making a hollo=
w
> > section and instead append the parse results to the prior section.
> >
> > Many Bothans died to bring us this information.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > Acked-by: Markus Armbruster <armbru@redhat.com>
>
> Generated HTML changes, but the diff is hard to review due to id
> attribute changes all over the place.
>
> Generated qemu-ga-ref.7 also changes:
>
>     diff -rup old/qemu-ga-ref.7 new/qemu-ga-ref.7
>     --- old/qemu-ga-ref.7       2024-06-27 10:42:21.466096276 +0200
>     +++ new/qemu-ga-ref.7       2024-06-27 10:45:36.502414099 +0200
>     @@ -397,6 +397,7 @@ shutdown request, with no guarantee of s
>      .B \fBmode\fP: \fBstring\fP (optional)
>      \(dqhalt\(dq, \(dqpowerdown\(dq (default), or \(dqreboot\(dq
>      .UNINDENT
>     +.sp
>      This command does NOT return a response on success.  Success
>      condition is indicated by the VM exiting with a zero exit status or,
>      when running with \-\-no\-shutdown, by issuing the query\-status QMP
>     @@ -1348,6 +1349,7 @@ the new password entry string, base64 en
>      .B \fBcrypted\fP: \fBboolean\fP
>      true if password is already crypt()d, false if raw
>      .UNINDENT
>     +.sp
>      If the \fBcrypted\fP flag is true, it is the caller\(aqs
> responsibility to
>      ensure the correct crypt() encryption scheme is used.  This command
>      does not attempt to interpret or report on the encryption scheme.
>
> We add vertical space.  Visible when viewed with man.  Looks like an
> improvement to me.
>
> Here's the first of these two spots in HTML:
>
>     -<section id=3D"qapidoc-31">
>     -<h3><a class=3D"toc-backref" href=3D"#id13" role=3D"doc-backlink"><c=
ode
> class=3D"docutils literal notranslate"><span
> class=3D"pre">guest-shutdown</span></code> (Command)</a><a class=3D"heade=
rlink"
> href=3D"#qapidoc-31" title=3D"Permalink to this heading">=EF=83=81</a></h=
3>
>     +<section id=3D"qapidoc-30">
>     +<h3><a class=3D"toc-backref" href=3D"#id13" role=3D"doc-backlink"><c=
ode
> class=3D"docutils literal notranslate"><span
> class=3D"pre">guest-shutdown</span></code> (Command)</a><a class=3D"heade=
rlink"
> href=3D"#qapidoc-30" title=3D"Permalink to this heading">=EF=83=81</a></h=
3>
>      <p>Initiate guest-activated shutdown.  Note: this is an asynchronous
>      shutdown request, with no guarantee of successful shutdown.</p>
>      <section id=3D"qapidoc-28">
>     @@ -502,22 +502,20 @@ shutdown request, with no guarantee of s
>      </dd>
>      </dl>
>      </section>
>     -<section id=3D"qapidoc-29">
>      <p>This command does NOT return a response on success.  Success
>      condition is indicated by the VM exiting with a zero exit status or,
>      when running with =E2=80=93no-shutdown, by issuing the query-status =
QMP
>      command to confirm the VM status is =E2=80=9Cshutdown=E2=80=9D.</p>
>     -</section>
>     -<section id=3D"qapidoc-30">
>     -<h4>Since<a class=3D"headerlink" href=3D"#qapidoc-30" title=3D"Perma=
link to
> this heading">=EF=83=81</a></h4>
>     +<section id=3D"qapidoc-29">
>     +<h4>Since<a class=3D"headerlink" href=3D"#qapidoc-29" title=3D"Perma=
link to
> this heading">=EF=83=81</a></h4>
>      <p>0.15.0</p>
>      </section>
>      </section>
>
> The id changes muddy the waters.  With them manually removed:
>
>      <section id=3D"qapidoc-31">
>      <h3><a class=3D"toc-backref" href=3D"#id13" role=3D"doc-backlink"><c=
ode
> class=3D"docutils literal notranslate"><span
> class=3D"pre">guest-shutdown</span></code> (Command)</a><a class=3D"heade=
rlink"
> href=3D"#qapidoc-31" title=3D"Permalink to this heading">=EF=83=81</a></h=
3>
>      <p>Initiate guest-activated shutdown.  Note: this is an asynchronous
>      shutdown request, with no guarantee of successful shutdown.</p>
>      <section id=3D"qapidoc-28">
>     @@ -502,22 +502,20 @@ shutdown request, with no guarantee of s
>      </dd>
>      </dl>
>      </section>
>     -<section id=3D"qapidoc-29">
>      <p>This command does NOT return a response on success.  Success
>      condition is indicated by the VM exiting with a zero exit status or,
>      when running with =E2=80=93no-shutdown, by issuing the query-status =
QMP
>      command to confirm the VM status is =E2=80=9Cshutdown=E2=80=9D.</p>
>     -</section>
>      <section id=3D"qapidoc-30">
>      <h4>Since<a class=3D"headerlink" href=3D"#qapidoc-30" title=3D"Perma=
link to
> this heading">=EF=83=81</a></h4>
>      <p>0.15.0</p>
>      </section>
>      </section>
>
> Makes no visual difference in my browser.
>
> Do these differences match your expectations?
>

Yep!

It does change the output just a little, but Sphinx really doesn't like
title-less sections.

I thought the change looked fine, and I'm still planning on removing this
old generator anyway, so...

>

--0000000000008e5c5c061bf4a592
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jun 28, 2024, 3:55=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Sphinx does not like sections without titles, because it wants to<br>
&gt; convert every section into a reference. When there is no title, it<br>
&gt; struggles to do this and transforms the tree inproperly.<br>
&gt;<br>
&gt; Depending on the rST used, this may result in an assertion error deep =
in<br>
&gt; the docutils HTMLWriter.<br>
&gt;<br>
&gt; (Observed when using &quot;.. admonition:: Notes&quot; under such a se=
ction - When<br>
&gt; this is transformed with its own &lt;title&gt; element, Sphinx is fool=
ed into<br>
&gt; believing this title belongs to the section and incorrect mutates the<=
br>
&gt; docutils tree, leading to errors during rendering time.)<br>
&gt;<br>
&gt; When parsing an untagged section (free paragraphs), skip making a holl=
ow<br>
&gt; section and instead append the parse results to the prior section.<br>
&gt;<br>
&gt; Many Bothans died to bring us this information.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
Generated HTML changes, but the diff is hard to review due to id<br>
attribute changes all over the place.<br>
<br>
Generated qemu-ga-ref.7 also changes:<br>
<br>
=C2=A0 =C2=A0 diff -rup old/qemu-ga-ref.7 new/qemu-ga-ref.7<br>
=C2=A0 =C2=A0 --- old/qemu-ga-ref.7=C2=A0 =C2=A0 =C2=A0 =C2=A02024-06-27 10=
:42:21.466096276 +0200<br>
=C2=A0 =C2=A0 +++ new/qemu-ga-ref.7=C2=A0 =C2=A0 =C2=A0 =C2=A02024-06-27 10=
:45:36.502414099 +0200<br>
=C2=A0 =C2=A0 @@ -397,6 +397,7 @@ shutdown request, with no guarantee of s<=
br>
=C2=A0 =C2=A0 =C2=A0.B \fBmode\fP: \fBstring\fP (optional)<br>
=C2=A0 =C2=A0 =C2=A0\(dqhalt\(dq, \(dqpowerdown\(dq (default), or \(dqreboo=
t\(dq<br>
=C2=A0 =C2=A0 =C2=A0.UNINDENT<br>
=C2=A0 =C2=A0 +.sp<br>
=C2=A0 =C2=A0 =C2=A0This command does NOT return a response on success.=C2=
=A0 Success<br>
=C2=A0 =C2=A0 =C2=A0condition is indicated by the VM exiting with a zero ex=
it status or,<br>
=C2=A0 =C2=A0 =C2=A0when running with \-\-no\-shutdown, by issuing the quer=
y\-status QMP<br>
=C2=A0 =C2=A0 @@ -1348,6 +1349,7 @@ the new password entry string, base64 e=
n<br>
=C2=A0 =C2=A0 =C2=A0.B \fBcrypted\fP: \fBboolean\fP<br>
=C2=A0 =C2=A0 =C2=A0true if password is already crypt()d, false if raw<br>
=C2=A0 =C2=A0 =C2=A0.UNINDENT<br>
=C2=A0 =C2=A0 +.sp<br>
=C2=A0 =C2=A0 =C2=A0If the \fBcrypted\fP flag is true, it is the caller\(aq=
s responsibility to<br>
=C2=A0 =C2=A0 =C2=A0ensure the correct crypt() encryption scheme is used.=
=C2=A0 This command<br>
=C2=A0 =C2=A0 =C2=A0does not attempt to interpret or report on the encrypti=
on scheme.<br>
<br>
We add vertical space.=C2=A0 Visible when viewed with man.=C2=A0 Looks like=
 an<br>
improvement to me.<br>
<br>
Here&#39;s the first of these two spots in HTML:<br>
<br>
=C2=A0 =C2=A0 -&lt;section id=3D&quot;qapidoc-31&quot;&gt;<br>
=C2=A0 =C2=A0 -&lt;h3&gt;&lt;a class=3D&quot;toc-backref&quot; href=3D&quot=
;#id13&quot; role=3D&quot;doc-backlink&quot;&gt;&lt;code class=3D&quot;docu=
tils literal notranslate&quot;&gt;&lt;span class=3D&quot;pre&quot;&gt;guest=
-shutdown&lt;/span&gt;&lt;/code&gt; (Command)&lt;/a&gt;&lt;a class=3D&quot;=
headerlink&quot; href=3D&quot;#qapidoc-31&quot; title=3D&quot;Permalink to =
this heading&quot;&gt;=EF=83=81&lt;/a&gt;&lt;/h3&gt;<br>
=C2=A0 =C2=A0 +&lt;section id=3D&quot;qapidoc-30&quot;&gt;<br>
=C2=A0 =C2=A0 +&lt;h3&gt;&lt;a class=3D&quot;toc-backref&quot; href=3D&quot=
;#id13&quot; role=3D&quot;doc-backlink&quot;&gt;&lt;code class=3D&quot;docu=
tils literal notranslate&quot;&gt;&lt;span class=3D&quot;pre&quot;&gt;guest=
-shutdown&lt;/span&gt;&lt;/code&gt; (Command)&lt;/a&gt;&lt;a class=3D&quot;=
headerlink&quot; href=3D&quot;#qapidoc-30&quot; title=3D&quot;Permalink to =
this heading&quot;&gt;=EF=83=81&lt;/a&gt;&lt;/h3&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;p&gt;Initiate guest-activated shutdown.=C2=A0 Note:=
 this is an asynchronous<br>
=C2=A0 =C2=A0 =C2=A0shutdown request, with no guarantee of successful shutd=
own.&lt;/p&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;section id=3D&quot;qapidoc-28&quot;&gt;<br>
=C2=A0 =C2=A0 @@ -502,22 +502,20 @@ shutdown request, with no guarantee of =
s<br>
=C2=A0 =C2=A0 =C2=A0&lt;/dd&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/dl&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/section&gt;<br>
=C2=A0 =C2=A0 -&lt;section id=3D&quot;qapidoc-29&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;p&gt;This command does NOT return a response on suc=
cess.=C2=A0 Success<br>
=C2=A0 =C2=A0 =C2=A0condition is indicated by the VM exiting with a zero ex=
it status or,<br>
=C2=A0 =C2=A0 =C2=A0when running with =E2=80=93no-shutdown, by issuing the =
query-status QMP<br>
=C2=A0 =C2=A0 =C2=A0command to confirm the VM status is =E2=80=9Cshutdown=
=E2=80=9D.&lt;/p&gt;<br>
=C2=A0 =C2=A0 -&lt;/section&gt;<br>
=C2=A0 =C2=A0 -&lt;section id=3D&quot;qapidoc-30&quot;&gt;<br>
=C2=A0 =C2=A0 -&lt;h4&gt;Since&lt;a class=3D&quot;headerlink&quot; href=3D&=
quot;#qapidoc-30&quot; title=3D&quot;Permalink to this heading&quot;&gt;=EF=
=83=81&lt;/a&gt;&lt;/h4&gt;<br>
=C2=A0 =C2=A0 +&lt;section id=3D&quot;qapidoc-29&quot;&gt;<br>
=C2=A0 =C2=A0 +&lt;h4&gt;Since&lt;a class=3D&quot;headerlink&quot; href=3D&=
quot;#qapidoc-29&quot; title=3D&quot;Permalink to this heading&quot;&gt;=EF=
=83=81&lt;/a&gt;&lt;/h4&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;p&gt;0.15.0&lt;/p&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/section&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/section&gt;<br>
<br>
The id changes muddy the waters.=C2=A0 With them manually removed:<br>
<br>
=C2=A0 =C2=A0 =C2=A0&lt;section id=3D&quot;qapidoc-31&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;h3&gt;&lt;a class=3D&quot;toc-backref&quot; href=3D=
&quot;#id13&quot; role=3D&quot;doc-backlink&quot;&gt;&lt;code class=3D&quot=
;docutils literal notranslate&quot;&gt;&lt;span class=3D&quot;pre&quot;&gt;=
guest-shutdown&lt;/span&gt;&lt;/code&gt; (Command)&lt;/a&gt;&lt;a class=3D&=
quot;headerlink&quot; href=3D&quot;#qapidoc-31&quot; title=3D&quot;Permalin=
k to this heading&quot;&gt;=EF=83=81&lt;/a&gt;&lt;/h3&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;p&gt;Initiate guest-activated shutdown.=C2=A0 Note:=
 this is an asynchronous<br>
=C2=A0 =C2=A0 =C2=A0shutdown request, with no guarantee of successful shutd=
own.&lt;/p&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;section id=3D&quot;qapidoc-28&quot;&gt;<br>
=C2=A0 =C2=A0 @@ -502,22 +502,20 @@ shutdown request, with no guarantee of =
s<br>
=C2=A0 =C2=A0 =C2=A0&lt;/dd&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/dl&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/section&gt;<br>
=C2=A0 =C2=A0 -&lt;section id=3D&quot;qapidoc-29&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;p&gt;This command does NOT return a response on suc=
cess.=C2=A0 Success<br>
=C2=A0 =C2=A0 =C2=A0condition is indicated by the VM exiting with a zero ex=
it status or,<br>
=C2=A0 =C2=A0 =C2=A0when running with =E2=80=93no-shutdown, by issuing the =
query-status QMP<br>
=C2=A0 =C2=A0 =C2=A0command to confirm the VM status is =E2=80=9Cshutdown=
=E2=80=9D.&lt;/p&gt;<br>
=C2=A0 =C2=A0 -&lt;/section&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;section id=3D&quot;qapidoc-30&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;h4&gt;Since&lt;a class=3D&quot;headerlink&quot; hre=
f=3D&quot;#qapidoc-30&quot; title=3D&quot;Permalink to this heading&quot;&g=
t;=EF=83=81&lt;/a&gt;&lt;/h4&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;p&gt;0.15.0&lt;/p&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/section&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/section&gt;<br>
<br>
Makes no visual difference in my browser.<br>
<br>
Do these differences match your expectations?<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Yep!</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">It does change the output just a little, but Sphi=
nx really doesn&#39;t like title-less sections.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">I thought the change looked fine, and I&#39;m still=
 planning on removing this old generator anyway, so...</div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000008e5c5c061bf4a592--


