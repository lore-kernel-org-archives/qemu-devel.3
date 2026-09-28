Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54910C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7nc-0001Ao-HS; Mon, 28 Sep 2026 05:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7nZ-0001AM-SX
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:37:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7nY-0006jW-3u
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:37:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M8g92057279
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bjuz807DvKpMrnQal5FHeW7iEQoYbooNYZ3Q6w06XHM=; b=fB7AkCtTTdd9Er6q
 pc4MLDL5hT/2v2R7vFSI9YZs9ZW05wVmIQrJasXvrGw4ZgnehwvpB6/x51zqZh75
 1I3DJLqhe+SdWiJ0pTKK0J+h2rNJO0HHS27bDUHU4PQhiEW5q8PJ40AT7AhFYWZD
 ckU00bBYZLeR5zcEg0WYf/jWlCeVhb40ZQ/VXtDAKPZbKO6ma2mXBT5FZfmvDIZr
 UGO/zM0qugMgZMe6SpxiUjk3ocugKTvKYOg/z9LP0dcinHvAfYQcKaqoGgRGNmMc
 j39I1Z2IOMSOlcvrFbNujGZnrb46NaTeaXNCeJe4Pelg4eSpsay2BgOAG96V0yM6
 5XBXeQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubgww9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:37:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-530e5b709b1so67940761cf.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790588242; x=1791193042; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bjuz807DvKpMrnQal5FHeW7iEQoYbooNYZ3Q6w06XHM=;
 b=DidCZvdnZTLSM/4jSymArv55PtNWrW3NOYjRQDI1Ln/qz7K5nbJi9h0oaWQsok8wil
 92yPAXCfYWoL0NhrLQF552UuGHzP/QnT11BYcRwCx1JDs0yrZdc9jbo2H3OEXgowMqSN
 hQFGwhNvjrGk+BH53E9482JXOw1EwO5u3fJ/+W8O+sDybvHKYOuDcyNSKcCvtenLKtcM
 4NLKGNVYyuFqQCoFcY4UVffmlld0IAe+ijZRxH4z4TP0OGqgL5IVA+CkujzE/Hp5prCJ
 yq231R8wEYr3IeSWLsdWzWccIlH2oC7TrPRDty00k1QH4c00TPj2uzM4mmIBR0DQ01Sr
 IkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790588242; x=1791193042;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bjuz807DvKpMrnQal5FHeW7iEQoYbooNYZ3Q6w06XHM=;
 b=uBB1i7cQuAn2wS2TP0ovPV+V1q0GkaaqJnr/GL7uQiU1TTYam4RiW68s8xdWIkwDu4
 f8jeRSqrYfEOY+Oy8ayE4E1ot5+9c1joXcAEUTZKJsjCDcXne6gyhm/85Htx1j84qj7Y
 aaIV7DnyBrtG2EapBlCak2BsPyJkL1gY+EiHVeCqzKK69D/5t5pTFvW41LndRFS5DNAh
 HP6Ob3C1EWw9i23QpYRiFr3QsAJ+74qo3SXIjsQTn9BhhaeWuN/AlA27Wh/ypOkzpV0h
 KJmIPg7J7+BG0DiIw8Zt4l5STGuAdve/qr7U/3CfYP+pv5II8FWpuWApUtYNkNc99Qqr
 ZSGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzS7LfWfy1xzQuu0/9Ww7CtQmGFYx+Jkn+j/sQLL9I7rNwDlh5dNsuo7dOD/xkvEpaLjCODLUoX8fg5@nongnu.org
X-Gm-Message-State: AFuF++kXn72XgrCYPr/f22101mXAZeVirzY0VFktxiP5jKfkkupktJWg
 mVCvsiACQX1Qnb7BcWGoPU5fXZBplrcq3qdmTl6xvEcTn2ffdnHemV7KBX/ziFCUT1IUFpGl+Ek
 bflz474KbVHg7yJs5YRlAYiDTG8bo9BLyejrGN96MWZfry0PcSLk1AbDqMA==
