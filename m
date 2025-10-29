Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF58CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE7yu-00039a-08; Wed, 29 Oct 2025 11:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vE7yq-00039A-N5
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:20:56 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vE7yj-0006jq-6q
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761751250; x=1793287250;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qco2swxZxXsczFYK+nW/92TxeVWTMn8hwmVYOP3fXuw=;
 b=Pj0AtviMJeBzobUHtbQT3WDkM28sIgehD6VYslBLu68RV3elnMx4VvIg
 Vf1pnNjK1JkOdYw8xx31Wd2mkbAXYKyVZ/A443eAe/58hD5eKSl4tg+MK
 ki/3jHh1nOVzhCkcdElry7FPAO5EBD/P0LtzUiAWxgyB0AHPCv2rHwqwh
 3TIS5M6o6lBLrKAlpbf60dvSc4VLJ/aCH8r3lqgMSqEf6LJxrSX2rxNzO
 ufKyeh08RUaSrzMv2aHj0k0FFWQBbhALmpQrQm9GZTm0FYgInpOYJ7gt0
 gIr/AlUgr6HDdVUgRGKrqID02sq+c/S1OrbmNZbHRldMDESOEOiZ2rLq2 A==;
X-CSE-ConnectionGUID: QXJNKEnBR7GYWbWS+O9eZQ==
X-CSE-MsgGUID: jLwE2xQZTMynJm8GYSylfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64025898"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="64025898"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 08:20:46 -0700
X-CSE-ConnectionGUID: o5G9A7M+TG2p8Ft5U81BEA==
X-CSE-MsgGUID: WkLguMnqTvGM49uWJ6pAgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="189759298"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 29 Oct 2025 08:20:43 -0700
Date: Wed, 29 Oct 2025 23:42:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/functional/x86_64/test_virtio_balloon: Fix
 cosmetic issues from pylint
Message-ID: <aQI1/0uNyczHcLsT@intel.com>
References: <20251029075342.47335-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029075342.47335-1-thuth@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Wed, Oct 29, 2025 at 08:53:42AM +0100, Thomas Huth wrote:
> Date: Wed, 29 Oct 2025 08:53:42 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH] tests/functional/x86_64/test_virtio_balloon: Fix cosmetic
>  issues from pylint
> 
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint complains about some style issues in this file: Unused variables
> should be marked with an underscore, "when > then and when < now"
> can be simplified to "now > when > then" and expectData doesn't conform
> to the usual snake_case naming style.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/x86_64/test_virtio_balloon.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


