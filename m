Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3256F3C27D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztdm-0007NH-2D; Tue, 10 Mar 2026 05:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vztdj-0007N8-P5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:44:35 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vztdf-000135-U6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773135871; x=1804671871;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=MrmlwMaR5qsp2Mqj7d67QrgUH2lh+bET5BjqThSMmJA=;
 b=NBIt5rAoAlLsi1BE3YyDQksjArZwYnH9mHJJOQ5qucTAGPWVZQon9K1Q
 1wnNSONA+AcXceIFzuwXxLPUQwPxR6csFy+24hZWpWYV8vHEZ0Dy9cArl
 +caqpGLIZQMyc4Y8UyZjX0ZViAv/RJlOvpGln72W6tvH6LkXTEM5iS2kE
 QsSIkSKbTWVR1HGE1IWngtKdvPHI7KoAlPSDN/hgoSTtvVdm2uBpwm92u
 BFg90W0zvS/CyBGiwn3ouMz3Gim4ro+Ob87nyfLPDcvpsXeWE3FvQv19l
 vCPGJVh8i6XiLKD/EWy+vqq2FJ3lGarJnQo/MUYTQpJ03I6tXssnQ1Ilr g==;
X-CSE-ConnectionGUID: O6GOLm9HRbWrPQUFpuQ3WQ==
X-CSE-MsgGUID: VXKvnyd4S9ufmizpxnB+mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="84887881"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="84887881"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 02:44:27 -0700
X-CSE-ConnectionGUID: D/D7s6vHQLiRaXgDOyGRng==
X-CSE-MsgGUID: maBz2Z05RpiemXAdIi5SLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="224517803"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 10 Mar 2026 02:44:26 -0700
Date: Tue, 10 Mar 2026 18:10:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PULL 22/28] hw/i386/pc: Remove pc_compat_2_12[] array
Message-ID: <aa/uHBPRvmt3pZeG@intel.com>
References: <20260305105215.302571-1-thuth@redhat.com>
 <20260305105215.302571-23-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305105215.302571-23-thuth@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> -GlobalProperty pc_compat_2_12[] = {
> -    { TYPE_X86_CPU, "legacy-cache", "on" },

It seems "legacy-cache" property could be deprecated later.

> -    { TYPE_X86_CPU, "topoext", "off" },
> -    { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
> -    { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
> -};
> -const size_t pc_compat_2_12_len = G_N_ELEMENTS(pc_compat_2_12);

Thanks,
Zhao


