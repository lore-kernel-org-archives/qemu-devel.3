Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970E6CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ3BZ-0007pr-KI; Mon, 15 Jun 2026 05:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ3BV-0007pW-UA
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:00:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ3BU-0006oA-Es
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:00:45 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F7UCkG4091933
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FYfdZLMq8LqjR71Z/DWsbC4FByyrAC0oSL4BAoI60Fs=; b=VE9+SYFb85Sg3LGv
 GAg1GSbGbLAH0/NEYUw5BBBlpsN3+EAlgnVPrXKgkPqfULygzYXzfVxSYHiHigqp
 bBdwHapbOWutS0Jko0g+PoRpWcahJVObInHo3dFA5jLBS613qLZEqjVnkkSk/7LM
 BFdDc87s5pCF4MmgGf1n9y4uz32VGvnvwnWtg7eVtwivj1EsUAcMDTPBw/BLWn83
 LlcT1xZA+HrqJjzbhYACp/pramhExxvfi/RyDKjnXnG4YcFCJw8JJ/bFuKW4EPXy
 bz1fZ8J1Xf2GbVw5DvHPt4xckc8SpERks6xP8SygFItKVnkTdprE8NahMBtQnvFy
 mHpCUg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2c8c0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:00:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91565f8c589so560192685a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781514041; x=1782118841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FYfdZLMq8LqjR71Z/DWsbC4FByyrAC0oSL4BAoI60Fs=;
 b=PDx+USmA1Geu7EZef7lnNmaQvpqs87RY+KaiLkddA6wB4cInPLF6Z69nRhy9NOJQL6
 EHDzVXq9NnDIY0r2LQ/DbfreWAr55ugjmA9G3wIysvOnNNTysTS2ZCbawiniBJxMH8fR
 klkFxeujCw6trOMlvkKh7WCtW4TDPWeb0e4uZDatY+VPbQdIfKEyfw7In+n7jT4BIjPQ
 ttxMXzVEadmr8i7aMv34mxHjd3zIXGnVQyTK1LebfZeN7Qwp68vV4ZzQapyRQBTvwsVP
 SHLs7QlJ1CG/tB8c91/JLuO6n9+PVcRs0u22FNCQuWOjRo1Pzea8QcEElRNDcyr6Aa11
 Rmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781514041; x=1782118841;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FYfdZLMq8LqjR71Z/DWsbC4FByyrAC0oSL4BAoI60Fs=;
 b=Q+0bmK5eNDvl4TV4DornbImAjpRrAzqp+UQQFTI/+5F47ARoJPqgGCRwIOckc9KNc3
 T2aNLWNdPHuA5b/XEcn2XK4gYgNQOGl1Q1kYsGsk+KIazsujMCEyXGN81TpDiyplThYG
 Nm2MP1XvD2XbH0NrRHJexLzIIYWQ51ihXj3BvxeCO/cYcph+BCTDe4D3eO/GzBFSAoGX
 GLKYm2N1YwVH3s/hIE0wSh88Wxa324uvOtUUkiiC6qj0WIX99yJf53IQZm7HdzPu95iy
 9S2CVeMCyDlt+mHhCvpr2qTY4wGon2qRLliOgJZ+EDczgmCv/UFb/lrQmrogQkD1sXVh
 FTcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Kx9kZhcykvS8THNW1HGU0M9cRc5KL7I5WyXBglw1QZ1zYQl3xrns/DLywTOeid4Sb1yH8KD7/SPKO@nongnu.org
X-Gm-Message-State: AOJu0YwdG8EGuly4ZvBODEZPEmPh8usyL6LR/xWVRgHVrmiXOSCzEaxu
 teXFIcXv7+mBaKRrpACrxK/MQD6pT2J1UVu9pSqllMgaH4DHO3fLuCuO3anbqoxfasD5WEa3zxJ
 uz40ICBEWiA6NRpaoRPPCX8JY0k3Kic/6fdJ/P5oqKXB6RndylHKKxi1jqA==
