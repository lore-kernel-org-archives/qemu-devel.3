Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363B5C5B570
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgOQ-0004xx-QO; Tue, 11 Aug 2026 02:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgOP-0004xj-Bp
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:55:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgON-0007uh-T5
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:55:21 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMptu62705359
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ANHPZQlrl2q9R2A4j64SZjvt/YBwz9H8QqYK9ADcdto=; b=Q+lZOe5sxU613prD
 KITMjVfohSzbNP6LKhsery+zE1vmVLZgRf2eUDmkSX+IKWt0rgnWmJqMiIf3uGZn
 wW/++YPfQCN/3WsUOtRVPnFJke7gSmmk4lJ4wMPWIcwU6pRDkMTYfYTT92CgUCNY
 KBhUiCzYF+jyX2g9oBV8QIITENOcXUkGzJavq3g82eQRKBFQqyJrVEgq3acSiOnW
 txazXDoJ1fgz5rRxF6mVgaqVfsYi45BNDXWAApkFr9N9xS/5H+HECxKrV1DlROtj
 ng8TiP9aS24Qm9+kOmoje7fohadxCG8H9jRrYt+Y0adxZqr0ElsddMADOUIsdvNQ
 9ZunLw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk62swr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:55:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d28f8737eso52752141cf.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786431294; x=1787036094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ANHPZQlrl2q9R2A4j64SZjvt/YBwz9H8QqYK9ADcdto=;
 b=LTHGCCznyCgA1R5DXu2YBBI/UHAJKi7V7HhAV6zU/0qPuXdHni62LuYaAZAJCgJMEJ
 h5+wbDYJsFt/31u5QUWS5DPDILp1bqrKQB68hSJv/RaVwOrDSI1Uky4f9oNdzbCRoNL3
 8ZCtEj1A+l2jdovzqm90xVooV75+BYleNF6DU/jBrJa9eItuREWcLiuCEo6zjkUf7LIl
 St/gkQqV30WDv5ubONxZ+MQrqftQ4FnALHNcJnG4n8vk/sGUu+jkNcWcF92y8sGAwtW+
 Zf5+sdEYSWaOzWJoqQbYrsDLOnbvsU9Ii7t0xSLtSmt/y87InKGSd5xM/iOM6NqFUWBH
 D36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786431294; x=1787036094;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ANHPZQlrl2q9R2A4j64SZjvt/YBwz9H8QqYK9ADcdto=;
 b=nIVpOQu/eQgRcfy+h68hNoHBuAG7CXU24/gzio3/piRVL0gjr8XH2I6XiHhzdZO6L9
 /tzxSwe0w8X8lULBG3CbaHpI+nwA5vW0KY4rrvOcxtAj5/TpieqA3IyJlTfFmpFgS3CK
 SBClwSlxiv4QuXwscMJA/6E6xKKa4tWyjtVpDNM3kFR2r+FJedJ41cEgAubBeQpg/bDK
 P3o1dhlO1UU42BNahyTom4O1VXJQZ2QJRNNnZyRetSi/wMdLNiXfvLC6LXoKP5Uk5a4N
 g9o3pw77WbYWPHkWGDOM8nK4Ns+fEA16EsTn6J99vue2td6uc/vKd0kosBx9ylEjmx8J
 ef2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDBK4FkUGajESxM7s7H+RVqLFlt5zr7h+yEcR90yFoDMj2LeMwUz1ye8iPxy39Fxo2ta7+vUXbvbmS@nongnu.org
X-Gm-Message-State: AOJu0YwEcheiTC0JD9lnNddtKzl+xn4kF3J+dibLXs+3ahjnsVSKBics
 eO1/1+10d18cSn/BwhmqqIVyZ/NGTCCCi9p/DdIJu8DEhomwVXfFLGokHq/h9et/zr0cS1jD7vL
 JSY+AL31DcxtO+1D7Mfg/x88TWhHpvkK/ojYHnLPijxm4O8/9+Vdzj6tfZg==
