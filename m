Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C87DC98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqrJ-0002Gp-2c; Sun, 27 Sep 2026 11:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqrF-0002GV-VJ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:32:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqrE-00029A-87
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:32:05 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R1d8En1280783
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qHzU96mPUKR6UHQO/W2vaTnIcaqWFJoUl6eIj5F7RJ8=; b=W1YzsGpyrXDLT1ao
 ilZC4f+aLFvgtqa8ATpN1mVTJ2owCIXqUNFZ0S7dVYyf/ju5cj62fOwo/zNqP5MJ
 d4W2TlkS+969a6zygV8h/RVOvvZpucfrmufitBbpGyhqylAgS++c5hFE4v6MSWbM
 t6nxMv8Bdveuzy4VjqsbVagpdJaayVprsVCOicFve88geezMi6cqFv+yG8TzLdQR
 sYGpx6+ZV8k6C/Mwr2o7Z06SN7MMwSSfhiGKD9b/9jXFgy+POCLXvkesNxvghxel
 R8Z1rKOSr3EE7Sp8IjB29kcaA7j7fwzSkHFmqzaunsBJTZ9LKIzgiwan3fQ02qwN
 UlsRvg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp3gms-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:32:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93be1861d2dso399434185a.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523122; x=1791127922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qHzU96mPUKR6UHQO/W2vaTnIcaqWFJoUl6eIj5F7RJ8=;
 b=SzIa+7cdnrf0Sr5QuUDUx3Vid7WWnVKlyq7TKP5PZZGy3wDYXc4X5QEqrsbQMSaazK
 BTDdyvvvFIFd9WWE9k87zEpCJ5TCTFXNZhLANFLlWE6ORLFAnSt9mW9ekIMEXtYAUQAZ
 Wi2x0iuNWdx5ZSoEnQl7q0BdFb4aal6FyvKkp7E+VdrxhVgm/uPkzF5pJn66VyGNj0nj
 VLOd47ryVD3c4R0N5ce92+Tq3K0c3srNwhTsfitcsX1E7PGZ42ujmBY9UL3kkaZkuytH
 UW7AH6pnDIJBfwGUVu6iiw28gcfQCL0zD7LK6LN2a86m3YzqqTCtrUCt+paYQMrZIQn4
 nAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523122; x=1791127922;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qHzU96mPUKR6UHQO/W2vaTnIcaqWFJoUl6eIj5F7RJ8=;
 b=dzivbrfHd95WfOa8Poz256Y/rbgG/eCE2q3tJ6NV8vNIWv4SybMxE9Awz1tDabd68R
 r+tFmd6aH7CVeQ8pjMXlgapE1q07wYgUjHGLEXPD6aJiCAFFgFMyjLBQes25f3kf0JgE
 KoQ1GGtMxcztt/eQsqIbyLNESgBZJfUrJU9+X/4mifRAAwPtqxw6ruQkpwbFYRsO4elB
 TXG1bFWoby+CyE5FiG3UXRvICvfkYAwSjKbGUEax5u/Qdn2t1VlXr5RG+oZU/T8cXbD/
 aTFt41LFV9tuBK7zvp5Ftrh+MD4YAm4KlE/v0sdVOPIlDxQC+S+BVHWpBTCoLBpne3rG
 +u4w==
X-Forwarded-Encrypted: i=1;
 AKwUvByAme3S8y9UJQSXjtZsO7ErwisnRdIXkzyIXtjW83EJqq1ZcmJhsED0g4n4RcGdATL4ICJUH6y/mtNp@nongnu.org
X-Gm-Message-State: AFuF++nuuUbkeCskf5DKnwOXMb/FzpqrllDe/3pEZIyG8MY0TEoZRjyE
 IBozLfiwpnQIC21gRVD9IB4m5KEvBHsKKp9lEgGVGv8pDg3rMyvWeEgz8VXE3FauZZwd1cwJ0H9
 In85VRFCh9bgcrU1uYMUgNWOGsZhcHMU/GVas4rxCiomZQ23fgE39eHKRrg==
X-Gm-Gg: AYBFou3JYpr6oPFkcXOKTW+2Dt+KmMBY9ti9ssUsItiqlw/GAGh1oYiwRmqfuXKplOt
 FGrEzE1L/BJNyU+6PtqM4oaTvj0+KRE3p6t67cX7c8lHec0qckq4y/kEz5oMuQwqjREA/3rUCpQ
 jvkTuLLzlshU7Mf07riSThRtqsSiXu7pSFHnWnBDsmEkKSgDZQDAImkZN98G58IsjWB4ZxkHEp5
 2mOA5nJulSHeN8gyrQxDeulkUCcG1Ows99wYrSCnJCzvns2yi/3UCo3qlUI9YEoEjmvqbzlOXRp
 vwJy+EHmm2OL4Fv+yhvTLSz/xMjKYYrFQ8pnx3D8retOwQ5kTgF8R3l+pM0V0oMtJpwCEkh5EMQ
 D0kuThHl9pnxkWYylm999tH75fOXYroUr/w==
X-Received: by 2002:a05:620a:6086:b0:93a:1763:5545 with SMTP id
 af79cd13be357-93c43b8308cmr1562074885a.13.1790523122427; 
 Sun, 27 Sep 2026 08:32:02 -0700 (PDT)
X-Received: by 2002:a05:620a:6086:b0:93a:1763:5545 with SMTP id
 af79cd13be357-93c43b8308cmr1562069285a.13.1790523121974; 
 Sun, 27 Sep 2026 08:32:01 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00178174dsm63195215e9.10.2026.09.27.08.32.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:32:01 -0700 (PDT)
Message-ID: <cbc9eaca-a9c1-41ba-aab5-631566ad5dbd@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:32:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 016/101] tcg: Generic expansion of tcg_gen_neg_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX90MzJoXGznrI
 LdB1eIfNiXV8rM2dTd17Am1QjOF0Hw4NtrTRUEalVvlIV04EsadjsvVGIlBe8eOMSPR0QBlcGr7
 al3LY9pH3K61rk1Jqwr8sm8JJMLuRB/TIlaEwvwJq0aPpGhJSS3aaqJZjZC9O307BdhVR5VbwV9
 pNmeicZfs2A+4ZRWMNohaszYKmSlPiFT7Q7TShmbSMFnV1YaHaQDHy9XTSVbCqe2M0W3++v6bCn
 /HjJ7MClvUyOvINnXmUlIZfYLPy2XN2VGA3Bk6DJNM7ww1MWGehgF2qrHJv4Jf36H3zpCDDR2Ha
 zVvb4NPpOjJtc83Zm7wY3EeJsOt/XmP/TSUscuejVPxoxcfD/a8yjTnKI1D7yshZFLqX2tAB88s
 VIfyPK2Lh5cnCAaJ1dhBOkE5dCWYji9bBWec2AZMKL9oe7+WUH61F1QNfbUwXDyVmq5794Yg1P3
 R6mEsUaiyI4R8KD1Hfg==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab936f3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 86FUEHtKfjsRHnmdgCXZY8Se8ImOH02X
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfXxGap++Y7zG3O
 S5/fEh8iJW6UuWca7zVp5nsthNHcWB2pb1wcL7BOBzZ7Q63YkVX38ZQF1lvM1CFwMNXfLgIqhXP
 FulIdvRBWkG25yHzNvzoR4/Dg48LR0M=
X-Proofpoint-ORIG-GUID: 86FUEHtKfjsRHnmdgCXZY8Se8ImOH02X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
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
>   include/tcg/tcg-op-common.h  |  3 ---
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 15 +++++----------
>   3 files changed, 6 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

