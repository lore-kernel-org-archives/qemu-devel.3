Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA1EC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8e0-0003nn-S5; Wed, 26 Aug 2026 04:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz8dz-0003nb-Us
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:05:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz8dy-0004ex-J7
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:05:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6Ruuu122868
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gvcuRSlFQrnSwS6kBMUwE9Ye6d2J3ech9VHVS19Ro3s=; b=BWUYTpq9VVngo7GQ
 nDEX3HRhDmGLuQpt2ffaixrkgHJ3TgGh8xuC0KMBKjE/+/QhoASr2LGkEZbvg/Mp
 xuBP+oaCRIUCPNan+04/urabLwml8kRmoVSaprSBkf/yEjuoHr2sLpuH3aW6YMzF
 j8vsQpe5OZPN8RSVwH95/4Kf5x2Z+I1eCgcwKOB0F73xJRLL3DxrJxf/3uVI3ygv
 SJl1YECjcMNl/ESMJjzJhAWb5au6Nd2Jfk3pAzXQoTSUyqD+fVDGcT4heRbfdnwZ
 oxuuEw14VXQyOTz/kgXBtvW19yld0EGXsljpiq/vNrG7QtM59JpehxXmY2KnFpW7
 1OettQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9g4mtmyg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:05:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8fdace20927so6041516d6.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787731556; x=1788336356; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gvcuRSlFQrnSwS6kBMUwE9Ye6d2J3ech9VHVS19Ro3s=;
 b=TOdLjhdG8qzTYS2/wb7/YFgryQRNxf+z3wWpPenPtV4Vznvcp+sMUJYrC5jUvTJP6b
 3Oi1wUkcqoyiDoX3qtV3KvcE3iXd0I5PtUk72IOeqjgrBSmwZ17LuCYKtLyyCPSw1tW7
 hrWutqVQ6ZTxgW1hHyMnAA55QyktGKhv/5t3+nGg1MHgRPy6HkIlYsDUmhshUMFDJeGY
 BTaNzSOy97O64tnBGSPfVEf99lZzsA8g2lNP2XzkZcYR8syaen9X4uAmc3q/mfg2hCa7
 oLfSeg4XJc5RwgMSIDXFqP6Re/bBAh//yFMc8/MT28MwkpJAkBOqu/ul1x0o43Aa6e6k
 THHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787731556; x=1788336356;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gvcuRSlFQrnSwS6kBMUwE9Ye6d2J3ech9VHVS19Ro3s=;
 b=L0bBXOu8CEelgN39kdNqjyi8LzoadX1elcma+2/1tFJ4cc/dJgJcVVlwryE7zxuGS5
 KxVQCD6GVvQ5R+UeT0FBGNcGZPk4QT2c5fEHfVR4prGFw8VpZkqipYGxL1nDAHXXcPkr
 r/yRzdnmyc0ihrmrinr2GpIrHHrb2SDvmxjmdVDBe5OirKNEgVZ/QmBf2k7C4OQbFQ91
 RGLRfwy332fTkynWh2iGv0+v/4gBItH8Bn8pqnZYAVuaLZWbiSmTq4XpEi9rMVyfEaxi
 nxK1ikC0rhdQHIuftlMOHiK8bkWe9TmfsU0YY54lmE7SBdhMnC47GN8GUbDLSFwtlBWU
 wicw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9KUbRx9+KGfbZd4EeMgiuzCiLF27AS6MKuiSkFYCHzicjEJvM+/n9vE3asNzlg2R+E1gOgKkVDJln@nongnu.org
X-Gm-Message-State: AFuF++nfBe2BiKt5W1gImiVIKRyQ90U+X4IWoIYog+I4+lvAAGfFcoTj
 Wsg14SSCkBf9FaqAyljzPXqwMeDgqwi5swILxb9hHeJp4OaSu4J09jCEeNgakXDJj7EoZ4sBKa0
 RHbiF5RUMIL492zSBQQ0bxu+OtXv40QUutApFZZhdKnKjT3xo5FeRnsyr/Q==
