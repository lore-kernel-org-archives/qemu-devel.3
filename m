Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F893C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 15:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGh9m-0008KU-5y; Mon, 10 Jun 2024 11:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sGh9h-0008Jv-OA
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sGh9e-0001UX-WE
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718034113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tz8oEDZrsga1fB7hJHYhPgWZIhfxnebHJ5NF1kPQzFE=;
 b=WeeH8M/kxkrsZlnzmAkOvbL8/QPTiAuelyrLPfwi0hYlA9AsmazKjrBAfaYjSOnsMLDPvO
 iJ1qG+0NLPe+P5NPXJvx31GB7qEORZ0JwS8K+osBJbE1SlxaPB/mZ+H9wxYXI1s+YygLoR
 mh/kWCY8fBJRjX2sk2Us8to+DQrb2zc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-y4r0s8sVPUWXAZetEDgFgQ-1; Mon, 10 Jun 2024 11:41:51 -0400
X-MC-Unique: y4r0s8sVPUWXAZetEDgFgQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-6c7e13b6a62so21491a12.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 08:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718034110; x=1718638910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tz8oEDZrsga1fB7hJHYhPgWZIhfxnebHJ5NF1kPQzFE=;
 b=uZcsQQDCuPm86MACPSMonCE3HyAp4YCcwAsi8moC9JqJLud3BJI6CQwypom4v/Ab+I
 I8BFAC0OQS3dWdChZOEwHKfhL6MJgDlkksPVC9UTcph8WutKL9NLYQk9lxOSZkE80+eW
 PIao6yLYsJBf+kQoetX6Bzc1g8nbrCiB6UbY91guL2E6hI7B/1t3InGeOPztUTt5xsf3
 MI7MU4W1OPaaqZcUw0AFDLBbQb/w8JrC/8I4yIt4yrlHZRZv7EGVAyScsjDD4fK7d3dV
 pJWKU2LN+15GupBXSoV3llymVj2AMQg9rW1Itlv4KwpyeEpyRGHiGqIay5UWOVUrgdKx
 PE/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX2FyMiCI6V9LKXceuEMq3Pbc2yH/YvxbxzifUUVu886FW1nSyPyOJrMt3dKGVZPJUDR/LaaZV2kZfAMwjJ/l8LWnoEQg=
X-Gm-Message-State: AOJu0YzESTtKO3YOa3lV8KdyCBKg0R9lshTwHZnsc1gy/B++ZHlU0ItJ
 3ZC6SiIPVkIkOrl2Bih+CYXKQgPIw5Ef3ng/YloCtQFDIvv0whpL79slE/5v+SS5Ji8V8Ttu23B
 w+hxA8n6N2mRbRwrFd0JDUkxOc1MJAOB2LvuhUfs3GFsVw+8hbzS4xMPHolZSSqa8wZSfzcw36z
 tXlWPY7IjNolS+kbDLYNKBX/+v2rM=
X-Received: by 2002:a17:902:e54c:b0:1f6:5869:df53 with SMTP id
 d9443c01a7336-1f6d02e647amr117536565ad.20.1718034110470; 
 Mon, 10 Jun 2024 08:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH66Pz92+73IhD3g6AvC3pKks/2VOJrnWA3w4ScZC72GxlrHHSK7H/1lARaUOZCvhR10u5UFDSafg0LtwkDYWw=
X-Received: by 2002:a17:902:e54c:b0:1f6:5869:df53 with SMTP id
 d9443c01a7336-1f6d02e647amr117536075ad.20.1718034110081; Mon, 10 Jun 2024
 08:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-bdoi1yDQTNhpzM=MP5s8Zm9zxuxbD-zPs_h_iA8C=mGg@mail.gmail.com>
 <ipebw5yv4l5joa54vk42rb2fmuykzvmjar7blcwiwstj5fwyuq@ycl4du6sb724>
 <CAFn=p-b9gLmAwLAjzf2RWA4JZuxVM-nnwETwQ44c8F0kOkReVg@mail.gmail.com>
 <ZmblKThDo7PJG5Fh@redhat.com> <87frtknchd.fsf@pond.sub.org>
In-Reply-To: <87frtknchd.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 10 Jun 2024 11:41:37 -0400
Message-ID: <CAFn=p-aEktwkkcKUqm_sqOOUNizi-AgsUHexHxgs1SCT1Vs5eg@mail.gmail.com>
Subject: Re: Historical QMP schema
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Victor Toso <victortoso@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Andrea Bolognani <abologna@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d7fd66061a8afc8f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

--000000000000d7fd66061a8afc8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 9:39=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Thu, Jun 06, 2024 at 01:22:14PM -0400, John Snow wrote:
> >> On Thu, Jun 6, 2024 at 6:25=E2=80=AFAM Victor Toso <victortoso@redhat.=
com>
> wrote:
> >> > On Wed, Jun 05, 2024 at 11:47:53AM GMT, John Snow wrote:
> >> Importantly, old versions of the schema aren't contained *entirely*
> within
> >> the schema. Here's a timeline:
> >>
> >> v0.12.0: QMP first introduced. Events are hardcoded, commands are
> defined
> >> in qemu-monitor.hx. query commands are hard-coded in monitor.c.
> >> v0.14.0: qemu-monitor.hx is forked into qmp-commands.hx and
> hmp-commands.hx
> >> v1.0: First version which features qapi-schema.json; all query command=
s
> are
> >> qapified but most other commands are not.
> >> v1.1.0: A very large chunk of commands are QAPIfied.
> >> v1.3.0: Most commands are now QAPIfied, but there are 2-3 remaining.
> >> v2.1.0: events are now fully qapified; most are now defined in
> >> qapi/events.json
> >> v2.8.0: The remaining commands are fully qapified; qmp-commands.hx is
> >> removed.
> >
> > v2.8.0 was in Dec 2016 - 7+1/2 years ago.
> >
> > libvirt's min QEMU version is 4.2.0 - Dec 2019
> >
> > Ther are non-libvirt consumers of QEMU, but for them, do we think it is
> > reasonable for a consumer of QAPI *today*, to care about a QEMU version
> > from almost 8 years ago ?
> >
> > IOW, I wonder if the most pragammatic answer to this problem is to simp=
ly
> > entirely ignore the problems prior to 2.8.0 - accept that the versionin=
g
> > is inaccurate/incomplete for versions before 2.8.0
>
> I'm in favour.  However, I'd prefer honest "Since: at least 2.8.0" to
> "Since: <untrustworthy but irrelevant version <=3D 2.8.0>".
>

That's certainly fine by me if it's community consensus to do so.

I wouldn't mind a phrasing in our HTML doc output in this way:

"Since: 4.2.0", when it's after the cutoff, or
"Since: at least 2.8.0" when it's at or prior to the cutoff.

However, because I am unreasonable, I do have a pretty accurate history of
everything that happened prior to then anyway, just in case ...!

(I was afraid of the review feedback of when I went to cull such
information from our docs, admittedly...)

Even after 2.8.0, there are many "breaking changes" to the QAPI schema
format itself that requires various hacks and workarounds in the QAPI
generator to be able to parse until at least v6.2.0 or so; things we
definitely don't feel like hacking into the upstream parser and
maintaining/supporting. It's far easier, I think, to compile this
information *once* and store the compiled result into a file we can check
back into the qemu.git tree to serve as historical reference instead.

So, even if we do ignore such older versions, it's still a question of how
we'd like to store and maintain the historical information so we have a
reference for new releases going forward, and what kind of features we'd
like to see such a format support us with.

My list right now is:

- The ability to see at a glance, as a "one-page summary", any changes to
the QMP wire protocol during Release Candidate phase.
- The ability to programmatically determine from the doc generator:
    - when any Command or Event was introduced
    - when any Command Argument/Return field was introduced (or modified
incompatibly?)
    - when any Event member was introduced/modified incompatibly

I've got some prototypes for this, I hope to send some example output soon
when it's more reasonably complete and I don't have to explain the
Work-In-Progress caveats quite as much; however I'm still receptive to
ideas and suggestions about how to organize this data. Right now, I am
using a JSON Schema format for "compiled" data because it has the ability
to describe arbitrarily nested structures, which allows me to strip all
"non-API" information from the compiled schema, such as intermediate type
names which we do not consider API. This allows me to give accurate
version-to-version diff reports regardless of the type factoring on the
developer's side.

I'm not necessarily attached to this idea, but it has been useful in
prototyping for verifying that the rest of my qapihackborg is functioning
correctly, so it can serve as a starting point for critique and discussion,
I think.

(I just chose JSON Schema because it's something I am aware of and know how
to use, and it fit some loose criteria for the hacking I was doing. Maybe
we'll stick with it, maybe we won't. etc.)

--js

--000000000000d7fd66061a8afc8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 10, 2024 at 9:39=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank">berrange@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Jun 06, 2024 at 01:22:14PM -0400, John Snow wrote:<br>
&gt;&gt; On Thu, Jun 6, 2024 at 6:25=E2=80=AFAM Victor Toso &lt;<a href=3D"=
mailto:victortoso@redhat.com" target=3D"_blank">victortoso@redhat.com</a>&g=
t; wrote:<br>
&gt;&gt; &gt; On Wed, Jun 05, 2024 at 11:47:53AM GMT, John Snow wrote:<br>
&gt;&gt; Importantly, old versions of the schema aren&#39;t contained *enti=
rely* within<br>
&gt;&gt; the schema. Here&#39;s a timeline:<br>
&gt;&gt; <br>
&gt;&gt; v0.12.0: QMP first introduced. Events are hardcoded, commands are =
defined<br>
&gt;&gt; in qemu-monitor.hx. query commands are hard-coded in monitor.c.<br=
>
&gt;&gt; v0.14.0: qemu-monitor.hx is forked into qmp-commands.hx and hmp-co=
mmands.hx<br>
&gt;&gt; v1.0: First version which features qapi-schema.json; all query com=
mands are<br>
&gt;&gt; qapified but most other commands are not.<br>
&gt;&gt; v1.1.0: A very large chunk of commands are QAPIfied.<br>
&gt;&gt; v1.3.0: Most commands are now QAPIfied, but there are 2-3 remainin=
g.<br>
&gt;&gt; v2.1.0: events are now fully qapified; most are now defined in<br>
&gt;&gt; qapi/events.json<br>
&gt;&gt; v2.8.0: The remaining commands are fully qapified; qmp-commands.hx=
 is<br>
