Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5924CC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAFs-0008Ew-E8; Mon, 29 Jun 2026 07:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weAFr-0008EK-6q
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:34:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weAFp-0000nu-BH
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:34:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATEYC2579129
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 11:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E7dEUYW5YIEKnb2lHcEuTk51u6NvRoisGq+CZn489Ec=; b=k2QUqgm76SDXnG6l
 6ZPjBPu/I9KCns4F0OZt/k64pZ0JirXFMxUm6vF2PzQ1qfShcwRfbkWyPQIMy59A
 1Y6e7iERBs+BFqBywMjhMhtHmAnzP56sFAaV2XRcsl74tyox32o270dEJv+oBurQ
 n6xlxTz0EewJ+uoIf5KTt2WkFPBm9AIVtSAFQlMtKQQVZrnAxos2O1svWeWeFPdY
 eghnLbAaitxJnmRim47hcYIt1uS7ZtFNmoWTNAV2GNHiTA/TwAC2DMDaZnMor2SG
 zy6RbuZP9w4WP5z+J4i+i3NR5JNu6IWJtZnp87pLK66FxgQ4XBf8lELqVMz1gJBK
 xzVsow==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7h3u6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 11:34:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso2778884eec.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782732858; x=1783337658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E7dEUYW5YIEKnb2lHcEuTk51u6NvRoisGq+CZn489Ec=;
 b=H1erz9Tg3VTTeKgHXSF81A8O6h67+HdzkRVRZxOAnpk9jOK24etshxdnPGxer0cBLd
 rZ6EXS99GEGD5QKGh3zLksI77uO7es0br9gs7KRbZE3+WIaon/gaH8m8N/SoEmup4Pp0
 g+pf7C53i97wGRwfIrFrSWSeC2mKqzWIrQivmoV4T3IpbyF2A61m5wXKFLFLO3UpTMrK
 Q6npOJw5LnYR6Bg1M1G6h++d9JWM90TRE2EqhCMv1Xym8MxKIIjG2veTCMBHZ4t59oLs
 F75url2jQqwfRls8f/Z7WABWsig3YIbmt/jPoJqNumr1AfJWzcFpXMKESrlZYV/ZET6u
 5DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782732858; x=1783337658;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E7dEUYW5YIEKnb2lHcEuTk51u6NvRoisGq+CZn489Ec=;
 b=HtnLlXgbipyHk/nXeTy2PL/RYIRak0teP5LkNXJPxoLXTSzeqbrztKQdDJK3zfVF5E
 XsxPQ0p66W0ghWWD8AkHEsqUlJdv+piDCuSBUL1fiKykQ0OvIp0tnH95kyTeXU6vZxnd
 vWk7XwnZMfTXM2HApAlwBbx54hz06aGEj7d8oaEQ2QsjHGaCxdJkSapu6Ecs2NsT1EaJ
 F2RIzLBltVCrGzYLttOCrLenxmwTuSblsaWV5WgYV/k15Poe34s1hQUELDBpAHvhNaU0
 2AuxsJfzG6KQuMoMgCtH6FUBC8GzxXK5wRGuyLiOTVHNhXn2ns3cdvlNntKBksk8w8zA
 VHHA==
X-Gm-Message-State: AOJu0Yy7MCxIREizVBExlLH+ysl2FlxGvafDbGVDdlJkEF7EmHD+2LsC
 sz+NmMzVmcZ/I6NwE5YYAr8T5MAb8XMrKJtakWdPNlG+YthWZ7gr+4RbeSJJqVoJeFhKW5ROOxU
 2Al7Iq3wriAkf7Ptk21MAdzgfFR4KucldDY0dY2AM+6qZYc6QQVw+ldjmbkdaONNeYw==
X-Gm-Gg: AfdE7cnhVuVRBE27yr8y5q5dcAg48alWh8c9pw8IUqMZBAJ4IL/4UFI40riEokpUiSp
 7Y0rxaqEXRjR/8fPb+xPe0XEP6K8hWRSUwzdcfRafkepvATwA31jgeaXuj0XvX+ndd0Zw4XAMDV
 amZ1fLCfhLW2m5nepkEYCnktYFhJH257K6i8vArVBZPmq16KBmZz9ASunH1LOKgRO0PJuh8RCo7
 dPbN8BJinUyxqMJ6xIu88r3mzQGpAF4/TBGlXzNhxiWrho32HK0eoF/ixwYCyiSdLS74IY9YIur
 OOV40VkBp8ZoDUvKVTBLMkQ+lynbaEM6u4EJlVlHHThXFX5Z1akgzDXWjaajrNcdlGOl6f7sA2B
 MMIoyiAuoOxGeEPy9/+tUXp5HAd5Gq2BVF6yAnVWQjedi
