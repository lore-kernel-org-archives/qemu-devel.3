Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39252CCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHfnc-0005d0-Fa; Fri, 16 Oct 2026 07:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHfnY-0005RF-HG
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:08:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHfnV-0000N4-SB
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:08:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GAAY5n1794483
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0lG7wd1IVqhydfGCBr3MJInmzgGVwCYfQeL9Xv+7FY4=; b=McQKYlgJYdfAvQuL
 fS73xEU4Q0ngWao1+mb38B8+fZ3t8auBC6n8MQM81sADekwciWa5Wd/k4dUQzlk8
 Fqrx5UJlZsnZFsfyu824vAwYxrWkBb+ekJUsqf+MihkYcxCsMD3CVp/+R0EbDUik
 dcxt4ymO9GtQbuexh5E6Dnuf9Eu4aClzet5y/+lz33WWJUZOa8pwSqhd03U0tyL1
 +hNQmfG+a6k/PGjHAY9mJPn11pd2Gg9tprKPUzyeA+vEGr9fMUMdzx9/3IIp3WdQ
 8nCWRb/DKuRBK4J0EB5/mLB1vICYwnlEp4FolOwJkCJvFFWp2Jhdb0ACPS+TryXo
 R6JCzA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3seudxd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:08:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cc7a6e4e1so1898840285a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792148904; x=1792753704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0lG7wd1IVqhydfGCBr3MJInmzgGVwCYfQeL9Xv+7FY4=;
 b=NNCnBmrmn83maa3xXJN7B9ZD7Q8qgVQBMe05m9xeDMIK7Y9k/9HxiZnSR+mfSpMgTD
 8qDIs14oup+3TNjSGWLaBtlrDQ+Ut+hfA3O6kTsSvBLdX6cEl03kN0SUoPZGCtn9aucP
 7wDuKpRtlAp1kxfkkMkFhYx7qa35N8e+xJoJ3SEm5E/k1sQHQbfkWtQduGjmkCjLnebu
 h22TwE15lLzxYedIhh83yNXT1GVJP8VIS0U7VziTyJ1V1MdHedQ3sdmITPjVCvEHZZLC
 R2Aat5US1sp4FbOvTRrnd9WF374+eY5yl82Wtn0TSFO5HDgIzraEriwd4edoQ0vwDw4k
 GbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792148904; x=1792753704;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0lG7wd1IVqhydfGCBr3MJInmzgGVwCYfQeL9Xv+7FY4=;
 b=EbAMJrasq14PXyIBJHsOXN71y1HBqeNwUniCb8daL/PyQz8iDfmZoS2/GTDOl4G+03
 u3ie/stAuinn9A/LrBNUATw1+HwctUUyEKcDQQOP4gHM2RX5UlmTMmYX65TdvkOfspoj
 eoM09nSbf/jB9FIsay49CJhcrNbyCFBjQHHog8vR8OVZ/xqV4R1X9g64tMZqFNCSDETy
 86dcoJp+UBmyPSc+YOIDa+0zBSWni6zlSLpU0M3woyhx35pFdo0eOl6nueDYM/THlDQd
 cNRAlXboQKSZTNJxDEGUn/2rGHk9v93l76fswRFg0p2tj6WQDWodSo73sP6dtYNrTZKi
 6b5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzV+UCxcz0NX2eiFjeT6UuNk5H7C5bTAEf1E/3ab8LNF3Ts1BzY20Oa3Vr57P8penMUpjVOSnpjJG3b@nongnu.org
X-Gm-Message-State: AFq9FYK5uM4lBysiFn5gt3QLB62EfBobWUGy1ZaAPhSxU90jFvS64xhY
 bZYfpqvLyjfaxzI96fUAUgpf5nwLRC7HA3WW1RH77UAhd1Zx2YX8Db3sbC9FLDwmOoEFVZvvREn
 yrX5mnrk2Ae/lgoAiKa+g4HQC8Cok+GagcDo9xmKBQiKysDamZFhdFHz33w==
X-Gm-Gg: AYBFou156bdSs/DSaDMObkNnbrMp0FTu858V2ywoQ1m3JhtA2VTUcbVfshKaPnMvQDY
 M9Fe2S/X9a8GfmDoh3nltKkd6sKHtwRhzRuQppRVbjS21B7Mf2DsPjH06RzCWg//yumB6ZTBTvV
 ENrF1UzmgSOFjue4895m4B5OdIiOj0mH15frdyii+Rj9ptlCKM4Gavv9YOxFTEI5/Z2imwyANqS
 HHGb1OwaMV37k0RE6xe2qfHipmQCVhC57xO6HtKY3jquj7DFCFotS4ndrjNXxN9QSpEM5pqU/uD
 Zsj9i/iIXRWxBqTBAgdsXnUiSUFvNuZaRSKaDPc7YZD8v7niuxInlB4kiram9SZG04dSpYNukZX
 5H2oO8w8EglpFxXNFjLhqMdHXCRVrNFOt3A==
X-Received: by 2002:a05:620a:2993:b0:93e:61ee:fb14 with SMTP id
 af79cd13be357-93ebd248395mr3381924885a.36.1792148903627; 
 Fri, 16 Oct 2026 04:08:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2993:b0:93e:61ee:fb14 with SMTP id
 af79cd13be357-93ebd248395mr3381920485a.36.1792148903053; 
 Fri, 16 Oct 2026 04:08:23 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd50d1bcsm4425162f8f.54.2026.10.16.04.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 04:08:22 -0700 (PDT)
