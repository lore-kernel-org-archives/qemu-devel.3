Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CA5C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wphIz-0003H5-EK; Fri, 31 Jul 2026 03:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wphIt-0003GM-Lo
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:05:11 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wphIr-0004qi-VM
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785481510; x=1817017510;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+2gH6d0mvPbRq5RRTPhJOH3p5CfgPHiv91vDTc5GU4g=;
 b=AmokqTT1uQn/WQT5pL6/EvFQzuNvlVP7XF0o6H8/bMyT2ZNaQlkawRFe
 1pXxcjQhFpPuPc3TlFUYdGX6gUdJdDDtoCjbzAbpH+wPEUj+QOZM3bmda
 dvj8gi6Ux1QbbtL3NopDIwRW6pyizXSltHAfH0qDqWQcquXp4AaCQ+yw0
 bGEEmPWsHkcA167Ojxa0lg6LS0md8ddFl+Yx9RD6O1k2LNh4s7xUEv8gw
 e9Mqs58+wyIm5A3Q9gssP2uTTaajXFt1rTCIBPA+0XyOgthBv14U3pQGs
 SZqT4J1PGyKDnRBXKFV7BzUZIEnenKyPyDuEanhm/A0J2O4YMLnz2z0se g==;
X-CSE-ConnectionGUID: ep2ntCHeTCuN/0ratVokoA==
X-CSE-MsgGUID: rx8hHr6ATh2OYynFjCZ/BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85231692"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="85231692"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 00:05:07 -0700
X-CSE-ConnectionGUID: UOzxglkEQLead0t9YnX5og==
X-CSE-MsgGUID: xc0QzjWxTMqyBUzm4jtdWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="259267745"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa010.jf.intel.com with ESMTP; 31 Jul 2026 00:05:06 -0700
Date: Fri, 31 Jul 2026 15:05:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v1 3/9] target/i386: Hide ARCH_CAPABILITIES for Hygon
Message-ID: <amxJIUQXIgXwHR4s@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-4-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706055530.1752094-4-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 06, 2026 at 01:55:24PM +0800, zhang_wei@open-hieco.net wrote:
> Date: Mon,  6 Jul 2026 13:55:24 +0800
> From: zhang_wei@open-hieco.net
> Subject: [PATCH v1 3/9] target/i386: Hide ARCH_CAPABILITIES for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> From: Tina Zhang <zhang_wei@open-hieco.net>
> 
> IA32_ARCH_CAPABILITIES is an Intel-defined MSR.  KVM can synthesize the
> CPUID bit and read-only MSR for non-Intel guests, and QEMU already hides
> that interface for AMD CPU models because Windows may not expect it on
> AMD-compatible CPUs.
> 
> Hygon Dhyana uses the HygonGenuine vendor string, so it currently skips
> that AMD filter.  If arch-capabilities=on is requested, QEMU can expose
> CPUID.7.0.EDX[ARCH_CAPABILITIES] and the associated MSR feature word to
> a Hygon guest.
> 
> That creates a vendor-inconsistent CPU ABI: the guest sees an
> AMD-compatible vendor and cache/topology interface, but also sees an
> Intel-specific architectural capabilities MSR.  Guests that choose CPU
> mitigation or feature paths from the vendor can mis-handle that
> combination; Windows is known to be sensitive to ARCH_CAPABILITIES on
> AMD-compatible CPUs.
> 
> Apply the same ARCH_CAPABILITIES hiding rule to Hygon CPUs when Hygon
> vendor ABI fixes are enabled.  Keep arch_cap_always_on as the migration
> escape hatch, and keep the old Hygon CPUID/MSR output for pc-11.0 and
> older machine types via x-hygon-vendor-abi-fixes=false.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/cpu.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


