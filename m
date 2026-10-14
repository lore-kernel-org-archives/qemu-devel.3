Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F42CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 00:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGn1x-0005Pb-EZ; Tue, 13 Oct 2026 20:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGn1v-0005PR-Q5
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:39:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGn1u-0002sG-4J
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:39:39 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DKHfAN1460097
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b25oxHVMCbZtyuee+iyDIy1c8MxAxd/R4JzybGQkMzM=; b=YDm30kN8oTJWQpaQ
 I3OAgXeW9olneEfMFnNCYTcMEB7ZLkpr7VaMHn10LbVcMykpKujtUh6I9t+fx7WT
 J3j4GGWni5euT33YjH2plWu+OiJS+VA66jG294jxB14+PYNRw5KFw1c+2qh6MyS0
 eIkPparnwgjM00omKxVkIxI/vOrbFASa6e31/Uwrop/Tb8e9xWya61ygNFg/xNIg
 3HF1j82FVQE1fF47Gvw1WDLabESIQGx3+BYkMfG6U9fphdiofmf2mzy72JTgXoqa
 Mt5+dBZA/WQAc+uJ6Lc414uWROoTeMpZuNG7xqtnatz39KiQlyZmh0VHh3/yADHA
 dkvQdA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjuqe9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:39:35 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-816cd7b7838so4910786a34.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 17:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791938374; x=1792543174; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b25oxHVMCbZtyuee+iyDIy1c8MxAxd/R4JzybGQkMzM=;
 b=TAa5otSyrGutHOKJqkYlAXuOA908Kh9SH+QHc+ZimAhkkJJH0V46z285prklhntjpE
 VGwp3DZBCe7c8yM3sGOMR3zqnd/dSrEW7Y44XaDdsBHYHCCODRrR+BvxI2ibE3ABUnaB
 5o03G2ZHoWL7zMsB7L/5Aarp0Yr+BHdQf5b1vM98+sfeltiZPi7YImFpOqQEwpE03hK5
 aLsIgBGFkfC0AtHI79gtoG6k9dX4GSKrY+UcnFN4cW3FOXLYQnlSe91DpSk/ozygSXzo
 mZGWunZZDEGaE2mOOv8odKJm4WUK/ZOFKC5vkErdp/FAvfQ2pn2gHvGVScWRVrvXM2Ak
 v7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791938374; x=1792543174;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b25oxHVMCbZtyuee+iyDIy1c8MxAxd/R4JzybGQkMzM=;
 b=PZ0ES1pZIuShJ05kHM/QSFVHrJWpQfGuVo9GaQxm/IhHqiOBpc4ljbVRlG1yhBvly5
 ay41r/fTTZE45s0F6/jAFJs3Mx5FWXC0FemJ6NGFacdpBAgoL78gbLb34+B4lrfawEhO
 Uhq+IqyIoEcdsxuwNkHM55m6927Pl8QcCQKOEE8F5OyEIN2qU3WZuMa+0zxgJb2UjioF
 uCnpbt8MiujK8hpD+319pQiBMgtAwcAX+FMfpyTuz9hLYGmziFfsYgB/K9pa2gSi44HI
 lwhTenJyOsq9h20FP4ygJ/BaHUL1dfqfYzh0MQDCmYM93JMDtdVPn/0y2iVzt4JDr/eT
 1bLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlyQNwHT6H24CVwtyNh3vmAOAFgIkuRAuLvHSuLUodwVgh0gL55NePdSguFsxqYV6u6zLBDMAc40AA@nongnu.org
X-Gm-Message-State: AFq9FYKcfeEkYSlMyQxa/z/NsKc0oCf6JijkOKPJJq9i75/NsqTzTiji
 gETaKtesRoUL2n8XadCyM+sfUBvkG3CvDzeVoyk3h/JVtglMncsr6hLuke3RhrWRxKn1oBaX1Ma
 HTKoodAai2hpAs1+1T58UxUJkHfUqkwOL8A+6FlDJ6crd/qgprJT3z0YbwQ==
X-Gm-Gg: AYBFou1NlmsW7vUJV3wzRZD9EKeOUm8vRp5XKH1HJlXyffsaVPqqOpMvN+kKRJIiCXI
 k0sCivhY2VHomUnniDmfFGNZhnlYfHhBVFMKDdQXcr3F1xkyp71jKvMb1pJd5lFYOPDq282RuIV
 B3ANX9Tdl6W1nUS9SC8rn0xn5Si8LrAgUjNUep2/Kpthpsd+Gd2CqwI1pakdwqd8VRK0O07SzNy
 0tgKQGUIAK/dpF0a3XW1lApWnu2ZwvZWydTGdCHKtqEXX1+haCZSdlPqpEd0cJ57991vkg3IK7c
 GV/ytkJx03wMjdp+LhMXpiv6MW6ywalvj/e0xVE02X5Y+VJ+C081aPZDIRhgPSPFOaLeS+czvQ9
 GSJUI46aDI2S09Ipu/upxUq38X+ryHrXqL0oFNsJWriSkYz9KoiWf8NcSy/13vh/syg==
X-Received: by 2002:a4a:e847:0:b0:6ca:7a04:ee31 with SMTP id
 006d021491bc7-6ef10293009mr10557526eaf.64.1791938374449; 
 Tue, 13 Oct 2026 17:39:34 -0700 (PDT)
