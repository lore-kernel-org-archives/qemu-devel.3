Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629ACCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC1dK-0008Dc-Nv; Wed, 30 Sep 2026 17:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xC1dE-0008DG-IN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:14:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xC1dC-0000Dy-Oq
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:14:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UJ4EF7002075
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 21:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i4gPYVPbvb6eRdW06on/XEqnljN+h5ePybbr5NfRklY=; b=MGCRI+307MT4GCAV
 i9osum9gVdXGXCP0fNa5LRRl/WntfC9BiHEqgHSKf4uPTzfHVQb9ukEaQODpu7p8
 3wPww+dx8rWDT5wqso+xbhM0ceGCFwq/J7ms+8LGDW0Bo4SYWHXPjV4GZ5JvzUcR
 CQPtOE0OYeT/MdtBbl3nbVABTupMuQGUMdDARJDYrUyhkdCpRltZHwtK/gf1+MDS
 cDg9jaPy36XXNf6lnKTdabGzh70ANhk7rKdUK1xK+NhxqBjMP3oTWnRHf4awtLZn
 xJ7qtPVoQYQY2lJOIP9Erv7qc4bsd/AEeT8qG7uxikh1w5drYLp2VCCnAVoW0aJK
 LKW/jQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h188srdv0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 21:14:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb71b1443so51159385a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790802864; x=1791407664; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i4gPYVPbvb6eRdW06on/XEqnljN+h5ePybbr5NfRklY=;
 b=Ik9Bd9b9ZwFrgNS8KoBPk1mdpr2GlK2sOcJgLGNukYeivh5dQi7vk0YBEYOw7O7Y0o
 X3sJnQBYGOt7z8+etHI4hRyJm/az04c27QqSFa14LuozvrC7XQFJ5KcJTQUV2qauqzzJ
 vE1ZuKkMNmaHl+FqGv0AktD7DWIRKmL7XPJrQeAW8W9GrkG5IIXZLj+dg0d+zZ2jP3y9
 EyKzdMD0lShavj+u2ejDNmE31ID9AHD/uAMfzRimAjHVCswrr3d9k37JNO28CZclyfju
 6XO1XuozOj8IYzDLbGYf7SiEKIUhaoIwrb4RKSNEUx2rYtKZfNMJPtOdUJ1FHNq8aTBB
 ZQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790802864; x=1791407664;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i4gPYVPbvb6eRdW06on/XEqnljN+h5ePybbr5NfRklY=;
 b=LJPw8wS19aRJFrwP7os9X5cSYjfueysrHybd7O0WnJhtO3nT5F2UORIQwIUalRH3x0
 ZrT3eYEByeho7mSGPQ814hi+RG9ubU33BtkvXYm02ZCNI4nx93LZvQHqCZPMqlvXbtGv
 AeahQzNLM9OZJVjT7g2wfnF6VxKTxg5xzOscrgT6tfg7S5bg9I6luW/lKO02YCwIuWeD
 sfBSWxqVRQplk6TPQutGh0jT3nqAjeeFSHQwRDwhIhqh85s/NTwmD94gvJcmkbnNk8o6
 13QJjIffL7LzYxnggAaYzEMSKIaVyAIrxgZTnx/f9FTPDcjeBhniSSg3HEB8DMt7Kxjd
 uYkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGo68vLV6XXx6YCHrXjXIiDPbaYhqz5hdYMBu2Cr7pocIyOj/SGzxJU8vGmbnacaYV0k5TwSo6P+iQ@nongnu.org
X-Gm-Message-State: AFuF++mFdClsz/AMKonlk/W0eqEtE4KjQthhNdNRHigKBm3JLS9bYiGa
 dJJYLpcFMs8iLdtRs01Xkk6Jpz3Bi61R1AkAEoKPkbN/MHC/zJAAjcjjDbzcybvb53ZecpuDbmY
 ckTrbPmqJjXRh39aWmiQ2fcjbQmCBn+Rlhf8aGkQl6GqpotuE9yPuts4xYg==
X-Gm-Gg: AYBFou2qHQMY31qBlDLSJTl4JJ04V6JCnI2P8Yf/BlXa2exK+LjUrId9W1qFCX5dUa+
 lkfFDoCrN35UQro1ng7FyGGNEzdVJOMCaflk8WkeXSTjKQ5vgvY9JxwYkkzx+P7ljoY7w5AMkUE
 kwMy0tMuS4aV4zF/1Z08x2IfjWlYHhW4ZAWNWAwNX2jpNbrqp9R1hiYHvCaQot2+qQkED3736iH
 nNHG4IYlM0LYen3j57LWuLA6YkKmGvqug6QAE27m/uKeoAjk1pB5fMdFfbTEZAgc97Laiexa3t/
 wMGgg2hObpEHXntb52tOQmFtThGvpO5dLB3ASXovnXfxRMC7bi/j9bt4N8yJtdSAiinVZfMxfui
 PsSr6V+kuNsRbjPHtgcHhE2PwRJa4YjJ6QFaA9Xmsv+mmFfpwJyCPQmVnCn06dyYu
