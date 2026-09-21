Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C345DC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cxm-0007VD-RJ; Mon, 21 Sep 2026 08:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8cxg-0007NV-GT
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:17:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8cxe-0008IN-LT
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:17:32 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LB4jta1129584
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VZM0+d32rtNvzR9nIDqvTH1Rjgdzv4N2DqJc8Hq5kTU=; b=BK4Ta2UNz/R2p4SM
 sbBEdpyUngxl3hWygGfyzl2E8nAeb6733CIkXJ6LiDmYoi492WlQAuOhrWfaLKzM
 AJzO0Qd7SBbnXKms0FX0CwTuwrDw+JP88XCC1HCJJzmOQkhgUjdrMlSDgpPmjwMx
 crT13G/PXiJnUAST/y9QBuiDOAsmaM3XzCrNlO31cloSDg/n36VzSaSIrw7acO3T
 1FMc25kxzP1tRxF/X+u0L/ecKO2TG4Rsrk4h6jpqj1YRxXiWyQcKP9S0CjZGfuFW
 3t1JCw0Dz/Sif57J5vu2+/zVxnmq2uakVuuY3n+xeL3dT+trkxzrWsij3m1+yo3V
 tBStdw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu3csg8n9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:17:28 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c7b0f8e40bso3245866e0c.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789993047; x=1790597847; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VZM0+d32rtNvzR9nIDqvTH1Rjgdzv4N2DqJc8Hq5kTU=;
 b=dzo26HuAh+WkAMI5bW4nVL2zTdb91u/Kvf/InlDIDczRSI3dNr7vXzcPXh5WAfst4P
 QVq6GCCQt59eIIH7GjAcR3Oq0mbEds2Q17FGF5FpdYrCBuikZHCSxDGT+Zq7nwCXYTha
 Ks6m5sYFMMjiLf7O7LIqeb12XQ9WODk7d6cj1n2fb9tfVQi8G3LLiiARpDWHe4WxhBAw
 ZF2/NVHQ4xxnIU3DRWPorNVI4bKA5UPwgzTCwcBfyzxyqrLVNAwtC27ZcbHGXrGKIpNe
 oDKyh5fsEkpdH9J0WM+ZMH28QVJG+ds7hbK55OKyg4YboT7otn8ePs8tqyzb7Nz6LXg3
 fp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789993047; x=1790597847;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VZM0+d32rtNvzR9nIDqvTH1Rjgdzv4N2DqJc8Hq5kTU=;
 b=Ut7BvYpe9Gr6h07Oe7CV53/fCoU6j3kOHTZJBqU+d+3sLDb6ABmZihHu0g/xrxffnH
 iMCqQOMCvP9gPX39aazV/TrZUpBPte9UcFtbTzVh5ymJBr/DhnPbYTMJiZKZopMB03YS
 krOmLi3dB1aqc+FhNrKFtfebTGF8+zl5LZUnY4xw1xXt1tb0+QC0eOMbPA76Hv4XCQfb
 b/pzB3CpOwi0gbaf5WfsWIg+zr84CuKwSZTPPu/CersgZZHYQ4UpeJCC6ITs2+S/VR47
 92Qv15apzboT7/1nT3z6vlAMn6BIPH4ex3aQUwdJ8J7Xwi7VKUaa0FwQh4tllEs8yu1n
 qHOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzr7eITSEzA9umM1GnczaH1l3x6nxaW/EAqq8XMDAVwCfp4kI03TvzkU4NK6kPrc1gUAzGvfdUPDwgG@nongnu.org
X-Gm-Message-State: AFuF++n2Wji+pD0vKa0AnUt+iR5TCn4EzxWvTMmoBAC14l9LTi53rqur
 oUpln9OQdXuOgI+JRDB1pNSfg3OQcLoCKlZpqU4ILyKrOc9tHt1XUNxG7k3vVnp859ZaUwfen3h
 MYLuHlC0vdTNYDvf2Je+ajPXvsQu26I95IZIcWaFvG6DboSyqbWD8Zfife32K3sekXw==
