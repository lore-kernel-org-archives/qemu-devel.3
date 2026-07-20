Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F63FC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlwLj-0005xU-Pk; Mon, 20 Jul 2026 18:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwLe-0005wF-PC
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:20:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwLd-00044q-Bd
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:20:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTZJL3539890
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nRP4YnKH/TwwudyFA9UKhjSHjz2nWH5bAmfPCkIucUk=; b=SccX0ng266sV6X+d
 pWREHwYOhXr2ZVEpIFlvb8rkTKT4GDx14IQ0ewzT4gRMOPm/FBrXi1rjDrk3mgHZ
 cHV7wcEnWcaEnhpW1wpMyDKGqtCREHJD2Zj1s71c1rQcJnZckzxOfJWDoWsH/aby
 pwznP45ncBjVA3JxKmGrIJZKoMeODYymsKmwvQvFD6kIFR6h8YYZoKKljWnwstiA
 T9z1f6lXRfi8h6vJNQoEaUdeY2VsK5bTA0qI83IygqWf42yPyrR/5TZmpc+rvNMm
 VAm3qsgdk53O1wgdJsXbfo8b5rtM7OZHotnryfyCWBjFmVqFigWuQbq61FARWh+s
 S4bC2w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhk2faqe2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:20:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf27789c79so55862815ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784586027; x=1785190827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nRP4YnKH/TwwudyFA9UKhjSHjz2nWH5bAmfPCkIucUk=;
 b=BfP0MpfbOe9eVbTXyip1/H66iTXSOBKVy7FhJJmkwhCaokmn0g0tPRL3VVqNhdfsoi
 lA9Mw1+06dJzOgTaiqRi2BjP3BQeynr7uArbHK0RxcfbQzN6puCEHC/iaSdqH8HzbzIR
 xd1Y3xMRTh3foHbjzM6yvtJPurNBJ08GRRKbY/943c+mhU3JfSpsFMkjza3LKrMTaf1c
 LHCPRh9h99z0Yrktk2Gr/FB8DWz0k4oyRZFzZIlBvUACSSp2G7i5ha01ESDg2uP8K0F+
 nI0Qj1n1QXKXWWbBVlTlV7P1Sf5rXujn46f5EfY9l/czQEe4AI7nnTm9LXTQGVBTNser
 43vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784586027; x=1785190827;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nRP4YnKH/TwwudyFA9UKhjSHjz2nWH5bAmfPCkIucUk=;
 b=tZECVrL71BdNafML0KRcibQX261k9V5tpm9ACsQV6OqOpGT8bk+6NM2oA/123S9gDj
 TqrBf5h5oHmPxH4LrbNtNTplHIdWd59ECNiXewxvsHGJixiV+j8GdFrapYFK/dTGAqRK
 OQnAC9Xyz8jciZFtWGawAq9BcZc706mDv3EdailKlIB9NdkpZbKCVq/KxokboT1VoJ6B
 4NuVDgMjdGf3SEpHsqBmZmvazfaJZLyiJzeOjN2FsMCfoEzPGpDiqygWyESkBoPpO6eZ
 MslaDHCr7uuishEjVbr9ZaJR1pvPc5+3TuD/v64Z7rCnJBi38En73ihi3whz6kmTv21h
 SktA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBBpgbOZvnQoQYzY7FgxcVWqgxXKNCLUoVXN4XYb/a/QaRIaAGEwXKqORXztJWYy9eqzets31fd5zK@nongnu.org
X-Gm-Message-State: AOJu0YyIIBQS9oQ/iK01UADYEMNUziE7dxHk/CHKxEQPsewpT7vjuond
 N2W9HDMx+UQbwuhFe3adSyFrr3dX1iWRx0jNG7Be86os5Y7u9FOlBzojFGI3a7C4HjxWJBcEE6A
 MPU4Ow8aDGhNe66801nGZC5M/AhT/CuC+akCl+teTEcmlzV0dGc6mGf/ZWA==
