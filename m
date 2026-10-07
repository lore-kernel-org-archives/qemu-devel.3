Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7FECA6004
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xES9F-0000YL-4E; Wed, 07 Oct 2026 09:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xES6L-0007zq-Hv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:54:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xES6I-0004iS-FQ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:54:32 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BVEGY609967
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 13:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tui9mTR8NgPOLvD11h9XTRIV1yLOkV7DqpwpfF8ODiE=; b=ckK9hYqIp4hkN81S
 BhyW+tkd6erHrwBHiG3gq86822uYfQrLRJs+rSLU4iCgLwMm/RVOBkQssxHXYQg4
 5sIva76avqB2cwPWoX7Y4NbrjUGCPDVGV0Kc6yfep/Y2zLYKQDeELmTJ2yhkY1xA
 YewQC5HVyVt+v4KaqTdn7ZToya9dC0/YNpWQSaUTicBCHhEgcuRugktSLFSUOpuJ
 JydciyRQkq6ACj021czxpOi8vIwknXujt9JkLuESiytaQMLALiOLG6DBQbh+bjJi
 XsyWhzfX4iWSTjwt3KvXM6ZhaJDfbNFIdEi2Oj6IWFCS5NqF/afKRNEoxIvHzG5G
 CDqkpw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc59scq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 13:54:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so797448285a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791381265; x=1791986065; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tui9mTR8NgPOLvD11h9XTRIV1yLOkV7DqpwpfF8ODiE=;
 b=JD49+u/t6tyaxrk9EPg2pswB0rUtWCc8WRXWj3AJ0Zn/3kIeUw2lqfrfmAwdEgn/QC
 HiudT/5L6HleEz5Sk9wLsuxii5Bg40F/bDMPZSx6Dfk2qdOtvmd+/Iu9WOjqHvQFLvee
 JqdbDdEdzqyORiGYE/qWKbMIA1sUjK9S17kw01+r04o2Mi2652K6UBcLabxiknGZH3HB
 Fl0BZ1O2wFrpXrsQIgBgAFALQ/2uXMbAEggmaJHhzCChNAntNFZ2jKDmnB5aDgCaK1LY
 4OuXqo3feRkFqAre2iSjpisJZQe9hohKp3zLOvtwacNsBolHyX7a6SKj0gfCBAWaxWPL
 LTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791381265; x=1791986065;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tui9mTR8NgPOLvD11h9XTRIV1yLOkV7DqpwpfF8ODiE=;
 b=utxkujXVTG2pPJkoKU08g4vXDkFxuqyvJwR3V56CcXDcPEAfl+L+7g6seOSt2B6C/4
 //jW+gJiAP0nbD2N9vTchRK7fRiCil6cotTooKQtpYghNrAbOYDnT/DwMR0bNA1kgnPh
 xWu4yMVfe5VdQx/WeNIViIm1Ucdc3azvKDBs7ICcWD0N/E7PNEX1DB+JODQhwclfxAOJ
 fqLrQWocuT+si0KfO3i+NXpbt0lbAHlzk4OGiIb8loWBDOiitG16qoI3i1KOJJgPngni
 Bxa/Dc6DyMc2SX8s0wRP/jnI+7DmbSpPdbCNWHmIJsr5rNr8N8cgLrHbXWCz3lCdNhrT
 Mrmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxoo3L2yT1dZRPD9i9O7r9S6OCx2Q8/beIEsXVNIS8KFS3s+c0iOY9pGHNX1UxapvIL+8RUxch6uNY@nongnu.org
X-Gm-Message-State: AFuF++nGC63ixGDu05teryIlz9xr4yJUY213bfvZ3/dsEakqr3fsy0gf
 Ko/TZ2ArmIkC0lFSKC8mUF6std6NrCVCjUtum3VYt/7CFRrHtCNgBTuUCF0TL8bymnwNpg98+aw
 Zo31aqmyV35RYb6u5JfhYP2X6qJVZG52JMGYMjK4az2oivkq6TUsvSxNC1Q==
