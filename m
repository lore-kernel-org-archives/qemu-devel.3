Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD47FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 03:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXI2-0005nz-1i; Thu, 03 Jul 2025 23:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXI0-0005nl-Lr
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:40:40 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXHy-0006OK-Rm
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751600438; x=1783136438;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=H+9FlPA/E27UVUZyU80QAOeyZpqYBxUcfq+7kni2r10=;
 b=djTiK9rGQbJjub4cMXYFf/oHYP/2fj1XH+pkhe54bMSyXM8GgnoSq578
 I+HwI0fyn9TabivhFwBfX78Uo1JEo1bnAeQ4R6ecB66pcdHrZXK3gU4Wf
 RQ5AbjjMNKgznT+IFr+qzT/VrqjED7jqd7K+qpWN56kHfSVP5tfatOIpl
 MSXJDYAxhlMo5FrfivmW8c7vES8INdpOFXb1auTMM6c0tZF/G0dduBkWw
 Qijqs7n9IxGyws+OMF+9v6P5o5vfHB63t0NRx1awWmBvM+6AHvW69SJt0
 8b30LkQo/T3QuGNkn3Xpt7NnD2G4ATMCBX1zUHQba8aRTrICuszq57xBd w==;
X-CSE-ConnectionGUID: Mb/rbilQQkKz+YZNsScU8Q==
X-CSE-MsgGUID: uSX0g9/bQgOC+dEB6v5R0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="41562265"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="41562265"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:40:36 -0700
X-CSE-ConnectionGUID: Yh4V0IXFSiaBniZqekv0nw==
X-CSE-MsgGUID: +cCMRDReSl+snyZaUur+Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="158572287"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:40:34 -0700
Message-ID: <9a4fb69b-540e-4758-9168-60994f58f95c@intel.com>
Date: Fri, 4 Jul 2025 11:40:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/39] system/runstate: Document
 qemu_add_vm_change_state_handler()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-4-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250703173248.44995-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/system/runstate.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/system/runstate.h b/include/system/runstate.h
> index fdd5c4a5172..b6e8d6beab7 100644
> --- a/include/system/runstate.h
> +++ b/include/system/runstate.h
> @@ -14,6 +14,16 @@ void runstate_replay_enable(void);
>   typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
>   typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState state);
>   
> +/**
> + * qemu_add_vm_change_state_handler:
> + * @cb: the callback to invoke
> + * @opaque: user data passed to the callback
> + *
> + * Register a callback function that is invoked when the vm starts or stops
> + * running.
> + *
> + * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
> + */

qemu_add_vm_change_state_handler_prio() and 
qemu_add_vm_change_state_handler_prio_full() put the document in the 
implementation in system/runstate.c.

Please make them consistent.

>   VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>                                                        void *opaque);
>   VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(


