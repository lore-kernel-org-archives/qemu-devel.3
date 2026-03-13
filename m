Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF1E107BCE6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 22:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1B7O-00058h-5Y; Fri, 13 Mar 2026 18:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1w1B7B-00053E-AI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 18:36:18 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1w1B78-0008DQ-Dw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 18:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773441375; x=1804977375;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1P94Ih71Rc6BxBWCR/FMoKb3vqEnmdLR7+m2OUz9M/I=;
 b=Wr2IxwT+gX/CHrP70HNRo+k8Qe8x804WmX1RVUqFds+wSr1WPXMBuxHC
 YVbXV7zbT9xaM54yPzi1Edj1Xb5/fk8mg6HaGCRxscqz242Sm5Y0c+V33
 kUvyZDMU0g4lrdn8Tzxcrxbh9AGIZ8CXsm+duRolflDFgEezs1YL4fHBG
 AvzYiwIExA7E9N0rLn2VsiCIbCbjS/3XyrMLImEirH6SkDcGn1PwkIHu3
 dSf3U06GPWocRVrOokW0v85tAHn7MbStgmmhC6EWGtmLdjplavx8AlWXq
 wVglwLMmbe2WMNTIolaeffA5BlFKcMpNw1Kp14z5g5KuMEWiBRv3bkL/N w==;
X-CSE-ConnectionGUID: rrt8i9mWSkelQhUBcK811Q==
X-CSE-MsgGUID: H9SZZoX4T/CcCpzAD2FLVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="91936087"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="91936087"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 15:36:14 -0700
X-CSE-ConnectionGUID: Addf1a0aTmOL+cSSTKBNkA==
X-CSE-MsgGUID: mGTZL7c6TPSgEinmOmqp/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="221375422"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.240.205])
 ([10.241.240.205])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 15:36:12 -0700
Message-ID: <a4df97c1-ca68-490c-8576-dc83a1908da9@intel.com>
Date: Fri, 13 Mar 2026 15:36:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/21] hw/core/qdev-properties: support valid default
 value for DEFINE_PROP_UINT64_CHECKMASK
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
 <20260210032348.987549-22-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260210032348.987549-22-zhao1.liu@intel.com>
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
> DEFINE_PROP_UINT64_CHECKMASK is designed to detect and check user's
> property setting:
>  * checking: check property value against a bitmask.
>  * detection: ask caller to provide an invalid value as the initial
>      "sentinel" value, which is impossible to be set by users. However,
>      this detection is not strict, since the property could be also
>      set internally.
> 
> The entire mechanism is not easy to use.
> 
> Now there's USER_SET flag in place (and the current unique use case
> "lbr-fmt" has been converted to checking USER_SET way), manual setting
> of invalid initial values is no longer required.
> 
> Thus, extend DEFINE_PROP_UINT64_CHECKMASK to support *valid* default
> value, and for "lbr-fmt" case, replace the invalid initialization value
> `~PERF_CAP_LBR_FMT` with a valid value `0`.
> 
> In addition, considering DEFINE_PROP_UINT64_CHECKMASK itself actually
> doesn't identify whether the property is set by the user or not, remove
> "user-supplied" related description in its document.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---

Nice to see "cpu->lbr_fmt = ~PERF_CAP_LBR_FMT" is gone.

Reviewed-by: Zide Chen <zide.chen@intel.com>

>  hw/core/qdev-properties.c         |  1 +
>  include/hw/core/qdev-properties.h | 14 +++++++-------
>  target/i386/cpu.c                 |  4 +---
>  3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 91c4010e7dc9..b84214e60f19 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -507,6 +507,7 @@ const PropertyInfo qdev_prop_uint64_checkmask = {
>      .type  = "uint64",
>      .get   = get_uint64,
>      .set   = set_uint64_checkmask,
> +    .set_default_value = qdev_propinfo_set_default_value_uint,
>  };
>  
>  /* --- pointer-size integer --- */
> diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
> index c06de37b1e9d..2ac784bb5e9c 100644
> --- a/include/hw/core/qdev-properties.h
> +++ b/include/hw/core/qdev-properties.h
> @@ -128,14 +128,14 @@ extern const PropertyInfo qdev_prop_link;
>                  ##__VA_ARGS__)
>  
>  /**
> - * The DEFINE_PROP_UINT64_CHECKMASK macro checks a user-supplied value
> - * against corresponding bitmask, rejects the value if it violates.
> - * The default value is set in instance_init().
> + * The DEFINE_PROP_UINT64_CHECKMASK macro checks a value against corresponding
> + * bitmask, rejects the value if it violates.
>   */
> -#define DEFINE_PROP_UINT64_CHECKMASK(_name, _state, _field, _bitmask)   \
> -    DEFINE_PROP(_name, _state, _field, qdev_prop_uint64_checkmask, uint64_t, \
> -                .bitmask    = (_bitmask),                     \
> -                .set_default = false)
> +#define DEFINE_PROP_UINT64_CHECKMASK(_name, _state, _field, _bitmask, _defval) \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_uint64_checkmask, uint64_t,   \
> +                .bitmask    = (_bitmask),                                      \
> +                .set_default = true,                                           \
> +                .defval.u    = (_defval))
>  
>  /**
>   * DEFINE_PROP_ARRAY:
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a6d943c53a3f..56735570d66c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10265,9 +10265,7 @@ static void x86_cpu_initfn(Object *obj)
>      object_property_add_alias(obj, "pause_filter", obj, "pause-filter");
>      object_property_add_alias(obj, "sse4_1", obj, "sse4.1");
>      object_property_add_alias(obj, "sse4_2", obj, "sse4.2");
> -
>      object_property_add_alias(obj, "hv-apicv", obj, "hv-avic");
> -    cpu->lbr_fmt = ~PERF_CAP_LBR_FMT;
>      object_property_add_alias(obj, "lbr_fmt", obj, "lbr-fmt");
>  
>      if (xcc->model) {
> @@ -10439,7 +10437,7 @@ static const Property x86_cpu_properties[] = {
>  #endif
>      DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
>      DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
> -    DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT),
> +    DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT, 0),
>  
>      DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
>                         HYPERV_SPINLOCK_NEVER_NOTIFY),


