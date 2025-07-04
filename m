Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412DAC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcfS-0003bq-OD; Fri, 04 Jul 2025 05:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcfQ-0003aj-3V
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:25:12 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcfO-0007kk-GH
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751621110; x=1783157110;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=1G1vHj6KsAFh8sSR29Gt3reJ/1Jynq1HBGf+gWFEEAk=;
 b=RxZbhc+t+r2d2d83DcN2LLKdvG4+TgAO4zQzRLV+hUwKG5eFlJBtHiEW
 JdBbyiDvLRSqpWQZ2d67QS6f/dtUDbEyzIYW9ptNZt68RAG2IQNaYl5vC
 6Efmx5dWUIlnnfYk/rahtC2nhqsfJ7Alwrdu+wdiJR/wbF5cbDBjvkUdW
 ZF1f43yr91vxcnMwFJlyj803o+HKKILtKNlFt7G/jrn7z2bsEDhAyhFZO
 +tTst77qdyQ75v8aelArDk8KOT8bObqiESGX8VD8oknfbhpLsYmy78XJZ
 UnXmq3ZTP/ArJ+elOVkPcTQJoBFmQ56IfZjVpGK98rOGXHGd2/0Zfzc4P w==;
X-CSE-ConnectionGUID: GEqEn9/SSaWZ+o2ZmOmHlQ==
X-CSE-MsgGUID: Z4/az96XQNeaq0ssNtjg8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57763820"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="57763820"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:25:06 -0700
X-CSE-ConnectionGUID: CBNQeFOjR0CWifVKZHKukw==
X-CSE-MsgGUID: vPv5uAZRRfacf6E+zBF6OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154012784"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 04 Jul 2025 02:25:06 -0700
Date: Fri, 4 Jul 2025 17:46:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 15/39] accel/hvf: Move per-cpu method declarations to
 hvf-accel-ops.c
Message-ID: <aGei91NDZuCigN3i@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-16-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-16-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jul 03, 2025 at 07:32:21PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:21 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 15/39] accel/hvf: Move per-cpu method declarations to
>  hvf-accel-ops.c
> X-Mailer: git-send-email 2.49.0
> 
> hvf-all.c aims to contain the generic accel methods (TYPE_ACCEL),
> while hvf-accel-ops.c the per-vcpu methods (TYPE_ACCEL_OPS).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/hvf/hvf-accel-ops.c | 30 ++++++++++++++++++++++++++++++
>  accel/hvf/hvf-all.c       | 28 ----------------------------
>  2 files changed, 30 insertions(+), 28 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


