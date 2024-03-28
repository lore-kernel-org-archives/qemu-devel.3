Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7F5C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 02:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpfql-0005ba-Nu; Wed, 27 Mar 2024 22:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpfqj-0005bA-Kr
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:50:41 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpfqh-0004qC-6N
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711594239; x=1743130239;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ev01rh+JSJyQmiJpHxGwKg52c1nyth+mXbr68DmuH1o=;
 b=IrG4GIHrQyiVm2p1CcnYsRqCFnc5QOdfyKAGjxnoamsnIaRP+8ExEqcY
 2uFWfCV4kmTO5/DJEdFAsAEu6uEvrFiYfqml0wJR6Lrdu0yEkfMdHtJ6V
 adsSnepusTQ22io8vP+j98TuaGSM613DBpFqfCABLPIA2oIKE9IKfkYP1
 TbvzDbDXP4N3nNZ42v+bNj1pkm5Kp8M9OT1CiJZ63rjDRfTMcdRrSPfCK
 kaZWQOcckBcBFwh3LPhFF8PqvwHOkq0TwtGuMcGV45Cfki75AV99cOxPa
 BtrPUNNIsMjWScfY0I7dY4sOZHkB7j85e3I2sPmMc7VSyh6kPKwXnihrP A==;
X-CSE-ConnectionGUID: sV6TLt0wQEq0nEg5t4dgAQ==
X-CSE-MsgGUID: UjsD4wToQiGrae6CZcWcAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="9691704"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="9691704"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 19:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="21219752"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 27 Mar 2024 19:50:34 -0700
Date: Thu, 28 Mar 2024 11:04:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.1 v2 16/21] hw/i386/pc: Remove
 PCMachineClass::resizable_acpi_blob
Message-ID: <ZgTePNiK3/cISpP/@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-17-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-17-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Wed, Mar 27, 2024 at 10:51:18AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:18 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 16/21] hw/i386/pc: Remove
>  PCMachineClass::resizable_acpi_blob
> X-Mailer: git-send-email 2.41.0
> 
> PCMachineClass::resizable_acpi_blob was only used by the
> pc-i440fx-2.2 machine, which got removed. It is now always
> true. Remove it, simplifying acpi_build().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/i386/pc.h |  3 ---
>  hw/i386/acpi-build.c | 10 ----------
>  hw/i386/pc.c         |  1 -
>  3 files changed, 14 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


