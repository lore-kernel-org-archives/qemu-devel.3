Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7382AC021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 20:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkTmn-0003ba-8g; Tue, 18 Feb 2025 15:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkTmd-0003bJ-HS
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:01:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkTma-0001fW-Ja
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739908884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j15woZJV7U8bx9WUE8UddwgHt4lYr2bg0F1VCXa3TEs=;
 b=BrwuJxliiv+mBD3yNj/WmenMtTGuRM3bufHaZJtF1JQn6iI05IcgpBHEYYgqJtuujtPfPv
 eJKGWJou3EcuaI89uEhFaUuV9WJhp0KsVoLsrm/feaAva9orSZkevPeJBnC9j8Jkc3oelH
 KwlVtb04tSz3hslmOaAmiUNiBrqT8+g=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-glPYjRJfPG-fCNpzuBwzdg-1; Tue, 18 Feb 2025 15:01:22 -0500
X-MC-Unique: glPYjRJfPG-fCNpzuBwzdg-1
X-Mimecast-MFC-AGG-ID: glPYjRJfPG-fCNpzuBwzdg_1739908881
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-220fff23644so98573295ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 12:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739908881; x=1740513681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j15woZJV7U8bx9WUE8UddwgHt4lYr2bg0F1VCXa3TEs=;
 b=XjzkqxdCTz8Gn+69HGND4NftzE5c0p8QOSCD0j3mJEBMs5NbFdhcPZV35WtqaoFDPp
 fwy4myntLCf7xEQAxHt3ZMOgeyR5gNR0NfmjD5RnfqNSRrA2dmvfsdYB+KiFxHtaLNsh
 yquBbnKMFOVQUCEaVGQqjLpQVULLYHLJ/FieN+K11mFbCJsSx0Wd2n/msdMxl2SPUqva
 Ije0AfcBs5np7DbPA/xNDumEnHBV1/Xy7rcWsW5y+FJQWgCA1swsUfVJiR7KyR8GK7cS
 gJ0ZbSRJXAGphgn0FrRVIZu6tXv0AD4+ycv+oHKspb0K6EjXxJeaNxRA8vPYaWJeUwy1
 jNnQ==
X-Gm-Message-State: AOJu0YyEyLiQD4B4EWsrAzUSFJ9B37pZ2FpBFbDykoOWcFSDoBPKKYx9
 4M68XjiRZ+MkaH1gNSAxoT4sYyvuCsuLAYwQSbexybgLUk239EjOBxCrozA/+oLzdpiqRtVv2QP
 2LCwBgZjInIM1bmXeZ2VK0fQKaf6fpae8bgM+EfD4eaY/GFHBvJb0QQ6lUdLY+kPn0M/dl3f674
 xEe8o8EmG5+R8onmve/NeU78xr7kk=
X-Gm-Gg: ASbGncvm7FthuwxShGjxbpMJGlaObyIA1xaNJmPD18h+VrRgECyxVI6lE6/+1yB1SXh
 0uYkZWp0T5HWv+PgtW7wr4y8pYxDUj6lhwJMMqyRGLMgaYKOFD/WNckmY42nhzvh2OAUpSpkghr
 EA5em7jwKL4fuMqrVWCg==
X-Received: by 2002:a17:902:e2cb:b0:21f:7a8b:d675 with SMTP id
 d9443c01a7336-22103efec65mr179982545ad.4.1739908881021; 
 Tue, 18 Feb 2025 12:01:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkRnMbKzh12uIkFokF716j0mIw0V0U7cVhs28J9SPTWRdylwoyB+EDy7cQH8nhUsdvUrxNQUuJT+eR9z8i23E=
X-Received: by 2002:a17:902:e2cb:b0:21f:7a8b:d675 with SMTP id
 d9443c01a7336-22103efec65mr179982065ad.4.1739908880443; Tue, 18 Feb 2025
 12:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <87wmds4tpk.fsf@pond.sub.org>
In-Reply-To: <87wmds4tpk.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Feb 2025 15:01:06 -0500
X-Gm-Features: AWEUYZlhQYTjPl2VfPFH_PvAuqzUucTh4RmCZrXLHpxXNDBFMiXMgJHx4OblILc
Message-ID: <CAFn=p-adsVRfMhwEst8iX57OOzNDjLkRHg2SQO7+jLuzfx78fw@mail.gmail.com>
Subject: Re: [PATCH 00/42] docs: add sphinx-domain rST generator to qapidoc
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
Content-Type: multipart/alternative; boundary="000000000000c2c9dc062e701ae0"
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

