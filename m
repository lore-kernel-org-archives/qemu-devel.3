Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2618C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk0yQ-0005gs-Ny; Wed, 15 Jul 2026 10:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wk0yP-0005gD-8U
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:52:33 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wk0yN-0004gk-D4
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:52:33 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15ea93028dso607107566b.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 07:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784127149; cv=none;
 d=google.com; s=arc-20260327;
 b=I4iyHlLCzld6mz5LAgLlXnp3w9dFTUp4CzVAEWTVm7/SInHddZq7ll5TnbsNU8mHNo
 8mOi1rlnUE16koDKki0zyISyRc13pI3wbYAazSL4Ec0NAOIgR1AWs/aOn/+BRc+qYDiP
 JlczZipYyzQfWtoEzbcmcMAZ+d4KoFTnGFgamT2rf4vEU4Iw3kkRoKc6AJHxuxCiQ9LV
 o8RHJT/nnt3pcweZ4kfHUha4Iidx5t97avVHZLTn8Ms1nNsrTtAYBw64ggY8ZCetELjI
 T+ZNH2y9ILOSykoE5F1EvQlOXEEyH9oB8J2RCEj/vshwO5IviaEM+USou0eRxM9ul1un
 bw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R+2YQ++tCGhGAsEB28VxBQ9eWCVQpQmGwfss64TAYYU=;
 fh=sCIo24Djn1JEp790PlTnHhwIS7zUfZNgDfxLqebqbxA=;
 b=H7khOFI06uBzer5xYcPrFRBSmT585sVcLjbQAoVyGAuZbaemc5WtGl1HOUqultBPSO
 tR8f1z9/i1gygWKuqWVgMeB3qKmIaJ1wuvdTz4MXXJ4SsubtRXQCV5ErXRDK7xB/RBp8
 gMbB1lpotD5be3itwATwT39O+G4zECbvIDghChgY+0h/vSv62Gg8d2IfTTQpd00s1otT
 asMTT+xYHLkatyPkhobsKQsEwxbGM/RUbfPNb84T1BHMuynMCkmGpopA1yQ480OcIb+u
 XBRrtgkIEXJnnBsOUAiktRAp41kaSwWPl1RKbSIfwa6mvk2woYJMG9BUJxG6PKSYzYSG
 mOUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784127149; x=1784731949; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R+2YQ++tCGhGAsEB28VxBQ9eWCVQpQmGwfss64TAYYU=;
 b=hmO4s707BU49p8sQXqAsNpktz+eELSkPpw3avbyYCuZLMk9BBNz2xfKXkhhRpsH5WL
 bJwYwsW7b5GPjv3ujaGycGufyZJPTb79oJGwcRwd+Q/tlFOXOzP/VEZsi6GalVFacdPh
 cqnrvdmmXtWm3lbylVnZp04c654r1Xf9AFOJu0JrgCbaZEEM806hjli5fpBnvfJ4rmqG
 +03RglQIS44BSIg5n4eP4yB+OFb53xnSK5u1tThkm/cl9/DCwAoCftJ9IOsitR74v7NS
 tu70ksTYaH7kY8SDiQ7vfW7d5aXfiE/Jg9+j2szmP6Fnw8BM27amQF3QlZA6+3Qxu6zD
 R4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784127149; x=1784731949;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R+2YQ++tCGhGAsEB28VxBQ9eWCVQpQmGwfss64TAYYU=;
 b=RHWiNWQNCFRTftnQ1HJZSkoVVvXJEHJ/FPA6bGIBo2h8qQbD7hV2uch7mgjql4DqR1
 I8YnVyUf1RaNnYOlTgruHWaM4h9Jo041rAg0pX9Itk8HlEj0lLgkx3K0gfKmjtSrSm+q
 pukEYNwZ/5MLUMjBy+CoVcJu8O+fyiwZDMJ2RU5brong54z6BchGQHIlUOuSExVojS6f
 iYvm1KpttknmAw5oKXjboDw2zYy+UNnkgkcMvW43UwJWWSrN4NcafM0nwsgXhhCs4OZe
 fy2kpd0YOPcIQwCqbdOQDoEUUm3APvffFluO4LAIr60qljzeLm/ytKc85fN0dLVDSjbZ
 tQEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RopvBaBy9ukMve22h6vAfl68jq83TQix2Xw3r5KHMTIveSFouOCdLf9DW/MMhMR5gQTvaN+uALwnmu3@nongnu.org
