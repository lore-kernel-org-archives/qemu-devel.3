Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB02EC98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqqv-0002Ae-Q1; Sun, 27 Sep 2026 11:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqqr-0002AC-Vs
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:31:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqqp-00027w-MS
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:31:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R1jWr61930291
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z5pgf95PSiPG9YZUk9kdiI297W5MDneuvTDBf2EmBkA=; b=MWent1eCUZZUzSfx
 O+ZSt2DWNVSgB5M8FpqubzZh/chQ6SBN4//bPudbPF0uo4WsLg74uTYYrFDkoeWp
 p+T/TPFCjMHBaFUM2qAWSQtrGIX9/yNYDYUC7CgmJPlR0PNoZp/JPA2eUUVvySGy
 Se8wDptKTgOP+bWpp2RvbrV/S0faK1z3lBMHKcZSZYND1XId84TITgTnU1O/bXOM
 ICcjmz4z0H+DrFCrxKzOGp5CpgpB6hEKo6Rmp05FKc5gGI2Z0+3DlrNbT6BkissG
 MBkt6Mz+WS1PHBP8aEgqIoiN4TVLtJoMy7sx2GDs6p3zP+T9aI+Nr5r4NeFSkHw8
 BH5jVw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mwb7r8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:31:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5e9c2ec1so150869485a.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523097; x=1791127897; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z5pgf95PSiPG9YZUk9kdiI297W5MDneuvTDBf2EmBkA=;
 b=YEQrlm+WO9cIIEl76+wXXRHsV6RjgGU9yE8ZORyzWjcKOxSUs0JGyioHCG7Q9htZgf
 /gagJobD24ljuE5eDDRfJM0wdukORBTtESQV8N85pItmXXR3wCzVXRWeZEDn0xpzrUvB
 n5PKiI7Z30nUHnWen3ajHZKtQ8erSirndHvVWrip5+HYdruyCtGEkc2AymppwpJg//mb
 u0Gj3JRFVYgbN8PV+VCQgKf2yT4Pw2MTSGgT8+IGtOU3h8aoV3JZP19N8N1swZgnveQt
 2BFhDsK9cm0PglyAQD6gMqC1PJoB5oN5ozkgOKM+TnSTfPRHHlBVNsizCioARvIAezI7
 SXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523097; x=1791127897;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z5pgf95PSiPG9YZUk9kdiI297W5MDneuvTDBf2EmBkA=;
 b=27g1oOf65mlHSfCWW+qjr980eIjwl65T6c/CUtfpJTb1ItyLRLnDN3e27SeTN8Pzko
 a+skCZ0wjsISLe3S18xi3KIO3p7Le7CKcKR1/8Ia4S/X37DNAFdLlv7a8VRvwkI6y5rJ
 2q3znLp70ZrL7A2eBmWh1aFZFeJkcUAm6a2P6mnji7SUgqTqsaDJrFXgU9plvVN9cn0a
 ONZvqSZzh5+nvtWwSPKuYQ8OxWlpzfTjIWEaSZ5J6UxrqRtiFVpdrGaK0hZH6gvHlxt6
 droiwkQV6m/2e7WUl0/sRW3v7ZdNPy/2oplm5NDEswOMF1s9CzeYDjeCU+8Kt4myFN3q
 9kGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhc2xr0aovHTir03s/oH1JunrPCBbJN2jgHWRZiMDU4kmWBsuP3WHC0oYLbtCH0vDu9fuQWr0QtrBb@nongnu.org
X-Gm-Message-State: AFuF++n8/8QTCpYroSxl48N3cfwPWC5+KzaRnTrezU75r//d+4wVKSNa
 ZcsTwhLyVOUuBgN9eOFiqZHzeOt5hV7r/u6PTRy4MY3sI0d/5fuEly4/XRc4Fc2l0qhxdfj1Lfs
 k5saquuoXU41lTJNbSAa1Z/p4ATO4HWycVy36JgIVa8sOLdfWCLlHiKj0Pw==
