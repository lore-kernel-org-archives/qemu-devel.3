Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D50C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB88Q-0002uW-RS; Mon, 28 Sep 2026 05:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB88O-0002lt-Nz
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:58:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB88M-0000IA-RV
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:58:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MMoB954631
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +KdcaflyVLkWlSypie0tu3kzEKKt30hcDQN4uY3IRcA=; b=Q+YzWxF9AXrHVIbH
 LQZTAVkzFouXH4QvN3JH9dJOFm5HetKLsIf0k2yq+3JlqW6VTGlvZ0e/igppUqX7
 lbj0/hk5Bf4i0439SY3iMJ2hk5q/Xeo/zrSGZIofsBrzefvlgZXDHbD0mf3yCpme
 1d8l5WEtvhZPrIDENq1v0+9vTvgN39OsObvLjpOJ2VBQeg9LPo30SKFSlcGhItVi
 WiyYute3thw/BjOf8DxEidQLHD3S1Y7VNgD4zGWhXBRX1l9tIVcRRupOlf7GEc5J
 OM1qIvKm1cMgzMkarauqvhUUQZLuFqjfEI0VWu2c+QdcGPJ353jyj5nnDWFMsLOs
 z1Hfag==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc068m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:58:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ae8e7e546so586245985a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589533; x=1791194333; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+KdcaflyVLkWlSypie0tu3kzEKKt30hcDQN4uY3IRcA=;
 b=PJ4JhtNRXjCQn/jx8SnwFWLqZJjW/xxQQZmsKIYgqhiNC+umkResleUY8D6tyk9gKa
 40VQMgqw0obI1Cbm48W+c2Z32K2HiI+bb7zI96i5dLuoYqiJyuindEWQsAZof3zYBr5Y
 tg5epYa5HaugBVNrv4IhfJgrZx+AIt9izfg2okhdsOHQr5NDwCn5wYr9R3+uE+dQMCMa
 1so9owFDyUCKPaEQMuRREfNAcr1eFlqekYvziQAwU9rMsJ8OlyzQK9SrKvHY/cpR8Jr1
 RRCPaAhVxdvuNi9Y8jSmQ5ssppgeFWGh3zQktm32EnOb9E5/rnLQow6eDbQOMElCAa/X
 nFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589533; x=1791194333;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+KdcaflyVLkWlSypie0tu3kzEKKt30hcDQN4uY3IRcA=;
 b=iRAdUmiPzauESrvudkMLOUa5sbDcoAPSFylJ6QXl8GqH5iAT24eaPxhsJ1xgIANid+
 45hH1lICo9hpjLFoYzf6p/b77u0mNFxSZJjnf0fPH1BzgSeOMIfWy4//CVioRKAtiYmZ
 i4Xu7ZuDMAXsErYfzul4Ry8qTOu9z0xEU7PjB6MBPkxDJf5Ahdt3leqw5DHB6jb3HBQi
 FLb9l8yO2T7YMhdV64glcNv2F6E2UHsRgs7FeqwscO5BF1bbCnkY6mLQzj0oB5Xb8xJa
 1rO2sU4crYp9WiF6Mwb3xZ8MU8as9IE4Eao2c9ZvgzZ6qT8N0jxNESmMdxKGJzSIzAMJ
 yttA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+omnHMDfQCGF/GJpeNhXW/4cMcA7SxhF0ptpq8IwR6HhpdO4p+Z0YxkzIEmhJU/NqW9HoX8NkNvvZ@nongnu.org
X-Gm-Message-State: AFuF++nFu2NJ25NVVcdaqwsMxmtlLpZkfP3Ib6qDRLMdNnO9UwlwMsAI
 dEHOcpAMGEmu8EEruOmNZX3AtUoKd0lQnmg7WIcdKGrbMW/U3780KbCVuATFx8g2cdCqyNv8nLK
 ivEQYWFI7exaqXFMVuEcQpaxkCKDO17JWEs8XWzZuj36cUxgNCcj9Cy5tjVC0QOT6wA==
X-Gm-Gg: AYBFou1q/aAVftzOFBD5FNuTl04eJsIwnJXee96x1KgH3Ll2zWAJ18la5kty0227ugF
 Pqg+To0x9dcFn+PfXqHNU3lG/W/aBHMQTuz15uER2Ro+2oS1IZ2e0gwxsTK913hWM+IB+G0N82d
 K3gfk5+FKVYSsAHqcRLNTRV+DwLm8DUVo+r0meih3+GUNlX7c3WTk20i2SnNHu5zsvEL/dFmem/
 n30bLi7vkPH6QpcKVQ9jhds37N8deuin5cNOWzFiCNiKHlTYFhx1Fo9swgAGquoh2eAr5r5VZkk
 70sLxR2fGS9lYxKJaRWG5/w04+wkQn1eQyextHaJ4iERSKTcT2pjMpz6+FpMnV1yHGXHkgWy2Cj
 Y3IoZH/R72HYJPFqs7r61k3uhOHn376DeCA==
X-Received: by 2002:a05:620a:40d2:b0:939:6de6:9518 with SMTP id
 af79cd13be357-93c43cd9749mr1807701085a.47.1790589532913; 
 Mon, 28 Sep 2026 02:58:52 -0700 (PDT)
X-Received: by 2002:a05:620a:40d2:b0:939:6de6:9518 with SMTP id
 af79cd13be357-93c43cd9749mr1807698985a.47.1790589532513; 
 Mon, 28 Sep 2026 02:58:52 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fee6ced69sm171666775e9.0.2026.09.28.02.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:58:51 -0700 (PDT)
Message-ID: <494acc66-6f8a-4e27-949d-c7d494ba11fe@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 092/101] tcg: Generic expansion of tcg_gen_ld16u_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-93-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-93-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba3a5d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xLjoGdnADhaOMTuVG1UGVSMB6Xx8EjJ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX/G6S2LnqTMxS
 NOGp4kfsgAuMCwsRWfXzACmX1j++2L978VABuF6S4vusL9wvsQn8SUajjF3pgDhIaN5Iitncco8
 Otsx9rswNAmbISopB2oyyFDhE9dH6Y8JN6A4IUM/x71Z8Kys2txkEW2cVHeSUAlWs8HMr+CbdhX
 T+n+atWrdF+XPQBi4u6nVQdsGHVM6JMeIiXrndU+8m5HJ/Z6kCa7wc9l6oZ8K8LnzHvk5Yh2Bhg
 Feoi8WGEr8HJqpQzZtiaAUhCMqREwTOsvkCSF1+BNPCwjFFbjLeg1CEv5BtaXWKZ81baxn2R0X4
 bf9DeaRHVrhcNdsktI6egpUNgH7DKXNUkBJpyRykMpuaJE8jsNj5YvAAGXMds+4cs+9oEoF3/kV
 tDTQY0zelVnzibuCnHsT2OxmKLa23mO9OxNeKLDCSsrVwE6keO/5qdSYmHy0xWk11Ezz6IXL9lQ
 kXquwaa9LWgKUcMNrPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX0w/JJEw6Bmse
 I9xNNIaSeC2J0gRXVfLARkV1BSoj4XN/s/cnJ2Z/1rowKlGlaadq0gnCB7GzX/gC/kSLS4v8zsS
 YvAIv1lBlHhUW89sFGHHB6oMHm3lGPc=
X-Proofpoint-ORIG-GUID: xLjoGdnADhaOMTuVG1UGVSMB6Xx8EjJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280039
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

On 27/9/26 11:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  3 ---
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 16 ++++++----------
>   3 files changed, 7 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

