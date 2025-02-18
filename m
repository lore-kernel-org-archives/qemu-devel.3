Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E31C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 22:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkWOD-0000tk-S4; Tue, 18 Feb 2025 17:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkWOC-0000tc-HJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:48:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkWO9-0005Dl-Tx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739918904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aeCN3hH1SbE7thu7uccmF5N7W07RDd7ZG1emxLBKDeY=;
 b=fDboEeVzLmEhhjt/KxUnJnWoQW9f5Z1YjrDlBGEJVrtpfI+yRow+vZPeukKjXmXMgmcWUN
 SO1UdFN5WFnx4pv2BHwQm45DCMnjb6HV8/8THbLm06qS4joTRMCYPR9NK27pEE2A6WcsTW
 VleL2MD9iNc3CYoOLTkO7PByQHkLAY8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-C_Ef6GAwM869_Z1rzj7blw-1; Tue, 18 Feb 2025 17:48:22 -0500
X-MC-Unique: C_Ef6GAwM869_Z1rzj7blw-1
X-Mimecast-MFC-AGG-ID: C_Ef6GAwM869_Z1rzj7blw_1739918902
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fc5a9f18afso6001052a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 14:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739918902; x=1740523702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aeCN3hH1SbE7thu7uccmF5N7W07RDd7ZG1emxLBKDeY=;
 b=dS2lp0Qt7IxARJ4bfUseSVlALj4oU9qGq5+FaFLAz4bhipOTo5v8Bh+SDUvar/TEET
 oDfEK/TcKDYcOjL/ZH9jEwcB34kJ1VbxsL7dg1uiGNcRfj0vM5Dw5p1tseq3cTgffK2J
 kWzQiXX29VtAEHemiDCl0XqFU/rbE4blSorPyFS9Dm18/lc59GThYoTSAy3Kg/BSIyy6
 jVD1qWGH7o37+0AeZI9uL77TmEW9/HDqDJHF9FTqUAqRNyhBUnJWSjsXwfQt4giZPOkV
 oLrPKbN+h5NOXlmVnbG5bfzaV1/RgKTdxExIERafyhVe4sJ1loIpg0qLsTLfZ3hUr9ar
 sOzg==
X-Gm-Message-State: AOJu0Ywi/F4+thRRykcuEGXJ3Qapmtggiu/6+xg81iyyWC3R4fIAxpmd
 FLdhaU9s7NeFbRCbmxSODzow1VPZBYVE3ZmNyAyVMQmRMtIHL4hXZCmuJBO7WaEH7G3rW8plYw1
 jH1gl9qCz4x+FecWl3qZ5S6rZWbRqjb7281+dQ4rK1Fj6hknlWka3Fg0YuWehQCJZUOLBk91ffa
 RJsSjQirgbtfWGYPNMbUQ/i4aWq5k=
X-Gm-Gg: ASbGncv3kZHfcoIAgRjMLGHuzD0fQnj2zxzLIkBHKFm1DGtlaJwWIzgOpeBxMbJV1UU
 StyYQuzGPS5uQGDkkd292Yjfh0fQTXCqLSjtVhb573Dc9bTUtM21bCr5t3eOHjif++SkC36lhtA
 Zs24y8bwdoiy9dSfan9g==
X-Received: by 2002:a17:90b:2249:b0:2fc:9967:acd8 with SMTP id
 98e67ed59e1d1-2fcb5abf66dmr2059811a91.33.1739918901622; 
 Tue, 18 Feb 2025 14:48:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwAhgiKrYDX8mq1e4ymzwtsgYhdyg9VsDnBnvOkN2BWEuYPki1EgX6W67MYNiSSLevW3IR8Zrkt8FW7DKKLvs=
X-Received: by 2002:a17:90b:2249:b0:2fc:9967:acd8 with SMTP id
 98e67ed59e1d1-2fcb5abf66dmr2059761a91.33.1739918901231; Tue, 18 Feb 2025
 14:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-30-jsnow@redhat.com>
 <87h64srcpo.fsf@pond.sub.org>
In-Reply-To: <87h64srcpo.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Feb 2025 17:48:09 -0500
X-Gm-Features: AWEUYZkFCCVGKPP9mp9uutzYaQGLKk-8ZdINogiI1kKithiRhzSbdsCV9jtrBk4
Message-ID: <CAFn=p-ahRX5fULGNn4uCh5aqqKcZoocQiXQEO=xkQAKdNEZAHA@mail.gmail.com>
Subject: Re: [PATCH 29/42] qapi: Add "Details:" disambiguation marker
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>, 
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000bdd1a062e727057"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000000bdd1a062e727057
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 7:13=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This clarifies sections that are mistaken by the parser as "intro"
> > sections to be "details" sections instead.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> This is rather terse.
>

Mea culpa. I can write more at length if we agree on the general approach.
For now, you got an RFC as this was the subject of a considerable amount of
controversy between us in the past ... so I am doing baby steps.

"Commit message needs to be hit with the unterseification beam" added to
tasklist. :)


>
> Why does the boundary between "intro" (previously "body") and "details"
> matter?  As far as I understand, it matters for inlining.
>

> What is inlining?
>

> The old doc generator emits "The members of T" into the argument
> description in the following cases:
>
> * When a command's arguments are given as a type T, the doc comment has
>   no argument descriptions, and the generated argument description
>   becomes "The members of T".
>
> * When an object type has a base type T, "The members of T" is appended
>   to the doc comment's (possibly empty) argument descriptions.
>
> * For union types, "The members of T when TAG is VALUE" is appended to
>   the doc comment's argument descriptions for every tag VALUE and
>   associated type T.
>
> We want a description of the members of T right there instead.  To get
> it right there, we need to inline from T's documentation.
>
> What exactly do we need to inline?  Turns out we don't want "intro", we
> do want the argument descriptions and other stuff we can ignore here.
>
> "intro" ends before the argument descriptions, features, or a tagged
> section, whatever comes first.  Most of the time, this works fine.  But
> there are a few troublesome cases.  Here's one:
>
>     ##
>     # @MemoryBackendShmProperties:
>     #
>     # Properties for memory-backend-shm objects.
>     #
>     # This memory backend supports only shared memory, which is the
>     # default.
>     #
>     # Since: 9.1
>     ##
>     { 'struct': 'MemoryBackendShmProperties',
>       'base': 'MemoryBackendProperties',
>       'data': { },
>       'if': 'CONFIG_POSIX' }
>
> Everything up to "Since:" is "intro".  Consequently, the old doc
> generator emits "The members of MemoryBackendProperties" right there:
>
>     "MemoryBackendShmProperties" (Object)
>     -------------------------------------
>
>     Properties for memory-backend-shm objects.
>
>     This memory backend supports only shared memory, which is the default=
.
>
>
>     Members
>     ~~~~~~~
>
>     The members of "MemoryBackendProperties"
>
>     Since
>     ~~~~~
>
>     9.1
>
>
>     If
>     ~~
>
>     "CONFIG_POSIX"
>
> That's also where the new one inlines.  Okay so far.
>
> This gets in turn inlined into ObjectOptions for branch
> memory-backend-shm.  Since we don't inline "intro", we don't inline
> "This memory backend supports only shared memory, which is the default."
> That's a problem.
>

Yes, this is all correct so far.


>
> This patch moves the boundary between "intro" and the remainder up that
> paragraph, so we don't lose that line.  It accomplishes that by giving
> us syntax to manually mark the end of "intro"
>
> However, your solution is manual: it gives us the means[*] to mark the
> boundary with "Details:" to avoid loss of text.  What if we don't
> notice?  Should we tweak the syntax to force us to be explicit?  How
> many doc comments would that affect?
>

I'm leaving that question to you. The calculus I made was that there were
fewer SLOC changes to explicitly denote the "Details:" sections only in the
handful of cases where it was (potentially) relevant than to mandate its
use unconditionally. If you have an idea that is enforceable at runtime and
has fewer SLOC changes, suggest away!

Unseen in this patch is a warning I added to the /inliner/ that identified
potentially "ambiguous" delineation spots and issued a warning (error); the
exact code that did this is possibly a little hokey but it was what I used
to identify the spots addressed by this patch.

Point being: it's possible to enforce, but I enforced it in qapidoc.py in
the inliner instead of directly in the parser. We could discuss moving the
check to the parser if you'd like. The check itself is somewhat "dumb":

- If a doc block has only one *paragraph* (knowingly/intentionally not
using the term section here) of text, it's assumed to be the intro.
- If a doc block has any number of tagged sections, all text above (if any)
is assumed to be the "intro" and all text below (if any) is assumed to be
"details".

