Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA3606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HnkamM/2;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UXNrI1Kk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTRXN-0006eI-2R; Tue, 17 Nov 2026 17:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTRXJ-0006e1-Ue
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:20:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTRXH-0004Gp-Q5
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794954017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g9PQH4KKti6z1ts5h6HzRA3ty1ymDjx+Qpy8bx9iSvk=;
 b=HnkamM/2yd7WZ1HfaxviXJn0M7tH2IjprRghhQwRXn4z2VCpa/+phcfwaq3e5Wn+jVgfnS
 DTEOlq2Pk79+XZMGwnyq0d8lQbZhdipbrCuEmeBN73jWhCITe63AaVdLnxSvJ0BAMhkUv1
 RBNf22uqMsneustDtZKZQczTprR1Ak8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-qils322CNve3Q4l_TLhE7g-1; Tue, 17 Nov 2026 17:20:15 -0500
X-MC-Unique: qils322CNve3Q4l_TLhE7g-1
X-Mimecast-MFC-AGG-ID: qils322CNve3Q4l_TLhE7g_1794954015
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b07b06027eso227935a91.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 14:20:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794954015; cv=none;
 d=google.com; s=arc-20260327;
 b=dGYCDlw5C9S6PRrmKM6LX36oSmJnJeQJP9jBo9pFfQjlxkTp0ASQbaeiVW8U+XQVs+
 KwjNu9KZ3qfzj6cxEZPNiUz9PEQX340v97z+E5XNID1te+vOzaP3L6gBHUqgzHqDUibD
 1c+LdxQ9aTZQjKmrQmAbI6gG9w9TaiVAdNj2bP39l9QpbWYDxnEWsyjT8it1YxZITG92
 xFohU1i8K4z6gnHMweUwq0EvYhGk5+fa3maJXMYMjiVNnRd1NoOTLCpAAaQNIWH5UTXf
 dRnTF4qsdh54mircSnX4CFMUiVjwl+6XE1lB2y0zMoRnhRG9TolQFY3+PZ0Eja8dQm8b
 2A5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g9PQH4KKti6z1ts5h6HzRA3ty1ymDjx+Qpy8bx9iSvk=;
 fh=76TU5MhT1Jpc0G7hPEBHsvlWIBJ0lFNhuD3bHBPq8bI=;
 b=e5VXJFnj2GpeyMqm28BnaWBD3oYCyNzcqZpSMa9AU2s04T+BfeogxH3Jk9XpBtbkJV
 BA5/vhrUUmPVhIqaiWf58ka6v9W3ZrbCQ5ra2Pf1kGf7f+XqD8zMIHR/yksK1T32oqUp
 fdZMaOMWfe/tHTg15bWAVxzGhT9d2pGFGwS5135LrL6i3zdDMnoG3PrYehBSuXWPSMon
 tDPqyRcs81wfWITEQmfiwIPU98VKiN9Sr54D4rjffo8T0c5mzQjqRaF3/RCLCUqCDvxO
 DnC1RHMEXNy1iFffhgmvsao28hcNXQ31mb9EWzj+3OGhGYqx+mPzqyJs+tOMYjaaZNI+
 Fr+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794954015; x=1795558815; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g9PQH4KKti6z1ts5h6HzRA3ty1ymDjx+Qpy8bx9iSvk=;
 b=UXNrI1Kk0/f3vx+qPxN+fMEiwQrL8GCaupkpQyXvGpMuDQwFk+JiJE12ZGD3HED8mv
 yR8pj2ZekjP4+dHnM2fvbhi020JEkjgaMFjEd5SFI0KTMfSZ8Qe5npjUkxM0Ozh+Vegl
 5/9A2jsPOdemslwOoXm0FV5aOy/DafSnOUb8maoG5ERDH6KPqhu42qfrNTBTi2zEXoA0
 BY2qXd17hhWsJz123RGbz5Bq+B3q3j0TaPQ9fv4ccCtjYiIuNN3VNJqOUn101gzkdqbx
 MsWV2xu9T8uTx2dUFL6vhIT8ZLkitMj7Z+b2xZnsv8MCkH/51ireZP0JnGwA+IqZCJlq
 rkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794954015; x=1795558815;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g9PQH4KKti6z1ts5h6HzRA3ty1ymDjx+Qpy8bx9iSvk=;
 b=obt9lw3C3UQOjBCpTuXbHNdaf6bepXwoR95wfFNROtDMBZxs3wBcU9UwDX95DUsy2w
 +1MpixrCtlQlhqR9wMq61J+fjgnepU2HEiN2rsLA10AsdRW9dQ4aicPig4PwIHZzPlfV
 dXi9tcFwESs9pWRVslagrMSDBLBAd6gGzIkL2ODjsY3EqGb7CVT7FrYBakV1WgJWVCOr
 5BEoc6A8DFpHkpmjtbiC/QkZYzfEczxKgkDeBIOk7zcE8SrqwB46LkKR7oxu4NhbmoGZ
 b23KnMicjBtelK8+OzFRNkZxQYr03LiEh/xWFz2AKO2+xVqszBDCFqfhtFw/jADo6Iqt
 a6+g==
