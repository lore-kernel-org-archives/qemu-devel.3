Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60F5C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 08:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta9yA-0006eT-Ih; Tue, 21 Jan 2025 03:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1ta9xs-0006c6-KB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:50:32 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1ta9xo-00056k-5W
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:50:26 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so4315178f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 00:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737449417; x=1738054217; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VDzQCUICQRSClnuWhghJMM7wdVtPktltqMIYV+tt9f0=;
 b=PqTzBSWC1ALnirFhh13+xi+CmMh2iVAGPAaVRt2RUFoy0JNWYK5OBYamhuX91y98//
 a/RcFg714avMns9xdjdhOXGm+uCkibuAgTZGI5MevxDRR+tiS6Wtzzrf9fuEKyLxDKXZ
 U06oju0vkCPHoi2TKKukGWw137ydPfLHrD0T7lpt/KODpo+mPjmlz0jY39yly7XT17cL
 h//RXMj7foiBNKyBr+Ieckp+MyTJvQmFNu19cJNqnlkk2MiuSYjqARRLqPz9iILKStkq
 XaO5e8kvn6/Bp2HgV+F+JJwQhp2qGQ8hzLzf8i0GoEwhzlToPQVHR1/iUPZ0gYYt2M4O
 zZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737449417; x=1738054217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VDzQCUICQRSClnuWhghJMM7wdVtPktltqMIYV+tt9f0=;
 b=Kvn+gAz5uKiXGSLOT6II6TacaLGItxBGBgz7pq9Edd6Hf8vPYxj217SZAvhNVlTIF8
 Ecm/HBI7pK2i8USLQ3GBX8XlXJNF+yjvJvAOOuRlgx4PdJnQY+KT7/KzxI9yaN/ZXXMd
 F76d3gfcKHar6f8JcyZXHjPumCFy/s158Zc+O3Nw+kSeSuf6rfAkc7txRt7NBkYQqksV
 C0HySerNM3EDOqFjtQHKZ/amISkL+e9Oe1DaPO+P6EkyNpzWvCQ6qbBI2hQnn4/7OdY9
 XyiKoMKy6GfWRJ042Evl1Dzl1NerNA8qsVXXjKHZLZL3oC/M3KZwWkb6O/1Jo2zzN/hm
 PhWw==
X-Gm-Message-State: AOJu0YxFNeyQlh7IAydRcLBLfPndudG8hw+GVhO4fLIeTU9Iub9yOsn5
 dKTj+VQk+dvdhGRQTV/kxlHGEBVKtdm7Zljsvc84+6tHcmnjAFM/QIC5qTbtTVbAlI22TO9lfN8
 SMhTLaqpyZLC6oy3Ls83ATzINMao=
X-Gm-Gg: ASbGnctmbNLsKogNBoc64BdNXYnTnvwbeum9ceIlXUXJdL79aDbotjxxV9SjKL5JwW1
 M4Ke6uHrDPu2Gk5vm3NsXm5BWBsPZTkmSD+CEOep035ppqaMu2cYt
X-Google-Smtp-Source: AGHT+IF8jX26gxV/uhOLs8qDIfbfMFOC3R9lwpu6NIkcskCWdz92Rv/eqk5RPI8NDAefIqDJksiWOURDRJdfScTbL4A=
X-Received: by 2002:a5d:59ad:0:b0:385:f560:7924 with SMTP id
 ffacd0b85a97d-38bf5678104mr11454394f8f.4.1737449416773; Tue, 21 Jan 2025
 00:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20250116095355.41909-1-east.moutain.yang@gmail.com>
 <479d79c7-2cb8-4f32-9bf0-fe1a50931925@redhat.com>
