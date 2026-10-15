Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56963CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRMZ-00008H-Lf; Thu, 15 Oct 2026 15:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHRMU-00007e-DJ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:43:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHRMR-0001gY-HU
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:43:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFajsV4077489
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l+dKssAnUb40haZOmKbsPuO1tAsj9iigzR+eQQXMCfA=; b=JoD2dkeJS5KEqvio
 KOVekUS4AXXwseNzKByfEPD0/bvFbb2QTN59/tvJtAk+pNGOoCgIT/+u3DkDG3hg
 LDlZRJuo53eYteZwALpfdXBy0wO70poMy3zH4bcM4EFm2ER8iHKZNPl4HCRCfF6E
 g3Y3Esc9Psgp4sD5g+Ro1A095UKrh206d8C+5PM6VhI/DusrRUc89jPgVXV0NcUl
 C2lvtaOQXyvzoz/+oa8HEKnngLho10bWj1kv26h2iOnFufUZwjXsC3QFNVE+cqYQ
 2O1iG7tzbJCs3NSDmucgm2e7/h9Y6+VY1ReR6+Y+vd7A+jzMBlm5v5/xslgoECKY
 qQ2iPg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4havbc2f77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:43:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso1041684885a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792093406; x=1792698206; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l+dKssAnUb40haZOmKbsPuO1tAsj9iigzR+eQQXMCfA=;
 b=ZZLmFTkOP2452x875P3BPvtrogBxa5OzPChQkPsIabHdG7ELrFnyGAYCCeb/8WJj0P
 dzLsaox9Fi9Wz7K0urF4tduWRlGpcvuJsJAfvNIAL1b6NBUWfJamPhLAYdUGgZNccvP+
 2WarvX3/fSOS4y0FZTn+Fj+2rBAamu8ZMbCaPb1NpYC5xr/VllDJiYIJn+GMvasYwLAk
 gj7WvHKoVrL2rkhtchyHk66iFlm8JMlIQFatzC/0WpfER/4kPIIb59p0m+7KNRms9tx1
 JBCqxNd/mvBX5DMD1LptdIpj8BZFy9pbvNuwxpGj7TjfK33fBwrl69Jvuagid4DDd4a2
 l2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792093406; x=1792698206;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l+dKssAnUb40haZOmKbsPuO1tAsj9iigzR+eQQXMCfA=;
 b=FA1IYOt5eVleBu64JMZQCTGD5n2xC+dM1qhuOsA+g9/cRu1kKMto2LzR2h3KUnKiUH
 2lPb2EtNI1fBHvA/oQEqSPTd7FT1FCcx9rs4W59OoDjeUV4b0Me0ZRT2LI5tVijl3wNh
 dKFEycPN9ycFkaFCUTKWb2HbWZKu+qfur8/Ep89Hx0si47I8FLzJIGoPMISlhVjxZnjH
 VP8hWOR/H5wRH91a4fb5TfIlcqpAr35mnsR5CJhov+2hY0ZuybC28oQTYOS5+IKRjG8Q
 XhkkwBfDLfnQrqpqVSz1/qW8t8X1EEvSWD1AaUZWfKkY/YYx99usCI7AW0gZ1QRFZoHv
 2uoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1G19Vj6qZi1cWkzOfDHgiEg2ADPV1p/xfZWQP011voygQSArNvvs3DCte8Av+EYtghPoRCxKSW2Us@nongnu.org
X-Gm-Message-State: AFq9FYKqYXyoG4vwYwOKVcCamDc3hm9lsl+iC1vAFvLEX5GmV9G/e3ao
 pKdGGMuqb54w2QZNtamtVzUPcR8sYGu7wWl41bHQYFHkVurzT4jgp3I+UN4qm9xOnZlU5qPi5tG
 vruDclVPFFx6mmzDp6i57dAobV+yqqGf59IaHUTohedfTTQOAQe1HY+B7uQ==
X-Gm-Gg: AYBFou1z4atujVVtlfJ2lhphw1UqIN9+HqVmPGbAkLSVhfu/GaGUKkOAA6Vxkcxfjq+
 rh5CCLHB8igDHODvli0NvEhc61D60xCFuj8PIbJyT/Fy4ZJ3bUQ5sn2xVVP7JRULnOI6OoGSrul
 rOJlhy/pxgqca8P7d11uL7vJL7i2lnA9Wf+j62qXgdfvCwIB5Wd8SsWwJMerur3DwYy/zCzx8Om
 g0A4aXb5La/vrRP2oLFdrRj1ugFbMcXpkdtqt6bLtXKnmo7VX6AIk2W7dtwAHE+wdlXKM4G5rsh
 OCYgZbnpQFIues3ip0DhgOBwBr5RsJme4ruyvpsXNraw7iKlbtv9PI5LsI6YaQO/jKlfF4KYSOv
 yN5m6B8Y7g5vhmOPpSo++HSdBHvwuX4gw8Q==
X-Received: by 2002:a05:620a:270d:b0:93b:d79a:c462 with SMTP id
 af79cd13be357-93ebd26b606mr3208306785a.58.1792093406351; 
 Thu, 15 Oct 2026 12:43:26 -0700 (PDT)
X-Received: by 2002:a05:620a:270d:b0:93b:d79a:c462 with SMTP id
 af79cd13be357-93ebd26b606mr3208303285a.58.1792093405828; 
 Thu, 15 Oct 2026 12:43:25 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9a88bbsm95353065e9.3.2026.10.15.12.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 12:43:25 -0700 (PDT)
