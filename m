Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAC4C54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokSV-00060m-Hn; Tue, 28 Jul 2026 12:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokST-0005vk-DL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:15:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokSR-0001G6-8z
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:15:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SEcd6f3063296
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6c5npyHiTOXxuVWUv2QJ8EeR90GhoRN4iVABu8QUYms=; b=fTnUAhoNg5oWx7p2
 ji3IfTI/DX8JljOzfWIhDsCFUz6VYwP+bU4BFKxxvYQCdKDQFInnxt9rOSMRW6aG
 4WbibXDG2ZZ1BOFWeeMa90CKvsQZyv54XE8GqhuA1BmvtN7c4ADSqimFBNDay7ME
 o0XHNrxFbjTrDCrHjDMNvzrnhe4MXzANQtflIvRxfTlewPIGVJVcGuWrFwN6GfCu
 vhPGsFO7zhrTyhIJPJ5ERuEk+7t6FCpkXuS4E8LT8w7kNv1W9oDsFpY1K9WXYlwh
 xZZCbCQGHpG+tLRmVEwqW1RpR08t60WuQbHNwTwIcYR/k9JfqyOY3Dedioblqgt5
 6RrC/A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpuyg9h3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:15:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-522de3c645dso20852611cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785255305; x=1785860105; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6c5npyHiTOXxuVWUv2QJ8EeR90GhoRN4iVABu8QUYms=;
 b=PSo2Pk2fb4evjJmN/F2Ec5C574cHMmzqUVlTp8AbmJ5+rWGg1JJdwrP3h1W31R4pDI
 qfyLDCk89DeUeuLaPprcVm6CDkW9vdv2uq6a2vZ5EGrOnm28SDfPj2UExcU8LJa8I8bj
 7m+oOOkBqOVtkNkOB8ZoLMVqDXiY9xaYh1oot9DToaKWJepc4ufEuXRg73en+0tjBVuE
 bCizFTp+04y4di7A+TO/duqCr4AEGMfEfeLKKA6Ih3yP+S7awhNxouXnASELwv7tPSNx
 rPH7BvN07DA6ODLSjvR2fNzxgNhiNBMMHS6UUP1eARpAhTQpgItW37CNzWltsVksJPow
 JswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785255305; x=1785860105;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6c5npyHiTOXxuVWUv2QJ8EeR90GhoRN4iVABu8QUYms=;
 b=aDieoha8GOJdCS5bBpVZp+SQHWI60WP1IX7j1POVCJ34riztfKpxyYr4zDvH8TkSr6
 kcrD9ndbPCkhUp23SmWpplt9hVgnv1GXev51KKYO+gb13JId/L15Jvu1ouKXjTrIg2up
 evMtFhU3uBpkuRYOkqIF1zI5/cAoMMAFb/Q8yASXH3731CkZtegf+qZ05Vmx8Hla6Xdu
 GBmlsjuo5R0PE5IQqP98xuH+hmsQSW7brRQm6M3/NAhL25FJ0wEfzxefZ8N/f0JeI3ps
 6DC8mrQ9Uxu8mV9GIG11JMNWkV8xOi5PLT4Znkhoud9wxgffXwUokJhaE4u4uVbSYQ1D
 /oXw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqObRkt/SQSnYpdOttuq7oK4cs/AXcHANawT1CT2UXjodJOObYM3v3Rj8XKhfeX8RWfU+5oqsvkF12v@nongnu.org
X-Gm-Message-State: AOJu0YxH+vgxnxK/Ia5eNp9GGGON5bgMN+JBoWHp71920h6Z6OFlnfUM
 vokldySgMLVvt877s9MNtHzi9n1lryVULLdHx2CYabceIlyCw3o1ovUodVORtNvSPjQHVepbXJH
 XY1kHNH0ySCSqJGohzoG6/gBVMiIpPQgNRjaOR5/xnvARI0NJubYk2A7U5w==