X-Gm-Message-State: AOJu0YwCzZwNdSqGRh4QxqCf6eNo9GiaFDhPNGxW6Dg7RIlEXJH2+mr8
 pUXs3ORXk/CN/zh35UZjceffZy+2+JvVZM2mQEHI9UbKxOAJZV1foSmwB3KIXshWlvr0s6jLo/Z
 M9MSvtt8nIfKPPXGAFACWMcztiAu8T/Q=
X-Gm-Gg: AfdE7cmaAAWjRz97eawZ2VEpBXnYSKVdAm47Ya/g2fUiixadpVVSQqwrLMMEaZ6PzZC
 T6l2St/9GqWBdJzax/mLDdB9eP+CSUaBtbvoF5S7GBEfaaRu52Kyaa3Gj1bzgdXtEbuo83HynaM
 9x5hrcGoSHpXYc4/E7Syisapt7OPZRlOQHBOvexRC1hRqJyjrJZc719lFjtp8a2WWlf+kYACRbP
 7y4JpA+EMlzds3QhqfF3m8raIxnsP1k+552g5ZZvRYGK+5YcN3wTuehwBxiuiUWNuwdPKCdUWTf
 +EVbUZo=
X-Received: by 2002:a17:907:7292:b0:c16:29eb:e84a with SMTP id
 a640c23a62f3a-c1667b8bfdemr456014366b.53.1784127148911; Wed, 15 Jul 2026
 07:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260714164745.573141-1-shivangu@linux.ibm.com>
 <87pl0ob9l1.fsf@vajain21.in.ibm.com>
In-Reply-To: <87pl0ob9l1.fsf@vajain21.in.ibm.com>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Wed, 15 Jul 2026 20:22:15 +0530
X-Gm-Features: AUfX_mzCV-wvqmZvRelqULvxj7v5cBZKEeqHb2LRPgPz1obtzt0nwA1A-rtBKfg
Message-ID: <CAEuJdmrKCJs_acaeJUu=WNif_hHnq1N5yikgiu7GoBcWjnxLTA@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/ppc: reorg PowerPC RAS code for better
 maintainability
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, hbathini@linux.ibm.com, sourabhjain@linux.ibm.com, 
 Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, rathc@linux.ibm.com, 
 Nicholas Piggin <npiggin@gmail.com>, mahesh@linux.ibm.com
Content-Type: multipart/alternative; boundary="000000000000f1f07e0656a778d0"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000f1f07e0656a778d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jul, 2026, 8:10=E2=80=AFpm Vaibhav Jain, <vaibhav@linux.ibm.com>=
 wrote:

> Hi Shivang,
>
> Thanks for the patches. My review comments below:
>
> Shivang Upadhyay <shivangu@linux.ibm.com> writes:
>
> > Extracting RAS related code from spapr_rtas.c, to a newly created
> spapr_rtas_ras.c
> > and carving out a MAINTAINERS entry dedicated to PowerPC RAS. This will
> cover RAS
> > related functionalities for PowerPC platforms.
> For a refactor-only change, this patch is adding 44 new lines to the
> codebase which feels a bit heavy.
>
> Just moving code from one file to a new file will reset the git blame
> history of the code making future reviews difficult.
>
> Such movement also makes code optimization difficult for compiler.
>
> IMHO such code movement should only be done when:
>
> * Its accompanied with patches for adding or fixing a functionality.
> Or
> * It clearly improves performance
> Or
> * Results in significant reduction in LOC
>
> Since these patches doesnt seem to fit to any of the above criteria I
> suggest you to reconsider these patches.


I think the goal here is to ensure right people get notified to review RAS
related code changes. Other option would be to keep entire spapr_rtas.c
file listed under RAS and let it have non RAS related code also and do the
split later when it's bloated enough to be considered for split. Open to
suggestions.

Aditya, Sourabh, thoughts?


