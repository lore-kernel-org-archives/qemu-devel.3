Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C440AFF60E7
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7UKb-0001d5-Ai; Tue, 31 Mar 2026 04:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w7UKV-0001ac-Fn
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:20:07 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w7UKL-0003aM-Te
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774945198; x=1806481198;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=gJWdUwK586GJa5VW9QzsnFo5SqAsT+/I4KOMATeviiU=;
 b=Yz3JvBRlKHh5DRIfaLN66Eo2Z7wDkuqfjlyUn/bgJFwLGauNV69m8N2J
 3sXKE6U3bkgK/AKanKvOgOxcp5vOY5SSnBVEG1t530m9PfSKzzrUtpOR7
 P2eRKRdfK/oWQpE4aUxpGIS0xhcObe65rNL3UDC2HUbN0sFQqa78GR1yL
 ForSAZ0JQSS9hc1HHsycMNLzykInvvIAZ0M2lmMXucf7Qh3vmx1qoTPJz
 vdwLyU66CqNZWLTavjO/zkQrRhKFhkXJmj54Q334kxn2KLzUuDf2S4K5l
 t0BNo3/s767VEhUWs7afHsZq4I+S6cmGN801jKIOvxMbIvq/3KMll8Fd2 w==;
X-CSE-ConnectionGUID: iaZImlXIScWdycW80+kj3g==
X-CSE-MsgGUID: 8P0NS2lCSiCfa1bE1eyUhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87342467"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="87342467"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 01:19:55 -0700
X-CSE-ConnectionGUID: jecDXw03TyW5D+uveOUWRQ==
X-CSE-MsgGUID: aVx8ZMafQG6N/YIspLgExA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="222999326"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 31 Mar 2026 01:19:54 -0700
Date: Tue, 31 Mar 2026 16:46:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386: Treat qtest like TCG for supported-features
Message-ID: <acuJ1c5J3sTVzvy0@intel.com>
References: <20260330151437.1787008-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330151437.1787008-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

On Mon, Mar 30, 2026 at 04:14:37PM +0100, Peter Maydell wrote:
> Date: Mon, 30 Mar 2026 16:14:37 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH] target/i386: Treat qtest like TCG for supported-features
> X-Mailer: git-send-email 2.43.0
> 
> In x86_cpu_get_supported_feature_word() we figure out the supported
> features differently for each accelerator. The default case is
> "set all feature bits"; however this triggers a warning because
> it enables two features which conflict with each other:
> 
> $ ./build/x86/qemu-system-x86_64   -cpu max -accel qtest -S
> qemu-system-x86_64: warning: this feature conflicts with APX: CPUID[eax=07h,ecx=00h].EBX.mpx [bit 14]
> qemu-system-x86_64: warning: this feature conflicts with MPX: CPUID[eax=07h,ecx=01h].EDX.apxf [bit 21]
> 
> Treat qtest like TCG here, to avoid the complaint.

I see, this is a proper way to resolve this for max cpu with qtest,

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

so,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> ---
> This suggests to me that the default case is not something
> we ever want to be in, and we should instead be exhaustively
> enumerating the accelerators and asserting if we don't know
> how to handle this for the accelerator in use. But there are
> several accelerators that we don't have code for here...

yes, when I have some time, I¡¯d see if I can sort this out, to clarify
what accelerator needs to be covered here.

Regards,
Zhao


