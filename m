Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E670D4A619
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggUS-0006jT-7n; Fri, 16 Jan 2026 04:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vggUO-0006ie-CA; Fri, 16 Jan 2026 04:51:32 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vggUM-0008VA-BE; Fri, 16 Jan 2026 04:51:32 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3PJgYCmpphiHgBQ--.2460S2;
 Fri, 16 Jan 2026 17:51:20 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAXbusWCmppGyEUAA--.20987S2;
 Fri, 16 Jan 2026 17:51:19 +0800 (CST)
Message-ID: <2255d30c-cc58-4a45-974c-f7fd89694c26@phytium.com.cn>
Date: Fri, 16 Jan 2026 17:51:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 2/7] hw/arm/smmuv3-common: Define STE/CD fields via
 registerfields
To: eric.auger@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-3-tangtao1634@phytium.com.cn>
 <9f780549-8d03-4761-a2c0-32e85d245a0d@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <9f780549-8d03-4761-a2c0-32e85d245a0d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAXbusWCmppGyEUAA--.20987S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQARBWlpSgQE7AAAsz
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7CrWkGF13Zw15tFyDJF15XFb_yoW8uF4Dp3
 WxtF1fCaykt3WI9w1xJr43uF1ft3ykCr4Ivry7trWIqr1Yvr92yrW7tF1Yqr18Xryqqr45
 uFs29a93Wr1Ut3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Eric,

On 2026/1/15 17:14, Eric Auger wrote:
> Hi Tao,
>
> On 12/24/25 4:46 AM, Tao Tang wrote:
>> Switch STE/CD bitfield definitions and accessors to the
>> 'hw/registerfields.h' REG/FIELD API.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   include/hw/arm/smmuv3-common.h | 169 +++++++++++++++++++++++----------
>>   1 file changed, 120 insertions(+), 49 deletions(-)
>>
>> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
>> index 9da817f41a..b6da2fd62c 100644
>> --- a/include/hw/arm/smmuv3-common.h
>> +++ b/include/hw/arm/smmuv3-common.h
>> @@ -11,6 +11,8 @@
>>   #ifndef HW_ARM_SMMUV3_COMMON_H
>>   #define HW_ARM_SMMUV3_COMMON_H
>>   
>> +#include "hw/registerfields.h"
>> +
>>   /* Configuration Data */
>>   
>>   /* STE Level 1 Descriptor */
>> @@ -35,63 +37,132 @@ typedef struct CD {
>>   
>>   /* STE fields */
>>   
>> -#define STE_VALID(x)   extract32((x)->word[0], 0, 1)
>> +REG32(STE_0, 0)
>> +    FIELD(STE_0, VALID, 0, 1)
>> +    FIELD(STE_0, CONFIG, 1, 3)
>> +    FIELD(STE_0, S1FMT, 4, 2)
>> +    FIELD(STE_0, CTXPTR_LO, 6, 26)
>> +REG32(STE_1, 4)
>> +    FIELD(STE_1, CTXPTR_HI, 0, 16)
> not related to your patch, but shouldn't it be 24 instead of 16
>>
>> +REG32(STE_6, 24)
>> +    FIELD(STE_6, S2TTB_LO, 4, 28)
>> +REG32(STE_7, 28)
>> +    FIELD(STE_7, S2TTB_HI, 0, 16)
> same here?
>>
>> +REG32(CD_2, 8)
>> +    FIELD(CD_2, HAD0, 1, 1)
>> +    FIELD(CD_2, TTB0_LO, 4, 28)
>> +REG32(CD_3, 12)
>> +    FIELD(CD_3, TTB0_HI, 0, 19)
> I think it is 24 now
>> +REG32(CD_4, 16)
>> +    FIELD(CD_4, HAD1, 1, 1)
>> +    FIELD(CD_4, TTB1_LO, 4, 28)
>> +REG32(CD_5, 20)
>> +    FIELD(CD_5, TTB1_HI, 0, 19)
> same

Thank you for your review and the careful observation — you are 
absolutely correct.


These field width definitions originally came from the existing 
implementation when I moved them into the new REG/FIELD API, so I did 
not update the widths at that time.


Would you prefer that I submit a separate patch to correct the field 
widths after this series patch are merged?


Best regards,

Tao

> Otherwise looks good to me
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> Eric


