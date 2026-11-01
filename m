Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14037606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UuVutc/o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=etStAg1s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNRx3-0003I3-7o; Sun, 01 Nov 2026 04:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRx1-0003HZ-Hd
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:34:07 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRwz-0005s9-Gk
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:34:07 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18KWZs916800
 for <qemu-devel@nongnu.org>; Sun, 1 Nov 2026 09:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9JvQTCHyvXPENpJYsFDxQNE0uyF1aJX8drj7pdl3PUY=; b=UuVutc/o7gIatI9r
 DeNt57deT2IFxsEgQIBsY5/zr7vR6U+Q0H2o8gc5A6MU4Vz3F2vMLQMUloE9mbS8
 y3OFs3dE+QeRnIQ71nPJmJoHd7r9BzU6xnYI+UJJiYhNIpUB4VaMYHnqchH85/tV
 ZgT7QAplw3K0TSU2n4AvjeEz8DwItImKcWY4FlMyVFacSzBpWIjDQmW1++oDF9nF
 it0JclyVZK4iLcajojBzZWbOGTUXEbSu+UpBJArFKHdwAGDTd6fM5yZRg/O45Fm8
 wG0Sbt+r3W4THoz3zWZrKLYdII6oWx8Rl/x3Lf20WY+NusjYjk98LLVwkS+xXbhq
 DNdK7g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6k6w3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 09:34:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-536347602faso38321261cf.3
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 01:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793525643; x=1794130443; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9JvQTCHyvXPENpJYsFDxQNE0uyF1aJX8drj7pdl3PUY=;
 b=etStAg1sIFHudaZLcEUANSpB7SCObqon4Azv9QGPnDRZPwSfvBGElcp8QSGXxBhSvP
 atND8KC4nn7JeaA8SyetQYuWnMO0ItaKPoNBTH+vFUYeUyrw6CYmf4PD+/uxZ22irLx2
 c3byf5k8k8UuHsaCB+6EKDz9Tipt20VDc4o1XrPS1KFGefvV7e+Nt/KwWZ0c2gAS2fPu
 MOaMmcmIV8RpRoTqxi7VlqeqByks/zx2a7WUxzTbKH0IU1DuZOht9fHlb9zgDkPJOwg0
 YcGsxEJWdSmn8klMzO00gGPQu7USZ2OBJK35KUOK5H90mc/Hn1SoQ+zG4e+9WO+FBxpn
 dHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793525643; x=1794130443;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9JvQTCHyvXPENpJYsFDxQNE0uyF1aJX8drj7pdl3PUY=;
 b=lVtULT0AZ6Lhz/8SrnWjkhvIN8sFF6+rUyY1uPhtZMbJ7/ZqHfqUcrshYk0FrxESBg
 v1rXXohk0jvO0MLW2w1UM97LrCdkIx33MLs+seLyTqNPyJrCpC4IXRBbIJfUo5IHvazn
 WVJoAhx5A4AW6LjiHU0buV5kSTQ64074DIOLhz54OunWXBML2bBunpqUk3Xvi3YNlddW
 VFqAii8WH3enH9dY1IP3gG6BzlI4wuTAmyqmccCheqVhzI98Na+ipDl2+c+nbeSJzFWr
 PkPsRSBolWoCENrZV2YJsVW96IN4tvbu8DCSeo841rKBHMFwdOOnhbmsWQaIqLuB3oDx
 JZNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBykfcD8goTMxVmC7cuT0ajAKrPAFHo22Xdgnp0XiMQYapx8nYrH7yYANKwdP+XIz98Q2+QPf7eiwtJm@nongnu.org
X-Gm-Message-State: AFq9FYLB5UYZiexUeOucXwL4Z7N31vV1nHtGOYfQ+1TuReNFBLgozrjq
 qoHoTjlbYB6ZjzpNSkxJLVYBch3NpQAlEvXBqMn9qRkPsRLcB6H+LsSVLRLzmHNB8k6BPGXyn59
 Kujn0jJyHqAuZY45yka92anYSnYpOxH2iLmguFIrP7AfSL+infO7VF+MHAw==
