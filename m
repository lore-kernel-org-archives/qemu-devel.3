Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733B5CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHaoO-0005BG-HX; Fri, 16 Oct 2026 01:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHaoM-0005B7-3P
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:48:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHaoK-0002c5-3g
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:48:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G2dq9U406122
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TQts5uDVXY/oS37ZP/XdYPtaEMzhGiUQWQZNv3mea/M=; b=CWFEqJEnLJsIEMWH
 t3Y3B7ln6+MVCyPsyhHoSDp99Sx5rSFbW6f+eEPqPcg6i4kzN0oSM0KiaXyXItk7
 zG0Yd8oDrNfhZzeGN/a1z909dTnPPBefI2MtqJPrU5unMz/criNatLMGz3yZRglC
 acZXQoTUm7LdG3nB+S2J9bMm/dbO4fnlEFy+fs0rVasR35Pd8tXwWJXHHLvGBeh3
 HdSC6HE/9bTZBYGYHub9k1Gp5Qbpezog1eF9SwjBRlysWdEbloaopiL1YJdmJhag
 ZIr8EOWZ1TJ+z3HrxXfRDysf6VE14a3B/eu4YPPtxRcLMJzQ3vSVmzwEP0V4yTTc
 fqOJ7Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa279h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:48:54 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91430af782dso135405036d6.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 22:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792129734; x=1792734534; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TQts5uDVXY/oS37ZP/XdYPtaEMzhGiUQWQZNv3mea/M=;
 b=aMBQREtP/orj7fibnbeMHbvX517kDDLmRUOVkCXNtTZWymn7Hj6TuvglLitdd02Pxs
 iMLO1RsG0cP1TEXEw609oAL0heB4o3InTHiKn3Qy0FBLLelaBbwLXt5uY9m2gj8oIGr2
 ApmTUBvkTPt8eX3BsaeJowrqHADKFVNdaIuxDIQ9P74SJW6oAwbfg9DsA+DjQWMR44EU
 x4GipOPHF4r6FyCPoJZ6ekrLl86IE+Eb08g1idL1rgA70wPfRkae6gMP/Mtvg640LmO9
 wmw023u6LpRXkOKKt/PT9u32eQoeHN0ZIUYJ2Ii8Fgtta91Im/A1+KQYrEQVHFKTp5z0
 I81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792129734; x=1792734534;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TQts5uDVXY/oS37ZP/XdYPtaEMzhGiUQWQZNv3mea/M=;
 b=rFzJOf2IWkXxhvQG/jMJwZWdtMBplPaMkFxIhuBVU9h+XXXhkA5A1ccdlAjrFPxJ9B
 ObEFRAqZXwHu4UMFaSFS+sDzZ1hwkVTRCgSmcblxex5EuKJQ4SgTZzquUoDQmtaIA1Fx
 FoP3UhHly93yaqMCKoSRuhnJ+wo3ObVTu7Q2q2NqkEpZnLRNtT2go/w5B8e9Kqo/8J1g
 GM0bxJiu8e9DrwxqmnxGz82YVwcVAG4uEZ/LNvuvFiBSorbpSYdTV/20HCqVW6a6+3pr
 HJbbLzs55PKrdm9bK7IrBxVFAa3gQ9jNYZE8jE/6UAEr18ypZhzVM0Q9bI4NnbLZ0tB8
 VoYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF8K3KTman/3KuhA3hqauMMwW8nVKD4iWw4MiRanP6d1ItNihbvtUdlp/Cd96n8AqU/6QRrctnsFwa@nongnu.org
X-Gm-Message-State: AFq9FYKmCE7HHLcREH0Y8dDg8/MltEtbYkHAn/eF+6uB6K5jlMICiP62
 uGnBv0t9P6FlIoSJektzr4mNbtyWspZEh1y4sRY9p+OgWzb0mDP+5KJvdcbwHL0iWMRuZx8R5QU
 7aBm0GoJTf26mgh/qmeJKToGmt993Jki2PnQ/IEehvIKRwcR1efV+j5fb/g==
X-Gm-Gg: AYBFou1mCTPF2bXTDf+g51uRXnpDnbjrvGvh6nkhFqREoF9LKI9bPAs2muq9k3NSkge
 IVC2ofb5ZMjPfTAwz90D6DNpnKhiIfT1T2EuhS7NOe2K5YwT95FWJzJWJMi9Sumh+2lPq84wRmS
 YSGIKdeLmZ8VogA5QNwzZxQjwBX204G1vkOWeDvHVI3IGKtiUWm2SaSxAouf/KGwWzLRrq20p3f
 7cJhFdE7ngXPuETcq3zVr7fIUhP/ysYuKfg49ojd792bQ7R95QrWKrFr9RoTHCCN1bgO1VxG1H0
 +jKITkD+mPOajLKW6OTCpksTQNcYQA81s2DeRWPzZdBJG587weUAxYuR/+bJK+nKqa1q9TAYW2a
 wIkPhfESquVzRLnkxL1cMeHiriN9vhj/cEg==
