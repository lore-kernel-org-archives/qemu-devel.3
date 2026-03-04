Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ADDEF9001
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxoni-0005fO-6U; Wed, 04 Mar 2026 11:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vxone-0005eW-QQ; Wed, 04 Mar 2026 11:10:14 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vxona-0001Wn-Ma; Wed, 04 Mar 2026 11:10:14 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwC3jUVYWahpFt2sAA--.32110S2;
 Thu, 05 Mar 2026 00:10:00 +0800 (CST)
Received: from [192.168.31.94] (unknown [113.246.233.224])
 by mail (Coremail) with SMTP id AQAAfwDXLetXWahpPf0eAA--.38530S2;
 Thu, 05 Mar 2026 00:09:59 +0800 (CST)
Message-ID: <b5dc6957-b5c7-4b82-bbae-89be5e75512a@phytium.com.cn>
Date: Thu, 5 Mar 2026 00:09:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tao Tang <tangtao1634@phytium.com.cn>
Subject: Re: [RFC v4 09/31] hw/arm/smmuv3: Enforce Secure stage 2 capability
 check when decoding STE
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-10-tangtao1634@phytium.com.cn>
 <ad1f2339-0f48-4431-8334-5641c817d8c8@redhat.com>
In-Reply-To: <ad1f2339-0f48-4431-8334-5641c817d8c8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXLetXWahpPf0eAA--.38530S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWmnT6AGiwABst
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WFyrXF1fKw45tw1UKr13XFb_yoW8CFy5pF
 WUG3ZYkFWfJ3WxZr42vwn2yrZ7W3yFqFnrCr1Fk347ZF1Ykrn5tF12kF1YgFyrXryUX3yj
 va12gFWkXrs0vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Eric,

On 2026/3/3 AM12:48, Eric Auger wrote:
> On 2/21/26 11:02 AM, Tao Tang wrote:
>> When decoding a Stream Table Entry (STE) from the Secure stream table
>> that enables stage-2 translation, verify that the SMMU implementation
>> advertises Secure stage-2 support via S_IDR1.SEL2. If stage-2 is
>> requested but S_IDR1.SEL2 is 0, mark the STE as ILLEGAL.
>>
>> This implements the requirement from the Arm SMMUv3 architecture
>> specification (IHI 0070G.b, Section 5.2, Page 218) that a Secure STE
>> with stage-2 enabled is only valid when the implementation supports
>> Secure stage-2 translation.
>>
>> Signed-off-by: Tao Tang<tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 2192bec2368..d011357253e 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -623,6 +623,16 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
> I think I would rather pass the sec_sid as a parameter, indicating which
> secure stream table shall be used for ste decoding
>>           if (ret) {
>>               goto bad_ste;
>>           }
>> +
>> +        /*
>> +         * Stage 2 is implemented but Secure stage 2 is not supported while
>> +         * STE is from Secure stream table. STE is ILLEGAL in this case
>> +         * according to (IHI 0070G.b) 5.2 STE, Stream Table Entry, Page 218.
> would reuse the spec full terminology:
> I would explicitly tell explicitly: " it is ILLEGAL to set STE.Config ==
> 0b11x."
>> +         */
>> +        if ((cfg->sec_sid == SMMU_SEC_SID_S) &&
>> +            !(FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SEL2))) {
>> +            goto bad_ste;
>> +        }
>>       }
>>   
>>       /* Multiple context descriptors require SubstreamID support */
> Otherwise looks good


Thanks for your review.


I’ll rework decode_ste() to take sec_sid as a parameter, and explicitly 
state the illegal encoding.


Best regards,

Tao


