Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418CDC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 13:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsj5V-0003Bu-Vf; Thu, 13 Mar 2025 09:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsj5K-0003A6-NA
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 09:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsj5G-0004dj-V8
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 09:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741874330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGrRkdPC0RtCSD30i8DJNkbjn9s5E/pyGTQfKxAT3w0=;
 b=T3S5hMbzqyWFTWEGg6ims+ol/DNEJX8AomYaABu/bFwLKwVGSVMZJoSS3XMTM7TZ0dgWdZ
 2oXlfb37L5RWYVWa7ZQnSWtdOQcuGazjuDU9MmqMdVEtB0aUvVoN22E0fjRxRjJSL0LGtv
 wVEigSt+a+8a72EHD8PAHKTUEyvJWU0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-c4im1bEAM-GfbQeicbChcg-1; Thu, 13 Mar 2025 09:58:46 -0400
X-MC-Unique: c4im1bEAM-GfbQeicbChcg-1
X-Mimecast-MFC-AGG-ID: c4im1bEAM-GfbQeicbChcg_1741874325
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff82dd6de0so1808060a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 06:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741874325; x=1742479125;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xGrRkdPC0RtCSD30i8DJNkbjn9s5E/pyGTQfKxAT3w0=;
 b=kWgbq1Q5vaBeZFnSh4FbBUJdTJSAIOLGD8cOY9RKXEY2fLl2FPEDX11ASHYifPXwIz
 7WdcD0LW9Wd/yOdOf1w5drpR6GzwW8Hb0QTgZcOsXO2N6V2jy9lJqYmNhgWVRs6MGCZa
 q1ePVlGiQ215JHJ+cqMn59QKpO7uKTbb+oIiGHY+JAFTDAFh11rV0m2tIx4rtG+gddLB
 eejo9RJlPj2hn8w1j8nspDDePFjUO77xSAnjbkJzpRna8dCpslhSfWUPU9E3K5lO6v9r
 r4QSrBv2drFDWklCW5TUARL9gBbhgtm0qkbibOeU9HNdW7HMGbNxmd1+1kuQrKu9Fe1c
 dkHw==
X-Gm-Message-State: AOJu0YyYAaj4284RX9fbnHbLA9CFoMUHWWZKz1KQcSxkB2KTI+425XG3
 JuE/SZimi65V+IRGQyem/swEuh8rSHC2m3veFveQfjKfF+I9e2hwkjjkUW7/aGOV6vIQgcoTLCH
 qgRhsgJQi2QsJrsuZVYMBknSV+brpNbE2oYK/A9tIN9lgppa8CHzzRQreAA5oOsLOuwzDHONr+h
 Cr8WFh+5rQVwlqQrrFzb1ezJF7LveOQU3WFBI=
X-Gm-Gg: ASbGncuQRXO9VOVnQ0hX86asSbJJw0n94WIZL5yejKdUcND3UG7fw+rIlTulhNjPlQ7
 Tq3jfibWOv/y8CPRLk9Ntk9QOiu2Ihvw+dR7zM0CzjxVP9sWInNN116M7t+zjc3B7r6FB4IV1HJ
 x3+wG4zBRO/TbhQeSItBuShGGaKaG0
X-Received: by 2002:a17:90b:380e:b0:2ff:64a0:4a57 with SMTP id
 98e67ed59e1d1-2ff7ceef536mr30995411a91.26.1741874324590; 
 Thu, 13 Mar 2025 06:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzUy8DMR3byFtNZAdf9WD+82+zEtAXsxzXGDOibiHby640whZEQRRsLAKsR7wi4EkcuP/hUbevJuowZoFQK2U=
X-Received: by 2002:a17:90b:380e:b0:2ff:64a0:4a57 with SMTP id
 98e67ed59e1d1-2ff7ceef536mr30995385a91.26.1741874324219; Thu, 13 Mar 2025
 06:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-8-jsnow@redhat.com>
 <8734fhe8ag.fsf@pond.sub.org>
In-Reply-To: <8734fhe8ag.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 13 Mar 2025 09:58:31 -0400
X-Gm-Features: AQ5f1Jq6isMZXVkHqvMQtz6yxEnbiif5B94jNZC_VVJifiRM5tVF4K6d_JVbQ6s
Message-ID: <CAFn=p-b2LUBzn-JE6P41wCxnW-vAB1moHWcw66d9Ta=tt_H1gQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] docs/qapi_domain: add namespace support to
 cross-references
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000056c732063039b810"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--00000000000056c732063039b810
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch does three things:
> >
> > 1. Record the current namespace context in pending_xrefs so it can be
> >    used for link resolution later,
> > 2. Pass that recorded namespace context to find_obj() when resolving a
> >    reference, and
> > 3. Wildly and completely rewrite find_obj().
> >
> > cross-reference support is expanded to tolerate the presence or absence
> > of either namespace or module, and to cope with the presence or absence
> > of contextual information for either.
> >
> > References now work like this:
> >
> > 1. If the explicit reference target is recorded in the domain's object
> >    registry, we link to that target and stop looking. We do this lookup
> >    regardless of how fully qualified the target is, which allows direct
> >    references to modules (which don't have a module component to their
> >    names) or direct references to definitions that may or may not belon=
g
> >    to a namespace or module.
> >
> > 2. If contextual information is available from qapi:namespace or
> >    qapi:module directives, try using those components to find a direct
> >    match to the implied target name.
> >
> > 3. If both prior lookups fail, generate a series of regular expressions
> >    looking for wildcard matches in order from most to least
> >    specific. Any explicitly provided components (namespace, module)
> >    *must* match exactly, but both contextual and entirely omitted
> >    components are allowed to differ from the search result. Note that i=
f
> >    more than one result is found, Sphinx will emit a warning (a build
> >    error for QEMU) and list all of the candidate references.
> >
> > The practical upshot is that in the large majority of cases, namespace
> > and module information is not required when creating simple `references=
`
> > to definitions from within the same context -- even when identical
> > definitions exist in other contexts.
>
> Can you illustrate this this examples?
>

do wha?


>
> > Even when using simple `references` from elsewhere in the QEMU
> > documentation manual, explicit namespace info is not required if there
> > is only one definition by that name.
>
> Fails safely: if we add a second definition, doc generation errors out.
> Correct?
>

Yes, see the disambiguation patch for qapi-domain.rst for proof. Roll it
back and see what happens!


>
> > Disambiguation *will* be required from outside of the QAPI documentatio=
n
> > when referencing e.g. block-core definitions, which are shared between
> > QEMU QMP and the QEMU Storage Daemon. In that case, there are two
> > options:
> >
> > A: References can be made partially or fully explicit,
> >    e.g. `QMP:block-dirty-bitmap-add` will link to the QEMU version of
> >    the definition, while `QGA:block-dirty-bitmap-add` would link to the
> >    QGA version.
>
> Do you mean "QSD:"?
>

Haha! Yes, I suppose I did.


>
> > B: If all of the references in a document are intended to go to the sam=
e
> >    place, you can insert a "qapi:namespace:: QMP" directive to influenc=
e
> >    the fuzzy-searching for later references.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--00000000000056c732063039b810
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 13,=
 2025 at 2:47=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch does three things:<br>
&gt;<br>
&gt; 1. Record the current namespace context in pending_xrefs so it can be<=
br>
&gt;=C2=A0 =C2=A0 used for link resolution later,<br>
&gt; 2. Pass that recorded namespace context to find_obj() when resolving a=
<br>
&gt;=C2=A0 =C2=A0 reference, and<br>
&gt; 3. Wildly and completely rewrite find_obj().<br>
&gt;<br>
&gt; cross-reference support is expanded to tolerate the presence or absenc=
e<br>
&gt; of either namespace or module, and to cope with the presence or absenc=
e<br>
&gt; of contextual information for either.<br>
&gt;<br>
&gt; References now work like this:<br>
&gt;<br>
&gt; 1. If the explicit reference target is recorded in the domain&#39;s ob=
ject<br>
&gt;=C2=A0 =C2=A0 registry, we link to that target and stop looking. We do =
this lookup<br>
&gt;=C2=A0 =C2=A0 regardless of how fully qualified the target is, which al=
lows direct<br>
&gt;=C2=A0 =C2=A0 references to modules (which don&#39;t have a module comp=
onent to their<br>
&gt;=C2=A0 =C2=A0 names) or direct references to definitions that may or ma=
y not belong<br>
&gt;=C2=A0 =C2=A0 to a namespace or module.<br>
&gt;<br>
&gt; 2. If contextual information is available from qapi:namespace or<br>
&gt;=C2=A0 =C2=A0 qapi:module directives, try using those components to fin=
d a direct<br>
&gt;=C2=A0 =C2=A0 match to the implied target name.<br>
&gt;<br>
&gt; 3. If both prior lookups fail, generate a series of regular expression=
s<br>
&gt;=C2=A0 =C2=A0 looking for wildcard matches in order from most to least<=
br>
&gt;=C2=A0 =C2=A0 specific. Any explicitly provided components (namespace, =
module)<br>
&gt;=C2=A0 =C2=A0 *must* match exactly, but both contextual and entirely om=
itted<br>
&gt;=C2=A0 =C2=A0 components are allowed to differ from the search result. =
Note that if<br>
&gt;=C2=A0 =C2=A0 more than one result is found, Sphinx will emit a warning=
 (a build<br>
&gt;=C2=A0 =C2=A0 error for QEMU) and list all of the candidate references.=
<br>
&gt;<br>
&gt; The practical upshot is that in the large majority of cases, namespace=
<br>
&gt; and module information is not required when creating simple `reference=
s`<br>
&gt; to definitions from within the same context -- even when identical<br>
&gt; definitions exist in other contexts.<br>
<br>
Can you illustrate this this examples?<br></blockquote><div><br></div><div>=
do wha?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; Even when using simple `references` from elsewhere in the QEMU<br>
&gt; documentation manual, explicit namespace info is not required if there=
<br>
&gt; is only one definition by that name.<br>
<br>
Fails safely: if we add a second definition, doc generation errors out.<br>
Correct?<br></blockquote><div><br></div><div>Yes, see the disambiguation pa=
tch for qapi-domain.rst for proof. Roll it back and see what happens!</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Disambiguation *will* be required from outside of the QAPI documentati=
on<br>
&gt; when referencing e.g. block-core definitions, which are shared between=
<br>
&gt; QEMU QMP and the QEMU Storage Daemon. In that case, there are two<br>
&gt; options:<br>
&gt;<br>
&gt; A: References can be made partially or fully explicit,<br>
&gt;=C2=A0 =C2=A0 e.g. `QMP:block-dirty-bitmap-add` will link to the QEMU v=
ersion of<br>
&gt;=C2=A0 =C2=A0 the definition, while `QGA:block-dirty-bitmap-add` would =
link to the<br>
&gt;=C2=A0 =C2=A0 QGA version.<br>
<br>
Do you mean &quot;QSD:&quot;?<br></blockquote><div><br></div><div>Haha! Yes=
, I suppose I did.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
&gt; B: If all of the references in a document are intended to go to the sa=
me<br>
&gt;=C2=A0 =C2=A0 place, you can insert a &quot;qapi:namespace:: QMP&quot; =
directive to influence<br>
&gt;=C2=A0 =C2=A0 the fuzzy-searching for later references.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--00000000000056c732063039b810--


