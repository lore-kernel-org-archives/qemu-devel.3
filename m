Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021E5D3A660
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 14:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nQS-0008Ii-Nt; Tue, 29 Oct 2024 10:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5nQP-0008IR-L6
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:42:25 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5nQN-0002SG-Sp
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730212944; x=1761748944;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=F9SVe03MZxrtt9HZ3hsiH9rUrtmSsLapZSBJTlOfKp4=;
 b=TXsn0tbQPP2vKFCLIIg1eyp+KHetqlSkOlBp5wuVHplTRwyeQlR/mGif
 ay53LjLxpbJRDtsb6gS3DEiF2EhOT+nWEDrsStAI605u6+In8DZlONlN3
 mIwQ9YYUjgnjqgsYFlEaH1FvZukFCtjZ60X/fJ0i3VJdk9YdcLuPdnAuq
 YkU/ThySb6+IuRE0eCvojmd6PHx8ayBRX91/gWIJE9htjTPV4spZD8SKN
 WpVE4MGdm4eTgyP+hFnOy4T7gsUTtAknqS+RcHlOF8vNzWjEXDdMddI7M
 46/Jx8Wr6+Hn+HxGjPrLsdlvVhGQSzQufA1CqGGoVgHeZzN/Y+0Wxs6aH A==;
X-CSE-ConnectionGUID: iN7u2biPSSiWEy2GoGCH+g==
X-CSE-MsgGUID: 1TqG0FfMSmOZtn9xJu0ZCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="32710233"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="32710233"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 07:42:21 -0700
X-CSE-ConnectionGUID: aT53TqF1Scafnh+1hUDMIw==
X-CSE-MsgGUID: ZVxS8IYBQfCjuYsDDWRrKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="86752315"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 29 Oct 2024 07:42:19 -0700
Date: Tue, 29 Oct 2024 22:58:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 xiaoyao.li@intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 6/6] target/i386: Introduce GraniteRapids-v2 model
Message-ID: <ZyD4HyATnm1CfZZN@intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-7-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028024512.156724-7-tao1.su@linux.intel.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

On Mon, Oct 28, 2024 at 10:45:12AM +0800, Tao Su wrote:
> Date: Mon, 28 Oct 2024 10:45:12 +0800
> From: Tao Su <tao1.su@linux.intel.com>
> Subject: [PATCH 6/6] target/i386: Introduce GraniteRapids-v2 model
> X-Mailer: git-send-email 2.34.1
> 
> Update GraniteRapids CPU model to add AVX10 and the missing features(ss,
> tsc-adjust, cldemote, movdiri, movdir64b).

Do you have datasheet link? It's better to add the link in the commit
message for easy comparison checking.

> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
>  target/i386/cpu.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index adde98fd26..8d72c08b66 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4375,6 +4375,23 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>          .model_id = "Intel Xeon Processor (GraniteRapids)",
>          .versions = (X86CPUVersionDefinition[]) {
>              { .version = 1 },
> +            {
> +                .version = 2,
> +                .props = (PropValue[]) {
> +                    { "ss", "on" },
> +                    { "tsc-adjust", "on" },
> +                    { "cldemote", "on" },
> +                    { "movdiri", "on" },
> +                    { "movdir64b", "on" },
> +                    { "avx10", "on" },
> +                    { "avx10-128", "on" },
> +                    { "avx10-256", "on" },
> +                    { "avx10-512", "on" },
> +                    { "avx10-version", "1" },
> +                    { "stepping", "1" },
> +                    { /* end of list */ }
> +                }
> +            },
>              { /* end of list */ },
>          },
>      },
> -- 
> 2.34.1
> 

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

BTW, Could you please update the CPU model you added in
docs/system/cpu-models-x86.rst.inc (section "Preferred CPU models for
Intel x86 hosts") as well? Although this document has been inactive for
some time, it hasn't been deprecated, and we can pick it up again to
continue updating it, helping QEMU users understand QEMU's support for
x86 CPU/features.

Thanks,
Zhao


