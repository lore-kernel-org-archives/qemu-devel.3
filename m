Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02540C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKdO-0004GG-A8; Tue, 06 May 2025 11:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCKdI-0004Df-51; Tue, 06 May 2025 11:55:03 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCKdF-0005Zn-MH; Tue, 06 May 2025 11:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746546898; x=1778082898;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=MgaDTETiXzOz7MABvpwVlPfYt7SV2Bonf6PbPVxZqfQ=;
 b=CMzdgUZnwxc3Rnyl0N4wZPgaH/JpQRVPbtLpG4OEItqoNo34H8QjqvxB
 KWeG/ycqV5cFrWEFdPHhurQch05ga2gxLOBhfUzZdWmhUiWQR51kCrZjo
 YrMPHTJQzf8Pn9uKsm8Kq3GikBBRoBMpEjTIFz74jd6ocxQLxVIQhTnhk
 Tc2q/RxGbBxluW3VC8uwrc+kR8n0yKLqGv9gFfwGCT1V9yfYsXLunTfUm
 4PuaIXqwtmc29RLs03XrALUtt5Pj+KB/Ym9bqu3e3YxtzVn4eN6v1wfvy
 AGqQ2XpIjyS1KEISv5lBgGGr0GMsjRM5ZCvlzgPH+x4KZQvnm5nTn/Kar A==;
X-CSE-ConnectionGUID: ZWYKRUryRweMF6adc66ebQ==
X-CSE-MsgGUID: vKjpI9YhT1OwjV1pNgYenA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48359977"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="48359977"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 08:54:54 -0700
X-CSE-ConnectionGUID: ulIEHDOPRRiBqDmNm4yDtg==
X-CSE-MsgGUID: EdrB+MZtRl+OWhUPZEj3Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="172855632"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 06 May 2025 08:54:52 -0700
Date: Wed, 7 May 2025 00:15:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [RFC PATCH] qapi: Make CpuModelExpansionInfo::deprecated-props
 optional and generic
Message-ID: <aBo1uNs65Ce6fXkJ@intel.com>
References: <20250429100419.20427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429100419.20427-1-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 29, 2025 at 12:04:19PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue, 29 Apr 2025 12:04:19 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [RFC PATCH] qapi: Make CpuModelExpansionInfo::deprecated-props
>  optional and generic
> X-Mailer: git-send-email 2.47.1
> 
> We'd like to have some unified QAPI schema. Having a structure field
> conditional to a target being built in is not very practical.
> 
> While @deprecated-props is only used by s390x target, it is generic
> enough and could be used by other targets (assuming we expand
> CpuModelExpansionType enum values).
> 
> Let's always include this field, regardless of the target, but
> make it optional.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  qapi/machine-target.json | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 541f93eeb78..3b109b4af87 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -244,19 +244,18 @@
>  #
>  # @model: the expanded CpuModelInfo.
>  #
> -# @deprecated-props: a list of properties that are flagged as
> +# @deprecated-props: an optional list of properties that are flagged as
>  #     deprecated by the CPU vendor.  The list depends on the
>  #     CpuModelExpansionType: "static" properties are a subset of the
>  #     enabled-properties for the expanded model; "full" properties are
>  #     a set of properties that are deprecated across all models for
> -#     the architecture.  (since: 9.1).
> +#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
>  #
>  # Since: 2.8
>  ##
>  { 'struct': 'CpuModelExpansionInfo',
>    'data': { 'model': 'CpuModelInfo',
> -            'deprecated-props' : { 'type': ['str'],
> -                                   'if': 'TARGET_S390X' } },
> +            '*deprecated-props' : { 'type': ['str'] } },
>    'if': { 'any': [ 'TARGET_S390X',
>                     'TARGET_I386',
>                     'TARGET_ARM',

This changes CpuModelExpansionInfo from:

#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
struct CpuModelExpansionInfo {
    CpuModelInfo *model;
#if defined(TARGET_S390X)
    strList *deprecated_props;
#endif /* defined(TARGET_S390X) */
};
#endif

to:

#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
struct CpuModelExpansionInfo {
    CpuModelInfo *model;
    bool has_deprecated_props;
    strList *deprecated_props;
};
#endif

Do we need to set has_deprecated_props as true?

diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index 4351182f7209..ab05cf99a214 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -252,6 +252,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,

     s390_feat_bitmap_to_ascii(deprecated_feats,
                               &expansion_info->deprecated_props, list_add_feat);
+    expansion_info->has_deprecated_props = true;
     return expansion_info;
 }

---
Regards,
Zhao


