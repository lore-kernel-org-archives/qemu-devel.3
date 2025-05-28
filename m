Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5382BC54F30
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 03:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK72g-0004op-C4; Tue, 27 May 2025 23:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK72e-0004oN-73; Tue, 27 May 2025 23:01:20 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK72b-0006S6-K1; Tue, 27 May 2025 23:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748401278; x=1779937278;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WgzNyy4qqPHJXHfjJIL9IocmXHUqurpovENlFbO1Ge8=;
 b=H4OTjifvFgdCtYV032ofp1PJrd7FPkz2ltqXC9L1XOqB0rm1S+peNyKO
 qb9wT35tWaQKWduVFoiJmCjG7G2DUVPRryVdZq/pQuHFDjc/xV3cbG6a8
 9gcAd1qLMibmu37cbpau7TOtsseFD7+swu1GMvGnLcGVMB4OGZRt6AwjW
 zujkE0D+UdxTRHvLLTCOMdjgvcRMGivZLgJC3GBgcVUrUhSpe+8eD0Z0P
 mBKDgmdapT2xnTG0PTk85SDGC0d5e6jD/be6F1lnZUbayp0msqlyLvJe9
 veeFoEU+Jgg1qUzlRHfGqYHlWodvbJ2xkUwXzqPORIWFSIfhG2WaePfww Q==;
X-CSE-ConnectionGUID: tMnJfQG9R42CslVCmTnMgQ==
X-CSE-MsgGUID: VQJdSPOhRxCygsqHG97YIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="54062899"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="54062899"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 20:01:13 -0700
X-CSE-ConnectionGUID: jPqGQtsZSrKUlCRhGx3M4g==
X-CSE-MsgGUID: 7YyDX5YBTRmPLRDy5enuwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="143109749"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 20:01:08 -0700
Message-ID: <5a9ec134-d4cb-49d5-8747-437616e3c36a@intel.com>
Date: Wed, 28 May 2025 11:01:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC
 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:
> (series reviewed)
> 
> Since v3:
> - Fixed 2 issues noticed by Thomas (floppy fallback, e1000)
> 
> Since v2:
> - Removed qtest in test-x86-cpuid-compat.c
> 
> Since v1:
> - Fixed issues noticed by Thomas
> 
> The versioned 'pc' and 'q35' machines up to 2.12 been marked
> as deprecated two releases ago, and are older than 6 years,
> so according to our support policy we can remove them.
> 
> This series only includes the 2.4 and 2.5 machines removal,
> as it is a big enough number of LoC removed. Rest will
> follow. Highlight is the legacy fw_cfg API removal :)

Overall it looks good to me, except the below 4 patches
>    target/i386/cpu: Remove X86CPU::check_cpuid field

This one gets hard NAK because it changes the default behavior of QEMU.

>    hw/net/e1000: Remove unused E1000_FLAG_MAC flag
>    hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
>    hw/block/fdc-isa: Remove 'fallback' property

I'm not sure about the three. Because Unlike other properties removed by 
this series, the property name removed by above three patches don't have 
a 'x-' prefix.

It should be OK to remove properties with 'x-' prefix, but I'm not sure 
about the ones without it. There might be user using them explicitly. If 
so, remove them needs to go through standard deprecation process.