X-Gm-Gg: AR+sD13dxSZOCGa1WC9BBnw/h6zdJjw9Ak3+qKc5Yl+etZNGOhXIs2WbC3GtAwsM/1u
 vlLL6SD+XsinYTwYTzrhLBTuPTxtrozZHxdHRjtsCuJtsNzlfVn+ofN7Y+Xjru8fg+fGj5cactZ
 ZFA2N+fFiOwjetI32wPIIpL0Tdr06N9fBkNwcCm6NbQPSxcSvjcn4chByj/+nycet642erNX7rY
 Slsvu1e0ETa0umWHjZ3CPAkFDI35C0OlCtld1urPdpL/G31PaNLo5ER4ryROvGznGOT7y0rpIWM
 UVurpPy5EjurzxhTHXe/WYNs9QtJVFrbNg5T7FKh9BUQLrlnoddJ9czEfOjNkp3en7yQFJEbj9/
 pHhq7SrtIej/h1zTo+iI8OOPBYzd0cn+0CawGNsyjiPCkKyp+pXH0lAkhSx2ZVQQDO1tO
X-Received: by 2002:a17:903:1b66:b0:2c7:f12d:5d37 with SMTP id
 d9443c01a7336-2cf348734acmr161798635ad.17.1784586027232; 
 Mon, 20 Jul 2026 15:20:27 -0700 (PDT)
X-Received: by 2002:a17:903:1b66:b0:2c7:f12d:5d37 with SMTP id
 d9443c01a7336-2cf348734acmr161798405ad.17.1784586026838; 
 Mon, 20 Jul 2026 15:20:26 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429fe1014sm39681081eec.7.2026.07.20.15.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 15:20:26 -0700 (PDT)
Message-ID: <3bf37421-283d-46fe-a7a9-99fc85638d0a@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 15:20:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/applesmc: Fix a typo setting MSSD key
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-stable@nongnu.org,
 Matthew Jackson <matthew@pq.io>
References: <20260720115336.75063-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260720115336.75063-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5dbhgLpycUahVFzTQZzZafBxtX9LPoQF
X-Authority-Analysis: v=2.4 cv=X8xi7mTe c=1 sm=1 tr=0 ts=6a5e9f2c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=GJi6Y1L1LCzbqpN8S4EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfX1NgxYwkrIWl5
 XyZZMYU4V0MkIWk9m6FIvFHGuH4v5SEynt3VlMp8cEzI3F780DCMlDe/cMuyYipL/Pbgt7qHw/M
 RTC27s4ZOi/OmjPBqhwC4sO5ZVhPmQI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfX5nGfLHBEFGnX
 eWAWgxotfaMfOaX4mHQsCY3ItazQ/5SWFPFbxdRxb7n3bF5+Wwti723cWt+X6KQfeMMedz9A1iL
 41aoiyw/f6Mnm0/eiyXgljVShCaY+s5lIZOlNERumL8/Osaovl1henFjp29hE8H0kjsQRc4XRk/
 VimNZmcBy4+QOx/KWKImoLWwZa1g7eLA0T6wtC48cuyPPkPwAjyeUVtvsVb6b7NqUzRHcz9z4iR
 W0Ub880xP9Chp87iGudm5gxZbP7kVSMa6cd/98T6k3tSTBjFl9pAwwSIjrqnj6awHXA7VXiAPk9
 lxbc37HvbuTsSAIywLJzfvHpBPdcshKGHrNzMg03z3H2nFjnKcHPhf3hujP49G9eJC0LIZIrILg
 ZjTlif7upbLTT/ql6Lqur3iO9p+HVae7CgtQBHI27UW1TWE+RBCHUoDDZlbzPD42PDc9xVOZot3
 0ucfoB7py4IniIyru7A==
X-Proofpoint-GUID: 5dbhgLpycUahVFzTQZzZafBxtX9LPoQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200242
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/20/2026 4:53 AM, Philippe Mathieu-Daudé wrote:
> In commit 1ddda5cd364 we meant to set MSSD=3, but due
> to a typo we ended setting MSSD=0. Convert the two other
> NATJ and MSSP keys to use hexadecimal notation to avoid
> similar copy/paste typos.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 1ddda5cd364 ("AppleSMC device emulation")
> Reported-by: Matthew Jackson <matthew@pq.io>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  hw/misc/applesmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

