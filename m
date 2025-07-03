Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D28C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 07:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXE0x-0001YJ-Rw; Thu, 03 Jul 2025 03:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXE0t-0001Xf-1X
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:05:43 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXE0p-0002ei-4K
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751526340; x=1783062340;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8SXO5nI+xDcEDyec7i0C04BOq34/qzvnlTSefaa7jzY=;
 b=a0l0eVxTzMur1haTFZx9qnagmeih/kXa4oo0c8Akkw7G8uE5XDDdEsV4
 eHNXWTzaaWJC++DVVeTmJMHTQbZ5bLRho8nfv8sCJGP1t8EX+yyq47qv4
 8BysMD8wotg/HB7ZUjPvxs9Ly4FYfdgXVFO6IOPeHpzAVG4EGjHwUSH43
 a62xvwI/+dX2Wpotd23PnoFw8pj9+ijdZijwRD2KOlKY1v6LIuPbQfJAu
 jWa/VozghThvOaz0pJ5RZZ0D58jMtuE5wnn4OquNrd/lyyO5HMyaewL1l
 WhJbmjx0fxlFGB1BmZzD7jEuO2EcB+L8q//0eotvvWysHp7Sqnop11tsu Q==;
X-CSE-ConnectionGUID: mcCMx5AGS+G0eHsbK/Hl2g==
X-CSE-MsgGUID: gmelXXjnSZ+oToZDrC67nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64084902"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="64084902"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:05:37 -0700
X-CSE-ConnectionGUID: ImuYMEbcTLGRIw4rUXiu0w==
X-CSE-MsgGUID: YfKC/6KASYe8bppgfu1Csg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="177955536"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 03 Jul 2025 00:05:33 -0700
Date: Thu, 3 Jul 2025 15:26:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v4 22/65] qapi: Move definitions related to accelerators
 in their own file
Message-ID: <aGYwwuCClu2VOgrR@intel.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-23-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702185332.43650-23-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

On Wed, Jul 02, 2025 at 08:52:44PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed,  2 Jul 2025 20:52:44 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 22/65] qapi: Move definitions related to accelerators in
>  their own file
> X-Mailer: git-send-email 2.49.0
> 
> Extract TCG and KVM definitions from machine.json to accelerator.json.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  MAINTAINERS                |  1 +
>  qapi/accelerator.json      | 75 ++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json          | 65 ---------------------------------
>  qapi/qapi-schema.json      |  1 +
>  accel/tcg/monitor.c        |  2 +-
>  hw/core/machine-hmp-cmds.c |  1 +
>  hw/core/machine-qmp-cmds.c |  1 +
>  qapi/meson.build           |  1 +
>  8 files changed, 81 insertions(+), 66 deletions(-)
>  create mode 100644 qapi/accelerator.json

Thank you for doing this; then I could refresh the PMU filter series
based on this work.

And,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


