Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E52C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyrP-00063B-LR; Tue, 25 Aug 2026 17:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyyrO-00060W-KH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:39:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyyrN-0005Aq-7O
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:39:10 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PL9fMj3675854
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wvGvmK63YO3s3h6jtGvoLr52Ed8ksoOuomw/54SuxKc=; b=Miv5powvrt7qNaDj
 X2sBeSbYPJn+iMh+58QyzQ1vY233c7k6+V3Ms4sv0tm/c0X41EySkqespaxRxse5
 HmY4SanjWwaERwZAP6sWdFtZ72AcWYHJUxIlBGOuBFCSajZ28hFceKUBRDo1Ut+1
 C9TFeToxNmR0tBlDnZVmKr+fMhSG8ZeOHx4NxhP7WSQWumGh036+JLSyuQ3YYf7W
 1qgpPYtfnJW2lY6ht7tdxrFGajeMmPWi5gGpb3LKDW4j+Vp0tWKPi/uoFt5nTqYV
 Ao+CZ+Zz/RrTbQsZYfDfIbRTWqt6spYBcwUHCsky5hJFHjvg+csWV0qPX9rorNBD
 zLGSJA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgxgv09-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:39:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52cd0374265so5182091cf.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693944; x=1788298744; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wvGvmK63YO3s3h6jtGvoLr52Ed8ksoOuomw/54SuxKc=;
 b=V4ezKUZ4dJH4Nn/ZhbrulNMT8ieSF1rYOd1vNUGRM5auCG0xfainjHJKxyoL6MiV/D
 J91Qh8q/TvDfJNlQ1PBh/GvIQ4yfcSI9cDBTanNd+A5we/YY5cekaGfpsBLS1kNWeB7X
 rmZDZ1SIdfe7rIA3MTzm8e2CKI+K8dshQ3XE00D7FqlwQdhnvpsgcHLgigH8ifqYLI7M
 PAnEGUFc08h2YuMbMKCf29P74PNFaOeTlxKBvH0cMBksJhB68D2mh1s6O7DWB5tlccpb
 XfunB56i+aTRRtn2Y3zqFLUn+jH2nNepBOCrK8rskhwROpCinGJtH2bqzxgiFc4v8JKM
 aFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693944; x=1788298744;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wvGvmK63YO3s3h6jtGvoLr52Ed8ksoOuomw/54SuxKc=;
 b=WbB1QXdgfmdN0dgxi4uy5cVKgd78NyeazpSGjqdAExg1nuWnitKuE5j7/6eyONxbb4
 tObqR2KzcphJlAYDFaVQY36pgtQqAqzHemMKD7RHZ07Gy0J3uzuKbuWAQR+a+1LkoewI
 ZLFfq/LeJ3BW77YoKrH8a6S4+JVRRJ20ZRiItkCJpR1FTd8UrA9avLeR7qPQkSx0q1kB
 8HWAs/iz27BSIKQs4939xjAbuBUMmBPWQpSDIYtsI7cjXAjpwKTPU7mW4jLWLt2A6ULJ
 8j4RmF8xq0XzBvXM1Rgr9N1esJSRRvqZq88eX2oxsY/KcRHan/XY53fNsuNeQG2GGtsA
 W6/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDEo6oRUJD7HJN2FExscsaLfi+whhDmtkQ0J1IZoFX8M7XBYJ57iWLnB3cqkO+PK5ZD5G39wCUkxMO@nongnu.org
X-Gm-Message-State: AFuF++luPkUWIGuP61S1y6WC8XE1nWIb2Fbgd66dkbHeW6VoJqRrQ1lu
 Gc1Z8EAGkxkYna5HQS4mxNDISTZXZMnh6AlhId76P1LjiimjRR78s/SJwkuKBfPgoSCIzotiVjt
 tBUnJVsN7/jYw0/MVEIE/1I8x2OPjmi/59nI5dC7rbqiDHD62baBan5JrHA==
