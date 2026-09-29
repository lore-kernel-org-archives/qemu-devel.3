Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDFCCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXK8-0007CX-Vr; Tue, 29 Sep 2026 08:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXK7-0007CH-FJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:52:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXK5-0007mq-UA
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:52:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqedl613340
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IAgrX7RDeicz2ZiRJI4hwyUREW0KGEokGBtuxA1W4rc=; b=o+w2M6DYINtZlasO
 fjbh4qdPCfUrdf4aoejIiFJX+HUM7zx6ev1MPCBEuW69/1a5XxbIy11OEsW1ajxO
 w9cB90MyZelrSmX34b3gxrHyGabZQS9tipQ9FSvh3WTe+BvBjMDa/x2JV3u82a8G
 vk5c7RdGz5P+WVkQ71BXpJfEjLE86jhILYHPdyzS9d4OSe1g33Uhk4QUB0faHWAH
 UPURFz9NBUvOfzcHlWW5ZWw39tuAkoBUXhCMrTOdDEJcGWxEcP7CMaOAJzvQZTEy
 Sy6RABxH3k0k9DU4NnXUwzVn52LPaR2f08VHHZycXlPwRPkKdgAAGcGnQ+8wBgDr
 2xM5Jg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew2gra-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:52:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5d7c4c26so776160585a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790686356; x=1791291156; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IAgrX7RDeicz2ZiRJI4hwyUREW0KGEokGBtuxA1W4rc=;
 b=cKtXbTESks1WI37rzglmm02vJ3jS9felLS8jvA1rEAenNkZCwmU19AXYq7V/7nc6no
 viPJrsWEZKsdQ3qPtmYYdFGSRMJYjXzsXCEIoMzQxjfr/sIi5EMcWjj+NIj6GH4vd7zk
 bjATEt67enST6/m5nGiNVJ1fH7EdLfu4eHSUEXBwq3Q8O1zhvl5uyB4zpr4VM1V9uOM9
 k6PPN4JkHsSOJKf2ULJGB/wCDL6nqEMZlkuQq2VCy7obv2/Om5+gWIuExKlAa3f/L+sE
 VycG5RU2xPQqTiBttKCuE2hc0vcwBY0eukG58Q+O6U441PdwiRGLNmVUMI1+JoGU6Xwg
 VUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790686356; x=1791291156;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IAgrX7RDeicz2ZiRJI4hwyUREW0KGEokGBtuxA1W4rc=;
 b=NW7z46/6vyj+Q2qx2sfGhstvV3wzTExNurdzpjRCKW4Sm2q4iFx7xiu8pMf6dGiYQV
 YCa2BJoqsGea8uOKr9a+/1hMWR6rpXM3nzLMlhZgm70Yv+xAufQf24jSRQ1Vw+78mxYd
 PxlgZdOvnQz2VVXGZebA3KXdqHLDB2NuE2cmn/zsAa5mLoWVeYtBxRcc54Eoz77NCEEF
 KT2AtnYzEiDu0pJXWwbM2FzU9NFO8Q4DOjCxY0bBnDV2KJY0KmNWuUjZMc5kRxN5fdg8
 oSFxkzS2FaZs7HXefPE5R84rNjvtQCGT3MAiVhqThtqiAP5mLymahL6rmKmjerVrUulO
 jmGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGKI3/UeTks/MNNRnDBKL+N/PkRhbrDFKcCSo0nkywRruMzIZPrxVwc6RIfJ8c4idRWaj0GHuihgiy@nongnu.org
X-Gm-Message-State: AFuF++lNPlnOv7B8delZ1jhc//MUpfT741tYNY4IKdRMhegORKiSuHM9
 Cfh5amfLtPzCY9dkwkOBG7M5Qo4Q4dY0ZgRIFhACspwfddh03AcSrnRmYvhcOqmjioECCjCB64y
 iEJZdOFK4gTf9tAQORXHVVS1D7O7wTh6EQARBwSSdZlVC/U1pgoPPtJEjPg==
