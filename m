Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBC4C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lzD-0005J5-Uv; Wed, 02 Sep 2026 10:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1lzB-0005Ir-HL
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:30:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1lz7-0000Kd-UB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:30:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CRHJp2001805
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 14:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H/UoZeAtRK2b2YF7YP+RGHkQIjKBK40Uh3BoJc6jqqw=; b=dmll+q1Kd+poaGQY
 /Sy2fVFHBBghymClRifv+a38wrLyJnCCS3pFS211vgb4pfltrGnAK3EeXM/w0bRU
 SmFpNQhfHTU5Ip98Wrxw94so7jw9/xWk7g0L1cY81wKQHLlY8OmqLwpvun6YtWlm
 9z87DExlxRQs6JTF0R5zvDPqr/J9ceBRaUHdJXYtyXm5XuWIHIk4jgbv7QXzYYgT
 3zhpFmxGFhnEhhfTI8X5ca2RBqanKKLhNwCcbhpgdis0AXsXmBHftGGbXa0JdJS1
 6s/uQhnB5S2FuQ7RL6F/e/Lh8/bThLAgVl/ZQ4P8iaNRI43n5aFr0w8d4ETOCuo2
 55M5Lg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy17yv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 14:30:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-938153538caso234134685a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788359438; x=1788964238; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H/UoZeAtRK2b2YF7YP+RGHkQIjKBK40Uh3BoJc6jqqw=;
 b=DhRy2tOCGCVgxAQoFlv3fRO0oCLeuJn4ZvKF5Wmg0Lu3fUCJhHvBA9xEgyt3gs9S2f
 Uq7+G6nwkPsspGJD4qm0ZisfZnPBP8IhEwDAghHrPJ+ovUlE4sKZyxC76cjzyVnFN/BG
 kG4iC45hVjvV8KEAo1CzXSSPt3lKu/Q0Yib8nso2gzpuQybctih5lzi1F/jyRtTSJArF
 CiqTQvpsEkHbNCXPwCDOjvsFtENL76PFMtCa5X9BvPZCGLRBdVwPqZ5n7f28YiEZYw7X
 E8TVvL4z6wAIkSfVh104+TJBBJoQB28BpxIDY+/Uny7wUJ+cYauDkExf/FpYL/BeRwu+
 /Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788359438; x=1788964238;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H/UoZeAtRK2b2YF7YP+RGHkQIjKBK40Uh3BoJc6jqqw=;
 b=BECfDGZEn9PoUO2Ar9z1vFL66LGU1pq0zxFqf4UVlLdjywQyhhMv7DuEUFLJyp50AG
 2aRLPv3i8Xdf7Cdq/XXUQTEJ56FTqipeJmGAg8qhaIkBcSwjUHrKEItJmd2diHe4rHBB
 8znIvt4f1VqZneKAdhcdW9ekjzoU/imR7kIVEyjqMnNI0VcoJwTyfhJclR1U6VUg6a1o
 LKP+cjq0oRzLeZVDnbVI20JAU2WLqW8zj/VfdM+cvN+WRsVIsoL2sEmizGwllKaTC2EO
 Ymcbbq1AOJ5NpR0x7Ak3bMqW2xQ/xQndi2cyDOPfKC5cRaHNafWLOPODJULjJv7vbCxJ
 fpGg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rovxtw5rOkBn9iDiTXWGLe487fl7wmviaceNGFC8Otl+sn3h1eP7iaNNRBFa4wzMLc64KiTAzCBsbNZ@nongnu.org
X-Gm-Message-State: AFuF++nRrutMleIQ9a8Bp3e3r32k/qhoQThs8Wf95dxq1gPLKY0fVUTB
 Q+B57b+olsTK/LLKqyA4xPeABh+tmN12q0439t2G53u3X+hjoeZo+16WdGxqFx5wJ2LHg9L1ytK
 uIup9k00k4lfK4uM1K1+Nb2CbR1CxRYaipwgKFbJrLRM081e8vJfT4nZ8rQ==
