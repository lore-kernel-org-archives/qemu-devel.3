Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AC2C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 06:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCYDv-0008LZ-ET; Wed, 07 May 2025 02:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCYDt-0008LL-Va
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:25:41 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCYDs-0008P0-1j
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746599140; x=1778135140;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=oOQM0dcuI5vXA+PePUN0hZ6lMT/U6Qsqt5NjTsDanU0=;
 b=KuvRubJG+DYleGITEOgkYSM9UNIGSjrEEY4jeFjjYzn5K5cFlO7wlC9L
 3BUvIWvq/GCCjNQJu15r/kYTQM18aKCSvG7uLqXlbTV934ncz0QXmLwRe
 wjBCvyfb3SQNNlC78xos2dAXzkhNGoDrEdlTDZv5qkrjIiGVKyqrrEjRh
 f1SPaa2f1HFd/qHxzYu/a2yC6Tb6T/0788OfsJRIDPsaCihrXvM4XCDwh
 a/unEu7bNmQ8vEjF8XMqxgewlGHF756YknLBdukIR42XdDhucNT/7a3uC
 0vyT8TnSufC9S3Nmf0670mBTv9yk0dOp4nd/nfklawkGZ5xzAt73O/Uhr A==;
X-CSE-ConnectionGUID: zckOo3ZkQOSJdHwJUlc68w==
X-CSE-MsgGUID: KoX2CuKbRtyArRTjUOijgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59297048"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="59297048"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 23:25:37 -0700
X-CSE-ConnectionGUID: u/ClRLdHTbayVRLL/UagGg==
X-CSE-MsgGUID: Vo6YCvMbQbu5Sbu/WYaQbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="141037737"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 06 May 2025 23:25:33 -0700
Date: Wed, 7 May 2025 14:46:34 +0800
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
Subject: Re: [PATCH v3 06/19] hw/nvram/fw_cfg: Remove
 fw_cfg_io_properties::dma_enabled
Message-ID: <aBsBylkuSbY81HPl@intel.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502185652.67370-7-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Fri, May 02, 2025 at 08:56:38PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri,  2 May 2025 20:56:38 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 06/19] hw/nvram/fw_cfg: Remove
>  fw_cfg_io_properties::dma_enabled
> X-Mailer: git-send-email 2.47.1
> 
> Now than all calls to fw_cfg_init_io_dma() pass DMA arguments,
> the 'dma_enabled' of the TYPE_FW_CFG_IO type is not used anymore.
> Remove it, simplifying fw_cfg_init_io_dma() and fw_cfg_io_realize().
> 
> Note, we can not remove the equivalent in fw_cfg_mem_properties[]
> because it is still used in HPPA and MIPS Loongson3 machines:
> 
>   $ git grep -w fw_cfg_init_mem
>   hw/hppa/machine.c:204:    fw_cfg = fw_cfg_init_mem(addr, addr + 4);
>   hw/mips/loongson3_virt.c:289:    fw_cfg = fw_cfg_init_mem(cfg_addr, cfg_addr + 8, 8);

The argument here is wrong. :-)
 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/nvram/fw_cfg.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