X-Gm-Gg: AYBFou0ehPiKsIGo2pi4opYX2Bsb6OPkkUf06h9ZRIN+9TPmMcUFY8ykrXlKEI6QB3Y
 jHqwwTOsKvd5OaU/8f102qmz9YdhAFkTcIwtOFq7tpVJ3ePqMZbNnrdULXjO+YimMqQ5aTkgh/d
 HCkzyTMuy5PlO0VId6BDegdbM1rq4GcGOsZ70UTBpKkicmBvd3xO1TFTv37p/dBQbQpETnEw19F
 Y3uaAGHTbr5VvZk5WQf/ujRH9lPoDxS7ITbmLOYNCQ7fKnsXobckmVPM7+BPbL+AbdNIKAYf4pZ
 qrIVD5MqVNB6iYr49SRmdJAKmBvQw8NGVS5dq3FHlNRQLTy/l5Ikd1Zm5K7/LR/OZSN+XMq58cw
 M3gar5R0zCPvj8Ivg13VyJ5PAck/MOYgZ5A==
X-Received: by 2002:a05:6122:a5cb:20b0:5c9:c60e:5cf8 with SMTP id
 71dfb90a1353d-5c9c60e6106mr1626887e0c.22.1789993047504; 
 Mon, 21 Sep 2026 05:17:27 -0700 (PDT)
X-Received: by 2002:a05:6122:a5cb:20b0:5c9:c60e:5cf8 with SMTP id
 71dfb90a1353d-5c9c60e6106mr1626869e0c.22.1789993047191; 
 Mon, 21 Sep 2026 05:17:27 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724583250sm22233455f8f.22.2026.09.21.05.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 05:17:26 -0700 (PDT)
Message-ID: <a8e7f8ed-afe6-4de5-ba26-762df86e3c24@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] hw/intc/arm_gicv5: Pass cpuidx rather than iaffid
 in gicv5_get_hppi()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260914160020.327787-1-peter.maydell@linaro.org>
 <20260914160020.327787-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260914160020.327787-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NyBTYWx0ZWRfX5HIR/ni7rHaG
 M8zKBWOnLmfSS3VQM64IeNBBRCX1ZfM9lx2rJcG9pN9r9iacuYBhewWcEIYIbALxnp0ffisOJiw
 E9nrgBywbrVDJe09SCnE0jTGBgSVL4E=
X-Proofpoint-GUID: tZ2zUyVowhJ5DBaNmKXJ0O8ebl6UA6cq
X-Authority-Analysis: v=2.4 cv=QovLTlyd c=1 sm=1 tr=0 ts=6ab12058 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=hhpmQAJR8DioWGSBphRh:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NyBTYWx0ZWRfX+a1QDfh6IoaA
 Xchs+jxypSS6XBV2VXlkZItQdjpVg4LeHxCLqk1UTiJk7EzfUZJWKAwFBQXAyO7BQo0y5gwPO47
 S0c7toWeaMQnBnZNzwFa9YoiXwGLyNUF0HLRtO8+U2nqeZlX9X2iMOSLpiEZ3TgYyRCsHCfdupp
 KbUjRFUq/Zlxb1EBiNiJ48VHFSKHZCl8Jb6ipD/raOFN2tFWQhjVFMF2NTZ1k3RRdV9VQT//jUr
 KmNApSqZTsKudLbVMfeENDIws3TfddQxykfRl9+4jxyTmkCG2FGE9zKS//YXth5rTXnltQcZGPF
 C2xMCwhgSP5uHH85an99ecILRoo0YCAKQwn5Dfx6BxDRXSstMoHidUmN5NDcoe1eZX4lF4Xx//g
 F5qOqho8SV1wllKfu1ZezN7sLTJ14Om9FE8eR45l/E1J8rwiYCKxF30VvkoaQW09SYot8ePLOMb
 zAQUZzyvs/VB7qsmObQ==
X-Proofpoint-ORIG-GUID: tZ2zUyVowhJ5DBaNmKXJ0O8ebl6UA6cq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210177
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

On 14/9/26 18:00, Peter Maydell wrote:
> Now the CPU interface knows its own cpuidx, we can pass that to
> gicv5_get_hppi() and avoid the IAFFID->cpuidx lookup in the IRS.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c                | 5 ++---
>   include/hw/intc/arm_gicv5_stream.h | 4 ++--
>   target/arm/tcg/gicv5-cpuif.c       | 2 +-
>   3 files changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

