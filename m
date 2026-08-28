Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F08C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvWr-0002jz-0S; Fri, 28 Aug 2026 08:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzvWp-0002j6-Ch
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:17:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzvWl-0006ve-K5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:17:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SA7cIa2744796
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 12:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YrvnOOqMvc6gCMX050RJEmkUu2li6R0MG2FkAVvyHSQ=; b=JlSwsGufEKFNHs15
 JRD4rbCGUFGMrE8NMjM2DXEfFjGzVBsVzqsGNJ3l4/1FfukjmQggo8K1o/etSzE+
 hmsMrIhN/X9exjrZir4bUqL05/dSIIFW/vPVlX7L0JJCdKmU/rDRY7VwyIYcWXoR
 btywIn90A3f6JTX1wx5g2ZOkAvFmbhu+Bm//JhWytVK05yzyympT1znhTajMlT+H
 4y0m1Lm4iMPC5SueU9DgcoTqEK+E6A1KsQDvD5W9Hb1Cwq3YZny8iu99oSw3y24p
 jDWR4p7R4bQnV9QALkiexF6cKawbbP2bkOYGB2i189USoNBSuPyi/T/EHHnTbqe6
 WZu8oA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mxsqxc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 12:17:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ec3146553so170270585a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787919465; x=1788524265; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YrvnOOqMvc6gCMX050RJEmkUu2li6R0MG2FkAVvyHSQ=;
 b=LW3y2NZFr7YSlYaSlXlDh7Yv9eOcb+nxvsaEeMeOgnM3zCuylGZSFe5+hKrR43rjXu
 LOYyGXYWA0VyejnfrrAEefePCiWFrs52vzQIhSc0wRlBpHGoJtLcz8SyZQhj7p5EyBdY
 2zxXFDE2jMbIS1NEGSKpHZ7Bb2CnVPqeaAcMIaXE59BrQkb3VY9q5NyjN5Ueoq9hBg1E
 hw8b21WtMRTTF1dhUwoouxI+/vNCH2l9Wr9yG+nozG3Vq706rQigzw6Lz5kk00ZGNkxk
 RT67FaqdrASfW0U8FZRhCbKqnNwb8AMETwiHtWuDIKiB9jAcV2elvFWDO8TiwtZ2Y7F9
 ybTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919465; x=1788524265;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YrvnOOqMvc6gCMX050RJEmkUu2li6R0MG2FkAVvyHSQ=;
 b=qD9PJJgN2Zmeaxu6YMqcE2dQr8S9+wM6rp3JjUk8yYxVoA5jhokRFaNhk9iBxdgUa3
 /p0vhHRRVRUrDs0aOFLC1Mv2cPNlE1vVhx6y0pp5ccwwrcP9uNUR7JB2WtsS6REokAUj
 2BkaZNOCIrdKeX6NqiLo0mNXwtZqaIJGa1BIKGKMLSVBGFbKokkhHesbqH1I0RkbLjXq
 vUd1hykMBIvkDPFHhCMsxygZskHO8qXwBivU1Yu9nfUc4EuAq35nhT1v5fCwFBpk+NFp
 /r++jAptSpfxrE+dWFBMtMr17qkJLpvs02Vexlxn5A528EDW8JWB1cbfhkXIZ3R67/Xf
 tJsA==
X-Gm-Message-State: AFuF++kWt3e+bzxhKiD2X4DH7ZfKt4d1YBj72OndTG3iuq7lcOsKZfks
 9dKytmH9cuoWWD8s15EHNM9G/NDflC6y0vvV89KrCDFnD7M+EddW6uXLSEOvDhBhdpMXO9Zr4yS
 JWTuWTaD6qd5LBQKxzDbvoYPZ+9vhjW5WBT2HLleTiQYpXAChH+qv/h9WAQ==
