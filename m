Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA693C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 08:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd4ur-0005AH-NK; Thu, 22 Feb 2024 03:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd4up-00059Y-LD; Thu, 22 Feb 2024 03:58:51 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd4um-0006fr-Nj; Thu, 22 Feb 2024 03:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708592329; x=1740128329;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=tK9iJX/PGYxRl6fiAZa/42LQrJHsPlP9pIA09b3Rftw=;
 b=Y0wAjawUA+QHx1QjsjkegLtW6ZLCErZU0alCpEia8M79bmQUOnbqa1lN
 Mo3ZWxOvFv86JXAPPgBXpORc8iHgo6faxVD+s3IVNQsvtG6+7F+iOB/SU
 5H/LZ0BczXAs4pB+y484+K0nB9IKOb+gihVEkIKGSMac/GYK4B+J05Wdb
 Q7Vx12KPK2ujj/kKV0QClqiqO1yYyXy9CeQi9FcufpHrQkULJiNVPd7Ou
 1aeh6PcqbqO5CXSuf6sboQTYCAu2DPyPynjoeaRFZHtfSPNMvo6d3XFiS
 NGP1ttqPbMwmJhD8XolwvXipK2W7JwSYSUCnJ9c7V83TqdMCxndWMwkQz A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2688574"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2688574"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 00:58:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5367625"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 22 Feb 2024 00:58:39 -0800
Date: Thu, 22 Feb 2024 17:12:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 01/21] hw/i386/pc: Do not use C99 mixed-declarations style
Message-ID: <ZdcP9A7n5w7RJqii@intel.com>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216110313.17039-2-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Philippe,

On Fri, Feb 16, 2024 at 12:02:52PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 16 Feb 2024 12:02:52 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 01/21] hw/i386/pc: Do not use C99 mixed-declarations style
> X-Mailer: git-send-email 2.41.0
> 
> QEMU's coding style generally forbids C99 mixed declarations.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/i386/pc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 196827531a..3c00a87317 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1227,6 +1227,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>       */
>      if (pcms->hpet_enabled) {
>          qemu_irq rtc_irq;
> +        uint8_t compat;
>  
>          hpet = qdev_try_new(TYPE_HPET);
>          if (!hpet) {
> @@ -1238,8 +1239,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>           * use IRQ16~23, IRQ8 and IRQ2.  If the user has already set
>           * the property, use whatever mask they specified.
>           */
> -        uint8_t compat = object_property_get_uint(OBJECT(hpet),
> -                HPET_INTCAP, NULL);
> +        compat = object_property_get_uint(OBJECT(hpet), HPET_INTCAP, NULL);
>          if (!compat) {
>              qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
>          }

"compat" is only used here to check. So, what about getting rid of this
variable?

if (!object_property_get_uint(OBJECT(hpet), HPET_INTCAP, NULL)) {
    qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
}


