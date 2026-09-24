Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7FBC98304
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9cHl-0001jv-Q7; Thu, 24 Sep 2026 01:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9cHL-0001iI-7E
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:45:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9cHJ-0003UH-KH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:45:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5e3Nb567355
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E06frzGZRLy682vsc4oW67wMcdWEXuS7HQL0aJT4KYs=; b=dirD4JVHm8JrSydG
 5E4PFHltj9Opog4bFaLGUszuTQ6K9kv0cPOMMFeMNe5L6TSklBmIuaGuFhep1y0C
 51XxTUwvSVYVZbADqg9H50kO498pSpf327pQ9yahNMMQfpzDsVFfE8N22WIrGesd
 fWKX+41XfZfFACV9NKlqp6wG3ECbWlKVsmuebEs+4xeN7zkawpnu9mguHsy5wg6s
 q73zTgHbeSjuhRLWlWR6YKC7Gk6AL2MhG7ELVVMMhP0EwLKSaR0XBbAxmZDW5ewb
 rqMM3FqaNoJ+0WI0SKA7JQ+uynNw2gviDYO3uTXvEoHtlu4D0BYjkXeKxi5A/Zg8
 KP4WaA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvgh899h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:45:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5328dae1305so54484321cf.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 22:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790228750; x=1790833550; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E06frzGZRLy682vsc4oW67wMcdWEXuS7HQL0aJT4KYs=;
 b=UdVW3qIOuj/InRuy8Ono/2ZQ+YKTs+uNpMVnuSDPv8snWp+c/4sEoTm6/OWl1/Ov3F
 67BCNt0Swv7Hj+jxJ3IPW+Yv9OlwzV7GdpjZY7NAsqM+7X6Yv7qnHsrrNHujoXBbaxUw
 0zmhuwDO90DHBBvCxkNU47CfVpbpvBhPlOiWGOzN/3snVDdMC+oERrbbqGfnG2Y/84Ps
 TKGf3hMdnEyoZX8zUNrev1BJn3PkdFCXEHy7diwgBfhAko+PLPFnmc+x4Uo5pSKTfj/X
 hnUegNNjR9mJSfEDQWZoOxoxInHNeb3oQZsvhwIZIhHC6F66sONN55uygZVn9mHXF7ox
 NOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790228750; x=1790833550;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E06frzGZRLy682vsc4oW67wMcdWEXuS7HQL0aJT4KYs=;
 b=zY3h4OB3e9lOi23FdVKMb65DvfNIos1MTFgUe0D549k6vlN6TJHNTelN6Ux5HMID49
 EIvQl/r+fkB2zbUI4cXPti+1nNmeou7edmCiKtkIAShU/n/FBUThY2AlvhEtuwC5zoK5
 CP9jCcwPynO1kfmKhIkEtzCH4pTdzSv1NFBJqGibrHsSFXrZiTNVhds3pAqEwJikslJs
 L51o3e5gPCtjNWcmTAH7ru1W0qlQywNEWK4LpKvMF5rqOpCKxFGZDt2LSm4+QU21f03U
 B7ox7vQoeHa5mOK5+FfE0D75uiy+LHsPvc43X7Gz3WQQgFrJLSys1RJrTmaKSV4I/aWh
 I0sg==
X-Forwarded-Encrypted: i=1;
 AKwUvByemNDYanRJyu+dejJsK/GZxZTVjTBIMpC9YVR/a6oMoPjekm3mnIbONFf35szDFH6+F4W+adbrydey@nongnu.org
X-Gm-Message-State: AFuF++lD3lkCVS4YOykZyPTVJbygVdBRvEOHVSzgI2orKiUUZC7G3aGr
 /a8Qvm3J8ZR6cGLI+exEWvttXhe0bNMHfESPZ31sA07KU5bgs2aD/jvUFSVngATv1ZsAVONYw2l
 k7RUfihdzNkegk6l9d5jt0fqbHw0RMpolRvWQnOfIEqcG/KcfTD0lN2jr5nbvI03PfgNf
X-Gm-Gg: AYBFou0N+ZOU83EVmDqey2B9pF7/jiBpqswaKCCYpMAqSL86eHj2VfZjJQru0RpMUsZ
 BsrCj2GsX7DTfoT9J3jQXsmPTKBmT7x/Y+4IKO6HnlLl5i3tExVr0fwIXSot1f3Gm0BOmC7iG30
 lOzN3jjW+0kmLV1BZGEc+JbvDZGNeAF97nLkuvGwPtEVHZrS7xH3jxby/3GsneWisYvuhqQ0ShS
 qpWO++ILYaxi5okUeUrfdj2Z3HfpcP7yL/UmCMJlN992/EAbgCMpyL3oj3T1NHygfhG9YyyZgM7
 VlPMa4P4jveGJqreD1HlnuvdQW6N/IKWNGNuyQuTC2V3IBFbLF+eH/PTre+ZQnl4t/THhRAYcXE
 Kso+lWau2wqXknkhJnE3tXBnnUe+1xVlEKQ==
X-Received: by 2002:a05:620a:488d:b0:939:e735:c50e with SMTP id
 af79cd13be357-93c3625b27amr137160785a.13.1790228749997; 
 Wed, 23 Sep 2026 22:45:49 -0700 (PDT)
X-Received: by 2002:a05:620a:488d:b0:939:e735:c50e with SMTP id
 af79cd13be357-93c3625b27amr137158785a.13.1790228749541; 
 Wed, 23 Sep 2026 22:45:49 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877a19bsm12849629f8f.25.2026.09.23.22.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 22:45:48 -0700 (PDT)
Message-ID: <8b3b756a-b680-4da8-80fe-8b59070d4073@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 07:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32SLT
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
 <20260914230901.1781309-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260914230901.1781309-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab4b90e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tfd8ag-05hND8l10gS-8GgB6W958C6S7
X-Proofpoint-ORIG-GUID: tfd8ag-05hND8l10gS-8GgB6W958C6S7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX8vmbmTg3k24a
 Zi9YBsS0B4Wk68aGtNVsXQX/SuBKw0d9hWEltV5G8tMiHxXlIK9DQ1LUiFV7hA94NkioB+H6AOa
 Q41zZJqyGJe81hx9YBH83hxDaa41Grc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX2YNQv474XTW8
 l/Qh8s6TF/7Y2fkwp9JOxIdhJolTP3A6Sx3wn2zcaPtsrlq9ZdsxeXvW3OIm64zdQkLHh/2T+Mq
 H5pnBNQunbieEKJCsraaedkBqwDJe/D1Ts/ngtrbUMmqh0HbHGbLC0MCqXW4XwK7IgGTj84yOnz
 ycFOTEnowwSTfPI0BqW75GzJxQBiXDDzbg/Mlv6yFiZ6LekJoO/bpRAGDDZVgHrffD3MhFdjBt7
 batyrKirtVx3nGdQpwpr0q8HHLKpDy4+RhagdpoLuLh9UuHjUfyT42GFMkyw1WOA2LB2WEKaUYx
 1EzLrclXPcFCPN6Oe+NQMTgexxXwWMhc0cFmgZAYjVeeQ/62SZKNUNogINjvbRIX4iR00RTJxDa
 WalSgei0ZPFDn/scZYZgIVSApDlBNcGijJXYEQSQ3PYGctONG5SeX5UkXoEfuvwipGgOlufXa4I
 2KnQmBNn1h8gCtPLb4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240024
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c | 33 +++++++--------------------------
>   1 file changed, 7 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