X-Gm-Gg: AYBFou0dwF/+mhvIMW/pXe98d4TpP8BhOhv3lB1KxhlepjMMp7c794ll/fkiwZPl57O
 DYSG0YaoD9vSzRtp7MSDNZqPxEvzPEoOLljrvoop7z+kyJ6mfjgdp5ULR+eX4+qz4oZc4XjTFMq
 n9L3aKuUkzb/lfzFBGfiLat++ShXfaV0lkFf+Ewfuscr8mjTG4TuudDKoSiqPZ9YV1IWZ8GDkl8
 QkfJkbhreyk5pNL7uJwyeTgyDcI7R1mR8tA3V12J9uFRidmt9yqDozd2qpcWma7plf3Yuz6lJoz
 MXBBBDfiS5+YCQxZKQ4N782kbx2sC7D+HqEOglHdo+rLgTdtHfbODLJ60QT4mqRUHldrxEfhNuA
 KVwC4myWnhGKybPMM6yD9knasxHm72zk0Fg==
X-Received: by 2002:a05:620a:618e:b0:93e:9808:8d73 with SMTP id
 af79cd13be357-93e9b87f19bmr419572685a.77.1791381265440; 
 Wed, 07 Oct 2026 06:54:25 -0700 (PDT)
X-Received: by 2002:a05:620a:618e:b0:93e:9808:8d73 with SMTP id
 af79cd13be357-93e9b87f19bmr419567285a.77.1791381264807; 
 Wed, 07 Oct 2026 06:54:24 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1787e7792sm145694405e9.0.2026.10.07.06.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 06:54:24 -0700 (PDT)
Message-ID: <2874719a-ca6d-473f-a29f-e40f56016fc9@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 15:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] target/riscv: Compile pmp.c once
Content-Language: en-US
To: luoyonggang@gmail.com
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-14-8a2f0f296a7f@rev.ng>
 <17cb7c7c-5f22-4a03-8855-4d1ec91d347a@oss.qualcomm.com>
 <CAE2XoE9eXXKQGZZ0kvmex88+tjch1-+H_-MgB6JEu+4bdPZq8g@mail.gmail.com>
 <9bf8945c-6472-462e-a275-f0b74912d3ed@oss.qualcomm.com>
 <CAE2XoE9QzGda8J9QCQysRL8OoxBrR86Ft426Rf4TXJxnPm+Vsg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAE2XoE9QzGda8J9QCQysRL8OoxBrR86Ft426Rf4TXJxnPm+Vsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NSBTYWx0ZWRfXxKXhf7Y0lcH0
 tPyvb1JO+qbnjm2qgySJZzTux/WywPzhHaEeNYzKSVyl9HCu4GIBx4XRlSFPON/uqXWBpDbhgZf
 pXjDHjz5BJ3S95pkLcIHyuEhpjxhnFw=
X-Proofpoint-GUID: LWC9iN-7V129lQ0tuviqUSNSgLgdTw0n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NSBTYWx0ZWRfXyZPRI9FOXVFF
 BKoZigEanB3yScjdSi/Rwlb8127JYyCHsUP4lBJPWhHpZxr6DK2dKBD2EVZFHWJN+71N6+YWsWj
 0eWv54KR714JyhTnQ3PpOK/UwiNOWqRjT4IiKvdU8/XPg8/nb4OGYosSMZuL4JoAAN0tajUS/hG
 xiW3bFny56fSQw4bYqBbv6Q1S/p1XHeEt69xNK1KGyt5brLyZVD08YZtWTDcpK5ib2W2ezQyK3n
 5qc6IvMbAaRDQhJ4mNxDc85bbxvJvv5CkxmeggBVukHmA2Borp0YsZt0zl1ztP/T8WcUuW7nA6H
 Yw9VvQJsV4+FjrMWkxaRHROjVYS/rXeX1rpwcYHcZtnpNCU9r8CgHEvYFVjQsKtgeSIf/iL0RMk
 +c2hmT683y/vJ4x9OUwAnOoz6GpgBAyced5X2yvFmMB53UYfwOhWafumR2/KzHwov7VzJfvQF5B
 Um+FLqp5nF3jGPVpM3Q==
