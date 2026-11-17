Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75975606A32F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LmZNddka;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pDAc6taG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTRZx-0007Dv-83; Tue, 17 Nov 2026 17:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTRZu-0007DZ-O6
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:23:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTRZt-00010w-1p
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794954180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jGSAg6DP6Vg4hB6rwKltP9RAf8Gg9HCjF2XVY2DfHaM=;
 b=LmZNddkajPgeGC6T5kzaRqDo1K1cCTvPzOPQ7KQoCRMeSJh18RY/TLL/svGdaJ9iqp20oX
 cyw/4gL8PRD1UQk6b4E02ZnBWtkjkBRxtLydSMKiR3XqeiqwkTCXoL+AQoaSPp58hv2g5C
 wWHo1oImJct87fsx6EF6nT0dcBiOgHU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-9hYV1x31OaKpiaTcOSbC2g-1; Tue, 17 Nov 2026 17:22:58 -0500
X-MC-Unique: 9hYV1x31OaKpiaTcOSbC2g-1
X-Mimecast-MFC-AGG-ID: 9hYV1x31OaKpiaTcOSbC2g_1794954177
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ed00709df0so2294095ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 14:22:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794954177; cv=none;
 d=google.com; s=arc-20260327;
 b=DVRFH6Sae3NBpOqcg9pYAGPO3bZn607sXK8ZPfUlGCGX8QGcFTjo+AbqXPAcR4EkG+
 FBuRQxrPGs8cfpFm2eLeLPdRHSliSBozMW2qob73R337LNIMWaOhUxcyfuv2ReTex2hw
 ayWGp7iAQudwDiiLx3ARk1XsyZaSjzHSKkrXM0ju1SeS2B0iirwq/IiktqCiAvku1pAt
 siJiEmaWHnhsE/KcXMIeMuDUlLRJPtcrheQ+xrLyekedW7ce85qTMQyKeJzQ9uk1U1Hm
 kAXQpxeoF0E5UwZDvmjNQcElErewgsXwKgJTwOlIy7oJpFauH4DjieoDUD7a8Qp3s9hJ
 q8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jGSAg6DP6Vg4hB6rwKltP9RAf8Gg9HCjF2XVY2DfHaM=;
 fh=dpKlZqbEfwv6Q3J7wk4pErGlPLtOAN+Y4NlkIMw7/3A=;
 b=U2ncHoysBm+j2a0hiTzcSy5jnLmKDGV+7NIk7OEbHtes5ZSv9lrSY6dcnJcTp+J9+s
 M5AJ5yORtDmpR5E3cZAJgKJvcGWbX9WFMGEgchxnUb5rGBdpSjGZitApmO505WE3YGNb
 fyvDI5u6u96mllB+/sBEr9SMiRdU/eSB+RrBPIiOmDDaIKeYh09ME9zOF51pHrytR6YL
 ShwVLbTViG2Dqni8gRt0uINLriEkrdpUolCP35m4yWo1QkEoyWODVfGXOKRGUMB99A/p
 IGUJVaSheNc/0sBlfmpFB24VcasMl1NLjSIy0piYgLkUVPJK+5PhixjGCFwQ9NyINPCU
 juqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794954177; x=1795558977; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jGSAg6DP6Vg4hB6rwKltP9RAf8Gg9HCjF2XVY2DfHaM=;
 b=pDAc6taGupbX0JF/p3EKP0je52tXOYD4IKi2Qc1bADkyukG6tZo29eG1ShpOtVvTfq
 Gy7uoYXHkWsJUGc/Tx37QaY85ofnAY16ks2OcJ5TKDZE62/8xp/AWyxYbNxWnfN9zo0n
 a75h2wieQdNMUPHxsalPHO7YWBYvO1MW7H5bXR7oYrpiczjwsAIBkMGLW7vVQ50AyZXN
 GGwUTDQwYNZNdJuR+d9uuwC3gU//1VEDWs1cT2EQr4klvH75IXPik/z4S2s15uCjx0yR
 UA80Q3N0FTXfQbvxDTkklt7LVwj/Vd0swcPSIZeCX/z2Qii2yGssbVKO227KAPbastkE
 t8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794954177; x=1795558977;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jGSAg6DP6Vg4hB6rwKltP9RAf8Gg9HCjF2XVY2DfHaM=;
 b=VBMx9UlBGvX/m7tff+gPGxBDT7zbknBFfKl6n26XZztMYL19RvB4wdXSpuK/tL/QIw
 e6Rp8my7PsrLJdhwawibufRJBc5vwazWCq9U2FTBHYx6m6aW0DDV/SmCbBnkbRgmpqRg
 LQc0Mtphwdpw33Y1ReaWXJcuUGM3VLD41jqxbcjVbyVIJjMSSxZ/AxiHT35hhwhjPYWk
 GRIBGpQYExH+WrKH+jWhK+6PApurD067LnIiChXEZFiUdGIi1LLG+NT5MGzse5Y8+2ry
 HH249azlTs6Cg9nyj3EgHlFpuMy9a9aBW2KywyIMlRKU/xCx/R34ug6a5GXkeRKKT28P
 PlFQ==
