Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB67FCA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDsP-00068p-Mt; Mon, 28 Sep 2026 12:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDs3-00063k-UZ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:06:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDs2-0007IU-Cc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:06:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEdwkx2755837
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w90LfvElgBPT2cEzteufUWOoXsPYVw/2VH+PRSsqhls=; b=J6oXP4QIGHiTM0qS
 GShT8RNMPz86Dx+qfbx/IrxaWC8nQ/zO2YHR0jevynXTk62AwO4ePVXJzKeA9dWx
 X+bDNa5U9+0fdaFmXi+bKbKIh9+rfDcm2YyM+522rIz9Ta2UDDjqXEZkzYb5XCax
 3V8Ct0nxVMKLMatzkP+vanJ7JaeY+SRmCx608kWoLR5whD2gOUY5pPdY+TAbhGVw
 Kerx5g3tmEF8w9Od9fuaYU8/yRsgPMJ0VaVeTaqrpRB5ENzeuO/EOeEF4YEulw7o
 SOrm4w9HMRF2aZfT04e/mMC4hivFcxJvM84ZOifN/BPLcvSaaPDwfpmhG+s8M+Gm
 /39drQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubje9b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:06:24 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c9ebae1b10so631434e0c.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790611583; x=1791216383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w90LfvElgBPT2cEzteufUWOoXsPYVw/2VH+PRSsqhls=;
 b=i7MEI3E4jLFMqocw4VzKlLhxjnsnt8BVzc3IKlOcIfXsVXc8Br76dY+aE4ao1cfOVU
 okeveuIJPWuFP1KcvMSPwduOS+Qu/Oiw6YNajeVj+8WT7EMkMJDJKNgah7L/qn7lfdnb
 ILCCxnEARr4HwQP9RptTGX8gx1rWLoGLi181/ShlRf3JXeEMvtd/Gs/Vut377b5TiJ0J
 vhcfbMhz/cPxFJwMlBmJtb3gjaKSV/ZaUy9k0OznvjnOxZjLeMlyvborwqIgpIRJ9frU
 QMRJ8UeByi+B7OAFIrPsK4420ASlIVCupfenM2WmAO417N0iXzzbgJudoBq9biTNTRgB
 luiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790611583; x=1791216383;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w90LfvElgBPT2cEzteufUWOoXsPYVw/2VH+PRSsqhls=;
 b=DTXb1W/tGVIf7KaiZGxV0JnTfEGg8IQqW3+u2RoBbYwaNhnpfw6wlHuntmTWtblvxZ
 JTnRn2F7t1fFCtvilWW7lLkNjAZIMR1jym30dP72S6LB1mibSQgM0QQ3V80tcjGPtXty
 bQpbqbhBg4N69s9feZxK3lY8kKZDcRF2vfJp77AMl829GhVGbKWz4rg8GvxN2ElLkZ9j
 kNOMcybPvd8j7BZkNP9IY5HQYmv48SdqsnqTxYCn5pF6VA/4uKBiTka6EKqxRN8GTOYw
 4NpsHUaiYFV+RuUghZmewsVMIXLLVhB9KB/4OeCvhBk22jAIcYgRzXMw+SsQ5RXpM6Do
 Udkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzn74TPTXff8rUf5Hav2GUSuOfTtjYX5flAR3vqPnihVQNolFb/W/tI0k4GLT13QqHiOc2zt96QLiqO@nongnu.org
X-Gm-Message-State: AFq9FYIU5lHat5WF6dXQopAE/st9vCy9aY5xy+i/53fkbiS+HPKVerif
 p2SCejk/0S+pDXq9x/VNK/3YMEUfCUWrK9ZuHrUolc32qVf4xhyFxzyMgh30mgMqEW9kziQwOmq
 a3YmnCCsRC4zoTeaeUISOlfvuY3LpCVTUgysvIlolsKsB7lU3rmdUUquAgA==
X-Gm-Gg: AYBFou3wWJi/IHzWAX0cTIVKzI8ygs7sfn05ajSZo+/Cjb27MhccL0Bm1duubGee/0/
 3yKoqn6g0+eUHw21cNGSzIBQ87puwuO12Awaj8BhDndt/TwElrnzYeo6ezBtk49NSfZn+O67d/+
 Y0MBWtNAczB/PD6kWSG/ij2yg20nGPYJZLGxlLrpdbZUuodMXW4bfHO1L+5hfoFTHTd2hkfOSow
 eWwAf8g69xLyNUIp1GgGrl0B8SCyzZ+38XoN76hRY238IsyoHOt3HuJkjSSktp/WBPE/S1Ign8g
 n2MPJh0BbbQI9o7TZ9qWeZzUFcAntR1GB+aWWH0CSqTgKyicQ12IQE4+5D4BrPYHOtElCC/xrwn
 cN9IV/y1rc8hI2S4hiP/iZBiNXbymLn/5oQ==
X-Received: by 2002:a05:6102:1488:b0:7b4:879c:bb87 with SMTP id
 ada2fe7eead31-7b4879cc10fmr1218273137.14.1790611583195; 
 Mon, 28 Sep 2026 09:06:23 -0700 (PDT)
X-Received: by 2002:a05:6102:1488:b0:7b4:879c:bb87 with SMTP id
 ada2fe7eead31-7b4879cc10fmr1218259137.14.1790611582227; 
 Mon, 28 Sep 2026 09:06:22 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf4598esm3279295e9.0.2026.09.28.09.06.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 09:06:21 -0700 (PDT)
Message-ID: <6e3f6c45-f5c8-48d6-9496-3b17fcc9214d@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 047/101] tcg: Generic expansion of tcg_gen_negsetcond_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-48-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uAD7pvLSMnd9omaxRIGttA6ftFQqKc7G
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba9080 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uAD7pvLSMnd9omaxRIGttA6ftFQqKc7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX3UIHYp4OjcUo
 CMDygUXV+s3BiiZfRFTVitEcxGtiwlYxUd5mVWhnFc/au4cNuT9fRYeH9MZdvPdW21zodXoXqR9
 bOTZeT8TiODiDE7jZLQEQeKMGZtef4YHZbqnt/OB4MOPjDSgsm4emiq9g+T9GoSky3OaxKRmAYC
 TUOXrl6JHqXqrh1W820b/Y1jse/ii9PmR+Zk8RL6PQFWwwffqb2Nl9LgHUwcT+a7cr5rC8hdGaz
 CLDJGfXeR5lziE2wxIonchZtE1JEFAmNfP8PYcsCXVaexnZjZviLnpr2C1ndfb1RabyYFmY7qCI
 Ws6KlecR56HmRD+jDG0zoGW9vjp769pYZoYYIEyUv+JhZb3bA37MtzaJVUupNjmRXGBCpJWgOsI
 26z5pq2CaCOc6G9JJn8IYgHxBp1Q+8JBG8h4bkfl4sGLsHLBcKTsXdGTks9dE9bngc4D8u1Kx0j
 dqmFhLMh67dM6YeBp9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX6rEhRa2gdUfc
 K0WlD6E5KMSzMVp2LLN4JYbJteOj5cZ/WXDRrNEdzJQ5szS2GGf71bfRTyPGnAupjj31OTKNsF4
 G/dgcMR5vReIJohOHJNDSOnkjEF5Tz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280064
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
>   include/tcg/tcg-op-common.h  |  4 ----
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 36 ++++++++++++------------------------
>   3 files changed, 13 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