--000000000000c2c9dc062e701ae0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"The text handler you add looks just like the existing latex handler. Does
LaTeX output lack "little headings", too?"

Yes, almost certainly. Can you let me know which output formats we actually
"care about"? I'll have to test them all. In the meantime, I upgraded my
patch so that the text translator properly handles branches with headings
that delineate the different branches so that the text output is fully
reasonable. I will need to do the same for any format we care about.

I've re-pushed as of "about 30 minutes before I wrote this email" --
https://gitlab.com/jsnow/qemu/-/commits/sphinx-domain-blergh2

This branch includes the text generator fixes (which technically belong
with the predecessor series we skipped, but I'll refactor that later.)
it also includes fixes to the branch inliner, generated return statements,
and generated out-of-band feature sections.

(Long story short: inserting new sections in certain spots was broken
because of cache. Oops. We can discuss more why I wrote that part of the
code like I did in review for the patch that introduced that problem. It's
the "basic inliner" patch.)

Below, I'm going to try a new communication approach where I explicitly say
if I have added something to my tasklist or not so that it's clear to you
what I believe is actionable (and what I am agreeing to change) and what I
believe needs stronger input from you before I do anything. Apologies if it
seems a little robotic, just trying new things O:-)

On that note: not added to tasklist: do we need the LaTeX handler? Do we
need any others? Please confirm O:-)


On Fri, Feb 14, 2025 at 7:05=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> I started to eyeball old and new generated output side by side.
>
> New table of contents shows one level, old two.  No objection; the
> navigation thingie on the left is more useful anyway.
>

Unintentional, but if you like it, it's fine by me. Nothing added to my
tasklist.


>
> The new generator elides unreferenced types.  Generally good, but two
> observations:
>
> * QapiErrorClass is unreferenced, but its members are mentioned in
>   Errors sections.  QapiErrorClass serves as better than nothing error
>   code documentation, but it's gone in the new doc.  So this is a minor
>   regression.  We can figure out what to do about it later.
>

Right. I debated making the members references to that class, but recalled
that you disliked this class and figured you'd not like such a change, so I
just left it alone. I do not have cross-references for individual members
of objects at all yet anyway, so this is definitely more work regardless.

We could always create a pragma of some sort (or just hardcode a list) of
items that must be documented regardless of if they're referenced or not.
Please let me know your preference and I will add a "ticket" on my personal
tasklist for this project to handle that at /some point/. Nothing added to
my tasklist just yet.


>
> * Section "QMP errors" is empty in the new doc, because its entire
>   contents is elided.  I guess we should elide the section as well, but
>   it's fine to leave that for later.
>

Adding to tasklist to elide empty modules, but "for later".


>
> Old doc shows a definition's since information like any other section.
> New doc has it in the heading box.  Looks prettier and uses much less
> space.  Not sure the heading box is the best place, but it'll do for
> now, we can always move it around later.
>

Agree, it's a strict improvement - there may be further improvements, but
that is always true anyway. When we tackle "autogenerated since
information" we can tackle the since display issues more meticulously. Or
maybe we'll need do sooner because of conflicting info in branches or
whatever else. I dunno, I'll burn that bridge when I get to it. Nothing
added to tasklist.


>
> The new doc's headings use "Struct" or "Union" where the old one uses
> just "Object".  Let's keep "Object", please.
>

I was afraid you'd ask for this. OK, I think it's an easy change. Can I
keep the index page segmented by object type still, though?

I do find knowing the *type* of object to be helpful as a developer, though
I understand that from the point of view of a QMP user, they're all just
objects, so your request makes sense.

Replace JSON object type headers with "Object" instead of QAPI data types
added to tasklist.


>
> In the new doc, some member references are no longer rendered as such,
> e.g. @on-source-error and @on-target-error in BackupCommon's note.
> Another small regression.
>

Ah, I actually knew this one. I didn't implement special formatting for
these yet. I do not have cross-references for individual members, so
there's nothing to transform these *into* yet. If you'd like special
rendering for them (fixed width, no link?) that's easy to accomplish. I am
not yet sure where I will do that conversion.

Reminder/Note that in my KVM Forum branch, I did actually replace all
@references that pointed to something actually cross-referenceable with an
actual sphinx cross-reference, leaving only @member references behind.

