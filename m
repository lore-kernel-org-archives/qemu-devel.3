Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B16C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8nb-0000Lv-9D; Mon, 28 Sep 2026 06:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8nZ-0000KT-I2
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:41:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8nX-0004mC-Or
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:41:29 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MDDn2168227
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5fwpoAryv3us4ayutXSR2vnOZi+CVCnC8HMAD6CvkGA=; b=MuiNCWnx3VLM4TZT
 ULFEr9lHQ0sO5WL+8ylOfGyOg+cScqmgT0PLtlK7GCCqEqJKIxFYdUFUnA7+A6NZ
 rTrH+31nFjneyH8H+iiMl/1NIFSD5B99ExrN+99E2cJwToOU3Os9oGNNmBaw/gkG
 2lKDQQfLXlBVmlS7QzOKS8LuQuXp18lh7vBEhgSbO6IOggZAOMuRlo8H16VPuwTv
 CzyxvS33lh9HHBiHkQwBXvSy5rTxYAlKhWr9Lah+ODYpfgm5PzPEd/VWWx1S08FM
 kIDEUGaZVoXn/0n0SPFWa/lZl+GjZpBq+YeupftfDFbYqdVwF4mGY90HyxXrPCzJ
 N9E0/w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t14ak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:41:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5ab5c136so300225285a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790592085; x=1791196885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5fwpoAryv3us4ayutXSR2vnOZi+CVCnC8HMAD6CvkGA=;
 b=FoMM4/W3ZIj6d54ODCJMHCJ5jhVl8MHT1WgNaTc7pB021ma9ILumTs8QnTQkXinj9u
 QdakzdhVUpBDq+WwIBnD8MG9Hl1yMOCpCnZpphnIl8silvlrjC/Zj0sLcIEInPs68x6h
 tCI6KecJo3PQVcdhT3EZzJdJPWJ7zQo4eak1A5XZmhQE+OJwvwWdSTOHTpuYDRxBVgZu
 QcZJFwGaLns00dXGzgb4Ye0Ww+RT2k1jMU8zaMQAO9273ST3DKkxrA/Gt3iEQgyGyy5q
 VDCvl2on3sIrrIT+UXeQD8/1FE3+VR9C0INTUwhzi+X9vsabm9DlOe5PtR+w9xOJVmpv
 nYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790592085; x=1791196885;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5fwpoAryv3us4ayutXSR2vnOZi+CVCnC8HMAD6CvkGA=;
 b=VhyYHFK9egECyeKL4TAfsvSduQDz+OaLlddXREsnIICPsqRfKmzYRJafa2mb0AXK33
 hdWtQWp6iZh00DeDPwcS0jukTo3GFjkc3Jz2MxNgkg8ktboHFf/SIz0OM/4SvUDbD9ul
 AcPoo+RhqU3/K1xXv8DNhqkWYVtD73Qd4lu7nYhDwkK9FzKZKXb8mfg4Sjmv8AniS3dW
 8699oE+ZTi8SQRsNmioBSEDDa4hSMiDdlrtRR1oVUgknQrDnDzuCYxv+D/g6kzKnW0v6
 LXzKMtC9tb0k/xEWmq4zp5tOvRaS/Iqw7NkCeJASNzM0nNP2NQdmO1PN+vqBR//fw0f5
 sDtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPUQ68WNNtgSAR64XdEmLtVyolcG0M1RvsNdWcD9WqLkU2Md3HbdAT4mf9GE8+6OyT1w7NiBjA/HWN@nongnu.org
X-Gm-Message-State: AFuF++lNa1IaKRtz6/rjr8lmZU3l22spo55rGZ3wfejQLgRS6feFBLcu
 f5HMxxmXhE2m6se8FF2OrL5BFG4uUSshKUu90RuR2dzD5zQnb812Od7DCg9KxC+UNJARjpDmyIN
 AT3QmPgFfW0S2i4jMIxf8lqCwDlsNuHzfFa8gjdSLg+S6kqlABTWVHI4hc+j9EaanEA==
X-Gm-Gg: AYBFou1EpHoWnUdiUUoGayqr/3ggCkT2p4ibuTpy3zcWlVpm9UGey+DT53qQhhgLcKd
 UYhBhmWxX784Go6Kb9kvZpjKkwUhXCflCUKQg19OtbT18avN1a/pSuakv2zap2RWxsW37JbqG3E
 Hqmfr1hkbGHszU4l31BMy6JN1xRfpY0e96NF0T1KIMc2AHvv1K+XsZO3i0R/vlaSQN/cplpDkKT
 WrFg8OLRA7ZwMVuwELo3sjWrX0NpmWubY44af+/eqXwHBq5o+r19emc5O1fNZ2UuTodBqe5MWV3
 dZrSSQkfF66d4XRaZhI5pTWckn5zq//hYd8EbRWq39Gyw4XiKkES+y4nbgBnSWt9XKRaoFYNRSx
 D7N6nbloHnJcCF1XyBoSFnCJLfjNyW27qKg==
X-Received: by 2002:a05:620a:4692:b0:93b:d8b3:f9ca with SMTP id
 af79cd13be357-93c43be702fmr1953589285a.21.1790592085204; 
 Mon, 28 Sep 2026 03:41:25 -0700 (PDT)
X-Received: by 2002:a05:620a:4692:b0:93b:d8b3:f9ca with SMTP id
 af79cd13be357-93c43be702fmr1953585985a.21.1790592084728; 
 Mon, 28 Sep 2026 03:41:24 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017656cesm125629735e9.3.2026.09.28.03.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 03:41:23 -0700 (PDT)
Message-ID: <ecd35eb3-4cba-473c-a4ee-fc680e7d9bb0@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 078/101] tcg: Generic expansion of tcg_gen_extract2_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-79-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-79-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX9Z5ayuObTbTp
 zKqbS9pZ3xPvFCHo6OEnXLR4MbsCmfob4kGn+7L92C++Ums5VTuTYbJL4A6axqHXaIfPDELSPcJ
 oAimtJDbjZc8AYhFJQOelbJgQk7xPD0dX1ImPb9XaDfwafcbIhczn+GCR8YXLOJqcD31oWcwZ5G
 b3++uQxW/Ggp9zmhaWFMBaFCvlmxdvxpKNyjBHFDuaWuxgiKeHGfxdA+v+tj6Cl6X4Q6le3R5yX
 1w+k8xEN2L2HfCqPNf0zdxIrBVyMy/xIj9JvEnFDjt9GVsIRvi6QKhwmYNvMJ26d9JoYpwgMRCu
 qo4jQiON+QsETztnIPYNKuUB47P4Hv9GpePdAZ26bTxNi5TEfGGcBdzKbeh3+ojtBbagzBcdfR2
 Te1GKZwgYr4zt/PqTTsq4awZu14SwxWv00lYPAiQgb7bdVcCl+PCf2X63T6LDQ/2OuxlBOloKJx
 hd0emnrTLP7ugY2lulg==
X-Proofpoint-ORIG-GUID: dKRxmO52TKZ_ZYWD7nw9yflKOfy-ZhjR
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba4456 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dKRxmO52TKZ_ZYWD7nw9yflKOfy-ZhjR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX3puilnfhg4Rq
 7BdGkZaXPtoqVEa5DR01oAfbmUdR+XHCjeDS8qL0m8nt7v7Fxrip/rEtrcKj69xx3SNEV9qS7/0
 rOihlZK0Te3JcRoGP1GJeyT4LYW7Qrs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280042
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
>   include/tcg/tcg-op-common.h  |  4 ---
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 69 +++++++++---------------------------
>   3 files changed, 18 insertions(+), 56 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

