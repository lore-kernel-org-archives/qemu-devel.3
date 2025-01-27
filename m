Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF59C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcM8C-00069g-1M; Mon, 27 Jan 2025 05:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcM81-00068O-B7; Mon, 27 Jan 2025 05:14:02 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcM7z-0000hh-32; Mon, 27 Jan 2025 05:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737972839; x=1769508839;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=s9BjGLL9EoUekpU/YGPTxEs3FhiTr/fRLkdPAxXMsa8=;
 b=KQJSTUP5m4L8nvAy2ufGPZIHaumlh+B8Cs3SdKdm1feHleD4UFVu5Jib
 6yhChWyRVkZm12r8ro4bno9I85vzXoj5cNwlPm7b0w0qXRMCvkSpkBFQd
 3jOsaY4T5wdpoECZ/NRNtkl445lJe84opu/R/x663dbox9gIylJzr/LWM
 aRbaAz8gPk12QmUDzhjSx9/PjMVJKZpTS3AcQ6YjmQZv1alU6ZoJElA19
 YokFfHGXzbNZdamKgYYvtwQA3lYbVuHBuvl7Cq+m1hh8dFTcHNfiAY5tt
 SEx/nLXnfaCC0BTChPjyRXqAIY6rg6JPCbSgPSpwGzYre8ReOfzpgOpB1 A==;
X-CSE-ConnectionGUID: Hi5bTxk/R12K+sScSM8rWQ==
X-CSE-MsgGUID: kTBRkX0pS06muHwm/sCI8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="49819297"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; d="scan'208";a="49819297"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2025 02:13:56 -0800
X-CSE-ConnectionGUID: ENeZpjCnTwG8gJ8XqdI0Uw==
X-CSE-MsgGUID: PGPZPgW+RGa/G5oqazmwtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; d="scan'208";a="139269462"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 27 Jan 2025 02:13:54 -0800
Date: Mon, 27 Jan 2025 18:33:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 06/10] rust: qom: allow initializing interface vtables
Message-ID: <Z5dg78DiAwsOOCsE@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jan 17, 2025 at 08:39:59PM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 20:39:59 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 06/10] rust: qom: allow initializing interface vtables
> X-Mailer: git-send-email 2.47.1
> 
> Unlike regular classes, interface vtables can only be obtained via
> object_class_dynamic_cast.  Provide a wrapper that allows accessing
> the vtable and pass it to a ClassInitImpl implementation, for example
> ClassInitImpl<ResettableClass>.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/prelude.rs |  1 +
>  rust/qemu-api/src/qom.rs     | 45 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 44 insertions(+), 2 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


