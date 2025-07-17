Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CBCC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 05:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucH5e-00024F-8b; Thu, 17 Jul 2025 01:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucH5b-0001zX-QU
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 01:23:27 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucH5X-0007Ut-6r
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 01:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752729803; x=1784265803;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9Fhv/QjkT6O0yeWVr4zGc1peSiQkk7BjPQhYuQTS2oU=;
 b=PWd/jykiaRoQZvBVnqGkeJVJ1We/C7JNTQfR7SobWKcZCGVZ8G6hupYj
 1fxFToejIHArzGU/UtEkgHIkjDOgAmjaxKP8vk3wUMEx0U1vNj37QRNZU
 kyHRNRNStj3KdiAcPlbheaIO8zs1g1jAk1SSSd5ULyPpA70nSIMTSd2fe
 BWjjACt0lpP7G100t1YifxF87v2eherAoB7vU84hPPBQT9GgmrB5iTNoq
 Xl8XWiHNcoTB/mfJhSDjwszDcE7Njn47Dww0KPFM0c9z1Jem/XjFOUFB0
 faIeSatPog9HEYEzlF9E2QeJMchVUDR57Q+Z7UMUuTMjNE37filx6vQBo w==;
X-CSE-ConnectionGUID: eLRyQTBQS2S1oTVBdAkvoQ==
X-CSE-MsgGUID: hulymZ5HReaoVGqHy1Y28A==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="66059195"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="66059195"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 22:23:19 -0700
X-CSE-ConnectionGUID: YeASdhTZTWCggnWFc/KfOg==
X-CSE-MsgGUID: tH8Cdoy5QQuApE9PsTEuAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="162229882"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 22:23:18 -0700
Message-ID: <ac7fd8dc-6dea-4ed4-8af0-5e04f1ae8ded@intel.com>
Date: Thu, 17 Jul 2025 13:23:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386: Build SEV only for 64-bit target
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250716071554.377356-1-clg@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250716071554.377356-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 7/16/2025 3:15 PM, Cédric Le Goater wrote:
> Recent changes broke build on 32-bit host. Since there is no 32-bit
> support, restrict SEV to 64-bit.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 14d23e27b580b2d5ea3aa4c07ba066f21a62e348..5139d2308777114e76a789c4f850fa20f3fa754f 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -4,7 +4,7 @@ config X86_FW_OVMF
>   config SEV
>       bool
>       select X86_FW_OVMF
> -    depends on KVM
> +    depends on KVM && X86_64
>   
>   config SGX
>       bool


