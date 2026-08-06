Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBAFC5AC7C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws2Fq-0002Ns-8J; Thu, 06 Aug 2026 13:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2Fn-0002N9-89
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:51:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2Fl-0004ZF-Qi
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:51:39 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676HPHvO2927067
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 17:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2QkwIxdfvmMTri1LtcuMsJFInP2XwNasOjmklKWAhMo=; b=LVXm3KuaQ+iF46EF
 2LSnSXseKbeqC/qNUlGtQGDtZEqWBraDaVRWLiMMbu9rOE+RLXKGS68h1ieLi5dz
 MOo+O3sJYML8AzHPWH49BlIA0FHyX0vHOgx/UHXboc+1IZAzICaBEEWc3HOkFnlI
 oZG5ZPdcEbfyrZlvqySCugkohMwYVDLimeDk4QGVr6iN4IDW2F5gDioGuRHENMaH
 lh6jzZcGPoiJpqH/JfKxdS2xXygAf6NuexadnXEpHlXVn4MiIRuPC8RNIwr5UUfH
 HItvjrAbshgXFVvLIB1bbPReLGHMa/NpEZxGeblXRwzkvCzpMBZ0YfF22HMwcFgl
 pwM8MQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvxne84hf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 17:51:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso39055401cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786038695; x=1786643495; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2QkwIxdfvmMTri1LtcuMsJFInP2XwNasOjmklKWAhMo=;
 b=F69WNi4uuUlPKQ3ztsD7/nbO5GZd9mRFc0Cnfp6WUaE0HIdVZ666Eyu5SpVgNXNoTL
 AR5Hr3Y16EuGcrGqh8EBMMdy+dN+kFBKQr/RnU7jSjk0Kc0XxBxEXe8EFo/wk52onDzO
 xz8tpAbvJUUocIPMkatEIggW35lZ3GNnDPMqN+cWxvqatRlsUFsB53D4fv/Bq0g0otsM
 hLUFzuC5gBZq1bh1uq7O2bgOlUiaewXJ65rAwWrONT8s62TCAR9nJkWfQbh2L+8C2qKv
 6yBc68xEKMYfdEoLbwF5KaApfVtSoAUDx434C1sQ3Wj32LnT7RD1KRa9TzQ194Fc8J2E
 dW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786038695; x=1786643495;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2QkwIxdfvmMTri1LtcuMsJFInP2XwNasOjmklKWAhMo=;
 b=EHnED4XDaPxWaN11WHV0CCbBsxqbnWEBq96aELOQtxKXB8VAKJMAXMff9pa3KtTK8k
 QmQ2nc1gIgZpFFolr2ci2t9k9pCl9EJrrAysZ0Cr9RfgcWn2OF4hqjP1o8LZkQITTqSf
 9P6z34JUmLJ32jdjvPn8z+Y6DxLNvI9vOcIbQqGimjLfLaM0HWAq7/8bYXTgvaSPKDAT
 n3Vs+/BiM7f97dxyH/UCmf2Kpuj++QGzzypSZ9hK5xKCHHDQazVV6GMUFl3fopCMXJxg
 Catnwzryfqk5xZs9MBWwCO0aof4OZWoGDW4HDAZJH6ES7H8COFuMzO5wrvPKHqEIej+Z
 hxBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rot0sJe9P1samd4mVJIrZC4wptJ9VseqOU6k4+A2YQmh6kHti0VWJqG1VdUbem9v3C8sf+UfLaMWT2A@nongnu.org
X-Gm-Message-State: AOJu0Yzax6bU+t/jBrSxJ/+uzEkopbepc0BM79uMmWrTgC5h1mLuB88f
 OOJMAwRC75wlqxhaQtA0T+MiG3+j3nJnaZqPaE09LXmiVKx5e/JtHTg+qcml2C3cG8qybgXWTT9
 6Dd0BSBsbEv1IGzpywzmqfZonv96QzY7lqIVnXdYm+r72qclLbnv7tISyjz4ShQ69mA==
