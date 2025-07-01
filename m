Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0F1C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 06:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWUou-00019r-T2; Tue, 01 Jul 2025 02:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWUon-00018r-Ms
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:50:13 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWUok-0006nA-2N
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751352610; x=1782888610;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bfIgNabme3lWjnyhb85FNuwrnZ3Hbn/38kMllrUwWnM=;
 b=jAQ3FS5xAKJkLZHAneFneMzGQDwF/dbi5pztK409W2rNGMIYCZo+lElf
 7uyoWfPy0e1mbIsXopIrXKyXHq75LuyXiZ6r/o7Ssu+NH7ocBvR+tleWW
 xiTOdMM+x61+6GktKwN7QwCP0FmyT/2tAt5pDCvWNgwyauZ0C44xUWDWc
 reoo2LqqmmzyaQEI2hSrFVlxRzuhuMb4a/IlJGeDgAJKw2r561uT4Q+ZT
 FOxalOcABBZYnDPkUIl57OHEB88Z7wm5mByDfZsXKCmI859crNShn1HeD
 VZImf32e2df7YZaltKL9Cu7SijihowwLARMLnI9fXh6VBO491/TGN7SQX A==;
X-CSE-ConnectionGUID: CTCqP2LYSQS+kUvrPjw64Q==
X-CSE-MsgGUID: HE7sBN+GR8GLP2bGC8jojg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53744954"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="53744954"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 23:50:07 -0700
X-CSE-ConnectionGUID: QzGA+o1LT7+GBG4WhwPd3A==
X-CSE-MsgGUID: NOlxvFbyTk6Q++F4AmFYsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="159189878"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 23:50:06 -0700
Message-ID: <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
Date: Tue, 1 Jul 2025 14:50:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dongli Zhang <dongli.zhang@oracle.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=EF=BF=BD?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
 <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com>
 <aFpocfTpBLB34N3l@intel.com> <aGKryLSGlFTMSKHv@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aGKryLSGlFTMSKHv@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
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

On 6/30/2025 11:22 PM, Zhao Liu wrote:
> (cc Thomas for bug reporting on kvm-unit-test...)
> 
> On Tue, Jun 24, 2025 at 04:57:21PM +0800, Zhao Liu wrote:
>> Date: Tue, 24 Jun 2025 16:57:21 +0800
>> From: Zhao Liu <zhao1.liu@intel.com>
>> Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
>>   instance_post_init calls
>>
>> On Mon, Jun 23, 2025 at 09:56:14AM -0700, Dongli Zhang wrote:
>>> Date: Mon, 23 Jun 2025 09:56:14 -0700
>>> From: Dongli Zhang <dongli.zhang@oracle.com>
>>> Subject: [Regression] Re: [PULL 35/35] qom: reverse order of
>>>   instance_post_init calls
>>>
>>> This commit may broken the "vendor=" configuration.
>>>
>>> For instance, the hypervisor CPU vendor is AMD.
>>>
>>> I am going to use "-cpu Skylake-Server,vendor=GenuineIntel".
>>>
>>>
>>> Because of the commit, the vendor is still AMD.
>>>
>>> [root@vm ~]# cpuid -1 -l 0x0
>>> CPU:
>>>     vendor_id = "AuthenticAMD"
>>>
>>>
>>> If I revert this patch, the vendor because the expected Intel.
>>>
>>> [root@vm ~]# cpuid -1 -l 0x0
>>> CPU:
>>>     vendor_id = "GenuineIntel"
>>>
>>>
>>> Thank you very much!
>>
>> Thank you Dongli!
>>
>> (+Like)
>>
>> While testing my cache model series, I also noticed the similar behavior
>> for KVM. Additionally, Like Xu reported to me that this commit caused
>> a failure in a KVM unit test case. Your report helped me connect these
>> two issues I met (though due to my environment issues, I haven't
>> confirmed yet).
> 
> Ok, now I can confirm this commit cause KUT failure:
>   * On AMD platform, the "msr.flat" case fails since this case requires
>     vendor=GenuineIntel (tested by Like).
>   * On Intel platform, the "syscall.flat" case fails because it requires
>     vendor=AuthenticAMD (tested by myself).
> 
>> The "vendor" property from cli is registered as the global property in
>> x86_cpu_parse_featurestr(), and is applied to x86 CPUs in
>> device_post_init().
>>
>> With this commit, now KVM will override the "vendor" in
>> host_cpu_instance_init() (called in x86_cpu_post_initfn()) after
>> device_post_init(), regardless the previous global "vendor" property.
> 
> This is the root cause for the above failure.
> 
>> Back to this commit, I think current order of post_init  makes sense.
>> Instead, the place of host_cpu_instance_init() doesn't seem quite
>> right. So, I think this commit might have exposed some drawbacks in the
>> previous x86 CPU initialization order:
>>
>> f5cc5a5c1686 ("i386: split cpu accelerators from cpu.c, using AccelCPUClass")
>> 5b8978d80426 ("i386: do not call cpudef-only models functions for max, host, base")
> 
> To fix this issue, we need to initialize "vendor" property in the initfn
> of max/host/named CPUs instead of current post_initfn.
> 
> This will need to split the cpu_instance_init() of x86 kvm (and maybe hvf/tcg)
> into 2 hooks:
>   * AccelCPUClass.cpu_instance_init() - called in x86 CPUs' initfn.
>   * AccelCPUClass.cpu_instance_post_init() - called in x86 CPUs'
>     post_initfn.

Split accel.cpu_instance_init() into cpu's instance_init() and 
post_instance_init() does not seem right way to go.

The reason .post_instance_init() was implemented and put 
accel_cpu_instance_init() in it for x86 cpu was that, we don't want to 
scatter acceletor specific instance_init operation into different 
subclass of x86 cpu (max/host/named cpu model).

I think something like below should be enough.

-----------8<-------------
Author: Xiaoyao Li <xiaoyao.li@intel.com>
Date:   Tue Jul 1 13:33:43 2025 +0800

     i386/cpu: Re-apply the global props as the last step of post_init

     Commit 220c739903ce ("qom: reverse order of instance_post_init calls")
     reverses the order instance_post_init calls, which leads to
     device_post_init() called before x86 cpu specific 
.instance_post_init().

     However, x86 cpu replies on qdev_prop_set_globals() (inside
     device_post_init()) to apply the cpu option like "feature[=foo]" passed
     via '-cpu' as the last step to make the '-cpu' option highest priority.

     After the order change of .instance_post_init(), x86_cpu_post_initfn()
     is called after device_post_init(), and it will change some property
     value even though "-cpu" option specify a different one.

     Re-apply the global props as the last step to ensure "-cpu" option
     always takes highest priority.

     Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430fe..bf290262cbfe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9044,6 +9044,12 @@ static void x86_cpu_post_initfn(Object *obj)
              X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
      }
  #endif
+
+    /*
+     * Re-apply the "feature[=foo]" from '-cpu' option since they might
+     * be overwritten by above
+     */
+    qdev_prop_set_globals(DEVICE(obj));
  }

  static void x86_cpu_init_default_topo(X86CPU *cpu)



