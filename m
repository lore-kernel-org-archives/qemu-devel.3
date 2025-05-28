Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91759C5B543
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 02:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6F9-0005P6-Ae; Tue, 27 May 2025 22:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6F7-0005OA-Td; Tue, 27 May 2025 22:10:09 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6F5-000566-NW; Tue, 27 May 2025 22:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748398208; x=1779934208;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=V/ZEsMmL8lKKD023iHqyqSZ0skx8LkpcfLh6SCJ8pcc=;
 b=BFhNPJk3diqT33pir5nES9K8oZ+Z8i71KEeHKB4jpJFm+Zi8fZKDl1qK
 DoyTNYxeEoO6auKEBU0IBR6Sp8h5bnUDktkF+qZU1jOMbBU0Bd3UuvjT7
 Xey4wdZ6KLO3zJxzZY2VKqENMG0cbokH0sTW0rMf74JsDOLiKJxmA+lF0
 /xrwmgVb2u0uocrrfyTk5GqdA9TEbUYoGlSYKWPk9hLjHmyUQmvmjwtqC
 dtwhunLC5oW2WkJoX5Q4zFSFNDqZf4LB2p3gu7xzNqmaCjXs5aFZOUBJx
 3ymIOGKFI5ydZUBhnCPhRq1pKXdASdVU1gBzcf5ZSxEsmUSiHg7X10GQJ w==;
X-CSE-ConnectionGUID: O8q4R7VlSZ2dHtJ0dEAq7Q==
X-CSE-MsgGUID: 7zXDSamjTD+JlIoX2OR+uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50334737"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="50334737"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:10:04 -0700
X-CSE-ConnectionGUID: Y4JEmUDkTqe0vfbmy2YDwQ==
X-CSE-MsgGUID: vcuJkuvsQiigetT0b+vIqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="148200560"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:09:59 -0700
Message-ID: <ccf78c07-fc08-493f-85d8-5058cccbe82e@intel.com>
Date: Wed, 28 May 2025 10:09:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
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
 <20250512083948.39294-5-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
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
> The X86CPU::check_cpuid boolean was only set in the
> pc_compat_2_4[] array, via the 'check=off' property.
> We removed all machines using that array, lets remove
> that CPU property and simplify x86_cpu_realizefn().

No.

We cannot do this. Because it changes the behavior of QEMU.

'check_cpuid' is true by default while 'enforce_cpuid' is false. So that 
QEMU emits warnings in x86_cpu_filter_features() by default when user 
requests unsupported CPU features. If remove "check" property and the 
internal 'check_cpuid', QEMU will not do it unless user sets 
enforce_cpuid explicitly.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/cpu.h | 1 -
>   target/i386/cpu.c | 3 +--
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 4f8ed8868e9..0db70a70439 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2164,7 +2164,6 @@ struct ArchCPU {
>       uint8_t hyperv_ver_id_sb;
>       uint32_t hyperv_ver_id_sn;
>   
> -    bool check_cpuid;
>       bool enforce_cpuid;
>       /*
>        * Force features to be enabled even if the host doesn't support them.
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1ca6307c72e..cd4361b4227 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8174,7 +8174,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>           }
>       }
>   
> -    if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid)) {
> +    if (x86_cpu_filter_features(cpu, cpu->enforce_cpuid)) {
>           if (cpu->enforce_cpuid) {
>               error_setg(&local_err,
>                          accel_uses_host_cpuid() ?
> @@ -8813,7 +8813,6 @@ static const Property x86_cpu_properties[] = {
>       DEFINE_PROP_UINT8("hv-version-id-sbranch", X86CPU, hyperv_ver_id_sb, 0),
>       DEFINE_PROP_UINT32("hv-version-id-snumber", X86CPU, hyperv_ver_id_sn, 0),
>   
> -    DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
>       DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
>       DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
>       DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),


