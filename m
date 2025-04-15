Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEACC369B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 03:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Wid-0007Im-Hu; Mon, 14 Apr 2025 23:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4Wib-0007I8-D3
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 23:12:13 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4WiZ-0007nJ-8h
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 23:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744686731; x=1776222731;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3uk1h3UsxTcB89dp1X2744ua4dfY8GB/c69QrY1EmVc=;
 b=WPeD6apqDVzB2Q23eNoonsg93Krg8b8hroCxSVsRtXRU1rCah347yGLg
 psCsnXmh7yGpPUNoLVkkWMGd0HoDkY6o0aZxXRRnvOpSeYGELOt2VzgvN
 6CpZw6dwa7nb3p6GFNAnQe1+vM7IqqPyxkltk3txSRAz170L1DMMzHHY7
 8s6Tx16xBvKxf45xko77HL1RH6L4eRbD+Gb94DhZtErIuG3hsxUYZe2d7
 xw48moVuGDHiUNGJidIx2rGih7HQr39+5FfnBTGGSWK+z74ybMD5vW+NC
 fHk+Ct9MYVVTKnqXM0TWhyNUu5DbrXd/rRse4NxA9fcysWm1RLeTmKsy7 g==;
X-CSE-ConnectionGUID: 1neAf04PT/2iha2MOVTMwA==
X-CSE-MsgGUID: LU3AOlo4SlCD8GeJzUi0dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="57169923"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="57169923"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 20:12:08 -0700
X-CSE-ConnectionGUID: ZMXbcFwKRm6A2J80wC8O5Q==
X-CSE-MsgGUID: /JE0U7D7SpOLMLIeODso0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="135168807"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 14 Apr 2025 20:12:07 -0700
Date: Tue, 15 Apr 2025 11:32:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4] target/i386: Fix model number of Zhaoxin YongFeng
 vCPU template
Message-ID: <Z/3TaqVa4vza8iHm@intel.com>
References: <20250415024545.517897-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024545.517897-1-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Mon, Apr 14, 2025 at 10:45:44PM -0400, Ewan Hai wrote:
> Date: Mon, 14 Apr 2025 22:45:44 -0400
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v4] target/i386: Fix model number of Zhaoxin YongFeng vCPU
>  template
> X-Mailer: git-send-email 2.34.1
> 
> The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
> The correct value is 0x5b. This mistake occurred because the extended
> model bits in cpuid[eax=0x1].eax were overlooked, and only the base
> model was used.
> 
> Using the wrong model number can affect guest behavior. One known issue
> is that vPMU (which relies on the model number) may fail to operate
> correctly.
> 
> This patch corrects the model field by introducing a new vCPU version.
> 
> Additionally, it adds a "Preferred CPU models for Zhaoxin x86 hosts"
> section in docs/system/cpu-models-x86.rst.inc to recommend the
> appropriate Zhaoxin CPU model(s).
> 
> Fixes: ff04bc1ac4 ("target/i386: Introduce Zhaoxin Yongfeng CPU model")
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>

LGTM,

> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks,
Zhao


