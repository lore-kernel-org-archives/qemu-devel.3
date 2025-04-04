Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591E1C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 15:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0j5Z-0001Wj-LO; Fri, 04 Apr 2025 11:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <valentin.david@canonical.com>)
 id 1u0idR-00024A-BZ
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:07:09 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <valentin.david@canonical.com>)
 id 1u0idP-0001LQ-B8
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:07:09 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3D76D3F2C4
 for <qemu-devel@nongnu.org>; Fri,  4 Apr 2025 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743779221;
 bh=mftRCynS2LvbmOjNsQZYyhZIAEsQ/98pyWapsGwegVA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=b/PU80SspG1Xz4cLk37I8Frq03ld5r/URgnzURIzh6FkrsVNYKAQw1/iIVu9dNVN/
 KWFP7/qUvfYqSS98NnAdGf8uXX147kGUBJS33q+H28doRKbPMmhc5baOpV4L5dmQ2Q
 q2BsySDL/v3Xi8wJYgUwhoxj/5WbAPuRz41LR36Bee5C8L1YdjksNUHhzAZRqlUHZ6
 uLfA6pGwtdRqQPmcsksBJ2hDm528g84iQ9O8piMPLwsB7G0Wa0+GD+ZXD2Id7G2LGf
 J2y++Fb0qSzhoGpjgJF7h4pAgvH83Cqxq8Zgz7OKxtMEeniamA/qcWnmiOH+NPn91P
 iqgSt/t1dUY7g==
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff58318acaso3502402a91.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 08:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743779216; x=1744384016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mftRCynS2LvbmOjNsQZYyhZIAEsQ/98pyWapsGwegVA=;
 b=FUt15IlTrAwYmIYMjvCy2x4ILrYhSt2XDyQkxYUSKFx1tBKv9RdncenoUXO2s4XQub
 ELw6LSElmN2ZUQIPZPo5Px4m7W+Fi2HvvFZ6oDNFz5/6mG+L/ndthYd809DiPEKfZp3C
 3orT7y1NXhDiOphfaEqySt8AVnLoUCnRxf5EvK4tgD11T7tczcPMZnGZBDrxLick5+r+
 b57swm60H0VhTe0Wdv259KqmYmj1TGTeLpEAZ5yoZJo8UJliHjTiUwklCqTwoBE5wGI1
 LYnE0NpXgT+JRgif5tFP8Ho0ON+erzaCy3KGy2RX/JlTk0ll6ELZzQAR7kqItvX3TWb7
 d16g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV79VMUzFtGHTXSFFBwC1pe4Mg/+86y4nqH6YyLG4t6Pp2XPfgtmDIzgr8uIA30aRyNPCU2BPyUVzNg@nongnu.org
X-Gm-Message-State: AOJu0YyKPOWWenleMs6341PzyKR6qU4JBXkzt+nn/7fJZKpfX8uk2m47
 uGGXzbAgrTWGqkEtBqw/fD5f04eRlF1LVsGVA+vcUO3bathswnHXC4Rjx2lLroFrIN6Gn/KqsQA
 sYcwyxUzchskeElPYaUUaGjAXgxOedrsgGR6W7qC/Hz+IvrsDOHAU6cJqz1pdkx1OMkhocwmcej
 gHT3MMr9Fv0bWjzeleBqhVeEkHvdkK4cP76vhEa2oYuuA=
X-Gm-Gg: ASbGncuBtkcUSq4gHokDW6R1d8TR3MBDoQ9ccEYDrD6Ut9U1TqBJu4ttMrLUsxzjYJ7
 h5SZLauTjTXtkIHnnqFbS6YyM1Mc1ybc1QP03odk35HVvx40PauR8s3cF1zTml8ajHUIXEZ2HWY
 sJirX4B2rQ
X-Received: by 2002:a17:90b:5184:b0:2ff:64c3:3bd4 with SMTP id
 98e67ed59e1d1-306a6290627mr3803396a91.31.1743779216579; 
 Fri, 04 Apr 2025 08:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHutPvsAtyjxiezUeciQ0W641XpR9iW22SMNPMKCQwBGF9mI8aCzWJFGdpVbRpFuaKjruRHVZZV/PymIh1wUGs=
X-Received: by 2002:a17:90b:5184:b0:2ff:64c3:3bd4 with SMTP id
 98e67ed59e1d1-306a6290627mr3803381a91.31.1743779216315; Fri, 04 Apr 2025
 08:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
 <CAO8sHckT2Ko8TTJjzUsX0znafaL_4jp97QCtSxoZDnHow0bEAQ@mail.gmail.com>
 <aabb0497-016a-4cdf-9098-dbbaa92b781d@linaro.org>
 <CAK00H8NhzV6ZDr1Kisr2_GUr0b-7W+FKgekQOF_iD61-J1mh5w@mail.gmail.com>
 <295e5a6f-9edf-4a0d-844f-f5209de99bfd@linaro.org>
In-Reply-To: <295e5a6f-9edf-4a0d-844f-f5209de99bfd@linaro.org>
From: Valentin David <valentin.david@canonical.com>
Date: Fri, 4 Apr 2025 17:06:43 +0200
X-Gm-Features: AQ5f1JqPtteUEC29CsXr8S2hULKH3WZ48wpBhICRXmvqsYjGDwWZ4GJ-8Bj51yE
Message-ID: <CAK00H8NXrjc_LSGVJ0k7RL9FwMPjXGn52z0g0s07=wJfkRqDuA@mail.gmail.com>
Subject: Re: [PATCH] smbios: Fix buffer overrun when using path= option
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org,
 thuth@redhat.com, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c171f40631f53c7e"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=valentin.david@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Apr 2025 11:36:10 -0400
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

--000000000000c171f40631f53c7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes.

On Fri, Apr 4, 2025 at 5:02=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 4/4/25 16:46, Valentin David wrote:
> > On Thu, Apr 3, 2025 at 9:37=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <phi=
lmd@linaro.org
> > <mailto:philmd@linaro.org>> wrote:
> >
> >     Also I was hoping I could get feedback from Valentin.
> >
> >
> > Sorry, I did not realize that you wanted my feedback. Daan's patch look=
s
> > fine to me. I have manually tested it and it fixes my issue.
>
> Thanks! Might I add your tag then?
>
> Tested-by: Valentin David <valentin.david@canonical.com>
>
>

--000000000000c171f40631f53c7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes.</div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 4, 2025 at 5:02=E2=
=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.or=
g">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On 4/4/25 16:46, Valentin David wrote:<br>
&gt; On Thu, Apr 3, 2025 at 9:37=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt=
;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</=
a> <br>
&gt; &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">phil=
md@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Also I was hoping I could get feedback from Valenti=
n.<br>
&gt; <br>
&gt; <br>
&gt; Sorry, I did not realize that you wanted my feedback. Daan&#39;s patch=
 looks <br>
&gt; fine to me. I have manually tested it and it fixes my issue.<br>
<br>
Thanks! Might I add your tag then?<br>
<br>
Tested-by: Valentin David &lt;<a href=3D"mailto:valentin.david@canonical.co=
m" target=3D"_blank">valentin.david@canonical.com</a>&gt;<br>
<br>
</blockquote></div>

--000000000000c171f40631f53c7e--

