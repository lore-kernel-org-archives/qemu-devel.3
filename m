Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C09FD2D9A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxii-0003bV-5X; Tue, 10 Mar 2026 10:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxic-0003XE-Im
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:05:54 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxiZ-00034N-G5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773151552; x=1804687552;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=9UniQJEj05IKolV8mR5I8CxbeQ+YLcKPQURYL1ijEeI=;
 b=aTt+MVdlz+q5pHhHSNBZxgDx9UnclePgS+rpqqLoE55d7FhQV+xh81vy
 0zmHoENQOzGSaywbCjJmWU8BilpDY+HB0cIAcrk7ofh8slOjuv2LmUMBy
 KNE+q5tK/ElVOxQU5qbEacnRPp0IhmT5p2/33hDLLwSP9e44DRWfKAsgl
 i1TzXNVdMuo23Y2zDlLTFC3KSrDygSBJgDCVL5mhOctr7hrsIP3Aih7O5
 XhqZfuhvPZDGARw6C/kB8ZoG1otKO09QIdiyaJ0mxNkktNigKoxQjkjhW
 1MPR3zjUzmE8BxKsutUnc5SrXy5ITvXsyNy+sKI/rITOEwMikcLCfWf7z g==;
X-CSE-ConnectionGUID: ZUBHB7flT4a84tAskxtogQ==
X-CSE-MsgGUID: fyMIdMi+S8im/Se4w8KHwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74099733"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="74099733"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 07:05:49 -0700
X-CSE-ConnectionGUID: rwMn1u76RI+GbvP+Ika/Tg==
X-CSE-MsgGUID: 0DCAirShR5uxF0fWpgTi0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="220167677"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 10 Mar 2026 07:05:47 -0700
Date: Tue, 10 Mar 2026 22:31:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v2 08/10] hw/core/machine: Remove the hw_compat_3_1[] array
Message-ID: <abArXNEWVJ/RXMgP@intel.com>
References: <20260309145013.44327-1-philmd@linaro.org>
 <20260309145013.44327-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309145013.44327-9-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 09, 2026 at 03:50:10PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon,  9 Mar 2026 15:50:10 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 08/10] hw/core/machine: Remove the hw_compat_3_1[] array
> X-Mailer: git-send-email 2.53.0
> 
> The hw_compat_3_1[] array was only used by the pc-q35-3.1
> and pc-i440fx-3.1 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20260307152635.83893-9-philmd@linaro.org>
> ---
>  include/hw/core/boards.h |  3 ---
>  hw/core/machine.c        | 17 -----------------
>  2 files changed, 20 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