X-Gm-Gg: AR+sD10tfmIlWB4x78HHWHY29CUihb0+5sahRx9qeRsef9T30qkLSy4B3ui03K1xuv8
 RaDn9mvBt9cvHYnMQ4V8kKOK2o7PFR3mJoMb+UFljVZNQxCjR1eug2u8Tyh6j/44ANIu0WAXB8E
 YuMO7v4OSpV2e7TzMPAm49aaxX3d4V3uMU1CLAKP5/M32Ejnq8DoCyXxK33sLy2e0JfK6oIH2ze
 W04VXttv3xyxatffqe8oXmdEt0uCynpQoXYgG8f/fHgS7r8oKmwJ74JOCWHNVZh/ycTm/Ofm30t
 dD6D/pOPze/OC99YEN7c8U5o0qg3WHyUJUivBfqXWSv/hmpPyqpMFqTG6sPvIgeBUCipyRcl1S5
 HZwm0sYQcRjiy9mvnxpm2aQGmeCE9xK8Mbuik
X-Received: by 2002:a05:620a:11ae:b0:930:f723:35f5 with SMTP id
 af79cd13be357-939138ffc48mr539383785a.20.1787919465285; 
 Fri, 28 Aug 2026 05:17:45 -0700 (PDT)
X-Received: by 2002:a05:620a:11ae:b0:930:f723:35f5 with SMTP id
 af79cd13be357-939138ffc48mr539377185a.20.1787919464756; 
 Fri, 28 Aug 2026 05:17:44 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a560fsm129214285a.24.2026.08.28.05.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 05:17:44 -0700 (PDT)
Message-ID: <b29d9c2b-6d5e-4587-9e77-ac16c991f7b9@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 09:17:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Add experimental Zvabd extension support
To: =?UTF-8?B?5YiY6bij5Lqu?= <liumingliang.dev@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, chao.liu@processmission.com,
 Zhibo Hong <hongzhibo@bytedance.com>
References: <20260828092053.3787517-1-liumingliang.dev@bytedance.com>
 <11e5ab2c-b87e-4033-a424-028e42dc9954@oss.qualcomm.com>
 <ee7ee3a1f02a7e7cbb15b78aec59fd82060d2306.450f9d23.be8a.4745.93e4.f94f8b9058aa@bytedance.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ee7ee3a1f02a7e7cbb15b78aec59fd82060d2306.450f9d23.be8a.4745.93e4.f94f8b9058aa@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEwNiBTYWx0ZWRfXywoSgA1YKTu/
 reKmlU5XGCWdMGQFLqocyLkBZYDkaz+vT4nc3i/Qtqlnsxz42SSZQRySjaN4MIYZg6fuLxgSDz3
 y1ViNsT3SNaHNsfr/lHHuRh0aOUGxGNR6ugmV2COXqBDRG5O6Di21w2jFqiodu5Shl/31R3oD9X
 AQPvS9Coxbdr1SYRPyMt0QdADteBoW1u4zbmQQIKAxV2ko6aZsrA/POR4lIvchawcUOhy/H9JiL
 JkwAQY/2Ry1gUzmtpxMg/z8aI0ZXJGZVO/QA9Huf1kih0oBOZY4Nxf/IKD0I3iDRgsmW7vG1cHN
 WA6dATN3UeQLoSTvpYfKqALKdqt1w3dT4J0TProlzqujKo5Oy95DPxCmGMqUfdbbA4yd09q4C4V
 Bl4uPrhZbcBv7W1JaYnSDmc8KZlo+7ZDS21DtCuzh/pkV2M594d0qgQMemMqz5zNtvVa4sXY4Ab
 XanIfk0ePkJunFogP+g==
X-Authority-Analysis: v=2.4 cv=MONQXsZl c=1 sm=1 tr=0 ts=6a917c6a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=968KyxNXAAAA:8
 a=69wJf7TsAAAA:8 a=_O3DOGVWAAAA:8 a=JF9118EUAAAA:8 a=SRrdq9N9AAAA:8
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=t5Jr3y9hEBnHB1OR1jQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=2TKV-7w1aU1AVAwN0oqT:22 a=xVlTc564ipvMDusKsbsT:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEwNiBTYWx0ZWRfX9HTsb3+FYe4V
 dtObNQ1/MDbGThie8IjgZ+GvFE71UJ6nsLQAOJzTHjNGfb2Al1Njv4F+pIIpZkxfhUwC67g3d3Q
 aZrZ5WKPJAVHlM4uHviI5PJcjlvPyw8=
