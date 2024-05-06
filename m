Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A13C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oJg-0000ZO-9u; Sun, 05 May 2024 22:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3oJd-0000Wt-19
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:57 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3oJa-0007Wl-87
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714963374; x=1746499374;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LzRCBXPhfqaFfj4fQHqmi9NM6+t8R/Qm8mpHsXOCVnA=;
 b=GebVH9nOb9xCU8tS2e7g94ScE4Fnx3O3b15jIp4cMACd3DIZE0Z4vPEk
 b/G8hJnFXwVZIi8H3G5TcrFCWWJQAH/OLyYMVeWoBtw7GuTCUEpIuuZ5y
 bDevmcSRolfVpzYAhKhyESSvDO+NchxGUkFDMXEiK05xgeQxWM5SIb/XJ
 4rrknXvLBS6SbWffklfP9RrUhSClHtUlFyPZDdP16zkd5clmAwbPkj/u7
 iLQc+XV0700KJmaJkX6pSqdWh0jXOxKIl3KJGd9h3pc++2e+76/jcRf1Y
 E7iub4U84SuPoiKINIA5PRf6+66fzzWXznXLfQ83zoVY9HfT21UZepiPb Q==;
X-CSE-ConnectionGUID: HEdBNRT7SymumncFR2BT+A==
X-CSE-MsgGUID: coFvdmF+T0+9pNMa2tANbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10524763"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="10524763"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2024 19:42:51 -0700
X-CSE-ConnectionGUID: L8z9fa1MS0+ruIrD18g45Q==
X-CSE-MsgGUID: hJNJZ3e0QFuwIDprIVz+/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="28106331"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 05 May 2024 19:42:49 -0700
Date: Mon, 6 May 2024 10:57:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 6/6] target/i386/confidential-guest: Fix comment of
 x86_confidential_guest_kvm_type()
Message-ID: <ZjhG/cCMFP9T1z6J@intel.com>
References: <20240426100716.2111688-1-zhao1.liu@intel.com>
 <20240426100716.2111688-8-zhao1.liu@intel.com>
 <c75723d7-353e-4208-96bc-865a227f1bac@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c75723d7-353e-4208-96bc-865a227f1bac@intel.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Xiaoyao,

On Sat, Apr 27, 2024 at 07:05:41AM +0800, Xiaoyao Li wrote:
> Date: Sat, 27 Apr 2024 07:05:41 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH 6/6] target/i386/confidential-guest: Fix comment of
>  x86_confidential_guest_kvm_type()
> 
> On 4/26/2024 6:07 PM, Zhao Liu wrote:
> > Update the comment to match the X86ConfidentialGuestClass
> > implementation.
> > 
> > Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> I think it should be "Reported-by"
>

Right, let me fix and respin it.

Thanks,
Zhao


