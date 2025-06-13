Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A057C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 02:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPuV8-0000v0-D8; Thu, 12 Jun 2025 22:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPuV6-0000uQ-5J; Thu, 12 Jun 2025 22:50:40 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPuV3-00079F-TH; Thu, 12 Jun 2025 22:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749783038; x=1781319038;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5ME7Rr8GvHZ6NDCucaH5UuynuC83NzCm9tbVAL5cvlc=;
 b=f3qzy3m8YV3gReciIqLdOSVKMDwM5q+9QLApSXhtuUTV4DzRjO1NfxFe
 Ktlt0kTcQZ/LZu7EHWz9RaA+DIEViDRPJPc2Rd+XZYVeW/CVMY4MdyPo6
 /xY9Xavs3WoRT3CpNvFaNloGvgTJEMlsWFCyeFXlBgAYz+JrVSb5N3Uqz
 3zcD+UXnGjLwiLHlBCJX2NQzDh+AT5S+23ijyRoHu06h/BLIwSrz2XBpe
 MLm2PKEj/pMleSuVvwrpiyYWB7IjulZjSrYJurIPYU4Gk387B4HapoFSb
 Q3veENW1cjpMhrrTaW3vIx3hrf1Y+IjN9rYCTaqhleKduuervFqu8M9BV Q==;
X-CSE-ConnectionGUID: Yvdg6JxsSm+rgJ4zI6VaFg==
X-CSE-MsgGUID: UxqcDA3TR4aqqyQSxQuk2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55660093"
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; d="scan'208";a="55660093"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 19:50:34 -0700
X-CSE-ConnectionGUID: ppVKj6rnRjiRlVBMbUpxew==
X-CSE-MsgGUID: YqCXiCPBRUepAG6sEQhETg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; d="scan'208";a="148063587"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 12 Jun 2025 19:50:28 -0700
Date: Fri, 13 Jun 2025 11:11:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 armbru@redhat.com, berrange@redhat.com, dapeng1.mi@linux.intel.com,
 eric.auger@redhat.com, farman@linux.ibm.com,
 gustavo.romero@linaro.org, imammedo@redhat.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mtosatti@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com,
 shannon.zhaosl@gmail.com, yangyicong@hisilicon.com
Subject: Re: [PATCH v13 2/7] hw/core/machine: topology functions capabilities
 added
Message-ID: <aEuW8qIlDwJi44t6@intel.com>
References: <20250611155618.351-1-alireza.sanaee@huawei.com>
 <20250611155618.351-3-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611155618.351-3-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jun 11, 2025 at 04:56:13PM +0100, Alireza Sanaee wrote:
> Date: Wed, 11 Jun 2025 16:56:13 +0100
> From: Alireza Sanaee <alireza.sanaee@huawei.com>
> Subject: [PATCH v13 2/7] hw/core/machine: topology functions capabilities
>  added
> X-Mailer: git-send-email 2.34.1
> 
> Add two functions one of which finds the lowest level cache defined in
> the cache description input, and the other checks if caches are defined
> at a particular level.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/core/machine-smp.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/boards.h   |  7 ++++++
>  2 files changed, 59 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