X-Proofpoint-ORIG-GUID: myIixImAiuTHrx60ZOu-LNgHK4yiDw7K
X-Proofpoint-GUID: myIixImAiuTHrx60ZOu-LNgHK4yiDw7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280106
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 8/28/2026 9:01 AM, 刘鸣亮 wrote:
> Hi Daniel,
> Thanks for your advice. I’ll add more tests for this patch.
> 
> In the latest specification, vabs.v is defined as a pseudo-instruction that aliases vabd.vx rd, vs2, x0, similar to how vneg.v aliases vrsub.vx rd, vs2, x0. I think we don't need add vabs.v as a separate instruction, since they share the same encoding.
> 
> See the vabs.v at: https://github.com/riscv/riscv-isa-manual/pull/3279/changes#diff-c4a6db324416cc1f52c849a8cd5a20b5d8b5e422ffca6dcb6f341b5f1df48a15R110

Oh, ok. I wasn't aware of that.

Thing is that GCC generates vabs.v with x264.  So, following the diff you just sent:

"assembly pseudoinstruction insn:vabs.v[vd,vs2] = insn:vabd.vx[vd,vs2,x0] is provided."

QEMU needs to be able to handle the vabs.v pseudo (translating it to vabd.vx.... as the
spec suggests).  Please keep that in mind.


Thanks,
Daniel