X-Forwarded-Encrypted: i=1;
 AL+hErHuONwqztyAQktUk/EftG2/4bpk7txqTrxxxv9wOP05LNyvJU8A/+uj+fhluojPUFKinRA+bD0pGJl9@nongnu.org
X-Gm-Message-State: APuU4Z8S8cCI7IymcxSArCNhyI2SFj9kDBhrbNluZV+QsDyp+cdROIfq
 Yj2I9rwc6Gmcyp9Yk139MueJRkzOvzvKiutvVcPqOxrl54kZ4+gwAYbPorCritf4+kzMqLyx3d6
 up2ieXehlgvwHOMcaD8rvZna2VsqR3h0ZEibeqHeIIoz4qLBXIzc9KxAg/cmmm7yqb19xT86p61
 Dho2NC63tp/SFsEuzp+Zs4FR3WMu2vEm1lFvpPcXs=
X-Gm-Gg: AZFdTZcNDyZtD7KSTefhv9LASHo38U8d7vekWoTLOKPbq8Cp6K+a1FBNMgkXmnrWxew
 fGdHy1xRiFpTCpjU+9xK2CtZPjIFxwHcFG2+zk/QiAcUF+s+hEjzF+KMlCX7zPXor+kGHD4xYYW
 w+Qqbptu1JDqL6ZrFKBq7RkElGb482eMphswbWO4gXYFhCqHXyixq/D2JX3WKl+hHjrlMlC+rJo
 p8/nR5//FSomI/j/zHJ+6G65KnkWe2pCP369273lb/CG4+DkJuaUC4092iL
X-Received: by 2002:a17:90b:3b48:b0:3ac:9669:846b with SMTP id
 98e67ed59e1d1-3b3d06417b9mr802363a91.9.1794954014745; 
 Tue, 17 Nov 2026 14:20:14 -0800 (PST)
X-Received: by 2002:a17:90b:3b48:b0:3ac:9669:846b with SMTP id
 98e67ed59e1d1-3b3d06417b9mr802345a91.9.1794954014346; Tue, 17 Nov 2026
 14:20:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <avy4mkin-orpwskO@redhat.com> <avzDYfG-cPiWaCZ6@redhat.com>
 <CAFEAcA87cvgsjGu3-y_7h5dB2HyA2tzKOW8WmBxvoi7zdp9Oyg@mail.gmail.com>
In-Reply-To: <CAFEAcA87cvgsjGu3-y_7h5dB2HyA2tzKOW8WmBxvoi7zdp9Oyg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Nov 2026 23:20:02 +0100
X-Gm-Features: Aa3M54op2oKYdpsIIyGcgmPtvmsUUf3rVO0IFc2J5dJDkX4ThyRe-mYk2U67JgE
Message-ID: <CABgObfbBjLmAJ2eqQjJQw9aQfioV-xY+k9xrDTOemc95uyMchw@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000069eb9e0660804c78"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000069eb9e0660804c78
Content-Type: text/plain; charset="UTF-8"

Il mar 17 nov 2026, 22:31 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> > > I see lots of discussion about whether to stop here (and s/four/three/
> > > above), and leaving off the fourth bullet (or splitting it to a
> > > separate patch for later) appeals to me personally. But I can also go
> > > along with the final bullet if that is what the consensus lands on.
> >
> > If the consensus is that the legal arguments for the current policy
> > aren't relevant any more, I'd like to have some policy update merged
> > rather sooner than later. Without this concern, I think I'm mostly in
> > the "it's just a tool" camp.
> >
> > I don't mind the fourth point and don't expect practical problems from
> > it, but if some people do have concerns that would take months to
> > resolve, I'd prefer to do without it for now and allow at least the
> > uncontentious cases without waiting.
>
> Yes, I would rather we accepted the uncontentious cases and then
> had the discussion about the one where it's less clear we have
> consensus, than that we hold all the changes up until we get
> agreement on all four points. "Push for all four" has got us mostly
> "no change" so far.
>

I don't think this is the case - there has been discussion on all four
points and I hoped to have a little more discussion at KVM Forum, so I
didn't even think of sending a PR until now.

Dropping #4 is totally fine by me. That said, if we are worried about the
quantity of incoming patches #4 is actually the least of my worries, and I
would like to understand a possible way forward for it.

I know personally of at least four uses of AI for large contributions to
QEMU that people have experimented with or plan to submit:
- the QOM cleanups by Alex (posted, RFC, mostly refactoring)
- the Nitro Sandbox accelerator (mature, mostly new code)
- Windows VBS enablement (just started)
- a textual description of x86 instructions for use with the TCG front end
(mature, new build time code + changes to existing code)

The first one touches all subsystems, whereas the others are confined to
i386. The last one is by me, though done in my personal capacity and not
for (or paid by) my employer.

Perhaps I can post my TCG work so that we work out in the open what these
contributions might look like, with a practical example? If people agree,
it could be the Nitro Sandbox work alternatively.

I think we definitely should have that community-call discussion
> on the AI policy so we can see where we are collectively. I also
> don't think we particularly need to tie our policy updates to the
> release schedule: it's just a documentation change.
>

Agreed on both points.

Before the next call, possibly already tomorrow, I will post the next
version of the policy with the final wordsmithing and #4 removed. I will
also post the first (and bigger) half of my TCG work if people think it
could be beneficial.

Paolo

--00000000000069eb9e0660804c78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 17 nov 2026, 22:31 Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
&gt; &gt; I see lots of discussion about whether to stop here (and s/four/t=
hree/<br>
&gt; &gt; above), and leaving off the fourth bullet (or splitting it to a<b=
r>
&gt; &gt; separate patch for later) appeals to me personally. But I can als=
o go<br>
&gt; &gt; along with the final bullet if that is what the consensus lands o=
n.<br>
&gt;<br>
&gt; If the consensus is that the legal arguments for the current policy<br=
>
&gt; aren&#39;t relevant any more, I&#39;d like to have some policy update =
merged<br>
&gt; rather sooner than later. Without this concern, I think I&#39;m mostly=
 in<br>
&gt; the &quot;it&#39;s just a tool&quot; camp.<br>
&gt;<br>
&gt; I don&#39;t mind the fourth point and don&#39;t expect practical probl=
ems from<br>
&gt; it, but if some people do have concerns that would take months to<br>
&gt; resolve, I&#39;d prefer to do without it for now and allow at least th=
e<br>
&gt; uncontentious cases without waiting.<br>
<br>
Yes, I would rather we accepted the uncontentious cases and then<br>
had the discussion about the one where it&#39;s less clear we have<br>
consensus, than that we hold all the changes up until we get<br>
agreement on all four points. &quot;Push for all four&quot; has got us most=
ly<br>
&quot;no change&quot; so far.<br></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">I don&#39;t think this is the case - there has=
 been discussion on all four points and I hoped to have a little more discu=
ssion at KVM Forum, so I didn&#39;t even think of sending a PR until now.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Dropping #4 is totally fi=
ne by me. That said, if we are worried about the quantity of incoming patch=
es #4 is actually the least of my worries, and I would like to understand a=
 possible way forward for it.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">I know personally of at least four uses of AI for large contributions=
 to QEMU that people have experimented with or plan to submit:</div><div di=
r=3D"auto">- the QOM cleanups by Alex (posted, RFC, mostly refactoring)</di=
v><div dir=3D"auto">- the Nitro Sandbox accelerator (mature, mostly new cod=
e)</div><div dir=3D"auto">- Windows VBS enablement (just started)</div><div=
 dir=3D"auto">- a textual description of x86 instructions for use with the =
TCG front end (mature, new build time code + changes to existing code)</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">The first one touches all su=
bsystems, whereas the others are confined to i386. The last one is by me, t=
hough done in my personal capacity and not for (or paid by) my employer.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Perhaps I can post my TCG =
work so that we work out in the open what these contributions might look li=
ke, with a practical example? If people agree, it could be the Nitro Sandbo=
x work alternatively.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">I think we definitely should have that community-call=
 discussion<br>
on the AI policy so we can see where we are collectively. I also<br>
don&#39;t think we particularly need to tie our policy updates to the<br>
release schedule: it&#39;s just a documentation change.<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">Agreed on both point=
s.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Before the next call,=
 possibly already tomorrow, I will post the next version of the policy with=
 the final wordsmithing and #4 removed. I will also post the first (and big=
ger) half of my TCG work if people think it could be beneficial.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--00000000000069eb9e0660804c78--


