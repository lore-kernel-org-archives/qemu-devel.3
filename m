Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ABAC98310
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9d0z-0003La-Pq; Thu, 24 Sep 2026 02:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9d0y-0003LQ-7N
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 02:33:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9d0w-00088A-C2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 02:33:03 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O62MAM1475893
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 06:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pOV0DRkJ3z0+F16G9KLp+0zcRdpiv+nDLlnu7RmmIO4=; b=RRgLepzggy2/bTvH
 Wo3a/ueQxl71CnlgPx4ARChLbbICyWh44P0IAS9lKsjCH0QFXv3dn0vSlGPw73tl
 AOsB/QIp2DRBXi+Aavd1qjHxXBaRvSZ7V8kUgUNSAtvI3sib3t2CQHZpYFFN8pD4
 j1OJJbCCQfjOWyQ6eHEdlXTbe6N5Il3m0ir0CxNtHE428ltvPtcgPx8xPvfvq6Nq
 PQW8x1iMVZHtT1JzpZhJd1gzHuD3K0Ah3VD0jO+/QXwM1cO47/BDxjUQI2VQvoL+
 o2+ErNKAKvNmiMBBvrPbx5EouOHz7aZEfMSJq4SECruYH0HoTZYCa2REyctk6CTG
 LxL9kw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvx8ag41v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 06:32:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a08ff8451so271020485a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 23:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790231579; x=1790836379; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pOV0DRkJ3z0+F16G9KLp+0zcRdpiv+nDLlnu7RmmIO4=;
 b=QvLTrOTcp9zQkxRzJFH4gMhh5Ri8SyUQ0K5TZ9LaR+J66vQCPmgZgcQw9EDU7RfQPy
 bTuKVZ6XBfb8muIsuM96uYKnxjifTsR3FR6XtDkLtX/OZwe4r4SVqqKjuWDMT0PFyX/J
 6QR4sXyYHBmMiELjncZSTw/8z3mNMNAMhNp4zG/kQjWnZYDOBwbnws0Y87OnWgW3d+K+
 T6qUxJ+V1yA5km9vBqmQBsxXWOpOYI3P6YSgYwYbuCcu89x3roUmoHNsUO9YuMF6lF6W
 Edk9FG/Vwov7Mx+95KZnq5eAtIAntjewGGJ7JL89n/K3Sj+rr7kV6KIjJMGPOECp+GZd
 e9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790231579; x=1790836379;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pOV0DRkJ3z0+F16G9KLp+0zcRdpiv+nDLlnu7RmmIO4=;
 b=DQcDKvK60pTmflalAOPlRADCnz8ms+t3+wQNbqpxMIBOP8ITNyQcNQ22yS1f6LXB7f
 bc24p+7L6JaiKHsvrndlUR6/WY9Q69QBl+Mm8Yp8GJO5fBeTA7sKqdPOk/9qghAWXzP9
 eIJS838n9h4Hm4uyrJr5ycq7n1LHYKHUY5RUYZJRBQBzaQpytDyJSFYgIkY35kqIha8N
 8YOP2c2VYQpne+wJExHrur9IvmrD9q8A7ak3Fcz1E7iIoRx/nI+yG49Lweog3KatmBPj
 JzhAFjRUn8bK/4e8bQNBTOoToXSUgk3RBQ624D9x9Vlig65YFGzp9qgsH4eKsC9rCBSG
 xYXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPQmUYuO7Ka1OwdpUjjOgJdCawtvPi0LKWHKFRBcslzPvRMOL6k2+sHZjmyon1BZj4ieITbO+AxD+l@nongnu.org
X-Gm-Message-State: AFuF++krdX8wv0ghbjr59k+mZpcv5dozirtvqkLWqitmCOxf/vPeX5QG
 fQhtfpTPCvpxspRg8pV4OdhsFsqNgyFQ3KW+hj4yYFCxn224FdAsLCB7AEqKvm4ykbCpQtBD+nY
 rWRJM6+6tnDf61Og0j1aORIbWBIgtNHtd3xPCCVSPrVBtP2cCMVO1IJve/A==
