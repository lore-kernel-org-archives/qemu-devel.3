Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55DBCA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 12:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsVi-00084U-R3; Tue, 26 Aug 2025 08:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsVW-00082q-VT
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:10:38 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsVQ-0006RB-QG
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756210229; x=1787746229;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=QeHROvFbjDI8CzKljtM7VDsN08beSNXqLRgiET8AhXI=;
 b=n7JC0z3/Q+gfl2z2pw3QZjXpUT621oRyL5bjfOMLy8zjkv/jWL409uj7
 jUDGd0cNJTKprjI6gqG0CD4ZCX6X07qFCxfPKkNT1wKa2PNNSSFWPX4YQ
 hlpdOznx/AtY6NzXWdY/ww/G3c5WWjxXiRV9WUa72PRMgOM0KUq7p2Zti
 d2KNt5OCGIwAlz6OphdesCs+TpFb45DAChFCo1PFJ6pvfELF7WTwuKPPr
 0Wzw/fc+KVcLlY5M3Dq1jC7JqUHBckCwcSGlhhi7JJbVn7lkVNdRfpGwB
 kVmUqUOHIDn+Dflwe/2FsvcQK1kzhnX35lB5G25By33sxeLzwqt32gzp2 w==;
X-CSE-ConnectionGUID: FK1K7/QhRBCB9VVjv9+J5g==
X-CSE-MsgGUID: npC3rO6qSZ2YO6Vp6wY0vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58587256"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58587256"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:10:22 -0700
X-CSE-ConnectionGUID: l2rBj53xSOOWu/CmosFTCA==
X-CSE-MsgGUID: TwFa8dxmQxi5u6KWzmkGig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="174821928"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:10:20 -0700
Message-ID: <a2b32f7b-a094-480d-b835-a01da1c62da8@intel.com>
Date: Tue, 26 Aug 2025 20:10:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/19] hw/i386/pc_piix.c: remove unused headers after
 isapc machine split
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-18-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-18-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.751, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/22/2025 8:12 PM, Mark Cave-Ayland wrote:
> The headers for isapc-only devices can be removed from pc_piix.c since they are
> no longer used by the i440fx-pc machine.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 05713662e4..5babdc3e4c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -27,19 +27,16 @@
>   
>   #include "qemu/units.h"
>   #include "hw/char/parallel-isa.h"
> -#include "hw/dma/i8257.h"
>   #include "hw/i386/x86.h"
>   #include "hw/i386/pc.h"
>   #include "hw/i386/apic.h"
>   #include "hw/pci-host/i440fx.h"
> -#include "hw/rtc/mc146818rtc.h"
>   #include "hw/southbridge/piix.h"
>   #include "hw/display/ramfb.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_ids.h"
>   #include "hw/usb.h"
>   #include "net/net.h"
> -#include "hw/ide/isa.h"
>   #include "hw/ide/pci.h"
>   #include "hw/irq.h"
>   #include "system/kvm.h"


