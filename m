Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9881C982FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9cGa-0001Ep-FM; Thu, 24 Sep 2026 01:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9cGS-0001EG-Lq
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:45:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9cGQ-0003GE-Mu
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:45:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5eOs9582526
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nur67aJUcib8zZZQ/nZJsuJluUTnbSTWFEojg5g+b6w=; b=HCzi5j+qTyBnazeA
 rTwvPbfWPZfLsizYclxK0dvyRSTOwCyF67v8zZEqUXfWki8DqwaUjXXTpfNZRA3Y
 AdXURk81MNDlwC3TtRlI/o6tYl/ADQ57q3m0WYRtYkcEk1biF40CuPYc81bd1iNT
 rv5emiX+cXwGJ4asAsIe2NQIcS+3HH4YxssNCsNG8K+N06CxILpEeBTyA23/vJbb
 evkD0QyUZ6dM4b70mSuSW111YkW6tly14VIdo/3ZVW61kdnFk534PPKVl+HO2NQj
 bxcA7NHrQSWleYqTkD7md2GzPiZXs35/KKEnyiiQw1HFKeejm0D+0v7MyOt+3BbK
 JNR9aQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwkeeq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:44:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9308eafb465so386072185a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 22:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790228696; x=1790833496; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nur67aJUcib8zZZQ/nZJsuJluUTnbSTWFEojg5g+b6w=;
 b=Og72G91imyFpcSP/UCR0O9VqD5utceToA1C/EhEziv1TQGHGO+vb1do/T+lF8bkA2w
 IzALAJ+gk70c0uHEdS+yyZIPK/5/Qr4l7vourT89VEHjyyMQDeMhvPUBdTW00hyBEXrp
 tM9euVSnGIx+dfE/p2sF29oWXLo5GmO80KADU3O1BaMABZLpquFhigb0BNtNMNVcl9lF
 LCeYsoCxqV9VetiUAxASsnd5MsHUMW6++4kUhw2l+pCYjd9+RdMnKNjQV5HJgQ7c6Vt3
 t9rAe3PJQhE3zJZMgKDvl+9+pkJb5lwTr1wgc/r6WT5ZvwEyF4WDo9ia5sW+2Zdzqqv+
 W1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790228696; x=1790833496;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nur67aJUcib8zZZQ/nZJsuJluUTnbSTWFEojg5g+b6w=;
 b=PYsBHcjeMupu/eQwuIgv0+jZbAhJXW3gVStvR35jKBCXGGV4x0tauuCnYnCYE/HdXj
 ylMCIyh+NWYrw0JBIa0Auarpk8BoQZXe80ojP8ZhYts6aib7gddlOvSNWyBbNgMJyZkf
 cnNS76AOpCfeuC6DJcv+3V3xGOqXKekiqxmFghZLC7jubaQKMgorB777lHNJ8pRRhNP2
 arIEpGxX4VmroVa4rTb1tBfSLxx92dvwVX/UJ1GA2mQgZIOYbywJbhVyv/s7haVCyGhV
 MQDu8Wcrq+U+YQm4OmBjLGMz7hmLJG/gG4v70vK9Qc4SNfd4W6t357oCmC5ZIhJ8x8W0
 bg0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBymChUEOU50f32klPwdS5WIrTSPGE5L1n9LLvxBTYpHj8sstMyg7XY4QL0gCOb0YBR87EwVJGqn1lYK@nongnu.org
X-Gm-Message-State: AFuF++lOggjGFqmi5tOgxhxpBPV1mfUzFhMTbqw8PhBY+JbGxIsz0EkZ
 t3TipNK9p+6VMdw7Cm/5jb3ltCwVE0FC8n1oPnZMoRZNAkjdMXa9urwkMHpmDekQOuDwGwqzIqx
 poInLlxXjLmeJBUIKbLFOiKXWdzw1U4N9Tigq0lOSWNnIlpeDXk7X62S6WQ==