X-Gm-Gg: AR+sD10tpMwi1lpz9dx1M1L1emgnwSR7V7IvhWeKu4YUMAb+NKT1p1uzCf+y++V2V7i
 hXiYluty/k84HzB/ByieU/Aqa4Ne3aa9yqkJiUs0pj+VuMJTrvhv5s1de4zPmHmcQvYf/QeWP0q
 h//xEKIyQlW9KQ+cpOlnh9ikcajYuka+d7qhWD4sdf58W76P300Zdy6Gglk6auMA2Wfn0kl2rOY
 zThul3BtaHfrcyG/iLemcVkigp3191szqrFX5+HNQNVpUoVGHKqEFwnl97/E+ZDXFLr5+Zoy5jG
 6OPioktM66NgilTk/yy3KqK71HyevOKPzoF4DaPwEgpyGguOLesSjTfY3l1zIvAv7M2PsOHGQDn
 jvtxBa1439OfrXQbf5+SCtww5bJAkjr6Gx9GbuF4Xq0U=
X-Received: by 2002:a05:622a:86:b0:517:6d82:9aec with SMTP id
 d75a77b69052e-52e42052300mr47903061cf.0.1787731556495; 
 Wed, 26 Aug 2026 01:05:56 -0700 (PDT)
X-Received: by 2002:a05:622a:86:b0:517:6d82:9aec with SMTP id
 d75a77b69052e-52e42052300mr47902751cf.0.1787731556030; 
 Wed, 26 Aug 2026 01:05:56 -0700 (PDT)
Received: from [10.254.188.74] (14.89.66.37.rev.sfr.net. [37.66.89.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f25d4sm1918497f8f.30.2026.08.26.01.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 01:05:55 -0700 (PDT)
Message-ID: <db747c26-1fc6-491e-a0b4-0252b5f36847@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 10:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] hw/arm/ax3000: Specify SoC name in header and
 variable
Content-Language: en-US
To: Kuan-Jui Chiu <kchiu@axiado.com>, 163wangjack@gmail.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <20260826074635.2850931-4-kchiu@axiado.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826074635.2850931-4-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2NSBTYWx0ZWRfXy979z3fIa1OX
 15PCYHULsMK0uI4sCJza9joDMpr8jdX92zYi9w1voHMOTrSQ36rXMooCp52NHPqO0B5syhQIqUc
 lrby6RNflvTzEuGMTOmcv2Igy1oWWFM=
X-Proofpoint-ORIG-GUID: -xPf5MOu7jb5xQ33fXIyO9aRM3iwJTrv
X-Authority-Analysis: v=2.4 cv=eYgNubEH c=1 sm=1 tr=0 ts=6a8e9e65 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=JQZmDyB7+sUo+n2VpL1TLQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=440cDlBIAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=d9D1X1bx8dWolqnE4HNT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2NSBTYWx0ZWRfX4Z1fizq89lnX
 BEOBPlGp6zCh9QoKj/pKV33LbqtFaIMgZRec6Q0yOmoNtl0n0BHGPCu4fs3FqrkSxRkI86OWvL8
 JioorDK4yZZHGmnNyewGRHhiCLoQMqQNK90Qixgh4YKUDO6WzniSuk2Mn2jSW/Jrqi3z63ut70P
 EBScghVJce/tZN84rCijfkiofz7lfhcbOkfmjz3pHgKBzGhNSFjkMSgbVmULcYtxLonWCvZ9eHE
 o+ahuNLPLCpt0m/cTI8UFC+65JJmzEQB4WFVW9EW5K+/TrZE10EicuB36lpYAPIEWyppN4aYxDz
 sqlFfERC4cXZbq3vaUmhTQZfyZOxzp09NqVRDBQs0UUPO17G+2yto+EheZWgO3ZVsAn7ioqQdCp
 eigWHZoadyqtNsS4MPrQaFwUdQ4l/ujMjpH6gp65ChQrKqK1KB17MnoFJIgs+dchxBzmXgZDe8A
 ZEHUNQQ3QZQeSbyKTxg==
X-Proofpoint-GUID: -xPf5MOu7jb5xQ33fXIyO9aRM3iwJTrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260065
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

On 26/8/26 09:46, Kuan-Jui Chiu wrote:
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>   hw/arm/ax3000-boards.c | 2 +-
>   hw/arm/ax3000-evk.c    | 2 +-
>   hw/arm/ax3000-soc.c    | 4 ++--
>   3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

