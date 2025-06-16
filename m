Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287AAC71159
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 16:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRCxq-0002bN-7P; Mon, 16 Jun 2025 12:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRCxl-0002ae-6s
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 12:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRCxe-0004mb-Jb
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 12:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750092317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mU9C/h1FlR9EqU1IcDJd4iTHD3dJUb8+xAaWzrNsqPY=;
 b=ObUlQ72eYtfaci+cdJr4IFilbOU8dPAkkKRdzMCA04EmLoBPOYDYHuOjiE1L4lLnlrGfmW
 4bJ2raSJbZMj+4XqFgRdQMc2Qe+mJunNNJZ7gp/ff18+TMSbWw0kWZMGpcQINNv5Oayrhh
 46wBwoGV2QhFt342tlmlGu8x3JJZAt4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-XVMPZ6ItMFmUNeD4CG2JRA-1; Mon, 16 Jun 2025 12:45:15 -0400
X-MC-Unique: XVMPZ6ItMFmUNeD4CG2JRA-1
X-Mimecast-MFC-AGG-ID: XVMPZ6ItMFmUNeD4CG2JRA_1750092315
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31366819969so4115727a91.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 09:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750092315; x=1750697115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mU9C/h1FlR9EqU1IcDJd4iTHD3dJUb8+xAaWzrNsqPY=;
 b=hzhBkyETDxsTZ1C61ewlsJHLmZ3zJRbYJJJ2in9W8E+J35nxQtr/NAy4eBt0nj4N3T
 czsyCyqGwev0hpRmejzTEJ8w6pkun86yVKDiBXH6d6762kd65HUIEfJPMTwqStvnuyDP
 1hf34/P2B+uoYH8sCssYYL09Eu005qJR+4GtXbOGjkpgIg/Bz4kzFR9naK/k3rVM/iSB
 b056Tod9e9pHF7KW/dxVusxUIALjEBUmwwQbpgStREpdlHcsnMl0XUYaXEb1xju5ljnu
 T3+Yag2kt+CZSo8pF8a4Yf7dPLcem6JnyKNFFYYXzLKfyfcyLmHyJP1bp04+FmlxwDEw
 p7Uw==
X-Gm-Message-State: AOJu0YzmiiWs8cUYTLl4sd9zvtVIBUmPUNlswyYN3VfJw3S59pFHrf/c
 zsz7LpQTiaOxdSFswLTMtfRzHJo8icFUkLzj+57c88NXliXmeR0y3NR3iAm8nbI8hQxhoo0fjJO
 MyIXtKXyJkDg/8dQ+Q/hDvlYizPKbG6erdLfAtqacpeE+0wKt1zYQWKgf4Zj+vee3HmrSV5oyqm
 9SXYhtvrbFu5j5yc1WQX2xtyJzlFg33y4=
X-Gm-Gg: ASbGncuR3FMcH/C3BDwMTfnWrP7Yo2WrVgm3v+ty6iWSi+XlCHtWvzZ+KYytaxtFBfs
 Mb1kX3WMLWYbEXShwb/hmrjg0QpiSfw7xtOEizaOAS4FzPw144k3XqpppamKb53byQtaL5dOIbT
 L8pDHu+WnYuK218GFWxerwScIy20Va3Z6bPBA=
X-Received: by 2002:a17:90b:4c8d:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-313f1d580e2mr17722407a91.17.1750092314567; 
 Mon, 16 Jun 2025 09:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb4KAR6KBUofLyP3OF1Br646NF/19DM6MwQe6HoYPhu+rfHVHsAaU5+Ob+x7LtS1H6/qHrzus2E4CPiRoW4R8=
X-Received: by 2002:a17:90b:4c8d:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-313f1d580e2mr17722326a91.17.1750092313942; Mon, 16 Jun 2025
 09:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250613203620.1283814-1-jsnow@redhat.com>
 <20250613203620.1283814-4-jsnow@redhat.com>
 <jdryel3venw6sl3hghq6nbh4pqk5q4p2hr5qq2hkhd3wizvcsb@ytcelg5nnd3s>
In-Reply-To: <jdryel3venw6sl3hghq6nbh4pqk5q4p2hr5qq2hkhd3wizvcsb@ytcelg5nnd3s>
From: John Snow <jsnow@redhat.com>
Date: Mon, 16 Jun 2025 12:45:01 -0400
X-Gm-Features: AX0GCFtrIXK6nAtvIhzwi6FUEHWitqMQqettzNtMSGMVFD9eOCmAXHKroWWWcfs
Message-ID: <CAFn=p-ZJaNLfyeBJqYTS1oxf0js2C=KZHPfART=BSdQ739Oj=g@mail.gmail.com>
Subject: Re: [PATCH 03/18] qapi: add cross-references to block layer
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: multipart/alternative; boundary="000000000000b284530637b31ec6"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000b284530637b31ec6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025, 12:31=E2=80=AFPM Eric Blake <eblake@redhat.com> wrote=
:

