Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7D2EFCE21
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxppc-00062v-Fg; Wed, 04 Mar 2026 12:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vxppa-00062m-QX
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:16:19 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vxppZ-0008WT-1u
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:16:18 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 72F8B60018;
 Wed,  4 Mar 2026 17:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842E6C4CEF7;
 Wed,  4 Mar 2026 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772644569;
 bh=4zD8/+8hnl9047vbUIXxxm9N+Gc4t7NAAW6/uOqaKuE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rcaQNqCJ8gJ13KaUCpHQYh5d3EAt0n1yBQ747Z4fiy7fU8Pbcz6aVWbqQHaH0Hnpz
 /+qFDHft2VzQ8niT5OYRQLUnY6uiwMEicJOIMj4c6RdJ6r9CMB/eSUZG1RVMC8FN+O
 D/BFnx7lPOGTvoi2mUal3Oee3wSJmuG1wgJofOmz4+bgRFQWOgwiQB0qmM+FkajkVe
 uW3Y5V4nLs+ttoj2B2atplzI8cw5Mu/yfoIfTPW5jq19gbK0yJykufEFSqAHZO3aZ9
 v2sBpYHMlAlSxHIVrcQGbntpD1cWhKdHpdzzuXSdhScUk6gFNkguyL+r6g/qHFi0Sd
 YMscriUMpa3HA==
Message-ID: <d60cf470-be2a-4ca5-b6d2-e01b548c03cb@kernel.org>
Date: Wed, 4 Mar 2026 18:16:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] numa: add 'memmap-type' option for memory type
 configuration
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>,
 qemu-devel@nongnu.org, imammedo@redhat.com, gourry@gourry.net,
 jonathan.cameron@huawei.com
Cc: apopple@nvidia.com, dan.j.williams@intel.com, Zhigang.Luo@amd.com,
 Lianjie.Shi@amd.com
References: <20260226105023.256568-1-FangSheng.Huang@amd.com>
 <20260226105023.256568-2-FangSheng.Huang@amd.com>
 <7facab80-c59f-4869-a68d-2e61acd15cb3@kernel.org>
 <f36e249f-820d-4033-81c3-2b172453d1aa@amd.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <f36e249f-820d-4033-81c3-2b172453d1aa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=david@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/2/26 10:01, Huang, FangSheng (Jerry) wrote:
> 
> 
> On 2/28/2026 4:34 AM, David Hildenbrand wrote:
>> On 2/26/26 11:50, fanhuang wrote:
>>> Add a 'memmap-type' option to NUMA node configuration that allows
>>> specifying the memory type for a NUMA node.
>>>
>>> Supported values:
>>>    - normal:   Regular system RAM (E820 type 1, default)
>>>    - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF)
>>>    - reserved: Reserved memory (E820 type 2)
>>>
>>> The 'spm' type indicates Specific Purpose Memory - a hint to the guest
>>> that this memory might be managed by device drivers based on guest
>>> policy.
>>> The 'reserved' type marks memory as not usable as RAM.
>>>
>>> Note: This option is only supported on x86 platforms.
>>>
>>> Usage:
>>>    -numa node,nodeid=1,memdev=m1,memmap-type=spm
>>>
>>> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
>>> ---
>>>   hw/core/numa.c               | 24 ++++++++++++
>>>   hw/i386/acpi-build.c         |  8 ++++
>>>   hw/i386/e820_memory_layout.c | 72 ++++++++++++++++++++++++++++++++++++
>>>   hw/i386/e820_memory_layout.h | 12 +++---
>>>   hw/i386/pc.c                 | 48 ++++++++++++++++++++++++
>>>   include/system/numa.h        |  7 ++++
>>>   qapi/machine.json            | 24 ++++++++++++
>>>   qemu-options.hx              | 14 ++++++-
>>>   8 files changed, 202 insertions(+), 7 deletions(-)
>>
>> I didn't take a look at the x86 implementation bits. The high-level
>> concept LGTM.
>>
>> In an ideal world, we'd only indicate the property if actually supported
>> by the machine. Not sure if that is easy to achieve with the "-numa"
>> option. So I guess this has to do :)
>>
> Hi David,
> 
> Thanks for the review and the LGTM on the high-level concept!
> 
> Regarding the per-machine property visibility — agreed, it would be
> cleaner. Currently we handle it with a runtime error when memmap-type
> is used on non-x86 machines, which seems like a reasonable compromise
> given the "-numa" option structure.
> 
> I was wondering if there's anything else you or the other maintainers
> would like me to address in the current v6?

Not from my side, so

Acked-by: David Hildenbrand <david@kernel.org>

on the core bits.

-- 
Cheers,

David


