Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4B606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XhhgH6ky;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KsPltQh2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQNo-0004wg-Bh; Wed, 21 Oct 2026 03:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJQNm-0004wE-7m
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:05:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJQNk-0007Ou-Eh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:05:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j6EV2411218
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u3TdrldKGm9+WJ1OpcUEAuq9cahqtDt4Q9OS43UL2Gg=; b=XhhgH6kykDM+uRgQ
 mvL39DyY0dyDTT2ENq4lJSL2la/x1LRWkvi306W/RaFSuGafMSP1aRS9tfXyTNHk
 VH9GM3LP1OI20KaPRoutMe5v7P7S3hUEyiauOWjgGtkmP/QspAYvoJt1HIAgfQ5H
 n4GE5v3Ar+oHKE/KwqK1ujo61q0qRenomdEQKqtCO9TmnwNgOAtblzmXRSVEMSis
 XMEYHDVPlzoFblUnP16RZnJWXwDBdSKMI20Ki4BwXPvCIeqU7nVDa8cQ4OMk6/pg
 bpmArb8ueGmNbMjHwu9kLaGHIFm9QksjJtUqxHXATV1ep7jp/kdTE67U6loKyBNG
 IAUbIA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hvbxh9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:05:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9308eafb465so135242685a.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792566301; x=1793171101; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u3TdrldKGm9+WJ1OpcUEAuq9cahqtDt4Q9OS43UL2Gg=;
 b=KsPltQh2ouXKoZHMxgN+SL6fB6j7XuSB9UgnsYWZ6ux3cltcARgstxuxTPFMR5DzHI
 xQe0F4SsQwkpT6wT4fhDo6x4WEPKBTdBMT4aUc2vXHdY4J0tBRG9/SAlXixbdzWkfVGD
 EIbA/qI5E/45dQZybcCZtHQnaCn/ZRakSDH5H8tH81bKVj5PF9KVtoCBJuBCJetUpj6U
 2+meXNRK0OKE9iN2gGqBwypN87Jbz+6Hv29w2uK/7uYrTzfFGtGSqQM3DiatfuCbFQys
 9pi9V7aq/C6S+g1BQBRi+9UAkq9PNg+JQi88rRkHlNKWg77pnw41aBdia+LmcN22QyaS
 PssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792566301; x=1793171101;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u3TdrldKGm9+WJ1OpcUEAuq9cahqtDt4Q9OS43UL2Gg=;
 b=Y9vwozGRlcHbguLh0n4GV1ThFlBbgAxcKguv1KyzsZFDRy0bZxT1zXJsT05DGx8roC
 SHTDJttaVGVp+9cDDswN8vEzqyi0avXlybGNOf3ZL+idLZs7QzUZ3Ku0/m1HxWCd6Cc5
 bsW6DOMIdxqpsG5mVGBjZ5nW6Cb2cyCkDXjzLvcUr14A+x7HmsWMrSM1JUPtPHUNmYrc
 L/YLX0p6WxkG6cMayLmNvxqJ3P0kWKz5+AQq+RM29a4ITk2YgfuiqlW2IEbv0QQThsQY
 awEUCDsIg09fwPOybZMVeScenqGpu9rhV+BVnVFwxpx0iJZWnuxiQLaiFWM3QpwXmOXt
 uObA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrvUgQqN4uhxaeErovTU3QH5JiSS69lchCFuj2UfTyEs9lYLpwNntcG1UxoULnoHRnBQnvgvsvGUJZ@nongnu.org
X-Gm-Message-State: AFq9FYIEEJKR+kjMnGmfnC9EP7dFUThc9CS3bLm5EgQx5ux9VytXCMB2
 rnoqs9XU1KKJjCGvDNm5XAwTngyAS6hsMjq6ZOpEjFvEcPXoqnt1rxkVJsqyQTz+HXuDtDl7jrQ
 KhMH7dGU3j/5wwOohj7ReKKY2bv6ZYnwlPJbXTH28uQqzfPvrXYZr89DgyQ==
X-Gm-Gg: AYBFou1kRKbUmtCPsoz1GBWDcEgUX7ZjHNP9my60JXgDwKPD+tYenJAbN6iHbiEx+Dc
 IhOwMq4zkL8SPuC9KGwaL6DwF8Lo11CUoNKZU0w109fkiOQdW4EwR+WufeCSJh7X9TkGeSXgbQr
 IxroO0aLeKXV05+StmG64vUuEnSprm2f7lT7VZIi/yOC2pZMS1p9wI3uYLsvhp9obRVGPJjrRV0
 WgK/rQtGoH7EGCcOwXSmZRfFlM2k/JRQes2q9FyWQ1FSpcz56GBiAZm4L/V0wTRnkJnuHy+2Zjg
 Xw1zMeqNhfdNt4lNfChgmBGDd2Og3FHYl+hEDy3P7+7EyQ2bM4uwPqDC2L9AqJqJ6+FOIvoTxX2
 OMz8cLnFPlY5t4i0SDgxvnpj7dtreL//aEQ==
X-Received: by 2002:a05:620a:4586:b0:93e:942f:b8a6 with SMTP id
 af79cd13be357-93f57f7da12mr276489085a.59.1792566300957; 
 Wed, 21 Oct 2026 00:05:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:93e:942f:b8a6 with SMTP id
 af79cd13be357-93f57f7da12mr276486285a.59.1792566300505; 
 Wed, 21 Oct 2026 00:05:00 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581efd9sm3496726f8f.18.2026.10.21.00.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 00:04:59 -0700 (PDT)
Message-ID: <c3682c9e-9174-4c3f-b38a-d4215a8b2342@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:04:58 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] target/sparc: Add the eight AES round instructions
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261021064640.3591682-1-stian@itx.no>
 <20261021064640.3591682-4-stian@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261021064640.3591682-4-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNyBTYWx0ZWRfX1m8UP8JsvYUm
 XVaPEAb4njWxMffMrAIaKGNSTihMEWotiwOBRigLS41Ruk2NzH05LqAaraC7rUZnBH8Avy7FEUD
 9Zso41ZiS4LtXFK1k3SkrsVCO4z2FKG6viQnI5PKXEXi/884GVBEAJfbB4GFMcwZQ8InTmYc5lD
 oMOZI0Pmis3UbLzAvevdCSw1P9/AkEh+Rwr7MBAyZuBPpKdVBKnIvDD4bikDcNk6Ho5MXHI0dK/
 OrUgcPTItQSEJxpoHfvMxY2sJBJy92Rky0oBugDRAiOZvXda590Hh7n8RP8dF+NCrXpon7mhdeI
 JObCIbHJ5TOVco0JBKRDWUbIfAv0/FJRUhslI/43xFsKKcTUTwhd3xDk6+mkJcYsqpPk7+JK5QS
 K824MPh+PRMzKAj8060IZs+vJke5TImDI6yEMM6Pa21xqir6cgX5UiOCC3ghl3v17h3I/8hsV6V
 EyezfmGvBbU9CE3W3qA==
X-Proofpoint-ORIG-GUID: Z1x4XV3qD3Udi1RdlotgZhEAgRbMszzw
X-Proofpoint-GUID: Z1x4XV3qD3Udi1RdlotgZhEAgRbMszzw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNyBTYWx0ZWRfXwBg6/k2k1dWe
 zgPfajSJnU47MX49wQpHJDT+IaxA4oz+6AHvdB27Weno5jbScEmmRNwtdp0S0lT01jHVSDxqKhY
 JHMqh/lv4b0mpMuVgbxkYJKnGBSIW68=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad8641e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=6cxlYHhMr89IwoqP6GcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210027
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21/10/26 08:46, Stian Halseth wrote:
> Implement the eight AES round instructions by using QEMU's shared
> crypto/aes-round.h, gated behind the crypto CPU feature:
> - AES_EROUND01/23 and last variants
> - AES_DROUND01/23 and last variants

Maybe add something in the lines of:

   "Next commit will complete the feature and expose its
    availability to the guest by setting the AES bit in CFR."

> Based on OSA (Oracle SPARC Architecture) 2011, section 7.3:
> AES Cryptographic Operations (4 operand)
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/crypto_helper.c | 89 ++++++++++++++++++++++++++++++++++++
>   target/sparc/helper.h        |  8 ++++
>   target/sparc/insns.decode    |  9 ++++
>   target/sparc/meson.build     |  2 +-
>   target/sparc/translate.c     | 16 +++++++
>   5 files changed, 123 insertions(+), 1 deletion(-)
>   create mode 100644 target/sparc/crypto_helper.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

