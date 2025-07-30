Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30785C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 08:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh29a-000753-93; Wed, 30 Jul 2025 04:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uh1lD-0007TE-By
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 04:02:07 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uh1lA-0007iK-ER
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 04:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753862521; x=1785398521;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=JhkWE40o8mOT9s2n7Qia38qVjpnJXcDvaHGS4W9+3qw=;
 b=f2LtKU071AgZEqYO1SkJjdlqxaXrr7j5+T7Dle4fJ6OYxvuKEJsMr+j2
 WaLX4dIYami61PI4E6iD2ZosIOowHcpxQO3z+XoIJkT5kQ5VqEVVFel2T
 8en9kubVrlK29qIWKA/GpetOW1H6ZUh/bxzmGdy1xMxtjYU5kouL1rOTd
 chqHsRFWqYlmx+7vBfW+ja4dF+hCHq+bORnSx4gZgIZKdXIweyWkXfVxl
 1v638Y3eViwx6vSzGu1WNH9jISMGdliLvQ6q7HDepiTzU7ca4AFnQ/9s4
 539XIJSfyjlIMnjcO10FW29AY/gkExs4nZZtyBCBg+GtnSkA/Z8bkA8oc w==;
X-CSE-ConnectionGUID: fIUnW6dzSuyv/vmatOb3rQ==
X-CSE-MsgGUID: GBblvXRdSZyT7fU67nn1Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="66853563"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="66853563"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 01:01:57 -0700
X-CSE-ConnectionGUID: Hrk1GSQGRbCEn30WaSVKTw==
X-CSE-MsgGUID: nGE5DVCeTCOc5KYlFW/1KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="193767668"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 30 Jul 2025 01:01:55 -0700
Date: Wed, 30 Jul 2025 16:23:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] target/i386: Define enum X86ASIdx for x86's address
 spaces
Message-ID: <aInWgzo0yJH1QRbS@intel.com>
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
 <20250729054023.1668443-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729054023.1668443-3-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jul 29, 2025 at 01:40:23PM +0800, Xiaoyao Li wrote:
> Date: Tue, 29 Jul 2025 13:40:23 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH 2/2] target/i386: Define enum X86ASIdx for x86's address
>  spaces
> X-Mailer: git-send-email 2.43.0
> 
> Like ARM defines ARMASIdx, do the same to define X86ASIdx as enum. So
> that it's more clear what index 0 is for memory and index 1 is for SMM.

Maybe:

Define X86ASIdx as the enum, like ARM's ARMASIdx, so that index 0 is
clearly for memory and index 1 for SMM.

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  accel/kvm/kvm-all.c              | 2 +-
>  target/i386/cpu.h                | 5 +++++
>  target/i386/kvm/kvm-cpu.c        | 2 +-
>  target/i386/kvm/kvm.c            | 4 ++--
>  target/i386/tcg/system/tcg-cpu.c | 4 ++--
>  5 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


