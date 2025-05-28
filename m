Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D37C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 01:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK63z-0001V6-Bd; Tue, 27 May 2025 21:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK63w-0001Um-GL; Tue, 27 May 2025 21:58:36 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK63u-0003LP-GB; Tue, 27 May 2025 21:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748397514; x=1779933514;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ABxWJqdEbyv+3KaRIM+Gvy3SjNs4T/SGxSCoCjLKWtM=;
 b=k/M4gEMHlw9Mr249A3T9ceTtMSbb0QGtsmPPKmduEuJDqpeBhyBt16fk
 5un3RcO7GaodfqY4iGrGbUfUZOmFalJfDYCwTnCJ6OpO+l2QxBvhlMIFA
 MiwC8jheZ24lDKxNJGAKxZW3tSBVUdWkcPh69xFbR3b6HBEtb+/mK1Hzx
 cosECIXYxt9GfcIbdRGf0Eo4RBkT+pQYgyXEEgRNoDBMd6mGVQROL9Qed
 75Vgg2Sr8DcrO64m4xZ00HFovtz3lcSsNytsPwNSHp9lMbn6pay+xlFkv
 knOQrKGVfE1/KowGVK2Kqe7XCMMNb6A25Isy1prY4l9Q0NLO73fS59Ulr Q==;
X-CSE-ConnectionGUID: NlO5LtSzQICBkfxNm7zYQQ==
X-CSE-MsgGUID: vHjwqwXmQNartVKO5KJg1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50563641"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="50563641"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 18:58:32 -0700
X-CSE-ConnectionGUID: N0x/dOhGR8a7Lr2yQ51COA==
X-CSE-MsgGUID: FhldETG3Q/Ccl92d3P9sRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="143404309"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 18:58:16 -0700
Message-ID: <96020763-36b1-465b-843c-e2257489e9dc@intel.com>
Date: Wed, 28 May 2025 09:58:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/19] hw/i386/pc: Remove deprecated pc-q35-2.4 and
 pc-i440fx-2.4 machines
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-2-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
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
> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
> 
> Remove the qtest in test-x86-cpuid-compat.c file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c                   | 13 -------------
>   hw/i386/pc_q35.c                    | 13 -------------
>   tests/qtest/test-x86-cpuid-compat.c | 14 --------------
>   3 files changed, 40 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 0dce512f184..04213b45b44 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -791,19 +791,6 @@ static void pc_i440fx_machine_2_5_options(MachineClass *m)
>   
>   DEFINE_I440FX_MACHINE(2, 5);
>   
> -static void pc_i440fx_machine_2_4_options(MachineClass *m)
> -{
> -    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> -
> -    pc_i440fx_machine_2_5_options(m);
> -    m->hw_version = "2.4.0";
> -    pcmc->broken_reserved_end = true;
> -    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
> -    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
> -}
> -
> -DEFINE_I440FX_MACHINE(2, 4);
> -
>   #ifdef CONFIG_ISAPC
>   static void isapc_machine_options(MachineClass *m)
>   {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index c538b3d05b4..47e12602413 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -685,16 +685,3 @@ static void pc_q35_machine_2_5_options(MachineClass *m)
>   }
>   
>   DEFINE_Q35_MACHINE(2, 5);
> -
> -static void pc_q35_machine_2_4_options(MachineClass *m)
> -{
> -    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> -
> -    pc_q35_machine_2_5_options(m);
> -    m->hw_version = "2.4.0";
> -    pcmc->broken_reserved_end = true;
> -    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
> -    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
> -}
> -
> -DEFINE_Q35_MACHINE(2, 4);
> diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
> index c9de47bb269..456e2af6657 100644
> --- a/tests/qtest/test-x86-cpuid-compat.c
> +++ b/tests/qtest/test-x86-cpuid-compat.c
> @@ -365,20 +365,6 @@ int main(int argc, char **argv)
>                          "level", 10);
>       }
>   
> -    /*
> -     * xlevel doesn't have any feature that triggers auto-level
> -     * code on old machine-types.  Just check that the compat code
> -     * is working correctly:
> -     */
> -    if (qtest_has_machine("pc-i440fx-2.4")) {
> -        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
> -                       "SandyBridge", NULL, "pc-i440fx-2.4",
> -                       "xlevel", 0x80000008);
> -        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
> -                       "SandyBridge", "svm=on,npt=on", "pc-i440fx-2.4",
> -                       "xlevel", 0x80000008);
> -    }
> -
>       /* Test feature parsing */
>       add_feature_test("x86/cpuid/features/plus",
>                        "486", "+arat",


