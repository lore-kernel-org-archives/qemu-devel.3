Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D1FC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBx7p-0001wb-J9; Mon, 05 May 2025 10:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBx7n-0001wS-W1
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:48:56 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBx7i-0004yH-LV
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746456530; x=1777992530;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SpOTjgfL6A6BCgzuuMsoy5mgDqVlCT3WlYWMwOsXhLM=;
 b=PSY3ZIPbBT0aVrig1TnQ5//BibCbRAaCEjrVBj5r0ZXa6hSH+tU7Y00I
 lOdy8STmnrlc8Lq2OrkibvcNuktiN0u1zbjMLPKBgSaQTD1pTnHkjsFYE
 uMHrBIIsyV07rEzjP/RrbI0hnbE7BUHxo4ncIQGe2a1OWu9Kk9TyF3p8U
 Y7ZTR8zigI1GBi9HGB9RijTdRIzl6+W2ovs8J6W+2b9Db/gt1Gl/8L3Co
 wzPu7bq2t+vqJUQRlDlbClWEUZA50w4aQ6clGsxUc2JXRjrk+Wjd3iBwa
 SJ4Q+V/HArutyfqTetaGZcCjaQ5c/IchV+1ugDomJwQ+6Qpdllfhge1/B w==;
X-CSE-ConnectionGUID: ty4nENOWTzmnxSbEZkH41A==
X-CSE-MsgGUID: RFHIbeneSCOOE9pJRMhD2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="58696948"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="58696948"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2025 07:48:31 -0700
X-CSE-ConnectionGUID: v+VYAoBHSO+Vn5wYafiBQA==
X-CSE-MsgGUID: 9Ouf/5HMTFumEmAqICHIhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="140065743"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 05 May 2025 07:48:29 -0700
Date: Mon, 5 May 2025 23:09:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 49/55] i386/tdx: Define supported KVM features for TDX
Message-ID: <aBjUqTpUVFrCb/vd@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-50-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-50-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, Apr 01, 2025 at 09:01:59AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:59 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 49/55] i386/tdx: Define supported KVM features for TDX
> X-Mailer: git-send-email 2.34.1
> 
> For TDX, only limited KVM PV features are supported.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/tdx.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


