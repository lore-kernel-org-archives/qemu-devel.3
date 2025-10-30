Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCAECCFA00
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETyB-0000Ul-HJ; Thu, 30 Oct 2025 10:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vETy8-0000SV-5G
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:49:40 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vETxz-0001O1-K3
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761835771; x=1793371771;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Iddla4z7flI67h7EdMSDk02AU+XEEh2561J+ewfpQww=;
 b=Kz9A2GquAr4hX9+GvBUx4DEjizjCrmqZp9QrpO0XKR6nq5pEIrGwODCT
 L6qajqlmq3unt1ARwCGB1DKPDzQQbsFv9aAm914/P1CUFCam/UOWhfMoX
 vdd0pBEF36FWTrk5CowwK3TabY1iFqM5Fhu5k5IKxDBtxJTb94WeV0iqW
 DNqi1CRyfjMZoWz7Pjrt+xngTbE64jAg8/XVOs0fOygauZs4fESEJpmz2
 zO7arGAMQ/L/qedDdPlEiK/4TUSweLAjVGMdfwEQtBOyJkF1I4lo6LFUg
 so4KtlHhKg1czclChZZowzWxQGgkpJvzGF+zICyHSXqrChk6T+QFMmRZb g==;
X-CSE-ConnectionGUID: DWcbzxLyRjWrI/a0GlkVPw==
X-CSE-MsgGUID: Zljp+AdNQSCUuI5bV5zU0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63864602"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="63864602"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 07:49:19 -0700
X-CSE-ConnectionGUID: 18uW1v3FSGOYNruA8URLZg==
X-CSE-MsgGUID: Rb9i9bojQzu35J+ddr2Qww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="190311721"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 30 Oct 2025 07:49:16 -0700
Date: Thu, 30 Oct 2025 23:11:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 02/20] i386/cpu: Clean up indent style of
 x86_ext_save_areas[]
Message-ID: <aQOAH0a9P3ZK+5H5@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-3-zhao1.liu@intel.com>
 <94d254b3-3d0f-4fe8-b6aa-da5df2b9c0e6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94d254b3-3d0f-4fe8-b6aa-da5df2b9c0e6@intel.com>
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

On Mon, Oct 27, 2025 at 01:47:53PM +0800, Xiaoyao Li wrote:
> Date: Mon, 27 Oct 2025 13:47:53 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v3 02/20] i386/cpu: Clean up indent style of
>  x86_ext_save_areas[]
> 
> On 10/24/2025 2:56 PM, Zhao Liu wrote:
> 
> <empty commit message> isn't good.

Yeah, will add the description.


