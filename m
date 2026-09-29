Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5824CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXN7-0000Yc-Tl; Tue, 29 Sep 2026 08:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXMk-0000KV-9T
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:55:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXMi-0008LE-RI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:55:26 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqh3f613458
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 In0WDZHLEDVosUc8NJqI+WoThIK9S2Y5ygDZe3XeWeY=; b=ciC+Iu3j1GRXk0Ep
 ht4Cps3um2KTlgIRI1gSW5YKCeySw7GMQlXdzd1P/qeR6ARl/yztDQE8/Nk/fLZ4
 p4sm//nOKD1lx218QMjpW1jG1oKl6D+/UoZej/WkVjSodQcnlZtPfvrCuCgHuwbP
 Y1q8p4rb9qZenztnCkQykmxHAmhWAyysa89ThcHKh3rZBFBMm0A241Tw61xC2KSd
 Dj5KJyzhzWIyU9V1OgmJRRl2wPc5vXGRECg7RdLBA5U2KYyi3BHaEnmW/0Mv7ZgC
 DvGbsCKctaRj3DB9JjR3YwMjj6sqZ/QsMQ9TWoaWj9sga1Y56ywvAVNYMioRaTY9
 wGmM4Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew2h1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:55:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ae8e7e546so839730485a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790686523; x=1791291323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=In0WDZHLEDVosUc8NJqI+WoThIK9S2Y5ygDZe3XeWeY=;
 b=G05jmUcNmqR4G66EFuchjBjT9ZTmRaWWYOIOnnUSM8/gKn+7Dz7Bpmp8zpjOWERVTS
 eaG3C80/fAwua97oJYaX6nzcm3K1aPKDxda0YwRXGoQcR8lmL29itcv1LH9Ny7aDLRsq
 u9hayIgQ2IMjFApK63jEusRg+xz+IvcTOOAAiXgEwatU+LNus/wkQpCjflNC6dvK1zZj
 hZAtXX8lG3weJlvUW1JSJxzPaasBRWnew7GlLIS4TkloRdE4KgT6zx/oTZT+KHoNY2Hb
 E5BIhqmIiwl28wLEaOuf/Btec/sitCNv+XS00wGQmdzYlqD7aPlZ2fupKmiWERaCSqx3
 HiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790686523; x=1791291323;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=In0WDZHLEDVosUc8NJqI+WoThIK9S2Y5ygDZe3XeWeY=;
 b=d14PIz7l9KY2v9zj+I1kRk4swdk5Q9Qc0abHk2082r/PxwrwOAx+sF5oH9AlufiCm/
 3FuFRQy3fZJHrSN9284GVQSF2zF2zgserzkmZZVkOCCYA/5IZRhzs+Okn2bmUzoSxAQl
 YW21ZkM6JjZbdLdKnyz0WZM06LCb8+fCX+adE2MHZfQLhAdLPyDKaTdExtwbB7pGxsUv
 Zy1bpHQISZ8hLRv3o6SViqX7i7lCyLrO+0AhdO3dFW8HTJdR/by9MeznFH0P5a6iByxv
 lSdg+OQTuH8EVMIOw+XZHVX0IOjI03Qrk3hKIttJtE7fqGuc1OV4zqFZ7V5viGvkh/Fm
 lV2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBztegPPq3XOhdX4o9SNYwKGC6r4n46YHZhAmwQAkq/ioqNfeLZFyMKh7K/hinJqmYjTMJCvY+icxs3h@nongnu.org
X-Gm-Message-State: AFuF++lmFlzLTcCCkYsltfa+EXo3G66Y6hwbRqwUDyf10nS9cMPDAQHD
 g9PujHAK11rdqQvSq0OhqO4e9DsEMn5Qaf2sMCxhmVDYH4aI64Wy6WWhfFSfcnTqvqYKktGBEFJ
 vdmfUXFob2rhGA1whSFu5T/ftFf0jTXS3KfXlpoWwLDd3D0MiISi0R5de4w==
