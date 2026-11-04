Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B9606A32D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X3V4tMPN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gu7BZNzJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOYxp-0006re-Ji; Wed, 04 Nov 2026 06:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOYxl-0006qa-Tg
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:15:29 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOYxj-0002ud-To
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:15:29 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4B5xLK050753
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 11:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cBWjHLS2gd+cq3OzTEQiVTvP2VPkyUEDy1qkunYvkPY=; b=X3V4tMPNYcp2lw02
 0RLjP0duGw9GjawWyeAr0xAiF+s1+6NKJ7tikTdoaOGqjhmLJ+0/hj9ndpw6L7fv
 6cBt118a/T867UOCPYEt7tonXjWW4gAI/n/fp8+J9UZFxrToWNJveAz/fvrGulNE
 xLbb5EYcyk30+3x9TGBVUHtnIdPCWQf2tS5k2dL+5VzQIB/aXaxVJZB+CGvCE7E0
 JjVRTAPf7vDjA1LdduCJ6+y0Gn2qUM8VIu9o4RtjWjlQPVY2PWJgDg0A2AAyFHeJ
 t/7GMeCqZNa2BO7Lo5KcPrVz+s44/i61gXzt2X8WyCJ3PKWEwSKWeN0yQhHzfI9B
 jcWNqQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqwb09q37-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:15:26 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99859876e19so119462241.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 03:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793790925; x=1794395725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cBWjHLS2gd+cq3OzTEQiVTvP2VPkyUEDy1qkunYvkPY=;
 b=Gu7BZNzJ7qh6HTcN7MQ+BgnziYCgn3VA5e1GO5f/Tbnd+glZzNF86lX8pmIHSlBOEF
 dGvFONoHRdcrPxKuRtTiOSj46h+eZ8pdWUdqIqxciWeGpiElPkqSVDFx6ipaKdQRD46F
 2OgTAN4+eDvgrAsbE9F2SiIJ6l46Ky6kwi/4IfhJ/KZCxOgpk6Ps+kRYK/ZZZXnnZps3
 42nat9z0T3BsqEE3ezOC7mLCqz1lemtdtgFpAvCUlhE4wrfwz24oh/mPibgwnie11sj8
 UilihJn6CxuQ6bUihCm2gxSdt1QqlPNKLT/VPJZVcI6vnSvbD3+ApiPLCWIHccS4svcX
 VlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793790925; x=1794395725;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cBWjHLS2gd+cq3OzTEQiVTvP2VPkyUEDy1qkunYvkPY=;
 b=Ns20mv3EfOxJ19kUfzot+X4PImJ09uwjI14T8Ddi3fWnW2AQ2xp6xG9W0lQYV0wsMD
 R9+GsqVlIpYIkGjgAcrN0UtVMvgsl6RarlDmhS04L2mYJ9fFaYpMdAUUdDjwzEPnGIrp
 bbj5Zgfl0hFYH23ikM/vDSfRrqHDSWLRRQJ5DCKELl78BYvQwQLpzueC4XnsgaQG039u
 xqAd/jbhifb+mkbEPtRR0UWI4uF59gxyWgtkB9lHhbEjPqsRcB6LHEU6EtQ+kbFO3CIL
 1ZfR5LPulcvSErZdaCPLOHVYuZtt7QRDB34qPyQ7NlFyR0BaxdhTjkxG2SC0kRqMtVv8
 1nEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUQsVVBFLH72uzl5TuGLRqAqBTWfsNTw0Mz5jPM9xB411zBWDbCJ+uoZFK21ycg5ErVDSUMjAis44O@nongnu.org
X-Gm-Message-State: APuU4Z/t06WK64c7C6tetdrRN3duTWu2KsCU7/lxKrxmqeiSBHNelWS3
 eL8mmYE9iSaZKHIXx01Qi/TTFLNu0gSm3hVYMkcf1F2FzqM/IhauHI+od9qFz17ojWuIcPDGx+k
 2uldV4QDOJaRtWGT87v7NLHeAEvWh9bRMKcA3NtEEwd2bX/l3DJPClXtrbXYIGdfVlQ==
