Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1DACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RA9-0007Pi-3p; Mon, 29 Sep 2025 23:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3RA3-0007PU-Dn; Mon, 29 Sep 2025 23:36:19 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3R9t-0005NP-6m; Mon, 29 Sep 2025 23:36:19 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAH6CQXUNtoNIwBAA--.2512S2;
 Tue, 30 Sep 2025 11:35:51 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCX+ucVUNto05gyAA--.33171S2;
 Tue, 30 Sep 2025 11:35:50 +0800 (CST)
Message-ID: <cd36296e-7ef2-4fee-8205-f82e50014927@phytium.com.cn>
Date: Tue, 30 Sep 2025 11:35:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] hw/arm/smmuv3: Optional Secure bank migration
 via subsections
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250926033013.1099304-1-tangtao1634@phytium.com.cn>
 <00a61c3b-c233-4d40-938b-6d06342e22cf@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <00a61c3b-c233-4d40-938b-6d06342e22cf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwCX+ucVUNto05gyAA--.33171S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWjZjscNtAAFsI
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFyxJF4UAr17CFy5JF4DXFb_yoWrJF17pr
 s5Ga15KF4kGF17Jr1av3W8uF1Yq3yrtF43trsrGFWFyan0yFyIqr1qyF4FgFn5ur40ya1a
 vF1I9an7ur4jyrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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

Hi Eric,

On 2025/9/29 23:47, Eric Auger wrote:
> Hi Tao,
>
> On 9/26/25 5:30 AM, Tao Tang wrote:
>> My apologies, resending patches 13-14/14 to fix a threading mistake from
>> my previous attempt.
>>
>> Introduce a generic vmstate_smmuv3_bank that serializes a single SMMUv3
>> bank (registers and queues). Add a 'smmuv3/bank_s' subsection guarded by
>> secure_impl and a new 'migrate-secure-bank' property; when enabled, the S
>> bank is migrated. Add a 'smmuv3/gbpa_secure' subsection which is only sent
>> when GBPA differs from its reset value.
>>
>> This keeps the existing migration stream unchanged by default and remains
>> backward compatible: older QEMUs can ignore unknown subsections, and with
>> 'migrate-secure-bank' defaulting to off, the stream is identical to before.
>>
>> This also prepares for future RME extensions (Realm/Root) by reusing the
>> bank subsection pattern.
>>
>> Usage:
>>    -global arm-smmuv3,secure-impl=on,migrate-secure-bank=on
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c         | 70 +++++++++++++++++++++++++++++++++++++++++
>>   include/hw/arm/smmuv3.h |  1 +
>>   2 files changed, 71 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 80fbc25cf5..2a1e80d179 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -2450,6 +2450,53 @@ static const VMStateDescription vmstate_smmuv3_queue = {
>>       },
>>   };
>>
>> +static const VMStateDescription vmstate_smmuv3_bank = {
> I would name this vmstate_smmuv3_secure_bank


Thank you for the excellent feedback on the migration implementation. 
Your points are spot on.


My original thought for using the generic vmstate_smmuv3_bank was to 
potentially reuse it for future Realm state migration. However, I agree 
with you that naming it vmstate_smmuv3_secure_bank for now is a better 
choice for clarity and precision. I will make that change.


>> +
>> +static bool smmuv3_secure_bank_needed(void *opaque)
>> +{
>> +    SMMUv3State *s = opaque;
>> +
>> +    return s->secure_impl && s->migrate_secure_bank;
> why is it needed to check s->migrate_secure_bank?
>>
>> +static bool smmuv3_gbpa_secure_needed(void *opaque)
>> +{
>> +    SMMUv3State *s = opaque;
>> +
>> +    return s->secure_impl && s->migrate_secure_bank &&
> same
>> @@ -2521,6 +2589,8 @@ static const Property smmuv3_properties[] = {
>>        * Defaults to false (0)
>>        */
>>       DEFINE_PROP_BOOL("secure-impl", SMMUv3State, secure_impl, false),
>> +    DEFINE_PROP_BOOL("migrate-secure-bank", SMMUv3State,
>> +                     migrate_secure_bank, false),
> I don't get why you need another migrate_secure_bank prop. You need to
> migrate the subsection if secure_impl is implemented, don't you?


You are absolutely right. My intention with the migrate_secure_bank 
property was likely to maintain as much flexibility as possible.

However, I completely agree with your logic now. Forcing the migration 
of the secure state whenever secure-impl is enabled is the only correct 
approach to prevent inconsistent states and ensure robustness. I will 
remove the migrate_secure_bank property and tie the migration directly 
to secure-impl.

Thanks for helping me correct this design flaw.

Best,
Tao


>>   };
>>
>>   static void smmuv3_instance_init(Object *obj)
>> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
>> index 572f15251e..5ffb609fa2 100644
>> --- a/include/hw/arm/smmuv3.h
>> +++ b/include/hw/arm/smmuv3.h
>> @@ -71,6 +71,7 @@ struct SMMUv3State {
>>       QemuMutex mutex;
>>       char *stage;
>>       bool secure_impl;
>> +    bool migrate_secure_bank;
>>   };
>>
>>   typedef enum {
>> --
>> 2.34.1
>>
> Eric


