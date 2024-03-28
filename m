Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842CEC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 06:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpjIk-0006p2-Hu; Thu, 28 Mar 2024 02:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpjIi-0006og-Vn
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:31:49 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpjIf-0002m5-Mo
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711607506; x=1743143506;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ya2nFRIyAOQJ0gCXxwKPx/um0va6AQwIyofwmLWNp/4=;
 b=YAIvSUy7wv2Cg6rtU3KNJeO+Po3d3Su0q/JBfcRO1gAJ5Qn4Q50c9oHx
 zUqPMKk6psqgeFihGJxjuBF9YFf55GGvQuQovjTZ8PFPrY5V3by+BvYft
 fxVufXsVLKVXok1XFEQhhyXlzyvdy6DztqUKem3XXRaooaVB3JEGFKozX
 CDI6EMJiAx9O8RDBjopTJL0nq3EPDXlj2jrozfx91OrNCPetMiPAfSgrz
 qCSNbaETHiUmtJv9ywMmMKKgrrJlfSO0EwVrIrOrHJsACu+/QAScdNHEi
 weI0G4y4k0u2x4V/sx1udBL6J0MUe7yDXHvbeDcH4Am1cw7Y9OCXa6/Tk w==;
X-CSE-ConnectionGUID: /jaDuNUyTd+/pdHj8alI7g==
X-CSE-MsgGUID: 9e2hUmVESV6jyyhJ3pCfcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6856717"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6856717"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 23:31:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="16951517"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 27 Mar 2024 23:31:39 -0700
Date: Thu, 28 Mar 2024 14:45:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH-for-9.1 v2 08/21] target/i386/kvm: Remove
 x86_cpu_change_kvm_default() and 'kvm-cpu.h'
Message-ID: <ZgUSD6Zw0Unp+1Te@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-9-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Wed, Mar 27, 2024 at 10:51:10AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:10 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 08/21] target/i386/kvm: Remove
>  x86_cpu_change_kvm_default() and 'kvm-cpu.h'
> X-Mailer: git-send-email 2.41.0
> 
> x86_cpu_change_kvm_default() was only used out of kvm-cpu.c by
> the pc-i440fx-2.1 machine, which got removed. Make it static,
> and remove its declaration. "kvm-cpu.h" is now empty, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20240305134221.30924-8-philmd@linaro.org>
> ---
>  target/i386/kvm/kvm-cpu.h | 41 ---------------------------------------
>  target/i386/kvm/kvm-cpu.c |  3 +--
>  2 files changed, 1 insertion(+), 43 deletions(-)
>  delete mode 100644 target/i386/kvm/kvm-cpu.h
> 
> diff --git a/target/i386/kvm/kvm-cpu.h b/target/i386/kvm/kvm-cpu.h
> deleted file mode 100644
> index e858ca21e5..0000000000
> --- a/target/i386/kvm/kvm-cpu.h
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/*
> - * i386 KVM CPU type and functions
> - *
> - *  Copyright (c) 2003 Fabrice Bellard
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -#ifndef KVM_CPU_H
> -#define KVM_CPU_H
> -
> -#ifdef CONFIG_KVM
> -/*
> - * Change the value of a KVM-specific default
> - *
> - * If value is NULL, no default will be set and the original
> - * value from the CPU model table will be kept.
> - *
> - * It is valid to call this function only for properties that
> - * are already present in the kvm_default_props table.
> - */
> -void x86_cpu_change_kvm_default(const char *prop, const char *value);

Features in kvm_default_props[] are supposed to be supported on the
oldest kernal version (v4.5, from docs/system/target-i386.rst).

So future PC machines will not use this interface to adjust
compatibility with the oldest v4.5 kernel. And it makes sense to stop
exposing this interface in the header. Thus,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


