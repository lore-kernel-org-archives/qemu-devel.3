Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C1C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpi2k-0001iv-95; Fri, 31 Jul 2026 03:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wpi2h-0001ib-7f
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:52:31 -0400
Received: from [115.124.28.219] (helo=out28-219.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wpi2e-0003e8-O7
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:52:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07836451|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.274819-0.00941988-0.715761;
 FP=7060517339840209002|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033045018182;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.iaJHpDT_1785484205; 
Received: from 172.18.22.107(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iaJHpDT_1785484205 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 15:50:06 +0800
Message-ID: <ba2b2084-26c3-49a8-bf56-fff34b4c0802@open-hieco.net>
Date: Fri, 31 Jul 2026 15:50:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] target/i386: Sync AMD CPUID aliases for Hygon
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-2-zhang_wei@open-hieco.net>
 <amxIj+rZvDrtX7BM@intel.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <amxIj+rZvDrtX7BM@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.219 (deferred)
Received-SPF: pass client-ip=115.124.28.219;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-219.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
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

On 7/31/2026 3:02 PM, Zhao Liu wrote:
>> -GlobalProperty pc_compat_11_0[] = {};
>> +GlobalProperty pc_compat_11_0[] = {
>> +    { TYPE_X86_CPU, "x-hygon-vendor-abi-fixes", "false" },
>> +};
> This needs rebase on v11.1 🙂

Right, I will rebase this on top of v11.1.

>> -    if (IS_AMD_CPU(env)) {
>> +    if (x86_cpu_has_amd_cpuid_aliases(cpu)) {
> Or we can omit this helper ("x86_cpu_has_amd_cpuid_aliases(cpu)") and
> instead do the check directly inline?
> 
> I think we should have fewer helpers like this, unless the conditional
> checks are really lengthy... Since the helpers added for each ABI is
> similar, but we can’t consolidate them into a single generic helper
> (because while the AMD and Hygon ABIs are basically similar, there are
> still differences), having too many similar helpers makes the code seem
> fragmented.

Agreed. The helper is unnecessary for this short condition. I will 
inline the Hygon-gated check in v2 to avoid adding another small 
ABI-specific helper.


> 
>> @@ -2461,6 +2467,12 @@ struct ArchCPU {
>>        */
>>       bool vendor_cpuid_only_v2;
>>   
>> +    /*
>> +     * Enable Hygon vendor ABI fixes for new machine types.  Old machine
>> +     * types disable this to preserve guest-visible CPU ABI.
>> +     */
>> +    bool hygon_vendor_abi_fixes;
>> +
> Maybe the following comment to emphasize this is a compat option?

Yes, that wording is clearer. I will update the comment in v2.

Thanks,
Tina
> 
> /*
>   * Compatibility bits for old machine types: if true, apply Hygon
>   * vendor-specific ABI fixes.  Old machine types disable this to
>   * preserve the guest-visible CPU ABI.
>   */






