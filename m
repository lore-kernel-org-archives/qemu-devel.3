Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690C6FD2D9F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxhz-00038e-Na; Tue, 10 Mar 2026 10:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxhx-00038O-LI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:05:13 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxhv-0002Uj-R1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773151512; x=1804687512;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=LUDOe8MgUaKAVDwwsTYtifrbiJm8m91oWSOcamGzB/g=;
 b=cZBA3NHAJpDrswwi0NZqGG7XqSVqzQjCADxWFQHsfFPXKKHvRZsotxad
 o8qNUIaZEr+8a4deeFYqtbIpq1PtkVn0GyEjAYLNolyB4gBzoF74lH/Y3
 5x6/OuIz24brpwivk4moI6cvvd401nENnFxN0JhZ6XhfXNvv8BNRsBkXA
 0ljI/a/QJ1+sXTZAa5suOtLl/48nfVmaDCjFlE5GTDOCk3L00m0XZIjH5
 N8VrjqyKKDn2sdLpeBN2LLxEzfymDfD90rs9PVUmeS9TULnyHh2We1GKc
 IEKFgVAo9a5wz7R2OAVw5j4C1bBNDWdC1ErERYAjlULuOPb3wXQfrIjUb w==;
X-CSE-ConnectionGUID: NGPB4KiPT02DOFpzZMjuug==
X-CSE-MsgGUID: +IaxYzkgTeyT21SVDLSOIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="84831527"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="84831527"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 07:05:09 -0700
X-CSE-ConnectionGUID: mvQZ8pChTY6wTAS5ftJBkg==
X-CSE-MsgGUID: /DCOJn1CSnCMwh1KxHdaxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="216900926"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 10 Mar 2026 07:05:08 -0700
Date: Tue, 10 Mar 2026 22:31:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 07/10] target/i386/cpu: Remove
 X86CPU::intel_pt_auto_level field
Message-ID: <abArNU4IdyxWUaJj@intel.com>
References: <20260309145013.44327-1-philmd@linaro.org>
 <20260309145013.44327-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309145013.44327-8-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 09, 2026 at 03:50:09PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon,  9 Mar 2026 15:50:09 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 07/10] target/i386/cpu: Remove
>  X86CPU::intel_pt_auto_level field
> X-Mailer: git-send-email 2.53.0
> 
> The X86CPU::intel_pt_auto_level boolean was only set in the
> pc_compat_3_1[] array, via the 'x-intel-pt-auto-level=off'
> property. We removed all machines using that array, let's
> emove that property and all the code around it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20260307152635.83893-8-philmd@linaro.org>
> ---
>  target/i386/cpu.h |  3 ---
>  target/i386/cpu.c | 10 +---------
>  2 files changed, 1 insertion(+), 12 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