X-Gm-Gg: AYBFou0y0Q3kG9ljogHAZbuQ00POGI0eSgnV4JKoZteh4GLHPi+K3s/UWzWPxn0wZQ2
 BVDCm8eW3vo+ElPVzGacXtS2Quvtc7dLualhcZ0wx2p3Ep2oWax3Tsicp2vDqWpjnY3pUAUG+aB
 VjT/8gDfSrTaNPQoYQtjazizPUXif18pLpSI8CSyoxH5dYaC3W+RDPujDXr/UDlZ35Iw1Jt0Q3p
 OeM+qV15KxoLtHpuIq+UBGs5eROn+m1wdkZpKgNX8bqInEdKnXYIN5aKDz+asv6XSztJOodwj98
 mkKsfxO6k5usFNabAuZYiwcEwc7YQN3kGpc99k5+Y3Ut5sOm/NLOho6mIEHJnrvs+K71ui7XiBW
 7gy8Yi9Oz1fUOzhWi3Bb40e17fQSmxY0eNQ==
X-Received: by 2002:a05:620a:2b94:b0:93b:d7a1:ba16 with SMTP id
 af79cd13be357-93c36443ea1mr137469385a.65.1790228696400; 
 Wed, 23 Sep 2026 22:44:56 -0700 (PDT)
X-Received: by 2002:a05:620a:2b94:b0:93b:d7a1:ba16 with SMTP id
 af79cd13be357-93c36443ea1mr137467285a.65.1790228695967; 
 Wed, 23 Sep 2026 22:44:55 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48867b49661sm11493302f8f.0.2026.09.23.22.44.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 22:44:55 -0700 (PDT)
Message-ID: <8114072c-88a9-42a9-a8d0-7b3a4bb7d498@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 07:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/mips/tcg: Use gen_mxu_logic for
 gen_mxu_S32MAX_S32MIN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
 <20260914230901.1781309-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260914230901.1781309-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX4USJ1ukuFljS
 V2FAgLybro4DU2NDM+lGm3nR7V7JAR4dKUxPiGXVPMFyDcz4FHtFBPHYWBZQ/Jc/GDlbzbWJHzK
 RETV6LH3oKJAQLJZn4QxpFd7NTxbMJAgkmdDo5LJ3m9aM5tYmGlG/mjki96EQtxDZCnOaDgbvKG
 47yyM/r13n25Xqr/7H10el6p3QaftGl+hiiqMTFIuMLDJseLwLV3Xv9OJA5cwX5XR9uVS4FvUf5
 5oXgkhoHjdbfBEdOIaQVkyH3ds/t0KIMzxwkZacDPNVuxQAYn7tPmcXVq9+tAcawMyQ8RH8IuAJ
 eUwushnUqr5gc67KAElk017SSLcKLB3x861S3gSvCH0/D8nE/XWPtMe4EH9unpw5fB/5reqxSXP
 o4DkoyaLse+fIGSwqV2e1xjfuCQsmg8sc53SxTo9xjjZ807mUEVcXZ0NRj4EYZIN1dBy+YyD9U/
 2/DdS/TiW4zyZ57R27A==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab4b8d9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX+ep1HG1o2GJO
 aQOGNfb7DA1BbrZKaPy/KGzNa2sosT66xuKMIYDPPOPxiRFA31R+9iMl4gHJeMNZbH+2dFos8jh
 GBtYmx7AmR+qLSFJ5FFB4GZIv96BGU0=
X-Proofpoint-ORIG-GUID: WHFiXy_BB6tY92vKGNGVy70N8gRq292r
X-Proofpoint-GUID: WHFiXy_BB6tY92vKGNGVy70N8gRq292r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240024
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

On 15/9/26 01:08, Richard Henderson wrote:
> Split S32MAX, S32MIN to separate functions.
> Fixes a bug in that "0" was passed in one of the zero reg cases,
> aka NULL, instead of a proper zero constant.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c | 47 +++++++--------------------------
>   1 file changed, 9 insertions(+), 38 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

