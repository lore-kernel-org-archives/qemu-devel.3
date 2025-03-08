Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD443C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 08:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqpOY-0000Yg-7i; Sat, 08 Mar 2025 03:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpOU-0000YN-Gl
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:18:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpOS-0006e8-DL
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741421927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B81a/BhbyGBTkvGJJ5ADDz3jHOgGpCQzroT0ndQe2xE=;
 b=eHqQRnDKO3XAuYLNdXYuhZ5d2mcyTPZ+iAr8JnHYP8ta/wM/jh6YqOtTbGMOPFfGS1jdom
 Nzw4y6J0Uy6FoqgpJH5sSupGcw1wKYrtX0bG7UVPnpiZxMwfFhNO7+HTm5Voqu8CyuyIje
 W5CRnlr0uLSCMZWQf8lekEPyEcFudjs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-qbjmykSsMuWj4x6lQGVSsw-1; Sat, 08 Mar 2025 03:18:41 -0500
X-MC-Unique: qbjmykSsMuWj4x6lQGVSsw-1
X-Mimecast-MFC-AGG-ID: qbjmykSsMuWj4x6lQGVSsw_1741421920
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff799be8f5so3089561a91.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 00:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741421920; x=1742026720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B81a/BhbyGBTkvGJJ5ADDz3jHOgGpCQzroT0ndQe2xE=;
 b=vfIt+kXcoovlPXwO3iGooWM0ouD4Iu5kdJFSFC8NrWXMRSS5m+B0/h8SEgcnVD5k+X
 dBqzCXOTUHZrUFApvhhT1V/V9FvO9oJEPUdov7TzUg+XwDJ2wYw5NYUVJ1C0bDWYd/fi
 m9KDSeOhyxWPRDEvL6+b/2vtguBHUWvbiQn2TbWG07bor44FoFQIxbLMasybBZfk/jx0
 at3RuqrS553tKacEqXVHroyDPKOFwjksFoLkRD6Utr3kevTB3YJQuPVHUj2VF7cI9Rtd
 oZK+uOvTq05Gm7i5wGTFLrrM1F6Fk88Nl6FB9WajNZ68SPaL0LVtZCXvBfmjZziPjYby
 2lOA==
X-Gm-Message-State: AOJu0YwXQuLiukLi9sKb3KFIrH6PLRIJK4q1HqeC/PPiE4wIH7TcHR4u
 T4Bl5H+P7LYCgttk/6TIGnrOjK9x3PgVJYaOIE28cRhx8UClnuOnaSOJjo+shgWQU6c4PxvDCeJ
 ZPCA6OPT4fVjpxPSPRtQ8yr9CmSuyQvoUVgkoLzHEcM1CXdZNQ/6b3g/5qW3bqFPs/h/zCkI6a5
 ovFDoYNOpM7siy+7cqb+bzLKp3L+8=
X-Gm-Gg: ASbGncuG5iPvSsqNiuq4b23rOPJydArahYaGyGwAq2aWmKd8vkhG716c+bPRRLu6FMF
 JRxOS0znu1oiZop7g3P+Nj0YiRpcWxKqYmMPQ4f6AcjlZBo/FxqDh4UCcLZqm9rCtL6oR1w==
X-Received: by 2002:a17:90a:d605:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-2ff7cf128cdmr9351750a91.30.1741421920292; 
 Sat, 08 Mar 2025 00:18:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWMXsKToxd12WikzP/anriMgt9G7yQix/ynMkW/q/OTE7sN+FS8dZ0qQSdJyDXOhbyv8UNvsHJQg7Vz7zj69w=
X-Received: by 2002:a17:90a:d605:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-2ff7cf128cdmr9351729a91.30.1741421920036; Sat, 08 Mar 2025
 00:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-58-jsnow@redhat.com>
 <87jz91hv8v.fsf@pond.sub.org>