X-Gm-Gg: AYBFou323UG+EsqwwPIxwKPFkyQpngpfYSXo3Ok7+1BOWt11Ya0FnTtIN36C0iQ7Jg/
 P3faKwRIicf4fOGiycug8d7Ms6r/XGfvUK8U2TbrDFu13EClSxPJSiPr3EyW/K2zX/gjVVn0EFn
 2Sn85WQt30/WMNWFzQlqWJ/c5kPHNQJCfremGHW7iCjuLqXfNkii4i2e0O5r3vCAXc8XVm4irJE
 XPBxRlQ+FjmL0gZn8Kd8J2j505+BNSR/nsJ84/JAZTprPrCTbxFWIstc2dmBQkU0fa4Ok9iM8WT
 JX3B2ZI1Vw/k+AHg3uVhNuPYhwKRMJH8h4F867THoI1qsjAN9LxRWt8OT7GbND2XQshyXhm5Taq
 1/dUr+xGpOx0UmWDk4JWisrfMcxf4tytgKQDuahW/yvAPeArgdDo0VhqRvxSHL2XV+OkTtvwvmw
 1ZQ6zhbJ/v
X-Received: by 2002:a05:622a:5c0f:b0:536:91bf:b540 with SMTP id
 d75a77b69052e-542b6780d8emr117248131cf.23.1793525643421; 
 Sun, 01 Nov 2026 01:34:03 -0800 (PST)
X-Received: by 2002:a05:622a:5c0f:b0:536:91bf:b540 with SMTP id
 d75a77b69052e-542b6780d8emr117247741cf.23.1793525642815; 
 Sun, 01 Nov 2026 01:34:02 -0800 (PST)
