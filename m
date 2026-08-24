Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4978EC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyMv4-000534-6m; Mon, 24 Aug 2026 01:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wyMv1-00052Z-1S
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:08:23 -0400
Received: from [115.124.28.50] (helo=out28-50.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wyMuw-0006jK-R8
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:08:22 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436267|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.113531-0.015932-0.870537;
 FP=7205660562698012251|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033040074035;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=8; RT=8; SR=0;
 TI=SMTPD_---.ivaIACA_1787547955; 
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.ivaIACA_1787547955 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 24 Aug 2026 13:05:55 +0800
Message-ID: <199e4e38-9942-463a-8edd-b97cf2b32f73@open-hieco.net>
Date: Mon, 24 Aug 2026 13:05:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] target/i386: Sync AMD CPUID aliases for Hygon
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Yanjing Zhou <zhouyanjing@hygon.cn>,
 Yongwei Xu <xuyongwei@open-hieco.net>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-2-zhang_wei@open-hieco.net>
 <aoqzsAC5dBBuLQ8h@intel.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <aoqzsAC5dBBuLQ8h@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.50 (deferred)
Received-SPF: pass client-ip=115.124.28.50;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-50.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Hi Zhao,

Thank you for the detailed review and helpful suggestions.

I have addressed your comments in v3, including rebasing the series onto 
the latest master, splitting the PMU changes, updating the IOMMU helper 
and tests, and fixing the pc-11.1 compatibility descriptions.

The v3 series is available here:
https://lists.nongnu.org/archive/html/qemu-devel/2026-08/msg05437.html

Thanks,
Tina

On 8/23/2026 4:47 PM, Zhao Liu wrote:
> On Mon, Aug 10, 2026 at 04:29:48PM +0800, Tina Zhang wrote:
>> Date: Mon, 10 Aug 2026 16:29:48 +0800
>> From: Tina Zhang <zhang_wei@open-hieco.net>
>> Subject: [PATCH v2 1/9] target/i386: Sync AMD CPUID aliases for Hygon
>> X-Mailer: git-send-email 2.43.7
>>
>> AMD defines CPUID[0x80000001].EDX bits as aliases for a subset of
>> CPUID[1].EDX.  QEMU currently synchronizes those aliases only when the
>> guest CPU vendor is AuthenticAMD.
>>
>> Hygon Dhyana uses the HygonGenuine vendor string, but implements the
>> same AMD-compatible extended CPUID feature aliases.  This can leave QEMU
>> advertising a feature in CPUID[1].EDX while the matching extended alias
>> in CPUID[0x80000001].EDX stays clear.  This inconsistent CPUID state can
>> confuse guest OS feature detection.
>>
>> Apply the alias synchronization to Hygon CPUs as well.  Gate the new
>> behavior with x-hygon-vendor-abi-fixes and disable it for pc-11.0 and
>                                                              ^^^^^^^
> nit: pc-11.1 ?
> 
>> older machine types, because the CPUID result is guest-visible ABI and
>> must remain migration-compatible.
>>
>> Add qtest coverage for the Dhyana model, including the compat property.
>>
>> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
>> Tested-by: Yongwei Xu <xuyongwei@open-hieco.net>
>> ---
>>   hw/i386/pc.c                        |  5 ++
>>   hw/i386/pc_piix.c                   |  1 +
>>   hw/i386/pc_q35.c                    |  1 +
>>   include/hw/i386/pc.h                |  3 ++
>>   target/i386/cpu.c                   | 10 ++--
>>   target/i386/cpu.h                   | 13 +++++
>>   tests/qtest/test-x86-cpuid-compat.c | 76 +++++++++++++++++++++++++++++
>>   7 files changed, 106 insertions(+), 3 deletions(-)
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index f064aa2b3e..2b4e322b2f 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -74,6 +74,11 @@
>>   #include "hw/xen/xen-bus.h"
>>   #endif
>>   
>> +GlobalProperty pc_compat_11_1[] = {
>> +    { TYPE_X86_CPU, "x-hygon-vendor-abi-fixes", "false" },
>> +};
>> +const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
>> +
> 
> compat machine property is already on the master branch, so this
> patch need to be rebased.
> 
>>   GlobalProperty pc_compat_11_0[] = {};
>>   const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 82457bdb16..8e58f2a7ee 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -438,6 +438,7 @@ DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
>>   static void pc_i440fx_machine_11_0_options(MachineClass *m)
>>   {
>>       pc_i440fx_machine_11_1_options(m);
> 
> pc_i440fx_machine_11_1_options() has added pc_compat_11_1...
> 
>> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> 
> ...so taht now we don't need ao do this again.
> 
>>       compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>>       compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
>>   }
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 6c1e4eff5f..fd4366f51f 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -393,6 +393,7 @@ DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
>>   static void pc_q35_machine_11_0_options(MachineClass *m)
>>   {
>>       pc_q35_machine_11_1_options(m);
>> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> 
> ditto.
> 
>>       compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>>       compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
>>   }
> 
> Overall, LGTM except rebasing :).
> 
> Regards,
> Zhao


