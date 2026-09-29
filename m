Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C42BCA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 20:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBeRA-0000Nc-1u; Tue, 29 Sep 2026 16:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xBeR7-0000NS-OE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:28:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xBeR6-0005iC-0G
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:28:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THhIoc3936725
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 20:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 33UO5WZW0ulk/2gXTxLqkoKPVD4pvkcR6208r3SyD8o=; b=S2kWu/5AUG7p0AN+
 4a+Jk2FvDwRdN0D0y69b2gv66KVwpC8vpGODpjGtneo0pq/327p1Fva4VI2XUdJf
 f7mXKpaT4xaYLS1QgFPNcoBQil4aTNdaBkBx5UZyrTu7dJ+lb22skg1FRHqPmwdP
 u7vY/2zb8Slep5C3OWhmf77a3xEL697lHWlh+uSILjX5BPBPSMvNhd2DJD8Q9RgW
 5ZgfMpJfnO3d+dHP4O2AdJErTou4ULZtzJyxoUd+Izm/5EIMhcdhZyMsNSuhIPa1
 0PrMMetCPMHnDDVUyQ1NIEbyRuwGi9V9dgwR/jZ48222U+iJbuU/lY3hoq9XkWw3
 j5xPqg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1jm7g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 20:28:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-530d206e2b4so106453691cf.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790713700; x=1791318500; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=33UO5WZW0ulk/2gXTxLqkoKPVD4pvkcR6208r3SyD8o=;
 b=WM9PlyyaqNHgdojCV29yckttJbArIVIVQiLMUanBuU48JBjP41Sb9UYEgJXkA61KgS
 j049XXpaLezIaUwi2SxZZupmotnRAwibLmSXVpy1Ukldrn2dzXinbIYP4X8FoemnLVT4
 Afd2gEM8Fb87hNO7BdCPVdp1M+JObIfYwPPtQHDcZi3Rv50c5etnkJnzhKBw3mz5V5zq
 axeaiKJGgaiCf1pci3nOO8zl2pflBPsWykT1lRMhBnR1ZVbBOVwQopSut+tDV/ZmTcq3
 fUTKR/uNrsM/HB9Q7fRROOUCiYj0DaCQlwjXZpl4E4g9Y/PH0TA0JRADVXQo9kKnTCQD
 /J1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790713700; x=1791318500;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=33UO5WZW0ulk/2gXTxLqkoKPVD4pvkcR6208r3SyD8o=;
 b=bUxTT6S7tv269rW6mGt5jBesjbxQwo51xjJlXzTPBV7n0xRa4hc0kxv0K59E3cc/yF
 pnl+phOwQCcHA3SaNIiYMk/xfpxlrw3rAlAdjQcAxelW9HvJrkshoyzDzeu0Jzi0NE1J
 go+hWEOo9DTrDfug20tK7xi+SXQVSIPUe47nRY6ND/ykpS4K2WmeNreiWGueDr6wAKzi
 /eBMKo5tQykl4boTtc+O4GJ8ehSgHr+Bq/2UilmUf9xBdg/kUDXrdjsK2DVbrqYHbTfM
 P+td53ijkonHseXgJU1RKbI5qMmaVuVTn1i/laA6zrV9TX9/t2cd0w3KG7z/hPnkzuhg
 +wCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhsiaX2tYtQFbL5fRWVmyaJc2t1nWa1CElOlme3n71ab7hXEfzZJheUsVtBgdAf2Sm4VBtKikCQMum@nongnu.org
X-Gm-Message-State: AFuF++khehTKJwpP3vB3VSe32ezrawYe8u0+ltu219tltG9ainqcJUTB
 sf+//3AhXlqufFuxOqW8EtZAey137QBS8IMcG19illJ7NZyBjJBWGZbwIuiq47o6HO3MnRL0o+A
 aF6Z+P72A+MGINnuteRR9GtPy5thQKeaHBljt6PLXarO6MqimRpX4U5MRuA==
X-Gm-Gg: AYBFou3CKzswpZCN3K6zbSZCl0fQNHup3ks/EKnuQe/dpDpFdKr7qkRVockF9HrZ++m
 byxCMxUJNv2YR5Emw9WVPg1ifDEX7Gac+WSyH+EXN04KiOXiJ1tBFBSmdiBZ9TTk9lLgHvm0hKp
 lPDXgnQiWN9WgmCgbfEXZmlHYsKzKInr1a8A2LdOxFGsul44R9buGdx1rciC5PBPoo/amgcXZwJ
 TDZaFVze1IdM8B2BPSB64FW/LPM/zX+uflR/b2F6LhI7h5prIsovsVNQzXtuafWishkUQP/tEYx
 HyTDh28U4uGImWuE8xgdaVFD+vf1siQxd8EGoS0ytEltG/sd5hTjKJJdyzOqb0tUcuOGmDcAuR7
 hiadimniQ/7JvDRuU6+l+bv9+EgKd1H/xz9BYy6CsV26o+VCKI+Jab9cuPIYqTXdC
