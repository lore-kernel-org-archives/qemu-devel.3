Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E09C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJWO-0002MJ-HY; Fri, 10 Jul 2026 18:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJW9-00026Z-W0
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:16:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJW7-00042d-EG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:16:21 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3I191841718
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C+VaTBawsyiLdlLuK9EXJtp5+875b1nSFubFDNiAN+o=; b=LUD4WvIBhBlzXR85
 X377vomCaJTRlcj8vm3vnPQZBLq5EEFDYuymYbNY51PvDDcvjunMmWQJn0YT5tS7
 P0DVnNWM/keWM5ShfKgDSGENk4J5d22S5NwwYCz3eTbP3dtZmoxzMrkznFccrjal
 idNpo+A8Dwwco6x/+gMgbXuxvuvFnHhAQbIyBTqwzdlvl/t1dgFpojeuXeLcsX/U
 ZDnxRhFTit+so0dqm25qMx9owwZmLRWXF4U6BCSdO/ysa6GqUEZbDM+hA1oKiVaY
 hJD18t6SraLvl8fc9jlvfg70HCrPQKVk7SnVAHjX1s6zP4WCSUsnvJALXxMe/uWw
 QS5JAA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xn15m6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:16:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so13149981cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783721777; x=1784326577; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C+VaTBawsyiLdlLuK9EXJtp5+875b1nSFubFDNiAN+o=;
 b=WSYABWYTiC2rVtUAmUBZmYLhYVfO/WOH1cvv1gMttUxFq1Pe6CCg78CA9tA5dK7xUP
 moN/vyNuVrXscS8MiARebYeK9Q5AEPTnVAHGUQHF8KItKQiSfuArgJccj3A2o6UTyKkN
 yPVZGkfmfIe+oF8miUfNtyWisN3iHT8BBiZT3ANDSvIVYUCrsXZBM3ILddwxh8OfO6nV
 +NhM2Ld3Qwyz/waRlM8xSiqQoimTybF3D0h2/Tp+qSLqXpYHdR2ea4CMeBMNYZdrsVXo
 NQCBumFJd0wWFYOc81kSi6sJl13bZ+H28I0GO9kpiSOd39BMpfhkAZqfJKzn+V9pKAlQ
 3VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783721777; x=1784326577;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C+VaTBawsyiLdlLuK9EXJtp5+875b1nSFubFDNiAN+o=;
 b=hjs5XBYTvsVagnOuuQS87wM05whCjS9lsKDnXTK3CNw8RUCpRikz30riYgelRpCpsv
 8VsBgUVMvriFcM28QT9B8eE7LyNvK0Q1Rf6GIhDw49irnC59nLsb1cMztV86MzCUrjpC
 y2qcoJRh75Jxjy+D9I0wBd8VwHlcreqqF25vd5dcJmb2RlAxB2jh6cYBrwqX0sTz8f4M
 /t15keHJyTauHnwNKcpFR06pWn1hekIgdTCOvcq/D9nynJkDVm1A9yBNHoHl1R2vtbkH
 E5OOFOz9cMvg9fQIXqzJQT5NfJWmRzcHyEZq7RYU7U3xVeyUVmXB+sPUvbfwY2LcAh+S
 rdWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQQxr01J4hIjyGHrRQeyGSKWrQGwxHGkM/MrCcZaM/JPzRdt7pgIh+cm2yLW0j590Ni5TxeAnbYps6@nongnu.org
X-Gm-Message-State: AOJu0Yzol7ugps/PUBL6gEdd77w+38KXzE85CXIJLZlk2+i9M9Bk+Rgc
 gIpHfdyINQMlut7AGqiuHSifHL5O2R5khNRppMyzwEH6VS+cD6HcQg022sHNGEmo46AIxJLyrEq
 /39KszTDAhue4ZtuS3LSpTZxqIk4HskUDfkHIqtu2r/ArpwADK3B1pD5jaQ==
X-Gm-Gg: AfdE7ck0ts2KYTtHPgb1ImepfQhM6Iwc7fdwhfvBONV9gB4D1ggvaP+jOZ2F3VNpZXs
 ct9TgSsCSUB0ZFEujfvc7H4bylu3X7QHD8hlb5K+KhMK7dbfEOutjLKRPzEQt74MwbCNEt3Z2f0
 Tqh1YGZVXNS8jLC0WynhpMHE2vgQnX/snRW7KR0d2+tiY9H2qVpn41mGcF8oH35uKP/56W9SrBL
 V/cyUJU6mkHPugmD/MQl1ns/9/fTYfEnIdlecVv7u+TKtTxaWnocO193+o2U6To/MEoMwKLFogg
 9gBFI56K2qEgbLxjdPTyTELyG0jePzfPKkj53g8iwCoKN+RJ08OHyzyKUsa0XPxE86MnXj1YvZP
 U+CYWrO+4IJUL6mSxRW0GVmvvl9dx7qzI9Wrxl6f7+o0PcLVxKxB4Vm4k4gGQmw==
X-Received: by 2002:a05:622a:1101:b0:516:e152:7a59 with SMTP id
 d75a77b69052e-51cbf280ccbmr8188591cf.42.1783721776988; 
 Fri, 10 Jul 2026 15:16:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1101:b0:516:e152:7a59 with SMTP id
 d75a77b69052e-51cbf280ccbmr8188301cf.42.1783721776605; 
 Fri, 10 Jul 2026 15:16:16 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb73b161sm150741955e9.9.2026.07.10.15.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:16:15 -0700 (PDT)
Message-ID: <242a93c6-8af6-4c3f-936e-2e8e5b34eef6@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 45/51] accel/tcg: Move ALL_MMUIDX_BITS to hw/core/cpu.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-46-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JJYLdcKb c=1 sm=1 tr=0 ts=6a516f31 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HG9oXkHzoSJ3i_p-ZWgh211Pw8E6nFG4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMyBTYWx0ZWRfXyubmVqNFvbz0
 SpmBQxRfedC7cmCUnuWQNOZyYownfkZp9lsSmaFBboLgY9fNyIf+oW/ylIwjUyrDrHr46Me3XbV
 dcNXDtG1vWvrErNh4UHwzGpJ/T3YMXw=
X-Proofpoint-GUID: HG9oXkHzoSJ3i_p-ZWgh211Pw8E6nFG4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMyBTYWx0ZWRfX+Jp6yzQEdCfP
 1+qvZchq6RozMyosbcKy2u6wrKt3qlv83lnmr7lLGmY4BHfHQhlhnG4jkPA03+SbRXXw1B8X5xu
 8qFZ7jHPyle3nIWq2hoW1rFQ4IeJIRNhqrI2CeVwC1vvxszTTduNJXEqtTz8xp92Lyzy1zdTAOy
 wEgjUxCOHcY0fBMkDOJeHeFrqKIMcnEQbVf54gNaqKuWW+MV/scqHBSUInD7Csw9dUi0yHOJoAM
 bQnSY+vSLs8iBdb2mvoTPNrhgON/3NiTKMfkdDzG3stqpA2suw5NX9Abt2Ggw80wc/xhpx+83BY
 bSSoc2jtUxiQyKxpGOqui13EXyJdGmV11jKzIlQMECjeL/yRVl28mByLPu08oNV8ONykUwZt5bZ
 U+y4+7lHEovMECf4dYVCXs4PUmPmbuYPBxy/qCgL/5Hk/laCsw90ao0kjyC2TSIWVHFg6c2M0qF
 hq2IgfGUbGU6uiOAc7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100223
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 10/7/26 22:53, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h | 1 +
>   accel/tcg/cputlb.c    | 2 --
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

