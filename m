Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5261FC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Wim-0002Je-Nd; Thu, 16 May 2024 04:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7Wik-0002Ip-L1
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:44:14 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7Wig-0004oZ-3f
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715849050; x=1747385050;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=m2KuwUWLQuvsU1YrEGkqd/3WTTJH4MB4ByuHtxm95W8=;
 b=X20FLATtpWL9dmaAyaZHX/4SIOFNk8G4kZSCp3bL9oraqAKbAdXk8888
 tREhFFWv2ABY5kUlKXUTE4IXrsgr3DHFqXL2fKXVT4ApmJlSxBusWmpek
 nNBkl1bWlLl70i05yN63OJ7ZtKPve0M/s6wznEo5LQUA3N95TEwpXjh9g
 AOqKer3HD2e/ZxFyzACDEGa5NsXi9ZfHZISkbxr34tPrYcQeRAFOmge9D
 aswVJ/xl69j8NEC3caWbRQqucjx+4sivlGTXz8uxPzwDAXuTP0m1Qj4T8
 UKEiQ9+a1W7VL0p/q0ZtmfESdSPk2vC2qIjASEecRzMVVgT4hjnxuTAyX w==;
X-CSE-ConnectionGUID: xtJoYypQQf2+fflPXQmtxQ==
X-CSE-MsgGUID: f9gxVxZfTo2GWA24uMWSKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12066745"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; d="scan'208";a="12066745"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 01:44:07 -0700
X-CSE-ConnectionGUID: n8T/XUA2T8uBHlyNb0kDvQ==
X-CSE-MsgGUID: f0zZ7XmuTFGDzxgEp2Zq3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; d="scan'208";a="31463079"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 16 May 2024 01:44:05 -0700
Date: Thu, 16 May 2024 16:59:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Krempa <pkrempa@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 2/2] tests: add testing of parameter=1 for SMP topology
Message-ID: <ZkXK62Oie/zRDEek@intel.com>
References: <20240513123358.612355-1-berrange@redhat.com>
 <20240513123358.612355-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513123358.612355-3-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Mon, May 13, 2024 at 01:33:58PM +0100, Daniel P. Berrangé wrote:
> Date: Mon, 13 May 2024 13:33:58 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH 2/2] tests: add testing of parameter=1 for SMP topology
> 
> Validate that it is possible to pass 'parameter=1' for any SMP topology
> parameter, since unsupported parameters are implicitly considered to
> always have a value of 1.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/unit/test-smp-parse.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
> index 56165e6644..56ce5128f1 100644
> --- a/tests/unit/test-smp-parse.c
> +++ b/tests/unit/test-smp-parse.c
> @@ -330,6 +330,14 @@ static const struct SMPTestData data_generic_valid[] = {
>          .config = SMP_CONFIG_GENERIC(T, 8, T, 2, T, 4, T, 2, T, 16),
>          .expect_prefer_sockets = CPU_TOPOLOGY_GENERIC(8, 2, 4, 2, 16),
>          .expect_prefer_cores   = CPU_TOPOLOGY_GENERIC(8, 2, 4, 2, 16),
> +    }, {
> +        /*
> +         * Unsupported parameters are always allowed to be set to '1'
> +         * config: -smp 8,books=1,drawers=1,sockets=2,modules=1,dies=1,cores=4,threads=2,maxcpus=8
> +         * expect: cpus=8,sockets=2,cores=2,threads=2,maxcpus=8 */
> +        .config = SMP_CONFIG_WITH_FULL_TOPO(8, 1, 1, 2, 1, 1, 2, 2, 8),
> +        .expect_prefer_sockets = CPU_TOPOLOGY_GENERIC(8, 2, 2, 2, 8),
> +        .expect_prefer_cores   = CPU_TOPOLOGY_GENERIC(8, 2, 2, 2, 8),
>      },
>  };
>  

As Xiaoyao's suggestion, only the nit in the comment.

Others look good to me, so,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