X-Gm-Gg: AYBFou0JVE/j+ARVnu58aSO+U+Zyf21UGUA4K7n6gddjxvRNiMCwjr3MRgTOywdj3Fs
 M3PNcAWCadu9LO5QXJdGUF6ePtCXgw6/ChHDoAg1kdBAa44aYkm1InQZjxmw78Z67azEUBZguiG
 MzlEwQShccHVWRCIy5XPG0MW1QyWi70mVASMRoSPT5I2HeH7RxaJvIlju1xRdyJEK+PlE556k5L
 f0bJEwbKCUOFa8Z3DIL8BvOfegvNJZFaKojebkZzSwgLuIb+/fszCnuz9m4zLsXCOeicDhZcs+h
 zJDz1OlrV1vB+aafrfrDwwjB1rX1OAskGqTNxIpo0+rZwged7yYZ1Ka9uNYkNrlH4oVEqRXHhX3
 G9IB9IEbIrev9nETcyROuW5SH/VIn52tlfw==
X-Received: by 2002:a05:620a:19a0:b0:939:3885:3131 with SMTP id
 af79cd13be357-93c43b82c04mr1983076885a.3.1790588241654; 
 Mon, 28 Sep 2026 02:37:21 -0700 (PDT)
X-Received: by 2002:a05:620a:19a0:b0:939:3885:3131 with SMTP id
 af79cd13be357-93c43b82c04mr1983073685a.3.1790588241140; 
 Mon, 28 Sep 2026 02:37:21 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a36189bsm25374540f8f.21.2026.09.28.02.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:37:20 -0700 (PDT)
Message-ID: <04b6070e-568a-4592-975d-778227e75f96@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] target/arm: Clear PSTATE.UINJ when taking
 exceptions
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
 <20260925215004.456336-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260925215004.456336-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XF4_H5xHXYMSJYWU5El0PVenI31Oaj8L
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba3552 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: XF4_H5xHXYMSJYWU5El0PVenI31Oaj8L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX5OATFNrwooj3
 KBFdy91NyoMm+BRa+7ZI4sPlnLq99AkYE84PfmoaZ/HaKliTQyw/5QbXH8aL41ksZDm37x3/xa0
 yBEYhrTEimM8E3pfEulkOYfMO+yU4lu0+7J143kW3HBKFS2dL+/rX29E9Kq556wlhDFuS88wmdQ
 +xG+xYb0dO4UKw8BxFxNIW5xm1vkDynzK7qLDCuXtqVTVpr0+fynfgl+NhsJZj7aIotomzrZGuo
 P9RVs/KNgvbUBw+JN9J0AcCsawy9hszcyg5Buy4k/M0lza8pB8mgZZIg3pOViCevu+kVDzGOAu3
 tfRxOwy/23ri0fH5HwNXrfmyodRfsm3LGOw1kTCmJkBtNJpS7ilS5LA0hniFpg9fosAr7luQUaH
 MTqyhGSymwiDZBzZKmT0H2/ZzkDzmlUZ1s5nlnQ0ClapKCYWJy+nC0iVXciEuECnmDPaZ2rGDBZ
 zO4vGsYLOGmPYeNbqEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX1wnCEsq4ZDFR
 yHHRdP4pjdKWpHsbdnxce9ETieZhP1Tz2S8ueS6QiR5mXv76HtBKLmEjoMiEj5bqfxcGgXwnq5p
 pgELB9sviuHqArHjCbTUIjFxFUmAViE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280038
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

On 25/9/26 23:49, Richard Henderson wrote:
> Clear UINJ when taking an exception.
> Clear UINJ when exception return is invalid.
> 
> In both cases, perform the clear without feature check,
> since the bit is otherwise RES0.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h            | 1 +
>   target/arm/helper.c         | 9 +++++++++
>   target/arm/tcg/helper-a64.c | 2 ++
>   3 files changed, 12 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

