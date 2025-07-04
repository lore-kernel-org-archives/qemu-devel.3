Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E38C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 05:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXZLy-0006vV-Si; Fri, 04 Jul 2025 01:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXZLw-0006vI-NK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 01:52:53 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXZLp-0007TZ-UK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 01:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751608366; x=1783144366;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=i3QvBSEIB5lb6LDMtH33KoJ1GpeNf3jG66i5CRCWR40=;
 b=Ja3+8m/GpbmKiyJUQznc3dffOynFCF1bzQcSzdbMmxJOPQNEKKbYqmTq
 IWlZaKDAvhFiBK+xF48ieVV643+5C63etEENAxG8aWzNBON2jE/nGRZQU
 fQ++bmCTAEdi+5ibw7af0wRREGCl9fpjUN0MsJ2xpvDOyJhp8rpWohZNL
 lHAnk04c0ZFm97CZEsS6r62L0u2Ne5CzCdnsM1k1fYbkwJCJjkazVgW19
 +S41aEe6ty5g+/elTxKYiqspsIo7d0CVY5ZTgwsNwappQjkC8bZu6cPeA
 Fn8Jo7S7whTdmtsoBh2FPC6QNlyfDK7g98etNApulO0BdNxfM/Jdn8iu/ A==;
X-CSE-ConnectionGUID: Nyi5yUXwRB2hfhcAxqbddQ==
X-CSE-MsgGUID: 5/MLIUV8QwWvBcOcL7LXTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53163186"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53163186"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 22:52:43 -0700
X-CSE-ConnectionGUID: fzmOJIWRT9WuYORYbwxBGA==
X-CSE-MsgGUID: lXnAQr8FReOXtTiKPf3OhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="185582502"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 22:52:39 -0700
Message-ID: <2d624471-1762-455e-8d3c-b911fdf3eb08@intel.com>
Date: Fri, 4 Jul 2025 13:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/39] cpus: Document CPUState::vcpu_dirty field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-18-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250703173248.44995-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   include/hw/core/cpu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 162a56a5daa..5eaf41a566f 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -442,6 +442,7 @@ struct qemu_work_item;
>    * @opaque: User data.
>    * @mem_io_pc: Host Program Counter at which the memory was accessed.
>    * @accel: Pointer to accelerator specific state.
> + * @vcpu_dirty: Hardware accelerator is not synchronized with QEMU state
>    * @kvm_fd: vCPU file descriptor for KVM.
>    * @work_mutex: Lock to prevent multiple access to @work_list.
>    * @work_list: List of pending asynchronous work.
> @@ -538,7 +539,6 @@ struct CPUState {
>       uint32_t kvm_fetch_index;
>       uint64_t dirty_pages;
>       int kvm_vcpu_stats_fd;
> -    bool vcpu_dirty;
>   
>       /* Use by accel-block: CPU is executing an ioctl() */
>       QemuLockCnt in_ioctl_lock;
> @@ -554,6 +554,7 @@ struct CPUState {
>       uint32_t halted;
>       int32_t exception_index;
>   
> +    bool vcpu_dirty;
>       AccelCPUState *accel;
>   
>       /* Used to keep track of an outstanding cpu throttle thread for migration