X-Gm-Gg: AR+sD13trTJMo5dXXIMq5MTuMX3D/ICMlgipPE0eRx/8RpkFLkGvKzrPr4/24vTDCcR
 KwjmdgXXcnGW5pbb7seu6tKIiSbU7yflw7Mtxa44ewb6vO3Nb/bswaciVxBy+E7vT5cXotgmlhn
 p8QxTSMSW0cOn2qSIZruy8cx0psnRJF1p+id/T3qPT5vO6aHjBEYm5H5F7wuXwMmwzTpxWcvzHZ
 ShEuNk+7mDgwWUyMNNNGfA941eUWSv5X8y6QAOw5oN3Y6N1JqWYMNzVzFFAsCp0snBNG/7o7iYh
 2hGDZBQauXYdrKRYohhWpKwt7p/+iD/BB5DoC6Jntmvvq592hzAUEuOExvAPPjmqrEGK7xQdPil
 WjFfCp8qaCzf+kzJ7xmUi9EMZk0VSch0pjQjnILz3ksC8LjARhsQ=
X-Received: by 2002:ac8:6f08:0:b0:51c:16b3:351a with SMTP id
 d75a77b69052e-52e422d9df5mr23267981cf.1.1787693944475; 
 Tue, 25 Aug 2026 14:39:04 -0700 (PDT)
X-Received: by 2002:ac8:6f08:0:b0:51c:16b3:351a with SMTP id
 d75a77b69052e-52e422d9df5mr23267501cf.1.1787693944076; 
 Tue, 25 Aug 2026 14:39:04 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8b84esm5544555e9.1.2026.08.25.14.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:39:02 -0700 (PDT)
Message-ID: <f035b8bf-72ec-405b-93ba-e8d94200e53e@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 23:39:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] target/arm: Rename and adjust
 aarch32_max_v8_tcg_initfn
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260825213000.221822-1-richard.henderson@linaro.org>
 <20260825213000.221822-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260825213000.221822-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MqZiLWae c=1 sm=1 tr=0 ts=6a8e0b79 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=jDE5IcpPZucr9eBqKOQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: JfFOidTabkNbXvmtZFQOpbc8YiSSY-Uw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NCBTYWx0ZWRfX/qjo0CsccpXS
 xpdSoptbXHWVtIrHJjQX2WkfN58HgRt20I2fMgLQhnqbOKfNuQU6SbftZ7AZh4HOLrkdVyroEJF
 Pafjv4BGQpFgVIDqoQKtg2rIGzpXrmGGgs5A0VAAw0H5VKgc1X6MSOpfxV0KbWWrekllJNjdcm7
 LUkPAOTeuY/j9cs1DZUCEleQtokFLsPVaduDS49/CGp2jTurQXEaAJX1xOrJeqxwOpF+ow9na09
 YX9vh8ntNF19lejAyglwJv0PHnzI3ZtoOSPFiOUYWuAf8LftFFGUFaAjiLCNR/w3337Da/vaFxN
 R4CNbSr8XngAr353kt0mRUQueLXZSXYJQLNxQ31jyTMnhNswj1zJ3dsd7SbfqA+CLZ2K/wn736K
 OEcQX+hpoDsSXIYhXJxmhr4X5UWZUqYzLQHT7aqpi6wodBdPRNFaoeryhkl+p6FmFzTh/bbslDR
 ZbsYVKV3aBdHJ9Kc45Q==
X-Proofpoint-GUID: JfFOidTabkNbXvmtZFQOpbc8YiSSY-Uw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NCBTYWx0ZWRfX4Hzm/4QYy+PK
 6aNp7zQoxrpHjQi1D5XtmUdPfpZ8guxjLaCa6J25n69YNHlrbcS8NAfnItCyLfiw6/HmxuxlHPq
 Rj037SlpXcnOCEVx/pGGBu85apIIU6o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250184
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

On 25/8/26 23:29, Richard Henderson wrote:
> Rename from aarch32_max_tcg_init and take an Object pointer,
> in preparation from being used with TypeInit.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h | 2 +-
>   target/arm/cpu-max.c   | 2 +-
>   target/arm/tcg/cpu32.c | 4 +++-
>   3 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

