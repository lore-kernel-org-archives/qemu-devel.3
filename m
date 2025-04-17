Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8401C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 15:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Ra8-0006Dm-Sz; Thu, 17 Apr 2025 11:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u5Ra7-0006DY-3v
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:55:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u5Ra4-0000LJ-SD
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:55:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClat5029708
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 15:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UHvTENV1jRwA5M8ruHNR7q4XcdGD9r+gmlKVEfPssTc=; b=kdK1Y8LqxU5KSISg
 Hq1iJyppmY6VWpMmu+p08ANpJrOdRRHoDfkeXyrd+k+Uqe/rWA0Lk8SYbwVex3wo
 pbMnYpWyRlvROVHf7wkQeT48tubWWMipfOdwW9hbuzQ/KIgVVdvZw7Cb6WO+vh/4
 2ULS3SmmvGCpjDPsobja5Ip1+DTp6Fob8zR1XoSmimLLH7n3vKhsAN/DHTMdoZm/
 iOijJAfYqNAAvvieBR0wGzgTd94BA2bdetAj4eg9x7s4AWtkzCglND8rseU15sQR
 Hy1wy3XPQmHVi8e2yI6h+QCXLkBrt8gfCgO9vKSIqX0VLgbTRJ54no2HVCyc01ky
 wD/f2g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj9fex9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 15:55:10 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ead629f6c6so15745296d6.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 08:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744905310; x=1745510110;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UHvTENV1jRwA5M8ruHNR7q4XcdGD9r+gmlKVEfPssTc=;
 b=DSvudGe7GxxEznJcQW6pKEi26pgUszS+3d1j0rWrLvacyMoTTFOnxBc71qK+7uXry2
 86g3H+xE3zNK7kjj2q9sQU8HQ6EJLlXTEvDLoKo6KrQ4BEUSzsd1C9MHsrVr99oS5Sse
 HYry0uGq6bjCAxfRZ/70h4PdXFdyOV7K6m7vDbA65Ymrul45+sINx/cxIia58QrI5OlY
 6wfT56OU1NqfOVQxB+Q6AjCQZOjp4paAhWdvURpBnvDh97uB+3q1yiXU3ncliXM8lkHk
 CljeUu3czkZKeWpAOZm9FVqpmKT7TLe79pULt9upzO1Vu0+Ts90cF7ZESWmCH+SUNzuh
 fqUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrTZQpJfH/xKpQocoayUT1c3bxTm/FrJ2qZZkfJQJlUETczSX2a4oY1vLT0B7+xurEGBDcHSVpBZ0Y@nongnu.org
X-Gm-Message-State: AOJu0YztLpdxkeTDeHdeMmSB98j0oZA7mpmVuuy9X5nndLKOwcceZc1R
 jI8qy0m7BGA3dDctZmvcMrYvLUfiM+AsO2klxTDDRQ4gGBIP8/5IOblLeLJbods9PpaAy4M1kiQ
 auAnUjrwSH6E0FaC4UsSOfOBLv0uj3btrierfeAk5YUxx7JhTtvF5+w==
X-Gm-Gg: ASbGncu9twfWY3Zx5+HjbLX1BYqLw0VsOT7A9PzrfKGsoU5141t9WbjOcuE5xTWemIx
 PXMO+LnhBc1eziZg7I69cnKnAsFXLDeXhVDakS+E1j2Y9jsQSq71J+ny/HoDRCuW1G4PFnuaE26
 4MQsW55ac1jm2jbpvkfv68L8sZ2Li/sVBcW87WeWshlhjc0Lk4ASCXNHSwWgUqi6WGNQ8Opyv4s
 4Aikdid10C65uJpcb4qRS2TDVCuRUBKoppLSG6zVgt0URO/HFn/DOrdPsdolJ/k5GbzsiuuXG9P
 Gnj2OV6hz4X1VuenQSIlOd3EXhjpsr8LzJbIcTuJiY/GNg8i4LW23gWQybSS+RXmJVPd6w==
