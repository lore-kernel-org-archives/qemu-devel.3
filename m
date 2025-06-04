Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A0FC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 01:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMcy8-0006PF-UT; Tue, 03 Jun 2025 21:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMcy6-0006NS-3Z
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 21:31:02 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMcy2-0006KN-Mt
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 21:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749000659; x=1780536659;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IHfBvoFU6LtxKPLy7BIfFHf5uu/2TIlBFeIop9bjzJc=;
 b=lbAG1bo/vYPyuV9GsiFqoNKR6qMD38cLbhLi1L+p4x3gBsrhg/vd3kfI
 Q9n5vc8HvkHu7XqnVhs17ySVlUjRH8T2nuwo71BZ/mUIUlrmb1C+kYaWw
 V5Ub9vkqeE6YNDcEuvNwGlwaPixeBsTxGsDe6Owgf5OUFbaAKVvcKsVxA
 h3pfUvWOTy+A0i5JcU6ORXgQcY6OZshFpmzd/ETvkBm6dYUTjjO74IUCR
 HBNjP3EQE6tvEpsUpB3P42a59JBFf6z27FAtY2QUvNKwEmm52N84qwdc1
 PmIjrBu1fg5IR/ftKIf4fLnddSwAso1gRV06o2NTlNmQGvGWCKBLmTcBL Q==;
X-CSE-ConnectionGUID: Yt+NN0siTK6iekJKDSgqXw==
X-CSE-MsgGUID: 2ZPRG1mSRIWXZoZA3BXOzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50922747"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; d="scan'208";a="50922747"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 18:30:54 -0700
X-CSE-ConnectionGUID: 3BPggVVoQsS12nDTzZycTA==
X-CSE-MsgGUID: LXmr38a3QH6wZxtnICllxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; d="scan'208";a="182201574"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 18:30:52 -0700
Message-ID: <4ac8c8b0-700b-4fac-ae4c-6531fc6b682e@intel.com>
Date: Wed, 4 Jun 2025 09:30:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/i386/pc: Remove deprecated 2.10, 2.11 and 2.12 PC
 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250501223522.99772-1-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250501223522.99772-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 5/2/2025 6:35 AM, Philippe Mathieu-Daudé wrote:
> The versioned 'pc' and 'q35' machines up to 2.12 been marked
> as deprecated two releases ago, and are older than 6 years,
> so according to our support policy we can remove them.
> 
> This series includes the 2.10 to 2.12 machines removal.

For this series,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Besides, please add more patches to remove hw_compat_2_{10,11,12}

> Philippe Mathieu-Daudé (8):
>    hw/i386/pc: Remove deprecated pc-q35-2.10 and pc-i440fx-2.10 machines
>    hw/i386/pc: Remove pc_compat_2_10[] array
>    hw/pci-host/i440fx: Remove I440FXState::pci_hole64_fix field
>    hw/pci-host/q35: Remove Q35PCIHost::pci_hole64_fix field
>    hw/i386/pc: Remove deprecated pc-q35-2.11 and pc-i440fx-2.11 machines
>    hw/i386/pc: Remove pc_compat_2_11[] array
>    hw/i386/pc: Remove deprecated pc-q35-2.12 and pc-i440fx-2.12 machines
>    hw/i386/pc: Remove pc_compat_2_12[] array
> 
>   include/hw/i386/pc.h      |  9 ---------
>   include/hw/pci-host/q35.h |  1 -
>   hw/i386/pc.c              | 21 ---------------------
>   hw/i386/pc_piix.c         | 28 ----------------------------
>   hw/i386/pc_q35.c          | 29 -----------------------------
>   hw/pci-host/i440fx.c      |  7 ++-----
>   hw/pci-host/q35.c         |  6 ++----
>   7 files changed, 4 insertions(+), 97 deletions(-)
> 