It's only in this case that it whines:

- A doc block has *multiple paragraphs* of text at the start of the block,
but has no other sections and so if there is semantically a "details"
section or not is unclear to the parser and inliner.

The check as I wrote it is unintelligent in that it does not bother to
check if the doc block it is checking is ever one that *could* be inlined;
i.e. it will complain about being unable to delineate for commands -- even
though it wouldn't really matter in that case. It's a potential improvement
to the algorithm to ignore cases where that "ambiguity" is not actually
important.

But, it's possible to mechanically enforce and nudge documentation writers
to add the delineation marker where the parser is uncertain.


>
> [*] Actually, we have means even before this patch, they're just ugly.
> See the TODO comment added in commit 14b48aaab92 (qapi: convert
> "Example" sections without titles)


That's right. This is merely a formalization of that hack: I add a
"section" that is intentionally empty and serves only as a marker to the
parser to begin recording a new section.

--0000000000000bdd1a062e727057
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 17,=
 2025 at 7:13=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This clarifies sections that are mistaken by the parser as &quot;intro=
&quot;<br>
&gt; sections to be &quot;details&quot; sections instead.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
This is rather terse.<br></blockquote><div><br></div><div>Mea culpa. I can =
write more at length if we agree on the general approach. For now, you got =
an RFC as this was the subject of a considerable amount of controversy betw=
een us in the past ... so I am doing baby steps.<br></div><div><br></div><d=
iv>&quot;Commit message needs to be hit with the unterseification beam&quot=
; added to tasklist. :)</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
Why does the boundary between &quot;intro&quot; (previously &quot;body&quot=
;) and &quot;details&quot;<br>
matter?=C2=A0 As far as I understand, it matters for inlining.<br></blockqu=
ote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
What is inlining? <br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
The old doc generator emits &quot;The members of T&quot; into the argument<=
br>
description in the following cases:<br>
<br>
* When a command&#39;s arguments are given as a type T, the doc comment has=
<br>
=C2=A0 no argument descriptions, and the generated argument description<br>
=C2=A0 becomes &quot;The members of T&quot;.<br>
<br>
* When an object type has a base type T, &quot;The members of T&quot; is ap=
pended<br>
=C2=A0 to the doc comment&#39;s (possibly empty) argument descriptions.<br>
<br>
* For union types, &quot;The members of T when TAG is VALUE&quot; is append=
ed to<br>
=C2=A0 the doc comment&#39;s argument descriptions for every tag VALUE and<=
br>
=C2=A0 associated type T.<br>
<br>
We want a description of the members of T right there instead.=C2=A0 To get=
<br>
it right there, we need to inline from T&#39;s documentation.<br>
<br>
What exactly do we need to inline?=C2=A0 Turns out we don&#39;t want &quot;=
intro&quot;, we<br>
do want the argument descriptions and other stuff we can ignore here.<br>
<br>
&quot;intro&quot; ends before the argument descriptions, features, or a tag=
ged<br>
section, whatever comes first.=C2=A0 Most of the time, this works fine.=C2=
=A0 But<br>
there are a few troublesome cases.=C2=A0 Here&#39;s one:<br>
<br>
=C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 # @MemoryBackendShmProperties:<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Properties for memory-backend-shm objects.<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # This memory backend supports only shared memory, which is t=
he<br>
=C2=A0 =C2=A0 # default.<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Since: 9.1<br>
=C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 { &#39;struct&#39;: &#39;MemoryBackendShmProperties&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 &#39;base&#39;: &#39;MemoryBackendProperties&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 &#39;data&#39;: { },<br>
=C2=A0 =C2=A0 =C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
<br>
Everything up to &quot;Since:&quot; is &quot;intro&quot;.=C2=A0 Consequentl=
y, the old doc<br>
generator emits &quot;The members of MemoryBackendProperties&quot; right th=
ere:<br>
<br>
=C2=A0 =C2=A0 &quot;MemoryBackendShmProperties&quot; (Object)<br>
=C2=A0 =C2=A0 -------------------------------------<br>
<br>
=C2=A0 =C2=A0 Properties for memory-backend-shm objects.<br>
<br>
=C2=A0 =C2=A0 This memory backend supports only shared memory, which is the=
 default.<br>
<br>
<br>
=C2=A0 =C2=A0 Members<br>
=C2=A0 =C2=A0 ~~~~~~~<br>
<br>
=C2=A0 =C2=A0 The members of &quot;MemoryBackendProperties&quot;<br>
<br>
=C2=A0 =C2=A0 Since<br>
=C2=A0 =C2=A0 ~~~~~<br>
<br>
=C2=A0 =C2=A0 9.1<br>
<br>
<br>
=C2=A0 =C2=A0 If<br>
=C2=A0 =C2=A0 ~~<br>
<br>
=C2=A0 =C2=A0 &quot;CONFIG_POSIX&quot;<br>
<br>
That&#39;s also where the new one inlines.=C2=A0 Okay so far.<br>
<br>
This gets in turn inlined into ObjectOptions for branch<br>
memory-backend-shm.=C2=A0 Since we don&#39;t inline &quot;intro&quot;, we d=
on&#39;t inline<br>
&quot;This memory backend supports only shared memory, which is the default=
.&quot;<br>
That&#39;s a problem.<br></blockquote><div><br></div><div>Yes, this is all =
correct so far.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
This patch moves the boundary between &quot;intro&quot; and the remainder u=
p that<br>
paragraph, so we don&#39;t lose that line.=C2=A0 It accomplishes that by gi=
ving<br>
us syntax to manually mark the end of &quot;intro&quot;<br>
<br>
However, your solution is manual: it gives us the means[*] to mark the<br>
boundary with &quot;Details:&quot; to avoid loss of text.=C2=A0 What if we =
don&#39;t<br>
notice?=C2=A0 Should we tweak the syntax to force us to be explicit?=C2=A0 =
How<br>
many doc comments would that affect?<br></blockquote><div><br></div><div>I&=
#39;m leaving that question to you. The calculus I made was that there were=
 fewer SLOC changes to explicitly denote the &quot;Details:&quot; sections =
only in the handful of cases where it was (potentially) relevant than to ma=
ndate its use unconditionally. If you have an idea that is enforceable at r=
untime and has fewer SLOC changes, suggest away!</div><div><br></div><div>U=
nseen in this patch is a warning I added to the /inliner/ that identified p=
otentially &quot;ambiguous&quot; delineation spots and issued a warning (er=
ror); the exact code that did this is possibly a little hokey but it was wh=
at I used to identify the spots addressed by this patch.</div><div><br></di=
v><div>Point being: it&#39;s possible to enforce, but I enforced it in qapi=
doc.py in the inliner instead of directly in the parser. We could discuss m=
oving the check to the parser if you&#39;d like. The check itself is somewh=
at &quot;dumb&quot;:</div><div><br></div><div>- If a doc block has only one=
 *paragraph* (knowingly/intentionally not using the term section here) of t=
ext, it&#39;s assumed to be the intro.</div><div>- If a doc block has any n=
umber of tagged sections, all text above (if any) is assumed to be the &quo=
t;intro&quot; and all text below (if any) is assumed to be &quot;details&qu=
ot;.</div><div><br></div><div>It&#39;s only in this case that it whines:</d=
iv><div><br></div><div>- A doc block has *multiple paragraphs* of text at t=
he start of the block, but has no other sections and so if there is semanti=
cally a &quot;details&quot; section or not is unclear to the parser and inl=
iner.</div><div><br></div><div>The check as I wrote it is unintelligent in =
that it does not bother to check if the doc block it is checking is ever on=
e that *could* be inlined; i.e. it will complain about being unable to deli=
neate for commands -- even though it wouldn&#39;t really matter in that cas=
e. It&#39;s a potential improvement to the algorithm to ignore cases where =
that &quot;ambiguity&quot; is not actually important.</div><div><br></div><=
div>But, it&#39;s possible to mechanically enforce and nudge documentation =
writers to add the delineation marker where the parser is uncertain.</div><=
div><br></div><div></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
[*] Actually, we have means even before this patch, they&#39;re just ugly.<=
br>
See the TODO comment added in commit 14b48aaab92 (qapi: convert<br>
&quot;Example&quot; sections without titles)</blockquote><div><br></div><di=
v>That&#39;s right. This is merely a formalization of that hack: I add a &q=
uot;section&quot; that is intentionally empty and serves only as a marker t=
o the parser to begin recording a new section.</div></div></div>

--0000000000000bdd1a062e727057--