X-Gm-Gg: AYBFou3s2zo3DYciRodNhKqGQc0QCiMty1W7nuJwo97Tq5M1Nm232A2yNb1kYgfQsP/
 k/LnhE6VxQrcf1aiUfBTd/0Fv1CONXu7b+AtF7eu0vadzhzXRbjEO1CHe7dS6ciI4u9Kuu+X7Lg
 GJYQuKOASFXTVEuHSlE7DDMr4UnP9pT4UjhoXoNVwiih5IBONOTKQ/7HBJQ6fsBAFJp/6dz7vt2
 H85MvjfCBY7Q7wOELPM5aj7rOxNi1dbJvXXjvujUc2fH8P92Gh5ltudMSfKPymM5R7Vltje8NF1
 vgK4xbK44XhkbG8ZPWRbq4a5fr+JHYJBIxNulmqJFvXB2uSbFPRuU+1vAG68uNMBOmmAZbz7UHY
 Iyq7xT/IohqBL0nP3jPkbA+GmV972C7UKDA==
X-Received: by 2002:a05:620a:7003:b0:93b:d79f:d949 with SMTP id
 af79cd13be357-93c43eb2a07mr2699751385a.62.1790686356085; 
 Tue, 29 Sep 2026 05:52:36 -0700 (PDT)
X-Received: by 2002:a05:620a:7003:b0:93b:d79f:d949 with SMTP id
 af79cd13be357-93c43eb2a07mr2699745885a.62.1790686355470; 
 Tue, 29 Sep 2026 05:52:35 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013d0de7fsm685855e9.2.2026.09.29.05.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:52:34 -0700 (PDT)
Message-ID: <38edf739-6d4f-4b68-a141-57a5b71185fb@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 057/101] tcg: Generic expansion of tcg_gen_clrsb_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-58-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-58-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfXxXMTCQNYSlQu
 0v2hmGx7rsJ+fq4uppzvmBd7QTsi3kCUkqoX77bQH2MOVe7E+lNapk4YrArHwKLa58a0moa8eyq
 HMkE3qHoCTLl9XFz6Ro7p1Q/+V2Dt8o=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abbb498 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VPXphUonS_HM00HJoAIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfXw9s7fwWCd8g+
 rq82GgzaFFEtlgK1tpqfm4cCR/fU5LYS4AsU3dYpXuo0uAnFyUDMD8wtFMSJf+QfJvQoPbsyY4H
 oeQ7DuV+/gAYcdL05nXvXbayCNhPbgJ9sniJ8Ze265hzt+hvIreLW0jHz9TlheqjZ5md5FnzBaC
 7BmCNriu4zOV0ndkYjxPye0QPClOwOPg/scFNiurj095jQ4PYT+UBtV9Xc2zEuIu7IcDSGq3Bc3
 T6CW9/4msk5CbAtfuqBiOMyvWgZMhytaRC8ktRF8PVABJtMh+efD+g0pcjA5bvx2jqUUiFK6q6H
 uplt8iKAzaQi/1LvKG+ToihO5GdO8HSwgLnkzCC6LFqF9LjbOjadYuYMvJX2E+mrz8ovfAcCkQq
 4Q8xhB14Boce8moocbZaPpXkoSGGrRJ/zTXa8SvYH3ShMKjsFAL7lD9Y3qLRYuAP4OMkS639qC0
 D0RY1KEvDw/oluEoThQ==
X-Proofpoint-GUID: aoNAkbtdKn-WahLhk4xQP3r8pxVAcVVZ
X-Proofpoint-ORIG-GUID: aoNAkbtdKn-WahLhk4xQP3r8pxVAcVVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290051
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
>   tcg/tcg-op.c                 | 45 ++++++++++++++----------------------
>   3 files changed, 18 insertions(+), 30 deletions(-)


> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 3498be09e70..5ee49e2553d 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -422,6 +422,23 @@ void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
>       tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
>   }
>   
> +void tcg_gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
> +{
> +    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
> +        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
> +        int width = tcg_type_size(type) * 8;

tcg_type_bits()

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +        tcg_gen_sari(type, tmp, src, width - 1);
> +        tcg_gen_xor(type, tmp, tmp, src);
> +        tcg_gen_clzi(type, tmp, tmp, width);
> +        tcg_gen_addi(type, dst, tmp, -1);
> +    } else if (type == TCG_TYPE_I32) {
> +        gen_helper_clrsb_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
> +    } else {
> +        gen_helper_clrsb_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
> +    }
> +}