X-Gm-Gg: AR+sD13VCSm89jY0gW6vpsg6TJZ5GqLWyUV/51k8t6LZTRuHER9H3Xde74k06MIGE9E
 yEX/MW/FBZBaP2MUfflK0Tc0gjlgUt16uNl+4ziKWHMwwYpaa/+vVGLaSsNzHHiEUOcjWWuTVxe
 DKV5U2230wg8CefSIlF6INMxmRRjiMqiOz/vjs7NnMGuykqoXu6EinVDjd5hXoScEpNLaurqPCG
 3PMLJ9asSG36X2/xPV1eVm6Dwk2tnZnYZekJBDNXOIGCyLzWxto06ZjcHkKxKe8NxwnsQWjDCod
 LR18c4we/2XIyMJLV5B9/wQaLBr6HO3m71zVNkiqN9Q7K4Oo+AsEimL404VmCXvL9xNIlonRMGO
 FLBG5LzdpM+wtS+dTTe8SKeMZdZdqi/Wzzgj9iScV
X-Received: by 2002:ac8:5a55:0:b0:51c:1132:c7f7 with SMTP id
 d75a77b69052e-52d58647d66mr9400801cf.29.1786431294321; 
 Mon, 10 Aug 2026 23:54:54 -0700 (PDT)
X-Received: by 2002:ac8:5a55:0:b0:51c:1132:c7f7 with SMTP id
 d75a77b69052e-52d58647d66mr9400541cf.29.1786431293841; 
 Mon, 10 Aug 2026 23:54:53 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49978840189sm13759605e9.0.2026.08.10.23.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 23:54:53 -0700 (PDT)
Message-ID: <dc0ae3b5-7535-4d37-82a9-7eaf5b411b04@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 08:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] tests/tcg/loongarch64: Add bitrev smoke tests
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
 <20260811045605.1246543-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811045605.1246543-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Nb3WEWD4 c=1 sm=1 tr=0 ts=6a7ac756 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dUexN0EwOiA93GcR1BIrrY4Uxqq8gtwU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1NiBTYWx0ZWRfX8b+FQ4xzetGe
 D6iPwY4CAmNSFp6fqKstOo6Z2+oW1Qv8qT4vfNXIoljA50Jn2xVkt6TK+5C+gKN0w/sCLtpycMC
 AaMMI9OhpR1JurLKVLgPCgXFnvEk99Y=
X-Proofpoint-GUID: dUexN0EwOiA93GcR1BIrrY4Uxqq8gtwU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1NiBTYWx0ZWRfXyHCB2tDtbPVc
 5acpBLKK/CvMXlYyhHXiMGUD3MSyi5lM11wFvf3WsVxVo21uQCekZdRjtYLubpRz/ABQVeS5wXM
 MJf/+2Ps8O8gTXZwtiXZIAfk5dn14r27onNIL06nKqnU/ePRp9Zf3VHkTBYEAyJ4/ckiu2m8q8D
 tgN1S4BVrgQRMIubYOE0xX4+9HZhOKzjgXHA2lTu7m4JM6qpCYSxlPViTFsEetgndi+KV7qdPiX
 lpDZ1q/QRVChS8XhyCf/f+SugRuPel7/V/4C28jlKhvEZT10JjG6LwnYAXEkdZGQoP5yTsAxZkH
 r+4+JgigzAOP172jL4O+ASWPWFOPMjdloBp9RxTpXDeg+rNjD3hbFpQZyUukFU6dAN0q7N1bYLZ
 E5cwzltTzkUjghJ2veTBP0L0N/+acoTWyqKkjhm0Uboo+i1sNlOM0LQPdyiW9uKQTxpfLFndrFe
 +1vapMe1mqIsxQMWktQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110056
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

On 11/8/26 06:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/loongarch64/test_bit.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

