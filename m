Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91306C44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkhlW-00010q-A7; Fri, 17 Jul 2026 08:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkhlU-00010V-Gl
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:34:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkhlS-0000Vc-K8
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:34:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCTuwt1756227
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 irwPvkl8b0yZTQ+eDfTrHiU1/R5uLZoCSXHK9QNgr9I=; b=Bb15rEODqP9tQz8W
 LaZAz5T+7BcllnbldfQbsJhtXoD/CYYg5Z7OFyuYsHFxC9lIX00AU4O2GDf/pbPK
 0npr7lNI5XGB4WB2lQPORDU+r6I/vYTcuLYDGf5HX1F4cxozQj9gAdziEVVQd+F6
 bjRpbkDZCPOg0HFXSZq8WVfV+IZ8R/riod0peemy4r7yZNleXM9iayqAiqu6chYY
 UnCr8/2WLvqQhA7p79/OFC2eaP0Apg9CozhFmFwLYTkGno89dm8D430l6PyyeyQP
 0j8v9LYR66p0hvG+yEPjQsdMnX8Fm9cDvAyWfanBJdyZYIet/GRM1bwKv58zjU6+
 Be22JQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff2f2v6gy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:34:00 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-81e68b02459so200852557b3.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784291640; x=1784896440; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=irwPvkl8b0yZTQ+eDfTrHiU1/R5uLZoCSXHK9QNgr9I=;
 b=QI+o7koB312SLd/wZDLtHcOMQmwBWSIgWJB++t7Qr3MELMS54T23KIp02EXAkQnOaR
 IC4okUyhY0E1sChvv/ppMS7ompP8SC7tsC9SflgjSY5+Jcso5R6mivWa5QXy1qYwuawv
 4dTWWs6k+sHMM+zZDJpLlaRbFr5eJ2z6nZPYlwE3sBRD4TPf5VE25EpqOFpq4OSbOizQ
 cavkafPETbDpKc9gyX3eV7q2GcWN0KLfGDB4hJ6hDsXHssf4QZ47EQn/jNPe6Uw5hhqM
 RSnslIuyRY6oCBSyN9+orT/Ud6I1Jmf0xCygb5sNf9LL/7glMF3aa9UHOx5mw3kJrQch
 YRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784291640; x=1784896440;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=irwPvkl8b0yZTQ+eDfTrHiU1/R5uLZoCSXHK9QNgr9I=;
 b=KI6NEOkMXCAmUJ1vdJcSRKvqfOetijcAmsDUvdiaG+1HuMqOXvkkdm3FjtaqCvGilK
 LboH0bBdlp12n9BCLw5EQcLL6d63TcC0YCrjEkrhzyQV72t/9/yQN8StrA5+KjZYh5ul
 12d0Jq2BtjHbdkJgdWRe6DOZo0b/Hi/+xo6khYYl50VdHwbt2ixmQNrhAgoa92Z+9eQm
 zbSlZJsx/H+A4+i9rtw8pbWahwXXCDIaewJLW+6YnDvij6R8VU5LFaW3be9z18UTD3Av
 lhNc9UvNEp2urf9gG1PxblSAeBjUr+BrSLLLc9gCKmKPR1C64W9G/3ElNLwH6ykEE3XW
 0YvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnFw/adurU3POuebOa+J+7tanrWuTx1GR8IJKzZRx7IIJ/auZrfTpyiV/W7/F3b6mkBTbxqyLN8Vfi@nongnu.org
X-Gm-Message-State: AOJu0YzfL9DBWiF/VtNPXpNDvrAV799g2ir7s0DyzNwaNOvjVY/Z0MQf
 lgNy+RwarHP4EYY4Tt/D0e99mBdcSBTbW/wd+qkdDiCQ4zpzx846HkUD0ykztqIwK4rb+jvzf5H
 oqj9uVLZ8oDMKQBMwfxQV3t0Y7A3kFmmOnxQXD79y6gHmkdYfl2OCu4rk8Q==
X-Gm-Gg: AfdE7cmVfqrN7a3gBaBL5jpx4nJkGQ+9hQRdIxFpaxVCTdHTOwORhQG047w4z0nO7AU
 QX7ftQLFkrR7E+zzFm8hWjL/zOQh/pJXdjVTbktUS80Hr4zKr1GVtIuMLZHID7N4260ZnXPt8Oc
 3/Ch9+e21u2UmCvLr/vlXWVOMSJgOScY3tzFJwGmc0JTFSQCqpdAJLA65NDzy1VvXkyjVIOYrNU
 RdXe6dqtrotGAMftvzhRhqlf1zaQRT07kmX9A1a73hF826h2dvwoXf7DY/4xhB9/7dd2P+R0Wvr
 Yqbnuxtp5fpi9C/4ZzcOvqctE6Zar4MijwUTFOIQoZPJzjVInLXI75ykc0jc7CxhIfqrXrlM1Dh
 dxX3DGdwVyIxeTwtrtxrlM4TudMcCm9Km3L2Kww==