X-Received: by 2002:a05:7022:ff49:b0:132:ac76:9772 with SMTP id
 a92af1059eb24-13b2271508cmr224866c88.34.1782732858275; 
 Mon, 29 Jun 2026 04:34:18 -0700 (PDT)
X-Received: by 2002:a05:7022:ff49:b0:132:ac76:9772 with SMTP id
 a92af1059eb24-13b2271508cmr224836c88.34.1782732857698; 
 Mon, 29 Jun 2026 04:34:17 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm44700495c88.7.2026.06.29.04.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 04:34:17 -0700 (PDT)
Message-ID: <b0184774-3449-45b6-831b-de745a4c4d41@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 08:34:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: fault when !PTE_U and no priv access
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260629104201.349850-1-daniel.barboza@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260629104201.349850-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5NSBTYWx0ZWRfX09T/Mau6Gv12
 41U5naeesq3F64Qr5rzZQ5Q7yFgyt1yf/oqE8jQfRm71Oshu3dKBC/0UMpDiULyL67DK9MJx9GJ
 jRVf35p+BUTdVbxO/36jBUnE/Vt7IrU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5NSBTYWx0ZWRfX/QRWAhMIACIb
 XK4FtIY8L1Bph637ABdtyxwS6tja/XmqXRi2quydDqsCDW0DJ1pZ7NbDteJdBNrsPMRxz7LBkFw
 IASotxjYa0vuWJC3xsJDcS5Sq0ipCnztwoDrQrnLtrjb9AbzavQIAknujuMeYq2JzVb7JEO0BRM
 o4bk01bc0vUgP4HMppOVmJfyyfUZ2bBqM89DTZckzMk+9RBzNu27WPXHEtlua7uReBt7UMeqlZe
 nkEWvMyxq+Ve28TFE1VVIrf0DJrND9UMX1YelssWaST/T2iBICG/2QZS2EDZB3+QBtWEh3rdN9d
 6MlAO3LtD+puepG6otFEKUURp7v2Bfbq/eFt6lxPARS1MWH6F2GK7VqgU5DnyTt1kIKC+u8RTjU
 3jJeLQTLf+mzgJk+huXJ449dG5HIX+4F1WCgKlgGU9IOX8EG3XfMx24K+0rytkK1BtuQwE+Ozx8
 1NO2/KY0iJDBbWGB/eA==
X-Proofpoint-ORIG-GUID: TpEqQKFFfUlZmPT8BuCE_ixUtsxa6KCU
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a42583a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=FUlGGrPokrg9S1BtQ9wA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: TpEqQKFFfUlZmPT8BuCE_ixUtsxa6KCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hello,

Please disregard this patch.

First because we don't need to explicitly call the fault code like I'm doing
here - we can just add a 'break' and then we'll have the fault code doing the
work for us outside of the loop:

     } while (1);

     return (iotlb->perm & IOMMU_WO) ?
                 (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
                         RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
                 (pass ? RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS :
                         RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S);


Second, I just found another bug in the same code area and the patches ended up
conflicting with one another.  I'll send both together in a short series.


Thanks,
Daniel


On 6/29/2026 7:42 AM, Daniel Henrique Barboza wrote:
> All IOMMU accesses are assumed to be user mode unless told otherwise,
> i.e. we have a process_id.  In case we have a non-user mode leaf PTE
> (PTE_U isn't set) and we are running in user mode, we need to throw a
> fault.
> 
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3553
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/riscv/riscv-iommu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c2c470b5df..2bea770fbc 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -297,6 +297,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           G_STAGE = 1,
>       } pass;
>       MemTxResult ret;
> +    bool pv = !!ctx->process_id;
>   
>       satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
>       gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> @@ -468,6 +469,15 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>   
>           if (!(pte & PTE_V)) {
>               break;                /* Invalid PTE */
> +        } else if (!(pte & PTE_U) && !pv) {
> +            /*
> +             * All accesses are assumed to be User mode unless
> +             * process_id is valid (pv).  In case we have a
> +             * non-user mode PTE and !pv we need to fault.
> +             */
> +            return (iotlb->perm & IOMMU_WO)
> +                    ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
> +                      : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
>           } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
>               base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
>           } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {


