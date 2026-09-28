Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FA9C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB87V-0001vE-JI; Mon, 28 Sep 2026 05:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB87U-0001uy-Mj
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:58:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB87T-0000E3-5Y
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:58:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M7M91195696
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0C1hvPgnHaK0vOkNZoHIvpajWW5sOQmE3a4z4QIYpJs=; b=ADYM3Ki43JDewTKx
 S+M0MdMiInlUfzOmiuC5upOHs3WyLJ+S+k6W3d82amZSBV7BsDSiWuyVNK0QOpug
 MfAv7m2BXzeG3oHoP9Ex4+ojWoIg/mObyxQEKauUCjVwiKWExEEBPYBHZ/hG3BFd
 dVRrKW736lXdVsE3wKGjbUcM7DVoX7QVHkJWoF3lPosBgWdyhgc74UkXeAMeifL1
 DironYnGvg7hTTC1rKHCRewKYDNS1iqcqVXxGnqWYQi24YlnaJWMY9YSMzW921aY
 4/qAbNYOZfMe3sVad+H6Xzn4PpFkNqBMC/IYlJu32tMD+sdM1VlZEMYRoTJzcnzq
 U7cG4g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s10e3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:57:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91454ecbd2fso37115306d6.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589476; x=1791194276; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0C1hvPgnHaK0vOkNZoHIvpajWW5sOQmE3a4z4QIYpJs=;
 b=AhsHUhfzff5KU+bKp2tGU1vDlnzDEb92rR1dqNGIpXxqty6IRLvsSO1UDyCUN/2oIr
 Lo0G2V1FGGQdMUl+7L7ygjEZA5+Ek0xvfK9KT9SA87bgCtLa2Q54sxoWI57zfd7Nsdew
 mNHEIDauz5J/SaXE7y7i4SkyS0kdjjDymFGFeQ+327cqYvgK3kIS9G7kkNcnTpPgQ44n
 EaH0hs1nSUo5kur8zi9HRMNS35RzZOM4GmFUSazzrQncqCQpm33mo7OnNNIqoWMUlaA6
 hQd/VVRcEMonI2pIpHKZVJ0Z6z3gTlAU+WZndWjeZ7Frj34RjdIFYuNwVVxSeoEKp7Xh
 LuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589476; x=1791194276;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0C1hvPgnHaK0vOkNZoHIvpajWW5sOQmE3a4z4QIYpJs=;
 b=AMMJVe7HOyocBJtlGDLQB25avUgs2E9ZnP6dcuEnwVgJR1OMGkXsxslNsBJPhu1YTF
 Sd3Xv3R8ef05tdHiaRDtUEN0hYXtNgHc638viuR7jVS/K0seDM8t7WkiwWa7azOSFTft
 mRWJmQ/0oQjzACDnADx5XeyzSaTQMn+PJ0X1IsfNZM3i1WgbDe4IbwcfoCne5vZArQAE
 fObTPgX1S6Yf6GPF5pUSg/uFgt2mLGakJq68sd1Iql88aHpBlyrPrTYkvbZ8sJtFpW6Z
 SWZwfwf1VuyxfWkWnnwPn9saHRC4nKx2W8mrr6g0SFvKVUWkBniedo92UwvejDY9V374
 ke8w==
X-Forwarded-Encrypted: i=1;
 AKwUvByFA1wUOw4ky/A+BjCuwlsmkhthHiDOGEKoEf1UhhkhOFpCnFuMjkYznSKSd+kRGeF2WhAh2tc4zxVC@nongnu.org
X-Gm-Message-State: AFuF++kzxSLzq1kIbiTvFh4EGOo2DaqxMwBJCbZF/79vk7YAJDmDmVMH
 kcN66SWWvirPqAMrQJFyDpxMgr3u0eq20Gfw/0XAObbFNSyxP7NP4OHYXOC7kWSdrtkGQpg553y
 p3ANN3sqPd5Pecq8wf/2ygyxZ7ZshZsLO/JiIfh/rSh1zNtAs9agjm3SOQA==
X-Gm-Gg: AYBFou1JSpt0AGd1WQVY5iX+aakufzN5gHCY8F/ioan/ArC0Ka569lQmiaWV95hGzzw
 3/nFy47xR7W/73875ohGi7ymhgvUh8ZW3fHU2TDhsUYxeeqHW2ffm8ll7hgENJ7uGXCFNNwFCju
 uK0j6fFf3zfYclLjXBWydfwMGS4CrzIDXhpdzhus0kH8fKfgeBFl/pljDA2uh+4rdUcTIP11SGy
 MRU3+BvYtRUD0Fx5v2/m7inbXCmVVmSlVisFMRlmwy03+ARf8kdpiPFbn3n20SKxrScmakbPnt3
 K85EBj4BPJiilccscD+fyM09XXd8scMnDHNbY/p5qwEg9EcAZDJkimpjGR1jw6tp9+gHDtqEy0B
 NHUBKs6PAtZLrgKiUXix4ZnUZEPG+t3LpvA==
X-Received: by 2002:a05:620a:2b97:b0:934:946d:599d with SMTP id
 af79cd13be357-93c43e0e559mr1944852785a.33.1790589476272; 
 Mon, 28 Sep 2026 02:57:56 -0700 (PDT)
X-Received: by 2002:a05:620a:2b97:b0:934:946d:599d with SMTP id
 af79cd13be357-93c43e0e559mr1944849685a.33.1790589475822; 
 Mon, 28 Sep 2026 02:57:55 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35607bsm24149710f8f.16.2026.09.28.02.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:57:55 -0700 (PDT)
Message-ID: <418dc0c5-a2a6-4b03-8a39-68c1c606a3eb@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 089/101] tcg: Generic expansion of tcg_gen_ld8s_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-90-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-90-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXyEgJHBvok4ct
 Gtd14pjRzOFqRzX0jDk+RJ3Ob7xDcAy0NCnbxHg6cgP4ZzivquM7vkCVdHL1QkPAGgHkO2l3gGq
 p5bJDhjv0SECLwlHxyYfpl4nhTi540CeeQxeiNX0tUzJwjVqGROwxqDtDPHc85t/sVu3zYDW1Of
 8dV6x7igvBmMgrnMpUqenWKBBc+8I/SNLhh6tSgBBRo1RdCW+N5kIWhkD/jZhHp8LX2SLYB6a5Z
 +6wnkorK8Rc4N9+xU5Ud82pL6D49qFHRPonGbGaic0PtxlMtlocMkkf+c+6A/MsVJcjyNTH/Dzl
 qdckAmzYsoiywCCvEUw1QiRtWlK5na+tztxa4s8BWa7DarYpQwZtbFAe6nBdRkZj51a1P6/Pokl
 YhjilHNQ2aVLKTMZ22ALe2lwUJPqiBkklMtlitAwORRvXs4Uq3SaCZAj8FtuOLxlCDifJX2/GiV
 7PeglfjUd2IYdrIdWdg==
X-Proofpoint-ORIG-GUID: xcX05M3DYD8skY2xOWHAMEo5ThadvsF0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX/sv5GtmR/6Mc
 1lECCQI1Nb21HrXPJ/C87Ax2f2+MJr0ZBvEVAm8RGZhp6tRBNmd+mWHHFquS7HCSeRbTPFrjQEn
 9EH0ozbvweYM09i+eeB/fhyyIQocOwg=
X-Proofpoint-GUID: xcX05M3DYD8skY2xOWHAMEo5ThadvsF0
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba3a25 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280039
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
>   tcg/tcg-op.c                 | 16 ++++++----------
>   3 files changed, 7 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

