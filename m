Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FF5F3095D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 13:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy8fb-00007x-Cq; Thu, 05 Mar 2026 08:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vy8fW-00007Y-0J; Thu, 05 Mar 2026 08:23:10 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vy8fR-0001C9-P1; Thu, 05 Mar 2026 08:23:09 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDXrEStg6lpwG6wAA--.2998S2;
 Thu, 05 Mar 2026 21:22:53 +0800 (CST)
Received: from [192.168.31.155] (unknown [113.246.233.224])
 by mail (Coremail) with SMTP id AQAAfwD3Tuysg6lpnz0fAA--.53199S2;
 Thu, 05 Mar 2026 21:22:52 +0800 (CST)
Message-ID: <e42c6868-552b-4eb9-ba76-4e9d69525565@phytium.com.cn>
Date: Thu, 5 Mar 2026 21:22:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 11/31] hw/arm/smmu: Add PTE NS/NSTable helpers
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101544.2992355-1-tangtao1634@phytium.com.cn>
 <67ce2d21-0b7e-4f21-aa3a-d4a7dc52a059@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <67ce2d21-0b7e-4f21-aa3a-d4a7dc52a059@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3Tuysg6lpnz0fAA--.53199S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAFBWmooSAF7AAAso
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJrWUKFy7uryktF43ur4kWFg_yoW8Ar13p3
 4DKa98KFW8Ja17Gan7twnavFnYqws5tF1UGFy7W3s8uws0vw1fWr129r15Ka4q9rn5Jwnr
 ZF1qv34furWY9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Eric,

On 2026/3/3 01:07, Eric Auger wrote:
>
> On 2/21/26 11:15 AM, Tao Tang wrote:
>> Add helper macros for NS and NSTable bits and group PTE attribute
>> accessors for clarity. No functional change beyond the new helpers.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-internal.h | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
>> index d143d296f34..a0454f720da 100644
>> --- a/hw/arm/smmu-internal.h
>> +++ b/hw/arm/smmu-internal.h
>> @@ -58,16 +58,28 @@
>>       ((level == 3) &&                                                    \
>>        ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_L3_PTE_TYPE_PAGE))
>>   
>> +/* Block & page descriptor attributes */
> Maybe use the spec terminology:
> Stage 1 attribute fields in VMSAv8-64 Block and Page descriptors
> vs 7 Stage 1 VMSAv8-64 Table descriptor fields
>
> By the way AF belongs to both



I’ll rework the comments to use the spec terminology and avoid grouping 
AF too narrowly under Block/Page wording.


Best regards,

Tao

>
>> +/* Non-secure bit */
>> +#define PTE_NS(pte) \
>> +    (extract64(pte, 5, 1))
>> +
>>   /* access permissions */
>>   
>>   #define PTE_AP(pte) \
>>       (extract64(pte, 6, 2))
>>   
>> +/* access flag */
>> +#define PTE_AF(pte) \
>> +    (extract64(pte, 10, 1))
>> +
>> +
>> +/* Table descriptor attributes */
>>   #define PTE_APTABLE(pte) \
>>       (extract64(pte, 61, 2))
>>   
>> -#define PTE_AF(pte) \
>> -    (extract64(pte, 10, 1))
>> +#define PTE_NSTABLE(pte) \
>> +    (extract64(pte, 63, 1))
>> +
>>   /*
>>    * TODO: At the moment all transactions are considered as privileged (EL1)
>>    * as IOMMU translation callback does not pass user/priv attributes.
> Eric


