Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032A3E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNaAn-0000FD-Nj; Tue, 17 Dec 2024 11:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNaAk-0008Sj-Sf
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:11:47 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNaAf-0003op-Hv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734451902; x=1765987902;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ADb5LrrPM45Iltt7daJmxHcrLCSyT/62xcSAmOFT7SE=;
 b=Gdo3MioeXLe/hvxQHGRJBSIWdWWmGd7RN1tucQc5mIZcrpY+en9nEqyY
 hc0YsVbhK8+iyLJ48jalCQT9z/bbIM7zXSVo45rFo0VfUZdjx0oKalg0i
 BCM46zjJUewWSTGWn//1tiLblzLjwNIBtmhNmzEywVRONBc6VM9MQH9cY
 zUcYRPbxSyocKGSEcjhCEd3HF7NTzkc+MJMn7gvdbJ0+soXaPCtI5rNX1
 8UeOQSlgoYc/29s4wyMDjH7d1o+3fk46GEpOtPuFYyUpaJRVbhAKDUfNY
 f6XUbB+w8EusVfrDGGihOKACCLZ0QKEhj8DNt9FxuHL2w3voqMeXBdZ7k w==;
X-CSE-ConnectionGUID: KuCxuSyQQ2ucXCzpLDTLoA==
X-CSE-MsgGUID: ZMjf6emnTV6DRwPuPolmvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34778435"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; d="scan'208";a="34778435"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 08:06:08 -0800
X-CSE-ConnectionGUID: rozFU8KBSmWf/b67cOyFeA==
X-CSE-MsgGUID: 8ivHx4rvS5SaWz8EmpyQAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; d="scan'208";a="98151026"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 17 Dec 2024 08:06:06 -0800
Date: Wed, 18 Dec 2024 00:24:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Anton Johansson <anjo@rev.ng>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 3/3] system/accel-ops: Remove unnecessary
 'exec/cpu-common.h' header
Message-ID: <Z2Glzcf9pWE3BVLq@intel.com>
References: <20241217151305.29196-1-philmd@linaro.org>
 <20241217151305.29196-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217151305.29196-4-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 17, 2024 at 04:13:05PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 17 Dec 2024 16:13:05 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 3/3] system/accel-ops: Remove unnecessary
>  'exec/cpu-common.h' header
> X-Mailer: git-send-email 2.45.2
> 
> Since commit c4b3f46c151 ("include/exec: Move vaddr defines to
> separate file") we only need to include "exec/vaddr.h" to get
> the 'vaddr' type definition, no need for "exec/cpu-common.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/sysemu/accel-ops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