X-Gm-Gg: AYBFou2gXf3exAMInSAjux4Rg21GpP4/LXpuhae88vsKGAkxSHe/b8gfEkoIbvrxTQk
 xXGfnaMpPW4oc6gjlNFWeXMvNNLgodslQbwBZskRQKvjBv1xCl6oqllfSPbEmdwDStbNSDz066r
 4zkvXZZEZYxWqcCDxjn3hizyiQZ7ymvWPdsxB5zU3Kwikwp4EDK3Unlneje6UyfF6jkn78e5KAI
 MXP5KuSy73uYcIZtyiIGJeyTv6rScLpIoEoLAz+4ILmYgM6mMnhY7H+k41xdbWBEXbld7N5VTJ7
 Eqbt6EaSZJFE1XPnaAZ3Ldw4CGjXrOSr4ML1l7/QJ0I2EVntiNdkdNFe7DES8o/DqwEgd4G0gDB
 POxICh3RDZGWg9cNjsFWJes9YX2m/fMCcfg==
X-Received: by 2002:a05:620a:45a4:b0:93c:6450:9cef with SMTP id
 af79cd13be357-93c6450c33bmr1707687885a.57.1790686522786; 
 Tue, 29 Sep 2026 05:55:22 -0700 (PDT)
X-Received: by 2002:a05:620a:45a4:b0:93c:6450:9cef with SMTP id
 af79cd13be357-93c6450c33bmr1707680085a.57.1790686522213; 
 Tue, 29 Sep 2026 05:55:22 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm3460642f8f.27.2026.09.29.05.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:55:21 -0700 (PDT)
Message-ID: <5682966e-c73e-424c-b92d-bdeefbf7a9d2@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 060/101] tcg: Generic expansion of tcg_gen_rotri_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-61-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-61-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfX6gSgiHVmQFKR
 m4tpOCzljDt+VGye1YhmkvBwtqok+brkDF3879m1OmyIKGans/y+cQYkkipsc4s672GLVb+dwd/
 Z6XvEg8x15/V5fPSoiqiZsaaTBr5Y5g=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abbb53b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=erjZ25jtM_Ol--jnGkwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfX3Ajxm6vKVfkx
 USlX0Q6dqDXtz0/Pl9if5Fj00pJtTj6bk/1UF2zjJZEJqpjczfNvOFiLq5r2iGkwsy89bf6F/UT
 +ONbNYM+e2CboCaV7LEqMVMElIPw4q/ACJEYGKW8nvksQBWF+AqqsxLc+kuBkVxQFlkYTi0idIf
 i97q5pIWuH3mFLOPTU2ZmFNzn8qq+ut1vX0YibwPi4xTtr7LKk/upzrQFP39ZUMO4XJa2F/2rf5
 dnuyokrFLQxeO6oBXmNyUkoT9yvXAgvQ/VUJo6A6vmluJRgdEDAFClJlwjKgQdOoUfO9Aw6g85V
 gctAan4OD8XPLuKjHbwGa/MwL4Y7rkiSJebCC32bM40/cjCvm8+NhS1DeLYtSAgWl3xBtYGZPw9
 S66mN8tfCsUJhHCQj1Ggm77SVkyKeonUN2MZUBdvm7PrBXgPwUYqgG5+cXyiTfHKEvG5GOr+3pJ
 eT6COkvtTofIHM4JJyQ==
X-Proofpoint-GUID: Cn__YAZq_PjmkMRLChbNQ35nMM6xXXJU
X-Proofpoint-ORIG-GUID: Cn__YAZq_PjmkMRLChbNQ35nMM6xXXJU
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
>   tcg/tcg-op.c                 | 49 ++++++++++++++----------------------
>   3 files changed, 20 insertions(+), 32 deletions(-)


> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 6414b3b627c..4c51428f935 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -786,6 +786,25 @@ void tcg_gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
>       }
>   }
>   
> +void tcg_gen_rotri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
> +{
> +    int width = tcg_type_size(type) * 8;

tcg_type_bits()

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +
> +    tcg_debug_assert(src2 >= 0 && src2 < width);
> +    if (src2 == 0) {
> +        tcg_gen_mov(type, dst, src1);
> +    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
> +        tcg_gen_op_ttt(INDEX_op_rotr, type, dst, src1,
> +                       tcg_constant_internal(type, src2));
> +    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
> +        tcg_gen_op_ttt(INDEX_op_rotl, type, dst, src1,
> +                       tcg_constant_internal(type, width - src2));
> +    } else {
> +        /* Do not recurse with the rotri simplification. */
> +        tcg_gen_op_ttti(INDEX_op_extract2, type, dst, src1, src1, src2);
> +    }
> +}