X-Received: by 2002:a05:690c:6b06:b0:816:b469:ccec with SMTP id
 00721157ae682-81ef25a187dmr7368497b3.15.1784291640507; 
 Fri, 17 Jul 2026 05:34:00 -0700 (PDT)
X-Received: by 2002:a05:690c:6b06:b0:816:b469:ccec with SMTP id
 00721157ae682-81ef25a187dmr7368387b3.15.1784291640096; 
 Fri, 17 Jul 2026 05:34:00 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81ef42e85f5sm7833937b3.45.2026.07.17.05.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 05:33:59 -0700 (PDT)
Message-ID: <1f0df921-7575-49fc-805f-e18de5edfbb8@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 09:33:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: fix U-bit check to apply only to
 leaf S/VS-stage PTEs
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com
References: <20260717112340.1071148-1-andrew.jones@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260717112340.1071148-1-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GXjTFuieXcraeK7vsvcyBWerlRCbFfAR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyOCBTYWx0ZWRfXxk05IF+H120k
 kb3n4gl7ARvU3ou4Jn/v3+fNMjWpzzyALRzrBQM+KCCijY65iaxzXuOKoimFn/k5K3FZpQA822n
 nosZcwo4c44P4o3eOuKMAQnXtHUgQKI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyOCBTYWx0ZWRfX3c1JvdjFKTat
 iLrHt0QUz7/fzXIcIF68fbWstQNDQriyZayZJFS5ese5RwZDeKFTcphhna/7rwyWzXtQW6qTWO3
 LxLYnOzO+ur6qH9dn+HgJIZyZ56CkxAOhV7mhRb2+2gh8OvJO+YYNabLySV+WjfIGAHJsN7CHzn
 vNUAnASDB5XuQkCi9XEytBAeYi7NweA5Bc+rR25ybIyQNlurCR5mgiyKb1M/6bmsueEIzpe2Daa
 hR9XwDpDAOVhfPHTJB7YaTJCRyvJAMYVI3tS1+Olx+JOhF32Jups0+0n3TzFZcHoVdMQXj3xEOt
 0fMSrrxCsdKjXhb+qQoQfL5W1lK44QWRoML26U1TZcJfO4x1JNt4t2S04zrgSVoXpO933/HwCIS
 zhngGmd958skqcxEopFQ76ShikLgR7iqzpKjmTSBzDuazFtqOP0dNG6iMymCi/HbQFqpYqex3na
 UVCuuunJc1ahEpXqWgQ==
X-Authority-Analysis: v=2.4 cv=NcTWEWD4 c=1 sm=1 tr=0 ts=6a5a2139 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=reDuT1hDkj-Uxv0C5A8A:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: GXjTFuieXcraeK7vsvcyBWerlRCbFfAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170128
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 7/17/2026 8:23 AM, Andrew Jones wrote:
> Commit b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and
> no priv access") placed its check ahead of the leaf-vs-non-leaf
> branch in riscv_iommu_spa_fetch(), so it fires on every PTE walked,
> including non-leaf/table entries. Per the RISC-V privileged spec's
> address translation algorithm (Sv39/Sv48/etc., the "leaf PTE has
> been reached" step, followed separately by the U-bit permission
> check), the U bit is only defined and checked for the leaf PTE
> reached at the end of the walk -- non-leaf PTEs don't carry a
> meaningful U bit at all.
> 
> Move the check after the leaf/non-leaf branch, alongside the other
> leaf-only checks, mirroring how the G_STAGE U-bit check (added in
> 9158c900ab30) is already correctly placed.
> 
> Fixes: b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index f6865d1e164e..ed9fb09f8bc7 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -476,13 +476,6 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>               break;                /* Invalid PTE */
>           } else if (pte & PTE_RESERVED(false)) {
>               break;                /* Reserved PTE bits set */
> -        } else if (!(pte & PTE_U) && !pv) {
> -            /*
> -             * All accesses are assumed to be User mode unless
> -             * process_id is valid (pv).  In case we have a
> -             * non-user mode PTE and !pv we need to fault.
> -             */
> -            break;
>           } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
>               base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
>           } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
> @@ -491,6 +484,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>               break;                /* Reserved leaf PTE flags: PTE_W + PTE_X */
>           } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
>               break;                /* Misaligned PPN */
> +        } else if (!(pte & PTE_U) && !pv) {
> +            /*
> +             * All accesses are assumed to be User mode unless
> +             * process_id is valid (pv).  In case we have a
> +             * non-user mode leaf PTE and !pv we need to fault.
> +             */
> +            break;
>           } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
>               break;                /* Read access check failed */
>           } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {


