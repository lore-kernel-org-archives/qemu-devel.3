Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3562CC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuX3B-00013Y-T0; Thu, 13 Aug 2026 11:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuX39-00012q-OF
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:08:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuX38-0001Hs-B0
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:08:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DCKVVa2404591
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 15:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VdkRK04FDeRPJ2qfha0pI/66lXLx4GB8NQd8NBviL9I=; b=fYVfr4i37k9jfotv
 Btw/iNc3B9b8g5Oy8tSSHKs3LPlpvGFNQwjwwogdX2w3GKZpwRNOtXhQoX8at5rj
 xyGlE00rugNlCduwNpRneylokzaNsmBuY/AVriOCeXX/vkgxPROfGtZN8HJ3RCMB
 Op155os7Ag1rMaWgaHbCLatEiQfPgPBSR2KUQHh6y1V0a6vklM371yfJQwVSU98C
 HhrK9ilPWcKwdJpYg0YTBwUzvu/hsPNCzD7CdROxlMdi/J6/6JH5zKy+5IBn9OiD
 7asn0dPAH++EfqqDqi9rmi9cYb5X6JShW6hUja4+173vB1/1WVDcVZJYQZwuhMf3
 fkQaAw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g158gawdg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 15:08:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-529ae8e96e8so109011cf.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786633732; x=1787238532; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VdkRK04FDeRPJ2qfha0pI/66lXLx4GB8NQd8NBviL9I=;
 b=L7/L/4jJJ+kFxZU6EI15daRCbIjZmmLf8qdcXT2E7cIU5ZSm5GPsCwUuOQG6OFKUBz
 oOl+DMJV8pqTs1ekLsSADSi+6mnmqzyzGDPnEf7fOKDYwr940fgOWovp5md28Vwtagi9
 j7mXejuR7DdRQnMipV0crvSNdN5ThD1rGvz7lTUAEWu1537szG83QUT/QeQhwkkGOYJr
 gdLYMXUT3nPAypFVDTeEetkK3d+XGTAls7pRoogXKwjtZp5JFOpwpIDmkyjgeN79HRHL
 Akn0Rc/QEqYlCl+lbVAmYad4xkZYT6ZQg/rjXLCCg0imtsuIPzThMfEKS4UHWO2zTaNw
 9mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786633732; x=1787238532;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VdkRK04FDeRPJ2qfha0pI/66lXLx4GB8NQd8NBviL9I=;
 b=epgCzD9aEuTei8BsB0QeQsOwctG3k5AudtMXPOg0FmLdYdIunSgENbebScYrHI9idN
 6PGe/4NEfa0mUQr91Y/8JkSFXPjlwOFg85wFdN+mH3T+GfaXwAd5y9mnKsMRuYqh8giM
 nMvULG6vVaF5O3qF3K9828afxKm3MfGf9GNi0SMfJwyV6hdoCCeVTxHxCsll4jCqNTeW
 F9QuFbXdq9Y49E752LEtUHAR9RAEu2yukzkrIoYKi7dv58vO8TCOX4tkOvX+J2O7S1WA
 zyHAL2h+L1VuOGeBuUGpq32sLfJLq1b5XM9TGD/cfqTO/LwIFH1E/bjerNsDaoSpyWEx
 C5FA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrzj40bVhbv+4hkEUO3NSnYMdNHu0W3pvA4HI+4Ny9tcCXtC3AAhfPTckqelbYU6qEAiN5iJ+Mo9Js3@nongnu.org
X-Gm-Message-State: AOJu0YwQh/dH7Dae+3tfGH1EtFg00waCX+JjjcD5Abso6zR/qLg9Pme6
 X/hU2SUH46vT2tLBgFqz9wuyxLhjG4FvUr5L8kwZfPZqujcYqSO78JglNZeHx8m+1R4b2TW5y7n
 L2gAJjQFileEISfY5k2a3dq7cc9vblXa0/PsVenOagTezUC8leV4ZVv/5elKMhvRsXw==
X-Gm-Gg: AR+sD133OS+GFZvTDbXwgeWBAkOvIihgO6aGr/2VkhadC0qnn9OrQjL3yvhrSr0G55c
 vz40JLDeksh0T+zEt4jAfACTVsiK+GpRsK/wM46Kttx8/cAB4/kGnFuzLvXL5qwUt8MSyN5zFEK
 JmkfVPonfLT5ZuY/CJuY3CXIwVyOsj8Bt5PIdB5bLMZp/uejbJjlqi5DAELE29aEINx2SeTuGXB
 uYxQqXQII22CXwEeuodoOCqkXuAoxtwRfZ18BnSZzwJqySXdsO8Ys1Iu3hqzjL4QMAmBa+SQkdQ
 xRg5zU7sg2v2Sge1tE/P8c+H6pirj0nPv3aJPQJ8g0PJSht4GwgtzNB9ocduBJSjJD/xDssOTch
 676psSpcMcHqwgqVE0qW3bB83WJuwkWWP2pk=
X-Received: by 2002:a05:622a:4088:b0:51c:61a:50e6 with SMTP id
 d75a77b69052e-52d73bef81fmr80752871cf.3.1786633732235; 
 Thu, 13 Aug 2026 08:08:52 -0700 (PDT)
X-Received: by 2002:a05:622a:4088:b0:51c:61a:50e6 with SMTP id
 d75a77b69052e-52d73bef81fmr80751741cf.3.1786633731653; 
 Thu, 13 Aug 2026 08:08:51 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f219e12sm46883f8f.10.2026.08.13.08.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 08:08:51 -0700 (PDT)
Message-ID: <8d63950c-4727-4089-895e-526fb3889fad@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 17:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tcg: Return success from tcg_region_alloc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: yvyas1991@gmail.com, qemu-ppc@nongnu.org, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com
References: <20260813005031.518387-1-richard.henderson@linaro.org>
 <20260813005031.518387-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260813005031.518387-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: e7GOeN1dyTe2RDX6qFn0b0BtaYGaeoTa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwOCBTYWx0ZWRfX7iBV6P0ZaTl7
 BYNumRIXC0vSUReK69Psv22632Q0AGO9C78js4nU9UbtD6dpHu/7llRui6vYhfCY7CpnYiuwrR4
 6UkJNvcPklp9amHTNIZpMtV8l/lOyso=
X-Authority-Analysis: v=2.4 cv=G5ks1dk5 c=1 sm=1 tr=0 ts=6a7dde04 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: e7GOeN1dyTe2RDX6qFn0b0BtaYGaeoTa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwOCBTYWx0ZWRfX578+1eD6PpCB
 GKojI9Q17iDLB367qHa1RCnYIfPYXNDMQndDWdR9gDConhriJ/tVhcS5fGbIZ0gNxiaCSWutV5N
 ShzX1no1KiHzITrBluvLL82u3DDPQaLwtE4r4dgN2en8qS0jRXO19HajkT4cEIovzXD3QKKFT3b
 tirJi4kjAGS+GjEh0Cz/8FDg4UaclXRrV5xvXzYW/ILlHC8BkxiXbyOWvSDKbAxdkbwVluK668t
 ElBeygdTDD+XKIR+1G4jopUHyf5Y+hMGdfA+4di1fbAP/J7YnAtabX6ZmUqOcJ2jWuqyjkfAP3n
 qXiZIZin443wm4rK5yGDRNIKHwsBovLyCaoDJIBoYIYgUqLiNnAuF2H9pijowMuB32t7XgRSy1K
 vMCBW0tH0l6wIcKs/iMqDwEAjcF8eaPt5KlAZG4SFEGZ+CxwnoN10iBe5KL0ZHBzYBbbAjjdzOL
 Z+3tq06uxeLJkkqUsiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130108
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/8/26 02:50, Richard Henderson wrote:
> Invert the sense of the boolean result from 'error' to 'success'.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/region.c | 2 +-
>   tcg/tcg.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

