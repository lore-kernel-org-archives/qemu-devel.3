Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18135CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKji-0003SS-Is; Mon, 27 Oct 2025 06:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDKjd-0003Qk-8A; Mon, 27 Oct 2025 06:45:57 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDKja-0002Jc-QI; Mon, 27 Oct 2025 06:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761561954; x=1793097954;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zvKOKIqrL381FFR8Rfjt88/IRNmS2Y7LYuSRLtH2IWo=;
 b=ExUxPhNV1qarH9imbqZE9Ub0lqYW0unmgFYrzJ3K8bHndYaN5BzzveLR
 LEoDtcIb1AtsHZdMP1EPmmBimQie32LK6w244+1nafXmJ0pmXjEQ2RP//
 J+MozcQYS7+72JsL453OmsrQI8ewX7v5cF/SGwfTNMFpAdTjQvz8L9I+6
 V47suD8pUP4qWrhupWAm9icQsL4B4yb8KinO/y7W18Y/Lq5GVmXadJ2k2
 RsYKEBedLkjSUpeNPzfGGB+BHo+uXp/wOxIkwDUO0dDOQ0cZZse3TWv7U
 aCnTnzWL+cVp8gOnaXC9JIQJa4nIxy02MDYAVPXk15EsJoC6bodndm/A/ g==;
X-CSE-ConnectionGUID: qe9EOF9XTQ+eHVbqIQEnAg==
X-CSE-MsgGUID: VPebxUAqRz6OvVdLTvKOZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63526952"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="63526952"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 03:45:48 -0700
X-CSE-ConnectionGUID: 5+GiYi9GTOaKty8BN+wj6w==
X-CSE-MsgGUID: RyFcUmkLQhG+kr2s8BucpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184907468"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 27 Oct 2025 03:45:46 -0700
Date: Mon, 27 Oct 2025 19:07:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] tests/functional/i386: Remove unused variable from the
 replay test
Message-ID: <aP9SjbVr9Ew5zCAd@intel.com>
References: <20251027104012.51682-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027104012.51682-1-thuth@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

On Mon, Oct 27, 2025 at 11:40:12AM +0100, Thomas Huth wrote:
> Date: Mon, 27 Oct 2025 11:40:12 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH] tests/functional/i386: Remove unused variable from the
>  replay test
> 
> From: Thomas Huth <thuth@redhat.com>
> 
> Remove a left-over from the time when this test was still an
> avocado-based test.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/i386/test_replay.py | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