X-Gm-Gg: AR+sD129gAVmUojYG7YHq/DkYGkfKroJWYysDY1dOp86IVFoU9GstskCB5UeBBlfUKk
 8hDaRS9XBdxQclaE2APv7ZDf/rTAv/KMjh/RQUSDU1s8E7BRNhbSu8uwfuBCqS84wE9JHYjlrQ8
 F8SDGamU+QcAih5eISjMtw721CBbWWgQf6RwGgorXCHHVKrVRpZAf7QxHdlb8oh8bfyhRqnkGaP
 hutUhmzp8vgTSxJABj1cT8jQ38fhjSphDrX/zDirt8VJTO7RE1CKyTvArp+G+csc/+z6VWgB/kI
 G413UGMuG9eees9QmvQfwWXIzGSGf86dA5e0+DIsj7qnjJnFBXNeAqsfhV8/ZLv/yaJssq0vsfu
 e+hQNtzvICtRgfTWoJaVCAQQtaag5+76N5EQ=
X-Received: by 2002:ac8:690f:0:b0:51c:ace:de6a with SMTP id
 d75a77b69052e-52d0b0adb1emr44137611cf.18.1786038695196; 
 Thu, 06 Aug 2026 10:51:35 -0700 (PDT)
X-Received: by 2002:ac8:690f:0:b0:51c:ace:de6a with SMTP id
 d75a77b69052e-52d0b0adb1emr44137231cf.18.1786038694820; 
 Thu, 06 Aug 2026 10:51:34 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b32487sm7513872f8f.34.2026.08.06.10.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 10:51:34 -0700 (PDT)
Message-ID: <59c0d6d2-b388-4fd3-8b28-9d79d1b96af6@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 19:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/arm: Pass aarch64_enabled to
 aarch64_aa32_a57_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260806163939.328201-1-richard.henderson@linaro.org>
 <20260806163939.328201-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260806163939.328201-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LxX3E1TiW9Dj8ZB-Bw_EMyoiIDxnvSy8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfXyupvXsARaEQN
 BldepS/pON7FoaBvCJ+tphmc8KlZPm7uFz6qBlhzJH/yVclOzqihtdkBvhuqVpEHFIxbLWji6CB
 Piv3Xv2kiDIYQdDII6yfWdNT2GVhsMo=
X-Proofpoint-ORIG-GUID: LxX3E1TiW9Dj8ZB-Bw_EMyoiIDxnvSy8
X-Authority-Analysis: v=2.4 cv=ZYQt8MVA c=1 sm=1 tr=0 ts=6a74c9a7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfXxw5BJOvqOOC+
 M8lXnIT1o00noDXQWwkyb7zWgoenjZMxdoI/Fy6E3O8xxJvpHp3DP3ZD8mqqEgN61JWymH3Z5TT
 Z9Dbc5tFjuATqJxcVDyHb1heiPPkSf6pdJcAK5FuZ84oJvQFS2TsERm7XB7svDDzFTCca5BHnZg
 wnKoQNGOakw0dq3IV5ZnA1lzzhKTaeCGgles/J+quikoHTlbsUa6AP4rO0ZsdsZUafzU/K0uWF4
 WffyB16XtACG5Af4b1eZNV7biBRbxawpVdfTmldJvj9V0mngiBNRjsGYOBAX1qC2J/+7yZtT840
 /7UnNw+KWsgD28CFDLBpkVSeP/guU1FuowZed041S4rVV0QufSKFLCiDWOkfliowF/NVsV4Z4B8
 nBg2ISw2EDH9KD2Oq/VVig/8TxD6YyX1qNjA7p5v7dHnona7swEjgo9ErvaHq1Ih1uavKjEbFSh
 ZueyarSBhqYfRJ2xBQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Invert aa32_only argument to what is actually used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h | 2 +-
>   target/arm/cpu-max.c   | 5 ++---
>   target/arm/cpu64.c     | 2 +-
>   3 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

