Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0D0FD2D9A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxeS-0000z0-Ue; Tue, 10 Mar 2026 10:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxe8-0000py-73
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:01:19 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxe6-0001uY-Mh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773151275; x=1804687275;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=U4INyuCgUhc1CpetJeMOWHw4LN7FOYLUN1bsDivCof8=;
 b=a4Jc5Hd6/z+CwL9b+OlPa5q3KXeTJ6HGs2KqgzJ/nV6UPXEeuSUZphDe
 s0jF5ZclAMe6PWLt/uve+uh8FESKZHcNMsmY/FjSD1i0TpGzEpF2I6tbm
 vApYTlgfIH52oKjTW4nKFDguzMJSxZlZnEjxZB+p9VpGE4Q7yqA28UuHt
 yL7jlp8wzVzVMg8UaGdRQ35W+7tYLRGKYgEG50CnDJwlhBAyo7wxwGvNk
 OQLFgkgbJrbSWdXMQaXZb6AC6uPhC+kSUGbPKWw7CWBXcE8xPtrtY/OiM
 4jdxbBV1CQ6WcXhsk4f+Omj+6rDKN1H25IJjh9P7Tumx4ibBqrki/dNgq g==;
X-CSE-ConnectionGUID: 2aRuh0csT9uFX1d9n7CSqA==
X-CSE-MsgGUID: YFp8RJ7HRCyb8/vbeVC0sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74240021"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="74240021"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 07:01:13 -0700
X-CSE-ConnectionGUID: +xQPUE7+Tk6NqacQUDjowA==
X-CSE-MsgGUID: rS7S+LO1QXmwBX0Ys5JsFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="258039180"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 10 Mar 2026 07:01:09 -0700
Date: Tue, 10 Mar 2026 22:27:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Corey Minyard <cminyard@mvista.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v2 04/10] hw/core/boards: Remove
 MachineClass::smbus_no_migration_support field
Message-ID: <abAqR/e0XhjQDacT@intel.com>
References: <20260309145013.44327-1-philmd@linaro.org>
 <20260309145013.44327-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309145013.44327-5-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

On Mon, Mar 09, 2026 at 03:50:06PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon,  9 Mar 2026 15:50:06 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 04/10] hw/core/boards: Remove
>  MachineClass::smbus_no_migration_support field
> X-Mailer: git-send-email 2.53.0
> 
> The MachineClass::smbus_no_migration_support boolean was only used
> by the pc-q35-3.1 and pc-i440fx-3.1 machines, which got removed.
> Remove it, along with pm_smbus_vmstate_needed().
> 
> Use the unconditional VMSTATE_BOOL() and VMSTATE_STRUCT() macros.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20260307152635.83893-5-philmd@linaro.org>
> ---
>  include/hw/core/boards.h  |  1 -
>  include/hw/i2c/pm_smbus.h |  7 -------
>  hw/acpi/piix4.c           |  8 +-------
>  hw/i2c/pm_smbus.c         |  7 -------
>  hw/i2c/smbus_eeprom.c     |  4 +---
>  hw/i2c/smbus_ich9.c       | 10 ++--------
>  6 files changed, 4 insertions(+), 33 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


