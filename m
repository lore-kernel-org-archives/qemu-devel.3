Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B94CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB89Q-000452-F8; Mon, 28 Sep 2026 06:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB89O-00044g-Qf
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:59:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB89L-0000Kk-Ha
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:59:58 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M41S322557
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sslhnxxilEE6lGb1P/gbFN9r61Jm8vzvn0ZkK3TCDMo=; b=PfLL66Ossu6NDVap
 n4Sel6lMu4Al4jA5qCJn2iznlSVYBFZD/Y0oRrY9zv3s5EafjYUYeRPX2npdmXvG
 3uRHODJnrkbM+pPk3yMAz7nVx68QvFUEx9JfyLaQCPSfSg6/OoN0V5qylH1JPkoY
 YXMDu9nyRkFlSwJll4xl547muyQY5Bxz5eDLFOIa6q8+hN4X9+mW8kkOGbBXwFdI
 9tRCHsZoh7ZbETrFxH52ScdQa2hopO3baydEDbTEqYdFim7NXSAON1Ws0wiL2bBH
 S5Tt3qY4f7NSut1bgLlsDxeDt46CgG2LjmbE2Gd5EKFtj0PywlIIcgaponcshPia
 D11p0g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq1m2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:59:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934956beec8so620503885a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589593; x=1791194393; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sslhnxxilEE6lGb1P/gbFN9r61Jm8vzvn0ZkK3TCDMo=;
 b=O4mdhQ5ALBJ/RM85P9lKVLV8d1NzuXQD4xASWouyN+sCm2tOLUBaI+fHHq1TQlZEwP
 sqSx7WkZ8RrVyr1/C6NLKTdFv6AvesSvU4FHIIqnpukA2ZeXA2NvwW3woItewkVlL6js
 HJG4ijLX7mF7N0lB16Lpelb3bN4rWCZ335rNLF1ZwKcrBtatAeeHBAd3QUYQP9FwW51q
 O2ElgQEOZ6yK2vLH8+k1POq2tvF2YjCpEwQcHsfNEHCSt1eCUFjtFu7w4xLCXa6sPLM1
 9bsqUWL/ooNciIq68qfI59Em85IvLqH7BRdRzOG7KRlEz2tPjOVhjJBqAxyb/YO0tkIY
 S1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589593; x=1791194393;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sslhnxxilEE6lGb1P/gbFN9r61Jm8vzvn0ZkK3TCDMo=;
 b=L/EyPsFweMDvT6BpbXgkj4KhCaKG1XL7wRPoCgYQAW6g6OL7wApDMcuVfvWmNiPIsF
 PX5RtJg5QtFSv2+gzrYwR9fIN5IU6eK7IcnseKrU11D9ql0LFGeioJRy7EmSoFgj+cHt
 PT0hmIQQPrMmLBqSyqy9S34QGsaFx3kBWFFBoP08KjWJ7SMu2WFCpFdtsSiOvLykJF6B
 9OvbUXY8CZwNWdfpVYDBUDHoMQHUpV3U8fjbhKrdUQLW01J8vvR98wXyUtWfpyybxRo6
 sy9dHHHK8GZNM+FTcST2cFE003g29Ay26UG2dSkWua3dwbiskU5b930tdpqJ46Es5yuK
 t6vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsTWd0N9d6dJ2TdLS8q/zvzJUmejKjHHUNkLQQ3W289S+jl5jZQ5gkqZRtYbfvlnPPxrKJaX50tnQT@nongnu.org
X-Gm-Message-State: AFuF++m/1gT8HgLy7e7iwg0+rS8Mody7F9qaEnqhfZ0bw8F9Rhc8+Wcb
 mblk0AlypIoaG/H8PKGhCK+NlQjON6DipDylXOzI7T6EUSP7k5AT6jXKgh/vx49A5u94338QW9R
 vZDwE4LBDiMQug62TrXyKHwf3GWnBcCwX6KYNJcxDkEp/YFhFoJ5V1ZG5UzJyEr0vDA==
X-Gm-Gg: AYBFou2h7yC1gKU7X+otHQmpgZUb7PSBfnCGgGxvBdLH+EXZqexAtl14XuoH55jBlT9
 Sbs0sY/nBX8sV1dSR2nbhXhDQrDAOSITsaW099SaTWTBfSNHXxgiwdNYjFFd8pL9xwD36/HFO8W
 rG0lho0Y2igeVbc0IO5zGfTcFc3dyfhUJ5qY+7RRHf+BDWDcKmiFzlAYH/7K/d98rzQMksUCnAS
 sR1dq1DikuCpwN64xRDpiSlr8AX0Y7D2c04WTMx9IXzOywjU6U5Mck9SdHYc1C9NV6oZsbvHUA2
 n50QwDaOHGl/Z3QZ92Ukcnw1a+0RhEGy3Uwla2OG5cZdDi8vLfSo3NxsLuimMuVZrD5dtoijIPD
 cqYkKLQdCwNH39+EVZXLQSbpizYh1E5ZtZw==
X-Received: by 2002:a05:620a:288f:b0:939:6dea:4f1b with SMTP id
 af79cd13be357-93c43d163dbmr1942842685a.49.1790589592961; 
 Mon, 28 Sep 2026 02:59:52 -0700 (PDT)
X-Received: by 2002:a05:620a:288f:b0:939:6dea:4f1b with SMTP id
 af79cd13be357-93c43d163dbmr1942839985a.49.1790589592518; 
 Mon, 28 Sep 2026 02:59:52 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm29323178f8f.20.2026.09.28.02.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:59:51 -0700 (PDT)
Message-ID: <6960b2fa-4755-4f2e-a485-bb4f84574b8e@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 095/101] tcg: Generic expansion of tcg_gen_st16_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-96-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-96-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R2qFDywIAIZAxk3-TZ02f-mNPVOqsbvw
X-Proofpoint-GUID: R2qFDywIAIZAxk3-TZ02f-mNPVOqsbvw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXxGsLTcOVoDIa
 nVXU/jpDkzmole9vsFhqZ49g7nl0z3eM9rRPCcBtrdOrC1xyBOHpqN2+mHCSJ2TY99HTobqm9Ay
 PV5+lq7YjhA0GddKo7WHMY8ioxmTWk4=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba3a99 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX5KYnVkdAFBeo
 jpxwtzN4Ya2etxlYtVPUNXnqiM88+3F1z1w4KavloP+lmzcOgnGxRTPC5ggqoonq5j2bLQBEao0
 f6kdJ6uA7SSdwT+iMvNnDkQlW/gS8ClUsERkC04heQXtqmz0FiRh7U7rVT5wCEyidsIStZz+qnF
 UUNVm0WFy6Aaq4RK8+VxphlsYHfp9R08L4lBVq6knjWtcJdBdZDxPMBDNFPtaMLEJfP2UwOIAem
 BK4snUnDLaFgalt4nctnadbrqYDgHZFXQKMEXVablFswUFa3eC6BkUCbf6IGUcDdpbG9OT10foN
 SclJ+VgRtI+SpzZI1YItR3lUqL5CKLRmtp1r/tzV0MaKDGsne7OzjPxqlpXJijdvMo/uKc8US6v
 A/B1NAv9jlJYt8UQNzmf1zCNhv3CPhsj9ig+KhuTXHPQxoIA/MAY2tmmpH3ymSIh7Tpa9EwhdHn
 X1IvGVevY3v7xNYFLmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280039
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

On 27/9/26 11:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  3 ---
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 23 ++++++-----------------
>   3 files changed, 7 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

