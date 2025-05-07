Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF06FC369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 06:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCY9H-0005LG-7e; Wed, 07 May 2025 02:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCY9D-0005L3-FM
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:20:51 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCY9B-0007qP-0l
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746598849; x=1778134849;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZMxogRC/2Ywa6Bpb4bilAwDm3gSz9d9HL+WAMMsR+Ec=;
 b=Tmjbo9TbfejLmkWsj6JMeK7chj6XcFO2Ov0GRLH6ZzktCGE1owaelGag
 LlhlVPZ4GDvO+Et0REfTy/+b2ZjILG2B/gT5vVPNxXaD2rEghffzipYGc
 JdMdrq4uvIqi19W5eZA5KaiaBwMGg/kRzlDfq9tIfIXJbSfNN0xpuI3vN
 2MwhaUIDAafpxhxDTa4Nfm8rTdrTowcDRBKa01596ONS50Xi0Edu53DVB
 DceLCWfJVZ/iwBpPOpxz/FMT89qJRxPr1j73uzTAJQBX9G3+NbSllE5+/
 11jaEUBlWE2pc8yAwEUB4nLdjyL5AXm/9/1OZ8hymYZBlY6uGTqr9o5Wl A==;
X-CSE-ConnectionGUID: 7LuL6g7sS1aj6+D7OUK9Xw==
X-CSE-MsgGUID: Uy0P/o8WQF6+spSJBuFWZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48180264"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="48180264"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 23:20:44 -0700
X-CSE-ConnectionGUID: I6qFCfgDSdihzrmf5M6Aog==
X-CSE-MsgGUID: iJyOiSQES5qy6BvoHK3Zhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="135857518"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 23:20:39 -0700
Date: Wed, 7 May 2025 14:41:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 05/19] hw/i386/x86: Remove
 X86MachineClass::fwcfg_dma_enabled field
Message-ID: <aBsApFCmVrgtNMMT@intel.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502185652.67370-6-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Fri, May 02, 2025 at 08:56:37PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri,  2 May 2025 20:56:37 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 05/19] hw/i386/x86: Remove
>  X86MachineClass::fwcfg_dma_enabled field
> X-Mailer: git-send-email 2.47.1
> 
> The X86MachineClass::fwcfg_dma_enabled boolean was only used
> by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
> removed. Remove it and simplify.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/i386/x86.h | 2 --
>  hw/i386/microvm.c     | 3 ---
>  hw/i386/multiboot.c   | 7 +------
>  hw/i386/x86-common.c  | 3 +--
>  hw/i386/x86.c         | 2 --
>  5 files changed, 2 insertions(+), 15 deletions(-)

Note for myself: fwcfg_dma_enabled is not a property.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


