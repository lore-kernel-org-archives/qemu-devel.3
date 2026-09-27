Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D870C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqGX-0003wa-Pr; Sun, 27 Sep 2026 10:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqGP-0003wI-8u
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:54:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqGN-0005rm-LU
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:54:01 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxUhJ4013986
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uelhg/1UamFyEZhicqYMUgpwHvqJ8jQINgVP/0LV4bY=; b=BrqVtpZ57GpjfyXw
 b3YY31cFNaRF1zW+cE9qEe3xddmEKPTTlyrxHCH09WQ3jaFn+QGJCIXUl5yTjC+1
 feamgOEn2riBtqsLuOeNmdLWCZhPrRUtpZhp+DTlVKMin1plpO6m+YI5r14/xYih
 XIyW8t4r7enZfNUnFvf8cam4O4NFtpGHuW7SC8qeZ4cYJs8+WwSKpa8BwYqfWLjD
 pyu/lNaO21hMD1hKvWU8kIMok5n+NeHgftALjOi9rfpPN0UcFBDVhXBJR3hDiGtT
 rgAnxvFJFJLI8N5OQJNWMNRUiGBSmP4LHr4RaxobYCc0Tv8pFa3mtPqzoh483bxy
 koRTLQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6tek240-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:53:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9143d796129so26276266d6.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790520837; x=1791125637; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uelhg/1UamFyEZhicqYMUgpwHvqJ8jQINgVP/0LV4bY=;
 b=jS4ro5o4WaddOiHz6UIdpnWilxt/KhXaWp+iN9sNBMmIjFBU8FCSf6NdUVt8wHZaHV
 cT5cXo1Hf7Ana2CbqzseJzC6ZSPdEkHhaHXI09dosDZ+dUvt/xx71LZPrV1I8GDgszev
 itvH7wzX4c/0Ts6f+5Fp30FTHZy2KJZYGQd+cs2auLymwE7NCEHBEva4sZpm5HNC8EE3
 gN+f/DOsXIAvpVU9nm1xwy4uNPZgkXUW2SySs1udpfC0X3d4H1hoHQvkfmMHMDzjX+aG
 OF5kBC+W+SXXtk+APWIDA1Z9imXzq4yk+3mTXD0dGSigBsex9JQCqZQZFQfHkjaJ6CIW
 Y3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790520837; x=1791125637;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uelhg/1UamFyEZhicqYMUgpwHvqJ8jQINgVP/0LV4bY=;
 b=YyRm2sUEnqDg1Khh204iJw3GnXOyBWQ59306InRjg4a2kGOBoBTfar6TES6CLfe+IE
 N6VY6hAM3wuoUAMtLKCDnzcYnELzdjxiJj4k13lJoAerXAyhGNz/hBkoq3nXChjmrkBg
 ANQNOYXELBWR2oZmBr1HMBpGW5PGMUBXxvRGXpGVc0ryMsXO7EACsZMmxuLsNidV07Pl
 4Zn4gxi0lut7S67KjVZl5tO/EgW+AH4pGU2/89UZEHoNcTK9yCSgrOJ5Cn7426ZsmAgF
 z07TWsMakess5f8ZcHKDBe63ToNh8AN9AjAX/Wj2eCcJ31PqQDr0LW6N+t0LnohI54X4
 bNxg==
X-Forwarded-Encrypted: i=1;
 AKwUvByUEbfhW99xh/3cCOl7qelL1dCd95oP6ctiyJFfQSuC12H2Pexg/q70HjxRRVPzsieEdb3OVeLIRcIw@nongnu.org
X-Gm-Message-State: AFuF++k/1OGHZT5iyHkCPu3ua8RhNpbxx3bfsSDDIQ2uHpr1p6eltCDP
 Hd/1VdovmFLuf+AmZZyjyKsOOXVwC52GcimMpYi5VfJzVQABcQkKPYEMhaifDp/s73aFcoCf8wJ
 Wz2e1h58Q5tx5O6hNzfUTN/L4X26Z/zNRGCXZZnVc0zj3VXKVPyx2CmnvGA==
X-Gm-Gg: AYBFou22lolpoLOYzs1RrU+ZLAJYWfWBOlqcQhySfRorn0YLVcOf6lgGZEVwczJCRwb
 VBLNk/jBT9d2mSxpCIFF4BxSdqTJT/stwBFx37QrdkTzvoNQuLvIgYXzs25ILj/5Z+msnZmpDeW
 6e9rwg549li4gfd1gQ6fUcQUMmVG8cC2VWnpvYaRgIImatoEVquf4ZI8vLRBfWvLVJUFtvZT0ia
 sDnbVoFrA/k7JJrCMgAQQYevpL/xfnUhYo3JanT2py8P2S5KAJwd5wuUEt3ADEgDBlchC1B/EVQ
 Wxi5jp0no46Rne3KuVc7boliIXgn76456J4GH8jXfu/hMP1sKnjs3WY8lqV+4p+EHH6/fsQ8mRx
 C/Ie2yn9vn9CbUhb5fCt764YfiWIral2Cfw==
X-Received: by 2002:a05:620a:4012:b0:93b:d7a1:ba10 with SMTP id
 af79cd13be357-93c47555948mr1455349485a.59.1790520836697; 
 Sun, 27 Sep 2026 07:53:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4012:b0:93b:d7a1:ba10 with SMTP id
 af79cd13be357-93c47555948mr1455346485a.59.1790520836269; 
 Sun, 27 Sep 2026 07:53:56 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a001771ce3sm67625095e9.7.2026.09.27.07.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 07:53:55 -0700 (PDT)
Message-ID: <985946c6-51c4-4acd-bf8d-7ed3288aff9e@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 16:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 007/101] tcg: Use QEMU_*_NONULL with all tcg_gen_*_ptr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfXyDDa0gS2C4Aw
 SFBA40zkgv3UKB30LHxjGTjCeOsV1vRIH24p7VF2CK/WH7eY2tPi+rojMT+NsyEo8tluJClh6Yv
 mXCXodrtWxC9Gfsme0CPT7uPce+O3U8OgnO5tT3/uK33B5Kpyi6/xuYY0xjV6WdbdRidyaIXZ2q
 nxCfdvrin8mAdllV01IqEfXgl+E/Vz1bjXprCXobmSxXm2Vxnf/b3hQ+I74Q3o0F1wBhp/Uw/sw
 aAUTF2XNfedDEaK+AQN3DfDjvKRcQf6gMAzsr+EInuD1I+1FRWmXNp71WHiZaLKX+VH9vaFboit
 g7O3f9Bvli66B1o+mtH3KtKS3h3GwppAykp5uwnGonqQ3pTMA8Z8wiRKgQU2OjoUgav6r9NO+8f
 biVkMmkJUYkjggIywEn0HmwP7HypQeMCPecZPn6Iwlhd7qoVHYjDJbwGBXBfNDf2irGol1zaeVi
 adFZfgpHKqvcHAs98Ug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX1mQ6wwLn959b
 kKxzPo5DGGbFToZktognpiEzQZTUx0pAraAG+W399L4sgbwKRwsN7j9EbyBEETMDBSCZNDOfe8i
 0qt8bp8AZu9FUt/YjP8ZXOFoGsYtW1E=
X-Proofpoint-ORIG-GUID: NrgMEdriDkmpnjGPcy48eyqPZe991oMo
X-Authority-Analysis: v=2.4 cv=X9LHu2Te c=1 sm=1 tr=0 ts=6ab92e05 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NrgMEdriDkmpnjGPcy48eyqPZe991oMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270059
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

