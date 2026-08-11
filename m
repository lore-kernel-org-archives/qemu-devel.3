Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4B2C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgDa-0000Bp-U3; Tue, 11 Aug 2026 02:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgDZ-0000Bh-NG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:44:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgDY-0004WB-8g
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:44:09 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMpuGW1751881
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ilZMEfWO0VCnIvMpxWDGLDzjVS66QHZALIM0bfICe/8=; b=OzdGxnAF94PpyVso
 8a6lFaz/TNtLbRrKBF+OpNlfza9yLcfENi/qNIoKRt2oZj6A+pCHD24Cb9jtfJvF
 nl0rt2nEpPRNeQiCNdfu7ToFakxSHNqBG8VJj5jfTQcZ1IB0Y1ok3b/GwN0MkPjI
 mhZcqzSX1Ork9ZJVN9uMwzUCpzz77vAhAYR/R0aBTnMoGc+GcTAp9H+HwJ0Txn8e
 oLE1AbnClygZReevhb00pdT9zP7CoL/CLxdDtF7je7IDbvUPXiB8VgkEcplOot5X
 10lI8PnKLx7HPGUtGXyxsP+W96A/hwpriyIgLh8WpMIXJHNVhXs2fz3YWeSo+DfD
 f0KaQw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fycgevhek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:44:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a8db414c7so37801981cf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786430646; x=1787035446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ilZMEfWO0VCnIvMpxWDGLDzjVS66QHZALIM0bfICe/8=;
 b=ORHEYYh1Wljg7joVOBGiUFT7qwnsXOUFwkSVsVK5EwJKWkjGK1xE4RK0+U04vcoIdK
 laIQv4zyhjueTz8r4AVhCPGCwY1yJ82sVcpmM3psZp1majtkU0JkkXh/wvx2XL4Sposh
 NBrbiFdnrUL4NT+YwFAhAtK4BSu1rxWwXTyihfZoGXIICcT1tG2ffAX86RxkBYuViXQg
 7Gb+X5HD4v7lliSwVbzL/YPr8VGlQLCwCnx5JfcnE4ImI13zP1HU1E4lPQhbM+angKEj
 +bptDm0+F6j5D+mgpof8Q4npFfBxlwjoklZetS8Zto4vGZDO+bI+4RlHX/y67FbOY8GU
 Ys3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786430646; x=1787035446;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ilZMEfWO0VCnIvMpxWDGLDzjVS66QHZALIM0bfICe/8=;
 b=gPFBFd+kbwofHTex5ABRhdle+u+z8s7TAj4gZI8MKva1li/fAiRTy0hSg4f0DBjQUQ
 S8ex5uRYDX24Ll66dGdhZ66eWv/jSrJ8BaIayolEBrJTioVbF4kWc/s9t+x7yggRlyLg
 JMso4pf98fJxdxRO2nDCH7u5UcN1ZSZmc5LV1WZn8mxSiDpJdbq764ymWuGA7DHoC6lf
 ulOEEbEgdXShTzkImC9rwghilAV+TpZncewMiIyxyqHmElPmylalyO6AzOhmmQuAp/my
 1xVVZ0jxeqAVrE7Kau5Ng6e39BepXoRmjfz6Gbyqh1vEBeXfNMyDfYaiFOkIq8qniF68
 lk5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Row7l2YAscq7ZDIycNv1me+L1QLnC3k/6Sy87heP1zbydZSmsyJ5G5itQUnbK8RZI/IB11TmgmQLBXF@nongnu.org
X-Gm-Message-State: AOJu0YzL2FHaB/rOQPPkYwuFAU0+85igrb7+/Jxez5jFaKp7/4Df0OXv
 qzLpqcjBLp43Vb/CrOT86XrtFv1NC8zDrUCECkWozVmlxQGEbY+N4mW13oByJKLc6iNuXO9btL3
 4QUwBWMIm+HTMmy0RDavVKdGTMba97xdE4fBIYnj4ch+1poERCyLzNR6cpg==
