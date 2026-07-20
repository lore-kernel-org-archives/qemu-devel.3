Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E836BC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrtl-0004cc-RH; Mon, 20 Jul 2026 13:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlrtk-0004ZD-Nq
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:35:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlrth-00021N-F2
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:35:24 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6jP43299199
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1nJSN/16zpCcBanPqmL4DZU9JKaSYAh1VwTvJrYDWKY=; b=GZ1IhtFHKrNVDPYq
 f0DiCXYgmSDv/W3RMEcughL1l+3OwWBtAmE6PfKmZjr9zGPn5OfSul+Hdbkl1MmO
 RWVH2NWLcFY6CYg8nG+tL+Yp2+pVgG+ErjJdBOzDsPW79MvEOSdHsK92jg3BntXh
 NmEh1NOk60LLn1uj7tBI++lgLtxdbS2s0bFwzB1huXbmx5ueQYkS6/DF4AVgokur
 i/mFny6Q9S9TC2NXpXubJcw9VrsV4+5fHoRXsL/9J8sKJ/K2XRDtmUJNoag5sN9T
 f2rXijnI9gQ6Q5irYPa2wh6gIKD7S10bMrIwxK9oE2/F7DTVe7ESmBiIQhbV4sEC
 89LeAg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxjk80-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:35:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cce870a060so181425515ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784568914; x=1785173714; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1nJSN/16zpCcBanPqmL4DZU9JKaSYAh1VwTvJrYDWKY=;
 b=UC4lZG/hysMm0D5lNd6x03g9TvhXasbVCX7sfb/zbigYr/b7RwCprXu3MwnkHp6eKG
 F7syrF9LuGjfvdHgd34Dyvyd6uYLIH8dqWtiQCHgcgczHl4lVjIKvWHDdk7YCGHhgFRg
 DusE2+zuv/w+VlTy2+6+t2cXB+P/l+8WCO0DchkHZXgkGluOZUAFhjaw+OoCqr4n2W8W
 Jx68zWN8SWXf6X1TNcYg8ZzS4p2tsxL/3wwcodYLJwEL6Kaj5ClJajeZ0Jvh4LaDT/yw
 8LyuCrplouBVAxnN80sNJRPMH7fnHY2eG+KJpn7oVtuhWhdCoQfygb8e1KPezD1kWEvM
 jI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784568914; x=1785173714;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1nJSN/16zpCcBanPqmL4DZU9JKaSYAh1VwTvJrYDWKY=;
 b=Zcu3+LlwTPvJwTrFoz05F4BSF8x2gsi8hU9qX79Dg7kgWQrmhqNgSrjwCMGo3WKpvf
 MWLooLdhrpxp38cVxxyeMGvB99kdOZcwTm3pVROLiB1GahjTxGnug+Fv4Tas1iNVuwAD
 EAlSq3NlqiPJPNPAJN8pBZL10wVi2k3WgZ9X93TfnH/IvJyXnPwN74fCm62thaHIflNj
 DxUjjnwkDWTwRkBgfQgPxISyKC5qF9G0vmWOtjV4mPfhTldVcQAYbTo+jG32+bQUCjbs
 uZPp5cjPM4mEAtHuiWzd7SyYUBFBxGKKMNZiUZS3GMj1jmfX77SFa8LajPMrNu0Kow1r
 z40A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVTHES2x0DrM7VlSN9ndt05g3z6OZfOkekvC+rOV2lZY6CnUG38aCmmxysYqapqEoLESod04xh//ZU@nongnu.org
X-Gm-Message-State: AOJu0YwuK2qKePpdnC3sS/w3ra9wQz8xCmwsdRZ3iDJY3VhXeZieJqSo
 muTk4jKK87tBLW75zGtKDP/SsMuDUYEM78vieuEXUC2H2cO6WCvMCN0Z1J6PzZNhjXDlOIChPV/
 8bXlsyXlv9MaKhAD77nNiGv+Ay8CZw/uhdC7Y5vYxM8LY2Fi/4f2ckeBEJg==