>
> >
> > Also adding myself as a reviewer, to help share the review workload.
> >
> Thanks for volunteering as a reviwer for this code. Having more help
> with reviews is always good :-)
>
> > Shivang Upadhyay (3):
> >   hw/ppc: move RAS-specific RTAS handlers to spapr_rtas_ras.c
> >   MAINTAINERS: add dedicated PowerPC RAS section
> >   MAINTAINERS: add self as reviewer for PowerPC RAS
> >
> >  MAINTAINERS             |  33 +++---
> >  hw/ppc/meson.build      |   1 +
> >  hw/ppc/spapr_rtas.c     | 189 --------------------------------
> >  hw/ppc/spapr_rtas_ras.c | 232 ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 249 insertions(+), 206 deletions(-)
> >  create mode 100644 hw/ppc/spapr_rtas_ras.c
> >
> > --
> > 2.54.0
> >
> >
>
> --
> Cheers
> ~ Vaibhav
>
>

--000000000000f1f07e0656a778d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 15 Jul, 2026, 8:10=E2=80=
=AFpm Vaibhav Jain, &lt;<a href=3D"mailto:vaibhav@linux.ibm.com">vaibhav@li=
nux.ibm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Shiva=
ng,<br>
<br>
Thanks for the patches. My review comments below:<br>
<br>
Shivang Upadhyay &lt;<a href=3D"mailto:shivangu@linux.ibm.com" target=3D"_b=
lank" rel=3D"noreferrer">shivangu@linux.ibm.com</a>&gt; writes:<br>
<br>
&gt; Extracting RAS related code from spapr_rtas.c, to a newly created spap=
r_rtas_ras.c<br>
&gt; and carving out a MAINTAINERS entry dedicated to PowerPC RAS. This wil=
l cover RAS<br>
&gt; related functionalities for PowerPC platforms.<br>
For a refactor-only change, this patch is adding 44 new lines to the<br>
codebase which feels a bit heavy.<br>
<br>
Just moving code from one file to a new file will reset the git blame<br>
history of the code making future reviews difficult.<br>
<br>
Such movement also makes code optimization difficult for compiler.<br>
<br>
IMHO such code movement should only be done when:<br>
<br>
* Its accompanied with patches for adding or fixing a functionality.<br>
Or<br>
* It clearly improves performance<br>
Or<br>
* Results in significant reduction in LOC<br>
<br>
Since these patches doesnt seem to fit to any of the above criteria I<br>
suggest you to reconsider these patches.</blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I think the goal here is to ensure ri=
ght people get notified to review RAS related code changes. Other option wo=
uld be to keep entire spapr_rtas.c file listed under RAS and let it have no=
n RAS related code also and do the split later when it&#39;s bloated enough=
 to be considered for split. Open to suggestions.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Aditya, Sourabh, thoughts?</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_containe=
r"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"> <br>
<br>
&gt;<br>
&gt; Also adding myself as a reviewer, to help share the review workload.<b=
r>
&gt;<br>
Thanks for volunteering as a reviwer for this code. Having more help<br>
with reviews is always good :-)<br>
<br>
&gt; Shivang Upadhyay (3):<br>
&gt;=C2=A0 =C2=A0hw/ppc: move RAS-specific RTAS handlers to spapr_rtas_ras.=
c<br>
&gt;=C2=A0 =C2=A0MAINTAINERS: add dedicated PowerPC RAS section<br>
&gt;=C2=A0 =C2=A0MAINTAINERS: add self as reviewer for PowerPC RAS<br>
&gt;<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 33 +++---<br>
&gt;=C2=A0 hw/ppc/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/ppc/spapr_rtas.c=C2=A0 =C2=A0 =C2=A0| 189 -------------------=
-------------<br>
&gt;=C2=A0 hw/ppc/spapr_rtas_ras.c | 232 ++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 4 files changed, 249 insertions(+), 206 deletions(-)<br>
&gt;=C2=A0 create mode 100644 hw/ppc/spapr_rtas_ras.c<br>
&gt;<br>
&gt; -- <br>
&gt; 2.54.0<br>
&gt;<br>
&gt;<br>
<br>
-- <br>
Cheers<br>
~ Vaibhav<br>
<br>
</blockquote></div></div></div>

--000000000000f1f07e0656a778d0--

