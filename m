Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC62606A32F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K8MSLm/c;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C+Ye2VBn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOx4V-0003Mr-LM; Thu, 05 Nov 2026 08:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOx4T-0003LT-FD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:00:01 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOx4Q-0006X5-TW
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:00:01 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5A1UOg1416577
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5vQ29i32Lz59NXugBGY64Sl0G/vg/VhGB19T2tDXXCA=; b=K8MSLm/cDxr5v8/w
 9kIBzC9P+DNJWxtI5CLVTkyn/WbNrfwNuET/3g3sPlLGBAPfuqkQxhEiJoFwE9me
 lz66Zy51+6aeWGAiNRyOs1SYS+mC1Lbe216cS1+dC3s/6nj48se42bvZdkZJAriH
 C/7NyiL7jV/5r4Ciq0/Tj88G2A06XMCjev1bLxqxSzbuZERtu/hQH+x4tasr3/hG
 DyEzghknvVj4aQSudpLo+g4nAchxVlnEy5DhQSkxYfPVAa9P867vLNTdrJDscrf5
 v1dJ6j70sJELWk39LJzMU+JIUThvMSEVNx8Zc6PRnDia3H/DeJ4w/nUfG1hLMiRs
 iFgZaQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqpd0q1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:59:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91c7a0f8250so38438926d6.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883592; x=1794488392; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5vQ29i32Lz59NXugBGY64Sl0G/vg/VhGB19T2tDXXCA=;
 b=C+Ye2VBnf1bUcoqFKQGy33KegtYCjcClTJ7ZuER/+lBoZulsrYmVGZqagYz3UcO3/r
 L4qrRVyxfjWg9JLM7QaFtm1hB/AUdtxadsb9r+eOIZoa+Gen/R5UEzosp5KK/Us2N2O/
 3Vu9h1yxmr7BpAXVofTPNCop7A2MQjWLrkCDYKijwLJGEvWRVo0a8gHZjDu9YpNgLYx/
 gyAYnpJnV/SN31G3k/ZXDc7DqrQ1dOakdd/Cu4OWzqMq8oA51TRytqxLuSpIKckv+Xjl
 rstj0zFjJeoytGdUz7NA2eKtinmoZfpxiMxj/j2RJopgZP9x2dicgbAe8QgQwUa/TIw3
 RO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883592; x=1794488392;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5vQ29i32Lz59NXugBGY64Sl0G/vg/VhGB19T2tDXXCA=;
 b=fEvWPejCEtkoE57j79giE4aCkT+Nxh406UIgJ/M+4WJdyIgz3KziKfiQUuk66/e8r6
 tq113fUrGT/vU5G/WqwGKnLGH9RegBvsrj0mggif1SXA1XPCF6rRLFiR2lu8khbSruiw
 OCiZpuWITajkEQcdX4N38hie8LpuClSuFpBatFEtP0IbxYVWLLECc42Y5aKdC32a4YvQ
 o0bUFQlnvWOvHgPfGJz3lxDjyFOWVyQbcTHTDwsOl9Zhcy7l9PVBJ/G9K95Wq6+l9OFa
 wXweRVWmcWPL81iSkQh3t4MXaaiggrCHEwm8/qNFus1NtD5d8OIEg5asfc6+OCoXBVwA
 Y5JQ==
X-Gm-Message-State: APuU4Z/bybzMxMgUma8N2fn8cq5C/zxTCapu6WaRTVMY2ug3bCtwNm+O
 7QoGlsA3eIMxPMmX7cdp/wu84krH0hPuw8TvstmuouwZzmFUfHyZQJJyDXZqwq157/M4qCsyVGH
 1TRxtn7cdxjCKrHFZFrq5TSWLFDc2dK8MSMbHt1qHOrRqyu0+L+DBgzgOpA==
X-Gm-Gg: AYBFou2Y20gKf/wj31Jn1eu0cEuivBQxJjYhhuACoX1X3OAF4woVVE2UQurmUY8VrYG
 0ZbA+VnOWCeu4L8zJ0qYhZJ7l1pRqB2pPYPrnHNb4RPAV8BmL3f28K6yIcsJCzJzAFyzL4hUBQQ
 xAA5T6Z4Df6WNelofGYUqYtcIroh4goz/yOvFAATHYD3Tz8eBTFKrsR6HDuiWN7LJlcVjXvLoma
 WNsLcBS80+3Gtjm2OQY2s8xGoVHKxL2mwBIv2GgDfb33RUWDGguL8RIkt9F5Y7ScQRSML7ROhLR
 EpV5TA8VBOJL6sITjEG09DiP3S2yi19oxdPh/c3pkIY0Yg/V4BvbeHFCztUpV66z5bXpqO8QaIj
 KWCv/gEk80TF1GYakEbBTMyNt04pDnSpOLdiKJA6RvcdeyBKwzTgmUK+KTsLvSPRQNZ24zM5dDz
 4mTdm6kKE1