X-Received: by 2002:a4a:e847:0:b0:6ca:7a04:ee31 with SMTP id
 006d021491bc7-6ef10293009mr10557510eaf.64.1791938373891; 
 Tue, 13 Oct 2026 17:39:33 -0700 (PDT)
Received: from ?IPV6:2600:100c:b088:78be:8d58:2241:3c5e:b479?
 ([2600:100c:b088:78be:8d58:2241:3c5e:b479])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8367ada5b6fsm7269751a34.21.2026.10.13.17.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 17:39:33 -0700 (PDT)
Message-ID: <cfa6d466-c686-4693-a3b3-7f754b4ba906@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 19:39:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/hexagon: model PCYCLE counter
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009003521.2227155-1-brian.cain@oss.qualcomm.com>
 <20261009003521.2227155-2-brian.cain@oss.qualcomm.com>
 <cf93c914-b533-4468-bea1-b0cecdd3fa93@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <cf93c914-b533-4468-bea1-b0cecdd3fa93@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwMSBTYWx0ZWRfX1WN0gekvA9ee
 +u9mpDu3IhbEsEb0EXLLXDeOdgeZbiMFyZxJwdNFP/JeoR5g53gTXTd9vx+Z3d2Y7Jj7EtsfsxL
 P1RK9CsbV+1n3KL2G7boDV8Q1shhhKo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwMSBTYWx0ZWRfX1BjRLa4NhH05
 qUHoIVelL7RXn3g2ZqDt+c7JbIrnxU2tMwtfa4TgI1TJL++oS2Y1oYQ/vCvKElpNJm0Hlj4DjQB
 JniVQvkHe9v7zztau0ihfoSf7JMTxhk/3kk1VmDnWksolA9byVtWWmZ/FlU7skxWk7wKSG0Awtt
 dLEfGYsWEG7icJC3SGkKPO5shhN27CS4xvAjxuafOILNdqcNTbx5AY1hyfPovD8Z97MeOgEif3C
 TXHIks7F38CuenPaSJ6ETuq5c4tiGcsKebFr2LPKXlN0M3UB1JvQhhhAJCaRqAI9giXaHsIDI1B
 b2YVuoAFRuYm28MU65rdeVltlG3HaEkFmksUWqJG1PRGV7q3gMYes+WrgVujcj1uhRx4vFXK0b7
 /h5qQv44yV0hi6y4zigCRAdhoeacEiqm+v/qbz/bVi0hyVLA9ymozGKZV+y8ujQ3klu8m0NWEJ7
 GdRnTbEglyKojornSpQ==
X-Proofpoint-ORIG-GUID: 7gEjzYt4_V0zXWtnx2KiKrFbxJbo1isy
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6acecf47 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=FVcRC8pvBCZPXlR_89cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: 7gEjzYt4_V0zXWtnx2KiKrFbxJbo1isy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140001
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/13/2026 5:34 PM, Pierrick Bouvier wrote:
> On 10/8/2026 5:35 PM, Brian Cain wrote:
>> {U,G,}PCYCLE now use a shared virtual-clock counter.  This is closer to how
>> the real PCYCLE behaves and avoids the extra work that was being done on
>> every single TB.
>>
>> Handle SYSCFG.PCYCLEEN and the semihosting PCYCLE read.
>>
>> Remove the work-in-progress implementation that summed the TB instructions
>> into a counter.
>>
>  From what I understand, PCYCLE is different from RDTSC (x86) or
> CNTVCT_EL0 (aarch64) since it tracks cycles per thread, compared to

https://docs.qualcomm.com/doc/80-N2040-60/topic/registers.html#cycle-count-registers

PCYCLE is a global (per-core) cycle counter, not per-thread.  The WIP 
implementation accumulated counts of packets per TB during that TB 
(accounting for just that thread's activity).  The previous 
implementation on our fork summed the counters among vCPUs on PCYCLE 
register reads.  This was "good enough" for a first generation but is a 
less appropriate model than provided in this series and required more 
work with every TB.  The one nice thing was that it was stable and 
consistent among hosts.


> globals ticks on cpu, independently of its frequency.
> Pushing a bit further, I also see that aarch64 has PMCCNTR_EL0, which
> models something similar to PCYCLE.
>
> In the case of aarch64, it's implemented based on time also, so hexagon
> mimics this approach.
>
> ```
> static uint64_t cycles_get_count(CPUARMState *env)
> {
> #ifndef CONFIG_USER_ONLY
>      return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
>                     ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> #else
>      return cpu_get_host_ticks();
> #endif
> }
> ```
>
> So, since we are not accurate anyway, and depend on host cpu speed
> through time elapsed, is there any reason to have a pcycle_freq_hz
> property instead of a fixed number?
>
> ---

That property was sort of an "apology" to any user who might long for 
the stability of the implementation on the fork - allowing them to 
calibrate as needed.  I am definitely not attached to it and happy to 
get rid of it.


>
> The rest looks good to me. It would be slightly easier to see the change
> by removing the count based wip first, and then introduce the time based
> implementation, but it's not a big deal.


Good idea - will do.

> Regards,
> Pierrick

