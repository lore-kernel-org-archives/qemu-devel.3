Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CA7C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whCDG-0008Go-SV; Tue, 07 Jul 2026 16:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whCDE-0008GV-G7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:16:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whCDC-000710-F7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:16:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5TbI370302
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 20:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zg7/s43Zhkaxcp5cxO2ln+GhAsdGSuALODlH3V4nVFU=; b=OHC1yh3lyh2CpOoP
 N2uffpDNpeU3ShjP1TpEUzO0U3WwVjTNnabeDd3I5RI5xRY3QOvLmEdbJqW0KhWM
 2iaw0actAaFy79T8EcKAPkSDfXJpfunp0RV5BFutevic4lRbwYSw1VxOqwFMsfsB
 mXvwwXvIcHiKfk85Z+syFzokmMYLUawcuufkFo5bIzdfQQ8Q9FmQlnxVzOJzZf5j
 5GLb3Pt4lxGhFT3wmC6kQuCaNUZ2ZHNJi25mYpYjhk7hqZeMGfdgtoBtKG8oOInC
 d3L208+7dgNAnb0cRBeOh486QNvcQXinjkbHXGat6DVW9H0cebWCzXklWHCVkhde
 yAJO2Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun38je-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 20:16:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c20762d21so56690751cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783455367; x=1784060167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zg7/s43Zhkaxcp5cxO2ln+GhAsdGSuALODlH3V4nVFU=;
 b=VHa1yetj/f/LC8cZZ8cg2YbZab40OnubrDetXeUne0D8nNQNGEQdmXSB4bEkgv0ZER
 knq113vLTKC9ub96SwJy/wOqnJk0kleoOrbIirTeO+QhGEDGe7EFCWUILnB1BGmpYPUi
 tnz9yRCzkCCzrAyPSIFEVv2qgSdmkVNQ/XLVrhtl1wby/m7KHuqJwqGtjmPtbkvlzb0j
 UsMvgOb9mXB7M+7GORwEl5Z+qzT4n6E1fWXawjDCKlaOOB1zexUHbxAQjXEI5ZnD0Z9O
 uJtiWg99hPS+P7ZhL9kVdq37mqIYVJmtTeQEZX7PBaQIgN5aj4WPZXCaN+4bzfRecBPO
 rneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783455367; x=1784060167;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zg7/s43Zhkaxcp5cxO2ln+GhAsdGSuALODlH3V4nVFU=;
 b=JqJK+LshkCeVAetnIddSEvXmmkB1b29XhbGCWm24dXd3NBgD6luY2Z6S/ccfew8n/x
 A43sYalByjPlQ28b0NiN6WBe6MQVc00rK0ezkQWF//G0BiP2Ul6rE2zhoepBCoCf2iGC
 l/q+D5B+PfQh6k1z/an/DYNAcEcsEX12reQBEP0jQc0F9nc0nFvXxAd17hgk0Vx17Lv3
 wa+LgzuVx99Fkg/aRQZAzFYRe04KdUXXW4s9aj2XV21FzTwdns+potwqrYhBsJSmQWhU
 V+jtJn9WChmdLEDDlAjKWQBhjWk6HlMU4ETas+yiEPlvF8xoJAvnI2AY6XVJfLP9ImN1
 T6KQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqOhBmeh84oQcS5YSiPe/vFlH0ml1tzvlo0LvjJ4Cf0sBf03oOfAhJNW4q3zAT93aQkAp4Td0tA2vN@nongnu.org
X-Gm-Message-State: AOJu0Yx0YUTMfsSCCs3XVUZiNBolxcstoXnO02G+KFq/K1wSCTvqt2rs
 HVgd5eFSIFq2Vb3GmD1PpFiYSqB/G4JA3Xbj0fGrtTsM/qM9sHRnmjmk6vVKVwviDOl0iIDiwXk
 YtwFh/PwNS2WfEsfmQA+sACausbfWTs18didwaKktaern/ThcNBnyp3JJdjESKZyVPQ==
X-Gm-Gg: AfdE7ckmi3veayDak/ji5PuyoYYhnH7S8n3xKE4ycBlHQWmZRQIUoktI/NL2+6rsHNT
 2AJdSZ1jTroWZEuPrsMHN3KWSNzCzH23tPnglswvMPOXrqHH0xG31VDqzGJU3MIPVsxR+VpY7Px
 OJYsZJEiC/JQSKen/Za++u0lJ9Isxh5xYXAaze/wR9DcYtHM1/oLH7SH7PtCmwYLA8IBbSqSyFz
 4VIYfb48yZ5WPVEb+QeR5kzr9utzGuJwfkuJwS7tXU5TESouNnULQ/UXouk/Vy/VMYl0CcO1SZg
 wRXqI9O09kMumi+s2xYPKgY2clweAmvSRT6beFX93xXSdt+DgcLItwjfx/Kz+Alq7kr4zaneCAs
 dCJKA3h2I5zYceDlfLynwcXKgEUteIaJ+vy1/44Mpnx23orsUjkJstOmnk98ekw==
