Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E4BC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDFx-0007FA-Ge; Tue, 21 Jan 2025 07:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taDFt-0007Ek-PU
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:21:19 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taDFo-0000fk-Ah
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737462073; x=1768998073;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fzP2k6GMlja+qySGoa4iYhs0uQUl+tM4pvRMasjKeRo=;
 b=eYjn/ETrKhYvF/TqUixGEMwTj9Iu81hECmixBG+nYiFqAuN6eCraiBll
 kYIp45Tw5Wo/GNPxQ59PeNBdWKz3Dp4VBvoAyjmPZ090sw819qrA/xAGv
 eifQdTidRVp4YfAOE9uXw/UBHoUSc2D23/SqitJQMwgqQ6y65OEGdz86g
 i3NDdHQrbvJ0u6kr48xpCXUVwB22ezucHQNFGhJCAOFb/kJwf+7PStHTj
 Dp+/BxazoPBLbmAFOEi7ta3AwnpDjiIObMFDZ0wcnn99BaBWHG6+12q26
 /uha4opqjQbFWVBd+NQp/z0ugMwvQ1cYopn5S+HePlyom0UtDcrRdCty+ Q==;
X-CSE-ConnectionGUID: xNAtjbi+THKKKIgFMCNvTA==
X-CSE-MsgGUID: 1lBxkZWJSS62rgux2KR9oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="25470506"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="25470506"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 04:21:09 -0800
X-CSE-ConnectionGUID: RMQpioqgS/Oq3QboV0XSfw==
X-CSE-MsgGUID: WH3mJRCBQh2tPMKdkcrnlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="137663949"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 21 Jan 2025 04:21:07 -0800
Date: Tue, 21 Jan 2025 20:40:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com, zhao1.liu@linux.intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 1/4] target/i386: Introduce SierraForest-v2 model
Message-ID: <Z4+VvdP/rsd3f5gR@intel.com>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-2-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121020650.1899618-2-tao1.su@linux.intel.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
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

On Tue, Jan 21, 2025 at 10:06:47AM +0800, Tao Su wrote:
> Date: Tue, 21 Jan 2025 10:06:47 +0800
> From: Tao Su <tao1.su@linux.intel.com>
> Subject: [PATCH 1/4] target/i386: Introduce SierraForest-v2 model
> X-Mailer: git-send-email 2.34.1
> 
> Update SierraForest CPU model to add LAM, 4 bits indicating certain bits
> of IA32_SPEC_CTR are supported(intel-psfd, ipred-ctrl, rrsba-ctrl,
> bhi-ctrl) and the missing features(ss, tsc-adjust, cldemote, movdiri,
> movdir64b)
> 
> Also add GDS-NO and RFDS-NO to indicate the related vulnerabilities are
> mitigated in stepping 3.
> 
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
>  target/i386/cpu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


