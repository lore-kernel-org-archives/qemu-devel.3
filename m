Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B2ECD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBOn-0003fB-Ja; Wed, 13 May 2026 11:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNBOk-0003eR-Im; Wed, 13 May 2026 11:21:22 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNBOj-00019G-4I; Wed, 13 May 2026 11:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778685681; x=1810221681;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8d8FEsJ08AQ3jjbf8P8FrpPf4MQLE019fz7xfwdX4kM=;
 b=MgrFpZiismwlDpI3o841TqNQzKhjRsBh4dkfn8Okd4mAM1lA5C0YLsft
 I2/8bKmww/o1WUk49nldk//5Lfq5Nw69xTGpFMO2wXCwFjY0V3s8AZPop
 QGiY+PKokNuw0bgSvrSaqIlhM4ETvnRmjTLO0YlMaja0QAKS2bk84TOlz
 u/konQhf/lv8yFeA1rShg5bOQmmdQzkzQvHgYtriIRoKr5pHyTylcxKsS
 lLQ0ZcOA8Og5sXwOZyigxhrl2azY5f0exPcNsHlRBv7W7PxX7+DgUnCAI
 qVcLCj8UoJ1c4uhF5s8VL3lLuuLCt0bUMrF7TsOsecbQqNa/1pyNMp5Iy g==;
X-CSE-ConnectionGUID: BCl0p7EATw6ugzj9WFOq8Q==
X-CSE-MsgGUID: QTYxD1zQQUqGRAbnUHBoTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83489630"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="83489630"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 08:21:18 -0700
X-CSE-ConnectionGUID: KFrErarhSZCC8e/tujVOcQ==
X-CSE-MsgGUID: veyZ84wRRNmuUZIDbPss9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="261616103"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 13 May 2026 08:21:15 -0700
Date: Wed, 13 May 2026 23:49:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, philmd@linaro.org, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 05/21] tests: acpi: x86/q35: add WDAT table test case
Message-ID: <agSdbMmgDWjcUimC@intel.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-6-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303092532.2410177-6-imammedo@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 03, 2026 at 10:25:16AM +0100, Igor Mammedov wrote:
> Date: Tue,  3 Mar 2026 10:25:16 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: [PATCH v2 05/21] tests: acpi: x86/q35: add WDAT table test case
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