> On Fri, Jun 13, 2025 at 04:36:05PM -0400, John Snow wrote:
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block-core.json   | 186 ++++++++++++++++++++---------------------
> >  qapi/block-export.json |  36 ++++----
> >  qapi/block.json        |  14 ++--
> >  qapi/transaction.json  |  20 ++---
> >  4 files changed, 128 insertions(+), 128 deletions(-)
>
> Detecting whether you missed links is harder; but for the links you
> include here...
>

I can share my script in a little bit, though it's very inefficient and at
times stupid. It is at best "semi-manual", but perhaps there's worth in
improving it so that we can run conversions elsewhere in the docs, or
re-run it periodically?

1. I modified qapi-schema to output a list of identifiers to a text file. I
exclude anything ending in "List".

2. I manually removed built-in types like str and so on. I could update the
above to just do this part automatically ...

3. I ran a python script that loads all of these words and then runs
through all of the qapi .json files, replacing each occurrence with
`occurrence`. The regex is a little rudimentary ...

4. I use "git add -p" to (quickly) review each change as it goes in.
Sometimes I need to make edits to remove the leading @ or remove
surrounding quotes. On occasion I need to disambiguate the reference. I may
need to reflow the text.

5. I skip committing most things for "stop", "eject", "transaction", etc as
they are common words and don't necessarily refer to the QMP command or
event enum, etc.

If there are mistakes, I'd bet money it's around runstates, eject, stop, or
"transaction". It's possible some things are not capitalized "correctly" in
the documentation and therefore missed getting hit by the cross-ref beam,
too.




> Reviewed-by: Eric Blake <eblake@redhat.com>
>

Thank you very much! Hopefully you like this change and it makes browsing
the block documentation much more pleasant.


> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>
>

--000000000000b284530637b31ec6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 16, 2025, 12:31=E2=
=80=AFPM Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com">eblake@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, Jun 13, =
2025 at 04:36:05PM -0400, John Snow wrote:<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/block-core.json=C2=A0 =C2=A0| 186 ++++++++++++++++++++-----=
----------------<br>
&gt;=C2=A0 qapi/block-export.json |=C2=A0 36 ++++----<br>
&gt;=C2=A0 qapi/block.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 ++--<br>
&gt;=C2=A0 qapi/transaction.json=C2=A0 |=C2=A0 20 ++---<br>
&gt;=C2=A0 4 files changed, 128 insertions(+), 128 deletions(-)<br>
<br>
Detecting whether you missed links is harder; but for the links you<br>
include here...<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">I can share my script in a little bit, though it&#39;s very =
inefficient and at times stupid. It is at best &quot;semi-manual&quot;, but=
 perhaps there&#39;s worth in improving it so that we can run conversions e=
lsewhere in the docs, or re-run it periodically?</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">1. I modified qapi-schema to output a list of iden=
tifiers to a text file. I exclude anything ending in &quot;List&quot;.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">2. I manually removed built-=
in types like str and so on. I could update the above to just do this part =
automatically ...</div><div dir=3D"auto"><br></div><div dir=3D"auto">3. I r=
an a python script that loads all of these words and then runs through all =
of the qapi .json files, replacing each occurrence with `occurrence`. The r=
egex is a little rudimentary ...</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">4. I use &quot;git add -p&quot; to (quickly) review each change a=
s it goes in. Sometimes I need to make edits to remove the leading @ or rem=
ove surrounding quotes. On occasion I need to disambiguate the reference. I=
 may need to reflow the text.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">5. I skip committing most things for &quot;stop&quot;, &quot;eject&qu=
ot;, &quot;transaction&quot;, etc as they are common words and don&#39;t ne=
cessarily refer to the QMP command or event enum, etc.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">If there are mistakes, I&#39;d bet money it&=
#39;s around runstates, eject, stop, or &quot;transaction&quot;. It&#39;s p=
ossible some things are not capitalized &quot;correctly&quot; in the docume=
ntation and therefore missed getting hit by the cross-ref beam, too.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Reviewed-by: Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">eblake@redhat.com</a>&gt;<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thank you very much! Ho=
pefully you like this change and it makes browsing the block documentation =
much more pleasant.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer norefer=
rer" target=3D"_blank">qemu.org</a> | <a href=3D"http://libguestfs.org" rel=
=3D"noreferrer noreferrer" target=3D"_blank">libguestfs.org</a><br>
<br>
</blockquote></div></div></div>

--000000000000b284530637b31ec6--