In-Reply-To: <87jz91hv8v.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 8 Mar 2025 03:18:27 -0500
X-Gm-Features: AQ5f1JpcQPnVko_-LZb5a9cLnKqXr7VikrPahFs0j_PtUO4Q8HmDTAEzga0pWRs
Message-ID: <CAFn=p-ZpDh0HoHwGcnzAqiPmEq0-OX35RiYNEeG8h3Qg8DJNYw@mail.gmail.com>
Subject: Re: [PATCH 57/57] docs/qapidoc: Add "the members of" pointers
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f2ba12062fd0622b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000f2ba12062fd0622b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:37=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Add "the members of ..." pointers to Members and Arguments lists where
> > appropriate, with clickable cross-references - so it's a slight
> > improvement over the old system :)
> >
> > This patch is meant to be a temporary solution until we can review and
> > merge the inliner.
> >
> > The implementation of this patch is a little bit of a hack: Sphinx is
> > not designed to allow you to mix fields of different "type"; i.e. mixin=
g
> > member descriptions and free-form text under the same heading. To
> > accomplish this with a minimum of hackery, we technically document a
> > "dummy field" and then just strip off the documentation for that dummy
> > field in a post-processing step. We use the "q_dummy" variable for this
> > purpose, then strip it back out before final processing. If this
> > processing step should fail, you'll see warnings for a bad
> > cross-reference. (So if you don't see any, it must be working!)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Yes, it's a hack, and possibly fragile, but it'll all go away when the
> inliner lands.  I understand the inliner already exists, but you're
> holding it back to not balloon the series even more.
>

Just couldn't find any other way to do it with less SLOC. It's a weird
limitation in the bowels of Sphinx, and the Field classes aren't factored
aggressively enough to just write my own new Field subclass without also
having to do a lot of re-implementation that touches a lot of APIs I'd
rather not muck around with: I literally think that approach, while
"cleaner" in the traditional sense, is likely *more* porcelain than what
I've done here.

Thought it was better to just let Sphinx do whatever it does in make_xref,
and then make some tactical edits on the tail.

Could write a John Steinbeck novella's analysis on all the other approaches
I tried and why I ruled them out, but. Eh. Just read a John Steinbeck
novella instead if you want to.


> I'm on board.
>
>
Thank goodness.

--000000000000f2ba12062fd0622b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 7:37=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Add &quot;the members of ...&quot; pointers to Members and Arguments l=
ists where<br>
&gt; appropriate, with clickable cross-references - so it&#39;s a slight<br=
>
&gt; improvement over the old system :)<br>
&gt;<br>
&gt; This patch is meant to be a temporary solution until we can review and=
<br>
&gt; merge the inliner.<br>
&gt;<br>
&gt; The implementation of this patch is a little bit of a hack: Sphinx is<=
br>
&gt; not designed to allow you to mix fields of different &quot;type&quot;;=
 i.e. mixing<br>
&gt; member descriptions and free-form text under the same heading. To<br>
&gt; accomplish this with a minimum of hackery, we technically document a<b=
r>
&gt; &quot;dummy field&quot; and then just strip off the documentation for =
that dummy<br>
&gt; field in a post-processing step. We use the &quot;q_dummy&quot; variab=
le for this<br>
&gt; purpose, then strip it back out before final processing. If this<br>
&gt; processing step should fail, you&#39;ll see warnings for a bad<br>
&gt; cross-reference. (So if you don&#39;t see any, it must be working!)<br=
>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
Yes, it&#39;s a hack, and possibly fragile, but it&#39;ll all go away when =
the<br>
inliner lands.=C2=A0 I understand the inliner already exists, but you&#39;r=
e<br>
holding it back to not balloon the series even more.<br></blockquote></div>=
<div class=3D"gmail_quote gmail_quote_container"><br></div><div class=3D"gm=
ail_quote gmail_quote_container">Just couldn&#39;t find any other way to do=
 it with less SLOC. It&#39;s a weird limitation in the bowels of Sphinx, an=
d the Field classes aren&#39;t factored aggressively enough to just write m=
y own new Field subclass without also having to do a lot of re-implementati=
on that touches a lot of APIs I&#39;d rather not muck around with: I litera=
lly think that approach, while &quot;cleaner&quot; in the traditional sense=
, is likely *more* porcelain than what I&#39;ve done here.</div><div class=
=3D"gmail_quote gmail_quote_container"><div><br></div><div>Thought it was b=
etter to just let Sphinx do whatever it does in make_xref, and then make so=
me tactical edits on the tail.</div><div><br></div><div>Could write a John =
Steinbeck novella&#39;s analysis on all the other approaches I tried and wh=
y I ruled them out, but. Eh. Just read a John Steinbeck novella instead if =
you want to. <br></div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
I&#39;m on board.<br>
<br></blockquote><div><br></div><div>Thank goodness. <br></div></div></div>

--000000000000f2ba12062fd0622b--


