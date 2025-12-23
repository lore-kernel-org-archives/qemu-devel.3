Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5959E6F079
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 10:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXzDZ-0001fT-NJ; Tue, 23 Dec 2025 05:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vXzDV-0001ev-Mn
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 05:02:09 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vXzDS-00073Z-Np
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 05:02:08 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 029C44174F;
 Tue, 23 Dec 2025 10:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF63C113D0;
 Tue, 23 Dec 2025 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766484123;
 bh=x9tjIlg3VX+f69EOUsnLTmF/yAHIyPV7HKv8MP5SXNA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PjINTrh0Unl/bKzyGWmhOt4s6mb1ehI8/fuqA2jQW4GijFkCly+m2q4VclX49exak
 t8q5AFYTszhy4Wde3djyh9Yq7uOb1C8HbYNcVXLmZZRM//GpZR2h2h0nS3IttzwoUr
 V7uVCU5sa0HfnpRV5EDFxsnxfFt69r7PttnBR4ZXZNPjgKa6O6VLPbqaYPihC1qZpp
 y5Wxy8y89zxXa8xx9+qaWKXf/qBNSFFccinBtS2B1jzZF5KGtObzGhjdOpMO85hkat
 X380rEz3hjQPtfyRs5/dCCfB5IIH3LnIxzUoIybUxk8gTsFFTV3EUD1SQ/d+12h9zn
 EFmdo84irBHOQ==
Message-ID: <586a3535-ffa1-4d13-8bb5-c1b922a90a43@kernel.org>
Date: Tue, 23 Dec 2025 11:01:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] numa: add 'spm' option for Specific Purpose Memory
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 fanhuang <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, Zhigang.Luo@amd.com,
 Lianjie.Shi@amd.com, Alistair Popple <apopple@nvidia.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 Paul Blinzer <Paul.Blinzer@amd.com>, dan.j.williams@intel.com
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <20251209093841.2250527-2-FangSheng.Huang@amd.com>
 <20251223095605.0000065d@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251223095605.0000065d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=david@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/23/25 10:56, Jonathan Cameron via wrote:
> On Tue, 9 Dec 2025 17:38:41 +0800
> fanhuang <FangSheng.Huang@amd.com> wrote:
> 
>> This patch adds support for Specific Purpose Memory (SPM) through the
>> NUMA node configuration. When 'spm=on' is specified for a NUMA node,
>> the memory region will be reported to the guest as soft reserved,
>> allowing device drivers to manage it separately from normal system RAM.
>>
>> Note: This option is only supported on x86 platforms. Using spm=on
>> on non-x86 machines will result in an error.
>>
>> Usage:
>>    -numa node,nodeid=0,memdev=m1,spm=on
>>
>> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
> 
> Given the discussions at LPC around how to present GPU/HBM memory and
> suggestions that reserved might be a better choice. I wonder if this
> patch should provide that option as well?  Or maybe as a potential follow
> up. The fun their is that you also need to arrange for DSDT entries to
> tie the region to the driver that actually wants it.
> 
> Anyhow that session reminded me of what SPM was designed for
> (you don't want to know how long it took to come up with the name)
> and it is a little more subtle than the description in here suggests.
> 
> The x86 specific code looks fine to me but I'm more or less totally
> unfamiliar with that, so need review from others.
> 
> +CC a few folk from that discussion. I wasn't there in person and
> it sounded like the discussion moved to the hallway so it may
> have come to a totally different conclusion!
> 
> https://lpc.events/event/19/contributions/2064/ has links to slides
> and youtube video.
> 
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 907cb25f75..cbb19da35c 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -500,6 +500,12 @@
>>   # @memdev: memory backend object.  If specified for one node, it must
>>   #     be specified for all nodes.
>>   #
>> +# @spm: if true, mark the memory region of this node as Specific
>> +#     Purpose Memory (SPM).  The memory will be reported to the
>> +#     guest as soft reserved, allowing device drivers to manage it
>> +#     separately from normal system RAM.  Currently only supported
>> +#     on x86.  (default: false, since 10.0)
> 
> As below. This needs to say something about letting the guest know
> that it might want to let a driver manage it separately from normal
> system RAM.
> 
>> +#
>>   # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
>>   #     to the nodeid which has the memory controller responsible for
>>   #     this NUMA node.  This field provides additional information as
>> @@ -514,6 +520,7 @@
>>      '*cpus':   ['uint16'],
>>      '*mem':    'size',
>>      '*memdev': 'str',
>> +   '*spm':    'bool',
>>      '*initiator': 'uint16' }}
>>   
>>   ##
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index fca2b7bc74..ffcd1f47cf 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -431,7 +431,7 @@ ERST
>>   
>>   DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>>       "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
>> -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
>> +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node][,spm=on|off]\n"
>>       "-numa dist,src=source,dst=destination,val=distance\n"
>>       "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
>>       "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n"
>> @@ -440,7 +440,7 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>>   SRST
>>   ``-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
>>     \
>> -``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
>> +``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator][,spm=on|off]``
>>     \
>>   ``-numa dist,src=source,dst=destination,val=distance``
>>     \
>> @@ -508,6 +508,13 @@ SRST
>>       largest bandwidth) to this NUMA node. Note that this option can be
>>       set only when the machine property 'hmat' is set to 'on'.
>>   
>> +    '\ ``spm``\ ' option marks the memory region of this NUMA node as
>> +    Specific Purpose Memory (SPM). When enabled, the memory will be
>> +    reported to the guest as soft reserved, allowing device drivers to
>> +    manage it separately from normal system RAM. This is useful for
>> +    device-specific memory that should not be used as general purpose
>> +    memory. This option is only supported on x86 platforms.
> 
> This wants tweaking.  As came up at the LPC discussion, SPM is for
> memory that 'might' be used as general purpose memory if the policy of the
> guest is to do so - as Alistair pointed out at LPC, people don't actually
> do that very often, but none the less that's why this type exists. It is
> a strong hint to the guest that it needs to apply a policy choice to
> what happens to this memory.

Just curious, it's the same on real hardware, right?

-- 
Cheers

David

