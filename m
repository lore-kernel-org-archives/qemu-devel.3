Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05884CED25D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 03:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy14B-0000NO-JY; Mon, 07 Oct 2024 23:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sy14A-0000NG-OA
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 23:39:18 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sy148-0004a0-HE
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 23:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728358756; x=1759894756;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=9yAgS0lWbUPpjnOfAInqD964GG7y4EmE2mwVRLH3fvY=;
 b=bK14REAyH8ZbdBj4JIyUyeVvl2r7k6AhnjkhQLBwQ7AAj5FdknZGzXCH
 GbF2y9Hp50iZOvAGAacmzRhVd29inUexXOtTD3fb8lT8qmBttyMfHobHu
 8RLwbBOP9wbZ7GYHnTaC+U9JkQAq6m6g0U3am/Oz+cODL5TegvxJUc743
 lkPA8Byk3RLnN6Cl+9gRCyYJS+qE3dW3CuhVusGlrQkxFey1i9Su0gqG8
 hCynkZkSWQ1DNUqtMC/n5scdPiFagc7qEFOD/sD+sYGZ+1m9ORa7yJ1zW
 1neqLECbaBx9tYTM/CMsfeZu90Dd2oshiqQhM0UrA55i5MU4BSPGMr7xV w==;
X-CSE-ConnectionGUID: 8cU7RisyTKyTW9W0unZl/g==
X-CSE-MsgGUID: fWS3vo7YQaai8e3lMhxJmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="52935979"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; d="scan'208";a="52935979"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2024 20:39:12 -0700
X-CSE-ConnectionGUID: SRZHXToRTWKzt/xp0fO8LA==
X-CSE-MsgGUID: wBjaco8IRZmk1BEzl3jU2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; d="scan'208";a="80103978"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 07 Oct 2024 20:39:10 -0700
Date: Tue, 8 Oct 2024 11:55:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 1/2] hw/core/machine: Add missing 'units.h' and
 'error-report.h' headers
Message-ID: <ZwStKjT13QGFvfct@intel.com>
References: <20240930221900.59525-1-philmd@linaro.org>
 <20240930221900.59525-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930221900.59525-2-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Tue, Oct 01, 2024 at 12:18:59AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  1 Oct 2024 00:18:59 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 1/2] hw/core/machine: Add missing 'units.h' and
>  'error-report.h' headers
> X-Mailer: git-send-email 2.45.2
> 
> Include the missing "qemu/units.h" to fix when refactoring code:
> 
>   ../hw/core/machine.c:743:34: error: use of undeclared identifier 'MiB'
>   743 |     mc->default_ram_size = 128 * MiB;
>       |                                  ^
>   ../hw/core/machine.c:750:44: error: use of undeclared identifier 'TiB'
>   750 |     mc->smbios_memory_device_size = 2047 * TiB;
>       |                                            ^
> 
> and "qemu/error-report.h" to fix:
> 
>   ../hw/core/machine.c:1029:13: error: call to undeclared function 'error_report' [-Wimplicit-function-declaration]
>  1029 |             error_report("NUMA node %" PRIu16 " is missing, use "
>       |             ^
>   ../hw/core/machine.c:1240:9: error: call to undeclared function 'warn_report' [-Wimplicit-function-declaration]
>  1240 |         warn_report("CPU model %s is deprecated -- %s",
>       |         ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/core/machine.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


