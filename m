Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345DEC5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 09:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvWuC-0005tP-Sy; Sun, 16 Aug 2026 05:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWuB-0005sZ-7R
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:11:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWu8-0001Fb-IB
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:11:46 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67G71lSt2346945
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KdbNQUou+xQoWZZSBwZEMOBzSbgSNuXhzX8u77iLeBY=; b=Dq1gK66fPLMQstb4
 p9bfLTqjlIlDrp+zLcpgygfxRY6Wg+3+D6UskjX3lz+ftVXCtS4c21U1QP10Ybbz
 tQckLB9FnMg+96uxF9qNGD8g8D1Y3EOsUXx04VX8w9/c9Ane/2yaEpGaZi7F5d7d
 NahyaQN7M5vJ3oANBRrhXGou4gVWLUDTMB+hunWPCoVaUI9aa/iyJQH0flIDBSYj
 pgyEd95z2jNg2Cjd/4r7J7QS6iGYNnvdtqDCQFLcgxHkNqJVcQC3Fr5E6u/T6aFl
 XLyGBTVQCJz/sgzgHY9z865K8+P2OuLM23oJ1yqkV9hFowQQCpdqayaWTP9u+27P
 htnpZw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2hd7u0df-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:11:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d7b3adda4so24156101cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786871502; x=1787476302; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KdbNQUou+xQoWZZSBwZEMOBzSbgSNuXhzX8u77iLeBY=;
 b=JSol/F1tpRMOLf0rn2LRTJ1CtRLvTbymMVqAwwUfsh+mB/XfmVNw/KzW1XhgFPMuoo
 50XAe2Cb4nYhv7rPGxTVsmAPButk0PHbAN7tlpuCMg+Ar+D+XzXEB7m2klnUhg5NfwZF
 /m3ThCDUMtsvzwsUMUxOwnm0dQ4ILycurFRuDtfko8SECQR0765LrJkHKiL+TcOlFN+E
 AgE0Vu/rOmInL964HSkq3jkFI5RefwvLqX9M8LsUHsJYPEOas0a6PJDJ+cj1nTiXeY24
 R+RfOns4J71nls3kwhCJ2jozn64ewWgT2Od4HPCZtC1UTBLXpThszXNjMbE6inGiy9jW
 ioXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786871502; x=1787476302;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KdbNQUou+xQoWZZSBwZEMOBzSbgSNuXhzX8u77iLeBY=;
 b=iPefegdD0zSryd4wxpnghXUYm3fy2VCrskKn5Fd+PUVDGv3NoVU9k1pVllpLO54T+r
 1JnrpPZLQnxYDiiij8vrWyCh/rwWuIIjSu6DdCQIQgpdFRz6a47eyLDvYSxxHJGQPW37
 OmUkS7JCZZ7bf5x02psxm611NedxN54QkY5OBx5OUkQNXzMCjyPicLX5231fo4uWGfz6
 f8snSLc/yraounheULNHkpE1aKwpKxAZEQnNy3thOmnO4ramxDChKCDKbBdJNdLlTmpt
 ITDpe+AHMIV6NzG/UOLqpuzJFoYCC5ibkIsthcPu4JAwIpefAH3CRd06N34Giyom1x+w
 jzDg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq10V+Xv3vz/BQMwuG9M/6ktfyZAv9ldDQTJ2CC2nPTntxXYMzCddwO/QWo5NDGcWWOAGsDeO7N6II/@nongnu.org
X-Gm-Message-State: AOJu0YxZCkSLKAp0guS6mSVt9a5LM7sF+KkQuAdEJklLgmsF40X9JhRP
 ZtMVW1s/34J+IY+6nxTrElHEmELKrd21vJVwkixMPpPYKsRwKZvrFglo8l150zA53pucjAIBCAB
 6HaYu2W6ux5HtIs+a3lmTJCfqqmxsaAm/wiVZTPRdQ9+ljkVTF9U//ISFuQ==
X-Gm-Gg: AR+sD10GEfXanFu4NjH5khNL7f2DRsdvDN+VjWzLBuw1i26oPAJ2BPMBJZqW9eB5fDe
 7ZvhcQEo3FuFEq5LxGPgetRl5AiwIkIHSP/5VrxSgdT73tSGpa9UcJvQMLlu8oNQ3MIiD4JUPmV
 bvMgkxmnVU5Lblj0Fiv7wGVp3kn9Z+wyWvkQv8N06tcFCz8KadT7ZztAkR4wRd8uZyfQvUq+bCs
 MIHLmwEFhCvNhuPXvAkiGdIsdfZihwg6TDx8OTh//0sTx+sblWpt3bf02qHspdhg7a2sjn1PeV1
 tKl/D3NHexJQZgdRMuDtthMsHhIwEb9R/I5f2ZZWSNkAckC7s2MAy6YGLd74OC2Ma+IbrOD2yUJ
 cS/WTEZt33NGJcc2tnm36Ysbd8SszdTBtY0o=
