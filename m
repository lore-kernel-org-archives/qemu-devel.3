Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E09FCA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 16:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoldT-0002zS-SR; Wed, 20 Aug 2025 12:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1uoldP-0002y2-27; Wed, 20 Aug 2025 12:25:59 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1uoldI-0006sc-6d; Wed, 20 Aug 2025 12:25:58 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDHzdUJ96VoZDyDBw--.336S2;
 Thu, 21 Aug 2025 00:25:45 +0800 (CST)
Received: from [192.168.31.34] (unknown [113.246.119.62])
 by mail (Coremail) with SMTP id AQAAfwDXXwcG96VoWlscAA--.12253S2;
 Thu, 21 Aug 2025 00:25:44 +0800 (CST)
Message-ID: <7b8acb9a-e3fe-461b-8495-42c7501a6a80@phytium.com.cn>
Date: Thu, 21 Aug 2025 00:25:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/11] hw/arm/smmuv3: Plumb security state through core
 functions
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Chen Baozi <chenbaozi@phytium.com.cn>,
 jean-philippe@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-7-tangtao1634@phytium.com.cn>
 <aKOa8KwAcm6hhAXq@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aKOa8KwAcm6hhAXq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXXwcG96VoWlscAA--.12253S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWikxY4F6QAGsh
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCFy8XFW8AFW3Ww1fXFy7Jrb_yoW5XFy3pF
 yvka4Fka1DGF48Jr92vr4kZFyxtrWrJ393Kr98Gry5J3W5C3WxKrWfK3yj9as3WrZ7u3WI
 yryjvaykJr1DZa7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 2025/8/19 05:28, Mostafa Saleh wrote:
> On Wed, Aug 06, 2025 at 11:11:29PM +0800, Tao Tang wrote:
>> To support parallel processing of secure and non-secure streams, the
>> SMMUv3 model needs to differentiate between the two contexts throughout
>> its core logic. This commit is the foundational step to make the code
>> security-state aware.
>>
>> An is_secure flag, which will be used in subsequent patches to represent
>> the transaction's security state, is now plumbed through the main
>> processing paths.
>>
>> This change is purely preparatory and introduces no functional changes
>> for the existing non-secure path. All current call sites are updated
>> to pass is_secure = false.
>>
>> This refactoring paves the way for upcoming patches that will introduce
>> separate TLB entries for secure transactions and enable a fully
>> parallel secure/non-secure SMMU model.
>>
> I think it’s easier to review if this patch was split (STE parsing,
> page table handling and translation, TLB invalidation)
> Also based on my comment on patch 2, stage-2 handling doesn’t seem correct to me.
>
> Thanks,
> Mostafa
>
Hi Mostafa,

Thank you your suggestion.

You've made a very good point. This patch is indeed too large and tries 
to cover too many different areas. For the v2 series, I will break this 
patch down into logical parts as you suggested (STE parsing, page table 
handling, etc.).

I also acknowledge your concern about the stage-2 handling logic from 
your comment on patch 2. I have sent a separate, detailed reply to your 
feedback on patch #2 that outlines my new understanding.

And as you commented on patch #01:

>> Inside this TCG VM, a KVM guest was launched, and the same NVMe device was
>> re-assigned to it via VFIO.
>> Command line of KVM VM inside TCG VM is below:
>>
>> sudo qemu-system-aarch64  \
>> -enable-kvm  -m 1024  -cpu host  -M virt \
>> -machine virt,gic-version=3 \
>> -cpu max -append "nokaslr" -smp 1 \
>> -monitor stdio \
>> -kernel 5.15.Image \
>> -initrd rootfs.cpio.gz \
>> -display vnc=:22,id=primary \
>> -device vfio-pci,host=00:01.0
>>
>> The KVM guest was able to perform I/O on the device
>> correctly, confirming that the non-secure path is not broken.
> I gave the patches a quick test and they seem to have broken my
> nested setup, I will look more into it and let you know what I find.
>
> Thanks,
> Mostafa
>
I'm sorry to hear that it has broken your environment. Please don't 
hesitate to share any details, logs, or reproduction steps when you find 
them. I am more than happy to help reproduce the issue on my end to get 
it fixed as quickly as possible.


I would be delighted to hear back from you on any of the topics we've 
discussed, as any further guidance you can offer would be invaluable.

Thanks,

Tao




