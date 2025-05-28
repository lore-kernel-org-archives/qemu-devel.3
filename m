Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FFEC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 01:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK64o-0002iQ-M4; Tue, 27 May 2025 21:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK64k-0002aG-6w; Tue, 27 May 2025 21:59:26 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK64i-0003Pv-Cr; Tue, 27 May 2025 21:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748397564; x=1779933564;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=sKtihF2GRiJcn9dfaW/7imhqiht51pMlwKDRUcNQKnk=;
 b=ONI4Nu0S36/1x+kL5fY9fFJhXst2noSMdnqoRJiunJn5jH1V/ru+gvpa
 bvwjwSEwPANdNnc4RaQjPiDqaOVEg3pf1cvMrE30DMeQip9cnrm32V+Rg
 PskEB2y9JW43ONZZyll7OBHKGcOKkIP3Am4w4LSlpW5AfHkGbBFx1CMQz
 u7tIx9fqPBSRSywYmHFy4hg6CEYYwg0VfzLlSPKyzNECUpC1VaE2NxF48
 bEog4O7kDIEWMP4wBpJMsquuCMEiwnfV6YLZqchrvkG8pBDIuAl+GInrH
 r8gIUFZD8bGcqc34pT2z7XJeEKnupyj8QKdDCX4al6TiiPIsPV03XAJHm Q==;
X-CSE-ConnectionGUID: 33SEjPotSmWouTiLIVEPgw==
X-CSE-MsgGUID: XT/c3hkJSaC35Y19BT+Fhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="53033845"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="53033845"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 18:59:21 -0700
X-CSE-ConnectionGUID: dXLmmygKRJmPB+wB5LuCQw==
X-CSE-MsgGUID: gIFs2BlCRu6OO8C7O9w2VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="144030837"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 18:59:16 -0700
Message-ID: <0c619815-6bbc-4f23-96ba-468535f00fde@intel.com>
Date: Wed, 28 May 2025 09:59:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/19] hw/i386/pc: Remove pc_compat_2_4[] array
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-4-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:
> The pc_compat_2_4[] array was only used by the pc-q35-2.4
> and pc-i440fx-2.4 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   include/hw/i386/pc.h |  3 ---
>   hw/i386/pc.c         | 19 -------------------
>   2 files changed, 22 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index f4a874b17fc..b34aa25fdce 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -301,9 +301,6 @@ extern const size_t pc_compat_2_6_len;
>   extern GlobalProperty pc_compat_2_5[];
>   extern const size_t pc_compat_2_5_len;
>   
> -extern GlobalProperty pc_compat_2_4[];
> -extern const size_t pc_compat_2_4_len;
> -
>   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>       static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                    const void *data) \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c8bb4a3ee47..2b46714a5ac 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -262,25 +262,6 @@ const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
>   GlobalProperty pc_compat_2_5[] = {};
>   const size_t pc_compat_2_5_len = G_N_ELEMENTS(pc_compat_2_5);
>   
> -GlobalProperty pc_compat_2_4[] = {
> -    PC_CPU_MODEL_IDS("2.4.0")
> -    { "Haswell-" TYPE_X86_CPU, "abm", "off" },
> -    { "Haswell-noTSX-" TYPE_X86_CPU, "abm", "off" },
> -    { "Broadwell-" TYPE_X86_CPU, "abm", "off" },
> -    { "Broadwell-noTSX-" TYPE_X86_CPU, "abm", "off" },
> -    { "host" "-" TYPE_X86_CPU, "host-cache-info", "on" },
> -    { TYPE_X86_CPU, "check", "off" },
> -    { "qemu64" "-" TYPE_X86_CPU, "sse4a", "on" },
> -    { "qemu64" "-" TYPE_X86_CPU, "abm", "on" },
> -    { "qemu64" "-" TYPE_X86_CPU, "popcnt", "on" },
> -    { "qemu32" "-" TYPE_X86_CPU, "popcnt", "on" },
> -    { "Opteron_G2" "-" TYPE_X86_CPU, "rdtscp", "on" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "on" },
> -    { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "on" },
> -    { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "on", }
> -};
> -const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
> -
>   /*
>    * @PC_FW_DATA:
>    * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables


