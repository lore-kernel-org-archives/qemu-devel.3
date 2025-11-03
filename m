Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261AFCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvmj-0000pf-Bq; Mon, 03 Nov 2025 09:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vFvmc-0000oV-BJ; Mon, 03 Nov 2025 09:43:47 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vFvmU-0004n3-Tw; Mon, 03 Nov 2025 09:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762181019; x=1793717019;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=rgzIUif7BymigCeBn3RihGliGYi9spsPrRXf4EkFZzg=;
 b=coyaW7Z8YPo+nv2u9gN3WPJy04UHnyjDg+m2eSnSKFuEYVAtYK4mngva
 drCfMqlCK4n5k9f2PmflypIgfyyj8gqr7+eK/hm9Sld3MFq3WRfPOO6XS
 lYfvGM3Qq+1CXj9l3GDjte0UBKNDmrzwU5+x/YQ6wspDZ5CcvI8+8OoRh
 QzjYaiEM8j8L+aCx1d8Tuk/DyGmzVsGyH1MQWAUsgZN6sd8fMx7Hq2XCl
 l+6r6RzYNHeKgD/KLvTkQaTIRYHtXGOxR2gMCVHHYibZDVLHm7pGMin4K
 l1Tfvr+cQsS12YU37+0hSvMoetXFCrR7m3nqRZfszFTARUkgFvSZiPQuN A==;
X-CSE-ConnectionGUID: DPX3Ag8BRsSSen2m5PNj6A==
X-CSE-MsgGUID: C/wY5EvjSk2F/PKDPnlaqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="66868994"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="66868994"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 06:43:26 -0800
X-CSE-ConnectionGUID: E98YbumfTHSdNpgxCn67lQ==
X-CSE-MsgGUID: kqvQMZqJSSaMwLYQkvXNUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="224130157"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 03 Nov 2025 06:43:18 -0800
Date: Mon, 3 Nov 2025 23:05:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 00/27] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC
 machines
Message-ID: <aQjEvN7zbBay8yDy@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20251031113344.7cb11540@imammedo-mac>
 <0942717b-214f-4e08-9e2a-6b87ded991c9@linaro.org>
 <aQTEKyQjqIIGtyP0@intel.com> <20251031152345.65b2caed@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031152345.65b2caed@fedora>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Oct 31, 2025 at 03:23:45PM +0100, Igor Mammedov wrote:
> Date: Fri, 31 Oct 2025 15:23:45 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v4 00/27] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC
>  machines
> X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
> 
> On Fri, 31 Oct 2025 22:14:03 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Hi Igor and Philippe,
> > 
> > > On 31/10/25 11:33, Igor Mammedov wrote:  
> > > > On Thu,  8 May 2025 15:35:23 +0200
> > > > Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> > > > 
> > > > Are you planning to resping it?
> > > > (if yes, I can provide you with a fixed 2/27 patch that removes all legacy cpu hp leftovers)  
> > > 
> > > Sorry, no, I already burned all the x86 credits I had for 2025 :S  
> > 
> > Don't say that, thanks for your efforts! :-)
> > 
> > > Zhao kindly offered to help with respin :)  
> > 
> > I haven't forgotten about this. I also plan to help it move forward
> > in the coming weeks.
> 
> in this case, I'll send reworked patch (not really tested)
> as a reply 2/27 so you could incorporate it on respin.

Thank Igor! I'll include that patch into v5.

Regards,
Zhao


