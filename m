Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81A7C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6r1-00021l-56; Thu, 05 Jun 2025 05:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uN6qv-0001yo-3A; Thu, 05 Jun 2025 05:25:37 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uN6qt-0003Bk-8G; Thu, 05 Jun 2025 05:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749115535; x=1780651535;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6gcqC2RNFKk8w35jVZyxPY8r9CAuU5Rebn8W7k05UwU=;
 b=fRLoEj9u1RFdR/vA7RFYyyzmX7ZZCdQ675BZ0fJESzjjmr+uaxG9DlO1
 pibl6OQeOXmKigWd3Z9Rzw8f4/mgN+0ReXhul9DbbP4RLH3IlI6vFPv9r
 TlQpYBzKT2xGJawE6FqUFSqwHzmVs4WvJCs2Cj4PZ2nDqs4nSYG+knDGi
 eQN+kAFickhGE/uZyOm9cHnIW8TXiPLFW5sWlSW51+3nwqq4xSp9G/WVs
 P3Sg+HKR85Q2fwwUm+IbVbW5mh9gR0aeDp7XMbQhixAAEqCsgKXdPj6IF
 edSo6MZJUMZ2TZY+0M7UOaiznMUp4TCQfv5LFYLshsCpz5c5nXCgNemq6 w==;
X-CSE-ConnectionGUID: 9ERmceTZR8aqFngDzQg+5w==
X-CSE-MsgGUID: ojPv6zgBQ+e9zR91IOCF4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="50464009"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="50464009"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 02:25:32 -0700
X-CSE-ConnectionGUID: IYhamantQ56dn2/LnifzdA==
X-CSE-MsgGUID: eF6omVKUTCSLIo68uDvO0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="182663019"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 05 Jun 2025 02:25:28 -0700
Date: Thu, 5 Jun 2025 17:46:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: mst@redhat.com, anisinha@redhat.com, armbru@redhat.com,
 berrange@redhat.com, dapeng1.mi@linux.intel.com,
 eric.auger@redhat.com, farman@linux.ibm.com,
 gustavo.romero@linaro.org, imammedo@redhat.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, mtosatti@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com,
 shannon.zhaosl@gmail.com, yangyicong@hisilicon.com, maobibo@loongson.cn
Subject: Re: [PATCH v12 5/6] tests/qtest/bios-table-test: testing new ARM
 ACPI PPTT topology
Message-ID: <aEFngNQBQlfyfkci@intel.com>
References: <20250604133439.1592-1-alireza.sanaee@huawei.com>
 <20250604133439.1592-6-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604133439.1592-6-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

On Wed, Jun 04, 2025 at 02:34:38PM +0100, Alireza Sanaee wrote:
> Date: Wed, 4 Jun 2025 14:34:38 +0100
> From: Alireza Sanaee <alireza.sanaee@huawei.com>
> Subject: [PATCH v12 5/6] tests/qtest/bios-table-test: testing new ARM ACPI
>  PPTT topology
> X-Mailer: git-send-email 2.34.1
> 
> Test new PPTT topolopy with cache representation.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  tests/qtest/bios-tables-test.c | 4 ++++
>  1 file changed, 4 insertions(+)> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


