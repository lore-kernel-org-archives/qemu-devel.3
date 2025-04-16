Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515E6C369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 22:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5B91-0003l8-9B; Wed, 16 Apr 2025 18:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u5B8x-0003kR-Oh
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 18:22:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u5B8s-0004Vw-N0
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 18:22:07 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GMClN3029865
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 22:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VfVX2hChdpurMnWs0ch/YfAOFlOSIjJmbLVcelvDqFQ=; b=MIkf/E+yLmwDnwY+
 puj3Iu3xX+GtW6UCfEyHPx+1E1eVDNEuWfl78ChriovHABmRXGNHdhEcHSC96Usg
 ekGE3AsiHyULObqAL7xMpWsLKluQBIwE7ZUx7Ljnz+rmcG3gqPJnV3cN6vf7erIh
 Bi08thAPaM++Ibq8VQhFFvg6HL9y5MvfCNhTFZChanjJFnUw90tuwtZECQJFLCFl
 yGGHyhw3SLJZ8GTrIC3QI70nnL3FpZzTGGRCNvhEyyYH3J0XZTZ59sRffYNGZeR3
 ZltGG+RqaUsobbhlfynq7+FFsbXZ3yKAGs2OlncJgZz9aYUIVdkSNI5LkTVRawc3
 1jO+AQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxk4u7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 22:21:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2265a09dbfcso3200285ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 15:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744842117; x=1745446917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VfVX2hChdpurMnWs0ch/YfAOFlOSIjJmbLVcelvDqFQ=;
 b=TQx+nine2/qpQ7lK+5rpEOHfmmmXlNN+mBJG1DZgJh9pQ8b7T1/Bzf7R1ezE8R2kKI
 sI5IGamuOqbFhBZ1YO6JhMLj/KHIYMtYcg4OqJKPiXafMoUYBSajyYBKHPFEoipgPeTd
 qI1q5wlt+j7M9ENVqfibL5wF1gezpPgmgp4Ueq/cawEn531u3aL33QHJKwhIRspJEUnZ
 OkjdP3Tz3zB0mH6APRa7rOeYGDfIhJT1APh6TJidZgG2vpzSNjePnZhImefeuQ33svM6
 KIWRLTT3WxuvryuTDuRXseOi+saVKrILQZqzv/TipnBo4C3MajGLBH2yCJqqk5NPDrLv
 enAA==
X-Gm-Message-State: AOJu0Yy3Dh5pd2DugCawbMcnUCY1/qBVQC/rlZfFMFcSahTJwqTPYiRr
 mAl+Kxpz9JkMYEvzp2x6G0nVk5eVWFpj+nlZr3AyTC4qrbU9gDe93zJw//UXhYs3PDb4FnIeeoZ
 8QeJAQQ2HeYHLZK7DDqSo2CNdlZPkxvEAbEiK9QE78YOJ2jw47/tzHDsIcH8Hjg==
X-Gm-Gg: ASbGncuTB0sHWLYp5TeqexF0MYk/+amimlyUotiOsv3fhAlNwqfYOXOiuhegsoRe9Z2
 3jFZd0N4kOE/l9BgpvdcgQAfpflAtcX8dp60eccQL7dBs2e7hZjR7uCcp+n+q+KK5jWXg+nKmce
 E3IQq/Wj10bM/OXbgh4x4EOrnwTYly+2CC1vebcw9oU7gRiHRWjRqh+BUyWZy6vOplf5FdjnsD+
 HQetGAu67UI4SeNNdLOhJsYEuyuc5WV48Di5dX2EG7NzcZl4bHPytPQVisCoL0kHjcoPeBXbC+o
 JOlShUxf3s/TkCiS3WpRBnvuNUlBWbeStyDSLcgGLDoD9Ge47E7qDGnq3vTmBpNB6LNuvF+Jpfc
 =
X-Received: by 2002:a17:902:ea09:b0:220:c813:dfcc with SMTP id
 d9443c01a7336-22c35974249mr58364435ad.40.1744842116983; 
 Wed, 16 Apr 2025 15:21:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT7RbTLjoLxE+PuUxjNGKYmKLFANwaqWolYpnL9p4pHYingg8sHQx5FYdZv2TRdpy8nuwrvQ==
X-Received: by 2002:a17:902:ea09:b0:220:c813:dfcc with SMTP id
 d9443c01a7336-22c35974249mr58364225ad.40.1744842116587; 
 Wed, 16 Apr 2025 15:21:56 -0700 (PDT)
