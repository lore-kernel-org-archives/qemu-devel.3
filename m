Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE9CD68BEE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 08:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW9MR-0006Ch-RF; Thu, 18 Dec 2025 03:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW9MO-0006BI-R8; Thu, 18 Dec 2025 03:27:45 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW9MN-0003JU-3O; Thu, 18 Dec 2025 03:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766046463; x=1797582463;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=87pQbD5cl/LGVBm5WnNCSWEvXxIu+1EkBmBLhk2bxhQ=;
 b=f6svgUfrnNPiEDWveKKxSHP4UR6d+g3+J7BueskyOATdxfJS3qxigL9t
 7qnvtz6ttS+thCs/MwtTUF2CKwUe8PXXAtcujPgMkj0JoQzrT6Z6hfS/7
 yIjf6mh0yx3u4UVA5tt2lR0QCunlsQPxzOBgmgK9bV2VlDWqBAtykHHNx
 G9zGhrmFaRHkB6jXflUlUizrGIJlsxRegX3gDPHCLUWz/zPPodMIEBWxf
 A269TLGveKSD9c1fwc7uTX7uogIiTjVUBQrJUtmaQfvrxqGZqP+qJAfPt
 bn2l+ksFoIcz+t8NgTHQERShngV+Xa000TeZRMdLwa6A0VthugJXohKbR w==;
X-CSE-ConnectionGUID: z2hzdK2iSnGYGvo+ny4FIw==
X-CSE-MsgGUID: 3H35EdbtTR+sH3nYyM8lag==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="79116926"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="79116926"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2025 00:27:39 -0800
X-CSE-ConnectionGUID: T2f6QqbJQQ2Ih9Et+4SPtw==
X-CSE-MsgGUID: eLyUpW0hT6C/H6V7W7wayg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="199001956"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 18 Dec 2025 00:27:36 -0800
Date: Thu, 18 Dec 2025 16:52:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH-for-11.0 v6 08/13] hw/sparc64/sun4u: Use
 fw_cfg_init_io_nodma()
Message-ID: <aUPAysAYqTPAfgzD@intel.com>
References: <20251203060942.57851-1-philmd@linaro.org>
 <20251203060942.57851-9-philmd@linaro.org>
 <aTBccn2LIv7puGzR@intel.com>
 <05f92a77-7587-4441-a252-01e4705a6892@linaro.org>
 <c03820b8-7745-4b8e-8e69-a37c872257f8@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c03820b8-7745-4b8e-8e69-a37c872257f8@ilande.co.uk>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> > > I think maybe one reason to use `ebus` is because...
> > > 
> > > > -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > > > -    memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
> > >                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > ... because the parent region is managed by ebus.
> > > 
> > > Perhaps we should add another argument: Object *parent?
> > 
> > I thought about it but don't think so, all instances but this one use
> > the machine container.
> > 
> > I'll improve the description.
> 
> The reason that the fw_cfg device lives under ebus on sun4u is because the
> ebus device is effectively a PCI-ISA bridge, and the fw_cfg port is mapped
> into I/O address space along with other ISA devices. I'm not sure that
> setting the parent to the machine is the right thing to do here.

Thanks Philippe and Mark, IIUC, ebus doesn't have the hotplug use case,
so it lives long enough like the sun4u/v machine, therefore replacing
the parent object "ebus" with machine is safe.

And it might be better to explicitly set ebus as not supporting hotplug
(via dc->hotpluggable = false).

Adding a "parent" argument to the generic interface fw_cfg_init_io_nodma()
doesn't seem necessary at the moment, since using the default machine as
parent seems enough to meet all current needs in QEMU.

What do you think?

Regards,
Zhao