X-Received: by 2002:a05:6214:3005:b0:917:a515:ba84 with SMTP id
 6a1803df08f44-91ca4b27b8bmr324216376d6.32.1793883591434; 
 Thu, 05 Nov 2026 04:59:51 -0800 (PST)
X-Received: by 2002:a05:6214:3005:b0:917:a515:ba84 with SMTP id
 6a1803df08f44-91ca4b27b8bmr324215846d6.32.1793883590668; 
 Thu, 05 Nov 2026 04:59:50 -0800 (PST)
Received: from [192.168.68.102] ([152.234.122.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91e7dfba098sm46935086d6.12.2026.11.05.04.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 04:59:49 -0800 (PST)
Message-ID: <3bdbff06-8a6e-44a7-b573-175c5fb942fa@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:59:46 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/11] target/riscv: Implement Smsdid and Smmpt
 extension
To: Rahul Pathak <rahul@summations.net>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 chao.liu.zevorn@gmail.com, liwei1518@gmail.com, qemu-riscv@nongnu.org,
 xiangyi.zeng@linux.alibaba.com, cxx194832@alibaba-inc.com
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
 <73bc69a4-a3e6-47c8-9c7f-92443706b250@oss.qualcomm.com>
 <397f4ece-067b-4714-93f3-082e07fad06d@linux.alibaba.com>
 <CABdD5xku3v1hGGHQA=WNiB-zTYkHdg=Pou5nci7ShUyERLp-CA@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CABdD5xku3v1hGGHQA=WNiB-zTYkHdg=Pou5nci7ShUyERLp-CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX/kTdecOi+cBd
 /pIBvjY6AUg12MAppyDY3yprS9ItiMYtWPFJ3823mg3s6MIyanXh1L9nc4sFO8LsXWCb1ma4WV3
 5cUmq26M7eG8Rox+e2O5iRN/4QsnvhE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX0APlj/H9rzcM
 3a2WmdrhiELcatJbvjSsUcsYYlCpNhdP2+jktqBGptdqyfJR0U3MaC6MAxhU0ddBdwhAFdYPt8B
 891RjyJTyiiSf0kVOwhGAcmiy/+WA0wcU/ldeSREn5wcKsqMmXry1RW8QC3SBOhObyQpeCY07rJ
 wLgg/149nrqkIHHJ2FOJFKGLp6f9t7SQv/+4h/vD2Vn+mczWvyi2Fg2+XArDBUzZJVe1FWQ0r+j
 0qP/Bqgf+Ou+UFyi1d/bF4/OY1A2fw0mJyPTn8VxAv0O3kJUwnjZcv8jUkfEG2FvIL2JYITnhkk
 eq3+cmy6gfbozdeeTDynfS6xQCwSNekbl18051TGcMnfdmwojXNyw6nHyw4FwAVCJ/jZomYkN/i
 0fVNkdmxp9AmZJObjnNoxrej2+/AAWtHs6zkLKX/JpWEGpaMFCxovOU1K+Tn2az81oqHAwSXuXH
 ElGNTEzPUGvelRZ1eZA==
X-Proofpoint-ORIG-GUID: KWfu-3UO5xJgcgo3OtI7y-jP6ZyY128a
X-Proofpoint-GUID: KWfu-3UO5xJgcgo3OtI7y-jP6ZyY128a
X-Authority-Analysis: v=2.4 cv=Y5JtIReN c=1 sm=1 tr=0 ts=6aec7dcc cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=LQvE5zGBNe+6ot3hfEwogQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=xvfqbYfxAAAA:20 a=mDV3o1hIAAAA:8 a=JfrnYn6hAAAA:8
 a=GaQpPoNlAAAA:8 a=SRrdq9N9AAAA:8 a=mvj5sVmwUl0dZkpUz3EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=xF5q_uoM5gZT5J3czcBi:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/2026 7:45 AM, Rahul Pathak wrote:
> Hi Zhiwei,
> 
> The SMMPT spec has been updated following the ARC comments
>   and the big change is the merging of both SMSDID and SMMPT
>   sub extensions into one with new name "SMSD" which is much better now.
> 
> https://github.com/riscv/riscv-smmtt/commit/ff5069fa99fc1fdd97c9fb8d96329e13afa82712
> 
> Can you please update this series.

And while you're at it can you please update the TCG tests to use the
new meson infrastructure?  It's a matter of changing patches 09, 10 and 11
to add entries in tests/tcg/riscv64/system/meson.build instead of
Makefile.softmmu-target.


Cheers,
Daniel

> 
> Thanks
> Rahul
> 
> On Sat, Oct 10, 2026 at 12:13 PM LIU Zhiwei
> <zhiwei_liu@linux.alibaba.com> wrote:
>>
>>
>> On 10/8/26 10:42 AM, Daniel Henrique Barboza wrote:
>>> Hi Zhiwei,
>>>
>>>
>>> Sorry from taking this long to take a look at this work.  I am afraid
>>> I'll
>>> need to ask you to send a v9 due to the following upstream changes, aside
>>> from some review comments I made:
>>>
>>> - upstream changed how tcg tests are invoked (we use meson now), i.e. you
>>> need to add changes in tests/tcg/riscv64/system/meson.build instead of
>>> Makefile.softmmu-target;
>>>
>>> - upstream also changed how we declare things in disas/riscv.c.
>>>
>>>
>>> If you send a v9 I'll prioritize it for review.  We can get this done for
>>> 11.2.
>>>
>> Hi Daniel,
>>
>> Thank you for taking the time to review this! No worries about the delay.
>>
>> I appreciate the heads-up on the upstream changes. I will update the
>> patch accordingly:
>>
>> Switch from Makefile.softmmu-target to
>> tests/tcg/riscv64/system/meson.build for the TCG test invocation;
>> Update the declarations in disas/riscv.c to align with the latest
>> upstream changes.
>> I will send out v9 as soon as possible. Really glad to hear we can
>> target 11.2 for this — I'll make sure to prioritize it on my end as well.
>>
>> Thanks again for the review and for keeping this moving!
>>
>> Best regards,
>> Zhiwei
>>>
>>> Cheers,
>>> Daniel
>>>
>>> On 7/23/2026 5:03 PM, LIU Zhiwei wrote:
>>>> This patch set introduces support for the RISC-V Smsdid and Smmpt
>>>> (Supervisor Domain Identifier and Memory Protection Table) extensions
>>>> v0.4.9(https://github.com/riscv/riscv-smmtt/releases/tag/v0.4.9).
>>>> Smmpt provides a hardware mechanism for fine-grained memory protection,
>>>> checked after address translation, which is particularly useful for
>>>> supervisor-level sandboxing and security monitoring.
>>>>
>>>> The rfc patch set:
>>>> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
>>>>
>>>> Rahul Pathak is working on SMMPT OpenSBI support -
>>>> https://lists.infradead.org/pipermail/opensbi/2026-July/010235.html
>>>>
>>>> based on his QEMU SMMPT branch -
>>>> https://github.com/pathakraul/qemu/tree/rpathak_smmpt_v1
>>>>
>>>> As we all agree -
>>>> https://patchew.org/QEMU/20260715145016.17369-1-zhiwei._5Fliu@linux.alibaba.com/
>>>>
>>>> , we will collaborate on this work and not duplicate efforts. Rahul will
>>>> focus on OpenSBI upstream and I will update the QEMU patch set to v8.
>>>>
>>>> Xiangyi will review the OpenSBI SMMPT patch set and may collaborate to
>>>> upstream the other parts, such as SMSDIA and IOMPT.
>>>>
>>>> v7->v8:
>>>>       1. Update the mfence.pa and minval.pa instruction encodings to
>>>> match the
>>>>          upstream riscv-opcodes definition
>>>>          (https://github.com/riscv/riscv-opcodes/pull/389/): mfence.pa
>>>> now uses
>>>>          funct7=0b0011001 and minval.pa uses funct7=0b0011011. The
>>>> decoder,
>>>>          disassembler and the system test are updated accordingly.
>>>>
>>>> v6->v7:
>>>>       The implementation is updated from the v0.3.4 specification to
>>>>       v0.4.9. The main changes are:
>>>>       1. Update the mmpt CSR number to 0x382 and msdcfg to 0x74E.
>>>>       2. Update the mmpt register layout: the SDID and PPN field
>>>> positions
>>>>          changed and the RV64 PPN is now 44 bits.
>>>>       3. Rework the MPTE format: the N (NAPOT) bit now lives at bit 2,
>>>> the
>>>>          non-leaf NAPOT form is removed, NAPOT leaf entries encode a
>>>> single
>>>>          XWR tuple plus a G granularity field, and non-NAPOT leaf entries
>>>>          hold per-page XWR tuples.
>>>>       4. Treat XWR=000 as "no access" and a non-leaf entry with N=1 as a
>>>>          fault.
>>>>       5. Enforce the Smmpt64 root-table PPN alignment (low 3 bits zero).
>>>>       6. Rename the fence instructions mfence.spa/minval.spa to
>>>>          mfence.pa/minval.pa.
>>>>       7. Drop stale Reviewed-by tags on the substantially reworked
>>>> patches.
>>>>       8. Introduce the configurable "smmpt-sdidlen" CPU property.
>>>>       9. Add disassembly support for the Smmpt.
>>>>       10. Add bare-metal M-mode system tests.
>>>>       11. Rebase to master.
>>>>
>>>> v5->v6:
>>>>       1. Use explicitly bit fields extract instead of mpte_union_t.
>>>>       2. Use the same exception behavior for MPT valiation as PMP
>>>>          valiation.
>>>>       3. Use PAGE_* instead of MPT_ACCESS_* as they have same value.
>>>>       4. Use address_space_*_le instead of address_space_* for SMMPT.
>>>>       5. Only print SMMPT address check log when SMMPT is enabled.
>>>>       6. Add implied rule for SMMPT as it depends on SMSDID.
>>>>       7. Rebase to master.
>>>>
>>>> v4->v5:
>>>>       1. Rebase to master.
>>>> v3->v4:
>>>>       1. Add missing review tags.
>>>> v2->v3:
>>>>       1. Fix build error in patch 2.
>>>>       2. Rebase to master.
>>>>
>>>> rfc->v2:
>>>>       1. When ext_smmpt is false or BARE mode, make other fields in mmpt
>>>>          CSR zero.
>>>>       2. Add patch 5 to fix smrnmi ISA string order.
>>>>       3. Fix patch 6 smmpt and smsdid ISA string order.
>>>>       4. Make smmpt and smsdid experiment extensions.
>>>>       5. Add review tags.
>>>>
>>>> LIU Zhiwei (11):
>>>>     target/riscv: Add basic definitions and CSRs for SMMPT
>>>>     target/riscv: Add smmpt-sdidlen property for the mmpt SDID field
>>>>     target/riscv: Implement core SMMPT lookup logic
>>>>     target/riscv: Integrate SMMPT checks into MMU and TLB fill
>>>>     target/riscv: Implement SMMPT fence instructions
>>>>     target/riscv: Fix smrnmi isa alphabetical order
>>>>     target/riscv: Add disassembly for Smmpt instructions and CSRs
>>>>     target/riscv: Enable SMMPT extension
>>>>     target/riscv: Add system test for SMMPT extension
>>>>     target/riscv: Add system tests for Smmpt52 and Smmpt64
>>>>     target/riscv: Add system test for Smmpt34
>>>>
>>>>    disas/riscv.c                                 |   9 +-
>>>>    target/riscv/cpu.c                            |  60 +++-
>>>>    target/riscv/cpu.h                            |   8 +
>>>>    target/riscv/cpu_bits.h                       |  27 ++
>>>>    target/riscv/cpu_cfg_fields.h.inc             |   3 +
>>>>    target/riscv/insn32.decode                    |   2 +
>>>>    target/riscv/meson.build                      |   1 +
>>>>    target/riscv/riscv_smmpt.c                    | 339 ++++++++++++++++++
>>>>    target/riscv/riscv_smmpt.h                    |  26 ++
>>>>    target/riscv/tcg/cpu_helper.c                 | 119 +++++-
>>>>    target/riscv/tcg/csr.c                        | 106 ++++++
>>>>    .../tcg/insn_trans/trans_privileged.c.inc     |  30 ++
>>>>    target/riscv/tcg/pmp.h                        |   3 +
>>>>    tests/tcg/riscv64/Makefile.softmmu-target     |  12 +
>>>>    tests/tcg/riscv64/smmpt-common.S              | 257 +++++++++++++
>>>>    tests/tcg/riscv64/test-smmpt.S                |  85 +++++
>>>>    tests/tcg/riscv64/test-smmpt34.S              |  97 +++++
>>>>    tests/tcg/riscv64/test-smmpt52.S              |  91 +++++
>>>>    tests/tcg/riscv64/test-smmpt64.S              |  98 +++++
>>>>    19 files changed, 1354 insertions(+), 19 deletions(-)
>>>>    create mode 100644 target/riscv/riscv_smmpt.c
>>>>    create mode 100644 target/riscv/riscv_smmpt.h
>>>>    create mode 100644 tests/tcg/riscv64/smmpt-common.S
>>>>    create mode 100644 tests/tcg/riscv64/test-smmpt.S
>>>>    create mode 100644 tests/tcg/riscv64/test-smmpt34.S
>>>>    create mode 100644 tests/tcg/riscv64/test-smmpt52.S
>>>>    create mode 100644 tests/tcg/riscv64/test-smmpt64.S
>>>>
>>>>
>>>> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
>>>