X-Received: by 2002:ad4:5965:0:b0:6ed:1651:e8dc with SMTP id
 6a1803df08f44-6f2b2f43031mr88465546d6.11.1744905309649; 
 Thu, 17 Apr 2025 08:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUkuw7xd+CyMYxO6uFJioHyVGVOgo3YmYAT0rYQ1qrIgfzOihTzdJ3N0p9VE1NpeXDzIuKrg==
X-Received: by 2002:ad4:5965:0:b0:6ed:1651:e8dc with SMTP id
 6a1803df08f44-6f2b2f43031mr88465216d6.11.1744905309220; 
 Thu, 17 Apr 2025 08:55:09 -0700 (PDT)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f2c2af5b28sm577056d6.10.2025.04.17.08.55.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 08:55:08 -0700 (PDT)
Message-ID: <f59afca5-d739-4e4a-8e96-fb1bc08e4673@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 10:55:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon (target/hexagon) Remove gen_tcg_func_table.py
To: ltaylorsimpson@gmail.com, =?UTF-8?Q?=27Philippe_Mathieu-Daud=C3=A9=27?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: quic_mathbern@quicinc.com, sidneym@quicinc.com, quic_mliebel@quicinc.com, 
 richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 marco.liebel@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
References: <20250415235542.71703-1-ltaylorsimpson@gmail.com>
 <c7588131-2c4f-4a66-8107-cba4df904278@linaro.org>
 <074e01dbaede$2516b720$6f442560$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <074e01dbaede$2516b720$6f442560$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9RHHUsHgm89ssPWdJ6HZxcuHsqbA4CZ7
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=6801245e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=5beqLnDKGG3ao05cDN4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9RHHUsHgm89ssPWdJ6HZxcuHsqbA4CZ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170119
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Adding Matheus, Marco -- their "quic_" email addresses might be 
deactivated soon if not already.

On 4/16/2025 9:45 AM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Sent: Wednesday, April 16, 2025 12:18 AM
>> To: Taylor Simpson <ltaylorsimpson@gmail.com>; qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; quic_mathbern@quicinc.com;
>> sidneym@quicinc.com; quic_mliebel@quicinc.com;
>> richard.henderson@linaro.org; ale@rev.ng; anjo@rev.ng
>> Subject: Re: [PATCH] Hexagon (target/hexagon) Remove
>> gen_tcg_func_table.py
>>
>> Hi Taylor,
>>
>> On 16/4/25 01:55, Taylor Simpson wrote:
>>> This can easily be done in C with opcodes_def_generated.h.inc
>>>
>>> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>> ---
>>>    target/hexagon/genptr.c              |  6 ++-
>>>    target/hexagon/README                |  1 -
>>>    target/hexagon/gen_tcg_func_table.py | 66 ----------------------------
>>>    target/hexagon/meson.build           | 10 -----
>>>    4 files changed, 5 insertions(+), 78 deletions(-)
>>>    delete mode 100755 target/hexagon/gen_tcg_func_table.py
>>>
>>> diff --git a/target/hexagon/gen_tcg_func_table.py
>>> b/target/hexagon/gen_tcg_func_table.py
>>> deleted file mode 100755
>>> index 299a39b1aa..0000000000
>>> --- a/target/hexagon/gen_tcg_func_table.py
>>> -        f.write("const SemanticInsn opcode_genptr[XX_LAST_OPCODE] =
>> {\n")
>>> -        for tag in hex_common.tags:
>>> -            ## Skip the priv instructions
>>> -            if "A_PRIV" in hex_common.attribdict[tag]:
>>> -                continue
>>> -            ## Skip the guest instructions
>>> -            if "A_GUEST" in hex_common.attribdict[tag]:
>>> -                continue
>>> -            ## Skip the diag instructions
>>> -            if tag == "Y6_diag":
>>> -                continue
>>> -            if tag == "Y6_diag0":
>>> -                continue
>>> -            if tag == "Y6_diag1":
>>> -                continue
>> What about all these skipped tags? IIUC gen_opcodes_def.py doesn't skip
>> them. If it isn't necessary to skip, please mention it in the commit description
>> for clarity.
>>
>> Regards,
>>
>> Phil.
>
>