X-Proofpoint-ORIG-GUID: LWC9iN-7V129lQ0tuviqUSNSgLgdTw0n
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac64f12 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=LnnBb7FsOvHOz9LIuJkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070055
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Phil.

Regards,

I missed it, but again Anton's comment were in this patch
description I wouldn't had barked.

How does this will work in heterogeneous binary with one
RV32 and another RV64 cores running together?

[we tend to avoid top-posting on technical lists]

On 7/10/26 15:39, Yonggang Luo wrote:
> It's here https://lore.kernel.org/qemu-devel/ar9WZip2Q2G0qvQI@hive.localdomain/
> 
> From: Anton Johansson via qemu development <qemu-devel@nongnu.org>
> 
> 
> I wouldn't be surprised if that's the case, although I'm personally a
> bit scared of riscv_cpu_mxl_bits() since it returns 128 for MXL_128, so
> if it's not used carefully or on clear MXL_[32|64] paths you could easily
> get UB.
> 
> 
> On Wed, Oct 7, 2026 at 9:26 PM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 7/10/26 13:51, Yonggang Luo wrote:
>>> On Wed, Oct 7, 2026 at 6:25 PM Philippe Mathieu-Daudé
>>> <philmd@oss.qualcomm.com> wrote:
>>>>
>>>> On 7/10/26 10:43, Anton Johansson wrote:
>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>>>> ---
>>>>>     target/riscv/tcg/pmp.c       | 5 +++--
>>>>>     target/riscv/tcg/meson.build | 2 +-
>>>>>     2 files changed, 4 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
>>>>> index 99345d63dc..2d7194de10 100644
>>>>> --- a/target/riscv/tcg/pmp.c
>>>>> +++ b/target/riscv/tcg/pmp.c
>>>>> @@ -638,19 +638,20 @@ uint64_t pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>>>>>         if (addr_index < pmp_regions) {
>>>>>             val = env->pmp_state.pmp[addr_index].addr_reg;
>>>>>             int g = pmp_get_granularity_g(env);
>>>>> +        const unsigned long_bits = target_long_bits();
>>>>
>>>> We need to fetch this information from @env. Maybe riscv_cpu_mxl_bits()?
>>>
>>> discussed before, there is possible be 128bits
>>
>> Please point me to the discussion (directly, saving us a ping / pong),
>> as:
>>
>>     '''
>>     This was already discussed on v42:
>>
>>     https://lore.kernel.org/qemu-devel/some-message-id-v42-20128438/
>>     '''
>>
>> Having the discussion decision resumed in the patch description will
>> prevent further reviewers to ask again the same.
>>
>> What do you mean by "possible be 128bits"? If we want to cap the
>> value we can use MIN(64, riscv_cpu_mxl_bits(env)).
>>
>>>
>>>>>             switch (pmp_get_a_field(env->pmp_state.pmp[addr_index].cfg_reg)) {
>>>>>             case PMP_AMATCH_OFF:
>>>>>                 /* fallthrough */
>>>>>             case PMP_AMATCH_TOR:
>>>>>                 /* Bit [g-1:0] read all zero */
>>>>> -            if (g >= 1 && g < TARGET_LONG_BITS) {
>>>>> +            if (g >= 1 && g < long_bits) {
>>>>>                     uint64_t granule = 1ULL << g;
>>>>>                     val = ROUND_DOWN(val, granule);
>>>>>                 }
>>>>>                 break;
>>>>>             case PMP_AMATCH_NAPOT:
>>>>>                 /* Bit [g-2:0] read all one */
>>>>> -            if (g >= 2 && g < TARGET_LONG_BITS) {
>>>>> +            if (g >= 2 && g < long_bits) {
>>>>>                     val = deposit64(val, 0, g - 1, -1ULL);
>>>>>                 }
>>>>>                 break;
>>>>
>>>
>>>
>>
> 
> 


