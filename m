Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6897DD2446B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 04:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6zD-0007LS-8x; Fri, 11 Oct 2024 00:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sz6zB-0007LH-Dx
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 00:10:41 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sz6z9-0007dM-PB
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 00:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728619840; x=1760155840;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1/9IbvcCKr/LtNuIs/Iznb4k26xfPWBZPLg3lqDiGcM=;
 b=JBj0sR2yCP4NocsFD78UXZY9zFfkB+fb9+MUWoP/01c4YJUtZTm7HqNj
 hUTGO7jcVcRiUWEEmynYNzEaYAbmg54hEVp+HPfkerJ9B2/zL8xbb7qnw
 NLIzgplBYvkTpCFlM2BA4dRjJ9KnhsaZakY3XoFg2WbaROR+599iAwX+P
 u7+4iJ762a7fklYuSbrLzlbbBuNYZY0BIZ1Uou5Hjlyu5Au90jnGOVLxm
 KvSGs6bNJRBaOOHyG53JOibj3Ua50Qtc0nmOzZ//gZWEwvjZara0x8lcK
 b+dgg0/jsOIndTAHrV9tOitNQos3XgNlUfchcPsZat/S7RJpnlvAc4QP4 w==;
X-CSE-ConnectionGUID: CBBn6NbcTo2WoWlIUpIyVg==
X-CSE-MsgGUID: J3Ew4RTpQTO+uAXsCsW4JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28139371"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; d="scan'208";a="28139371"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2024 21:10:38 -0700
X-CSE-ConnectionGUID: 7JHGESgXTF+n5Br4daG9FQ==
X-CSE-MsgGUID: fJKpLolVRP6j4OTd2wvn4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; d="scan'208";a="76443078"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 10 Oct 2024 21:10:35 -0700
Date: Fri, 11 Oct 2024 12:26:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Gao Shiyuan <gaoshiyuan@baidu.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, wangliang44@baidu.com
Subject: Re: [PATCH v2 1/1] x86: Add support save/load HWCR MSR
Message-ID: <ZwipCPXYcyUHm8k9@intel.com>
References: <20241009095109.66843-1-gaoshiyuan@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095109.66843-1-gaoshiyuan@baidu.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Oct 09, 2024 at 05:51:09PM +0800, Gao Shiyuan wrote:
> Date: Wed, 9 Oct 2024 17:51:09 +0800
> From: Gao Shiyuan <gaoshiyuan@baidu.com>
> Subject: [PATCH v2 1/1] x86: Add support save/load HWCR MSR
> X-Mailer: git-send-email 2.39.3 (Apple Git-146)
> 
> KVM commit 191c8137a939 ("x86/kvm: Implement HWCR support")
> introduced support for emulating HWCR MSR.
> 
> Add support for QEMU to save/load this MSR for migration purposes.
> 
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Wang Liang <wangliang44@baidu.com>
> ---
>  target/i386/cpu.h     |  5 +++++
>  target/i386/kvm/kvm.c | 12 ++++++++++++
>  target/i386/machine.c | 20 ++++++++++++++++++++
>  3 files changed, 37 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