In-Reply-To: <479d79c7-2cb8-4f32-9bf0-fe1a50931925@redhat.com>
From: Wencheng Yang <east.moutain.yang@gmail.com>
Date: Tue, 21 Jan 2025 16:50:05 +0800
X-Gm-Features: AbW1kva5RucnoVRD82tN1ECzm7BhppjrdSJ0NWqO3PP41BE62LVT30JWgb98d3o
Message-ID: <CALrP2iXft+p2FiSDUpMn+PnvhUVxw57uRQdwAPGiiR8wjpo5TA@mail.gmail.com>
Subject: Re: [PATCH] vfio: Support P2P access in confidential VM
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 pbonzini@redhat.com, peterx@redhat.com, philmd@linaro.org, mst@redhat.com, 
 sgarzare@redhat.com
Content-Type: multipart/alternative; boundary="0000000000004d5681062c337755"
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-wr1-x430.google.com
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

--0000000000004d5681062c337755
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi, David,

> I'm wondering: isn't this something the kernel should be able to figure
> out? Is this encrypted RAM (SMA) or not, and set the flag accordingly?
> What are the challenges?

VFIO driver and IOMMU driver don't know the device(memory or device mmio)
behind vaddr,
only device driver knows that, now that the device is managed by user space
VFIO,
user should tell the info to VFIO driver.

On Mon, Jan 20, 2025 at 6:21=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:

> On 16.01.25 10:53, Wencheng Yang wrote:
> > On confidential VM platform, for example, AMD-SEV, P2P doesn't work.
> > The underlying reason is that IOMMU driver set encryption bit on
> > IOMMU page table pte entry, it's reasonalbe if the pte maps iova
> > to system memory. However, if the pte maps iova to device's
> > mmio bar space, setting encryption bit on pte would cause IOMMU
> > translates iova to incorrect bus address, rather than mmio bar
> > address.
> >
> > To fix the issue, the key point is to let IOMMU driver know the
> > target phyical address is system memory or device mmio.
>
> I'm wondering: isn't this something the kernel should be able to figure
> out? Is this encrypted RAM (SMA) or not, and set the flag accordingly?
>
> What are the challenges?
>
> --
> Cheers,
>
> David / dhildenb
>
>

--0000000000004d5681062c337755
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>hi, David,</div><div><br></div><div>&gt; I&#39;m wond=
ering: isn&#39;t this something the kernel should be able to figure<br>&gt;=
 out? Is this encrypted RAM (SMA) or not, and set the flag accordingly?</di=
v><div>&gt; What are the challenges?</div><div><br></div><div>VFIO driver a=
nd IOMMU driver don&#39;t know the device(memory or device mmio) behind vad=
dr,=C2=A0</div><div>only device driver knows that, now that the device is m=
anaged by user space VFIO,</div><div>user should tell the info to VFIO driv=
er.</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Jan 20, 2025 at 6:21=E2=80=AFPM David Hild=
enbrand &lt;<a href=3D"mailto:david@redhat.com">david@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 16.01.25=
 10:53, Wencheng Yang wrote:<br>
&gt; On confidential VM platform, for example, AMD-SEV, P2P doesn&#39;t wor=
k.<br>
&gt; The underlying reason is that IOMMU driver set encryption bit on<br>
&gt; IOMMU page table pte entry, it&#39;s reasonalbe if the pte maps iova<b=
r>
&gt; to system memory. However, if the pte maps iova to device&#39;s<br>
&gt; mmio bar space, setting encryption bit on pte would cause IOMMU<br>
&gt; translates iova to incorrect bus address, rather than mmio bar<br>
&gt; address.<br>
&gt; <br>
&gt; To fix the issue, the key point is to let IOMMU driver know the<br>
&gt; target phyical address is system memory or device mmio.<br>
<br>
I&#39;m wondering: isn&#39;t this something the kernel should be able to fi=
gure <br>
out? Is this encrypted RAM (SMA) or not, and set the flag accordingly?<br>
<br>
What are the challenges?<br>
<br>
-- <br>
Cheers,<br>
<br>
David / dhildenb<br>
<br>
</blockquote></div></div>

--0000000000004d5681062c337755--