X-Gm-Gg: AR+sD12b08DP0TgiRmvcsPUdkkB3aStW+ellRf3jD8ebqc/Xv6rmxC/fzy7S4mR1Mes
 wSFe/F2H1c3eTuNJkeLjeZxbPUiEvd38D0NytSjvS9SUH3lAHO0BNDuSfj0NzauxQYTfF0jAm1Q
 YJ6hRO8YpR1TVDhfqzqF+pvAI78fWD7KgDoA9PBWBPon+0hYHlQAXdcwjukfH7ILf6VxAON9z6D
 vOBeFU2W/xchJtFMJGm7/BbtAeuSXkyXP+rQGdVgJj4x3V/iEEDRgdbR67yf+oXYWBD2apBWkj8
 TmxsysIvZIpotR+4hK4g9qndCx4L8Wi5zXluTk1+B/qoraqUSyKy6TQQETRDWroRMsdLVw92mAO
 ShCb+DTDwUtQyZi0+GxIOmSG9ZDa3AjgeXG35tVPyKJO1QPXLDYdlBsqWM6kSKRg38uBp
X-Received: by 2002:a17:903:3805:b0:2ce:8551:318c with SMTP id
 d9443c01a7336-2cf349d1747mr147460005ad.40.1784568913961; 
 Mon, 20 Jul 2026 10:35:13 -0700 (PDT)
X-Received: by 2002:a17:903:3805:b0:2ce:8551:318c with SMTP id
 d9443c01a7336-2cf349d1747mr147459665ad.40.1784568913410; 
 Mon, 20 Jul 2026 10:35:13 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d44fsm37364959eec.1.2026.07.20.10.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 10:35:12 -0700 (PDT)
Message-ID: <764a8c69-0511-4b86-a649-c0a0ea9080bb@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:35:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "target/arm: Build cpu32-system.o as common object"
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260720100312.119894-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260720100312.119894-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5e5c52 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=5ksWg3-Fzs99CpwBcB0A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MiBTYWx0ZWRfX7AFui+it1KbO
 SqFclfVH82k4NKIENPUt5pTBtGD6HyytaVRQKZh3RCEbx4uGYWFvDFk/L0CA+yHx8Mc5blBIQn0
 1RKR3GSNajFB+qgfxLrqFWg/Fl+SD4U=
X-Proofpoint-GUID: wva2aonbYJ13VUqILAgC51v9lDY8PIT9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MiBTYWx0ZWRfX9KxaBXxNchEx
 GnJF9mUDYywD7kEK6Jo2CvBUknsRn/JaelFHrKQ4h7stajaT7LfcVNogTKxA7qZzUXB/4S2QlTp
 Htec+CdEY/5GOncMr4g8t41flllq+zHddieCcQjPfRtLPb8pDeTyqU3+EvLOlf73ObnibmH+4yB
 oPDffyAvpioLmhIkPhNB5II+1mBzFBuZtW1KPozrzjNS3ySdPY9xLRPpyhUJ6UN4IZjVMq5TXmY
 nkJODj5z8xMwy82GBOxSBWULX4bpg+PLf2DJrF1c/TArewLf8ijyPxNuTsGli9SLmjIcwkOOLZ8
 QuE/GXrZd4gNTBN0smLlZJLya06KGr9cVlc2eivMndE6HHOBua3NnLWAzjHzBJpXAPw6v3WmkKE
 nUTx1pXUNrip4LRqQmrVeP5f0t4+/qQP4/Y2j40xSPOYk8FfEsb5sUpkgq4mzWR5W8+ySnMS6XZ
 822Ku9UACRpU93k8Omg==
X-Proofpoint-ORIG-GUID: wva2aonbYJ13VUqILAgC51v9lDY8PIT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200192
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/20/2026 3:03 AM, Peter Maydell wrote:
> In c8bea1276c we moved cpu32.c and built it as a common object.  The
> commit message says "cpu32.c only contains CPU types used in 32-bit
> system emulation".  However, this is incorrect -- it contains 32-bit
> CPU types used in both system and usermode emulation.  (The case
> where we don't need these CPUs and which we were using ifdefs to
> avoid is specifically the AArch64 usermode qemu-aarch64 binary.)
> 
> The effect is that qemu-arm lost all the named CPU types except
> the M-profile ones (which are in cpu-v7m.c).
> 
> This reverts commit c8bea1276c85855b2e088b740737d043c8556d58.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3962
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The commit reverts cleanly, and looking at the git history
> I don't think we have anything that depends on it, so a simple
> revert seems best to me, especially given that cpu32-system.c
> doesn't reflect the fact that we do need these CPUs in
> usermode too.
> ---
>  target/arm/tcg/{cpu32-system.c => cpu32.c} | 10 +++++++++-
>  target/arm/tcg/meson.build                 |  5 ++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>  rename target/arm/tcg/{cpu32-system.c => cpu32.c} (99%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