> 
>> From: "Daniel Henrique Barboza"<daniel.barboza@oss.qualcomm.com>
>> Date:  Fri, Aug 28, 2026, 19:34
>> Subject:  Re: [PATCH] target/riscv: Add experimental Zvabd extension support
>> To: "liumingliang"<liumingliang.dev@bytedance.com>, <qemu-devel@nongnu.org>
>> Cc: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <Alistair.Francis@wdc.com>, <zhiwei_liu@linux.alibaba.com>, <liwei1518@gmail.com>, <chao.liu@processmission.com>, "Zhibo Hong"<hongzhibo@bytedance.com>
>> Hi,
>>
>> This patch is missing vabs.v, which is also part of the specification.
>>
>> I added vabs.v, and a .S test file for this new insns, using Zhibo's original
>> patch, in this branch:
>>
>> https://gitlab.com/danielhb/qemu/-/tree/zvabd
>>
>> vabs.v implementation:
>>
>> https://gitlab.com/danielhb/qemu/-/commit/1ce5701e737f885f2e32248c1587614ea3435d76
>>
>> test file:
>>
>> https://gitlab.com/danielhb/qemu/-/commit/9f4626bc8e55c0768ff474037e291431d4deb0fb
>>
>>
>> Feel free to add these 2 commits in this work.  It's already rebased on a recent code
>> base so shouldn't be much of a problem.
>>
>>
>> Also, I believe we'll want tests for the other zvabd insns too, so we'll need extra
>> code in test-zvabd.S.
>>
>>
>> Thanks,
>> Daniel
>>
>> On 8/28/2026 6:20 AM, liumingliang wrote:
>>> From: Zhibo Hong <hongzhibo@bytedance.com>
>>>   
>>> The draft Zvabd extension provides vector integer absolute-difference
>>> operations for image, video, and other data-processing workloads. It
>>> introduces eight new intructions:
>>>   
>>>     - vabd.vv, vabd.vx, vabdu.vv, and vabdu.vx support SEW values from
>>>       8 through ELEN, with SEW 64 requiring Zve64x.
>>>     - vwabda.vv, vwabda.vx, vwabdau.vv, and vwabdau.vx support SEW 8
>>>       and 16 and accumulate into a double-width destination.
>>>   
>>> This patch implement this instruction extension, including instruction
>>> decoder, TCG translation, and helpers, etc. The specification is under
>>> review at:
>>> https://github.com/riscv/riscv-isa-manual/pull/3279
>>>   
>>> Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
>>> ---
>>>    disas/riscv-op.c.inc                        |  8 +++
>>>    disas/riscv.c                               |  8 +++
>>>    target/riscv/cpu.c                          |  1 +
>>>    target/riscv/cpu_cfg_fields.h.inc           |  1 +
>>>    target/riscv/helper.h                       | 26 ++++++++++
>>>    target/riscv/insn32.decode                  | 10 ++++
>>>    target/riscv/tcg/insn_trans/trans_rvv.c.inc | 45 +++++++++++++++++
>>>    target/riscv/tcg/tcg-cpu.c                  |  6 +++
>>>    target/riscv/tcg/vector_helper.c            | 56 +++++++++++++++++++++
>>>    9 files changed, 161 insertions(+)
>>>   
>>> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
>>> index 1d334e4857..07b56f5d52 100644
>>> --- a/disas/riscv-op.c.inc
>>> +++ b/disas/riscv-op.c.inc
>>> @@ -490,6 +490,10 @@ OP(vaadd_vv, "vaadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>>>    OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>>>    OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>>>    OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>>> +OP(vabd_vv, "vabd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>>> +OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>>> +OP(vabdu_vv, "vabdu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>>> +OP(vabdu_vx, "vabdu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>>>    OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
>>>    OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
>>>    OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
>>> @@ -861,6 +865,10 @@ OP(vsuxei16_v, "vsuxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>>>    OP(vsuxei32_v, "vsuxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>>>    OP(vsuxei64_v, "vsuxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>>>    OP(vsuxei8_v, "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>>> +OP(vwabda_vv, "vwabda.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>>> +OP(vwabda_vx, "vwabda.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>>> +OP(vwabdau_vv, "vwabdau.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>>> +OP(vwabdau_vx, "vwabdau.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>>>    OP(vwadd_vv, "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>>>    OP(vwadd_vx, "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>>>    OP(vwadd_wv, "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>>> diff --git a/disas/riscv.c b/disas/riscv.c
>>> index b8099cbdf8..e0a8b3a756 100644
>>> --- a/disas/riscv.c
>>> +++ b/disas/riscv.c
>>> @@ -2022,6 +2022,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>>>                    case 48: return &op_vwredsumu_vs;
>>>                    case 49: return &op_vwredsum_vs;
>>>                    case 53: return &op_vwsll_vv;
>>> +                case 61: return &op_vwabda_vv;
>>> +                case 62: return &op_vwabdau_vv;
>>>                    }
>>>                    break;
>>>                case 1:
>>> @@ -2164,6 +2166,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>>>                            break;
>>>                        }
>>>                        break;
>>> +                case 21: return &op_vabd_vv;
>>> +                case 22: return &op_vabdu_vv;
>>>                    case 23:
>>>                        if ((inst >> 25) & 1) {
>>>                            return &op_vcompress_vm;
>>> @@ -2349,6 +2353,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>>>                    case 46: return &op_vnclipu_wx;
>>>                    case 47: return &op_vnclip_wx;
>>>                    case 53: return &op_vwsll_vx;
>>> +                case 61: return &op_vwabda_vx;
>>> +                case 62: return &op_vwabdau_vx;
>>>                    }
>>>                    break;
>>>                case 5:
>>> @@ -2417,6 +2423,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>>>                    case 13: return &op_vclmulh_vx;
>>>                    case 14: return &op_vslide1up_vx;
>>>                    case 15: return &op_vslide1down_vx;
>>> +                case 21: return &op_vabd_vx;
>>> +                case 22: return &op_vabdu_vx;
>>>                    case 16:
>>>                        switch ((inst >> 20) & 0b11111) {
>>>                        case 0:
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index a13177b7b7..4b8944b051 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -220,6 +220,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>>        ISA_EXT_DATA_ENTRY(zksh, PRIV_VERSION_1_12_0, ext_zksh),
>>>        ISA_EXT_DATA_ENTRY(zkt, PRIV_VERSION_1_12_0, ext_zkt),
>>>        ISA_EXT_DATA_ENTRY(ztso, PRIV_VERSION_1_12_0, ext_ztso),
>>> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvabd, PRIV_VERSION_1_13_0, ext_zvabd),
>>>        ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
>>>        ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
>>>        ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
>>> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
>>> index f8c27a574f..6018e58195 100644
>>> --- a/target/riscv/cpu_cfg_fields.h.inc
>>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>>> @@ -83,6 +83,7 @@ BOOL_FIELD(ext_zve32x)
>>>    BOOL_FIELD(ext_zve64f)
>>>    BOOL_FIELD(ext_zve64d)
>>>    BOOL_FIELD(ext_zve64x)
>>> +BOOL_FIELD(ext_zvabd)
>>>    BOOL_FIELD(ext_zvbb)
>>>    BOOL_FIELD(ext_zvbc)
>>>    BOOL_FIELD(ext_zvkb)
>>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>>> index 4fc2d3a155..3aef6e0e3e 100644
>>> --- a/target/riscv/helper.h
>>> +++ b/target/riscv/helper.h
>>> @@ -1350,6 +1350,32 @@ DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
>>>    DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
>>>    DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
>>>    
>>> +/* Zvabd Extension */
>>> +DEF_HELPER_6(vabd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vabd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vabd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vabd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vabd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>>> +DEF_HELPER_6(vabd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>>> +DEF_HELPER_6(vabd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>>> +DEF_HELPER_6(vabd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
>>> +DEF_HELPER_6(vabdu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vabdu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vabdu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vabdu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vabdu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>>> +DEF_HELPER_6(vabdu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>>> +DEF_HELPER_6(vabdu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>>> +DEF_HELPER_6(vabdu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
>>> +DEF_HELPER_6(vwabda_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vwabda_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vwabda_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>>> +DEF_HELPER_6(vwabda_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>>> +DEF_HELPER_6(vwabdau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vwabdau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>>> +DEF_HELPER_6(vwabdau_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>>> +DEF_HELPER_6(vwabdau_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>>> +
>>>    /* CFI (zicfiss) helpers */
>>>    #ifndef CONFIG_USER_ONLY
>>>    DEF_HELPER_1(ssamoswap_disabled, void, env)
>>> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>>> index 21272fdb50..1c991a6f42 100644
>>> --- a/target/riscv/insn32.decode
>>> +++ b/target/riscv/insn32.decode
>>> @@ -1084,3 +1084,13 @@ sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
>>>    sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
>>>    sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
>>>    sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
>>> +
>>> +# *** Zvabd Extension ***
>>> +vabd_vv       010101 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vabd_vx       010101 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vabdu_vv      010110 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vabdu_vx      010110 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vwabda_vv     111101 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
>>> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>>> index a22e2cae6c..14ef961607 100644
>>> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>>> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>>> @@ -4091,3 +4091,48 @@ GEN_INT_EXT_TRANS(vzext_vf8, 3, 2)
>>>    GEN_INT_EXT_TRANS(vsext_vf2, 1, 3)
>>>    GEN_INT_EXT_TRANS(vsext_vf4, 2, 4)
>>>    GEN_INT_EXT_TRANS(vsext_vf8, 3, 5)
>>> +
>>> +/* Zvabd Extension */
>>> +#define GEN_ABD_CHECK(NAME, CHECK_FN, MAX_SEW)                       \
>>> +static bool NAME(DisasContext *s, arg_rmrr *a)                       \
>>> +{                                                                    \
>>> +    return CHECK_FN(s, a) && s->cfg_ptr->ext_zvabd &&                \
>>> +           s->sew <= MAX_SEW &&                                      \
>>> +           (s->sew != MO_64 || s->cfg_ptr->ext_zve64x);              \
>>> +}
>>> +GEN_ABD_CHECK(vabd_vv_check, opivv_check, MO_64)
>>> +GEN_ABD_CHECK(vabd_vx_check, opivx_check, MO_64)
>>> +GEN_ABD_CHECK(vwabd_vv_check, opivv_overwrite_widen_check, MO_16)
>>> +GEN_ABD_CHECK(vwabd_vx_check, opivx_overwrite_widen_check, MO_16)
>>> +
>>> +GEN_OPIVV_TRANS(vabd_vv, vabd_vv_check)
>>> +GEN_OPIVX_TRANS(vabd_vx, vabd_vx_check)
>>> +GEN_OPIVV_TRANS(vabdu_vv, vabd_vv_check)
>>> +GEN_OPIVX_TRANS(vabdu_vx, vabd_vx_check)
>>> +
>>> +#define GEN_ABD_OPIVV_WIDEN_TRANS(NAME, CHECK)                          \
>>> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
>>> +{                                                                       \
>>> +    static gen_helper_gvec_4_ptr * const fns[2] = {                     \
>>> +        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                   \
>>> +    };                                                                  \
>>> +    return s->sew <= MO_16 && do_opivv_widen(s, a, fns[s->sew], CHECK); \
>>> +}
>>> +
>>> +#define GEN_ABD_OPIVX_WIDEN_TRANS(NAME, CHECK)                          \
>>> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
>>> +{                                                                       \
>>> +    if (CHECK(s, a)) {                                                  \
>>> +        static gen_helper_opivx * const fns[2] = {                      \
>>> +            gen_helper_##NAME##_b, gen_helper_##NAME##_h,               \
>>> +        };                                                              \
>>> +        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm,                \
>>> +                           fns[s->sew], s);                             \
>>> +    }                                                                   \
>>> +    return false;                                                       \
>>> +}
>>> +
>>> +GEN_ABD_OPIVV_WIDEN_TRANS(vwabda_vv, vwabd_vv_check)
>>> +GEN_ABD_OPIVX_WIDEN_TRANS(vwabda_vx, vwabd_vx_check)
>>> +GEN_ABD_OPIVV_WIDEN_TRANS(vwabdau_vv, vwabd_vv_check)
>>> +GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau_vx, vwabd_vx_check)
>>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>>> index 9e3cc87f8a..4c2fb6f063 100644
>>> --- a/target/riscv/tcg/tcg-cpu.c
>>> +++ b/target/riscv/tcg/tcg-cpu.c
>>> @@ -732,6 +732,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>>>            return;
>>>        }
>>>    
>>> +    if ((cpu->cfg.ext_zvabd) && !cpu->cfg.ext_zve32x) {
>>> +        error_setg(errp,
>>> +                   "Zvabd extensions require V or Zve* extensions");
>>> +        return;
>>> +    }
>>> +
>>>        if (cpu->cfg.ext_zicntr && !cpu->cfg.ext_zicsr) {
>>>            if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicntr))) {
>>>                error_setg(errp, "zicntr requires zicsr");
>>> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
>>> index e28d8a3d9f..bdb1efcebc 100644
>>> --- a/target/riscv/tcg/vector_helper.c
>>> +++ b/target/riscv/tcg/vector_helper.c
>>> @@ -5906,3 +5906,59 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
>>>    GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
>>>    GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
>>>    GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
>>> +
>>> +/* Zvabd Extension */
>>> +#define DO_ABD(N, M)  (N > M ? N - M : M - N)
>>> +#define DO_ABDACC(N, M, D) (DO_ABD(N, M) + D)
>>> +
>>> +RVVCALL(OPIVV2, vabd_vv_b, OP_SSS_B, H1, H1, H1, DO_ABD)
>>> +RVVCALL(OPIVV2, vabd_vv_h, OP_SSS_H, H2, H2, H2, DO_ABD)
>>> +RVVCALL(OPIVV2, vabd_vv_w, OP_SSS_W, H4, H4, H4, DO_ABD)
>>> +RVVCALL(OPIVV2, vabd_vv_d, OP_SSS_D, H8, H8, H8, DO_ABD)
>>> +RVVCALL(OPIVX2, vabd_vx_b, OP_SSS_B, H1, H1, DO_ABD)
>>> +RVVCALL(OPIVX2, vabd_vx_h, OP_SSS_H, H2, H2, DO_ABD)
>>> +RVVCALL(OPIVX2, vabd_vx_w, OP_SSS_W, H4, H4, DO_ABD)
>>> +RVVCALL(OPIVX2, vabd_vx_d, OP_SSS_D, H8, H8, DO_ABD)
>>> +RVVCALL(OPIVV2, vabdu_vv_b, OP_UUU_B, H1, H1, H1, DO_ABD)
>>> +RVVCALL(OPIVV2, vabdu_vv_h, OP_UUU_H, H2, H2, H2, DO_ABD)
>>> +RVVCALL(OPIVV2, vabdu_vv_w, OP_UUU_W, H4, H4, H4, DO_ABD)
>>> +RVVCALL(OPIVV2, vabdu_vv_d, OP_UUU_D, H8, H8, H8, DO_ABD)
>>> +RVVCALL(OPIVX2, vabdu_vx_b, OP_UUU_B, H1, H1, DO_ABD)
>>> +RVVCALL(OPIVX2, vabdu_vx_h, OP_UUU_H, H2, H2, DO_ABD)
>>> +RVVCALL(OPIVX2, vabdu_vx_w, OP_UUU_W, H4, H4, DO_ABD)
>>> +RVVCALL(OPIVX2, vabdu_vx_d, OP_UUU_D, H8, H8, DO_ABD)
>>> +
>>> +RVVCALL(OPIVV3, vwabda_vv_b, WOP_SSS_B, H2, H1, H1, DO_ABDACC)
>>> +RVVCALL(OPIVV3, vwabda_vv_h, WOP_SSS_H, H4, H2, H2, DO_ABDACC)
>>> +RVVCALL(OPIVX3, vwabda_vx_b, WOP_SSS_B, H2, H1, DO_ABDACC)
>>> +RVVCALL(OPIVX3, vwabda_vx_h, WOP_SSS_H, H4, H2, DO_ABDACC)
>>> +RVVCALL(OPIVV3, vwabdau_vv_b, WOP_UUU_B, H2, H1, H1, DO_ABDACC)
>>> +RVVCALL(OPIVV3, vwabdau_vv_h, WOP_UUU_H, H4, H2, H2, DO_ABDACC)
>>> +RVVCALL(OPIVX3, vwabdau_vx_b, WOP_UUU_B, H2, H1, DO_ABDACC)
>>> +RVVCALL(OPIVX3, vwabdau_vx_h, WOP_UUU_H, H4, H2, DO_ABDACC)
>>> +
>>> +GEN_VEXT_VV(vabd_vv_b, 1)
>>> +GEN_VEXT_VV(vabd_vv_h, 2)
>>> +GEN_VEXT_VV(vabd_vv_w, 4)
>>> +GEN_VEXT_VV(vabd_vv_d, 8)
>>> +GEN_VEXT_VX(vabd_vx_b, 1)
>>> +GEN_VEXT_VX(vabd_vx_h, 2)
>>> +GEN_VEXT_VX(vabd_vx_w, 4)
>>> +GEN_VEXT_VX(vabd_vx_d, 8)
>>> +GEN_VEXT_VV(vabdu_vv_b, 1)
>>> +GEN_VEXT_VV(vabdu_vv_h, 2)
>>> +GEN_VEXT_VV(vabdu_vv_w, 4)
>>> +GEN_VEXT_VV(vabdu_vv_d, 8)
>>> +GEN_VEXT_VX(vabdu_vx_b, 1)
>>> +GEN_VEXT_VX(vabdu_vx_h, 2)
>>> +GEN_VEXT_VX(vabdu_vx_w, 4)
>>> +GEN_VEXT_VX(vabdu_vx_d, 8)
>>> +
>>> +GEN_VEXT_VV(vwabda_vv_b, 2)
>>> +GEN_VEXT_VV(vwabda_vv_h, 4)
>>> +GEN_VEXT_VX(vwabda_vx_b, 2)
>>> +GEN_VEXT_VX(vwabda_vx_h, 4)
>>> +GEN_VEXT_VV(vwabdau_vv_b, 2)
>>> +GEN_VEXT_VV(vwabdau_vv_h, 4)
>>> +GEN_VEXT_VX(vwabdau_vx_b, 2)
>>> +GEN_VEXT_VX(vwabdau_vx_h, 4)
>>


