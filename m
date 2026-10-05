Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27043CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDngi-0004uI-1P; Mon, 05 Oct 2026 14:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDngd-0004p8-3H
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:45:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDnga-0004n6-5R
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:45:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLx1T2207561
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gTIbJ/8G2vRrSRHZBc+WupQYNvgl/eDYPw71x+1+av0=; b=DXGkPiaPIR/arFam
 0iZhm8GWrolWCSIjAiDS8oyaTSQ6+QgaJd5uHpT+ayz77JejQH23xwhGNSi4zr1D
 1I5quYNm5ZKJ10KsKBHGNu36BRLBP5ncDjEst5A4WRKOZVMHjlrin2pQQRbo0gJd
 yQzy4xtYvp+RWpoqI1cjfU5csrnL3c+/EAlGiDpaFw0CDc7+IqFPTc0D87MF5r1d
 V55Whjlw/s9O38yysyOTvRv0MnT/GYDHAsexRiApkaCskoNEDgOkYsBBLeLUoYo1
 9oD+7CqepE1MrcVye1DngI3Xcb9t1Pl4d5ydODxeWYkWjBZ8jsANE+YzRbtSZn8Y
 7T59Og==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4a7dsvte-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:45:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf7856ffso326135485a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791225913; x=1791830713; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gTIbJ/8G2vRrSRHZBc+WupQYNvgl/eDYPw71x+1+av0=;
 b=F22Fh4MHFcBD4JLVB4LmOpywNV/LbVFGxRw5NPOgsOF1W20cmua9RVEK4PYWPinXK0
 hUmx9k1pEfwrLwMK7mCSN6+E6wzl3UokjoSnYMsoCCJhpm0lWhJURbNMd1pdvEp/4ayZ
 I2LB+vlzPoJ66iZtVk0sDcy/vIJUav8yH27slS8aTd/58gz/bACXD62sJLBMzW658sAS
 Co5nBc7n3O/3+1Q9xgKru1h8YNbemmndbAMN6CB4T/CjdBZhForldoDPX2JDg4toKuf7
 KxRZlpIfk4Sr+mxrYSuyCO8JtFQjpy97RJAFS4iApMbHwUmmY7Y6PjVNB3mVnBWMDvyY
 0dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791225913; x=1791830713;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gTIbJ/8G2vRrSRHZBc+WupQYNvgl/eDYPw71x+1+av0=;
 b=bqLKlUq2RDEXqqU32YvQOr+1euqurqFu5X3CmzwP3ynj70vdmFnFghIURJpf6dcw2P
 CKsXuFNPbidAelAwwRpsrgV/YZzmn8bsvZw2YRp6ajiPEV8OAm/C+RY/q9v4Hr/tgZyR
 2A+RA3Va2ZQe7sPTn4+kHDhmksAAoOy0mF97V91bH/dvJ8MZ1hB3TK/Vc0M0/VrCO7Uw
 m6yNLkEW3YjLGXgcenuDLIqNzmxkVOA7Su34AidTlcypypyfoorgWa+0+xGcpl/OJFu+
 NlwNyhbFN05CJgjANaDVt3cKDFS3qyVwWqqo99bhuZHE+jLg387Y2nWKVi+1tDZSz9Uq
 ZpOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFaWILGjq8jCtWZPjHtk+MPUtz34alMaIYhwNXp7L4PUgputicvCv8wY9XHfmw7gUFGU3CF8LDNDvN@nongnu.org
X-Gm-Message-State: AFuF++kfWQ6JnqnmifvZSnZL7+OFhP60ne//Z4JcPTCjLQm5Td+zFsoW
 N7FU01ceSgZyvjv5O6X4ircxPeJkkjqKhxP/xdksFMJ7m8v2evjVjExiiPb+p1X7JxMu4g423A+
 nLWLo6qwdBRQ6azuIPaLqIRi58DNXKrOxI2iEo0tOxm0+VPhfKaKvrNPOJQ==
X-Gm-Gg: AYBFou2uYNaog1XMcq8P/b+RHKipgbNSUxPemqDZR4yVH9TZqGcSBhBFoz+dxfTgc4j
 6+vVml3K88oA53DjL0oZrHt4X4UbXyOq3NPxUkhlnu/qq7HWCA1JccMgrD+alGUOtt4+dIUtI1E
 s+MycwL2PMZEsTP6ubKljHBlytp4ZlbTyvsgXounq5HSpaSboH1Ud6rGMwSWf4Mb4HAtTgWLiWO
 HvdoKue1KFvcbFdV/A918xFRbGINunY0wWqxAKruL3MaVoklGtRdTciA0EqDFK6AbrqwOY8ZEpR
 GmlvYLB7Qn523jmkiEfNsNyqNkjfsiy0+0604DKRk+EGdCJtPLDLCCaoogqxUW5vUDB9hUal8Dv
 t6VjLQjc7gPVFRjNUdQMZgWpY5Erz1TIyoPO/RmBnE5V64Uu0PPFLeYvV3YEf65EV
X-Received: by 2002:a05:620a:c53:b0:93c:6963:ff3b with SMTP id
 af79cd13be357-93cf17832a3mr2127703085a.42.1791225913105; 
 Mon, 05 Oct 2026 11:45:13 -0700 (PDT)
