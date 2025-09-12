Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4550FCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 09:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzd9-0004xh-V0; Fri, 12 Sep 2025 04:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzd2-0004uT-4s
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:59:37 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzcu-00005r-Jk
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757667568; x=1789203568;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iYLhFItOaO/PR7Hj5hhH89o+09xHGWXksIZTjhR4Tpw=;
 b=kD1f5jwxxpfYpSGxa/DRCIZKZhlaS3I9Fnl2WRYKndTlmfvHMCUmDf2p
 BwmjelcBUPADXTXx4n6P+gPB6l53ghYv4PGQaZykdY3ZG/mmel46oE8UE
 nmeWxDUEcIJrvwAyudNSBAYDzEYrVuwQX00vCRuvJTcYeumvfSMN/R2I9
 +vvVgsAPoagUh6waetemAyTu86OZQXBl8uHTQqnHbBtrMGDWMGoE9FPt6
 /diuyjRW388wio5qMA2zAGwjifgTEPHKuhpi4LWrR3i2HmeISeXZNIH5/
 5QHhuqT3NaPiO/mCDQYWyPPLZF8ePlPXZCsMk24hmm8OLG3ZXG+EneZdM A==;
X-CSE-ConnectionGUID: an1/ElVrTk671bQr3dmlWA==
X-CSE-MsgGUID: Z0PazzqDQFiSjPBLrxfZHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60072961"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="60072961"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:59:25 -0700
X-CSE-ConnectionGUID: zK0QjxPGQaCaaw1LLczFNw==
X-CSE-MsgGUID: c7RoUqjNQ/ai6ulnzL+RRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="173746020"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 12 Sep 2025 01:59:24 -0700
Date: Fri, 12 Sep 2025 17:21:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 33/33] rust: do not inline do_init_io
Message-ID: <aMPmDbp5CSgVtUL4@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-34-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908105005.2119297-34-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:50:05PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:50:05 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 33/33] rust: do not inline do_init_io
> X-Mailer: git-send-email 2.51.0
> 
> This is now possible since the hwcore integration tests do not
> link the system crate anymore.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/system/src/memory.rs | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


