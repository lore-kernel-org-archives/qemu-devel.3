Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DC6C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 03:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpg86-0001kU-PN; Wed, 27 Mar 2024 23:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpg85-0001kK-Mf
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:08:37 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpg83-0007p3-Sc
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711595316; x=1743131316;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=pu0Q0iRHP28PhhTIn102XkUiuqiCyiNLA+tm7o6vRAo=;
 b=X8ku4D+/eq2W/u5Ti7oPJxm6C4d6CYch1A+FqyhSUeVpHYUREsoQaWPH
 YCdma9gWQabOWQ2OpUOO1uoulMGtkxbyOTML92vblpMtQLSmgUlGm6SQx
 d5lS8G6OLOZBJhMtGQ/wUac/8EU1CsO1XJhBYVx12hh4X0XMLdf4N86i2
 71nNy07hlc1wIyamtY0dYqX/8aBuLupfOMfmLH5YNXEQRoV39QLObZHou
 6q9owA9sywkbjyaWrDzbCe95rLHb7oqt5/aCOq/IVnIcqc9Sx4MXzXQe/
 nFdQQ9O8+UDa1MvLHTPOsrHdtlPH+vFBDpMO/d/OAGoApHWhwC9JOTIad A==;
X-CSE-ConnectionGUID: HTD++YHtSau2sHer6JR7hQ==
X-CSE-MsgGUID: TXonJ7J+RBWODZ5PJ0ZsQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10522232"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="10522232"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 20:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="21150865"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 27 Mar 2024 20:08:29 -0700
Date: Thu, 28 Mar 2024 11:22:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH-for-9.1 v2 18/21] hw/i386/acpi: Remove
 AcpiBuildState::rsdp field
Message-ID: <ZgTicXrLYMVAQMNZ@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-19-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-19-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 27, 2024 at 10:51:20AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:20 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 18/21] hw/i386/acpi: Remove AcpiBuildState::rsdp
>  field
> X-Mailer: git-send-email 2.41.0
> 
> AcpiBuildState::rsdp is always NULL, remove it,
> simplifying acpi_build_update().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20240305134221.30924-16-philmd@linaro.org>
> ---
>  hw/i386/acpi-build.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


