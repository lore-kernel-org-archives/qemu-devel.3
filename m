Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481C6CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB820-0006ed-3A; Mon, 28 Sep 2026 05:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB81t-0006XY-Bc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:52:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB81q-000852-8r
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:52:12 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9Mp7P3879819
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kbqGKE7IymnKy3AGPJcXaahz7cXKiHNmsPTM/HEX/Ug=; b=QVTlgDaZIDhP0Efj
 nkeURz6wbDgvDTwzseJSbeF+R5aW1atRrz6P9/1YAdZmTr5L00m4AS5u7juN4rSx
 5ZSKBEJOJur/vjWKjG/HmlMlTALX3IWeqTQLqtqNIRZ5g4VerTcwi8u5o9ds+WrU
 RMiwl47ZouUQ+V8hvxytYoZFbtJwJxCwlc6NoUna65kSg2hmTggFh1vYM+9AjcWu
 HSyx7TxIz9aj785Ed/wUZkBc9vN7Jjasp5QZmn4vPgsGJTZ2ZunGy/W/8QZohSwk
 mVmdOuhcBeITusCzBotWtEH8e8dZfrqERD66v6UkMQaWGKN79yaTe3FT2MKTxZJg
 Q+GDjg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jwex8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:52:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so62129091cf.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589127; x=1791193927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kbqGKE7IymnKy3AGPJcXaahz7cXKiHNmsPTM/HEX/Ug=;
 b=OobrW5qb30xfdYlTNX3FL6vcotkr0PBIplsK+5+tETFUBQUq1PBzosDyUszzxceCuz
 MUZx+EewdPh2BYW7nyQO9lPfAvGyEpUChL2Wq4tlqV0R1bNLGABHiQUxt7E+K5FaKN7v
 rZ0+n/PbViohUPIKpFv2PzWm9XJrt7Hks+mRZKLhPU6BEYEhyAX8ZsjMbVq02mWFASiL
 APkSkjyGbhIsZ/YO4W4Kq0qT26xscyabig0u/ve/AQwqFZLhasZhXNJ6JP3uaGJxGo33
 i7KfCtn7ZSNjoAzeF9jZ4ZWhqB3Qdswx4d5tCKauu+zNeM9GOKd0iLXBKZvIpAe4SSYQ
 WVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589127; x=1791193927;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kbqGKE7IymnKy3AGPJcXaahz7cXKiHNmsPTM/HEX/Ug=;
 b=kCGU42haLpChWmczR16t3WEL3zseg2A1wBGURSHlE3WEo41BFmrxFDILfkL9Ep02B5
 xv5j0xCJpnJkhcylwxbvQcTYwKmEwliVHIezVPIkUosRgkXCqcnPUR2TeZfEkkULI+JR
 wNRGwoJG0LQ/NLxTt6od1po9HLRSkOKNporESNCI3TTYezR+9HlkcOG51d8tr87f2+SS
 c3Ffjcf/0fsomljZMzfKOTcMzp/Fe/xQzj2v/FAPl5IgqzaaW0p86YbFGeElqWun793V
 +D7gZQxaKKpulTWAvNngAXRU+0CjXd2VQpHhAcpkOFTX2ODv5P3ZrPh80nY0ue/9601n
 VtFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyRe+1pv8K23OpW3mcViTSawvOOYFFpYmJcvE+8OcYBOX6SyAmlkdmvYPO6NX+2kDK/BYAEwukXh/k@nongnu.org
X-Gm-Message-State: AFuF++my+OQAX0oHLFHcqRhXyhk1ehWaglwI2hdrisVnHOpBmVFlNChx
 /K/C+F0Z/dUtVgiYwwkO/m0cks/NNhsvrTtzOuXhk1u2p56zTiVdbVWc5uPwW4z0CX5xAOonSiO
 K6KOje4b0+Jjow0iR2PlGFLTuIRDG7v/5oRB209aSAiWInkozMH+RIvY2hQ==
X-Gm-Gg: AYBFou2Fvwsl+NjDL8fwjR0H8hiaGKEHeTFLjuTzFhAVPeMpAXhYUYUWEvngoyAC2PK
 bD3NfqMumGEly8Vp7BlkFLYd/nUDmVI2jIRP/4lLPxUTLy2Gio9yudpvlSzydK/AN5ONnDoZ3NX
 03p8QP9pozk4KpI0JbkHiEVBSWAkOd7AV5bNhprMbdADf1y/uIaV1xQLRVHccjCEJ2Pj3cqLfFP
 vUF4BbQrGxrsR3Y7f0HTTPX+zuHR5TGtQCLWN0gMavLZBv8Y+geDjZoQHpcsZDUGPxqB9bhfdwH
 nu6MeCpCqJfwpII7PNknKeU3yZOwv+5joIDoLYXTG7v6RMxDoRUaZ6yR/tF3TLm9hRWgaaD0MnY
 U4q7RruoUCCcFa1dFtAGGEFZQvQa1+/EWZQ==
X-Received: by 2002:a05:620a:d96:b0:93c:3250:84f with SMTP id
 af79cd13be357-93c43d151b0mr1967191185a.45.1790589127605; 
 Mon, 28 Sep 2026 02:52:07 -0700 (PDT)
X-Received: by 2002:a05:620a:d96:b0:93c:3250:84f with SMTP id
 af79cd13be357-93c43d151b0mr1967189685a.45.1790589127176; 
 Mon, 28 Sep 2026 02:52:07 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30bcc4sm27329931f8f.1.2026.09.28.02.52.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:52:06 -0700 (PDT)
Message-ID: <6a11505a-de78-423b-a20b-017c7135e6e4@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:52:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 041/101] tcg: Generic expansion of tcg_gen_nor_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-42-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-42-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX3rVyNdq3tb1l
 nitMocoC0P1cr7It+TCRQO0oN9Bylu1DqXeviQnJ4pvCfgIXELV7cVLqmyXuOg9Gq+ZEoSW23cK
 W1jfGalNBwtUvcVyqeU/YL/m45iH20k=
X-Proofpoint-GUID: rQxb5vfg0Y0oNoETVc3TZWBApB9oWubx
X-Proofpoint-ORIG-GUID: rQxb5vfg0Y0oNoETVc3TZWBApB9oWubx
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6aba38c8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX2XiwvQenIFQT
 qC1Voz1enLrkl7YNNaA8WxBmG3IYF7i6EtrJ8AX1yJ5/kl1zD8iqSFwhNPZ+pZ88e1AZV3C5oBu
 xhmLCQFxCV2h6O2cwTMIU3e1L/YtSoEemAuLOsMNhNEP0GlrcRel/A1WHONc/W1LnuCwu3YJf7K
 as16wyjfwMY5KBFyrPyGtHvzA/UnYIPl7FV6iDIfcCAGR1jlvA/SrqV2fhj9z6FDcnQ7J5xR91p
 tnFb7zQNPoez/7LUIkjCZaNHuF/OQ0iGyUfGklueM4n7APwxHT0mW2Qc4bDtO3/qLH87hTRxIaC
 MJ+PQD+MsJz/oMuL3QqeTpsdI8C8p9V2QIEOx6T2AT4OdoFG/skN/y8us9HSAG4hf6vbFeYca46
 MXMAqZsmecFCXh2ooI7z51mGl2lM1yA/CIwDz2BR/VoUTCwiT9eeGj9aDlWl7XC5+N6KSIpRpp6
 wHksKsKKCTBHqUfR+mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280039
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 30 ++++++++++--------------------
>   3 files changed, 11 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