X-Gm-Gg: AR+sD10w6cK0Xx4mSJr0Ev+cQVKa5ZmLIRg2HqQqVww6KcYFxyq2hTRx8Hh6u7iRdB2
 Fn/Xwvw7w4ITM3yCT+xJnpNiTIcCgcHDEqQEdapQytiOIL00pKZhjeiXsW6WYZhDUBWRB6jL1e/
 dxkOOVwB0SYt+yHXr8UImtJutyT+vv1tRqR7Jo03ohKW5MNkrLlD4vM1rOK3FNDbSkIcgMcyvzy
 8SQ82vgCNkfJxVHUU3xEmldzrJBteJXwHQAakNJtqBr9DaafwXnlIZ4twH2DVKt42WrhI87medH
 Xvvx0HNIU5xIXYJanUTjseshHJ1xLeY3Qm3QhWTkzAVBkMGANilibWuhGUgR56EM2W9DYQCtYmV
 svOMSYnHizc91ONRYzuHqsU93JtD+WhzzCA==
X-Received: by 2002:a05:620a:a50d:b0:936:e18d:763d with SMTP id
 af79cd13be357-93960cb8311mr583960985a.8.1788359437866; 
 Wed, 02 Sep 2026 07:30:37 -0700 (PDT)
X-Received: by 2002:a05:620a:a50d:b0:936:e18d:763d with SMTP id
 af79cd13be357-93960cb8311mr583946985a.8.1788359437224; 
 Wed, 02 Sep 2026 07:30:37 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eea961sm6856047f8f.28.2026.09.02.07.30.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 07:30:36 -0700 (PDT)
Message-ID: <51a72cff-b116-477f-8e75-2c9e13fa0d7f@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 16:30:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] hw/arm: filter minimal set of machines
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a98330f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: j4mOLZVaU2fP6V-_zAQUC7cQziSlZ9Ao
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX+ol7fTSdbflU
 f5kQtOaswecmMCjT017Fd0tjPDWw92BBgjBS7rfjwDZq7i9lPyTi/IMXbdydlbJ81EsYV6PDk+K
 w1t0c5SuT/XAquiW/K6g14yvjumyIaU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX8tbLFArdJdls
 GykcIAcK9lkVzJJCO8xYuSwX1i4j8Ae5PQX9kMFqVh6I2e63G613CrPRnhTd003NEFzqMJEkr0L
 D8vShbBJWGFb8KXu7Tnpwad5jHz6bSbldVDwkpu2+mp7MbsnDJFVOzDqARXUlT2m/OvYPPHEOH8
 0lb5OdiZu4cTKFKjIScoRA19FEUPYBhaq7xHNKcuIuS/LO8N+331Iogs2xpaE9c3CBrb5VDxQFn
 fnTfIztVnwWO8QNOs5Az0C5M6jkN0XVJEbIjJV7BSaZlwTRPpj3GbIp1hLQnaxFctNERjXZVBDN
 3S2Oy7aWSvQvDBua+6zxUvQ3kngj7BwRtnRlfoeTknBJBwSouVJrVTMWtbEuDt/9hgRW2+Fq7H9
 dfeshtwfpOuZLLuKltPDSkVeRd40N4L0TuplhlIW1BW21KnxxBe7pkU8L/2xpYaKJtxHxTx4wt2
 Ta8NPtA/HzpRjq8H1hw==
X-Proofpoint-ORIG-GUID: j4mOLZVaU2fP6V-_zAQUC7cQziSlZ9Ao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020128
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

On 1/9/26 22:20, Pierrick Bouvier wrote:
> We are about to change the filtering logic for machines. These boards
> are impacted and already are conditionally available. To not break
> existing binaries, we need to filter them accordingly with new mechanic.
> 
>  From there, we are free to remove the previous filtering mechanic
> without changing any existing behaviour.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/arm/aspeed_ast27x0-fc.c  | 1 +
>   hw/arm/aspeed_ast27x0_evb.c | 2 ++
>   hw/arm/raspi.c              | 2 ++
>   hw/arm/raspi4b.c            | 1 +
>   4 files changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