X-Received: by 2002:a05:620a:26a6:b0:93a:c102:1123 with SMTP id
 af79cd13be357-93ebd1bb363mr3480535685a.15.1792129734054; 
 Thu, 15 Oct 2026 22:48:54 -0700 (PDT)
X-Received: by 2002:a05:620a:26a6:b0:93a:c102:1123 with SMTP id
 af79cd13be357-93ebd1bb363mr3480534085a.15.1792129733566; 
 Thu, 15 Oct 2026 22:48:53 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a81587sm64389945e9.1.2026.10.15.22.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 22:48:52 -0700 (PDT)
Message-ID: <d4de90fb-0acb-45e8-8e4c-56f41bf97133@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 07:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] target/i386: implement get_dump_info sysemu op
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-4-pierrick.bouvier@oss.qualcomm.com>
 <ae92234d-e6d3-47e9-b8a8-2d43a8855e20@oss.qualcomm.com>
In-Reply-To: <ae92234d-e6d3-47e9-b8a8-2d43a8855e20@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyMiBTYWx0ZWRfX8j2lrHKwxfy4
 Yyfp+USd2Bf29RPau0KqctetBfibf1OhjTo0dHwcD/h10egYEFH/rFZus6Lab3Ui0nky+sjJl4I
 z79jjo0cnkF2a4DZjmmCqPThOvDvNgQ=
X-Proofpoint-ORIG-GUID: w-Iex4mO3JEnlOzEhONJ0rDUB9Ev6mb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyMiBTYWx0ZWRfXzM/DqiEnFyfW
 mdS5/cgmk1xMNvRfKBdD0/7biz+jTo8P97LzfeDYL2xqOm5iQVh1ik59KiR05WV+FKsHzLrNWQp
 9YGMBnTUzQw170f8za+465uXcrsVkFA6CQbybxa139nG2Icg4575mkWoTD+ycXorD41v2YljKgA
 lBskDadsdmQRbpFWmlyNQsYvj/czkTDuARfb11hLSHKWIrmZyUzipwVzVqkb+AAy3sRWhKH05Dv
 nmVkjkgJI8H26XowJZ39p3U7Ua2l9gW0yTlCihZwjfD6KlpBr9+od20Sx90gs47wSo1ADclg/yb
 O5WUSTl+Cf1Ht4+0GxMMsErdTQTBn7F+MrAK5jwMlZt5ILBjJo4rqul4EmM5/L8fTUZzYjezuHu
 1FUIekJHb71+GJEwYQ1/wpn0KV6emggD1ZJctj0BaEsw3qhrpwRnUiK6P+wKbS/9GB6NNvqfs/u
 nddpQ7weTd0wuK9cYlA==
X-Proofpoint-GUID: w-Iex4mO3JEnlOzEhONJ0rDUB9Ev6mb6
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad1bac6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=8sGaTZthACtLRNsAWt4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160022
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 16/10/26 07:43, Philippe Mathieu-DaudÃ© wrote:
> On 15/10/26 23:32, Pierrick Bouvier wrote:
>> For now, we keep the global cpu_get_dump_info symbol defined.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   target/i386/arch_dump.c    | 17 ++++++++++++++---
>>   target/i386/cpu-internal.h |  5 +++++
>>   target/i386/cpu.c          |  1 +
>>   3 files changed, 20 insertions(+), 3 deletions(-)
> 
> 
>> -int cpu_get_dump_info(ArchDumpInfo *info,
>> +int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>>                         const GuestPhysBlockList *guest_phys_blocks)
>>   {
>>       bool lma = false;
>>       GuestPhysBlock *block;
>>   #ifdef TARGET_X86_64
>> -    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
>> -    lma = first_cpu && (first_x86_cpu->env.hflags & HF_LMA_MASK);
> 
> I know this is pre-existing, but I'd like to understand this check, ...
> 
>> +    const X86CPU *cpu = X86_CPU(cs);
>> +    lma = !!(cpu->env.hflags & HF_LMA_MASK);
>>   #endif
>>       if (lma) {
>> @@ -429,6 +430,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>>       return 0;
>>   }
>> +int cpu_get_dump_info(ArchDumpInfo *info,
>> +                      const GuestPhysBlockList *guest_phys_blocks)
>> +{
>> +    if (first_cpu == NULL) {
> 
> ... because you kept it. Why do we need it? QTest something?
> 
> (goal is to understand when this can be called on a non-vCPU thread)

Apparently s390x doesn't seem annoyed enough to check for NULL
first_cpu, but maybe that code was never exercised there.
> 
>> +        return -1;
>> +    }
>> +
>> +    return x86_get_dump_info(first_cpu, info, guest_phys_blocks);
>> +}
> 
> 