Nothing added to tasklist just yet.


>
> Union branches are busted in the new generator's output.  I know they
> used to work, so I'm not worried about it.
>

Fixed in new push, sorry! An embarrassing mistake that took me aeons to
spot.


>
> The new doc shows the return type, the old doc doesn't.  Showing it is
> definitely an improvement, but we need to adjust the doc text to avoid
> silliness like "Returns: SnapshotInfo =E2=80=93 SnapshotInfo".
>

My KVM Forum branch actually corrected the QAPI documentation to remove
pointless returns. I didn't include that with this series yet, it was long
enough. This issue will be addressed solely through source documentation
edits, of which I believe I already have a comprehensive patch for.

Added to my tasklist: "Submit source documentation patches to remove
pointless return documentation"

It was my intent to submit those patches *afterwards*, but we can always do
it before if you'd like. Let me know. (I don't know offhand how easy they
are to extricate from my KVM Forum branch. I reserve the right to change my
mind on being flexible depending on the answer there :p)


>
> The new doc shows Arguments / Members, Returns, and Errors in two-column
> format.  Looks nice.  But for some reason, the two columns don't align
> horizontally for Errors like they do for the others.  Certainly not a
> blocker of anything, but we should try to fix it at some point.
>

Known issue. The reason is because we do not mandate a source documentation
format for errors - by convention, it is a list. There is (or was?) one
occurrence where it wasn't a list and I wrote a patch to change that. I
don't recall right now if we merged that or not. The misalignment is a
result of nesting a list inside of a list.

If we *mandate* the source format, I gain the ability to "peel off the
nesting", which will fix the alignment.

Added to tasklist: "Address vertical misalignment in Errors formatting"

Not added: how? need more input from you, please.


>
> The new doc doesn't show non-definition conditionals, as mentioned in
> the cover letter.  It shows definition conditionals twice.  Once should
> suffice.
>

Known/intentional issue. I couldn't decide where I wanted it, so I put it
in both places. If you have a strong opinion right now, please let me know
what it is and I'll take care of it, it's easy - but it's code in the
predecessor series and nothing to do with qapidoc, so please put it out of
mind for now.

If you don't have strong feelings, or you feel that the answer may depend
on how we solve other glaring issues (non-definition conditionals), let's
wait a little bit before making a decision.

Added to tasklist: "Remove the duplication of definition conditionals";
left unspecified is how or in what direction :)


>
> There's probably more, but this is it for now.
>
>

Tasklist:

 For the qapi-domain (prequel!) series:
  - Remove the duplication of definition conditionals

For this (qapidoc) series:
  - Display all JSON object types as "Object" and not as their QAPI data
type.

For later:
  - Elide empty modules
  - Submit source documentation patches to remove pointless return
documentation
  - Address vertical misalignment in Errors formatting

--000000000000c2c9dc062e701ae0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br>&quot;<span class=3D"gmail-im"></span=
>The text handler you add looks just like the existing latex handler. Does =
LaTeX output lack &quot;little headings&quot;, too?&quot;</div><div dir=3D"=
ltr"><br></div><div>Yes, almost certainly. Can you let me know which output=
 formats we actually &quot;care about&quot;? I&#39;ll have to test them all=
. In the meantime, I upgraded my patch so that the text translator properly=
 handles branches with headings that delineate the different branches so th=
at the text output is fully reasonable. I will need to do the same for any =
format we care about.</div><div><br></div><div>I&#39;ve re-pushed as of &qu=
ot;about 30 minutes before I wrote this email&quot; --</div><div><a href=3D=
"https://gitlab.com/jsnow/qemu/-/commits/sphinx-domain-blergh2">https://git=
lab.com/jsnow/qemu/-/commits/sphinx-domain-blergh2</a></div><div><br></div>=
<div>This branch includes the text generator fixes (which technically belon=
g with the predecessor series we skipped, but I&#39;ll refactor that later.=
)</div><div>it also includes fixes to the branch inliner, generated return =
statements, and generated out-of-band feature sections.</div><div><br></div=
><div>(Long story short: inserting new sections in certain spots was broken=
 because of cache. Oops. We can discuss more why I wrote that part of the c=
ode like I did in review for the patch that introduced that problem. It&#39=
;s the &quot;basic inliner&quot; patch.)<br></div><div><br></div><div>Below=
, I&#39;m going to try a new communication approach where I explicitly say =
if I have added something to my tasklist or not so that it&#39;s clear to y=
ou what I believe is actionable (and what I am agreeing to change) and what=
 I believe needs stronger input from you before I do anything. Apologies if=
 it seems a little robotic, just trying new things O:-)</div><div><br></div=
