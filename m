Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC9DCA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDu0-0007D4-1G; Mon, 28 Sep 2026 12:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDtx-0007CE-CA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:08:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDtv-0007RV-QM
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:08:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEeUQo941416
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ScpFZmsBbUDZ9ghRwGL6AJ3mDMH3zvydhAg8OMTN/jc=; b=SxUBp24//Rzi7FAC
 WKsnO/35EYH3UEKQocAOhIxo+WSlENzBHZeRy9Iga/4PkvlWep0pKxTHPLS7CAKF
 +JL6/KFaaXEY3syG8VymrqQ1K4k0c3N2WI+egpf+vX4aACJ1mu+iAfdXXhA0s/J1
 +6DqWeChpmIDkwx5qZnVLu3VhM9SpUBajEtzyMyvv0Vydz4rUN2ClVAM/8PuR3tS
 3iJCMlqP0yFIFQNSovPftsAEQ6V9Vmvtdft+fP1dNZs11HVD6gsJSrLVmxUTkXpN
 qF2aJ+eb5rIg7gukR/UekU4WfDf5BMTKdLXe4u93xVjg3BmdNK/vfOIs2Hf/42t/
 25sShg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt12acv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:08:22 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-988a14fe152so140879241.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790611701; x=1791216501; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ScpFZmsBbUDZ9ghRwGL6AJ3mDMH3zvydhAg8OMTN/jc=;
 b=JzqRFLGldGhiYIz3W0ZnIDJuNqbLuYD2OjTvseQ0+j6VbSWE8/Q6AkB/jOEXXaiuo9
 qA+U6AieJc4+3/h43goV6uQZoIpphkt64lqGlAip21vkAlxKztgOSvh5oy37bAOjBRfo
 bSV3f79x+I/ynEpxAD+aMvbeiBCVtbQ+hNhqjQJ+tzjPwPhVuiqnV6Y20rxt6xLgt5Wk
 Z2yUvLqawTMkR1BsCZcT3KCyvIwOY9B5LMo/2E/OW7ww0jPcEJbUbop4oXLsl49Z0wLc
 NUY4yjsWtamplq9uggkxMSdjzIDWtJgj0agFD/uw4xDcUgkzZotMERjw5QDvI9UxUNVM
 lIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790611701; x=1791216501;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ScpFZmsBbUDZ9ghRwGL6AJ3mDMH3zvydhAg8OMTN/jc=;
 b=ny2vvjCAjeeV/JX58hYG0pVIPkK7ridVwM4o+Odpisgc82riDYThVL8s8sApn15qxx
 9/jiWDik0Bzgz4WKo9FpqYFP0Jai2ffKX+aWnXDzbc0+JvlmaZsFz4aJAeiBhCeQbnGZ
 rSOVn/wRv82N7nbqe9PTmjqygOiuysvxNUYRfBu29aePe028Adby8KPwIRA2AFS+KWCL
 9CkFPqBcfgz0aTsVDKUpjoqBaALpk5ovYto1X3AYT1q6vHtBAICHj8h8XSN618FnmuF9
 tAb/oHZUxXyW/88R+6b9d+y1Jrj2eKRRWxVUSm73E1D+ovGppFgc2xGIxXHsbqk3thxM
 SdfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxewkVL6ZAXM7TZDJOp4t7uzb4G3bFKHkaQGfspUnKNluYOK8AdSrX2tkcwa9Bygl8dVrIDbIwXkC/n@nongnu.org
X-Gm-Message-State: AFq9FYI5teYspwZELkiJwpSgK/ahBitblnn2HQm7bgE8OT/cnaTlLlZL
 UAFciPmRa2phwS6rmrFoefPiNkjetHZ6/q8ADNocBN8zA4wt9T0PoPL2NJnyaG+UtM3jcFLGTGC
 ZRdpKhDL71C+ypxtURjobibHba0LCGXthvIQZnnTn9EF38vzwBfB7/DVJNgb/rgvjPg==
X-Gm-Gg: AYBFou0tv+yIXVBsNO7xslSYxoiKg+E78DoSQALpcjMCflCZe764YvtPcWy1IrGu6Hs
 XoBiqvc7aoKB9Dlrnlqd59rg9sZ8bqxv5Pl+jNYHkol/GO1xj9M2EQdbyX51szWtBATb63SCOEs
 cpR4TEVGxoaJ2+M8MTYAAaf+E1Xwh//e5OgO/906NiNfcpuVnmDt4dYKT/bddUccxgciqUf8xKG
 AM5/y/YhB42nKmO0ujczD/9Q/pAwK0RIR43wN6dKONalEJmIARJYBYEuXR82XAyG5AQ/zkBqgEl
 J4yVPMMwnrN8boznPbmE/wr2fwbGa9Z+tkOur7mXMwqIIn0YpngMgLoiIUk48WdvfoDCF3zVr4/
 LkqZt61bQGWJwAFOnE9W63AoBbnQdjx94bGbEjmI=
X-Received: by 2002:a05:6102:f98:b0:7b5:4700:3a6a with SMTP id
 ada2fe7eead31-7b547005e45mr893904137.26.1790611701379; 
 Mon, 28 Sep 2026 09:08:21 -0700 (PDT)
X-Received: by 2002:a05:6102:f98:b0:7b5:4700:3a6a with SMTP id
 ada2fe7eead31-7b547005e45mr893897137.26.1790611700837; 
 Mon, 28 Sep 2026 09:08:20 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30bcc4sm29703480f8f.1.2026.09.28.09.08.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 09:08:20 -0700 (PDT)
Message-ID: <c2c3f7b9-418e-4e1c-8f1c-38fea71a5a1e@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 049/101] tcg: Generic expansion of tcg_gen_movcond_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-50-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-50-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXz8lbE7O8PYp0
 rza1zhQ6MUlXeVDGQrvhcDSqJSU/y4ZEkUnVfphMxAf1+qGeLnMonHlN2BRTMxTo+IqByY2BsYq
 KbzVsvz44QmP/Xxzzjkfu5f62LqfP57gObVCmYvi/4HXNOOkxbF2s5KoCRABRNVe0sBNV/QUfzd
 Z1dKpyznypCzu6QBBr5fKTB15Xo+URZ3ArdmwHie0XvF9xHMSN4QVAmNxBp1xav5016/+DC/dQo
 sm/zI/9VR4nGMpHO9LSqHfBP69T4SiNA+u7jiAg7BLkggMPAJ+XGKcjfRZYGZjs1kTKbygB784K
 uVRQJ2tEXqdnrzlQfCjZ+dyZR3W7F1dWTA/pUigvHb/zq85YUk3xIP9P+Xj4qRmY43wCGAJo6/1
 GCtcDkAgOgeGVJGyp6/1bCDxbwAM+Qm861CHxZ+0zerV3Wco3/Ji0L22qah/Q8iNof+4+pCMc5i
 +y7bFqxtpbX0y7dfBbw==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba90f6 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: biDo95D32aNea-wYT-qcWtr3LypmU09h
X-Proofpoint-GUID: biDo95D32aNea-wYT-qcWtr3LypmU09h
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXyZmE/YPdsrik
 TWTsU5vqmkRXg+r44UvsZZgk7MrTo/xYyASc203EXtNhGX48G3xse60EvIivU2REB1ZoGGSmn8J
 JZYpl/Hxz/Dr1hqe0q9+pCBtfMsBJ8o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280064
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  7 ++---
>   tcg/tcg-internal.h           | 11 +++++++
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 58 +++++++++++-------------------------
>   4 files changed, 33 insertions(+), 44 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

