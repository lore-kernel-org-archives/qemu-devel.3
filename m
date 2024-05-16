Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9841C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 02:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7RIw-0001JP-R1; Wed, 15 May 2024 22:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1s7RIv-0001JD-2g
 for qemu-devel@nongnu.org; Wed, 15 May 2024 22:57:13 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1s7RIs-0005ZK-Lf
 for qemu-devel@nongnu.org; Wed, 15 May 2024 22:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715828230; x=1747364230;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iZ3VfSgP5SZEuo+k5yRTkP6hTOjyBBlNSq/TIema/S4=;
 b=eVoXzKqNivnUBHVrsYDDhRH/eXc66XkinQHUR7IVFi3INwMJzaf1+X6n
 RbNOYsjAZwKnQK33SKDk4xtw9ZoZzs7igZTZFO/XmzrEfpKkB69s4iXxk
 GXke6HptGKeU5IgY6/BmAT4zeoUvuEZ0U4ewHmEeloF6XZCG7M6H0uaOg
 fcjGBlLb+Ye96d4vWvV4ZrLCD3FqFnO7oR0pkBr1C6TJvZECEG5iHQUJL
 +UapzcD2sUCdPicOD1dM61pgdEKTY63DC9U/eCFOCkugsiCw4fY2iznCD
 AP2rpHo+xyu12l8FBjkec0JE+y18PdMMlqiPQLxseEyNWTViRjb80E4lo Q==;
X-CSE-ConnectionGUID: 4TNtBkyQTbOCv/Xn2dxdYA==
X-CSE-MsgGUID: kTW+EaO2RYmC/A+0skRS9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23052624"
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; d="scan'208";a="23052624"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 19:57:05 -0700
X-CSE-ConnectionGUID: lQbHOXS6SRGOlrFjRL9KYQ==
X-CSE-MsgGUID: z1gZ3btaReiAmF54iWD8SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; d="scan'208";a="36151544"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 19:57:03 -0700
Message-ID: <ac639098-2eea-4eb1-bd63-3e377c7ccd61@intel.com>
Date: Thu, 16 May 2024 10:57:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests: add testing of parameter=1 for SMP topology
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Krempa <pkrempa@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20240513123358.612355-1-berrange@redhat.com>
 <20240513123358.612355-3-berrange@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240513123358.612355-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 5/13/2024 8:33 PM, Daniel P. Berrangé wrote:
> Validate that it is possible to pass 'parameter=1' for any SMP topology
> parameter, since unsupported parameters are implicitly considered to
> always have a value of 1.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/unit/test-smp-parse.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
> index 56165e6644..56ce5128f1 100644
> --- a/tests/unit/test-smp-parse.c
> +++ b/tests/unit/test-smp-parse.c
> @@ -330,6 +330,14 @@ static const struct SMPTestData data_generic_valid[] = {
>           .config = SMP_CONFIG_GENERIC(T, 8, T, 2, T, 4, T, 2, T, 16),
>           .expect_prefer_sockets = CPU_TOPOLOGY_GENERIC(8, 2, 4, 2, 16),
>           .expect_prefer_cores   = CPU_TOPOLOGY_GENERIC(8, 2, 4, 2, 16),
> +    }, {
> +        /*
> +         * Unsupported parameters are always allowed to be set to '1'
> +         * config: -smp 8,books=1,drawers=1,sockets=2,modules=1,dies=1,cores=4,threads=2,maxcpus=8

cores=2 not 4.

> +         * expect: cpus=8,sockets=2,cores=2,threads=2,maxcpus=8 */
> +        .config = SMP_CONFIG_WITH_FULL_TOPO(8, 1, 1, 2, 1, 1, 2, 2, 8),
> +        .expect_prefer_sockets = CPU_TOPOLOGY_GENERIC(8, 2, 2, 2, 8),
> +        .expect_prefer_cores   = CPU_TOPOLOGY_GENERIC(8, 2, 2, 2, 8),
>       },
>   };
>   


