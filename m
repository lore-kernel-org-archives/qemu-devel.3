Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C922C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 08:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy3ry-0000vQ-UX; Sun, 23 Aug 2026 04:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy3rw-0000sC-Hs
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:47:56 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy3rt-0002sg-4X
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787474873; x=1819010873;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=V7UKv8CSb7uP/LVs/3DphfIxtGergNcv6nDGxcjSJqY=;
 b=a2E9vtW4S3Wwy7inl+xUh0pnQo9YIgSD7JsrM6LmKrhJu5oAVzLSr+Hr
 3aUrjnHbW9a3NYMuQflvFnJg/WObU/wcqiW85wtxT9+gmYtW1wKcLTW7w
 EN05ux4bLnZrDW5N7mdKrEjycqcu7Cp9iJacjuqZI1VvRXbZLo8vagYo8
 5crCzmy/i4RL/CpWOd4S23a/Bfq7M228d1yiUGOnS1WRISVHVyOiOcDaG
 YmC4MMNbk5lG856b7SrIrVtMpdBkPtFWDWgQ0FZ/Xs63AxTEsLHNPHPmq
 ASnCEOU8VobtasUwlwYjvnqd4RQzpACTX/vPrO1j9by+btgQFb2j88wXR g==;
X-CSE-ConnectionGUID: Qm7BbeLAQZKsC5oYS3wxmQ==
X-CSE-MsgGUID: sMvqnuNCSC+W7rl7mEDeTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="87070489"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="87070489"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 01:47:48 -0700
X-CSE-ConnectionGUID: 5Azxb7IQTsm9IztPQP+mfw==
X-CSE-MsgGUID: 4pPO+FpXT3muTTr6ao2dEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="265425607"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa010.jf.intel.com with ESMTP; 23 Aug 2026 01:47:45 -0700
Date: Sun, 23 Aug 2026 16:47:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yanjing Zhou <zhouyanjing@hygon.cn>, Yongwei Xu <xuyongwei@open-hieco.net>
Subject: Re: [PATCH v2 1/9] target/i386: Sync AMD CPUID aliases for Hygon
Message-ID: <aoqzsAC5dBBuLQ8h@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-2-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-2-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 10, 2026 at 04:29:48PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:48 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 1/9] target/i386: Sync AMD CPUID aliases for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> AMD defines CPUID[0x80000001].EDX bits as aliases for a subset of
> CPUID[1].EDX.  QEMU currently synchronizes those aliases only when the
> guest CPU vendor is AuthenticAMD.
> 
> Hygon Dhyana uses the HygonGenuine vendor string, but implements the
> same AMD-compatible extended CPUID feature aliases.  This can leave QEMU
> advertising a feature in CPUID[1].EDX while the matching extended alias
> in CPUID[0x80000001].EDX stays clear.  This inconsistent CPUID state can
> confuse guest OS feature detection.
> 
> Apply the alias synchronization to Hygon CPUs as well.  Gate the new
> behavior with x-hygon-vendor-abi-fixes and disable it for pc-11.0 and
                                                            ^^^^^^^
nit: pc-11.1 ?

> older machine types, because the CPUID result is guest-visible ABI and
> must remain migration-compatible.
> 
> Add qtest coverage for the Dhyana model, including the compat property.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> Tested-by: Yongwei Xu <xuyongwei@open-hieco.net>
> ---
>  hw/i386/pc.c                        |  5 ++
>  hw/i386/pc_piix.c                   |  1 +
>  hw/i386/pc_q35.c                    |  1 +
>  include/hw/i386/pc.h                |  3 ++
>  target/i386/cpu.c                   | 10 ++--
>  target/i386/cpu.h                   | 13 +++++
>  tests/qtest/test-x86-cpuid-compat.c | 76 +++++++++++++++++++++++++++++
>  7 files changed, 106 insertions(+), 3 deletions(-)
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f064aa2b3e..2b4e322b2f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -74,6 +74,11 @@
>  #include "hw/xen/xen-bus.h"
>  #endif
>  
> +GlobalProperty pc_compat_11_1[] = {
> +    { TYPE_X86_CPU, "x-hygon-vendor-abi-fixes", "false" },
> +};
> +const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
> +

compat machine property is already on the master branch, so this
patch need to be rebased.

>  GlobalProperty pc_compat_11_0[] = {};
>  const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 82457bdb16..8e58f2a7ee 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -438,6 +438,7 @@ DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
>  static void pc_i440fx_machine_11_0_options(MachineClass *m)
>  {
>      pc_i440fx_machine_11_1_options(m);

pc_i440fx_machine_11_1_options() has added pc_compat_11_1...

> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);

...so taht now we don't need ao do this again.

>      compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>      compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6c1e4eff5f..fd4366f51f 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -393,6 +393,7 @@ DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
>  static void pc_q35_machine_11_0_options(MachineClass *m)
>  {
>      pc_q35_machine_11_1_options(m);
> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);

ditto.

>      compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>      compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
>  }

Overall, LGTM except rebasing :).

Regards,
Zhao


