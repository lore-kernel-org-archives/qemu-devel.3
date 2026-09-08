Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625D7C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xTI-0001an-S0; Tue, 08 Sep 2026 11:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x3xTF-0001aY-48; Tue, 08 Sep 2026 11:10:50 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x3xTB-0008Ed-U0; Tue, 08 Sep 2026 11:10:48 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAHhmppJaBq1ZUGAA--.9261S2;
 Tue, 08 Sep 2026 23:10:33 +0800 (CST)
Received: from [192.168.2.9] (unknown [113.246.117.164])
 by mail (Coremail) with SMTP id AQAAf8DwFnRmJaBqy1rRAA--.30216S2;
 Tue, 08 Sep 2026 23:10:31 +0800 (CST)
Message-ID: <e4a140ff-fc28-4bb5-bb9a-f1ae2c07a1b0@phytium.com.cn>
Date: Tue, 8 Sep 2026 23:10:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 12/28] hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
To: Mostafa Saleh <smostafa@google.com>, Eric Auger <eric.auger@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-2-tangtao1634@phytium.com.cn>
 <apbdLhuQ7T0I9lMS@google.com>
 <2f430034-626e-40a1-89fb-266ce037bb1f@redhat.com>
 <ap7ZtWhyHgymBTNY@google.com>
 <3f6a482b-105c-4462-8fa2-df225285ce35@redhat.com>
 <ap_FE62YqJDBt11g@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <ap_FE62YqJDBt11g@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwFnRmJaBqy1rRAA--.30216S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAMBWqfEMkHogABsA
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tF4ktw1DuF4xZrWrWr4xtFb_yoW8Kr15pF
 WjkFWjkFs8XF1rJryvkr18WF18Krs7t3s8Ww4DJryUW3Z0gr1Sgr4xXw43WFyUZrs3JF4j
 vryqvasrXrWrZ37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 9/8/2026 4:19 PM, Mostafa Saleh wrote:
> On Mon, Sep 07, 2026 at 06:03:25PM +0200, Eric Auger wrote:
>>
>> On 9/7/26 5:35 PM, Mostafa Saleh wrote:
>>> On Mon, Sep 07, 2026 at 04:49:58PM +0200, Eric Auger wrote:
>>>> On 9/1/26 4:11 PM, Mostafa Saleh wrote:
>>>>> On Fri, Aug 14, 2026 at 12:25:09AM +0800, Tao Tang wrote:
>>>>>> To prevent aliasing between translations controlled through the Secure and
>>>>>> Non-secure programming interfaces, the IOTLB lookup key must incorporate
>>>>>> SEC_SID.
>>>>>>
>>>>>> This commit:
>>>>>> - expands SMMUIOTLBKey with SEC_SID field for cache key differentiation
>>>>> I still feel that it's better to have a separate IOTLB for the secure
>>>>> world, as it should never mix with the non-secure one; as I commented
>>>>> on the last version:
>>>>> https://lore.kernel.org/qemu-devel/aaGuGuevX8HFqx0x@google.com/
>>>>>
>>>>> Then all the functions can be re-used and it is just a matter
>>>>> of passing the right instance.
>>>>>
>>>>> No strong opinion though, this approach should work also, so it is up
>>>>> to Eric.
>>>> I don't have a strong opinion either. I am just curious about what the
>>>> implementation will become once we add further support for StreamWorld.
>>>> Will we be able to keep separate IOTLBs or will it make more sense to
>>>> have a unified IOTLB?
>>> Is that about the possiblity of mixing TLB entries accross different
>>> StreamWorlds, as I don't see immediately if that is possible.
>>>
>>> Or is it about growing number of IOTLB instances as we support
>>> StreamWorlds? I am not really sure about that as there are many
>>> possibilities (NS-EL1, NS-EL2, NS-EL2-E2H, Same for S, and realm)
>>>
>>> I'd imagine we have 3 instances NS, S and Realm but each one would
>>> need a STRW anyway, so maybe having a big one is not that bad.
>> Yes that was the question. Do we plan to have a multiplication of IOTLBs
>> for each streamworld value in which case it may become messy?
>>
>> Anyway we can rework later. So I would say pick up your prefered solution.
> Let's keep it as it is now then (shared IOTLB). After more thinking I
> believe that would scale better.

Hi Eric, Mostafa,

Thanks for the feedback. I'll keep the shared IOTLB for this series. We 
can revisit the table layout and eviction policy later if needed.

Thanks,
Tao


