Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EDCC56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws2L0-0004pG-NY; Thu, 06 Aug 2026 13:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2Kx-0004oc-Ii
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:57:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2Kt-00058I-Ta
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:56:58 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676HHJiS2656581
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 17:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QBVsMIjwQnTy0bI8hSttEivJx+mn/lDXFYAET/4Bxvw=; b=IcqB5muGQZebvAn0
 ALQKQMndAHmXE94Fh3REOSdCuJ81aY9fOhsql6pgksg9rMUvQFQUyi44X64Es4LB
 9cgrs3M+zhW1Legd+1U0s0b1VxStMXtSbqVSjXWO2qqCG/igEb1T9MN4mUqCtdkX
 W/Pp29TpPzvpxTkSucpuu4Y8I8r1RqCuLioNQGMNUHENoBL617G5chnO/H4WXnFK
 WJM/2K788Cp73zzThKJcIUYsp8gGv/oVbLXD+vJjXbZqHkAOZAYfstYFRAd3YRNR
 wQAta9dOr7C3KdOxWas18obAkJAhfE2B+aZgc2qdbTv2usLp5OAnkdErIql8fwBH
 RYUXPw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvntnk2u0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 17:56:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso29585591cf.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786039012; x=1786643812; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QBVsMIjwQnTy0bI8hSttEivJx+mn/lDXFYAET/4Bxvw=;
 b=OL5SF+tiaZC9E4qo16Y7GrdUYKTAE9uOsaKnFljEBoGsrkUPSkkga8Ag5QOlb+BDKt
 LttWjgYWkfqEVN4JI1jaPQTxuOP5hZzCCAZiOLX+DrfKM/oQ4rt3F7s117Z/29QH1jdq
 iqhKG8iOITMvITEZgk9WaBh0823mIVM/tZRTTwxzBMMCtW+gxuuEgDpft5JJJu7iYnVK
 PwOWZI3CT6TenEmVEbgRIywbWbse315As6uwZIDpMBvVMIgwHLT6sZHcGDYmbFyykKXf
 YlyZYP9TiwlfX1g7kF+SrjPSzL39t1yhv2OUVvEZVsUwkOb9DBZoPBa+Yaj3XddFWphM
 QNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786039012; x=1786643812;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QBVsMIjwQnTy0bI8hSttEivJx+mn/lDXFYAET/4Bxvw=;
 b=I41F6q7i1C5BiHoD9jtqztkCAvAFGjkgl4wBkyrWFtNWKFz/lwxi/cL0WIa2s27O48
 0ehFRfRG/jHZ1Po3QCvDqZdqco7eb7J3WJNo3ytyJH73ix5GZ7tzr124aH2YhWk01/y2
 huDUevbktZ6CFdmoBFe13u9CvclxgWA73jhjVwhkppwXz6vsyW0FiDf8g6kMBlxz4mkt
 Hy2Vb7a4XyJq3My7tC9sMpbV0pVAkzDTxyGaKaAM7deurtC4KhdyVRUgsCf1VmXGLVWC
 hv+ZL1XK1n+B30FBcoLpq7rym7CLOieneYTXNm+H7MCeRlKZ683IxX+TPOq0UmqtpCav
 ki7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAE57B2iea59q/nH3m6HVhbKaR2Ll7m9DqqIN3me2clwpp0TP3C6GtFegKcoVWkB6hXsXnHSR3FxLZ@nongnu.org
X-Gm-Message-State: AOJu0YxqTa/xWg4BK4urv5GtzWpvRci3ud5qLPxdAOtVItxEqhvsm5hD
 TGL1cgzX9Qr8zubDDIGvcEaBKG/4NkrC+cFEb3BXKuvCQJkQaSNqqGQbhQQc8eeT9WPIKycKtqH
 Fqet0h2FIv9arOYmY4IrwGAHB9V2UUqqbg10PAUoxcx6mFvLlWpuuFq4qNA==
