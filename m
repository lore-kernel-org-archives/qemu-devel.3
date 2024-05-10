Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E51BC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 12:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5PKN-000498-JS; Fri, 10 May 2024 08:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5PKJ-00047s-CL
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:26:17 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5PKH-0001mx-KS
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715343974; x=1746879974;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zNbhLYBOflHm6IBcdMKy+v+rF9GkUaMY8dILBO6Tmj8=;
 b=Wf59elFzhD8wXwjwr1wspW69DCKzO6Fcy3NfVucWxv2DmbDm3r63LZ2t
 ITRfAZacD0OjIx1ioIlcGrMiGh89A2A2reWmWRcMIUxgo1S014lWCrHU1
 1ak5rsi0tMGnTkuGE2M+AyvyC9omzGYQ/DXVANDbtXeRBj0UIHN+dOVFH
 Nidx3D1JP7hFDlC1UXbfGYBjZVQ0dKbIMK8WnuLyfVjhbEYPD4uL+DWjE
 ibSpD6bGmg5mwfvWXpmgBfd540ZfejZKEj3+v0XMxNNAIAgq+e29iqHz0
 xXHtdlzphAZu75UiCeSlA9o//hJFInU5PLGG0ljnwnfCugPmQSom4HNA7 w==;
X-CSE-ConnectionGUID: 2uqvUhNaRAmD8oW2bj97Ag==
X-CSE-MsgGUID: btIWZrRHRNCm0Ru9SGgVSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11448403"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="11448403"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 05:26:11 -0700
X-CSE-ConnectionGUID: I/phwcHqTkuX3KcTWdC8Zw==
X-CSE-MsgGUID: tLJQPTXLT6+LBjhzFN4GEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="34473429"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 10 May 2024 05:26:11 -0700
Date: Fri, 10 May 2024 20:40:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Subject: Re: [PATCH 12/13] i386: select correct components for no-board build
Message-ID: <Zj4VuJb8fVCVfm1x@intel.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509170044.190795-13-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, May 09, 2024 at 07:00:43PM +0200, Paolo Bonzini wrote:
> Date: Thu,  9 May 2024 19:00:43 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 12/13] i386: select correct components for no-board build
> X-Mailer: git-send-email 2.45.0
> 
> The local APIC is a part of the CPU and has callbacks that are invoked
> from multiple accelerators.
> 
> The IOAPIC on the other hand is optional, but ioapic_eoi_broadcast is
> used by common x86 code to implement the IOAPIC's implicit EOI mode.
> Add a stub in case the IOAPIC device is not included but the APIC is.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/intc/ioapic-stub.c      | 29 +++++++++++++++++++++++++++++
>  .gitlab-ci.d/buildtest.yml |  2 +-
>  hw/intc/meson.build        |  2 +-
>  target/i386/Kconfig        |  1 +
>  4 files changed, 32 insertions(+), 2 deletions(-)
>  create mode 100644 hw/intc/ioapic-stub.c

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


