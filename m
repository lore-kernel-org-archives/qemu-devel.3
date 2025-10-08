Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3526CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 15:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6WMl-0005JZ-8O; Wed, 08 Oct 2025 11:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v6WMb-0005J7-3z; Wed, 08 Oct 2025 11:46:03 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v6WMS-0008Eb-Qy; Wed, 08 Oct 2025 11:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759938353; x=1791474353;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=roZY+39itQRbkIpjQ8uQn0VVrly44G8m51c/qvakQnI=;
 b=nkG+5iLo/mO8ms+O7nczKYV7fvYAjWa4mcCikrGGOluCAzXD3wywe18/
 4Fh+dh0PMwv6EhKCxOTzUAMcJUbjhpNdyNgeGnBUvpQae7VDDfnYNavo1
 m764WTVVyQl0tbnGDnrIN9jlfPo9pKKSnE85o2dOXMdHgUIGsZkSzh5px
 96jKilstBDx9vtlVv6UKwLl5CNTxe9rSNubt4sZk8pEvCuWVJZYVH7ZM4
 vY7b0/f/z9If1HxMngQjYMNQTBT4TNm4A7AoXVSpEG5Vbc5Cqf70KOyFv
 VtkUzBZ4ke4CH5g25bNPEhuOPRAQ3tBn2rXUjL/SdRzldopzNCjU64Lpv A==;
X-CSE-ConnectionGUID: DJCwrBkIT+Kucrb2X9/CjQ==
X-CSE-MsgGUID: wl4o/4V0QEa6Z53U2tJ2eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="84753707"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; d="scan'208";a="84753707"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 08:45:42 -0700
X-CSE-ConnectionGUID: VHq4QfpCQASQtJRTQrNCyw==
X-CSE-MsgGUID: jAwdlRFmSyeF/j9AGqxM7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; d="scan'208";a="179716773"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 08 Oct 2025 08:45:40 -0700
Date: Thu, 9 Oct 2025 00:07:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] subprojects: Remove version number from .gitignore
Message-ID: <aOaMTqpsbcbazzUf@intel.com>
References: <20250930120008.700432-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250930120008.700432-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Tue, Sep 30, 2025 at 02:00:08PM +0200, Paolo Bonzini wrote:
> Date: Tue, 30 Sep 2025 14:00:08 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] subprojects: Remove version number from .gitignore
> X-Mailer: git-send-email 2.51.0
> 
> Get rid of all the version numbers, and use wildcard matches instead,
> because peopl will repeatedly forgot to change these versions.
> 
> Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  subprojects/.gitignore | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