X-Gm-Gg: AR+sD126h0L5IubXHdjDunDHL+AppNFaAhNdOZ+I7IOEKuzJnXbxl07fixotQbBhzMx
 9DrGzTE63ico+VEVFu8Ykr935qh8hXm27cTb5EyAhCH1DcpaomleQer/g1+hn+bx29NfzecEBwR
 eQxx+o0WnhCmrDOqSgwBLIiF6E7sI2rKy1drAy7aO4v3GPXFn4+OIYr5Zawg4DZWLvaPh8myD08
 wQBOhaZnSJt/HpGuMaTutGcTbjbubigz0TuQnzN+aDWkLhLNAoOnXZE6e6GLH0FfWF+N1eJhLWP
 utOy6c1NMmop0N8gaIPjjETluX52rGaGRgTQnVnq1ojId7/NuHa3XZexUULLr1ysOaVNHIey5Yi
 5THf3V3WdxfEAHMaT/e/juPmaequP4UOyWTI=
X-Received: by 2002:a05:622a:1a99:b0:51c:1a17:eba0 with SMTP id
 d75a77b69052e-52ce5f61709mr179770511cf.2.1786039012023; 
 Thu, 06 Aug 2026 10:56:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1a99:b0:51c:1a17:eba0 with SMTP id
 d75a77b69052e-52ce5f61709mr179769791cf.2.1786039011433; 
 Thu, 06 Aug 2026 10:56:51 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff79b819dsm8108456f8f.16.2026.08.06.10.56.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 10:56:50 -0700 (PDT)
Message-ID: <f6a02404-86ad-4b4e-b73e-58307cd53d16@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 19:56:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] target/arm: Tidy cpu_max_initfn
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260806163939.328201-1-richard.henderson@linaro.org>
 <20260806163939.328201-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260806163939.328201-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfXw2eN8WD1C4im
 mITcMI/cJhiCx40or2zucEn2JNxaOHe76t1kCFcsNciaXlFUoMHVM3+meuqu5lkLejhiK/j5By9
 QM13+UjALlQ5siXSdfsOj6YnikUvdMoKjZvXTQWXC3vrYuXO8dB4PGcz5/uu9/1QKNvBcPFIIW/
 IfjlFBu/t9pcp52lYJ5hiUyBZFEDzmb+UvgSfytZYce99feCRJuqdrvAncuVQvUnAZdaGrJpini
 vuUGF5sfRZVY1i7xER2AOsxaFDZ6eBCRMLI4G1brAG1GZmuU1y4MDcQ2knH5DU7jylvy3KbAVTu
 Rav/tuKrmhmG2k/f0kfLdew5v5ErglCDQVQyuNriV38jyCWvI+NsOSEaLsXVcF6zJOjoOMVJlRQ
 BNfJ63xghF2zTpqEi7v6cTcRoncKgPTt52vSz1n9I4JjIKfdhLD7JDuXEhFmOF+6QDTS8b5GU8w
 Sf93ATw+zhLJLfMQx8g==
X-Proofpoint-ORIG-GUID: 3o7yFjdAqoy4y8EH9QJyOyAl5BqF-P04
X-Proofpoint-GUID: 3o7yFjdAqoy4y8EH9QJyOyAl5BqF-P04
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a74cae5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfX+TQn/BPgj2qZ
 f9yqXao0BD+Y2Zrdpgqwlb0HhosAdJvssnUn+wKdmWUD/FeGKf7mSL3RUAlmkf6K1nW2lO3vkF7
 FKQ0E+KMWRljeb6L5Uisp4RbQPQiPrg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060140
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

On 6/8/26 18:39, Richard Henderson wrote:
> Once we have eliminated hwaccel_enabled, only tcg and qtest remain.

Since f7fa2b88084 ("whpx: arm64: implement -cpu host") indeed.

> We don't really need to test for it anymore, but convert the if to
> and assert.
> 
> Remove an assert on aarch64_enabled that is directly protected by
> a preceding if.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu-max.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

