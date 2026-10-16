Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6028CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHbb6-0000r8-BH; Fri, 16 Oct 2026 02:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHbb3-0000qX-Qw
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 02:39:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHbb1-0006ds-QU
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 02:39:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G4fYS33800311
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 06:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Eff4tiRLZlu07KOdmGOeYU4APp7jxVIL/d5Wp5ycEaM=; b=QP+YKFM5DavGPloM
 YLocu0rTyLuvJbR5kbR2KR3v2jycOXUJuyKt7WXjEjYDvv+EqGNf3AgsRBdRyB5D
 1CPYASYkKs/B/BZxq6slOpRHXQJa2ekYPFubqhxN/bU/w+OiDTe/ZEOrATphWA42
 mJ0TjiLdqPVz9oMTTEjWEoy/dK2R9ln/kyghMu4fcKuvqOBY9WNyZE4KpNMHBIB+
 65Vj62FUQFB3p3IDuvXt/NzKqudyuhKAQinYhTqCdqqCpZjFhpc8Q8yREDbHgT8w
 NOhtHWq1BCaDAhhlpVW5e5K0WZRM8RUsnPmFaElPUZFqMJ7P/1NO2ujqwAh+blSe
 q90Ykg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb5se9wh9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 06:39:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8862ed0539dso2777093b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792132753; x=1792737553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Eff4tiRLZlu07KOdmGOeYU4APp7jxVIL/d5Wp5ycEaM=;
 b=Q96wgfdHdGxKnrpb2xbqw/L3rAHlMN+B/Qeq/TZmL0q0kk41q+fTcbhf/ZC79P8GVR
 dLO4P72eJXa6GllNZakQPEkpsvL1tB11NBL+w1jKJ3Pw6q+SD14BVELWXWQcUCaB5l47
 7u4QvXAUBp15LZgzDa26cCn1u0r2gLt4qA5tXD451sTBYp/dtL1cxviTCWofHkjspIc/
 U7bwt3waqyBBFqGrc1JSEQzUpTgZY1pVqKdWVDbr4NY+WYvNRV/2ljPnpAh6FCjwUekP
 8wW4hDEc65l3ws8wuoZaqqmjW0/WmWZqiIP06gAP29mV6q77wOOmZjZu59nRDAfAZ3HL
 IKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132753; x=1792737553;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Eff4tiRLZlu07KOdmGOeYU4APp7jxVIL/d5Wp5ycEaM=;
 b=ICQw1MYLwQ/Ugx7iEFfJWTE3pf9FurHlgN7f5OJsY0AZ3xyls475JsKmnNDKaJ0epv
 JjgY2ecbYp71aYFAbp7rrdfA7nAS7/Hs8aiiSLnDdctQ0gg2W6CvvJqK66XJ7wJoyYVf
 XOJKpsFapCK/aKaootEHVGBhsZcSsyJEl5gMZtXKwUbQZQFnTcZqlYPGM6Tq20bn19rv
 XU3gvrUzNYa1K3QzmQLG9D+j4Vn7fOb0GD2IXEqHIjI64edL7QSwBmRg9qbTilJVCmFX
 yOkbBWtiuwSf5Uhf9HOuiJnAHE+/h0pUgsagd0nHTZUhyVi4ZA+YE1PPpIaBB0l6UPi3
 5h6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGl5Wp2DpGBprqTxDnytFZ2GpMu6/xXOuKFCkXrdP5YL03ny49fEMxbfdhh2DI4ffRCu9eyLr2b1AD@nongnu.org
X-Gm-Message-State: AFq9FYJurR7H1MUlGzhsnLVfg5+UwgFYAVS/RxBN+4E01m1iYsXffqdz
 fUUA5YNjCfQnn1Y1r6BpkM0omYw4Q/vvqmBFQM/+F0Zll6C3yar3vWUpgyj2yp440RSNN+tFL/u
 yWO+gyT9KI67CIneK4JYOADgfYn3xpmq+f8adfZkBNiMMZswsNToOEbZ1YA==
X-Gm-Gg: AYBFou0UKaoRR27zPXxYd5zjtMH9bPH6D4o98EKph8AxiU/k24YWBp6ASozLQ1ATpf6
 FiYxeLOz7YRHrb5KA6VilFx7w/w/TlPAQuDvvYhcM0Ok+k0grShFZbxa2cDngE5rf/wy9TlFTgu
 W7L1zV7/qTi/xYmo7yHMqkWpY6gqGWn84pbytq3QrBJvB7Wn1GC4JIV5orjuS3tQFYwz6kzPc09
 +rZS+ZJmqfPveze2UQ4c/8R6HukjPNpMvGRhAVAJHabhQVAgHrUsT8l9TOlulBk+4uf1E+UcHAF
 2DFsVQCA1aBPROZnYSU0XDvt5XfwA/oAEAKGay7TvHgbFhewRQx1T9bnhVIQPdm6Gw7izv6nyQX
 u8Feu2bpGOXIgNsxpMbY6Ew5Kzqg4LHAEcIQSBfIzQsZ2/6s8ZhLdKRDb
