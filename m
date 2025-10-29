Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690D7CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE7y1-0002bM-N2; Wed, 29 Oct 2025 11:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vE7xw-0002Zr-SL
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:20:00 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vE7xo-0006SR-Qx
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761751193; x=1793287193;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Y1BbVUrIO9cbdSuoFgKhVdAdefVivCHX1c8W3H/8Kdk=;
 b=mb6dalo09v+9CqCP6sJEsUAyCsC4hLbepT7dMkEaJ1mPyTRF/hTU40bx
 9ait9zXXBS0FBVajAcFGlYOcv8zJEmnsMYEtrf2VVNaGlv8aP8G0vU/6m
 2ylSgksMbkarGNryyu1Uwo66AzIVK8PxeEhTj0PHE+VH+bza/CthcIZNi
 jPjOCFsdWc2/2MZj70exEQAs4N5QvZmxF04h4X5kAo9DPeTkJQ1WiTDh8
 y+WccDGm55FvXOOD+9L9811DRNQo9+WW5CA0GkgJjBpYaCHqKnEZxINAy
 jm9+kz8OtSYf5Wx0X/DAiPjL4IQswKdY/SUNhgcsa75G9h3aiib/3TqiD w==;
X-CSE-ConnectionGUID: yoKdhklcSB2jEwek/Nc8gA==
X-CSE-MsgGUID: Na8kgmzPSbCc3eMfah1OWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="86503863"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="86503863"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 08:19:48 -0700
X-CSE-ConnectionGUID: mdlWDlJoQ+633zbDvu8ygw==
X-CSE-MsgGUID: /qw2uItyQqeAowblO1UHSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="190050989"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 29 Oct 2025 08:19:47 -0700
Date: Wed, 29 Oct 2025 23:41:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/functional/x86_64/test_acpi_bits: Silence warnings
 reported by pylint
Message-ID: <aQI1xvVQfRBPVkgO@intel.com>
References: <20251029081514.60802-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029081514.60802-1-thuth@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 29, 2025 at 09:15:14AM +0100, Thomas Huth wrote:
> Date: Wed, 29 Oct 2025 09:15:14 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH] tests/functional/x86_64/test_acpi_bits: Silence warnings
>  reported by pylint
> 
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint complains about too many positional arguments for the __init__
> function of the QEMUBitsMachine class, use a "*" to enforce argument
> passing by names instead (which the calling sites are doing here already).
> 
> Second, use lazy logging when calling self.log.info() with a "%s" format
> string, and drop a superfluous "else:" that is not necessary after a
> "raise" statement.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/x86_64/test_acpi_bits.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


