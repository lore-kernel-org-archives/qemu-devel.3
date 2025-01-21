Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA04C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDt7-0001xw-8H; Tue, 21 Jan 2025 08:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taDsn-0001tS-Ky
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:01:33 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taDsj-0006nV-MF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737464486; x=1769000486;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=v8RFzRdFY88AYI0wAuLKa0kSBnhRT8ckYNiub9jnlzE=;
 b=nOldkWGSJFdzyYmzzn/zB0UMO2BAUI12Q6Ql0LLTpR15sYqByw+lFXoh
 pUh7jSlQxAN+puPJP9ek9B1oN6NBhrIkYwvGRuaPo9fzZAqPfBiR6Z2+h
 O3Ph9J2eCNZ3yVPcfyYpIkBLhZCaY5wk7mtFvMkH1DR5Lr2G6C3hweP1f
 nlSd2WISAjdzqbxE8VO/n1gGONKwm0MF7vp4usLv4BV0Lt+qSHbEOgjCT
 MWLDAD3MEiULDJq3JcechRpZWyqX9vMPhkpr6ADqI2gxoJTppWVx2jY2Z
 3BzH/tVi0Jn+8hT0uHDhY8QpaBsDcHgii2IbZFVDpkD+6/O/hr/wf6hxr Q==;
X-CSE-ConnectionGUID: XLRlieDMQda9vENpqPjfYQ==
X-CSE-MsgGUID: sC5LSRchQruXZ5NiMYGj8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="48371323"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="48371323"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 05:01:07 -0800
X-CSE-ConnectionGUID: Ztsp7ZkXRR+kLEqDniWE2g==
X-CSE-MsgGUID: BuC4fh72QfK/qGpZAbGFcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="107402327"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 21 Jan 2025 05:01:05 -0800
Date: Tue, 21 Jan 2025 21:20:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com, zhao1.liu@linux.intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 3/4] target/i386: Add new CPU model ClearwaterForest
Message-ID: <Z4+fG8CTfRPqQ5x4@intel.com>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-4-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121020650.1899618-4-tao1.su@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Tue, Jan 21, 2025 at 10:06:49AM +0800, Tao Su wrote:
> Date: Tue, 21 Jan 2025 10:06:49 +0800
> From: Tao Su <tao1.su@linux.intel.com>
> Subject: [PATCH 3/4] target/i386: Add new CPU model ClearwaterForest
> X-Mailer: git-send-email 2.34.1
> 
> According to table 1-2 in Intel Architecture Instruction Set Extensions
> and Future Features (rev 056) [1], ClearwaterForest has the following new
> features which have already been virtualized:
> 
>     - AVX-VNNI-INT16 CPUID.(EAX=7,ECX=1):EDX[bit 10]
>     - SHA512 CPUID.(EAX=7,ECX=1):EAX[bit 0]
>     - SM3 CPUID.(EAX=7,ECX=1):EAX[bit 1]
>     - SM4 CPUID.(EAX=7,ECX=1):EAX[bit 2]
> 
> Add above features to new CPU model ClearwaterForest. Comparing with
> SierraForest, ClearwaterForest bare-metal contains all features of
> SierraForest-v2 CPU model and adds:
> 
>     - PREFETCHI CPUID.(EAX=7,ECX=1):EDX[bit 14]
>     - DDPD_U CPUID.(EAX=7,ECX=2):EDX[bit 3]
>     - BHI_NO IA32_ARCH_CAPABILITIES[bit 20]
> 
> Add above and all features of SierraForest-v2 CPU model to new CPU model
> ClearwaterForest.
> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/671368
> 
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
>  target/i386/cpu.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/cpu.h |  33 +++++++++---
>  2 files changed, 162 insertions(+), 6 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


