Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680EEE7717F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 02:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLCa0-0003PA-SR; Tue, 10 Dec 2024 21:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLCZx-0003Oz-W8
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 21:35:58 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLCZu-000469-9N
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 21:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733884554; x=1765420554;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xW4/4eTof//ZWgA2pABeuts83EI7xp8TFkcaPye/Xcc=;
 b=T5BbIuNM0DRISMuHRRNKT3w9KvNI8Znta3W7JufBmIAocxFjheVGQmwr
 kFBpElFqnfpowVcTB8dobH6OXH/fqxPMxVB7o0NdODAt6CCmivKXvwuA7
 gaZRxnt0t5wweA+9//jV0dPyLZwRMdCLgjgyM6itkEdA02TOoE5TLLbI8
 6F08qP4o5RS5xN9bQW/f9tiWK3bFK3ON0ke6btrz8EN3oh3k61Th8ksJv
 I2VqTMPFWpxQUqfYUbTY1m8lCClGZ8xk+OfxULf2IQSVdUvtNjMf7hg0m
 9JunIx9phaXT3gVk9aNNl5/UZGdSRNz5SIJb0/w3vK6Ic0Zg+17UHjA2w g==;
X-CSE-ConnectionGUID: lx6yJe+PRpKi8CqWhJ/zMg==
X-CSE-MsgGUID: K94ia15ASESyc/7nnz4Fqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="56730608"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="56730608"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 18:35:52 -0800
X-CSE-ConnectionGUID: Uz48BeXzSX6kLjOQPpHj2Q==
X-CSE-MsgGUID: hOmMFJ4bTvyJ/9THPEVkMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="95431400"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 10 Dec 2024 18:35:50 -0800
Date: Wed, 11 Dec 2024 10:54:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 1/4] i386/topology: Update the comment of
 x86_apicid_from_topo_ids()
Message-ID: <Z1j+zDk0w66tReuf@intel.com>
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
 <20241205145716.472456-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205145716.472456-2-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Thu, Dec 05, 2024 at 09:57:13AM -0500, Xiaoyao Li wrote:
> Date: Thu, 5 Dec 2024 09:57:13 -0500
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [RFC PATCH 1/4] i386/topology: Update the comment of
>  x86_apicid_from_topo_ids()
> X-Mailer: git-send-email 2.34.1
> 
> Update the comment of x86_apicid_from_topo_ids() to match the current
> implementation,
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  include/hw/i386/topology.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index b2c8bf2de158..21b65219a5ca 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -121,9 +121,10 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
>  }
>  
>  /*
> - * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> + * Make APIC ID for the CPU based on topology and IDs of each topology level.

Maybe "based on sub-topology ID"?

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


