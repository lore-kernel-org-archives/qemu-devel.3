Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57356C77B7F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 01:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUEV4-0002pM-4B; Tue, 24 Jun 2025 21:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uUEV2-0002pC-DC
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 21:00:28 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uUEUz-0007pq-3k
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 21:00:27 -0400
X-ASG-Debug-ID: 1750813210-1eb14e1c3a17970001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id UPSCjCisR2vnNgmp (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Wed, 25 Jun 2025 09:00:10 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 25 Jun
 2025 09:00:09 +0800
Received: from ZXSHMBX1.zhaoxin.com ([::1]) by ZXSHMBX1.zhaoxin.com
 ([fe80::2c07:394e:4919:4dc1%7]) with mapi id 15.01.2507.044; Wed, 25 Jun 2025
 09:00:09 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 24 Jun
 2025 19:04:19 +0800
Message-ID: <8bab0159-54d3-4f48-aadf-23491171018d@zhaoxin.com>
Date: Tue, 24 Jun 2025 19:04:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved
 for Intel
CC: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Babu Moger
 <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK
 <tejus.gk@nutanix.com>, Jason Zeng <jason.zeng@intel.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <cobechen@zhaoxin.com>,
 <Frankzhu@zhaoxin.com>, <Runaguo@zhaoxin.com>, <yeeli@zhaoxin.com>,
 <Xanderchen@zhaoxin.com>, <MaryFeng@zhaoxin.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-2-zhao1.liu@intel.com>
 <fa16f7a8-4917-4731-9d9f-7d4c10977168@zhaoxin.com>
 <aDWCxhsCMavTTzkE@intel.com>
 <3318af5c-8a46-4901-91f2-0b2707e0a573@zhaoxin.com>
 <aFpSN+zEgJl72V46@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <aFpSN+zEgJl72V46@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 6/25/2025 9:00:08 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1750813210
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4056
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.62
X-Barracuda-Spam-Status: No,
 SCORE=-1.62 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_SA085b
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.143350
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.40 BSF_SC0_SA085b         Custom Rule SA085b
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 6/24/25 3:22 PM, Zhao Liu wrote:
> 
> On Tue, May 27, 2025 at 05:56:07PM +0800, Ewan Hai wrote:
>> Date: Tue, 27 May 2025 17:56:07 +0800
>> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
>> Subject: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved for
>>   Intel
>>
>>
>>
>> On 5/27/25 5:15 PM, Zhao Liu wrote:
>>>
>>>> On 4/23/25 7:46 PM, Zhao Liu wrote:
>>>>>
>>>>> Per SDM, 0x80000005 leaf is reserved for Intel CPU, and its current
>>>>> "assert" check blocks adding new cache model for non-AMD CPUs.
>>>>>
>>>>> Therefore, check the vendor and encode this leaf as all-0 for Intel
>>>>> CPU. And since Zhaoxin mostly follows Intel behavior, apply the vendor
>>>>> check for Zhaoxin as well.
>>>>>
>>>>> Note, for !vendor_cpuid_only case, non-AMD CPU would get the wrong
>>>>> information, i.e., get AMD's cache model for Intel or Zhaoxin CPUs.
>>>>> For this case, there is no need to tweak for non-AMD CPUs, because
>>>>> vendor_cpuid_only has been turned on by default since PC machine v6.1.
>>>>>
>>>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>>>> ---
>>>>>     target/i386/cpu.c | 16 ++++++++++++++--
>>>>>     1 file changed, 14 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>>> index 1b64ceaaba46..8fdafa8aedaf 100644
>> [snip]>>> +
>>>>>             *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
>>>>>                    (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
>>>>>             *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
>>>>
>>>> I've reviewed the cache-related CPUID path and noticed an oddity: every AMD
>>>> vCPU model still reports identical hard-coded values for the L1 ITLB and L1
>>>> DTLB fields in leaf 0x8000_0005. Your patch fixes this for Intel(and
>>>> Zhaoxin), but all AMD models continue to receive the same constants in
>>>> EAX/EBX.
>>>
>>> Yes, TLB info is hardcoded here. Previously, Babu and Eduardo cleaned up
>>> the cache info but didn't cover TLB [*]. I guess one reason would there
>>> are very few use cases related to TLB's info, and people are more
>>> concerned about the cache itself.
>>>
>>> [*]: https://lore.kernel.org/qemu-devel/20180510204148.11687-2-babu.moger@amd.com/
>>
>> Understood. Keeping the L1 I/D-TLB fields hard-coded for every vCPU model is
>> acceptable.
>>
>>>> Do you know the reason for this choice? Is the guest expected to ignore
>>>> those L1 TLB numbers? If so, I'll prepare a patch that adjusts only the
>>>> Zhaoxin defaults in leaf 0x8000_0005 like below, matching real YongFeng
>>>> behaviour in ecx and edx, but keep eax and ebx following AMD's behaviour.
>>>
>>> This way is fine for me.
>>>
>>
>> Thanks for confirming. I'll post the YongFeng cache-info series once your
>> refactor lands.
> 
> Hi Ewan,
> 
> By this patch:
> 
> https://lore.kernel.org/qemu-devel/20250620092734.1576677-14-zhao1.liu@intel.com/
> 
> I fixed the 0x80000005 leaf for Intel and Zhaoxin based on your feedback
> by the way.
> 
> It looks like the unified cache_info would be very compatible with
> various vendor needs and corner cases. So I'll respin this series based
> on that cache_info series.
> 
> Before sending the patch, I was thinking that maybe I could help you
> rebase and include your Yongfeng cache model patch you added into my v2
> series, or you could rebase and send it yourself afterward. Which way do
> you like?

It would be great if you could include the Yongfeng cache-model patch in your v2 
series. Let me know if you need any more information about the Yongfeng cache 
model. After you submit v2, I can review the Zhaoxin parts and make any 
necessary code changes if needed.

And thanks again for taking Zhaoxin into account.

> 
> And for TLB, we can wait and see what maintainers think. Maybe it is
> possible, considering that the cache also transitioned from hardcoding
> to a cache model (since commit 7e3482f82480).
> 
Let's wait.> Thanks,
> Zhao
> 



