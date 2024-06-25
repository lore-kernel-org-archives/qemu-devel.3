Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8866FC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 16:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM8do-0002q2-JQ; Tue, 25 Jun 2024 12:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sM8dn-0002pZ-35; Tue, 25 Jun 2024 12:03:31 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sM8dk-0001jV-Gc; Tue, 25 Jun 2024 12:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719331408; x=1750867408;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aqtR3/KU2BgFo+Rt5bpSW19OPfURXowtgqJrCWMwTto=;
 b=M/k1gba+zXVJzjhdMDMKmzRZ1AVW3dIkZPLDy8RH4PEqclNVqsrXsK4a
 wrB5b/NQ5vwLzrhWej/W2Ki2LTVUDc3FuLINgqTXoYwT9AFktuLroGbSR
 Zbmpl/xSvhI7k5DpEYwNXXcStNcxrOmZS6Zw7463uI62iHhVoEB6hTGrM
 JieHVAy0Fn6OFCNKQttX6KL12Sh1iePHgLe8Oum2q4zwwlM10XUb30BuP
 zHm7RWKXzmkZdFWgKvrM+whfotROCz6M1Y2vl1Zvkwm6kvcZA3J8I1LTi
 espeyPmiQ4Wx+ZP1PJ/KYFCiBomKRVBiiNGD2SVdlpPjUQ2RaJIgSfeWd w==;
X-CSE-ConnectionGUID: 257frDDiTQecGAo6pj5a4w==
X-CSE-MsgGUID: O6m6bWjDR7C6nJ2ej6AWhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20138445"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; d="scan'208";a="20138445"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2024 09:03:25 -0700
X-CSE-ConnectionGUID: q1TTNfjCSSOZQQDuzM+KzA==
X-CSE-MsgGUID: G9h8UzVKSUKFgZcCn1LrSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; d="scan'208";a="43765999"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 25 Jun 2024 09:03:21 -0700
Date: Wed, 26 Jun 2024 00:18:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [RFC PATCH v3 5/5] DO NOT MERGE: replace TYPE_PL011 with
 x-pl011-rust in arm virt machine
Message-ID: <Znrt77XOc2YBNZyM@intel.com>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <229703c7f4394691f254b02c012ee0d7dcf57afb.1718827153.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <229703c7f4394691f254b02c012ee0d7dcf57afb.1718827153.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Manos,

On Wed, Jun 19, 2024 at 11:14:02PM +0300, Manos Pitsidianakis wrote:
> Date: Wed, 19 Jun 2024 23:14:02 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [RFC PATCH v3 5/5] DO NOT MERGE: replace TYPE_PL011 with
>  x-pl011-rust in arm virt machine
> X-Mailer: git-send-email 2.44.0
> 
> Convenience patch for testing the rust device.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/arm/virt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3c93c0c0a6..f33b58ae0d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -912,7 +912,11 @@ static void create_uart(const VirtMachineState *vms, int uart,
>      int irq = vms->irqmap[uart];
>      const char compat[] = "arm,pl011\0arm,primecell";
>      const char clocknames[] = "uartclk\0apb_pclk";
> +#ifdef CONFIG_WITH_RUST
> +    DeviceState *dev = qdev_new("x-pl011-rust");
> +#else
>      DeviceState *dev = qdev_new(TYPE_PL011);
> +#endif
>      SysBusDevice *s = SYS_BUS_DEVICE(dev);
>      MachineState *ms = MACHINE(vms);
>

I realized that if we want to merge the rust pl011 device, then this
patch or similar enablement support is necessary, otherwise, the rust
code is only used for compilation and cannot actually be run...

This is also an open for the devices that are rewrite in Rust.

I think there should be an option for the user to choose whether to
enable pl011 in C or pl011 in Rust. What do you think?

Perhaps the easiest way to enable rust pl011 is to add an option for
virt machine... But that's certainly not a long-term approach. I think
the ideal way would be to allow rust pl011 to be specified in the
command line via -device, but this approach would mean allowing the
user to create pl011 and would require changes to the current buildin
pl011's creation logic.

-Zhao



