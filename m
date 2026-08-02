Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F88C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqWyK-0008GW-CP; Sun, 02 Aug 2026 10:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqWyI-0008D7-Dc
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:15:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqWyG-000654-U7
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:15:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B6ksT936605
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1OsPnnff1UEtzoSoqsgfwYGcy/b6uwcBT0f0C/IJo84=; b=bMD2z00Mh6zLA+V1
 v21AScm5q2JFj1zC56TyAMz4w2TSAplkKZxvK6NTSDbsyF0j4DzQcbtmnrJtQA8I
 6uHpJv0nMDQ9EEUpI457YbfAvqVg/VOu2XM4GMiFE+zEgkoyYcjAcnjwodaN0gos
 v4WN+cimDgNdxwOhBQe0ygbQBNN+dW5cbD4tRy50qYyumeR1suohhPbmNzaIa4fN
 1YoPgYKKB7ckwJYqKi1cAEIlGQJ/TNXr3+VqaBKDlL/RAY4Tf0/Q5AsfFbv9GuXO
 Rsi30XhQ6dG6/Up6C8pNfRknOlbjaAx4+eGEFlNrv4nmznWwV3WXZdOl7aumH5Tn
 /Wjm8w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9ygjs2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:15:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a97644aso25313161cf.2
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680119; x=1786284919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1OsPnnff1UEtzoSoqsgfwYGcy/b6uwcBT0f0C/IJo84=;
 b=ahR3V/8epENV5O251VKvhTAegR97nWeJqTrMXcQ2VwOdrmcUrOAOiRBIpe1JYARkll
 1+Ux9sLdurGCvQvdoY6CqKh2GI5ujpLKiwMIixwB7B1mZ3eS1TrejbVM+o2nFkecPj/3
 +USzpOk6nyJ4tPO0gftkRdgENd5I4WZ+WbGvTYC6OtHtUG5JwWuum6AlpiP6LEpRn2nx
 ziRuFZw2hzV6zOIACn9LKMm0waXPUukIUl+sRqozoCOqUam4VBzdw5I6UPPUSCOf7zO+
 E83vnq6FKXnrb7NcDEPNrDGIIUutUf19lDS1KYQQzTHpDTTdCDwIcxkVeDvl8TPce7Mt
 yXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680119; x=1786284919;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1OsPnnff1UEtzoSoqsgfwYGcy/b6uwcBT0f0C/IJo84=;
 b=m8FvxgdGhKM6eOi49b3AaI5wVWxxPuLWKOeS7nQML4LbCSw5sB6anJR9zslV+6rwre
 cOMYEbW/DVu+r38D+JDtFb5Cqv2Zu9YHmoyjovCDJSuJ7VkcY+EwFp3fTbwQcZgpZcU6
 rkAC+6aYFX0bJFq9Y3On15zaO4EwQiE4x/8cfbTwKv3TtK1KLwjdKrEN31YI2LBIDbv8
 hFShYunchHtO7K1SjQNnzRZMDujvx/4FN2gwEVp4koRS10VHBunhw02K4UylIX6ql9xO
 g80NQp/6rE6a1DyZl+V2daZd0IH0kWNHDiTRKOsX/1Y7SpEb/7leHDpeKOO446GBB9Ro
 2UIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHluXFhTvI8fPHSMfxNyIsPY5hzW8fs5JG/+J3PiYl515AGMvhv5j0W/MikQHkTkRFowom6tBBhkzT@nongnu.org
X-Gm-Message-State: AOJu0Yyws8TDmLSpYnkHSQZDinnz2cvQ55V6lbmCIngHpANjIM48DJEs
 2MIujcgNEOB34G8c2rTKOz0RurX3SsLb+4u812ZoUPFS/qdaLex/9eQzbDqLkrnsXlHYqTgr1Vg
 AYK7Iq8OUWjfM5G+YWqRGbGUZpDKW/L6O1kOqEc/B/pcqcq4efMoI7Sg8/g==