X-Gm-Gg: AR+sD11K+7K2D6CqzI9GVfxLMEWhr8L7dgofg09MDxRuzeJbcYhKQk3KDv4Ivocet/Z
 wczKkUkgt+tSBkjgglG5y917cbop06sekRClgSJAgJsqw75B4A3gc7Wb4rzgvrjboGO1Xwbde3x
 OqCEn3LiKpmvHHe28tu10JXdD1/nU7NPLryni+qN88YJLLeTfrTc0lvqqgiAB8E+ssS6vXV/2h+
 qLF/qZ11ZL+yhRGI/Otngqhl9idQ2/A9WtheYoG9GlPijuocH/nvgLGngfwD3yOoZcweNQPgqGK
 qIqDNiYcJLYxVXKCL5Z98WHWyEYY9AjUpDtokbk8Q2I9IQK4MM+a/PVSfXnYPaLy6pfQwRpgXNa
 +4QkTUhml3Pzw308YnyucLCjWMl7jKt59mZyNOEOtwm7h8vwaSIc=
X-Received: by 2002:a05:622a:110a:b0:51c:b98a:244b with SMTP id
 d75a77b69052e-529d7147447mr26553361cf.62.1785255305032; 
 Tue, 28 Jul 2026 09:15:05 -0700 (PDT)
X-Received: by 2002:a05:622a:110a:b0:51c:b98a:244b with SMTP id
 d75a77b69052e-529d7147447mr26552881cf.62.1785255304500; 
 Tue, 28 Jul 2026 09:15:04 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6aa3a88sm279975f8f.6.2026.07.28.09.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 09:15:03 -0700 (PDT)
Message-ID: <ef1474c7-8461-4c31-aa56-7f79ee9ab280@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/nvme: fix unintentional integer overflow in shift
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260728-fix-shift-v2-1-6c2355edcfbc@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728-fix-shift-v2-1-6c2355edcfbc@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4W6zp4QeEJ8A5J1h_0-7LcuONHLSE5wW
X-Proofpoint-ORIG-GUID: 4W6zp4QeEJ8A5J1h_0-7LcuONHLSE5wW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0NCBTYWx0ZWRfX0lorxX5pFx5P
 XSwdB9UKJloj4tSRlXl8TW0XAPiQlTHnfwSNFf7ynUl5SNwqYIyegNYDQ1n7+v6Je08kMlsFgij
 NIwSt2fKIM3c68aawQW0De13Bdu2tj1Mvxynv0rSGAK+R8C434nS7rtmeNP/zCAnVfxr8tQ1MGC
 YeJyT8KBTgD9WFxVMZmX6zidHk6Bhqbt95bgnbrotwSroG7KpjU4Srw4BBCf480V0RBKT2dhPZh
 on/tKK3B3E4Yx2DVwOLUgShhYdmamBBSEuaLNz/UiIskEDQ0cWbnN7memn2X0ky/hEd7/D6QkE9
 +KEJ6iwmTx2JNoCBL8WAX/BcIyRe8JrcErDa64V38CcU3gIA8uNyeZeEdtVwmXZ5zKbEHk0IQ3e
 H7aUWZFSGEb/c/W9TWg0uwfELnzPZt4RebkHyTY0o7ROj7AnC0NQzbdsC6O+xjL34ju8bCxIAho
 FGUbSNOox6Im/wnUsXg==
X-Authority-Analysis: v=2.4 cv=aoWCzyZV c=1 sm=1 tr=0 ts=6a68d589 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=dEMyx9zPJOzPcidqg8kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0NCBTYWx0ZWRfXw0BJZ4dF6+uc
 0eFuI7t2eXcHibySzcDaJOkBYBky52gWvdMYmIj5nKX43UY7PnX3XKgIqWuf9Jp6dt2Eefrdd+X
 sIOaAhKfJl1xmiX2lnYnvPviqwVC3lU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280144
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

On 28/7/26 11:42, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Fix potentially overflowing shift operation.
> 
> Cc: qemu-stable@nongnu.org
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Resolves: Coverity CID 1663674
> Fixes: ec917cd49918 ("hw/nvme: fix FDP set FDP events")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
> Changes in v2:
> - use deposit64
> - Link to v1: https://lore.kernel.org/qemu-devel/20260728-fix-shift-v1-1-bdb98c205233@samsung.com
> ---
>   hw/nvme/ctrl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Please include "qemu/bitops.h" when applying (it is indirectly
included but we rather explicit includes otherwise refactoring
unrelated headers might break here), otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