Message-ID: <a4e01327-4931-4c59-b083-e5212f865ce7@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 21:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] target/riscv/cpu: constify cpu parameter for
 riscv_cpu_mxl
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com>
 <b99355a2-a424-41b2-978b-8938de06cbda@oss.qualcomm.com>
 <9218a003-b19d-480e-ae11-cf3ed2b9e592@oss.qualcomm.com>
 <56883c4c-dd87-41f2-8e71-1bb8fb65844d@oss.qualcomm.com>
 <7bd455f9-b26a-4fc3-813b-d4fec6b6a03d@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <7bd455f9-b26a-4fc3-813b-d4fec6b6a03d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QbvzLcbv c=1 sm=1 tr=0 ts=6ad12cdf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PZzySE43jPnr-TkPrcIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3OCBTYWx0ZWRfX6j3jl3Am0Q1T
 S42f9O+xKowrcna/fqDDGedWZPuJuS9l3X1keNQBHvOME7S+2tEg3AUrsI1qde7OHINvNWNGJ7q
 0gg3GqxucAjNkCjbbQmcy2r1667irU0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3OCBTYWx0ZWRfX5a7s6CtWkgSm
 P34aXIfg8MADFqrgAtlH4ZpSzq4UPr2uM+DNkVrOYKLNO3lGHIGwVt3iIeAB7ollFTzMqyWjFCh
 p1RSJZFzZS4YqXay5O6oxJdlcBr9JTHtZHyIqYLdz1UOOnUy77vrvMkRpgYmAmUUVpj87OCAmGA
 iEp3mu5eJmT6yhA/jyOdQ3glcvAzpr+wdV1e3ob0RVebUtFMmTH6z2j2tslVDWvBRzautUvRDIL
 Dsus6AZATKIh4I+XgPWNZA9xvq8M4dQJafqoI5WsTpc7dOo/k7j/oiVNFLGnPawXgNCCHpPxNBl
 SEBxtg4sHsJp9QwGEvdYxLTDIk2n7V4j9m31GDxbm8eM8xIxKbuFh4YYs8QZCzy7+A8ZFDp7zz3
 bytsoTxialYOduCE9dCBu4+lUPhdGOeL+bbQKulJ13iy2E/MrUsQVeOVOhCM2cuB2u9lLgyL0xa
 Vt8zAmdSvTb9zg2MAHw==
X-Proofpoint-ORIG-GUID: zi9PaG0LDIuOXnaznBi01dAXKdED3BAr
X-Proofpoint-GUID: zi9PaG0LDIuOXnaznBi01dAXKdED3BAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150078
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

On 15/10/26 20:09, Pierrick Bouvier wrote:
> On 10/15/2026 10:48 AM, Philippe Mathieu-Daudé wrote:
>> On 15/10/26 19:42, Pierrick Bouvier wrote:
>>> On 10/15/2026 10:37 AM, Philippe Mathieu-Daudé wrote:
>>>> On 14/10/26 23:05, Pierrick Bouvier wrote:
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> ---
>>>>>     target/riscv/cpu.h | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>>>> index 8c8ffe94cd8..00650a66dcb 100644
>>>>> --- a/target/riscv/cpu.h
>>>>> +++ b/target/riscv/cpu.h
>>>>> @@ -755,7 +755,7 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
>>>>>     #ifdef TARGET_RISCV32
>>>>>     #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
>>>>>     #else
>>>>> -static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
>>>>> +static inline RISCVMXL riscv_cpu_mxl(const CPURISCVState *env)
>>>>>     {
>>>>>         return env->misa_mxl;
>>>>>     }
>>>>
>>>> Reviewed 6 weeks ago and in Alistair riscv-next queue IIRC:
>>>> https://lore.kernel.org/qemu-devel/20260901095229.72018-17-
>>>> philmd@oss.qualcomm.com/
>>>>
>>>> Anyway,
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>>
>>>
>>> Did you flush the rest, or is it going through all submaintainers trees?
>>>
>>> I feel that system wide series like this should be sent on their own at
>>> once to avoid having a state spread across multiple people with
>>> different latencies.
>>
>> No, Alistair queued patches I'm depending on, and I consider a
>> maintainer sending the "patch queued" message a lock on the
>> patch. I'm stuck waiting for preliminary riscv-related patches
>> to get merge to reduce conflict with Alistair tree. Meanwhile
>> my tree grows so I'm not sure anymore it is a good process,
>> maybe I should have posted a PR and let Alistair deal with
>> the rebase conflicts. We still have 10 days until the freeze
>> so I guess we are still in time.
> 
> As long as the patch is strictly unmodified, the sub maintainer or top
> maintainer (merging the PR) won't see a conflict, since it's all done
> using git, and not email patches.

Fundamentals of git indeed. I'll try, hoping that improve the pace we
get series merge, hoping it won't disturb Alistair tree.
> In case there is a conflict, I would say it's definitely a
> submaintainer's problem since their tree is the one with a local state
> fixing conflicts between multiple series: probably a strong hint it
> should have been flushed quicker.
> As long as they don't have to deal with conflict, by keeping an
> invisible "lock" on this subtree, there is no reason for the workflow to
> change.
> 
> I understand your situation though, there is no good way to deal with a
> series that depends on another in flight series: either avoid this, or
> repeat the required patches in your own.
> 
> Regards,
> Pierrick
> 