X-Gm-Gg: AR+sD13nowdkC9XzBu2t7cTo0Cyj00uw7vSgwjiiQ8RQH6hYHSTQkf//gJw86pJ5v0m
 EDezs5fY1qsvDMBxWiJw2O46LU5bzLoliXTBN6U9/ZI04M/WY2QhKv4ieOlIyy5qrRnjGCz9f5l
 H9yC1/cB6g2Q8pRsPUNgPa7kIm0ZXEid34s5P+8GNQcXgHTC/IZXenEcHRu73vZfV8DN3Wf3wB9
 zcqke5Pf2ZW35o930wIFbu+Pt/HLS6JEpRfnZnfWP9mFUs8FvFZRBzO0t9lvJyI8vTCcCzXBosr
 ikZEu2PkyY7TDQgb9SMRDIJRQv7O0w9MQR92n/FYOliFHNezFchCA4NoLNiUuLnHs3hpe4gocf9
 3an51fU7Z7qSF3lXErgG5hBf6Kon1IcdjpzOVpINSqB9a1tLdgP4=
X-Received: by 2002:ac8:5705:0:b0:51a:89c1:1eef with SMTP id
 d75a77b69052e-52b5673773fmr128495811cf.14.1785680118429; 
 Sun, 02 Aug 2026 07:15:18 -0700 (PDT)
X-Received: by 2002:ac8:5705:0:b0:51a:89c1:1eef with SMTP id
 d75a77b69052e-52b5673773fmr128494801cf.14.1785680117867; 
 Sun, 02 Aug 2026 07:15:17 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd4562667sm25566792f8f.24.2026.08.02.07.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:15:17 -0700 (PDT)
Message-ID: <c91570de-620c-48a9-b5bb-330541ec1b86@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] target/s390x: Convert op_ld8u to op_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX9ZRPnuuyBJ5w
 /4lVUtYPO+tgB/EaL/xMx7DOoL3rcrGTp/bjZs04LVAx8kdgsAFzH+wsV9cd6v1FfaXW7gYVGbJ
 LN98x4l8zANcG3spxs8Ia6K4CbkRK3c=
X-Proofpoint-GUID: MjdGK8uBOIC0a8PlKuMAy5pP-X1sje23
X-Authority-Analysis: v=2.4 cv=Gu5yPE1C c=1 sm=1 tr=0 ts=6a6f50f7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MjdGK8uBOIC0a8PlKuMAy5pP-X1sje23
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfXx+M0HsemCGyr
 O7WjnzOBlbYiF2ZkTiNG9ju1dI9w0TAgOxYPyj+EoXPdc0lOC/gN9DzLAlDei8dZ5P/50uQJRdg
 gLzc2gRtUT1ZTYgWe9liAPXc8/eleR4mQKlvdLahITs9so3R0hhkGE27gWbvRRD+FEd8d1qtrzA
 Roww2g5XDrUMUzGbQuHxPM3gY2ODE8SzYuYe1Ry+vSKHoK2VQF9xAxWPMXOu8j56gK72GyE7TiB
 a4q+kXR4vsIsGXhhANOcI7eqU4xaUx1TYAy0BlcchNquoJJYeRXik4k0dXeOjXEa+zzD+ug3AEw
 aeR0PTz1Bm/hGozXwdyRyNaSxUjny8FPGdDyls/zjbLFlb50b8Fd8H/J37rC3dUZ/TEdgsc8ilR
 AY07gpMzhfT4g0NOL3PlR3YjWbR7uAcIsBWeArpWYqk6oN/OJ5Ix8rCp6AFI9BCQMHdlDKXQ7v6
 23n/7QnOdtZiy+T0P6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020126
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 31/7/26 20:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 6 ------
>   target/s390x/tcg/insn-data.h.inc | 6 +++---
>   2 files changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

