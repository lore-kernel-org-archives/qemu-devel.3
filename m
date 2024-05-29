Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30154C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJXK-0008RY-ES; Wed, 29 May 2024 09:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCJXI-0008R8-Bo
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:40:12 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCJXF-0000fp-Hv
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716990010; x=1748526010;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=MmFNbZeo9MSYiHcRdeKEQagT0HH9mc7n7rtg7wuLdOk=;
 b=LuutRjABgt5nRxMvQkj/IkliXiwGDeUhtv/CIQpWJ604HEBNufJ6cU59
 mNdi4QjV7UuPvVYfA9bjzgfr/5vL5KTzqxrvdc4Msue07VmAEX4tuBqsd
 bNtkPX7Io1osuAMJmSW7VQVSivv3NGiwGuIFAQuTyNKKcMGZn/9/i0/ZZ
 +4BHEnupv0dm1oevYMiO2k3jYWPdVnhCbCiigxdcTVliC47oF4D+WgxS3
 AT6+lxCSBGgsKCZMFuQQOaFSK5/Wmmrat/8cgE8kShQ51AxesQ4pHMAzD
 TJp6epK+6e9puX/Gy5maWdKKbxb4rWwK2NbZH4JVc1DPcU59dtEOsmmpq Q==;
X-CSE-ConnectionGUID: 2tiZFcj6Rsa6yT7fe8bDoA==
X-CSE-MsgGUID: omrHpsfmR5KNlO0Hi490Kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24806058"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; d="scan'208";a="24806058"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2024 06:39:56 -0700
X-CSE-ConnectionGUID: 4qXYuXRERLO3IAWvdJ03Jw==
X-CSE-MsgGUID: SpxxG4IgR8iRsxILyWXWDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; d="scan'208";a="35972577"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 29 May 2024 06:39:53 -0700
Date: Wed, 29 May 2024 21:55:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/6] target/i386: Misc cleanup on KVM PV defs and
 outdated comments
Message-ID: <ZlczxBdykhX28M9K@intel.com>
References: <20240506085153.2834841-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506085153.2834841-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi mainatainers,

Just a friendly ping.

Thanks,
Zhao

On Mon, May 06, 2024 at 04:51:47PM +0800, Zhao Liu wrote:
> Date: Mon, 6 May 2024 16:51:47 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH v2 0/6] target/i386: Misc cleanup on KVM PV defs and
>  outdated comments
> X-Mailer: git-send-email 2.34.1
> 
> Hi,
> 
> This is my v2 cleanup series. Compared with v1 [1], only tags (R/b, S/b)
> updates, and a typo fix, no code change.
> 
> This series picks cleanup from my previous kvmclock [2] (as other
> renaming attempts were temporarily put on hold).
> 
> In addition, this series also include the cleanup on a historically
> workaround and recent comment of coco interface [3].
> 
> Avoiding the fragmentation of these misc cleanups, I consolidated them
> all in one series and was able to tackle them in one go!
> 
> [1]: https://lore.kernel.org/qemu-devel/20240426100716.2111688-1-zhao1.liu@intel.com/
> [2]: https://lore.kernel.org/qemu-devel/20240329101954.3954987-1-zhao1.liu@linux.intel.com/
> [3]: https://lore.kernel.org/qemu-devel/2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (6):
>   target/i386/kvm: Add feature bit definitions for KVM CPUID
>   target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
>     MSR_KVM_SYSTEM_TIME definitions
>   target/i386/kvm: Only save/load kvmclock MSRs when kvmclock enabled
>   target/i386/kvm: Save/load MSRs of kvmclock2
>     (KVM_FEATURE_CLOCKSOURCE2)
>   target/i386/kvm: Drop workaround for KVM_X86_DISABLE_EXITS_HTL typo
>   target/i386/confidential-guest: Fix comment of
>     x86_confidential_guest_kvm_type()
> 
>  hw/i386/kvm/clock.c              |  5 +--
>  target/i386/confidential-guest.h |  2 +-
>  target/i386/cpu.h                | 25 +++++++++++++
>  target/i386/kvm/kvm.c            | 63 +++++++++++++++++++-------------
>  4 files changed, 66 insertions(+), 29 deletions(-)
> 
> -- 
> 2.34.1
> 

