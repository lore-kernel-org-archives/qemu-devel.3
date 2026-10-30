Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B217606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hsELKrwp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WQpALNOd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMlNi-0006jR-4b; Fri, 30 Oct 2026 08:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMlNg-0006iy-R7
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:06:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMlNf-0006ng-7h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:06:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBG03n3089246
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g6fCADZrf81IaNGaUbWt9QzqFuOjo19rfogf3qtdl8w=; b=hsELKrwpTx6XBjnj
 Jg5w+bsBDYGmTUZ+ZVbezTqeMXCehYaoSZYAJPiGx2riq0sIDxm/3BcA2bWWd4QS
 otVtW2vY+zUNQNVSCcDXZUPAoEWz7aIklk3ryQNe9G0EaWz8M3naQWw3OFNBM+cG
 ZrTmu6fsqFXViNZJsjuuW4j7diUdRGfNyrdo7yS8BSislN9g2ztr+NfTC0T+EA1k
 8Ku7GQBpJjtUOph5AjlrbmVK25uoKKdn3l5RRyHpcOL/rAuIrMV5jjP9wfza1eY6
 5wZbOCVIAbGw5xJvRG+375nlZGOwyKqLrU2N3MAwV9gIwMVXhQNYPWFoW0PsZyjF
 O4/zbA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qjxsa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:06:45 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9902e6f65dbso148757241.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 05:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793362004; x=1793966804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g6fCADZrf81IaNGaUbWt9QzqFuOjo19rfogf3qtdl8w=;
 b=WQpALNOd8g/P9zJTYunGgNy+yq5s2rxA90uY9of8PAL1xZoMsKC7p91BfCKca6HOGj
 SyukvD0zf36yPL8ARsc0BZrJGEB2n7iFzhtpq7L5qh//6W5IcqjJunR9Y57Gz9t5KxSK
 bnd3kxQM6vV2XYSBnWSCDLTfXigFS3Ue1Nj0EDGD3Tm5iBLt1fLWxJZGWV9EJNFIbyya
 1+uvXZ+dNXuK/3DKPQFmdqQ8BbIUWmyxmwliyLsLP/lFVTyRrM5luc+p3sN2qu/o/3rj
 udmbBcSgjBc+5yRQNpLaM451hyVej3WyP6Vsz+bJNs4tLLf/2n4qcSAVwfAig5lPqsco
 FdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793362004; x=1793966804;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g6fCADZrf81IaNGaUbWt9QzqFuOjo19rfogf3qtdl8w=;
 b=M8l8YHwUtNAWFUpK2r+GJf06d+agbBwk6C/RDNbWl0EiNqRvsVpQaCVF5xLcFeBQNx
 2l1p/s14RdrwziY7Sb8U2HuSOFP0CJxmHizAGRS8VyTkROX6PuRI5irXghQzIQHa4N2V
 V5Hz2C5fp0Rd9nyZb6rVI4reDbcLQ0jLgeVD3zD+7we1hBVqgQCkf92ieAGTu3oTzld7
 1YGmol2pQKVb9YHhyiPofqGLLHYgpJu9TFgkIhVyzQaZVRecCA4go5+ea1iOtuinzbsi
 TBJDyj2l4gjJOq1kcdLSTPMHymizzUjd3+N7X0hTfR/UPAeC5amp1u1n7LUfq6o/P+cY
 FLJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0yxDDajxdWQHZxj/1XrZv2puMl/6LM8XYKK5vRAvFogPhPOf5vuSqvspDHmEQGpHiNnp5NyAvYtMt@nongnu.org
X-Gm-Message-State: AFq9FYJPQbjgPSsQPqPHfar1f3rKzPTRsCFA4m/dav9YbUQvvOkgbAPT
 PMJjgwAy3lPVKLN2KW7TGdJLv15c6p+wxR3dqVkawSvAX9KuuHZpMVfQpmd0GI5CTdZ+uRZYn5v
 extNqFMak6nLi8DXgeuXzYCSaRQC6CVga1XnSZeUSIz7bcM6Jv67dWdHyrg==
X-Gm-Gg: AYBFou0l9JVPuy9IEnBFdQLipUCrvvhPorgISIFESVvzUzLANoyghlytG+/tWJaVDZU
 7/Nz5R94NixzQlpTICdio+faInK/YknMEbIx1GX66DLED3bykPAeYmXp4/wVF8JuWMBVddnvWY2
 HIw3Gh2HOYp7T2HThTpgC9HwqdFCdOKcZ9NZDBQDOmhMeFnz/aqkzyCfI/jBiWRMZ3FmuFfWD1w
 oOkNAu3P5WKXn9XG2NZBEfw1Gi2kUbDufrwd1kDB+Zey+Jubyye4D0bzyWgFVkiMmdMkUbt97im
 lQHJKyQtQDjvrd/+Lb+vYkszilKHMBUqMDKXliBj6Fybu2hvJIMRM+72qz/z0Bb8qMSChgLw36d
 /ixptfR2xAj/TWkX5EC3ByqXeCZR05sBpmlUq3yuffgIeLiEiszwdUx+79Mmk522QCnylUpNbAC
 umCTEVkxsf4r7URgV1fLdd0uo=
