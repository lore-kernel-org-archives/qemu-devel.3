Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ADFC25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 02:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9FYj-0004GV-4m; Mon, 20 May 2024 22:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s9FYh-0004GD-N5
 for qemu-devel@nongnu.org; Mon, 20 May 2024 22:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s9FYR-0002JV-8r
 for qemu-devel@nongnu.org; Mon, 20 May 2024 22:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716259720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aydI7zptD5+uo0Voind6VcRvAu/8cuEQC/sVaMr14ZI=;
 b=PfmTVIRpaE5a64AlWLDDgv9v5M9vhtc2rod7PPRF0M9cRwiXvCmV57CYsYI5uhQUEZ8Hlh
 YmjE1ig26jsrVeM4KpVwBMzL8zCNuAynbu8dmlN58xKM4zj93pHHY338YSzFhHhQ26gZiB
 t+3IYuy4EBDIEGVgVvJR9LeCufhu/uE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-R0sZ1QkwPnKZ17UY1_em8Q-1; Mon, 20 May 2024 22:48:36 -0400
X-MC-Unique: R0sZ1QkwPnKZ17UY1_em8Q-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2bd92c367ddso275345a91.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 19:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716259716; x=1716864516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aydI7zptD5+uo0Voind6VcRvAu/8cuEQC/sVaMr14ZI=;
 b=ZBMu24XBIhkoH06KTl/DrA1jKHzZ9/uXQ+apph3wcibVeCnFBeGxDksJ1Perw1JTTL
 89foK0LZ9Umumx6wrNsgLZ1h3Xger6h7uKCCT3uCuLay3buZBc6miEXfACG/oogVa1hC
 eyYpAhDDdQFDSnv875FOayTyErJ3OZiCmNAt3VCgim9mEjjpc9hrd6tylIAv0RK4i4eo
 tVnXdqSrLWVSzI0yt/Dmm1YUDbQ5vJ/r5JqTZ2v0RZeYySKXLOEvyrcr+Zll5d92jBL6
 Tu/5veKss03lDnWT5eb04/aM4dvQHF6/oNHUBmnosibqazX6q1n9lOUf8T10/DJHtJLL
 p91Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJLKxQwVnvVbuG0Jqe+Xz361mq5GwzQy37hF5LPJ2Z3xLcdxwbsZkIJer54hp3+TkUX/w93VdnSj8OxcradYDY9t3dbXQ=
X-Gm-Message-State: AOJu0Yxt4QAND7bwhBkOi3pFwMegkVIxSfu4OIcq3U+xQUPfiOXr3Q79
 Gczu2W/7Vzj4vWubbPm8rlphbcoNYrZylmGJjw3Stb8i+W7Ja1UNw7CaShmjsvY61awFfENWd73
 lgpMg2J2GFoK6mSly04XQv+WI4W+g7Z7o1mEvThhgl2fD3ax7DNOwBD9AgacOex20A23fcg3/zJ
 ZMZkw8ZlBjqs603X6IGTvliWBiW18=
X-Received: by 2002:a17:90a:e693:b0:2bd:7762:d5e3 with SMTP id
 98e67ed59e1d1-2bd7762e415mr4570482a91.9.1716259715835; 
 Mon, 20 May 2024 19:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE26cNadbFVJqAf2hs0bJ6G8lT99TuvL1o+C4pavsjv4A1eaQAIPBIwcFDvceqWqbTa5LY/rZRzX0dAEgtiP9Q=
X-Received: by 2002:a17:90a:e693:b0:2bd:7762:d5e3 with SMTP id
 98e67ed59e1d1-2bd7762e415mr4570468a91.9.1716259715453; Mon, 20 May 2024
 19:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 May 2024 10:48:24 +0800
Message-ID: <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng,
 Chao P" <chao.p.peng@intel.com>, 
 Yu Zhang <yu.c.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, May 20, 2024 at 12:15=E2=80=AFPM Liu, Yi L <yi.l.liu@intel.com> wro=
te:
>
> > From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> > Sent: Monday, May 20, 2024 11:41 AM
> >
> >
> >
> > >-----Original Message-----
> > >From: Jason Wang <jasowang@redhat.com>
> > >Sent: Monday, May 20, 2024 8:44 AM
> > >To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> > >Cc: qemu-devel@nongnu.org; Liu, Yi L <yi.l.liu@intel.com>; Peng, Chao =
P
> > ><chao.p.peng@intel.com>; Yu Zhang <yu.c.zhang@linux.intel.com>; Michae=
l
> > >S. Tsirkin <mst@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> > >Richard Henderson <richard.henderson@linaro.org>; Eduardo Habkost
> > ><eduardo@habkost.net>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined=
 by
> > >spec
> > >
> > >On Fri, May 17, 2024 at 6:26=E2=80=AFPM Zhenzhong Duan
> > ><zhenzhong.duan@intel.com> wrote:
> > >>
> > >> From: Yu Zhang <yu.c.zhang@linux.intel.com>
> > >>
> > >> Currently we use only VTD_FR_PASID_TABLE_INV as fault reason.
> > >> Update with more detailed fault reasons listed in VT-d spec 7.2.3.
> > >>
> > >> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > >> ---
> > >
> > >I wonder if this could be noticed by the guest or not. If yes should
> > >we consider starting to add thing like version to vtd emulation code?
> >
> > Kernel only dumps the reason like below:
> >
> > DMAR: [DMA Write NO_PASID] Request device [20:00.0] fault addr 0x123460=
0000
> > [fault reason 0x71] SM: Present bit in first-level paging entry is clea=
r
>
> Yes, guest kernel would notice it as the fault would be injected to vm.
>
> > Maybe bump 1.0 -> 1.1?
> > My understanding version number is only informational and is far from
> > accurate to mark if a feature supported. Driver should check cap/ecap
> > bits instead.
>
> Should the version ID here be aligned with VT-d spec?

Probably, this might be something that could be noticed by the
management to migration compatibility.

> If yes, it should
> be 3.0 as the scalable mode was introduced in spec 3.0. And the fault
> code was redefined together with the introduction of this translation
> mode. Below is the a snippet from the change log of VT-d spec.
>
> June 2018 3.0
> =E2=80=A2 Removed all text related to Extended-Mode.
> =E2=80=A2 Added support for scalable-mode translation for DMA Remapping, =
that enables PASIDgranular first-level, second-level, nested and pass-throu=
gh translation functions.
> =E2=80=A2 Widen invalidation queue descriptors and page request queue des=
criptors from 128 bits
> to 256 bits and redefined page-request and page-response descriptors.
> =E2=80=A2 Listed all fault conditions in a unified table and described DM=
A Remapping hardware
> behavior under each condition. Assigned new code for each fault condition=
 in scalablemode operation.
> =E2=80=A2 Added support for Accessed/Dirty (A/D) bits in second-level tra=
nslation.
> =E2=80=A2 Added support for submitting commands and receiving response fr=
om virtual DMA
> Remapping hardware.
> =E2=80=A2 Added a table on snooping behavior and memory type of hardware =
access to various
> remapping structures as appendix.
> =E2=80=A2 Move Page Request Overflow (PRO) fault reporting from Fault Sta=
tus register
> (FSTS_REG) to Page Request Status register (PRS_REG).
>
> Regards.
> Yi Liu

Thanks


