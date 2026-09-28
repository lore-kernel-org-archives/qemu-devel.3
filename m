Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D777CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDWA-0006Ys-V3; Mon, 28 Sep 2026 11:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDW7-0006Yk-QG
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:43:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDW5-0004wi-V6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:43:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEdu5J1016602
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 15:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tdWhm7MS+ZxA+2zZeCgur6ae09tQeHazdvbzg6J5Fio=; b=ZhnWKpeW7uJGhaZy
 FjfazaIRy6Gdp9TVr1fwHWWMltuF5fHF5N2RQVs5nQoG9e0EcjC+7VbiwfyRAfdl
 XUTcatfv+Vm53c3AVTb6H2R4qdNFLTbm4Zl2X+4Waw5XiRbHvYE23d4BKRc9jvCZ
 QQPyv4BXXN5Tez3xkXC6zyCxON+ApMLh2TuneDyJJgHKa9uTUcubP/QwHSn9lszn
 cFPBTd+xsVmp8n3K3kn+sl7CYV+u+G0TuL31MoWZ+QGXW5sVhYAqBXSTFLUKi+bK
 Qh2WUEW+zqRIxdDfdV71qLrK/02qg2Ikr2QxySTKag/fPyqqWKHguXfJtw4nWBaz
 52gbDA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq2wtw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 15:43:44 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9832d9be02fso1268173241.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790610223; x=1791215023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tdWhm7MS+ZxA+2zZeCgur6ae09tQeHazdvbzg6J5Fio=;
 b=EaD7nj26AdehAD1S5wcEvJf0dUCZYjFe+ki5lYAdIwzm4FfrFdDfcMg0bHn8VEyLPw
 BZhmvXqE+I74/1TCFoh87wQsWQrUIoKHNjkHMP7iCr61OPnBKSSi7TvVu1kdf/tj2rnt
 wZYGUkYMfq4JFPSKYcTWsJcbVHi06o8rHaVnI7ToQuivC2vXfZxiAjcA+EgLBiERj7n+
 FO5yj+l3awErDbalVpa7gymZzNL3vvg/J0U5oRrEG7XgVo6xZhtxYsylrtBbaxzOXUHc
 eNr7dm3lKIboTHhM3O94nkcm3H5Oj9jPN0ATx56aO/SHqzBu7E9hD1OZi5kvd+7ShLxo
 /e+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610223; x=1791215023;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tdWhm7MS+ZxA+2zZeCgur6ae09tQeHazdvbzg6J5Fio=;
 b=c/Lmoxzhtzu/5ujUdDE+46wt4sZTs6J2EEFYPGgGs6QeK9g2alqoF1Ji5sLpi/ViB2
 85/T0H0r+FW2feYyKJFtJdlgDJpJ17VhraBTmsalCovAghD8+PugwAWlT1qq/5NSnP3L
 9nNmOAcSy6zKN6lTF/VTkUww36UJXNX+flCpnneojJum156H2NRQ1e3bv2u/xqCfuc53
 NtRNTE3sE/Z5ykZXFSxfClZ3AItshfC32Szy9erWcFxQSauX3DTSzfqHvmaMNfyj/66m
 NYd8fjc1FjuP/E72OZlHroGluwh8CM++kHg2NFAbGnDT3xWeblGMc1ffDiwV4Gyr0s4R
 gq8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz58K3hkrWQKbZLx/d6TSaZWTKeWyq7DRzsKcHjs9wuW03e0+D2y1k/X9209RHGSRGT++EqV0ncc1Ax@nongnu.org
X-Gm-Message-State: AFq9FYI8R8fBkJvkOwCgO4huUWC4wy468c7Z1ov9DqzxFTOvY+Ix0TRT
 h320tIAuODiEDkmaBZpSmFe4GuWqOGNU/tDOGMiByYXszURgxiffBEQYFzUAc/54YAIzu7T5ybn
 5am4u/E6Zau+UDy1mJEU47Nhg1AiNLWrOLcWgTlANWfi/t9SwrBfVanf9jw==
X-Gm-Gg: AYBFou3ddhXSa02BtiWy0K3zlcnGJCQkbquoKAl3AqGQXSgXG/m84CT+gmHfk6SENsx
 jn7FPvlQ4pV/NeI94P22a9v6sTRl9vqNUg6D8842Q9EJvRvXPtwSjO9TNGdUlMcHcOj3qJQ+yaX
 NIY2mwhHG7NyutoMES8wRVmg2XCzri77WuNnxIg1CEFcOCjqUu/1c1cy16mPnfUkRJjfyT76vEa
 ftnnhKi/aJhnvQu2NCmn8HrkTaWBwybIxERLldVYkXqnVtvHlSg1QHI3QteNXsdC4OdP3Y332DR
 KfKMgXO//a/dFP5/Nc3vwxB47HAfbbNoA3dI7IfF9J97Om9pc9925OB9pvY4ox1FCjHESNp8yY5
 z23XDir1Jy1h9pCmaRgUfl2zb9xLGEAkFiw==
X-Received: by 2002:a05:6102:e12:b0:7a1:f7d2:e81f with SMTP id
 ada2fe7eead31-7af1e6eddf8mr4914034137.24.1790610222988; 
 Mon, 28 Sep 2026 08:43:42 -0700 (PDT)
X-Received: by 2002:a05:6102:e12:b0:7a1:f7d2:e81f with SMTP id
 ada2fe7eead31-7af1e6eddf8mr4914021137.24.1790610222505; 
 Mon, 28 Sep 2026 08:43:42 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00d0e9f9bsm27635e9.10.2026.09.28.08.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 08:43:41 -0700 (PDT)
Message-ID: <a3e09c33-c9b6-4b30-a1ec-de61fa2c20d8@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 17:43:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 034/101] tcg: Generic expansion of tcg_gen_div_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-35-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kFTWxjQDadMzH7RR_KduZf3gYwMelXTi
X-Proofpoint-GUID: kFTWxjQDadMzH7RR_KduZf3gYwMelXTi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfXwJK1nEuegA0f
 Wy0sSzTW/AzCrVvidGHBdgKncojqWFHi3XU+DMj+EtC2zvBDsaKQF0MN3Ayh9G0EIYzN8zzCTiy
 /sAVKLUYRCdRArLFiNNmHpjpv4WCRlk=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba8b30 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfXzBGxIUlsycEq
 4AutHpA8pdNQWkNr/zrF9ITKa/CRFZObI6jNE3yPQR/BymuX17awUIRLJ2H85GGx2F5RCXg2jHI
 z9F3zVOJa6q97gctA1fgSCfmZaO2Y6qEmqyGZDCjREOXfxiVXAFWk7y+bwG1FaHJWn0LokUATmO
 NeyxW9dcL0UhnFYaKBcxHu5GVzvBj/KLjIcMnQ/+3bzcENjRQQpWom9hSbqDIh7++5Iu/Wu9lAU
 ZXILPGVBD/RXkU2wRI9ujU+ndWIoNVvaGqve3o2Zgm/374DyVG5/OpSBfCRvivlf6VRfz3tTkxk
 2sE8Jt/jonJayn7nKobjHTQSW1+uksJ76zCrPB/K/u+qvpkX0tayuTJ/GUpF7ChFcHB5YWd9rwd
 awbMV40moyVErkndccU7hPjUvrUhvUqEIkI7NkD3Rw+2JDYXCkJqc9wqs50qvyWSAG5sSDF1CnK
 39CcYF7sMOl6xDQr08Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280062
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
>   tcg/tcg-internal.h           |  8 +++++++
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 43 +++++++++++++-----------------------
>   4 files changed, 24 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