X-Received: by 2002:a05:6102:2926:b0:7c2:5692:1917 with SMTP id
 ada2fe7eead31-7d072bb3731mr765794137.10.1793362004083; 
 Fri, 30 Oct 2026 05:06:44 -0700 (PDT)
X-Received: by 2002:a05:6102:2926:b0:7c2:5692:1917 with SMTP id
 ada2fe7eead31-7d072bb3731mr765786137.10.1793362003606; 
 Fri, 30 Oct 2026 05:06:43 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8c0b6sm2738664f8f.41.2026.10.30.05.06.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 05:06:42 -0700 (PDT)
Message-ID: <bda55d2e-cbb4-4982-90eb-79f9253948ac@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 13:06:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/31] tests/tcg: Massage MIPS tests for easier
 maintenance
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
 <6d7b237a-6adc-4768-81bd-1279def10381@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <6d7b237a-6adc-4768-81bd-1279def10381@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -kF8wp4bSH3i5t7Izegj-c8S4np_2zln
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae48855 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=xYDe3cNB57CiHjtmA1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0OCBTYWx0ZWRfX67jmKxR4bm/x
 bCPd741KXLc7WX+UjecgRu/PL0cZWj7R59uFz/c7z1ehk/CjpbteLNuQJ0QSrvDh6myTqxrrwD9
 KWdKo5LjXehuVlQsWG4+fvsMJp0uolcyTJd1/r8apkNYA6LSkFJYGLYr0kt3qUru08O7vBlWgDl
 VZF5XNw0mHMKyxk1paalEAq3VuaQs4uCsD6uRqjcXfKkm4pTApIOpoyJ0nwm8vay/ARKrLrwfu9
 YzbPN/geenUUlUtzFdYnszuQva0eZrJDPXtK2CzNnj8z6SjbZv3TFjiIsAmU7rCkUQQlkgGLQTZ
 qo/lw7AnDNwCJIpb4ZuSTWFvDkUYc7MwkiZyNhlJckUI98ixVeq1eZzVg5E3tjJH7h2NENeIfIn
 5xHvStgwavknozqOgRx8X1RPRvyD6AiL19hvsc7InIqWvr+/piAbbDK3FYWuoXFnrxfPY8piOXT
 pXuK5QdgdbCOqj2hZ0Q==
X-Proofpoint-ORIG-GUID: -kF8wp4bSH3i5t7Izegj-c8S4np_2zln
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0OCBTYWx0ZWRfX9bqTO7ZbONvX
 MbbcCSJtp9d1Uj/NF13lG5cLpM88NfBYgc5I+vlJhEz3vUsPyP//weusMhOmfYjj/rMEX6dATaB
 XeKDEiuFl+eTn2j4KE44uI8GsyvdV88=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300048
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/26 20:23, Pierrick Bouvier wrote:
> On 10/29/2026 9:22 AM, Philippe Mathieu-Daudé wrote:


>> Based-on: <20261029152009.19812-1-philmd@oss.qualcomm.com>
>>
>> Philippe Mathieu-Daudé (31):
>>    tests/tcg/mips: Group DSP acc tests
>>    tests/tcg/mips: Group DSP arith tests
>>    tests/tcg/mips: Group DSP cmp tests
>>    tests/tcg/mips: Group DSP ctrl tests
>>    tests/tcg/mips: Group DSP dot tests
>>    tests/tcg/mips: Group DSP mul tests
>>    tests/tcg/mips: Group DSP pack tests
>>    tests/tcg/mips: Group DSP shift tests
>>    tests/tcg/mips: Group Release 6 bitops tests
>>    tests/tcg/mips: Group Release 6 crc tests
>>    tests/tcg/mips: Group Release 6 logic tests
>>    tests/tcg/mips: Group Release 6 multiply tests
>>    tests/tcg/mips: Group Release 6 shift tests
>>    tests/tcg/mips: Group MSA bit-count tests
>>    tests/tcg/mips: Group MSA bit-move tests
>>    tests/tcg/mips: Group MSA bit-set tests
>>    tests/tcg/mips: Group MSA fixed-multiply tests
>>    tests/tcg/mips: Group MSA float-max-min tests
>>    tests/tcg/mips: Group MSA int-add tests
>>    tests/tcg/mips: Group MSA int-average tests
>>    tests/tcg/mips: Group MSA int-compare tests
>>    tests/tcg/mips: Group MSA int-div-mod tests
>>    tests/tcg/mips: Group MSA int-dot-product tests
>>    tests/tcg/mips: Group MSA int-max-min tests
>>    tests/tcg/mips: Group MSA int-multiply tests
>>    tests/tcg/mips: Group MSA int-subtract tests
>>    tests/tcg/mips: Group MSA interleave tests
>>    tests/tcg/mips: Group MSA logic tests
>>    tests/tcg/mips: Group MSA pack tests
>>    tests/tcg/mips: Group MSA shift tests
>>    tests/tcg/mips: Add MSA load/store tests


> Series look good to me, minus the comment on MSA tests duplicating their
> groups definition between targets.
> 
> With this factorized:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Done and queued, thanks!