&gt;&gt; removed.<br>
&gt;<br>
&gt; v2.8.0 was in Dec 2016 - 7+1/2 years ago.<br>
&gt;<br>
&gt; libvirt&#39;s min QEMU version is 4.2.0 - Dec 2019<br>
&gt;<br>
&gt; Ther are non-libvirt consumers of QEMU, but for them, do we think it i=
s<br>
&gt; reasonable for a consumer of QAPI *today*, to care about a QEMU versio=
n<br>
&gt; from almost 8 years ago ?<br>
&gt;<br>
&gt; IOW, I wonder if the most pragammatic answer to this problem is to sim=
ply<br>
&gt; entirely ignore the problems prior to 2.8.0 - accept that the versioni=
ng<br>
&gt; is inaccurate/incomplete for versions before 2.8.0<br>
<br>
I&#39;m in favour.=C2=A0 However, I&#39;d prefer honest &quot;Since: at lea=
st 2.8.0&quot; to<br>
&quot;Since: &lt;untrustworthy but irrelevant version &lt;=3D 2.8.0&gt;&quo=
t;.<br></blockquote><div><br></div><div>That&#39;s certainly fine by me if =
it&#39;s community consensus to do so.</div><div><br></div><div>I wouldn&#3=
9;t mind a phrasing in our HTML doc output in this way:</div><div><br></div=
><div>&quot;Since: 4.2.0&quot;, when it&#39;s after the cutoff, or</div><di=
v>&quot;Since: at least 2.8.0&quot; when it&#39;s at or prior to the cutoff=
.<br></div><div></div><div><br></div><div>However, because I am unreasonabl=
e, I do have a pretty accurate history of everything that happened prior to=
 then anyway, just in case ...!</div><div><br></div><div>(I was afraid of t=
he review feedback of when I went to cull such information from our docs, a=
dmittedly...)</div><div><br></div><div>Even after 2.8.0, there are many &qu=
ot;breaking changes&quot; to the QAPI schema=20
format itself that requires various hacks and workarounds in the QAPI=20
generator to be able to parse until at least v6.2.0 or so; things we=20
definitely don&#39;t feel like hacking into the upstream parser and=20
maintaining/supporting. It&#39;s far easier, I think, to compile this=20
information *once* and store the compiled result into a file we can=20
check back into the qemu.git tree to serve as historical reference=20
instead.</div><div><br></div><div>So, even if we do ignore such older versi=
ons, it&#39;s still a question of how we&#39;d like to store and maintain t=
he historical information so we have a reference for new releases going for=
ward, and what kind of features we&#39;d like to see such a format support =
us with.</div><div><br></div><div>My list right now is:</div><div><br></div=
><div>- The ability to see at a glance, as a &quot;one-page summary&quot;, =
any changes to the QMP wire protocol during Release Candidate phase.</div><=
div>- The ability to programmatically determine from the doc generator:</di=
v><div>=C2=A0 =C2=A0 - when any Command or Event was introduced</div><div>=
=C2=A0=C2=A0=C2=A0 - when any Command Argument/Return field was introduced =
(or modified incompatibly?)</div><div>=C2=A0=C2=A0=C2=A0 - when any Event m=
ember was introduced/modified incompatibly</div><div><br></div><div>I&#39;v=
e got some prototypes for this, I hope to send some example output soon whe=
n it&#39;s more reasonably complete and I don&#39;t have to explain the Wor=
k-In-Progress caveats quite as much; however I&#39;m still receptive to ide=
as and suggestions about how to organize this data. Right now, I am using a=
 JSON Schema format for &quot;compiled&quot; data because it has the abilit=
y to describe arbitrarily nested structures, which allows me to strip all &=
quot;non-API&quot; information from the compiled schema, such as intermedia=
te type names which we do not consider API. This allows me to give accurate=
 version-to-version diff reports regardless of the type factoring on the de=
veloper&#39;s side.</div><div><br></div><div>I&#39;m not necessarily attach=
ed to this idea, but it has been useful in prototyping for verifying that t=
he rest of my qapihackborg is functioning correctly, so it can serve as a s=
tarting point for critique and discussion, I think.</div><div><br></div><di=
v>(I just chose JSON Schema because it&#39;s something I am aware of and kn=
ow how to use, and it fit some loose criteria for the hacking I was doing. =
Maybe we&#39;ll stick with it, maybe we won&#39;t. etc.)<br></div><div><br>=
</div><div>--js<br></div><div><br></div></div></div>

--000000000000d7fd66061a8afc8f--