X-Received: by 2002:a05:620a:c53:b0:93c:6963:ff3b with SMTP id
 af79cd13be357-93cf17832a3mr2127692785a.42.1791225912359; 
 Mon, 05 Oct 2026 11:45:12 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e472b24e1sm802922785a.24.2026.10.05.11.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 11:45:11 -0700 (PDT)
Message-ID: <af812a3f-1065-45e8-849e-492582b1a8b5@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 13:45:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/hexagon: add v81 HVX compare, align, and
 convert instructions
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-4-brian.cain@oss.qualcomm.com>
 <00d46b8b-0ee1-4162-8d4d-51d86d5cc477@oss.qualcomm.com>
 <281bfd72-9f6e-482b-a74a-750da96eed01@oss.qualcomm.com>
 <162a08c2-b287-4c94-908d-00d95a319d4f@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <162a08c2-b287-4c94-908d-00d95a319d4f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3MyBTYWx0ZWRfX6YaYZ5NnGuuC
 rw518q4mdbJAs74aJhnVzFdwuFD5MMVznfMspJ1MOPyEpQfGQ8qEMfD6AAbTFrZSzCgwS3WV7Mk
 H98RSzYwEu/CNs6fhLBHagZgzbkUGnE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3MyBTYWx0ZWRfX3c5wm9zki9Bi
 2+YCKJxJkajcl63cLkQ8/ccGntFmScW8LKDH1cEj7cBPB6NyoMn1hwPYiJsZsjpqDvI8gXtGltY
 E+MrqtoyjqCGX/75/3NuNHDgtjpPGd0qrqzZg7s1VullLEVN3qjSEtwOEXzvf33WVtdzV/gDU0/
 0+9fWYoR0tdxmM6iDM51Xlz2/zWVMbDbkR2iNabbUpehssjOGnVUFypGuTslCOZPrkpspflSkME
 yC1sezjxSklzq87aNrPbfACbFOjL2fMwmhFv0k/2XAlnu8WrQp0XZ0knz9rWJ0XSeJHwPv4zgYU
 Ks8IhwZFRBfpIjzyo6fR/AhkmsztmFXho8aI5UrsAJ0fk8oNyl3SDQyfzVAghKxA1n5K8StDWC8
 4C2fH0eUy8IO5ZA5c9+yPlgOCECK0/rHXhnB00qr8/a4AMVANzIKznjhUV8MrwpAKpU5/kGLss3
 UK42NTDGZCEdyGeGuhg==
X-Proofpoint-GUID: tSWt8cMby4w5pUgH4WRUtRoTun6yly96
X-Authority-Analysis: v=2.4 cv=SvwFe/O0 c=1 sm=1 tr=0 ts=6ac3f03a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=f7tA75arMO8DkslLnDcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: tSWt8cMby4w5pUgH4WRUtRoTun6yly96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050073
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


On 9/30/2026 4:14 PM, Brian Cain wrote:
>
> On 9/29/2026 3:28 PM, Brian Cain wrote:
>>
>> On 9/29/2026 1:09 PM, Marco Liebel wrote:
>>> On 26.09.2026 14:23, Brian Cain wrote:
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>   target/hexagon/mmvec/hvx_ieee_fp.h           |  2 +
>>>>   target/hexagon/mmvec/macros.h                |  2 +
>>>>   target/hexagon/mmvec/hvx_ieee_fp.c           | 15 ++++
>>>>   target/hexagon/tag_rev_info.c.inc            | 13 ++++
>>>>   target/hexagon/imported/mmvec/encode_ext.def | 10 +++
>>>>   target/hexagon/imported/mmvec/ext.idef       | 74 
>>>> ++++++++++++++++++++
>>>>   6 files changed, 116 insertions(+)
>>>>
>>>> +ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_h_hf_rnd,"Vd32.h=Vu32.hf:rnd",
>>>> +    "Vector conversion of hf16 format to int hw, round to nearest 
>>>> even",
>>>> +    VdV.h[i] = float16_to_int16_scalbn(VuV.hf[i], 
>>>> float_round_nearest_even, 0,
>>>> + &env->hvx_fp_status))
>>>> +
>>> I think there are two issues with vconv_h_hf_rnd. Because it's using 
>>> float16_to_int16_scalbn:
>>>
>>> - It hard-codes nearest-even instead of using USR.FPRND.
>>
>> This matches the defined semantics for rounding. 
>> https://docs.qualcomm.com/doc/80-N2040-61/topic/hvx-floating-point.html#rounding-modes
>>
>> "HVX floating point only supports IEEE-754 round-to-even mode."
>
>
> Okay - as it turns out, Marco has explained to me that the statement 
> applies to the unqualified instructions.  In fact, the explicit ":rnd" 
> instructions *do* consult USR round fp flags.  I will fix this too.

Ugh - this thread has turned into a bit of a flip/flop/flip.

The text in the PRM regarding :rnd instructions was wrong, so we've 
asked for a correction and will post an updated link to the PRM when 
that happens.  In the meantime, we've verified QEMU against the 
instruction set simulator hexagon-sim that ships with the commercial 
Hexagon SDK.  That confirms the round-to-nearest-even behavior 
originally implemented.  The v2 series reflects that and adds tests to 
show the rounding behavior independent of USR.

v2 posted: 
https://lore.kernel.org/qemu-devel/20261005032616.1293829-1-brian.cain@oss.qualcomm.com/

>
>
>>
>>
>>> - It uses generic conversion, which returns INT16_MAX for negative 
>>> NaNs. Hexagon requires INT16_MIN.
>>
>> I will fix this.

