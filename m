Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213C4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 08:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxNCr-0005xo-1i; Thu, 18 Apr 2024 04:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rxNCo-0005wy-PI
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 04:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rxNCm-0000mt-QK
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 04:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713429195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cA+8/rkExO7HHwDjpqWn3LQgLueLTT0rpG4sh68X7VY=;
 b=akIqtuUubthit0CIGhQpZWZ7f33QXVqABsGiT47ayKobp7FOsPSDZxJ5HxFCNunNzod9cn
 R6SnJHhPQER4kzJREnOtXxuRzhe9VFWa1nz1daIXPaZ2D7cKERQ7Nqt4P/ja4bQtF+y0x6
 DpSZXv+ma7CKguOM0MLUpsOuPKm99AY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-UH0bVBJFNX-GxpVykJqMEQ-1; Thu, 18 Apr 2024 04:33:14 -0400
X-MC-Unique: UH0bVBJFNX-GxpVykJqMEQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-415591b1500so2960065e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 01:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713429193; x=1714033993;
 h=in-reply-to:references:user-agent:subject:cc:to:from:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cA+8/rkExO7HHwDjpqWn3LQgLueLTT0rpG4sh68X7VY=;
 b=a7bl0wj428qsJlRq5q+z5eNcvAmDlSWUv94LXU7VTjg28/rdI4A3NiChX9mCivb59T
 kuktNgIB1p/Ya/CYCFDB6UXPGlq6u/NLKaQoLK3LwdaCWOC4pCx5Jd0O7hxsWz1qwAZd
 vp9R6nIDKf/mfq8sofw4arwW6jfcQ8KD/1OIMzArZk8peZZKCWdEuWM8IHQODyioVwYF
 pU/IWITuDSUXmO0MwaA757dN8XFrwKAGV6kzWlAYw7S42vWZBwGHrgMrhlJbQaGVhAxu
 y1Ptg10TiP1JuHytliN3eY6yw88+UXMpjlzNILvuEbklWFKN47T6bh3RF2PDI34T/zI1
 5Vug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4GGAjXDdg7Wel2n1Ziu/RpRYcskbqaa1m3GSJEKa+8KxXn5OaQBpw0UPKpueCtmSLZSQkEIWgY7HNXfGIBffSdf+xzzQ=
X-Gm-Message-State: AOJu0YxYu9KSGGgbaUjpmL+baMHOEUIIDlTfzxzh2pyh4Cdkbiqp/0Hr
 t79m8sGC52iseNocIEA4zdLZ6IK5WHtKUtDeg/hhj9BdQ29V+1FqQ7FlaYDda6HLEWvIoIVFqZ1
 w1hpBHyijGEiKKKG9grSLmEdEFpT4DAm0R+914pzJQ2mTx3kPsnfo
X-Received: by 2002:a05:600c:3504:b0:418:d58e:2944 with SMTP id
 h4-20020a05600c350400b00418d58e2944mr1453243wmq.18.1713429192923; 
 Thu, 18 Apr 2024 01:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnDqCMGXzcPjKUqweCNrPT7NOs2ST3gtnHuCxGuMRtD/Zkq5s5RBep4elMIw6vCL1+1bzKDg==
X-Received: by 2002:a05:600c:3504:b0:418:d58e:2944 with SMTP id
 h4-20020a05600c350400b00418d58e2944mr1453231wmq.18.1713429192610; 
 Thu, 18 Apr 2024 01:33:12 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a05600c310a00b00418e1400dd0sm1547263wmo.28.2024.04.18.01.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 01:33:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Apr 2024 10:33:11 +0200
Message-Id: <D0N3YG7LB7D7.3OULBNYVWR659@fedora>
From: "Anthony Harivel" <aharivel@redhat.com>
To: "Zhao Liu" <zhao1.liu@intel.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
User-Agent: aerc/0.15.2-111-g39195000e213
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com> <Zh+fRliUJ8sPcOpD@intel.com>
 <Zh_AF3YfiZeIAkCU@redhat.com> <Zh/nMFpfKIORYW97@intel.com>
In-Reply-To: <Zh/nMFpfKIORYW97@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


Hi Zhao, Daniel,

Zhao Liu, Apr 17, 2024 at 17:13:
> Hi Daniel,
>
> On Wed, Apr 17, 2024 at 01:27:03PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > Date: Wed, 17 Apr 2024 13:27:03 +0100
> > From: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> > Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
> >=20
> > On Wed, Apr 17, 2024 at 06:07:02PM +0800, Zhao Liu wrote:
> > > Hi Anthony,
> > >=20
> > > May I ask what your usage scenario is? Is it to measure Guest's energ=
y
> > > consumption and to charged per watt consumed? ;-)
> > >=20
> > > On Thu, Apr 11, 2024 at 02:14:34PM +0200, Anthony Harivel wrote:
> > > > Date: Thu, 11 Apr 2024 14:14:34 +0200
> > > > From: Anthony Harivel <aharivel@redhat.com>
> > > > Subject: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
> > > >=20
> > > > Starting with the "Sandy Bridge" generation, Intel CPUs provide a R=
APL
> > > > interface (Running Average Power Limit) for advertising the accumul=
ated
> > > > energy consumption of various power domains (e.g. CPU packages, DRA=
M,
> > > > etc.).
> > > >
> > > > The consumption is reported via MSRs (model specific registers) lik=
e
> > > > MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs =
are
> > > > 64 bits registers that represent the accumulated energy consumption=
 in
> > > > micro Joules. They are updated by microcode every ~1ms.
> > >=20
> > > What is your current target platform?
> >=20
> > I think we can assume /all/ future CPUs are conceptially in scope
> > for this.
> >=20
> > The use case is to allow guest owners to monitor the power consumption
> > of their workloads, so they can take steps to optimize their guest VM
> > workloads to reduce power consumed.
>
> Thanks for the explanation!=20
>

Thanks Daniel for stepping in on the explanation.


> > > On future Xeon platforms (EMR and beyond) RAPL will support TPMI (an =
MMIO
> > > interface) and the TPMI based RAPL will be preferred in the future as
> > > well:
> >=20
> > Is the MSR based interface likely to be removed in future silicon,
> > or it will be remain for back compat ?
>
> For Xeon, GNR will have both TMPI & MSR RAPL, but eventually MSR RAPL
> will be removed. Therefore, if RAPL support is desired for all future
> Xeons, then it's necessary to consider TMPI as the next plan.
>
> Alternatively, the whole RAPL scope can be split into rapl-msr and
> rapl-tpmi features.
>

I'm aware of the MSR/TPMI RAPL that will appear in the future, and=20
I would like to share my perspective on that.

Firstly, we can safely assume that it will take years before all server=20
hardware is transitioned to the new GNR (or future XEON without RAPL=20
MSR). It may be around 2024 when these features could be integrated into=20
QEMU. While the adoption of this feature might take some time, I'm=20
optimistic that once it's implemented, people will finally have the=20
tools to optimize workloads inside VMs and start reducing power=20
consumption.

Secondly, the second-hand server market is substantial. This means that=20
with the Virtual RAPL MSR, all XEON processors starting from Sandy=20
Bridge (2012!) will have the potential for software optimization. Making=20
the most of existing resources is essential for sustainability.

Lastly, when the TPMI becomes available in hardware in the future, the=20
RAPL interface and ratio calculation will remain the same, with only the=20
method of obtaining host values changing. This transition should be=20
manageable.

Regards,
Anthony


