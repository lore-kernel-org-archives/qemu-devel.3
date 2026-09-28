Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570EAC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7n3-0000n0-PE; Mon, 28 Sep 2026 05:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7n0-0000ma-7r
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:36:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7my-0006iI-Sf
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:36:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MKkm1446720
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e3GJaHvbPfdbWTxm2g2TFWM8bLvxrqRTzgqwEV6l5bw=; b=Be8v1CZLUK5kxP4Q
 opTmxoTyfvwAicLydQrHZOHHOeIltwDq29YrtdiUT7GjrAjAnRU6rE7KUC/MAL3l
 NqSrYG78EJQhopMsIsm3asiJ5NuaO86APiIir5GvIQOB6uVMI32KXG36munMgIaE
 Lv+cNfNxqZf7QBDKscasXbBfGv0jhcbdpeF+GZDt31a2oHqdnYFfghFOepz0QDRU
 iLHY+tt0jhDVPut1sfkkh9bVV6UcgPE/0hHwMfFi10fT3BrKtXZY7eYcgd601BUz
 1HZLPBSRu3VYK6pn+WXBGThPrA4VWoqgLv0PSYG9s0bNWdNoh6kNLg5KrFmxghLH
 KqL1ZQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfkr26c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:36:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5328827bb8dso75075301cf.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790588207; x=1791193007; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e3GJaHvbPfdbWTxm2g2TFWM8bLvxrqRTzgqwEV6l5bw=;
 b=ePLm5NEupPZMp71l9c476rCNLa0qzIJKyFYEG8Pqdy03nooBLcqmOXE5PObTByyvIJ
 XEmj4LyUveREzt3mWN0Cn+ZGqyb0q4hvUzMBHto/0k/PI+V4PN3mpwJPSUlkod0pphgN
 9WKvGXl2HBJKCwVo8hCcqEppQjFbqOLBmKyfiFLDlwjeTPoFqYJMOL2zllLdRZ1yTAxd
 0gHea5hNmqXxezVISIKqpiBYftppuzzA2Asv8zk2t2heEsCqgWdpqjAgWZ32+9fPcBkq
 U7amVvrMMTzL9AJjz+BosXiNm0OgawSlHaH0Z3Xi+6zOkjcoFhfvHUS2O8LB38h9l+ez
 WTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790588207; x=1791193007;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e3GJaHvbPfdbWTxm2g2TFWM8bLvxrqRTzgqwEV6l5bw=;
 b=tylviV9g3xhgtiyVKRDNV+4ryZAgRiTt5BZTaCTd0uIf+NBIN0NwamoGTmknG0/OVv
 8q8ZX6kTKhIT1yqvADq368t8otVTQs+MKXPaWU4nZD1fNvib+9+pljFeFUBBLeC5+Wea
 Mx0O+p4+UYKXJocqxp9qQcUZjJ9U/1ZLCZ/PzZgPRFEezcmGgYDCebn8BjuXcZ4VD8Ji
 gT9Pexa9ZXDd7K2gXglLX5ZbeO87dL5KVvUwE6k+fVhdELTDW1SqHjRSJ3qNqCM4tmca
 2gZ6nk4rFv6LtJe+UudCfG8xzKlQhTx5j39rY2JsLZ0OX7WL6we8mcoUV/4WtbA/9HGr
 N0XA==
X-Forwarded-Encrypted: i=1;
 AKwUvBykDcSh5fsFcwm9qY3uMb03oYd6JqdnarDFtjXMNfTyc90nVHawf3sHSNrNGoh+KR5yycvBefI+RiJH@nongnu.org
X-Gm-Message-State: AFuF++nctu+soidbHGgNJduS73dNp8eUk80N1gJEH/B2k0KiqmnIX8hN
 D4EaQa0ssuXuHk5myvfjPIK7gsssMpa/9DOGS/+pS0UAufpS6d/iRJ1e+Y3zlhcXlFaF/2t6X9n
 m5WP1N8/LAlsVe9rtI3k7UCIo9/XUxvW6DHnAe6ABmjke2WSGsSrtxUtGZQ==
