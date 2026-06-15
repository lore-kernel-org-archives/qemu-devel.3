Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26428CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ2Su-0000XW-7x; Mon, 15 Jun 2026 04:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wZ2St-0000Uz-0c
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:14:39 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wZ2Sr-0002U4-1J
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781511277; x=1813047277;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zsBBXOfUwYqZRHBzwJF8plN0BHTKna76evx1hDPSeB0=;
 b=ErnNvKbM1nIaONJRXsfwcZk7E4gXpqV8ivA4Cuu9OvtHrhQDDMt0cHHT
 xOtX0pxDpwopDNlVOb6u0ffee8l5KnvdzqvMSV3b1ZIiLsVroWp2PHi+t
 3Yvr8E6GYQK49+BUF37VQ83moGrBuvmjzCog8ELIsam90NkIWvYmyq68+
 RGcX/xJwry3sYjNc5m/KqjLUR/MkSwJMNsMxYfLu1eLefRbsCTaH/v51J
 yQKM3nMdTEJL+6IpSPOZSr4g2uI0sBcn2VL1pL7ekOG///4ViVKaEYR4i
 1z87OUlr7XgXmH+94sKlihx/9uW6jiRPyPqY9zmqrRdaAjl53mIsvCS7d g==;
X-CSE-ConnectionGUID: AmeCZUvrSc224cdnwi7tVQ==
X-CSE-MsgGUID: DShO+iIgSCClhqtO61EtNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="104916674"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="104916674"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 01:14:34 -0700
X-CSE-ConnectionGUID: rtNXlZWrS8KZ5xNaJAqijQ==
X-CSE-MsgGUID: YpurzJLVTuunL6mUlFqTCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="271101636"
Received: from unknown (HELO [10.239.158.65]) ([10.239.158.65])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 01:14:33 -0700
Message-ID: <e8674902-1bcd-40eb-94fa-94f4a30f601a@intel.com>
Date: Mon, 15 Jun 2026 16:14:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] qemu-options cleanup and deprecate
 memory-encryption
To: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260512084458.622465-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260512084458.622465-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Ping on this series.

All the patches except patch 4 got R-b tag. Can we get the series into 
QEMU 11.1?

On 5/12/2026 4:44 PM, Xiaoyao Li wrote:
> This is the v2 of previous "[PATCH 0/5] qemu-optios: Fix, cleanup and
> add description of tdx-guest"[1] (Sorry that long time went)
> 
> Patch 1 in previous v1 is dropped because a similar patch has been
> merged already.
> 
> Patch 5 to deprecate memory-encryption is added in this v2, following
> Daniel's suggestion.
> 
> 
> - v1 [1]
> https://lore.kernel.org/qemu-devel/20250714091953.448226-1-xiaoyao.li@intel.com/
> 
> Xiaoyao Li (5):
>    i386/sev: Remove the example that references memory-encryption
>    qemu-options: Change memory-encryption to confidential-guest-support
>      in the example
>    qemu-options: Add confidential-guest-support to machine options
>    qemu-options: Add description of tdx-guest object
>    machine: Deprecate memory-encryption
> 
>   docs/about/deprecated.rst |  7 ++++++
>   hw/core/machine.c         |  2 ++
>   qemu-options.hx           | 52 ++++++++++++++++++++++++++++++++++++---
>   target/i386/sev.c         |  4 ---
>   4 files changed, 58 insertions(+), 7 deletions(-)
> 


