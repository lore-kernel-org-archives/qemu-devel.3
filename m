Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768F4F3C24E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzanb-0008GF-78; Mon, 09 Mar 2026 09:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzanU-0008Du-BQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:37:24 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzanS-0004ib-5o
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773063441; x=1804599441;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=4mWCyx1Te9ugLEsZU9ic00xrG8f/5qA2VFmRrRi9YPs=;
 b=nN0Vhq0oRw9jibclNnUNtbTeq6zcZ6VA+RBmBq8yJzh9miig2r+Z9guB
 yXDng//+lHxOXkMy3ftxWdbYW22Vm/tTaDAUWta/640MdzA/m7FLsf5MZ
 0aQMiNKkgM/Fx4N5BZuPcFcJTiiCOEKsq8FMFexNLtPRAHAeDDEkS5Arv
 h/iG4oltZIUjvrT9Q2o4RDvHoFgqjsJEUXvnicRX2EGXlmlvz3H5Rraep
 0Ud4eHpSXAeGeLyODY5GB1HiREN7/1X3wCuGEdUCI0ne3Lon/NnYyzFxY
 BPWxkBcJPMIAzj/+Neo6tPntyei+utyfEop/RD4IHsz8L8eLFb+JqwxCI g==;
X-CSE-ConnectionGUID: mtRM3GwOTzSPvL9yXNLx4w==
X-CSE-MsgGUID: jcsASRJyRTScJEsHWcz1YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73108721"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="73108721"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 06:37:19 -0700
X-CSE-ConnectionGUID: hC0GY+T1Toqai1gyjXyYWQ==
X-CSE-MsgGUID: NuXr/z8SQzC8gv/wAiCMhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="224203764"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 09 Mar 2026 06:37:18 -0700
Date: Mon, 9 Mar 2026 22:03:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 3/4] target/i386/kvm: Remove
 X86CPU::hyperv_synic_kvm_only field
Message-ID: <aa7TMGlD57JYsMLi@intel.com>
References: <20260307150042.78030-1-philmd@linaro.org>
 <20260307150042.78030-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307150042.78030-4-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

On Sat, Mar 07, 2026 at 04:00:41PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Sat,  7 Mar 2026 16:00:41 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 3/4] target/i386/kvm: Remove X86CPU::hyperv_synic_kvm_only
>  field
> X-Mailer: git-send-email 2.52.0
> 
> The X86CPU::hyperv_synic_kvm_only boolean (see commit 9b4cf107b09
> "hyperv: only add SynIC in compatible configurations") was only set
> in the pc_compat_3_0[] array, via the 'x-hv-synic-kvm-only=on'
> property. We removed all machines using that array, lets remove that
> property and all the code around it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/cpu.h     |  1 -
>  target/i386/cpu.c     |  2 --
>  target/i386/kvm/kvm.c | 15 ++++-----------
>  3 files changed, 4 insertions(+), 14 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


