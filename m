Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7379EC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 02:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6Gf-000746-EN; Tue, 27 May 2025 22:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6GZ-00073U-3w; Tue, 27 May 2025 22:11:39 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6GW-0005EY-JG; Tue, 27 May 2025 22:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748398296; x=1779934296;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Sqc7GIBeMBtYn1RIn1iJ3yFenyxlaXPZOEHt6rD6bkQ=;
 b=Nbs/MbxhH4R9sHyH9i+Ui3wKoUChlDTAAFN+2yKK6vJeY2cWct5tfZg3
 Av7tHqilsDs3fDCfbCT823umGCmkGD5t6yGhYCn5MSVPHKg6ojuAXhBnT
 4IfaVLu2+duOLbVSNMD/9juRMK2yaSMUKO3hsIoxG9IbBASWsFhDrd5yl
 ok1wivZJxkRG0s1Q38cLkRFCiE/HZRIyyB6bSPiGvzRW/+6kGQlXxf7rc
 eeblmFjK4g8oZYIG8mZc612ymrL//SOcg4fsZYKZq2naLOP0zwEzeSikY
 2Ya9Gr/e0/xuema0g45NRNslIOjMQ16MZl7vRSjecJRVR6Zz07dlzvqUT Q==;
X-CSE-ConnectionGUID: PFVBA97ISyKC3HbFNRYQXw==
X-CSE-MsgGUID: yM+IEjgpR26jI/p8vXCJSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50334866"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="50334866"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:11:34 -0700
X-CSE-ConnectionGUID: 8u2/KwwZTuCtaNh5jx28UQ==
X-CSE-MsgGUID: 6tjTGYk8RGyQjms1PntP9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="148201552"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:11:29 -0700
Message-ID: <ebb501d3-ae75-4fa6-83d4-df6493262018@intel.com>
Date: Wed, 28 May 2025 10:11:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/19] hw/core/machine: Remove hw_compat_2_4[] array
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
 <20250512083948.39294-6-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-6-philmd@linaro.org>
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
> The hw_compat_2_4[] array was only used by the pc-q35-2.4 and
> pc-i440fx-2.4 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   include/hw/boards.h | 3 ---
>   hw/core/machine.c   | 9 ---------
>   2 files changed, 12 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a7b1fcffae3..03e7cbeae82 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -866,7 +866,4 @@ extern const size_t hw_compat_2_6_len;
>   extern GlobalProperty hw_compat_2_5[];
>   extern const size_t hw_compat_2_5_len;
>   
> -extern GlobalProperty hw_compat_2_4[];
> -extern const size_t hw_compat_2_4_len;
> -
>   #endif
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ed01798d37c..d66b02b564c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -292,15 +292,6 @@ GlobalProperty hw_compat_2_5[] = {
>   };
>   const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
>   
> -GlobalProperty hw_compat_2_4[] = {
> -    { "e1000", "extra_mac_registers", "off" },
> -    { "virtio-pci", "x-disable-pcie", "on" },
> -    { "virtio-pci", "migrate-extra", "off" },
> -    { "fw_cfg_mem", "dma_enabled", "off" },
> -    { "fw_cfg_io", "dma_enabled", "off" }
> -};
> -const size_t hw_compat_2_4_len = G_N_ELEMENTS(hw_compat_2_4);
> -
>   MachineState *current_machine;
>   
>   static char *machine_get_kernel(Object *obj, Error **errp)


