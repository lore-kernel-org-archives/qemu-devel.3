Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1970ED70DE3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 16:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGhX4-00007v-HC; Thu, 28 Nov 2024 11:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tGhX3-00007n-KS
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 11:38:21 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tGhX1-0001nV-5p
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 11:38:21 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ea6f821decso819948a91.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 08:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732811897; x=1733416697;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fb9MsVeTF3WdtvmbUUB6oaNxbbESeBeRDPRgNbLwTYg=;
 b=bTLcvc8Xt4nvnV2PZ9V+6jkPduSnoeQB8c6l2ewkvkwOP9kH65iDxPj/gRJTDCGPfe
 VCZew64AzmLEF4e2Vkmku1/PiTWIvuZWM1CpJx3Vdqgh0XqWe51D52T90K+hI/i5BNZd
 BlRzYbM5u89K6AcR7OlQEgK3Ns3R//+DgzKxO01ob/b8CJSUiSGLb4T+dWJ+KFyfmygH
 yXJCoZFUS74AJUPeJmiZ0uchILGoYt1iRWXC2d1psdtviC0i6LxsLRX1DRImRLnjPqIH
 BLRYZxS2Hdcr4n+LRbkCmVX4cC/aYFTw326rNbZBzSjcNGGozU2y3V63gVy9JhFg/SMk
 d4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732811897; x=1733416697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fb9MsVeTF3WdtvmbUUB6oaNxbbESeBeRDPRgNbLwTYg=;
 b=hczWDVvKTyIuqn4qLXcezoftnytRk1rizVlnD1umIvT19V4izqZeIS4su3PboawZAy
 HCeB7cb5HTNhgiBdJIH0lnQNbBCQZYolPX2fk+ax+JnwSVvjgq1tyLaG7FQ8/z/R8Ozy
 I1rjhG+HNtRDL4wBvorVNkgRg1pOgq/pyqqIES9lTc5tx4mZMkv2g3+nVbASJWa1kgRN
 aB1Dsdd8i0EgCDAW0b2yc94n+hsc4DtqhZ7unGi6It5cji1ns2csZE9eTZbU4gi8fzIe
 VOEN0WQVD2xuz+fbwTWGCrG1JARwWmeXaoc78qBfJpBId9rtBa2NFlBTB08zGLl1x46A
 sPtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDePPR7XJ1c72fVcpjmC4ONbWnH4VGqj12SPHr083/2PRJPegnUESGNdtxwiMoQWphpgLMGyMp44GU@nongnu.org
X-Gm-Message-State: AOJu0YxgbIBdXHApJDq/GvvNRWrsJqNOsssJ6kgltfSvOdGuLiWROQNY
 5ey9XsIpa9E711qz3mkMfPP2e5+xsLjvZxXrU2rv0rQzisLdlx80VDcSllwRg9k9spjVxkHfhn/
 33sLEpPH69HcLejCsfnq+KVyrNojTn0PWhyT+
X-Gm-Gg: ASbGnctds6tAYNLGaOcr+dhf9vcf4PREIfai20VopzQKwiJLjsbsgOYJwBwZyQV6UWo
 pm7bJY0A1cxi9OhFjNfSn/NkqxsB9WEc=
X-Google-Smtp-Source: AGHT+IHAlgz1tOkCnkxjDJ9mNvjBRHIXTfGw9xwoGci/0MGWhfM47pfZicVEk2wjmnSPfuPesHXIc/HV9YZY1VS2CQA=
X-Received: by 2002:a17:90b:4f89:b0:2ea:838c:7f21 with SMTP id
 98e67ed59e1d1-2ee097bc2f3mr8467086a91.28.1732811896801; Thu, 28 Nov 2024
 08:38:16 -0800 (PST)
MIME-Version: 1.0
References: <20241113144923.41225-1-phil@philjordan.eu>
 <b772f6e7-e506-4f87-98d1-5cbe59402b2b@redhat.com>
 <ed2246ca-3ede-918c-d18d-f47cf8758d8c@amd.com>
 <CABgObfYhQDmjh4MJOaqeAv0=cFUR=iaoLeSoGYh9iMnjDKM2aA@mail.gmail.com>
In-Reply-To: <CABgObfYhQDmjh4MJOaqeAv0=cFUR=iaoLeSoGYh9iMnjDKM2aA@mail.gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Thu, 28 Nov 2024 17:38:05 +0100
Message-ID: <CAGCz3vtTgo6YdgBxO+5b-W04m3k1WhdiaqH1_ojgj_ywjZmV7A@mail.gmail.com>
Subject: Re: [PATCH] i386/kvm: Fix kvm_enable_x2apic link error in non-KVM
 builds
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Shukla, Santosh" <santosh.shukla@amd.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, mtosatti@redhat.com, suravee.suthikulpanit@amd.com
Content-Type: multipart/alternative; boundary="0000000000009276650627fbb53a"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1031;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000009276650627fbb53a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo, could we please apply either Sairaj and Santosh's fix at
https://patchew.org/QEMU/20241114114509.15350-1-sarunkod@amd.com/
or mine to fix this link error? As neither patch has so far been merged,
9.2.0-rc2 still fails to build on macOS, at least on my local systems. I'm
not sure why CI builds aren't jumping up and down about this, but neither
the Xcode 15.2 nor 16.1 toolchains are happy on macOS 14.7/arm64.


On Wed, 13 Nov 2024 at 19:39, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Wed, Nov 13, 2024 at 7:25=E2=80=AFPM Shukla, Santosh <santosh.shukla@a=
md.com>
> wrote:
> > Same proposed at
> https://lore.kernel.org/qemu-devel/cebca38a-5896-e2a5-8a68-5edad5dc9d8c@a=
md.com/
> > and I think Phil confirmed that it works.
>
> Thanks Santosh, can you post it with commit message and everything?
>
> Paolo
>
>
>

--0000000000009276650627fbb53a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Paolo, could we please apply either Sairaj and Santos=
h&#39;s fix at<br></div><div><a href=3D"https://patchew.org/QEMU/2024111411=
4509.15350-1-sarunkod@amd.com/">https://patchew.org/QEMU/20241114114509.153=
50-1-sarunkod@amd.com/</a></div><div>or mine to fix this link error? As nei=
ther patch has so far been merged, 9.2.0-rc2 still fails to build on macOS,=
 at least on my local systems. I&#39;m not sure why CI builds aren&#39;t ju=
mping up and down about this, but neither the Xcode 15.2 nor 16.1 toolchain=
s are happy on macOS 14.7/arm64.<br></div><div><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 13 Nov 202=
4 at 19:39, Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzi=
ni@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On Wed, Nov 13, 2024 at 7:25=E2=80=AFPM Shukla, Santosh &lt;<a=
 href=3D"mailto:santosh.shukla@amd.com" target=3D"_blank">santosh.shukla@am=
d.com</a>&gt; wrote:<br>
&gt; Same proposed at <a href=3D"https://lore.kernel.org/qemu-devel/cebca38=
a-5896-e2a5-8a68-5edad5dc9d8c@amd.com/" rel=3D"noreferrer" target=3D"_blank=
">https://lore.kernel.org/qemu-devel/cebca38a-5896-e2a5-8a68-5edad5dc9d8c@a=
md.com/</a><br>
&gt; and I think Phil confirmed that it works.<br>
<br>
Thanks Santosh, can you post it with commit message and everything?<br>
<br>
Paolo<br>
<br>
<br>
</blockquote></div>

--0000000000009276650627fbb53a--

