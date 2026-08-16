Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C4BC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 09:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvX2q-0008SK-Bb; Sun, 16 Aug 2026 05:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvX2d-0008Jz-RM
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:20:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvX2b-0002ow-QE
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:20:31 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67G71uNm1945819
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l3QyAF09ZXfHYyKDxPZWl4pmBZgtnF4lqdnSxlFCmtc=; b=BdWoMFeuwmAp+Chf
 nYURZAWIX5WXoqH903KKj3Z4pncBre5m2yq7joskybN3FC3TdpwmmjguoXNkDjV7
 cXSQ5kSSORCxrMNofM3IeGSbe2VpmMaaPl3oewgvOwt0jhWyNjsAiHRx77fy0NNv
 fo/3N/32KYdtKcHzcpwquuCywj+Rn2ZpdEf3GgzkdC8Wo3UjP/oD9XEtQwV7ixKJ
 iCn4HdGhqX6ulMvE7krJFdKg+nMKB6c3DdpNktiYyTOCYosTHSomFmZTmqA97F6x
 1Is6Q/1/y+KzCEswfixs8Dz26thKWRrQ1NzFWM3uugXTA2HHwSZ+jWuO2rsl1maA
 +UiwTQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gk1ft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:20:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-529ae8e96e8so31817761cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786872027; x=1787476827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l3QyAF09ZXfHYyKDxPZWl4pmBZgtnF4lqdnSxlFCmtc=;
 b=A56F2Tc++ta8YJquoxgGVdUDwzq5/FJfvoutNEKscYW61qtImenLcTSL3A20sZG6oR
 q2fkWoiCsZ/zByrd7KXPOXD8comGXD58pHYZqsT44fPQmC/eERvOBMHKYnxp83RxrW0H
 KkAvyaxdC1kEOAw5zC7s5IedBqDzYLDVN3g0g0ypAx5k9FnPi/MGQHfvLNHb1g9D2lV/
 lJVg8rVncHX5RI2lyDQV9PyAcjrZqk/shER9hhKNEXHQACpP3B241nGxXAmgJKPEzQfp
 xZ9QDwotLQf5hCRt9HXp3j5cTdmxPhPUHkM/4TRjOjFXHf9IGkCDjqTz9gALFqu2EYGv
 z3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786872027; x=1787476827;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l3QyAF09ZXfHYyKDxPZWl4pmBZgtnF4lqdnSxlFCmtc=;
 b=gp9aruhOpNTGuI3h6Eqv3a0+T85wGtihRmrALha+daJfN1X7o/QyIkEj6nVf0teuK2
 RP5fe8f7dMfihUH86/QZ9n2oLPaMQkDWS54SeuPxXpjh0AtCGuVkVpTbq7tgeyqBKawk
 YPJLZ1JMvhR4CUZLWLjJwTrwXJFSOQOUcqRP38116wS/WuGkd8+m16Osdo/SQftjQuBg
 rIfxhU17mHtl7di8qFi+CTWs4tfSapyPhFxNQa7DiRsccxKJ6yDrYnqLA7PQGDarzZ79
 KX5F5kHZGxtDzKwGBE+LYvSDmkldPh6DNZpJbOJ7Oh5G+sK39V2MbAk6v2M8DJudFqsc
 jh7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrnaI2jU6qFuWuGo3WhPWOL+c7E6S+66eLWGa79kZOFVqiVLDLNPbrRuGEwt6UydGF31VRxLhwtl13y@nongnu.org
X-Gm-Message-State: AOJu0Yx2n11TBtbjpaJHeOoSVwTKLVxk8a+SrIYAcO7N3nBg9cejMDC6
 uq1PhUjmbVo+W7LYCTcZE1UVXH+qj+82aAvaW6G73ljYFKghb0awReDLnrkrblheiG1BV2Oxiul
 xzjr7tLAKPQS5BWSca8YpvPJf/mfaDnHTu4H36wC2F7H9V21HIXk/KHejcw==
X-Gm-Gg: AR+sD10Ik4iE7z1FNKuWtXokoM5j3hIwO8ePZQuOyeKLK8PmJUUga3zB4ZEhLYVsVek
 B65QjBhOlWUqWMOwpHRrl1zxfJa8JYa1nrF0YOiZ/8oIiI5g72iMs77kCPsOgY+6A3tD78CO0OX
 Wej2YPNihM5EM9k2QfK+L3mGGL5aqtxXR4fivalh370OiQFSfT/S5b60H6wfRIsMYiu7pPYDcXX
 +n0Xyma92Ss4GSx58aCzRtoDAvlUMT1g6lNd5t5rFfhIbifldIb1QJ5trTU7/xRUIAF+6YuRgzD
 yAlxMPprnrruSxKFCotUlX6CBfCvb3MuR2YAnN4d2EDvO2eFejZWiTZS1VnKyRtMtsit7003DRK
 YZ8UcVqUdezRd/lE+76HH/MNfQ2KdLSigS7U=
X-Received: by 2002:a05:622a:8cd:b0:527:631:8d6 with SMTP id
 d75a77b69052e-52d854c66ffmr216300331cf.25.1786872026802; 
 Sun, 16 Aug 2026 02:20:26 -0700 (PDT)
X-Received: by 2002:a05:622a:8cd:b0:527:631:8d6 with SMTP id
 d75a77b69052e-52d854c66ffmr216300051cf.25.1786872026422; 
 Sun, 16 Aug 2026 02:20:26 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499960fef95sm38486475e9.1.2026.08.16.02.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 02:20:25 -0700 (PDT)
Message-ID: <296d23a0-3157-468b-8c4f-e04bd2bec201@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 11:20:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/18] accel/tcg: Replace size with first/last in
 tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260815203730.1468365-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ahnLyx_8krNh-2RLzptRrsCyJsAe1dTr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDA2OSBTYWx0ZWRfXxLREn6nQjHt5
 jOq5icn6f3E1cvihNJ8Sl6gmPbm09xcZOxapLvS4EIdH1w5i51m9FJIE172xLtgWXZVPVnjHkCi
 QQeHRM+HDAec8vYXMn29p1EMoDcN9hw=
X-Proofpoint-GUID: ahnLyx_8krNh-2RLzptRrsCyJsAe1dTr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA2OSBTYWx0ZWRfX7P2IAO6zd5ZC
 CjBQ4lqFT4uJ5j/lw5GNeZoHzUXlh0HsKs4EzLzycgJxJpCVa7+musQK5AqfaGUjm9JMw4B1svN
 bPqJ5sl9GZxI5G9yp+VLtV6eScg96AhO6wCyKacW3/9sp7wFv26C0qKJxmVvSlLTTVWQHQ1MfO/
 IK/ZzpRpGcfiizt8Ct2n4vXTHXTc8OtEkl4bcmHWaS1SqRr+YuQ4FCoOljixJ+x5jiUTk8dDVDI
 lOjWbyXGJbZbY4VmP5gdZ6zcpNhz1/+WtjaYH6sFwCA+PTTXMwfb/bFNTnvxaSKRb7dyVEi7ooo
 1XLb/CAC75aghMHycjhwUEzl/7/lLtyMmbiS8iljvGPVHJ7fF8iRtvNZ2utBCuJmX/scvTdaaWN
 GnI+7pttbtWIqcqEIkQ2VDQLKQz29VvBwbFkgz3xUu1KPYNShvcx8dwtFvLFRSMqJH9XYpDh4EV
 NIjGkdx3T+qLknMn7LQ==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a8180db cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/8/26 22:37, Richard Henderson wrote:
> Propagate the API change down one step further within cputlb.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