><div>On that note: not added to tasklist: do we need the LaTeX handler? Do=
 we need any others? Please confirm O:-)</div><div dir=3D"ltr"><span class=
=3D"gmail-im"><br></span></div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 14, 2025 at 7:05=
=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armb=
ru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">I started to eyeball old and new generated output side by side=
.<br>
<br>
New table of contents shows one level, old two.=C2=A0 No objection; the<br>
navigation thingie on the left is more useful anyway.<br></blockquote><div>=
<br></div><div>Unintentional, but if you like it, it&#39;s fine by me. Noth=
ing added to my tasklist.</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
The new generator elides unreferenced types.=C2=A0 Generally good, but two<=
br>
observations:<br>
<br>
* QapiErrorClass is unreferenced, but its members are mentioned in<br>
=C2=A0 Errors sections.=C2=A0 QapiErrorClass serves as better than nothing =
error<br>
=C2=A0 code documentation, but it&#39;s gone in the new doc.=C2=A0 So this =
is a minor<br>
=C2=A0 regression.=C2=A0 We can figure out what to do about it later.<br></=
blockquote><div><br></div><div>Right. I debated making the members referenc=
es to that class, but recalled that you disliked this class and figured you=
&#39;d not like such a change, so I just left it alone. I do not have cross=
-references for individual members of objects at all yet anyway, so this is=
 definitely more work regardless.</div><div><br></div><div>We could always =
create a pragma of some sort (or just hardcode a list) of items that must b=
e documented regardless of if they&#39;re referenced or not. Please let me =
know your preference and I will add a &quot;ticket&quot; on my personal tas=
klist for this project to handle that at /some point/. Nothing added to my =
tasklist just yet.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
* Section &quot;QMP errors&quot; is empty in the new doc, because its entir=
e<br>
=C2=A0 contents is elided.=C2=A0 I guess we should elide the section as wel=
l, but<br>
=C2=A0 it&#39;s fine to leave that for later.<br></blockquote><div><br></di=
v><div>Adding to tasklist to elide empty modules, but &quot;for later&quot;=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Old doc shows a definition&#39;s since information like any other section.<=
br>
New doc has it in the heading box.=C2=A0 Looks prettier and uses much less<=
br>
space.=C2=A0 Not sure the heading box is the best place, but it&#39;ll do f=
or<br>
now, we can always move it around later.<br></blockquote><div><br></div><di=
v>Agree, it&#39;s a strict improvement - there may be further improvements,=
 but that is always true anyway. When we tackle &quot;autogenerated since i=
nformation&quot; we can tackle the since display issues more meticulously. =
Or maybe we&#39;ll need do sooner because of conflicting info in branches o=
r whatever else. I dunno, I&#39;ll burn that bridge when I get to it. Nothi=
ng added to tasklist.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
The new doc&#39;s headings use &quot;Struct&quot; or &quot;Union&quot; wher=
e the old one uses<br>
just &quot;Object&quot;.=C2=A0 Let&#39;s keep &quot;Object&quot;, please.<b=
r></blockquote><div><br></div><div>I was afraid you&#39;d ask for this. OK,=
 I think it&#39;s an easy change. Can I keep the index page segmented by ob=
ject type still, though?</div><div><br></div><div>I do find knowing the *ty=
pe* of object to be helpful as a developer, though I understand that from t=
he point of view of a QMP user, they&#39;re all just objects, so your reque=
st makes sense.</div><div><br></div><div>Replace JSON object type headers w=
ith &quot;Object&quot; instead of QAPI data types added to tasklist.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
In the new doc, some member references are no longer rendered as such,<br>
e.g. @on-source-error and @on-target-error in BackupCommon&#39;s note.<br>
Another small regression.<br></blockquote><div><br></div><div>Ah, I actuall=
y knew this one. I didn&#39;t implement special formatting for these yet. I=
 do not have cross-references for individual members, so there&#39;s nothin=
