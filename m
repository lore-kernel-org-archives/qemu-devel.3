Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BB4D374A3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rkm-0003Qr-6H; Thu, 17 Oct 2024 10:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1Rki-0003On-45; Thu, 17 Oct 2024 10:45:24 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1Rkf-0005Zb-Oi; Thu, 17 Oct 2024 10:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729176322; x=1760712322;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zV481lRGbVV63j3CCjzbuapW1g8a4oHW28WTjDZBWng=;
 b=MiT73TZ1WhWkOAUyvyNpvLvK12joFNee91TYB3x82+/Eyv66V43b1FiZ
 O0ChiFzWimasX1OkTiqftNiRZg+NqcCwEioxTfSTZ/6SSuaHNjojb9I02
 Pqj+OaUplgE+ACHOxY8apRYV1pMGWht1yp4MoVZEpXbZswVh6cpezwUn9
 P07RD1Hw4Y6IVwmJ0Y/NLgcAJX3A9RYKQIRJQyN2VRXjpl7fymvmPGGqG
 76XGrGpkqXo9Aso2WRM+GgHo0o+w+7kBqdGtoOYcjbBPpMN+nBfNLiPK0
 I7npc/dFE4rflFLK4UBGQRSMOI8rr7VNNR+Pj8OcVxJTTrD2c7PP2Wreh A==;
X-CSE-ConnectionGUID: rKt8CMpTQwimfzXJk++ZjQ==
X-CSE-MsgGUID: BbRncYPFTMC/fJ7mA+ZmBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="31531319"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; d="scan'208";a="31531319"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 07:45:17 -0700
X-CSE-ConnectionGUID: S7JYt02wSee58G72esSEdQ==
X-CSE-MsgGUID: rTmYgiaESOSOiAQtFw6EsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; d="scan'208";a="78708432"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 17 Oct 2024 07:45:11 -0700
Date: Thu, 17 Oct 2024 23:01:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?us-ascii?B?PT9JU08tODg1OS0xP1E/TWE/PSA9P0lTTy04ODU5LTE/UT90?=
 =?us-ascii?Q?hieu-Daud=3DE9=3F=3D?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S.Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?us-ascii?B?PT9JU08tODg1OS0xP1E/QmVubj1FOWU/PQ==?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 0/7] Introduce SMP Cache Topology
Message-ID: <ZxEmxkwQythD6ILI@intel.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
 <20241017141402.0000135b@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017141402.0000135b@Huawei.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

(Cc and gentlely ping QOM & QAPI maintainers :) )

> > Meanwhile, ARM side has also worked a lot on the smp-cache based on
> > this series [2], so I think we are very close to the final merge, to
> > catch up with this cycle. :)
> 
> This would finally solve a long standing missing control for our
> virtualization usecases (TCG and MPAM stuff is an added bonus),
> so I'm very keen in this making 9.2 (and maybe even the ARM part
> of things happen to move fast enough). Ali is out this week,
> but should be back sometime next week. Looks like rebase of his
> ARM patches on this should be simple!
> 
> I think this set mostly needs a QAPI review (perhaps from Markus?)

Michael mentioned this series also need QOM maintainer's review. So I
pinged maintainers at the beginning of this reply.

> > 
> > This series is based on the commit 7e3b6d8063f2 ("Merge tag 'crypto-
> > fixes-pull-request' of https://gitlab.com/berrange/qemu into staging").
> > 
> > Background
> > ==========
> > 
> > The x86 and ARM (RISCV) need to allow user to configure cache properties
> *laughs*. I definitely going to start emailing ARM folk with
> ARM (RISCV)  
> :)  

:) I remembered you discussing cache topology with Sia (from RISCV).

Thanks,
Zhao



