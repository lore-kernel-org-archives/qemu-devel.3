Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2B0F33A76
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9li-0001Ya-93; Thu, 05 Mar 2026 09:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vy9lY-0001PP-4w; Thu, 05 Mar 2026 09:33:32 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vy9lS-00036a-Ro; Thu, 05 Mar 2026 09:33:27 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDXLNAolKlphZywAA--.34728S2;
 Thu, 05 Mar 2026 22:33:12 +0800 (CST)
Received: from [192.168.31.155] (unknown [113.246.233.224])
 by mail (Coremail) with SMTP id AQAAfwBnvusnlKlpIkAfAA--.39270S2;
 Thu, 05 Mar 2026 22:33:11 +0800 (CST)
Message-ID: <0a365563-17b5-4444-9085-991cc1f39d74@phytium.com.cn>
Date: Thu, 5 Mar 2026 22:33:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 13/31] hw/arm/smmu-common: Add sec_sid field to TLB
 entries
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101640.2993566-1-tangtao1634@phytium.com.cn>
 <3dd493e0-4788-4b91-9c2c-565938561bc3@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <3dd493e0-4788-4b91-9c2c-565938561bc3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBnvusnlKlpIkAfAA--.39270S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAFBWmooSAF7AACsq
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ww47tw1kXw1xJF4xJrWfAFb_yoW8Zw48pa
 18Jr15KrZ3Ga4Ikr1xJr4UZa4DZwsYgw45KryUGas5Ar15Kr40qF1j9a4Y9F98Wrs5XF4j
 vFyjqrZ8ZF4DZr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
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

On 2026/3/3 01:34, Eric Auger wrote:
>
> On 2/21/26 11:16 AM, Tao Tang wrote:
>> This is a non-functional preparation step that adds storage for
>> resolved security state in SMMUTLBEntry.
> Add the "why"in the commit description.
>> Together with the earlier commits that added NSCFG handling and
>> PTE NS/NSTable helpers, the plumbing is complete and we can now
>> refactor the PTW flow to handle Secure state.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   include/hw/arm/smmu-common.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index bd88e599c77..b0a02e12fe6 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -91,6 +91,7 @@ typedef struct SMMUTLBEntry {
>>       uint8_t level;
>>       uint8_t granule;
>>       IOMMUAccessFlags parent_perm;
>> +    SMMUSecSID sec_sid;
>>   } SMMUTLBEntry;
> what does it need to be part of the actual entry and not only of the key?


sec_sid does not need to live in SMMUTLBEntry. After rechecking the 
code, SMMUTLBEntry.sec_sid is only consumed in:

smmu_ptw_64_s1

         if (current_ns) {
             tlbe->sec_sid = SMMU_SEC_SID_NS;
         } else {
             tlbe->sec_sid = PTE_NS(pte) ? SMMU_SEC_SID_NS : SMMU_SEC_SID_S;
         }
         tlbe->entry.target_as = (tlbe->sec_sid == SMMU_SEC_SID_S)
                                 ? &bs->secure_memory_as : &bs->memory_as;
         tlbe->entry.translated_addr = gpa;



and smmu_ptw_64_s2:

         tlbe->sec_sid = SMMU_SEC_SID_NS;
         tlbe->entry.target_as = cfg->ns_as;
         tlbe->entry.translated_addr = gpa;


to get the target_as. So keeping it in the cached entry is unnecessary 
if we use a local sec_sid instead.



I’ll drop this field and keep the security-state handling local to the 
walk instead. If we later need it for TLB disambiguation, it belongs in 
the lookup key rather than the entry payload.


Thanks for the catch.

Tao