Received: from [192.168.68.102] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54312b52eacsm57333121cf.26.2026.11.01.01.33.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 01:34:01 -0800 (PST)
Message-ID: <70bfb1bd-24fa-45df-b36b-ecd908803010@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 06:33:58 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/27] hw/misc: pfsoc: Let IOSCB own service interrupt
 state
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
References: <20261014012323.322790-1-bin.meng@processmission.com>
 <20261014012323.322790-20-bin.meng@processmission.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014012323.322790-20-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ps4VFmDJnZ56OapADHIsYqIfO1FK3jS1
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae7078c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FRSEYCzRAAAA:8 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8 a=TIZ2mjcJ1XorKqfiCOoA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=H4N_Y-AU75W7NKDNhZlT:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: ps4VFmDJnZ56OapADHIsYqIfO1FK3jS1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfX6gY1Wjmr9oco
 6/VGHCqam+AGcNYSW6RpH4069eoSzInxErptb5JqVJqqxhyl++nxZpjx/ODOkuYHBjlQsggIsNY
 m+e4inA+Gx5Zs200OilFu300sTwvdXM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfX10JvIgOfaBd0
 2/43oRMxDm6g4XYEKrv4+JJc3oR6FMG56y4yVM4YXzeqygOb3pGMy+1Z9MsQ9Nrczqt6VCEXCXI
 EXxBV7VFCdg4+bQaOOFt0/+c8EYKPXMldnldzyjXGRNEBogUrO1pFr7UW7qvQKcurnFarYqzyYM
 veMXyO//JxJr2Lign3As3qaCSMVXOdx5yGAumIby237FIsHeaLtD0Y0YtoxWj3EnpQFK6/ZB0oG
 TiAm2brweyeFVTKGNluPhhz2Tnv4+80sSZAR/YIcJvEXlVYniQo2RdZC/+aFkyFgB6w/w3uf/8p
 eiBx2xEVMJrN5qs8ZqOi+nHHnyXiO1Ia5T922A+4MExGuwQVVNEJHd6LvsIJE1xSpn/sBfnfpeP
 p2AIOhRQECUCJvlyPrsWwsGphc67wQyjDxzjDn1MVfF8fo328TRgzeP9ld4EyJzLS5EfJnkUJCv
 VuCBBvPfIzedFXCOHow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010037
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/13/2026 10:22 PM, Bin Meng wrote:
> System service completion raises PLIC source 96 from IOSCB, while
> software accesses MESSAGE_INT through SYSREG. The MESSAGE_INT pending
> bit is not modelled explicitly, so reads return zero even when a
> service interrupt is active. Model the bit so service completion and
> register accesses use the same state.
> 
> Keep the pending state and PLIC output in IOSCB. Link SYSREG to IOSCB
> so MESSAGE_INT reads the current pending bit and writes update the
> same state.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ---
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> 
> (no changes since v3)
> 
> Changes in v3:
> - Separate interrupt state ownership from the NOTIFY fix
> - Link SYSREG to IOSCB for MESSAGE_INT reads and writes
> - Support both clearing and setting the MESSAGE_INT pending bit
> 
>   include/hw/misc/mchp_pfsoc_ioscb.h  |  4 ++++
>   include/hw/misc/mchp_pfsoc_sysreg.h |  3 ++-
>   hw/misc/mchp_pfsoc_ioscb.c          | 20 ++++++++++++++--
>   hw/misc/mchp_pfsoc_sysreg.c         | 37 ++++++++++++++++++++++-------
>   hw/riscv/microchip_pfsoc.c          |  5 ++--
>   5 files changed, 55 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
> index aa108d2d88..e8386f9794 100644
> --- a/include/hw/misc/mchp_pfsoc_ioscb.h
> +++ b/include/hw/misc/mchp_pfsoc_ioscb.h
> @@ -53,6 +53,7 @@ typedef struct MchpPfSoCIoscbState {
>       uint32_t services_sr;
>       uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
>       char *serial_number;
> +    bool irq_pending;
>       qemu_irq irq;
>   } MchpPfSoCIoscbState;
>   
> @@ -61,4 +62,7 @@ typedef struct MchpPfSoCIoscbState {
>   #define MCHP_PFSOC_IOSCB(obj) \
>       OBJECT_CHECK(MchpPfSoCIoscbState, (obj), TYPE_MCHP_PFSOC_IOSCB)
>   
> +bool mchp_pfsoc_ioscb_get_irq_pending(MchpPfSoCIoscbState *s);
> +void mchp_pfsoc_ioscb_set_irq_pending(MchpPfSoCIoscbState *s, bool pending);
> +
>   #endif /* MCHP_PFSOC_IOSCB_H */
> diff --git a/include/hw/misc/mchp_pfsoc_sysreg.h b/include/hw/misc/mchp_pfsoc_sysreg.h
> index c2b3688a94..d6c9027f2d 100644
> --- a/include/hw/misc/mchp_pfsoc_sysreg.h
> +++ b/include/hw/misc/mchp_pfsoc_sysreg.h
> @@ -24,13 +24,14 @@
>   #define MCHP_PFSOC_SYSREG_H
>   
>   #include "hw/core/sysbus.h"
> +#include "hw/misc/mchp_pfsoc_ioscb.h"
>   
>   #define MCHP_PFSOC_SYSREG_REG_SIZE  0x2000
>   
>   typedef struct MchpPfSoCSysregState {
>       SysBusDevice parent;
>       MemoryRegion sysreg;
> -    qemu_irq irq;
> +    MchpPfSoCIoscbState *ioscb;
>   } MchpPfSoCSysregState;
>   
>   #define TYPE_MCHP_PFSOC_SYSREG "mchp.pfsoc.sysreg"
> diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
> index bde1917c10..1f77da6852 100644
> --- a/hw/misc/mchp_pfsoc_ioscb.c
> +++ b/hw/misc/mchp_pfsoc_ioscb.c
> @@ -209,6 +209,22 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
>   #define SERVICES_STATUS_SUCCESS             0
>   #define SERVICES_STATUS_FAILED              1
>   
> +static void mchp_pfsoc_ioscb_update_irq(MchpPfSoCIoscbState *s)
> +{
> +    qemu_set_irq(s->irq, s->irq_pending);
> +}
> +
> +bool mchp_pfsoc_ioscb_get_irq_pending(MchpPfSoCIoscbState *s)
> +{
> +    return s->irq_pending;
> +}
> +
> +void mchp_pfsoc_ioscb_set_irq_pending(MchpPfSoCIoscbState *s, bool pending)
> +{
> +    s->irq_pending = pending;
> +    mchp_pfsoc_ioscb_update_irq(s);
> +}
> +
>   static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
>   {
>       uint32_t command;
> @@ -248,7 +264,7 @@ static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
>   
>       s->services_sr = status << SERVICES_SR_STATUS_SHIFT;
>       if (value & SERVICES_CR_NOTIFY) {
> -        qemu_irq_raise(s->irq);
> +        mchp_pfsoc_ioscb_set_irq_pending(s, true);
>       }
>   }
>   
> @@ -339,7 +355,7 @@ static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
>       s->services_cr = 0;
>       s->services_sr = 0;
>       memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
> -    qemu_irq_lower(s->irq);
> +    mchp_pfsoc_ioscb_set_irq_pending(s, false);
>   }
>   
>   static const Property mchp_pfsoc_ioscb_properties[] = {
> diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
> index 1d9154280a..4c52338c8a 100644
> --- a/hw/misc/mchp_pfsoc_sysreg.c
> +++ b/hw/misc/mchp_pfsoc_sysreg.c
> @@ -24,20 +24,22 @@
>   #include "qemu/bitops.h"
>   #include "qemu/log.h"
>   #include "qapi/error.h"
> -#include "hw/core/irq.h"
> +#include "hw/core/qdev-properties.h"
>   #include "hw/core/sysbus.h"
>   #include "hw/misc/mchp_pfsoc_sysreg.h"
>   #include "system/runstate.h"
>   
> -#define CLOCK_CONFIG_CR 0x8
> -#define RTC_CLOCK_CR    0xc
> -#define MSS_RESET_CR    0x18
> -#define ENVM_CR         0xb8
> -#define MESSAGE_INT     0x118c
> +#define CLOCK_CONFIG_CR     0x8
> +#define RTC_CLOCK_CR        0xc
> +#define MSS_RESET_CR        0x18
> +#define ENVM_CR             0xb8
> +#define MESSAGE_INT         0x118c
> +#define MESSAGE_INT_PENDING BIT(0)
>   
>   static uint64_t mchp_pfsoc_sysreg_read(void *opaque, hwaddr offset,
>                                          unsigned size)
>   {
> +    MchpPfSoCSysregState *s = opaque;
>       uint32_t val = 0;
>   
>       switch (offset) {
> @@ -56,6 +58,10 @@ static uint64_t mchp_pfsoc_sysreg_read(void *opaque, hwaddr offset,
>           /* Indicate the eNVM is running at the configured divider rate */
>           val = BIT(6);
>           break;
> +    case MESSAGE_INT:
> +        val = mchp_pfsoc_ioscb_get_irq_pending(s->ioscb) ?
> +              MESSAGE_INT_PENDING : 0;
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
>                         "(size %d, offset 0x%" HWADDR_PRIx ")\n",
> @@ -77,7 +83,12 @@ static void mchp_pfsoc_sysreg_write(void *opaque, hwaddr offset,
>           }
>           break;
>       case MESSAGE_INT:
> -        qemu_irq_lower(s->irq);
> +        /*
> +         * MESSAGE_INT bit 0 is read/write: writing zero clears the interrupt
> +         * and writing one sets it. IOSCB owns the state and PLIC output.
> +         */
> +        mchp_pfsoc_ioscb_set_irq_pending(s->ioscb,
> +                                        value & MESSAGE_INT_PENDING);
>           break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
> @@ -97,20 +108,30 @@ static void mchp_pfsoc_sysreg_realize(DeviceState *dev, Error **errp)
>   {
>       MchpPfSoCSysregState *s = MCHP_PFSOC_SYSREG(dev);
>   
> +    if (!s->ioscb) {
> +        error_setg(errp, "The 'ioscb' link must be set");
> +        return;
> +    }
> +
>       memory_region_init_io(&s->sysreg, OBJECT(dev),
>                             &mchp_pfsoc_sysreg_ops, s,
>                             "mchp.pfsoc.sysreg",
>                             MCHP_PFSOC_SYSREG_REG_SIZE);
>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->sysreg);
> -    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>   }
>   
> +static const Property mchp_pfsoc_sysreg_properties[] = {
> +    DEFINE_PROP_LINK("ioscb", MchpPfSoCSysregState, ioscb,
> +                     TYPE_MCHP_PFSOC_IOSCB, MchpPfSoCIoscbState *),
> +};
> +
>   static void mchp_pfsoc_sysreg_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       dc->desc = "Microchip PolarFire SoC SYSREG module";
>       dc->realize = mchp_pfsoc_sysreg_realize;
> +    device_class_set_props(dc, mchp_pfsoc_sysreg_properties);
>   }
>   
>   static const TypeInfo mchp_pfsoc_sysreg_info = {
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 36c894b677..38f4e7d799 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -315,12 +315,11 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>       }
>   
>       /* SYSREG */
> +    object_property_set_link(OBJECT(&s->sysreg), "ioscb", OBJECT(&s->ioscb),
> +                             &error_abort);
>       sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp);
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysreg), 0,
>                       memmap[MICROCHIP_PFSOC_SYSREG].base);
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sysreg), 0,
> -                       qdev_get_gpio_in(DEVICE(s->plic),
> -                       MICROCHIP_PFSOC_MAILBOX_IRQ));
>   
>       /* AXISW */
>       create_unimplemented_device("microchip.pfsoc.axisw",