g to transform these *into* yet. If you&#39;d like special rendering for th=
em (fixed width, no link?) that&#39;s easy to accomplish. I am not yet sure=
 where I will do that conversion.</div><div><br></div><div>Reminder/Note th=
at in my KVM Forum branch, I did actually replace all @references that poin=
ted to something actually cross-referenceable with an actual sphinx cross-r=
eference, leaving only @member references behind.<br></div><div><br></div><=
div>Nothing added to tasklist just yet.</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
Union branches are busted in the new generator&#39;s output.=C2=A0 I know t=
hey<br>
used to work, so I&#39;m not worried about it.<br></blockquote><div><br></d=
iv><div>Fixed in new push, sorry! An embarrassing mistake that took me aeon=
s to spot.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
The new doc shows the return type, the old doc doesn&#39;t.=C2=A0 Showing i=
t is<br>
definitely an improvement, but we need to adjust the doc text to avoid<br>
silliness like &quot;Returns: SnapshotInfo =E2=80=93 SnapshotInfo&quot;.<br=
></blockquote><div><br></div><div>My KVM Forum branch actually corrected th=
e QAPI documentation to remove pointless returns. I didn&#39;t include that=
 with this series yet, it was long enough. This issue will be addressed sol=
ely through source documentation edits, of which I believe I already have a=
 comprehensive patch for.</div><div><br></div><div>Added to my tasklist: &q=
uot;Submit source documentation patches to remove pointless return document=
ation&quot;</div><div><br></div><div>It was my intent to submit those patch=
es *afterwards*, but we can always do it before if you&#39;d like. Let me k=
now. (I don&#39;t know offhand how easy they are to extricate from my KVM F=
orum branch. I reserve the right to change my mind on being flexible depend=
ing on the answer there :p)</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
The new doc shows Arguments / Members, Returns, and Errors in two-column<br=
>
format.=C2=A0 Looks nice.=C2=A0 But for some reason, the two columns don&#3=
9;t align<br>
horizontally for Errors like they do for the others.=C2=A0 Certainly not a<=
br>
blocker of anything, but we should try to fix it at some point.<br></blockq=
uote><div><br></div><div>Known issue. The reason is because we do not manda=
te a source documentation format for errors - by convention, it is a list. =
There is (or was?) one occurrence where it wasn&#39;t a list and I wrote a =
patch to change that. I don&#39;t recall right now if we merged that or not=
. The misalignment is a result of nesting a list inside of a list.</div><di=
v><br></div><div>If we *mandate* the source format, I gain the ability to &=
quot;peel off the nesting&quot;, which will fix the alignment.</div><div><b=
r></div><div>Added to tasklist: &quot;Address vertical misalignment in Erro=
rs formatting&quot;</div><div><br></div><div>Not added: how? need more inpu=
t from you, please.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
The new doc doesn&#39;t show non-definition conditionals, as mentioned in<b=
r>
the cover letter.=C2=A0 It shows definition conditionals twice.=C2=A0 Once =
should<br>
suffice.<br></blockquote><div><br></div><div>Known/intentional issue. I cou=
ldn&#39;t decide where I wanted it, so I put it in both places. If you have=
 a strong opinion right now, please let me know what it is and I&#39;ll tak=
e care of it, it&#39;s easy - but it&#39;s code in the predecessor series a=
nd nothing to do with qapidoc, so please put it out of mind for now.</div><=
div><br></div><div>If you don&#39;t have strong feelings, or you feel that =
the answer may depend on how we solve other glaring issues (non-definition =
conditionals), let&#39;s wait a little bit before making a decision.</div><=
div><br></div><div>Added to tasklist: &quot;Remove the duplication of defin=
ition conditionals&quot;; left unspecified is how or in what direction :)</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
There&#39;s probably more, but this is it for now.<br>
<br></blockquote><div><br></div><div><br></div><div>Tasklist:</div><div><br=
></div><div>=C2=A0For the qapi-domain (prequel!) series:<br>=C2=A0 - Remove=
 the duplication of definition conditionals<br><br>For this (qapidoc) serie=
s:<br>=C2=A0 - Display all JSON object types as &quot;Object&quot; and not =
as their QAPI data type.<br><br>For later:<br>=C2=A0 - Elide empty modules<=
br>=C2=A0 - Submit source documentation patches to remove pointless return =
documentation<br>=C2=A0 - Address vertical misalignment in Errors formattin=
g</div></div></div>

--000000000000c2c9dc062e701ae0--