X-Gm-Gg: AYBFou0mk/9hdAvMVLXkIf6sgwYi1jbRmdZR2xdXrU5WMKoq08v1mSam673alWLEoEW
 bxADg0LPeLW6z86vTpOciU81CVoqsUCeJIHuTOLHEWHPiuT9JYT11nY2XA9Fkq1eE+NAMClzLb6
 9UcaMpWD99fb6Dbhpvj6uc2uWkJazbPR8V7ihElfSL01WAgCV0MZ+pA8T21xGcNQMJJTPXom/W6
 +VxCAUkO/EfjlIACaHjT2L2PdKjjFRqMFW4F9aoybjm07vhOWMRvW96OatKp3QWxSJyiaUCL6fQ
 Id16OmUtO/pyju2YQ0/sloA69UCON3xHshROA7mQQAiTTtZRf8B9F/KKrJtOStTjBpvkHhosFZX
 D9m8J6OiOug5VM6s6/FTrA3w66bpx+wNRCw==
X-Received: by 2002:a05:620a:a182:20b0:93c:5256:1901 with SMTP id
 af79cd13be357-93c52561a3emr1155823885a.39.1790588206989; 
 Mon, 28 Sep 2026 02:36:46 -0700 (PDT)
X-Received: by 2002:a05:620a:a182:20b0:93c:5256:1901 with SMTP id
 af79cd13be357-93c52561a3emr1155821285a.39.1790588206462; 
 Mon, 28 Sep 2026 02:36:46 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a34a76fsm27551023f8f.7.2026.09.28.02.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:36:45 -0700 (PDT)
Message-ID: <7211c0fc-18d8-4bf7-8ca4-6c193f7812ce@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] target/arm: Add PSTATE.UINJ to tbflags
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
 <20260925215004.456336-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260925215004.456336-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX9cfuaC3tSUN+
 T2XPxwnYQX1HGGqQKRY6i00wDrM/dTgfbDwfcQDvSrgsBE1yznRe/zcWk74h+IEyxvg7kYhdphm
 9qIsgHcMvoyAvyNiJw9F5o+A0oxIGgpg3YTojGh0I5rTRh+541cdcjpHT5jjsLCHZ41VEczgP1x
 2gm7PUOvLzSa7gx9BrDOK+eGjIvuQT6aDQR46PJOYY6lPW4wrmm/le34NVRiTFeRSMg96YMwm6o
 I/YaKIc1C5t186SO3tq8GxdM9hCcoXKqJfgUeqjyoCbJX8DssxlucBulqX8qiQw0VjXU19btvX/
 u15Qkfu3MlKKg9T3zcPZiPbtBKM906MsbJsGy9g1YlZa1KArBbMESeNnj20tXEy+AF7Bihwhpif
 8oDAcVOHqLutMEXG8AVURO/dmuHoutwJcpNIiTYgxgrQmflpVe2QH63PfApeooT9nlz48ckxxKc
 dedM73xo2/FF3ILf8Nw==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba352f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gkCNGxoB4m45Ge0QRgu2YOI3DzcWQoWs
X-Proofpoint-ORIG-GUID: gkCNGxoB4m45Ge0QRgu2YOI3DzcWQoWs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX73csmBWUTq7I
 DCt8CBBBrTMpzockehIdZGoaLfppPXoPzn4degLWY4UFal+0ZsfI4/0mz6h+zkPb8KEfb8ImpyM
 ptrMCoGPX/zzG9sFVDjJdYCjJWM4L58=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280038
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

On 25/9/26 23:50, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h               | 1 +
>   target/arm/tcg/translate.h     | 2 ++
>   target/arm/tcg/hflags.c        | 3 +++
>   target/arm/tcg/translate-a64.c | 1 +
>   target/arm/tcg/translate.c     | 1 +
>   5 files changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