X-Gm-Gg: Acq92OG5g1kUaBeh96Zdvcbw/TUPWh2VoekpvV9NcnGbIUUD2Y/0M5enQEk1aiZjzS1
 tvZFGaqe4X2sb5uNugL1SDb5VPXx786Z3Bo1AsCO65/wj46szT0tJRQxHHtXbYx0uGJxvGKdx98
 M/GibmOC9+H8flOEn8JvKcqWTmTD9vd/B3uPqjIwhFYYNySk0gBDDgzLe+kfraa38KKYnQFv2hu
 v92LXH0P+HFQF2TJ/o/2c2jr7TD4rYftWcpNDB14kk73fb86MmVLz+E1rYEV96sia9jT1XOBI+q
 ABhcg5qwRV6wf0EhgoqIU2kjTyGfym4evQqAB5Cfp1a9zvdNu/7FI+AVFEVb14Ra/NWj2DCwHYw
 mYehzUVrSoVL1MW2D1/NO3NVdukwpfuDvJ4ITWD4DNc2WFx6Gs3MXNcVFhdqRdUtuWz+5O8cu
X-Received: by 2002:a05:620a:a191:20b0:915:9b90:332f with SMTP id
 af79cd13be357-91619dfb8e7mr1232350685a.11.1781514041414; 
 Mon, 15 Jun 2026 02:00:41 -0700 (PDT)
X-Received: by 2002:a05:620a:a191:20b0:915:9b90:332f with SMTP id
 af79cd13be357-91619dfb8e7mr1232344685a.11.1781514040826; 
 Mon, 15 Jun 2026 02:00:40 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb7b6dbbcsm432827266b.32.2026.06.15.02.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 02:00:39 -0700 (PDT)
Message-ID: <6920a6ce-8bad-43d4-8f24-fce4f78f5753@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 11:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: honor --extra-ldflags when forced to use
 objc_LINKER
To: Matt Jacobson <mhjacobson@me.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260615045547.23422-1-mhjacobson@me.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260615045547.23422-1-mhjacobson@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5NCBTYWx0ZWRfX7ItAAqYtuHsV
 jFHe2lTb8gZ/YclUaAI6TxKbDmad199Hud8kJON1P0/idqoqVC9pBDinDVRFvWjWvngzatPGKH0
 zMxLpjd4P8W27t6q73atSqdone0W1x8wQJZmqphM7hmV/9jupljzL1+hVRiCC2YZYRrDst6npFP
 qHzYq5zKGoQ3dpEXSF8RdK5e7YyOwF31hBSseGmkPFr1IGORZfsFsr8rGLOTBMXYvV2padQDldh
 Be2x+ok82mB81Zu31dModobKCsHJX6Knsua9CBbqtgPemUWhBRCjROIcSxMIs83D/CEQZYLb3OJ
 NO7GdbLYMog5HY84reeuBkTe8CAlqFWHwQ8ijmBYCrUbJfMeHZASjbtHWgFn++M7gpiqsZ9TI6F
 8LAwDTDPL5NeiIdqaWRKv4fRlhpwc45/irnwOahce10WeeSmj047xliXRW5hD7WSpGU6mQdzJgV
 uyjeXZ+y+VA8TdkXduQ==
X-Proofpoint-ORIG-GUID: d8tTjmdq_w6m4KoobqLeKIpJq9e88AGN
X-Proofpoint-GUID: d8tTjmdq_w6m4KoobqLeKIpJq9e88AGN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5NCBTYWx0ZWRfX5jTf27r5LLiW
 GqU/DBQMCBLwsPSvITisLfzwNyi8/KzwgSgg3VhfZTtrxK4QLx6gufINHSu29RUCOASAcWvKq1U
 Gd8b+/GYRFgwcqgefEs3K6D6MwnVKG0=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a2fbf3a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=HHGDD-5mAAAA:8 a=EUspDBNiAAAA:8 a=KQvYhro-uxQUiASCdf8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150094
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

On 15/6/26 06:55, Matt Jacobson wrote:
> 3220b38a8d had the side effect of making the individual target link steps
> use objc_LINKER on macOS, because `coreaudio.m` became visible to Meson as
> a source file.  (The preexisting presence of `cocoa.m` is masked by the
> fact that it gets built into libsystem and then extracted back out as an
> object file.)
> 
> `configure` correctly passes `$EXTRA_LDFLAGS` to the "C linker" and "C++
> linker", but it neglected to do so for the "Objective-C linker".  Fix that.
> 
> Signed-off-by: Matt Jacobson <mhjacobson@me.com>
> ---
>   configure | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