X-Received: by 2002:a05:620a:2682:b0:939:f27c:7433 with SMTP id
 af79cd13be357-93ca9881ae4mr469419085a.50.1790802863607; 
 Wed, 30 Sep 2026 14:14:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:939:f27c:7433 with SMTP id
 af79cd13be357-93ca9881ae4mr469415385a.50.1790802863034; 
 Wed, 30 Sep 2026 14:14:23 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cb6599b50sm56603385a.42.2026.09.30.14.14.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 14:14:22 -0700 (PDT)
Message-ID: <162a08c2-b287-4c94-908d-00d95a319d4f@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 16:14:21 -0500
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
Content-Language: en-US
In-Reply-To: <281bfd72-9f6e-482b-a74a-750da96eed01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA4NiBTYWx0ZWRfX6TkGVtCH17f/
 DP2R5nTK5YyvaIKWxLXpRML5I6faGQYkYQE57ydJdcivBC91bYCihZE/CqPL2s/O8n1Yl8zxt2K
 HZRI/bmjpT6ON2wK4ZRuyLjZvPEMm6s=
X-Authority-Analysis: v=2.4 cv=OozaWC/t c=1 sm=1 tr=0 ts=6abd7bb0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=hwAzLS_yuh09cGhwTyQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: iQkLl1p9x-gB5QxBzIYStE7PWSihH2z0
X-Proofpoint-GUID: iQkLl1p9x-gB5QxBzIYStE7PWSihH2z0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4NiBTYWx0ZWRfXzzWz7s83boiO
 9CgzxgarA6oSWX2lJp89PtNUE+XjIBlEMJEfGCM07LQPonm3hLSIf7FjwgBUZgwirDmgKHBErO9
 OvbrT8HwtqJnf1fa3XuAkmlFky2SJ2UuBM+UZ+TsmG22pxdGBk4P1mABGJJjWJhfsu1i5K9pa7m
 h4Rv9RolsZZAtJbNdsr2HLNf+9Jga5JEtdWWYxUaHHSTtuF3G2gmNceRB5NSD5B9yxQuX2ElVyp
 D6l77TaNyuE/IRAkLZEbMxv0gzLOZeqJqO62+JCh13HV1W7a3X6mmf00zUiz2DeasVSC/Ky2Ffz
 wZLXuqnbjueWWkGom8/o5AVfB5fcjDtaGfbLSDFGlVYFp9TbHsUKOFRv82PHDBkq2bjbGxktK77
 Ris6eKpjhXTTCG2n/uQJPmHDpO3lCKt37cd7PYZOBJlZieV60ooyrt5TQ2/nqiwR8+bme0U27Xk
 hhvhiIJli+nMyPnYb/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300086
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


On 9/29/2026 3:28 PM, Brian Cain wrote:
>
> On 9/29/2026 1:09 PM, Marco Liebel wrote:
>> On 26.09.2026 14:23, Brian Cain wrote:
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/mmvec/hvx_ieee_fp.h           |  2 +
>>>   target/hexagon/mmvec/macros.h                |  2 +
>>>   target/hexagon/mmvec/hvx_ieee_fp.c           | 15 ++++
>>>   target/hexagon/tag_rev_info.c.inc            | 13 ++++
>>>   target/hexagon/imported/mmvec/encode_ext.def | 10 +++
>>>   target/hexagon/imported/mmvec/ext.idef       | 74 
>>> ++++++++++++++++++++
>>>   6 files changed, 116 insertions(+)
>>>
>>> +ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_h_hf_rnd,"Vd32.h=Vu32.hf:rnd",
>>> +    "Vector conversion of hf16 format to int hw, round to nearest 
>>> even",
>>> +    VdV.h[i] = float16_to_int16_scalbn(VuV.hf[i], 
>>> float_round_nearest_even, 0,
>>> + &env->hvx_fp_status))
>>> +
>> I think there are two issues with vconv_h_hf_rnd. Because it's using 
>> float16_to_int16_scalbn:
>>
>> - It hard-codes nearest-even instead of using USR.FPRND.
>
> This matches the defined semantics for rounding. 
> https://docs.qualcomm.com/doc/80-N2040-61/topic/hvx-floating-point.html#rounding-modes
>
> "HVX floating point only supports IEEE-754 round-to-even mode."


Okay - as it turns out, Marco has explained to me that the statement 
applies to the unqualified instructions.  In fact, the explicit ":rnd" 
instructions *do* consult USR round fp flags.  I will fix this too.


>
>
>> - It uses generic conversion, which returns INT16_MAX for negative 
>> NaNs. Hexagon requires INT16_MIN.
>
> I will fix this.

