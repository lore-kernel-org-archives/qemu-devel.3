Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC32A107BCE6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 22:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1B60-0004TP-8v; Fri, 13 Mar 2026 18:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1w1B5x-0004Sx-BJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 18:35:02 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1w1B5u-0007uZ-Gx
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 18:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773441299; x=1804977299;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Ipowi3rrCT9fCdEHdxTMaKC4edFYCMoAgK16e4/IIsA=;
 b=T3J6ZCrI9tZMmgw0y9waUbwIJC2M65DXtugB9zbSFRH5TzSWSft23C7u
 UozsUeUaeZyGdIeAbMc5JaaN+ITbkIE6jCPgTR7lHU0NIMHMuALtCw8e/
 JrpkRHUKZTcBJIZ3dh1ghbLLV7JxDdF/W+XSGsLUz2XTpx7CMXNZhRfHn
 BvgX5QPApFTy8ejuwUlyafghzeFlOjSAxFaTfCm+rGTx0quFnRcC81vPt
 hrUq+WJNxS79T7Ij72nGWk12Z0R6GrnR+MaTU43b4PaNoIEEjuoD7HCl1
 XuryQwMKg0U9XftplHKMI7XeqnxHD3AR3n+xEqdYDlQ7X06Vs4HwuOK3a g==;
X-CSE-ConnectionGUID: IB5Im7l3T2+HUH2LaPiAWg==
X-CSE-MsgGUID: tbnrOcjJQFmBBu3YVFS5xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="91936038"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="91936038"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 15:34:54 -0700
X-CSE-ConnectionGUID: jp/yHgzpRtus+yQ5nDOSVw==
X-CSE-MsgGUID: j1PjdnuQRs2GrmmcrVLRYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="221375121"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.240.205])
 ([10.241.240.205])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 15:34:53 -0700
Message-ID: <291e0970-97f0-43bf-8e28-5583dc203fe6@intel.com>
Date: Fri, 13 Mar 2026 15:34:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/21] target/i386: remove redundant validation for
 lbr-fmt property
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-20-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260210032348.987549-20-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zide.chen@intel.com;
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



On 2/9/2026 7:23 PM, Zhao Liu wrote:
> The 'lbr-fmt' property is defined via DEFINE_PROP_UINT64_CHECKMASK,
> utilizing PERF_CAP_LBR_FMT as the validation mask. This mechanism
> ensures that the property setter rejects any value attempting to set
> bits outside this mask.
> 
> So cpu->lbr_fmt is guaranteed to be valid by the time
> x86_cpu_realizefn() executes. The manual validation inside the realize
> function is therefore redundant.
> 
> Remove the unnecessary check.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---

Reviewed-by: Zide Chen <zide.chen@intel.com>


>  target/i386/cpu.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c2f99b98014a..a594747f0030 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9816,10 +9816,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>       * with user-provided setting.
>       */
>      if (cpu->lbr_fmt != ~PERF_CAP_LBR_FMT) {
> -        if ((cpu->lbr_fmt & PERF_CAP_LBR_FMT) != cpu->lbr_fmt) {
> -            error_setg(errp, "invalid lbr-fmt");
> -            return;
> -        }
>          env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
>          env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
>      }


