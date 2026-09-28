Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B78C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8s1-0003Y9-M0; Mon, 28 Sep 2026 06:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8ru-0003Xs-E8
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:46:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8rs-0005Gy-Ta
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:45:58 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MD13322684
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S+/nYMf2SuyIoNtR7go2FiR2l7+JJFOGteA+TzXIpBY=; b=c4YlHgwuo2JgG+G+
 MUP6lHOqnrjy0NKJjGSnrHzbjqq2Kx9ZnjG301YSzK11K5BnBTrOg/i6zjuIiq7R
 /B4DCOx9mvnHScbBpYUlaecehkZ2P95zjwsFbzaGSYGhZGIvYTykQe6j8KZGJB48
 Izz+j8JSFzapPNyqW8fqyKmEmWhLRdgyI8Rf6+P58ZPmyRGxGAlNvegPhK+s8rmP
 eDW5GMV4M7rFrBixF9y0Yu3zMg330t5xxYw6oesjtBj7t5ufC93Xk9au59W0wJGI
 zBsPZ0oxZFwW7WA9aWS5o/g9cdVAdW8SIBF2MCK8UAGguV0+dV68+rAW6cyLZ3Kr
 YvjS/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq1rqt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:45:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c6a0d2122so255229885a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790592354; x=1791197154; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S+/nYMf2SuyIoNtR7go2FiR2l7+JJFOGteA+TzXIpBY=;
 b=X6tDBYi8UYYO1aeThpfnpaDv8DTdAyHN6zHf34Oz0wK6jXu7o+aatAkkyF4Fpr/7gp
 hCExwrbQJCXMD5lWdDN2p7v7SQljxULWIo86Um6ilJ2YdNiU8fNf+kFMs3GYQJNWzCSH
 kWZ2r34QuuYWUkGiywTj2m33mHtlA7N3IyF9E7ney9goc9dtEjZCzqOFPGAS/TyDzTwG
 sJp86BugtHZGhxqTGnYB/stYYisFLiVf3qUxgTb/bRswF8Z8tmWh7IfWtW5p4K9tMsFg
 ekI3paoAPz+Ydhr92pN3A3x/FVG1RNBChrjqlhAKT4JT5N56kG3Y89UVJJKDl5rh+XXj
 Dnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790592354; x=1791197154;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S+/nYMf2SuyIoNtR7go2FiR2l7+JJFOGteA+TzXIpBY=;
 b=npBBcNcLv+CFRAFX576gGlNsvsYk3tHOUOGyNjN5gsBG8/H3p931To4xsYKPMkLa40
 QUe+59pu9B9Blfst9e8bQHytu6FJrypAJAdV8mP4YfmavzgFPPEoWqNonjVFkHbQYqOW
 4yF9okRCaRbNm1tCXwpP6ulrc8rzh2vjzsQC8OclsyWZQEWnwPyBnKhuRzuYsYIpfsxE
 VM8NPyLmPXuO8ANfEGAmv7lMeTPgevIlX7M8iA7igYOycJTuPwxT1+aa77kvDz1zuqUl
 0FCetwvPSuYWzSNA3StnzzPw9qS7Xg5MjWyYPinLa7aRMPN87pNSqJKtjjt6HKdqA7kL
 jdDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuewSvbel0y7gFg97UFiAg4Ux3MnijlEdofsq9qIio3yLVWtytE9Lbg+Cp9v9xy8y9sFzr4OBvQzSB@nongnu.org
X-Gm-Message-State: AFuF++kjN9D2jAmJSDvxwapIqKmExxgOOhtDtSdtr9IGzPE9jmvLNT5N
 4a49Z/qIXxOdYHW0JJpYWnJVr9UNv/7y0qV6ZXvsPARS6Idh2i//nbeVS3L7Q3KvX9FrNx6vAza
 8jAW/8ZqSL0OonV9Z69fs/vtUHMWOPN+17v8OBxkNx7Lnf6J73QakMH3vwQ==
X-Gm-Gg: AYBFou3rJgwligDEMtHVQiyGDWVYJLbFtUevlp9/Dr1D2pa1cTpyRr7jiUa68MjduuK
 MmDLajCm4XEbgnyqJLIIEb7I9fKzR1HdabnBkU9sbv+4PelqjGIrGcrSmctAAtLOSeyOMawhilG
 dv0sd+PsTi+X7N8uqtlLcuPhjK23pMD8ZK1hrP0qHCWwKf/EzB0IlKFY4rMIDYJ/zRRF7oEehBG
 IrMNyLU6D6nfih2KZjS53CtgrlGsluXWx7HWspilRLhiX/HZfp5Jf9aHokk3JUity+nRyYwPfhu
 T8AWTtDjldpKbvV2pbd3ITlkhCuqux0YfYq1MPrU3bt4xdxd5Aoavg0axgEWanhH0LpTtl3A+Re
 cuDYSsJmkQM25FwXkGzjPFvzj6Tdy6Up3qQ==
X-Received: by 2002:a05:620a:29c2:b0:93a:17c8:a1e7 with SMTP id
 af79cd13be357-93c43ce3395mr2050370485a.44.1790592354279; 
 Mon, 28 Sep 2026 03:45:54 -0700 (PDT)
X-Received: by 2002:a05:620a:29c2:b0:93a:17c8:a1e7 with SMTP id
 af79cd13be357-93c43ce3395mr2050367485a.44.1790592353827; 
 Mon, 28 Sep 2026 03:45:53 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30c43asm28066318f8f.3.2026.09.28.03.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 03:45:53 -0700 (PDT)
Message-ID: <72defa83-6c1f-46e4-8927-ac4fd1a721b3@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:45:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 071/101] tcg: Generic expansion of tcg_gen_smin_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-72-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-72-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GTQgNs200_Ew9PDuZqshhy3fpoiNDhmy
X-Proofpoint-GUID: GTQgNs200_Ew9PDuZqshhy3fpoiNDhmy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX8yf5y8mQCzhZ
 fg60/Y21eHHnkt+rnOAVGJh5ZMnvJ/CXAK6emtQiNFJJg5YMRbv7/JPKrSiTU+xUPfWu+U4y/f2
 oIw7KUgxEvUwjLe+KyevB1wAvXcT06I=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba4563 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX4qrNzSEQfPUT
 0Yt3xAxAJ3d83Lnjjk2LNM2pPR+YOWUMlzalIljMb39iFtp5/zaUBns/+mqb7RopqGHSD8basek
 eIWp7jXL8PxDDRLKYMG+rA5TbKAC1jqAsV9EGTqQwu7fkIXbxG92UKybxCmPHxkq+TvMWPCjBA6
 e7zSf/xOMaj0QHDzttvj/XliV56Sh9CeZVmlAQWas3Pw5Xa4SaI2ZnSSxdPa5fRliiL41SXy5s1
 9o75EKcl7ue1ck/Bl9pIwDAjJxZjXD66I27/duSa4ANI1l59uC/G04MwjP4qyY4AOV1iyhPrtWi
 gIRpZslBlOa95rP9TTketmrOGTonMnKNF6XDdJ80D5NLOCnDkQv3S/0Cu5xf3PYiq3PMp8uI0ye
 dTlmnTx64gDb7MRaGEvaBczQgU/1JuFcAaLe8lHwBf+XoK4T5ZXBHT4vE6kCHCVbHYxrnFtakH5
 CVJg3VgI3hXe65iQrnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280042
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 27 +++++++++------------------
>   3 files changed, 10 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

