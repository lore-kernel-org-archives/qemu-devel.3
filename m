Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581BFC83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 05:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW6cK-0001lp-Rt; Mon, 30 Jun 2025 00:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uW6cH-0001l3-UF
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 00:59:42 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uW6cF-0000wb-Uc
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 00:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751259580; x=1782795580;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bzjzHuoFz3RgM2XiFsZoAfa4Wh/oSQierjAsn0Ekupw=;
 b=lPtaW/qSV+cuvKwb65J9edOMDldO6I5+DO80Ef/IXmNYAtWMuFmVfPQr
 9r4bvW8RyvOH5eRGFowLw7ieVC4X54uHYx+Orn07QsWzcwB0M8fHCJqGf
 lJLdtNSj6L1nNZOum5TSz+YkrNmQTJapmGkjWRSl7VoZQMVzPunjf8svn
 TuTyoSMETwveIZstPaSG+4UWcAoqL9jlctB3c7KfJoOXFUxCkSED+dkoH
 dqAR0pjZykYrBtDKCFtyNXS4ufgGlM3bmjqbq2SB4YjXbsHdHew/828KP
 Opvs3/aSGnZCFkQJquGciw07/CzWaAOZ2S0onu+OaWmsf4cikYU3B5M8t A==;
X-CSE-ConnectionGUID: l+7mwyFLRnyWGIoGHNuqZQ==
X-CSE-MsgGUID: IuFiNFSOQpqCjzzw4xS7rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="64167047"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="64167047"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2025 21:59:36 -0700
X-CSE-ConnectionGUID: rJp3tvo1SN+uPNe2OaPicQ==
X-CSE-MsgGUID: O92vljidQEW8aSgHeojC1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="184271656"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 29 Jun 2025 21:59:33 -0700
Date: Mon, 30 Jun 2025 13:20:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ewan Hai <ewanhai-oc@zhaoxin.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] i386/cpu: Mark ECX/EDX in CPUID 0x80000008 leaf as
 reserved for Intel
Message-ID: <aGIeuV5QKTIbtkeu@intel.com>
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
 <20250627035129.2755537-4-zhao1.liu@intel.com>
 <dedb9a90-a516-430e-8748-f776392f508d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dedb9a90-a516-430e-8748-f776392f508d@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> > +        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
> > +            *ecx = *edx = 0;
> > +            break;
> > +        }
> 
> current code guarantees ecx and edx to be 0 for !IS_AMD_CPU(). I think the
> patch is unnecessary.

Hi, could you please tell me why?

Thanks,
Zhao

> >           if (threads_per_pkg > 1) {
> >               /*
> >                * Bits 15:12 is "The number of bits in the initial
> 