X-Received: by 2002:a05:6a00:419a:b0:881:fa65:d507 with SMTP id
 d2e1a72fcca58-897c73f9478mr17344529b3a.22.1792132753078; 
 Thu, 15 Oct 2026 23:39:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:419a:b0:881:fa65:d507 with SMTP id
 d2e1a72fcca58-897c73f9478mr17344508b3a.22.1792132752589; 
 Thu, 15 Oct 2026 23:39:12 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f58017244sm627244b3a.47.2026.10.15.23.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 23:39:12 -0700 (PDT)
Message-ID: <2ddc345e-4f28-433c-8b38-d0609a0aa020@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 23:39:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] target/i386: implement get_dump_info sysemu op
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-4-pierrick.bouvier@oss.qualcomm.com>
 <ae92234d-e6d3-47e9-b8a8-2d43a8855e20@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ae92234d-e6d3-47e9-b8a8-2d43a8855e20@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfXyZiaVVgaoeWy
 70knDHnzOTAI4P/IdJz3OdO6nNMd3t1YixGgSWWMHXyJiAcWoRWdI0iuowyPuhqfnDRK5MnTSu1
 zpbfJ1y4u8RhgxehPa1rEoStRMLBfl4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfXxehzsJxdFNZ7
 ITb77ERSP4nyhhyx4YjmeygQUHaDsd+xXd8fuK0r2W7fWUGLnajwayyLtlBbh9SoFCEltwepfpv
 xPz5+vlrEjmle8coqctJ3bClIt+po0z28BcgkBt9dGuwaxPYdn/EKdJxoGiFJIAOJu7hZBheLHh
 zc2Kl/JGj361cPIXrhe3IBfkgwJqi/SlJsxPUpzwe2cN6/Lxri482Pr38MT602onVdRbunvQGfB
 CIB4oNglhWjawS6i9yba92cgMgqlPNu4DsgKjxcfTIilYGqGw1HM6VSW0PCORK4PsmwOPWTlRdz
 wXkCo8X7tycM/YQlQf2GetKHye/ROzrRGk1STy5fTFzjNeicRcznlymlJBJgTRBeXuKixVxSJkE
 cUD7WQH489dJIJgrlNZCjnS5BEFUlGNCehEJ6yeS5CAvebaaGYG+t/bb2JgTvtlJInh+TaRY1wD
 NkaubvtSZ20dS6CZQRw==
X-Authority-Analysis: v=2.4 cv=P4yvFSAu c=1 sm=1 tr=0 ts=6ad1c691 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=CvMaXj2VcjRQU71Eg5IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: iAcwRYVOj699DGXBGm47g-UARl1jjEph
X-Proofpoint-GUID: iAcwRYVOj699DGXBGm47g-UARl1jjEph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160026
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/15/26 10:43 PM, Philippe Mathieu-Daudé wrote:
> On 15/10/26 23:32, Pierrick Bouvier wrote:
>> For now, we keep the global cpu_get_dump_info symbol defined.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>    target/i386/arch_dump.c    | 17 ++++++++++++++---
>>    target/i386/cpu-internal.h |  5 +++++
>>    target/i386/cpu.c          |  1 +
>>    3 files changed, 20 insertions(+), 3 deletions(-)
> 
> 
>> -int cpu_get_dump_info(ArchDumpInfo *info,
>> +int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>>                          const GuestPhysBlockList *guest_phys_blocks)
>>    {
>>        bool lma = false;
>>        GuestPhysBlock *block;
>>    
>>    #ifdef TARGET_X86_64
>> -    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
>> -    lma = first_cpu && (first_x86_cpu->env.hflags & HF_LMA_MASK);
> 
> I know this is pre-existing, but I'd like to understand this check, ...
> 
>> +    const X86CPU *cpu = X86_CPU(cs);
>> +    lma = !!(cpu->env.hflags & HF_LMA_MASK);
>>    #endif
>>    
>>        if (lma) {
>> @@ -429,6 +430,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>>        return 0;
>>    }
>>    
>> +int cpu_get_dump_info(ArchDumpInfo *info,
>> +                      const GuestPhysBlockList *guest_phys_blocks)
>> +{
>> +    if (first_cpu == NULL) {
> 
> ... because you kept it. Why do we need it? QTest something?
>

It's here to ensure it doesn't segfault when dump is called for none 
machine:
https://gitlab.com/qemu-project/qemu/-/commit/fd5d23babf9838c1b099a9e8020e778aac0ebb4d

It's a corner case, but doesn't hurt to keep it IMHO.

> (goal is to understand when this can be called on a non-vCPU thread)
>

I don't think it matters where this code runs, first_cpu is just the 
first cpu available and it can be accessed from any thread, vcpu or not.
Now, the day we'll cleanup this TARGET_X86_64 guard, then it will be 
time to revisit this question.

Regards,
Pierrick