X-Gm-Gg: AYBFou0jQiXwZ+jcDGdNmXoMryXlVRQRl6HOR+QtgLK2ROLSPvLMdxlrKqE/GuKSuzH
 uAd9JKdtMOlymKU5xDU+1RnAl4qHEuRbzwR8Dq15hTFKpM/X6mv0DsoyrACSWi5Ec44TY/s8JUH
 c3cZD67HPz8kmeNc0NNJq4gMtpJPQzZeHJhn/zOTwmf5YreaCaGKEbh21mPoqFxUPFuO0jb3n4P
 T8zheZzto3MShkLdfcl0KSqPZ2mGpu/iKZhqvMhKwr+CdwqQyUWtTy+PWZAAV3IbAhKWj/MU69K
 fu5C3D3iSU/M5h9qE8w+3BTE2mwMnsCvnB3TUz6ecLjDKmqHUh8xQEi3nScE4/+WuD1I2HlQ2oi
 7UpoYJdMSrLAf9JhsKK6U/aNE71BSmfHWug==
X-Received: by 2002:a05:620a:1724:b0:939:72cb:bae5 with SMTP id
 af79cd13be357-93c43d6c35amr1394119985a.28.1790523097118; 
 Sun, 27 Sep 2026 08:31:37 -0700 (PDT)
X-Received: by 2002:a05:620a:1724:b0:939:72cb:bae5 with SMTP id
 af79cd13be357-93c43d6c35amr1394116085a.28.1790523096641; 
 Sun, 27 Sep 2026 08:31:36 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a001904513sm96286695e9.10.2026.09.27.08.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:31:16 -0700 (PDT)
Message-ID: <5f762124-6163-433d-b8df-90ad0ae76353@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 010/101] tcg: Generic expansion of tcg_gen_movi_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cUMCsOo7P4806BjNFDTeaQoGGvH6QrBK
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab936d9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=wPPwIdV2K0xBRaMw7IQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: cUMCsOo7P4806BjNFDTeaQoGGvH6QrBK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX3fnm4xwPsUgE
 caEPnUh2KxndkGOcw8Ndt04lVzBxpW7Oi2OGc3Bv3D4SWtYiJs5qvkWzJdzGIFCmjo5OlqhmlEo
 h05zml1Vkd1/bHS87snpLt3480+CG8zaRfMszq9HNyZdqfsJYkMcSn2K1irjTN0V4vjYY7PL8O8
 TbZkTvNYtsBLS21PuszIDmPdmpAnd0uhLWcjGrXlSWhyugMgPhN8DAYE9EeJcZRm0U+az6C0cHs
 U58WAZImSyssKZpfTH38kHGYDC0/2FTHg3cN+OuV2wX9oxiErreQ7KGJ92jNs5+nFIOG/v6ocgD
 3dvMgTzb7dZ0QD4vak8tNfFeZ6cXEPCjBuA5idZeIuxhHuRMWs6ilazPZyLiI0dOWNPHsAYgavB
 YaXMHGglZsPCB/05QoLR0LQU9fkd1SFdEBCk7rkNygjoY+L9RwA6vzDry/Z//MQphGbHf62j7Tq
 AZxm8eVkuH8GR3NhkLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfXzbLOk+HVvnmC
 K+T4aAkMNGr+gCoRurHnaTJB9HJ9d+FPr76L7FlkyE3tKpyPWqZug2EnZlvUWc0lauNssWMU3G7
 w0tVWvn30xXHILzkT9cHtr2q6S3AxR4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270061
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 15 +++++----------
>   3 files changed, 6 insertions(+), 12 deletions(-)


> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 77ed34fcb8f..b2fa509cd1f 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -370,6 +370,11 @@ void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
>       }
>   }
>   
> +void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)

Maybe this commit (the first converting opcode with an integer arg)
could have a description explaining / reminding now all args are
passed as int64_t.

> +{
> +    tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
> +}
> +
>   /* 32 bit ops */
>   
>   void tcg_gen_discard_i32(TCGv_i32 arg)
> @@ -377,11 +382,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
>       tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
>   }
>   
> -void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
> -{
> -    tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
> -}