X-Gm-Message-State: APuU4Z9oV4raHkpH6yW955IYR/gGklkXPivkAU/5rgRqYqqgY8a+x0sz
 PT98m+X6E7FD5IzKJPFqMTWaora8t3aSYVXHBg0rhNFe9IInMDosI8WdcJ6EOimXjKTpOyp96Nd
 IU2taWTY9Cn8psTk14H1sA1vJdqCXfPZhOlEvqgky6x+Alljl5BWJVeKl1sMoKrY2YuEZGTnBLb
 RKJd2s2xxo/ZwBUtm/U0c1ogC43c0jmd4=
X-Gm-Gg: AZFdTZfsDvd+qxSJMtHI056eQ37r4ElBBx5tLHPAtXu/QwKLtaTUQ3REMCEAOZQD/ne
 OZqq5FfMkqDCpXBwqqFZncMMmU3nj/c3iWOw6xH9CgzDHCX0VXeqhFfvA/LSPNNpqEIa5k3m/Y6
 7iGeJifcUBjjuITUn3dhNsA1YpuKsX5zYVxskXPr7Dp6bxjdCLfS5hDmOpd22dTxni1UTMD8uSK
 24f6zBPbd2ZFMSMNQu6iH4UmJQqbPMKyJQ91YXGc5v8YotwxqC6CHOZGgMz
X-Received: by 2002:a17:90b:4d82:b0:3b0:9f53:e8a8 with SMTP id
 98e67ed59e1d1-3b3d07c9e1bmr733148a91.52.1794954177223; 
 Tue, 17 Nov 2026 14:22:57 -0800 (PST)
X-Received: by 2002:a17:90b:4d82:b0:3b0:9f53:e8a8 with SMTP id
 98e67ed59e1d1-3b3d07c9e1bmr733119a91.52.1794954176607; Tue, 17 Nov 2026
 14:22:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <87o6btvzef.fsf@pond.sub.org>
In-Reply-To: <87o6btvzef.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Nov 2026 23:22:45 +0100
X-Gm-Features: AclHuK8AlZWsfc4Qdrz3po7X20PpIkLRqK62BbuUrHech4jt7Mk7ThbBV7DoCzU
Message-ID: <CABgObfZ3wZ2x1mNL7rY8FdYFdfWnyJ6kXwz4vdeBn7x2VOVzyw@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000015ce7106608056af"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
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

--00000000000015ce7106608056af
Content-Type: text/plain; charset="UTF-8"

Il ven 13 nov 2026, 10:44 Markus Armbruster <armbru@redhat.com> ha scritto:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> [...]
>
> > +LLM-assisted and LLM-created contributions
> > +''''''''''''''''''''''''''''''''''''''''''
> > +
> > +Use of generative AI can be classified in the following four buckets:
> > +
> > +- "background" assistance, such as completion and code review.  This
> does
> > +  not need disclosure.
> > +
> > +- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of
> code)
> > +  are allowed with disclosure.  Splitting a submission in multiple parts
> > +  is **not** a valid way to bypass this rule; repeated, frequent posting
> > +  of such fixes must follow the rule for full contributions.
> > +
> > +- use of LLMs to help generating parts of a larger patch---test cases,
> > +  adaptations of existing code, boilerplate code for a new API, a tool
> to
> > +  help performing mechanical changes, etc.  These are generally allowed;
> > +  disclosure is highly recommended for non-trivial, functional code.
>
> Why only recommended?  It's non-trival!
>
> Disclosure isn't much of a burden.  Why not keep things simple and
> demand disclosure, no ifs, buts, or maybes?
>

Sure.

Paolo

--00000000000015ce7106608056af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 13 nov 2026, 10:44 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
[...]<br>
<br>
&gt; +LLM-assisted and LLM-created contributions<br>
&gt; +&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
&gt; +<br>
&gt; +Use of generative AI can be classified in the following four buckets:=
<br>
&gt; +<br>
&gt; +- &quot;background&quot; assistance, such as completion and code revi=
ew.=C2=A0 This does<br>
&gt; +=C2=A0 not need disclosure.<br>
&gt; +<br>
&gt; +- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of =
code)<br>
&gt; +=C2=A0 are allowed with disclosure.=C2=A0 Splitting a submission in m=
ultiple parts<br>
&gt; +=C2=A0 is **not** a valid way to bypass this rule; repeated, frequent=
 posting<br>
&gt; +=C2=A0 of such fixes must follow the rule for full contributions.<br>
&gt; +<br>
&gt; +- use of LLMs to help generating parts of a larger patch---test cases=
,<br>
&gt; +=C2=A0 adaptations of existing code, boilerplate code for a new API, =
a tool to<br>
&gt; +=C2=A0 help performing mechanical changes, etc.=C2=A0 These are gener=
ally allowed;<br>
&gt; +=C2=A0 disclosure is highly recommended for non-trivial, functional c=
ode.<br>
<br>
Why only recommended?=C2=A0 It&#39;s non-trival!<br>
<br>
Disclosure isn&#39;t much of a burden.=C2=A0 Why not keep things simple and=
<br>
demand disclosure, no ifs, buts, or maybes?<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Sure.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Paolo</div></div>

--00000000000015ce7106608056af--