X-Gm-Gg: AYBFou0fKNIO1W5o3bfnkc1QtgtLNvmq5aYiGl2iv2ImKnFuExTaJDu38q9Et5dn0kM
 4pDIdkNc/nfS798lMd68zoBfqe+RyGhf2l4GgDfSQ71pt0yw7OjiuUD8biD+f095nrx5CYaHk/g
 rBUIbKLOmp4LBR5F0Akc76MJeKIv2ezxOd26m8NoMHBJGfuUxV2W0Z8nkCw+jTSwuK+hXmUsLPK
 AAqjSRpe143Bubux/dVJYlGXwrYjkmu7wBY5UFAIyoBLAIASu6gvXlQtz0jqHxo9OiGYidNTtSb
 +a72p5OJxS87SUQp9VoMsvx3UQ+p+KigzyhAe+l2AtLuBDXMAf0FBDRgnzUfvdes3IN8u5gez3v
 2H351B+wdVpAHYKluHub9C4nTzARLvRyga3+8fVSRcQTpFJij7Gx7awXgQZBPIr95xt1Qiel5eG
 xtaV6nng==
X-Received: by 2002:a05:6102:f08:b0:7d0:5688:f511 with SMTP id
 ada2fe7eead31-7d0725b54c6mr6169366137.16.1793790924993; 
 Wed, 04 Nov 2026 03:15:24 -0800 (PST)
X-Received: by 2002:a05:6102:f08:b0:7d0:5688:f511 with SMTP id
 ada2fe7eead31-7d0725b54c6mr6169353137.16.1793790924462; 
 Wed, 04 Nov 2026 03:15:24 -0800 (PST)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd43bsm3489489f8f.14.2026.11.04.03.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 03:15:23 -0800 (PST)
Message-ID: <d0a0166d-289c-4a96-b159-425dd74993ce@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 12:15:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] tests/functional: fix call to common_tuxrun_gdb
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261029161310.2065290-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0NCBTYWx0ZWRfXxIrmjjgs9h9V
 xFHzJSDZdvYlYl5TJalTYM59qFE807fXvgrmvwx9dECugAY0yn2WVM2juwZbTAzj+feEmsw/XAE
 JIfkztfYaktB9sqm5XKM4+ujRVXP9Vg=
X-Authority-Analysis: v=2.4 cv=OfINnRTY c=1 sm=1 tr=0 ts=6aeb13ce cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=g60KYKktA1rzS1tZlfkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 8pnHTvz5elWCRrMNoVc8Ph9f4b27UO_k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0NCBTYWx0ZWRfXzVMuTIDg2mez
 v3Rh957YR6Ocs9BtCwxAslJm/HQ4iM4Vi/9xDbKcaZ8z+Hsre3VmNCQ1aeFr73H9Vbo64xNiwpM
 nCjxGTxXH1ymx3gXTjAnkc+78QjZc0iMAGpkh92nnXpSLYtp9s7bpleC9Gsb9QdD7vO3CrVxdUe
 2be2AXGb/hezfJNK6+HQe9tSaXpvR0jFUY7379wylXV//ZMFnTBK6rnnN5+rkNxYef0EK8OxYfk
 RlUNyY3GsirgQtdvs5bqcKXh8vc9qEuApsjciKf56MmywW8udJKKqUwL2P9q6d+UYUnhohdgLSs
 eaOYBFzd9SKPB4L5yRT/ndXwguc6Y59UtcH+8ZMz9vl6F99TyVIGY9z63ouQs+VtGwNPLKrsWLV
 hhxwNg3EJkmoWWGMWqQCcF26ZppnLZlNFEDjdgaBITenbCiPffsGDlSs0ZOEW3eheUNADm4cSE9
 L2KLFCWXqrePxgp3ITg==
X-Proofpoint-ORIG-GUID: 8pnHTvz5elWCRrMNoVc8Ph9f4b27UO_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_03,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040044
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/26 17:13, Alex BennÃ©e wrote:
> I applied a last minute review fix to the api as it was not used but
> evidently missed the one place where it had been set by copy & paste.
> 
> Fixes: e0a7139b2134 ("tests/functional: add tuxrun kvm gdb test for s390x")
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/s390x/test_tuxrun.py | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

