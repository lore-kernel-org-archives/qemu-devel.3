Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724A5C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBX4E-0006xP-Kw; Mon, 27 May 2024 05:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBX48-0006wn-Lk; Mon, 27 May 2024 05:54:52 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBX47-0008VE-0U; Mon, 27 May 2024 05:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716803691; x=1748339691;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=bOlElLfh6dD1KI2TE0d8lBG+ud9MK9TNyMp5tAHlTXg=;
 b=kME7HF+he4QmF8F3VfFDsN+I2ja6D27C8gfi6Kmt4H+Dvk3GFB4mOvP4
 4o7y4vrf6N/0Q2UQiM2t0oww5MSxmBrayKiyeaQRi7HDP7MvphViFccpM
 pCIdUYpetrnfUTOLK7imRt5ykLEITd5VXtn3pCw4I/i6T5iXSG6WLoPaJ
 6ELnkq0sMPa75IoQp2BK81hWoFk0ZTzKI0lRKcWB7kJeuh33Xjpw7N0au
 ANhAacwq6IE7ipr7KFTLmCvDhBWj2HisitjKN7PNNfMrAPOEXiGjHjdcP
 Jy1YR8LNvTHDo331RgPHa3byDmFP5332y+iUNZWKwDb+o9cS7O0enVLvo Q==;
X-CSE-ConnectionGUID: oI3F8sg+QOaWOTGTUTZRig==
X-CSE-MsgGUID: hZY58YXYTwSJZFzGaqDJmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12952318"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="12952318"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 02:54:49 -0700
X-CSE-ConnectionGUID: J2W3lqz3ReiazifHEbmQ8g==
X-CSE-MsgGUID: 2F3XYJnzREybJy59y+QhJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="34599385"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 27 May 2024 02:54:40 -0700
Date: Mon, 27 May 2024 18:10:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Shaoqin Huang <shahuang@redhat.com>
Subject: Re: [PATCH V11 2/8] hw/acpi: Move CPU ctrl-dev MMIO region len macro
 to common header file
Message-ID: <ZlRb+uLWumeVUN0w@intel.com>
References: <20240522211111.232114-1-salil.mehta@huawei.com>
 <20240522211111.232114-3-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240522211111.232114-3-salil.mehta@huawei.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 22, 2024 at 10:11:05PM +0100, Salil Mehta via wrote:
> Date: Wed, 22 May 2024 22:11:05 +0100
> From: Salil Mehta via <qemu-devel@nongnu.org>
> Subject: [PATCH V11 2/8] hw/acpi: Move CPU ctrl-dev MMIO region len macro
>  to common header file
> X-Mailer: git-send-email 2.34.1
> 
> CPU ctrl-dev MMIO region length could be used in ACPI GED and various other
> architecture specific places. Move ACPI_CPU_HOTPLUG_REG_LEN macro to more
> appropriate common header file.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> ---
>  hw/acpi/cpu.c                 | 2 +-
>  include/hw/acpi/cpu_hotplug.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