Message-ID: <ce002f54-0762-4178-a9a2-a0556fbee135@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 13:08:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] target/i386: implement get_dump_info sysemu op
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-4-pierrick.bouvier@oss.qualcomm.com>
 <ae92234d-e6d3-47e9-b8a8-2d43a8855e20@oss.qualcomm.com>
 <2ddc345e-4f28-433c-8b38-d0609a0aa020@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <2ddc345e-4f28-433c-8b38-d0609a0aa020@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: T9NlTs7PTzqOarpsw0-iw8goaZUEN3Sd
X-Proofpoint-GUID: T9NlTs7PTzqOarpsw0-iw8goaZUEN3Sd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0NCBTYWx0ZWRfX30xuRLnB7eDs
 oM7UIp2VyJD3j3y+y3xZ3Oogw0FSq17SfUPxAyns8rAUklNZ+2yT1URS0EDcgObOj3Fq/TU8W6c
 Tw3594bSsLSFcD2DLmimbeSUMPbnx6k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0NCBTYWx0ZWRfXxFeW+Ccw0lXF
 z8pmAoNABH62U384Jv+V2NpAdOqxDF67C3cLJW7wVTgLt0l6dnHkY4lEt65sHaPtY87KVLlMNsA
 Bty4AhJaQDXZzckIMlJBqceamdNnf0cXPLdCXtXpTs1Cfbi05JxeMG3rwwWpueubbCBMC705TST
 fJaSSZvv3v2jsY9Sks4Br0PqrmTnTQsIKlw74DeSUPyha4FYvt+gRCYiUlyg/WlScqlxjRZAM55
 u1uZME6m0+sZC8KQOnVchffYEWeXxiBvhsvd8w3Ps/VVZmDHIbkd0RKFz/OmVyBqGfeHKQpaI3z
 zAmXvbjItTBuKH8LBr6LZP9+P6fb1PAvXVCO/xavPT/yDL9yNy7/CE44BrfJejfVJgNX9PiRuxR
 fk6deuJrRvSh792355Ya7U/vuilx7ETmn01nu6lYldP5GXoUOkM5dx1TYplUuUmpovZHz9+0lZz
 0+iYkIWZ8f35P2UUQ+w==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad205a8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=MOoITgU2Mq_nIJlL_dQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160044
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

On 16/10/26 08:39, Pierrick Bouvier wrote:
> On 10/15/26 10:43 PM, Philippe Mathieu-Daudé wrote:
>> On 15/10/26 23:32, Pierrick Bouvier wrote:
>>> For now, we keep the global cpu_get_dump_info symbol defined.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    target/i386/arch_dump.c    | 17 ++++++++++++++---
>>>    target/i386/cpu-internal.h |  5 +++++
>>>    target/i386/cpu.c          |  1 +
>>>    3 files changed, 20 insertions(+), 3 deletions(-)
>>
>>
>>> -int cpu_get_dump_info(ArchDumpInfo *info,
>>> +int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>>>                          const GuestPhysBlockList *guest_phys_blocks)
>>>    {
>>>        bool lma = false;
>>>        GuestPhysBlock *block;
>>>    #ifdef TARGET_X86_64
>>> -    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
>>> -    lma = first_cpu && (first_x86_cpu->env.hflags & HF_LMA_MASK);
>>
>> I know this is pre-existing, but I'd like to understand this check, ...
>>
>>> +    const X86CPU *cpu = X86_CPU(cs);
>>> +    lma = !!(cpu->env.hflags & HF_LMA_MASK);
>>>    #endif
>>>        if (lma) {
>>> @@ -429,6 +430,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>>>        return 0;
>>>    }
>>> +int cpu_get_dump_info(ArchDumpInfo *info,
>>> +                      const GuestPhysBlockList *guest_phys_blocks)
>>> +{
>>> +    if (first_cpu == NULL) {
>>
>> ... because you kept it. Why do we need it? QTest something?
>>
> 
> It's here to ensure it doesn't segfault when dump is called for none 
> machine:
> https://gitlab.com/qemu-project/qemu/-/commit/ 
> fd5d23babf9838c1b099a9e8020e778aac0ebb4d
> 
> It's a corner case, but doesn't hurt to keep it IMHO.

I don't see it as a corner case but a bad API design. Why get called
if a machine doesn't have any CPU? The caller (dump_init in dump/dump.c)
should do the &first_cpu check, and either call with a valid CPU or not
call at all. The callees should abort for NULL vcpu (programming error).
Actually dump_init() already does the check by assigning nr_cpus.

Anyway your changes look correct since you pass a @cpu argument to the
methods added in SysemuCPUOps.

>> (goal is to understand when this can be called on a non-vCPU thread)
>>
> 
> I don't think it matters where this code runs, first_cpu is just the 
> first cpu available and it can be accessed from any thread, vcpu or not.
> Now, the day we'll cleanup this TARGET_X86_64 guard, then it will be 
> time to revisit this question.

No need to revisit, add the target_heterogenenous() check (this code is
completely broken in this setup) then we are good / safe.