X-Received: by 2002:ac8:5882:0:b0:51c:140c:6893 with SMTP id
 d75a77b69052e-51c747a0318mr73249941cf.11.1783455366856; 
 Tue, 07 Jul 2026 13:16:06 -0700 (PDT)
X-Received: by 2002:ac8:5882:0:b0:51c:140c:6893 with SMTP id
 d75a77b69052e-51c747a0318mr73249361cf.11.1783455366176; 
 Tue, 07 Jul 2026 13:16:06 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f5bc78sm95370035e9.14.2026.07.07.13.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 13:16:05 -0700 (PDT)
Message-ID: <32491292-2ce2-4a16-b3a5-5061333e6e57@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 22:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Update cc_op for SAHF
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20260609002802.729485-1-richard.henderson@linaro.org>
 <922b316d-961f-4747-832b-c5e28bdaefa0@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <922b316d-961f-4747-832b-c5e28bdaefa0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE5OCBTYWx0ZWRfX3dwcsVnh8c0t
 GHJOy1JyAUV3tJJ0DIimRSk0j9vyWN8OHEweY34yrxy+E3hoaoMe3hIr1ZDZc5NVSVYDyxn+vMW
 5xJ6K3nA3dRkO0vaCJJqyEVk43+U9WM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE5OCBTYWx0ZWRfXzemFQHR5NuxX
 Ndl3S9QCXStDAw+4EGNa+JqJuCPfXST8awAYLgb0CfEKOxVAYk76fOC/vVWdW0oc5Zfecb1s4TJ
 iK8JwaXFVquinN+AtIXhRDgADDX9Uc8J4Y9bbbqDYFJfayA3/3DFC2PFs8r9H9yPmUSqayredkg
 46+bO0aGRlpRZ7hzy9Jka8nYbFhd8EnrbQnbCUPimLZsyZArS8/Yc4euXKobUalVV6n08MBOsEO
 FwFBs634tWJdS+r9Of0+2v43Ln8VEQEvQ9l7uOpJCfJkIpClKWILEXlEx4L7kF3eqzBvh8wdCEB
 3jaZ7mEz56Y7zFqIk3PdP9kxpQkzHJ/a5gM5kJ/4XjUxVzjxiV9r6rjqkMrzZv6ZzFPOGtx1Zja
 uwWc2graDE3zfnO5T/tLrrSnrj75KER6+bPNwJD56BFvw4Io1bJgfXsJhirXIIbhzaf2SsViB19
 dJe5YwjFL4WbPQT5LTA==
X-Proofpoint-GUID: xPfQADZvJ4kZN46_xDaV4Q_v7RI3HJe0
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4d5e88 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=5rtoZQs5WZ2IrnFbVLAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: xPfQADZvJ4kZN46_xDaV4Q_v7RI3HJe0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070198
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

Hi Richard,

(Maybe you didn't Cc'ed enough x86 experts?)

On 7/7/26 18:46, Richard Henderson wrote:
> Ping 3.

I don't think you are waiting a review from me, but in case it
helps to unlock you, I tried to review it but since x86 is not
my cup of tea at all I got lost with global registers use. Anyway
the overall change looks safe enough and indeed fix the issue
reported, so to the best of my x86 knowledge:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
> On 6/8/26 17:28, Richard Henderson wrote:
>> Removing the call to gen_compute_eflags meant we no longer
>> updated cc_op after computing EFLAGS.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: da7649c6aeef ("target/i386/tcg: do not compute all flags for 
>> SAHF")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3537
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/i386/tcg/emit.c.inc | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
>> index ce636b6c56..59948fe64d 100644
>> --- a/target/i386/tcg/emit.c.inc
>> +++ b/target/i386/tcg/emit.c.inc
>> @@ -3768,10 +3768,13 @@ static void gen_SAHF(DisasContext *s, 
>> X86DecodedInsn *decode)
>>           return gen_illegal_opcode(s);
>>       }
>>       tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
>> -    gen_neg_setcc(s, JCC_O << 1, cpu_cc_src);
>> -    tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
>> +    gen_neg_setcc(s, JCC_O << 1, s->T1);
>> +    tcg_gen_andi_tl(s->T1, s->T1, CC_O);
>>       tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
>> -    tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
>> +    tcg_gen_or_tl(s->T0, s->T0, s->T1);
>> +
>> +    decode->cc_src = s->T0;
>> +    decode->cc_op = CC_OP_EFLAGS;
>>   }
>>   static void gen_SALC(DisasContext *s, X86DecodedInsn *decode)
> 
> 


