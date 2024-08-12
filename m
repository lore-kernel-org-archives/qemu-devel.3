Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A533C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 18:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdZmF-00009P-Ud; Mon, 12 Aug 2024 14:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sdZmD-0008VO-QZ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sdZmB-0006Z0-2w
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723487291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1dO7bvay9JIsu8zjXDiXTfklspmavhHfx+R+MA7Geg0=;
 b=YzPlnNfyo6JTReryx4dClGv94hpSWYIgTEw3uK05v+bt1FM7GEZbRcOn0M9NiMxW5Yx8lF
 ayd7N4QjBMGNN27fu9lvjEQ4uN6qimnBNMFPGi+Z9BrCIoy0Gk50d+j0S5P+WSqNJp1Evg
 TEnnSmJqppgrKb0XTK869/6Md+AX6n8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-MyMOrdi1PcyvmOJnz9MVhg-1; Mon, 12 Aug 2024 14:27:40 -0400
X-MC-Unique: MyMOrdi1PcyvmOJnz9MVhg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1fc6a863751so33222715ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 11:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723487258; x=1724092058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1dO7bvay9JIsu8zjXDiXTfklspmavhHfx+R+MA7Geg0=;
 b=wt9RZ07J1LP16EdKwsOWmYK+KL/F5DFWf7Y2YEXJI1a63Z4zztUWUwbVNrBqetT+C/
 hwhkOIAV9aukvZYMO4rzSRyzlOOWHfY+Yg7cGsd2z3sPVSJ+MtAvkCqwQb9QYTlSrxZi
 F2ptWLtIOMDepQpWytZcc2I9lTz1Sk1x3kTSJHzrPG/N/EJpFUeU7764AMZx7xWYLHtv
 19ZeWiRbu3RLcMGm1ysHpKUgswC9OcAxAYHsGhzKpGDHfxhWFqB1fucOme+MPe35zTky
 iS/KVcAj7dEFlk13jQqbSj9HrOx3jlr0VleS/ReS8b1eSDbmFuJIxpR8Kh+Xp2R81yF7
 AkZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6B7QIEIoM/TzT605/zz51zaTI61QHnMI4W4RDlnpdJYPQsuUtQGGQYsOwao8IykiankUCzFL1VqQbLkyxAhrwR3U510Q=
X-Gm-Message-State: AOJu0YztZPL8Qt+CActMMNzSsqIiuOrBUwNn/fEvKyM/lRgyPsWUqPt7
 EHairlgREbrcAWgTIED/Bt6YrqMqvMy88yc5tdmGNOFeUireL4Exjzrb3UqitmDbCv3xyz03H4G
 k0LhuXrOwqpDhtJkBl9xeGAZW+rpwgo9y+bIpTjXQ93E1LyeTUaF3IumSZUqOtz1WP7YIXsUP70
 Re2Fi14kqVVNZ6yS/0xz7TGUOEV73QDm5uqjw=
X-Received: by 2002:a17:902:db08:b0:1fc:6b8b:4918 with SMTP id
 d9443c01a7336-201ca1c0606mr13997515ad.41.1723487258057; 
 Mon, 12 Aug 2024 11:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECXeWPMU5gVTdvjTj/z+h8PJq0AELoTH7DRP49DgBtZdvMcVRFgNuQ4SQR7+B5JeyTo1KVUfdIgucORwLh+1A=
X-Received: by 2002:a17:902:db08:b0:1fc:6b8b:4918 with SMTP id
 d9443c01a7336-201ca1c0606mr13997275ad.41.1723487257663; Mon, 12 Aug 2024
 11:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240412080617.1299883-1-sf@sfritsch.de>
 <dnqsifhslb7mtidrzadsz6254ykmb4bjz2cenzryonz7wbjz4g@vj56wcuwgx25>
 <1eaf1f92-10f3-0270-a1b4-e95801c367dc@sfritsch.de>
In-Reply-To: <1eaf1f92-10f3-0270-a1b4-e95801c367dc@sfritsch.de>
From: John Snow <jsnow@redhat.com>
Date: Mon, 12 Aug 2024 14:27:25 -0400
Message-ID: <CAFn=p-Y1sAXfzx6cWEgeYyMyG3yn1vEpDmV2K8qWtLx4otm4tw@mail.gmail.com>
Subject: Re: [PATCH] dma-helpers: Fix iovec alignment
To: Stefan Fritsch <sf@sfritsch.de>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c4b5d9061f80a5e2"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000c4b5d9061f80a5e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 7:54=E2=80=AFAM Stefan Fritsch <sf@sfritsch.de> wro=
te:

> adding John Snow to CC because he investigated this in 2020.
>
> On Fri, 12 Apr 2024, Eric Blake wrote:
>
> > On Fri, Apr 12, 2024 at 10:06:17AM +0200, Stefan Fritsch wrote:
> > > Commit 99868af3d0 changed the hardcoded constant BDRV_SECTOR_SIZE to =
a
> > > dynamic field 'align' but introduced a bug. qemu_iovec_discard_back()
> > > is now passed the wanted iov length instead of the actually required
> > > amount that should be removed from the end of the iov.
> > >
> > > The bug can likely only be hit in uncommon configurations, e.g. with
> > > icount enabled or when reading from disk directly to device memory.
> > >
> > > Fixes: 99868af3d0a75cf6 ("dma-helpers: explicitly pass alignment into
> DMA helpers")
> > > Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> > > ---
> > >  system/dma-helpers.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > Wow, that bug has been latent for a while (2016, v2.8.0).  As such, I
> > don't think it's worth holding up 9.0 for, but it is definitely worth
> > cc'ing qemu-stable (done now).
>
> we had some more internal discussions and did some more googling, and it
> turns out that this is actually part of a known issue:
>
> https://lists.nongnu.org/archive/html/qemu-block/2020-07/msg01866.html
> https://gitlab.com/qemu-project/qemu/-/issues/259
>
> In the above mail to qemu-block, John Snow listed 4 problems in the code
> but my patch only fixes the first one. Considering that the code may also
> write data to the wrong place (problem 2), I wonder if an assert in the
> same place would be better until the underlying issues have been fixed?
>

Whew, it's been such a long time since I've looked at this, I barely
remember. I think my email now knows more about the problem than *I*
currently do. I'm glad I wrote it ...

I do not currently know what happens if you fix the first issue but not the
other four; I don't know if it gets passably "less broken" or if it causes
other bigger issues... and I don't have the bandwidth to test that out
currently, my apologies.

If there's a renewed interest in fixing this, I can try to start ramping
back up on it, but I have a few other projects to finish first, but
possibly I could discuss this at KVM Forum to help delineate the work into
manageable chunks.

~js

--000000000000c4b5d9061f80a5e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 16, 2024 at 7:54=E2=80=AF=
AM Stefan Fritsch &lt;<a href=3D"mailto:sf@sfritsch.de" target=3D"_blank">s=
f@sfritsch.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">adding John Snow to CC because he investigated this in 2020.<b=
r>
<br>
On Fri, 12 Apr 2024, Eric Blake wrote:<br>
<br>
&gt; On Fri, Apr 12, 2024 at 10:06:17AM +0200, Stefan Fritsch wrote:<br>
&gt; &gt; Commit 99868af3d0 changed the hardcoded constant BDRV_SECTOR_SIZE=
 to a<br>
&gt; &gt; dynamic field &#39;align&#39; but introduced a bug. qemu_iovec_di=
scard_back()<br>
&gt; &gt; is now passed the wanted iov length instead of the actually requi=
red<br>
&gt; &gt; amount that should be removed from the end of the iov.<br>
&gt; &gt; <br>
&gt; &gt; The bug can likely only be hit in uncommon configurations, e.g. w=
ith<br>
&gt; &gt; icount enabled or when reading from disk directly to device memor=
y.<br>
&gt; &gt; <br>
&gt; &gt; Fixes: 99868af3d0a75cf6 (&quot;dma-helpers: explicitly pass align=
ment into DMA helpers&quot;)<br>
&gt; &gt; Signed-off-by: Stefan Fritsch &lt;<a href=3D"mailto:sf@sfritsch.d=
e" target=3D"_blank">sf@sfritsch.de</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 system/dma-helpers.c | 3 +--<br>
&gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)<br>
&gt; <br>
&gt; Wow, that bug has been latent for a while (2016, v2.8.0).=C2=A0 As suc=
h, I<br>
&gt; don&#39;t think it&#39;s worth holding up 9.0 for, but it is definitel=
y worth<br>
&gt; cc&#39;ing qemu-stable (done now).<br>
<br>
we had some more internal discussions and did some more googling, and it <b=
r>
turns out that this is actually part of a known issue:<br>
<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-block/2020-07/msg0186=
6.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-block/2020-07/msg01866.html</a><br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/259" rel=3D"norefe=
rrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/259</=
a><br>
<br>
In the above mail to qemu-block, John Snow listed 4 problems in the code <b=
r>
but my patch only fixes the first one. Considering that the code may also <=
br>
write data to the wrong place (problem 2), I wonder if an assert in the <br=
>
same place would be better until the underlying issues have been fixed?<br>=
</blockquote><div><br></div><div>Whew, it&#39;s been such a long time since=
 I&#39;ve looked at this, I barely remember. I think my email now knows mor=
e about the problem than *I* currently do. I&#39;m glad I wrote it ...<br><=
/div><div><br></div><div>I do not currently know what happens if you fix th=
e first issue but not the other four; I don&#39;t know if it gets passably =
&quot;less broken&quot; or if it causes other bigger issues... and I don&#3=
9;t have the bandwidth to test that out currently, my apologies.</div><div>=
<br></div><div>If there&#39;s a renewed interest in fixing this, I can try =
to start ramping back up on it, but I have a few other projects to finish f=
irst, but possibly I could discuss this at KVM Forum to help delineate the =
work into manageable chunks.</div><div><br></div><div>~js<br></div></div></=
div>

--000000000000c4b5d9061f80a5e2--