Received: from [192.168.68.69] (syn-068-203-003-122.res.spectrum.com.
 [68.203.3.122]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33ef1182sm19757585ad.25.2025.04.16.15.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 15:21:56 -0700 (PDT)
Message-ID: <b8f2eb78-1cc6-4d82-8597-6d994a6a6f66@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 17:21:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] target/hexagon: Remove unreachable
To: ltaylorsimpson@gmail.com,
 'Matheus Tavares Bernardino' <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, marco.liebel@oss.qualcomm.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
References: <058801dbad61_68ff5b00_3afe1100_@gmail.com>
 <20250414180939.3575845-1-matheus.bernardino@oss.qualcomm.com>
 <05df01dbad80$17e73890$47b5a9b0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <05df01dbad80$17e73890$47b5a9b0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=68002d86 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=wZFxLTZBfD+s2kw6STbl6w==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=FrtiAJNx-cGySAwIHTgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pjgZZZwhnzVRIg1TEEtkdS6ezUCJx5rF
X-Proofpoint-ORIG-GUID: pjgZZZwhnzVRIg1TEEtkdS6ezUCJx5rF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_09,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=981 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160179
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 4/14/2025 3:59 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Matheus Tavares Bernardino
>> <matheus.bernardino@oss.qualcomm.com>
>> Sent: Monday, April 14, 2025 12:10 PM
>> To: ltaylorsimpson@gmail.com
>> Cc: brian.cain@oss.qualcomm.com; qemu-devel@nongnu.org;
>> richard.henderson@linaro.org; philmd@linaro.org;
>> matheus.bernardino@oss.qualcomm.com; ale@rev.ng; anjo@rev.ng;
>> marco.liebel@oss.qualcomm.com; alex.bennee@linaro.org;
>> quic_mburton@quicinc.com; sidneym@quicinc.com
>> Subject: RE: [PATCH v3 5/5] target/hexagon: Remove unreachable
>>
>> On Mon, 14 Apr 2025 11:19:38 -0600 <ltaylorsimpson@gmail.com> wrote:
>>>> -----Original Message-----
>>>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> Sent: Monday, April 7, 2025 1:27 PM
>>>> To: qemu-devel@nongnu.org
>>>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>>>> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com;
>> ale@rev.ng;
>>>> anjo@rev.ng; marco.liebel@oss.qualcomm.com;
>>>> ltaylorsimpson@gmail.com; alex.bennee@linaro.org;
>>>> quic_mburton@quicinc.com; sidneym@quicinc.com
>>>> Subject: [PATCH v3 5/5] target/hexagon: Remove unreachable
>>>>
>>>> We should raise an exception in the event that we encounter a packet
>>>> that can't be correctly decoded, not fault.
>>>>
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>   target/hexagon/decode.c | 6 +++++-
>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c index
>>>> b5ece60450..1db7f1950f 100644
>>>> --- a/target/hexagon/decode.c
>>>> +++ b/target/hexagon/decode.c
>>>> @@ -489,7 +489,6 @@ decode_insns(DisasContext *ctx, Insn *insn,
>>>> uint32_t
>>>> encoding)
>>>>               insn->iclass = iclass_bits(encoding);
>>>>               return 1;
>>>>           }
>>>> -        g_assert_not_reached();
>>>>       } else {
>>>>           uint32_t iclass = get_duplex_iclass(encoding);
>>>>           unsigned int slot0_subinsn = get_slot0_subinsn(encoding);
>>>> @@ -512,6
>>>> +511,11 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t
>>>> +encoding)
>>>>           }
>>>>           g_assert_not_reached();
>>> Why leave this one rather than raising an exception?
>> Good point. I think this one should be removed as well. We have removed it
>> downstream already.


Taylor, is it satisfactory to include that update in a subsequent patch 
series?  Or should this one replace the second unreachable too?


>>
>>>>       }
>>>> +    /*
>>>> +     * invalid/unrecognized opcode; return 1 and let gen_insn() raise
> an
>>>> +     * exception when it sees this empty insn.
>>>> +     */
>>>> +    return 1;
>>> You should set insn->generate to NULL if you want to guarantee that
>>> gen_insn will raise an exception.
>> The caller already memset's it to 0 before passing `insn` down.
>>
>>> Do you have a test case for this?
>> We do have a softmmu test for this downstream. Maybe we can adjust it for
>> user-mode and upstream it with this patch.
> Take a look at tests/tcg/hexagon/invalid-slots.c to see how to do this in
> linux-user mode.  You'll also need to modify Makefile.target in that
> directory.


Matheus provided a linux-user test offline.  I'll include it in an 
updated patch.


>
> HTH,
> Taylor
>
>

