Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12E6C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 12:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI5Rw-0002aG-B4; Thu, 22 May 2025 08:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.comg>)
 id 1uI0bg-0005m7-1Z; Thu, 22 May 2025 03:44:48 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.comg>)
 id 1uI0bc-0000II-GU; Thu, 22 May 2025 03:44:46 -0400
X-CSE-ConnectionGUID: byn5qMoPR6GQLy+Pvv6M7A==
X-CSE-MsgGUID: DdP8dZ9VRRW0vCr89p39vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49648576"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49648576"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 00:13:49 -0700
X-CSE-ConnectionGUID: 6wiW2drYR/6IzEoiq/Go2g==
X-CSE-MsgGUID: FeWAS7M9Q3iN2VY90+lShg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="140997796"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 21 May 2025 00:13:47 -0700
Date: Wed, 21 May 2025 15:34:54 +0800
From: Zhao Liu <zhao1.liu@intel.comg>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 2/5] hw/timer/hpet: Adjust num_timers in hpet_init()
Message-ID: <aC2CHrteHfhQDzOh@intel.com>
References: <20250520152750.2542612-1-zhao1.liu@intel.com>
 <20250520152750.2542612-3-zhao1.liu@intel.com>
 <20486914-1752-4710-b000-52ee04d4106d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20486914-1752-4710-b000-52ee04d4106d@redhat.com>
Received-SPF: none client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.comg;
 helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_NXDOMAIN=0.9,
 NO_DNS_FOR_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 May 2025 08:54:59 -0400
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

On Tue, May 20, 2025 at 05:16:22PM +0200, Paolo Bonzini wrote:
> Date: Tue, 20 May 2025 17:16:22 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 2/5] hw/timer/hpet: Adjust num_timers in hpet_init()
> 
> On 5/20/25 17:27, Zhao Liu wrote:
> > Currently, HPET adjusts num_timers in hpet_realize(), and doesn't change
> > it in any other place. And this field is initialized as a property.
> 
> Properties are initialized *after* hpet_init.  For hw/timer/hpet you can
> check s->num_timers and return an error if it's out of bounds, but for the
> Rust version we don't have Error** support yet. :(

Oops, yes.

(Note for myself,) the default property value is set before hpet_init(),
but the subsequent adjustments to property (via object_property_set_uint8())
need to take boundaries into account, which is why the num_timers adjustment
is placed in realize().

> Queued 1-4-5 for now.

Thanks!

Zhao