X-Received: by 2002:ac8:5fcd:0:b0:51c:167d:b346 with SMTP id
 d75a77b69052e-52d85420e12mr167004541cf.23.1786871501670; 
 Sun, 16 Aug 2026 02:11:41 -0700 (PDT)
X-Received: by 2002:ac8:5fcd:0:b0:51c:167d:b346 with SMTP id
 d75a77b69052e-52d85420e12mr167004281cf.23.1786871501309; 
 Sun, 16 Aug 2026 02:11:41 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996108141sm27335365e9.6.2026.08.16.02.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 02:11:40 -0700 (PDT)
Message-ID: <6a6b6a70-1558-4fb3-a0f4-87958a350b72@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 11:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/18] accel/tcg: Replace size with first/last in
 probe_access_full
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-8-richard.henderson@linaro.org>
 <2875df0a-d000-46fa-a8e9-22aadf102a7b@oss.qualcomm.com>
In-Reply-To: <2875df0a-d000-46fa-a8e9-22aadf102a7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA2OCBTYWx0ZWRfX6weuzAk9L/fZ
 OpmiyNZIcc+b31t2U+PjroX5F1HSQCxdLbHeoa2GhxtL38C9nf3SwyEQ2Hf+AEnBHfEUXDpfH+e
 4tZTUDI5YUKL2RYVujDmqafuROoXUkyABCDZpD1jDQor7c8GQcnTyM3RoICvpvuOxi8U42wDeAA
 iNxAMl7HD3is+7fqtg8thrCZ32fZOeGFAI1wlbB+fPbUJFbGeCOMy1t8U2eU3OzQw+3LY2LhD0j
 +f5I8jMOGUuC/SwRp4sz8Rv2dHIAgmbjBl00awhgU11FsvUXf8IGOkYuQXPFKy3vnxtXJp2HLI/
 82wLzOcpivVRCWlfFw5gInsXmdw3nJ0v57kITvrlR/Ze+EHkBscX1ZYk4Z0iFVxHlKe1TDG+jYt
 guTcbJF9kwK1BLoNSmyRZJ5SSSftFwiTSxuWP2AZXdUqvFg05k4t3xJ6dZWLXO4OcNJHyxAeJPk
 Krk59LNciAupp39prfQ==
X-Proofpoint-GUID: 4J6QbnzQcZt1txk6cEoMvGcp-F0SjEC8
X-Authority-Analysis: v=2.4 cv=Ja2Ma0KV c=1 sm=1 tr=0 ts=6a817ece cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bdvilYR6Lf0MEp-pbN8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 4J6QbnzQcZt1txk6cEoMvGcp-F0SjEC8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDA2OCBTYWx0ZWRfX0qCxMZN/haiO
 QYMFmyLFQ5H1EoAgkxZ1iyANM4dqPFmCugYaw2VgZd1HxCB6cVxvkr3dsbOS9MdBD7XLvA8yxuN
 Dfe9jRPSqd6hucCD3kmk7racyKdOPGM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/8/26 11:09, Philippe Mathieu-DaudÃ© wrote:
> On 15/8/26 22:37, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/accel/tcg/probe.h     |  2 +-
>>   accel/tcg/cputlb.c            | 17 +++++++++++------
>>   target/arm/tcg/helper-a64.c   |  5 ++++-
>>   target/arm/tcg/mte_helper.c   | 21 ++++++++++++---------
>>   target/arm/tcg/sve_helper.c   |  5 ++++-
>>   target/mips/tcg/ldst_helper.c |  4 ++--
>>   6 files changed, 34 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
>> index 0b788901ba..e3068a79de 100644
>> --- a/include/accel/tcg/probe.h
>> +++ b/include/accel/tcg/probe.h
>> @@ -86,7 +86,7 @@ int probe_access_flags(CPUArchState *env, vaddr 
>> addr, int size,
>>    * This function will return TLB_MMIO in order to force the access
>>    * to be handled out-of-line if plugins wish to instrument the access.
>>    */
>> -int probe_access_full(CPUArchState *env, vaddr addr, int size,
>> +int probe_access_full(CPUArchState *env, vaddr addr, vaddr first, 
>> vaddr last,
> 
> I prefer this clearer first/last range API, it feels safer.
> 
> Missing updating the docstring, otherwise:

I now see this is done in the following patch. Maybe amend

"the probe_access_full() docstring will be updated in the next commit"?
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
>>                         MMUAccessType access_type, int mmu_idx,
>>                         bool nonfault, void **phost,
>>                         CPUTLBEntryFull **pfull, uintptr_t retaddr);
> 