X-Gm-Gg: AYBFou2xbkGyhO9EGegJpCSWVlTzfomNsQQVxJPPDAJYOvtWLJdSJ256SqhDNvc8SRM
 cXjCO0rOErc3p1kkH++RlbGF4u5qh/OfpI1ZlaoISUA04lDg/3Jo+ewdxhJu2n6FxF6Qu5eNyBT
 FEjcpzWondtjmbQ+MAx1PYzvzzJ/T96V9oInNTVdWJCO/FgmgPofss4lKLBTTMSyY9DoQYmIi5y
 QUQn8cwjW71uODK8pi4WaImhl0ffHrJOpc9khqpPvOBcexA+MSlNWIYjHkkm7h/ldJo+NbeoQMA
 stPBzfbznUYK/EbXtsg98RGKlkN6UYFlBtafnS3DpB4OsqoNVmxl2+NvSQRswWQ9to2Sqm3Gfqw
 H3+1x+GK6OiMMrO7MREA4SgJdrETH5iVpgQ==
X-Received: by 2002:a05:620a:700f:b0:93a:1101:a21c with SMTP id
 af79cd13be357-93c362d19femr160029285a.25.1790231578901; 
 Wed, 23 Sep 2026 23:32:58 -0700 (PDT)
X-Received: by 2002:a05:620a:700f:b0:93a:1101:a21c with SMTP id
 af79cd13be357-93c362d19femr160027785a.25.1790231578363; 
 Wed, 23 Sep 2026 23:32:58 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cc9a37sm47606665e9.11.2026.09.23.23.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 23:32:57 -0700 (PDT)
Message-ID: <ea1f2059-4b7a-4d7e-8077-7c261803c516@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 08:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/mips/tcg: Split out gen_mxu_logic
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
 <20260914230901.1781309-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260914230901.1781309-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNyBTYWx0ZWRfX7GoGV6LWV03h
 Ukve3048mfXMgwbMMjbwBI8Mm2n8Fp3XVpJbeHreOtlBzatsbUPXBxkhhe/JqarKK+Ojbb9lPNO
 HjZZRCxjcAZuMH5EqU6RP7e8kt6BlR8=
X-Proofpoint-ORIG-GUID: 6_-M-O9aCiMKp4czOYU71yFiKc97lUpe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNyBTYWx0ZWRfXz10/LiGYnEjT
 sAYXfl7E8RBAsiGBT7cxtTARgTv6L2uBh3G6Gh+7qkEbuI1Cyro7uqZ2f7B53HDx7JIwUkMSSKT
 HDMgz1oxZlKpDzqrnjKd+O7UYoNQqcwmg4mvWKVoPlbC7aj7vLQqGoF2p4w6FWLSAIObQa6fxJO
 Bt7bKQfhNFIGWfSwar2t6T+5OSYfTWIPIUGre5aVLWo/juxA7sD90ayWZOCyftavuJyF/yQ6Bof
 fJ1ypVirhtYgOGAm+AnNFAel5ZmZVL4/ODKSTzAqCslVjwtxErg5yjN8zAXlwMdYyBaLxcUpYYZ
 ptzHDWVQsJOKw6Vxi9MLqvdpUHYT4aQg+6pt8pQxePcgsEJxQ75jDWwY99A4xUtXdBvzzlBIftQ
 wMgXKBuIWCiHwAo5nJvSEbMMjTwvCZdBbIMiNwO2y955WDNujjFcSAnWFL0QnYoPeU3OPcCugFb
 AijAeM4JRGop3hbqSxg==
X-Authority-Analysis: v=2.4 cv=a6SlZkSF c=1 sm=1 tr=0 ts=6ab4c41b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6_-M-O9aCiMKp4czOYU71yFiKc97lUpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240027
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

On 15/9/26 01:08, Richard Henderson wrote:
> Split out a helper for common expansion of a 3-operand insns.
> Drop all the special cases for 0 and let the optimizer handle them.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c | 122 +++++++-------------------------
>   1 file changed, 24 insertions(+), 98 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

