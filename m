Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E712CD1280
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 04:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rph1b-0003qt-Lb; Thu, 28 Mar 2024 00:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rph1V-0003qT-B5
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 00:05:54 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rph1T-0001Cb-MJ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 00:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711598752; x=1743134752;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=69rPDrBaZWejO1+qoOyuca1LE+QtsetvxDZoHoCk0Xw=;
 b=YH4e15a9gieUQ0LLIyLmbIvCNwYswBQn12W+HnMzuckud5pXWG6Wc94y
 Z9oWwGjFhc9sqc+YfSYeamlFv4xNdy13DCz1M40P+imax4XMm6PJKiJKp
 7YOjOz9aDb/eDgVSZa+i18Okp6/CIWalNrECS5gzcHZp4QRRS2Sg7ViKf
 L8Z7Jxiri8BMJRm42kheqT4buSwf55wFW/QGqE95Z/cSLe3l9I6SNqjVp
 9TiJGD7aUxPwMMzgJtnHegQZmRkSymUV5cj6nveqIyBLwBZByYd8gfvMX
 zxse9VD+BGF87XMVEdYWR6hHuDzQbO6tCBcgab65D+jIaSYaKh00f22sK g==;
X-CSE-ConnectionGUID: /7j4gydLQROMUSwKVP79Fw==
X-CSE-MsgGUID: eLqTcGsVSMWtD7t9oJIiLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6846524"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6846524"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 21:05:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="21172890"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2024 21:05:47 -0700
Date: Thu, 28 Mar 2024 12:19:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.1 v2 06/21] hw/acpi/ich9: Remove dead code related
 to 'acpi_memory_hotplug'
Message-ID: <ZgTv3SFavCuHn/wT@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-7-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Wed, Mar 27, 2024 at 10:51:08AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:08 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 06/21] hw/acpi/ich9: Remove dead code related to
>  'acpi_memory_hotplug'
> X-Mailer: git-send-email 2.41.0
> 
> acpi_memory_hotplug::is_enabled is set to %true once via
> ich9_lpc_initfn() -> ich9_pm_add_properties(). No need to
> check it, so remove now dead code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/acpi/ich9.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