X-Received: by 2002:a05:622a:4d85:b0:530:b2e4:91be with SMTP id
 d75a77b69052e-5336a68ff17mr6886761cf.55.1790713700489; 
 Tue, 29 Sep 2026 13:28:20 -0700 (PDT)
X-Received: by 2002:a05:622a:4d85:b0:530:b2e4:91be with SMTP id
 d75a77b69052e-5336a68ff17mr6886381cf.55.1790713699973; 
 Tue, 29 Sep 2026 13:28:19 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53369bc66cfsm3590491cf.22.2026.09.29.13.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 13:28:19 -0700 (PDT)
Message-ID: <281bfd72-9f6e-482b-a74a-750da96eed01@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:28:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/hexagon: add v81 HVX compare, align, and
 convert instructions
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-4-brian.cain@oss.qualcomm.com>
 <00d46b8b-0ee1-4162-8d4d-51d86d5cc477@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <00d46b8b-0ee1-4162-8d4d-51d86d5cc477@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4MSBTYWx0ZWRfXyTzkYFmA2dBS
 cT4SxjAroNfzSxam9CR+V4wYPZcuxM/PxgceI+qyqWXRvGSmyGya2i5QKx3ex5QYA6HroDIuF13
 AHPcw4gbKys/MXMK9y6brjZi6pvj25M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4MSBTYWx0ZWRfXydb2XbObV5Jw
 PD721jsWZdcNKIpsZnKLTcVNWQm2XPXCCTT7u2kEzkkXEnTidF2ny8/Csb+pDMNFe7Iv+LQP7MP
 qeqVijZEo7TPReBZhdnPf+5lA1lLXaHA0NSi35ZuKriJgN2XoRxI0YcjBhyb/rg89E/0ugGgSg5
 1+lPRp22rGYma1mqSAIGlLlX1Jm81DqjsouFhZzkvP+ZzZSaQzN7iwvSdwnxu2I0nPvORM1w5px
 Gr8WBU0BbsYI5QT3X6fS94fo+jbNwUm1q0DRhl7SDkPW7S0z2AlRFzf2yqg4pmZBebFVSz8pp4D
 cnCaS3fqdk+uAFgkViMHKJmibj8vSRGP5rbXfTsowBCjxjJFPgguX6ggAT6b0NA9F8yH61ZJbAh
 reZBfvSMIXgcHcW1fkPDfl7cV6WcLg1MDpjrewCOBlz6S2jdP4rwj7RFxL95pBUj/ShyEI7ObIY
 go8BFVot2HvW0wxWpnQ==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abc1f65 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=r76OPluIJRCZbRIQdZkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: wrKglMaQKJ0UP_w7o8SJJ0Ig0FDk0TtG
X-Proofpoint-GUID: wrKglMaQKJ0UP_w7o8SJJ0Ig0FDk0TtG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 9/29/2026 1:09 PM, Marco Liebel wrote:
> On 26.09.2026 14:23, Brian Cain wrote:
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/mmvec/hvx_ieee_fp.h           |  2 +
>>   target/hexagon/mmvec/macros.h                |  2 +
>>   target/hexagon/mmvec/hvx_ieee_fp.c           | 15 ++++
>>   target/hexagon/tag_rev_info.c.inc            | 13 ++++
>>   target/hexagon/imported/mmvec/encode_ext.def | 10 +++
>>   target/hexagon/imported/mmvec/ext.idef       | 74 ++++++++++++++++++++
>>   6 files changed, 116 insertions(+)
>>
>> +ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_h_hf_rnd,"Vd32.h=Vu32.hf:rnd",
>> +    "Vector conversion of hf16 format to int hw, round to nearest 
>> even",
>> +    VdV.h[i] = float16_to_int16_scalbn(VuV.hf[i], 
>> float_round_nearest_even, 0,
>> + &env->hvx_fp_status))
>> +
> I think there are two issues with vconv_h_hf_rnd. Because it's using 
> float16_to_int16_scalbn:
>
> - It hard-codes nearest-even instead of using USR.FPRND.

This matches the defined semantics for rounding. 
https://docs.qualcomm.com/doc/80-N2040-61/topic/hvx-floating-point.html#rounding-modes

"HVX floating point only supports IEEE-754 round-to-even mode."


> - It uses generic conversion, which returns INT16_MAX for negative 
> NaNs. Hexagon requires INT16_MIN.

I will fix this.