X-Gm-Gg: AR+sD11OO1RJ23DkVPYuerwudpu0VJvoACI3Z/UBqlC0s8OjGdEiOWhdBp8Gck+Bf71
 w9vB5WaeOYKbO/8gREvH09IL4c1WEJCVYmkhqk6zCEQxwCDul4r2zFMD5uRSBuWQWE9ff9zc0Gx
 JAIyD7iokVj1bNEILyQR7TXPhM2wC0/u0b5YTB7cVcznf8t01VxPGj2y6BrUSqpwgVrpfYZDkqa
 pFybi7rFxXXvVt6YJpSQYLpS10SRpVSjESJiUrxKbnqGxz4Q8zJ3VPVhQYWnFXQErXfYK8PiBaY
 FBAO6bOtb84ytWJ4CHcC2NlgBhpMrTMAyXq4lrJC2jNdwCESYFQ4xcqp6Eczfr0F9oQWBfJsJ6h
 dmSotmwP0akRZ4LCyS8sXbOzY2HV6/y2vcFUlU3ji
X-Received: by 2002:a05:622a:588a:b0:517:5add:e449 with SMTP id
 d75a77b69052e-52d586122a5mr9906001cf.22.1786430646216; 
 Mon, 10 Aug 2026 23:44:06 -0700 (PDT)
X-Received: by 2002:a05:622a:588a:b0:517:5add:e449 with SMTP id
 d75a77b69052e-52d586122a5mr9905521cf.22.1786430645553; 
 Mon, 10 Aug 2026 23:44:05 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977e57696sm16257485e9.2.2026.08.10.23.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 23:44:04 -0700 (PDT)
Message-ID: <d7fe8742-c036-4f40-9808-a0a181ba5f77@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 08:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] target/arm: Use generic tcg_gen_revbit*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
 <20260811045605.1246543-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811045605.1246543-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -c9p11e36lKckqE3K8hDnXzCh2nMQdyX
X-Authority-Analysis: v=2.4 cv=R4cz39RX c=1 sm=1 tr=0 ts=6a7ac4b6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -c9p11e36lKckqE3K8hDnXzCh2nMQdyX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1NCBTYWx0ZWRfX1ciHgpddJ9Yq
 P9WHXo8C/751SM6BBRPOPZqskpDuq0jPq34YNEjQG7Yb7KDx5aJwbe/XapNPWwFuWOBnz8dJSkD
 L2dcMK9QaHF8qw0VUqmnV/c+uhkyJtE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1NCBTYWx0ZWRfX2Bv1pg2+OHnV
 XGdRoGtflXmFz/iLXOuZ1OEoYR4DhAca8StydlXX9BQQ9LOnxg21Jv2SZkSoR0veutf3T7D0Xdh
 0A3i07DsF8uSaePA+k/sse+/nwDHntEW83fvyc0+M2aaQ3QcWyDHVgNrikdS473H1/Lt2gIpZ/y
 wuYeNQS1MXugoAIYkhJ/Bm3CyUWtanhddvqoj3BqmgzqGtgLYoOHj3qOxqBEPatmjfrwd2o8RcA
 7t4BIcBwDCx3y9zyrfzaibEWOGWUaeEDqC2alYSfDdpGYEaqf0/8HPCc8mCceVmNoDENUx5c/z3
 Sh0KduTl3P60vG/T2DnuQS40EV4aMcfIYsJOGiNmcGxK3AYeijMfBNijM8+17roidUWJ8GkWNjW
 4D63F8EslFPa1Q9kcNGMEHDsXQcTziHaWhBZbFyujYhZ0X72fAAb5oMnUu25Zr1mlw63igQMVFk
 Es4PwCIEzqhyOYOzyZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110054
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

On 11/8/26 06:55, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-a64-defs.h | 1 -
>   target/arm/tcg/helper-defs.h     | 1 -
>   target/arm/tcg/helper-a64.c      | 5 -----
>   target/arm/tcg/op_helper.c       | 5 -----
>   target/arm/tcg/translate-a64.c   | 4 ++--
>   target/arm/tcg/translate.c       | 2 +-
>   6 files changed, 3 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

