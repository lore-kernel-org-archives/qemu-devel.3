Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95FEC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7q8o-0003iX-2Z; Thu, 24 Apr 2025 02:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7q8m-0003iK-Uv
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:32:56 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7q8k-0006g8-9t
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745476374; x=1777012374;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=crVvmvt20948+XIDqkkeo+K2HiFVUVQubWp6Rvxv3ZA=;
 b=NqAXUaVllveflYiUCAgphpr+olNKBsGk4iVoHZs6KEsKcgPARVvFf6hh
 PuLYCCyR94w1cQTYxdau+/AtLoOS7iCI7chzvrVqZOh+Y473JXlVkbFMu
 nhMbm6WPvdG073A2Se5mq4vX22eSUSLxYiI+nOOzA2+j17WCiWigECRsI
 f5+cW326WNRgSjxX8MxS98Aj9iEw8tF8s77UAREtWmjTYtTebnuxb6aad
 949boFphJMOsJgRdt0jNZyeZDgivyZ5VXLuK9mTHk9NyI+wCENKfaFv61
 QaUQmIhouIfASqh/0JdeRFnJf9Tfq4fXWAvWm+xoCAg2Xy4RC38cuNyqM Q==;
X-CSE-ConnectionGUID: tPVvqbEtTTeIBFJwExmMGw==
X-CSE-MsgGUID: kr6cpe/pSo6bBgDl9XJQGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47226574"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="47226574"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 23:32:48 -0700
X-CSE-ConnectionGUID: giu4a9VBT6uyMnrpiLBAeQ==
X-CSE-MsgGUID: r0QMmQ+gS0CiIRt5Q/1iRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="163562658"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 23 Apr 2025 23:32:45 -0700
Date: Thu, 24 Apr 2025 14:53:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Tao Su <tao1.su@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC 05/10] i386/cpu: Introduce cache model for SapphireRapids
Message-ID: <aAnf9YvevhAo+HJE@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-6-zhao1.liu@intel.com>
 <315d76f0-d81c-43ed-a13e-ef9b8e6a0e75@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315d76f0-d81c-43ed-a13e-ef9b8e6a0e75@nutanix.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Tejus,

> Thank you for this improvement! I see that even within the SPR-SP line of
> Processors, the cache sizes vary across different models. What happens for
> an instance when a processor only has 37.5 MiB of L3 per socket, but the CPU
> Model exposes 60 MiB of L3 to the VM?

AFAIK, the Linux scheduler doesn't take cache size into account, so
generally speaking, I think there's no impat on Linux.

If user space apps don't care about this info, then there's no problem.

However, I've met some cases where certain customers prefer that the
named cpu model also become closer to real silicon (e.g. current cache
size). The advantage of this is that an app that works fine on real
silicon is more likely to run normally in a Guest environment...
Because nobody can ensure that no user space app care about cache
size at all. And it's also unknown if there will be other OSes that
depend on the cache size (although I think it should be fine, after
all, current x86 only supports smp machines).

In contrast, the 0x1f example is more typical. By SDM, 0x1f is only
optional, and if 0x1f is not available, the one should check 0xb.
However, in Mishra's case, his windows only relies on 0x1f, so making
the named CPU model and the real silicon alignable is a better way
of avoiding all sorts of incompatibilities.

Thanks,
Zhao


