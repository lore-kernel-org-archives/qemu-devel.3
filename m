Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C439FCA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 07:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqo8K-0001ec-E7; Tue, 26 Aug 2025 03:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqo8I-0001do-NJ
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 03:30:18 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqo8F-00057b-MO
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 03:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756193415; x=1787729415;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=Z9WYOvBUKB42Hk/qGWIya7qsYyH1Bg2jeLGbN+FjqXU=;
 b=QUrAhf1G14ITL5bAFVuf0AGehxuRH5RnTcUCtslq1jxOqXk3boTT+0jr
 hLPBmnTUMTZcY8NkbpkiGrbwKWQww/7Ic4OEboQloTQtfo01yaq/H5mMC
 +rqXm6L2iVtqbaYmqHqfZ4VL0skVogkzg/3+K5bYMyrkBHdIxvc48m7Ll
 poisgEXiY3O7RooNdrrH/lgndZ/tPHlyoJXVJJKhXTBfaKBNBdn5VVnPi
 T7jamjICGIcZVfKcRaE1PpIieRhT4hC908jsVaq1QT8GH6D6Qoodxcdxn
 uJEFOtBF/CPi9L+NTm6RyV7/UEu83f+gFt+5jn04rpauhjuJph6IfIZWV Q==;
X-CSE-ConnectionGUID: ifuMbwwZTLGBfKCGc3p/gA==
X-CSE-MsgGUID: cjshuiRbRWaKGc7vsUtbow==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="62235862"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="62235862"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 00:30:11 -0700
X-CSE-ConnectionGUID: ZjkRAkeqQFG2NV8OZA0qLA==
X-CSE-MsgGUID: e6QyJHnWQa6C5jzYqY0jyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169905145"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 00:30:09 -0700
Message-ID: <2116ca60-63e4-456f-93a4-f83b5325b760@intel.com>
Date: Tue, 26 Aug 2025 15:30:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/19] hw/i386/pc_piix.c: remove include for loader.h
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-3-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-3-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.703, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
> This header is not required since the loader functionality is handled separately
> by pc_memory_init() in pc.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 5720b6b556..bc8fbe46a1 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -28,7 +28,6 @@
>   #include "qemu/units.h"
>   #include "hw/char/parallel-isa.h"
>   #include "hw/dma/i8257.h"
> -#include "hw/loader.h"
>   #include "hw/i386/x86.h"
>   #include "hw/i386/pc.h"
>   #include "hw/i386/apic.h"


