Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E469BC5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 08:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy3uz-0001xx-U5; Sun, 23 Aug 2026 04:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy3uy-0001xh-88
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:51:04 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy3uw-0003bJ-E9
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787475062; x=1819011062;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kjpxf2sQ1FERHhRTBKUY+6K4RPxRhA/sRW81XFP9zpI=;
 b=R13UHqwqxealYrGpPS0RtK0ZNnALsp353Xs56k8LuXkslQ6ps1d7BddH
 brja8SRb+QEK84YFlxFkfwUOwD21KfLR6hzZQy5QCf5qxdu0XDQkb9J3L
 +TJaflaXcbRGSEISnEMzknAawEG6mshRxcXzbHxsSqCl57/Y2SYmlO/ax
 LmJ4Aw576x1rdF7L1GFZqo9ZGq1WjTSs6mko3P3uLNc4BfNAT9nTu3/H7
 jogu8VDOj5RAiNXAOEvCDiCLjiltW7lkKZXHNahWHScioSAs6tGGgT7kG
 sTVwN0qod5vd/AFj8qtMV6MdnuyqB3wKgg67VSjok5HaQLxvzbTwf/59Z Q==;
X-CSE-ConnectionGUID: A6rJ7dH9SBCR2Bv/cqWEww==
X-CSE-MsgGUID: Je9+W0DDQC6ZZqs7yFcjaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="105492012"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="105492012"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 01:51:00 -0700
X-CSE-ConnectionGUID: mDwjNrNuTjanWCTPIivfVA==
X-CSE-MsgGUID: u6Amo0LdReaPom+XTKMx6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="262469051"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa006.fm.intel.com with ESMTP; 23 Aug 2026 01:50:58 -0700
Date: Sun, 23 Aug 2026 16:50:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 3/9] target/i386: Hide ARCH_CAPABILITIES for Hygon
Message-ID: <aoq0cYPRcUBc88P3@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-4-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-4-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Mon, Aug 10, 2026 at 04:29:50PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:50 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 3/9] target/i386: Hide ARCH_CAPABILITIES for Hygon
> X-Mailer: git-send-email 2.43.7
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
> Apply the same ARCH_CAPABILITIES hiding rule to Hygon CPUs when the vendor
> CPU ABI compat gate is enabled.  Keep arch_cap_always_on as the migration
> escape hatch, and keep the old Hygon CPUID/MSR output for pc-11.0 and
> older machine types via x-hygon-vendor-abi-fixes=false.

Nit: pc-11.1? Same applies to the other commit messages.

Thanks,
Zhao

