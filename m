Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B9DC43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGgE-0003cP-ON; Thu, 02 Jul 2026 08:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGgD-0003cG-08
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:38:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGgA-0008Iz-RI
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:38:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662AmYrn3591674
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 12:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 smLWqVd0N182k9qV1zmjCM79F6wK7v+ooJhRl0ktel4=; b=NvIRJYpcdwWFViWj
 a7qvsiuXG3JIOHlqrG0m31LgqL1hekq9pXpjP6kdfHPM7jFXu7e00TsuA7+llOs7
 wGMi0PvnmgTTYEqrSwPpdzB9pYchulV2w0oH/w3shQKs9lqKTwYC0+fo0Yemjv1q
 Za3VlggTid56/AKBtosvIVmo3HZG7/DgTuV6oZ9fax131e1vRPkUiAd4CpwTl7cg
 4m4yvr7VBkSXZUMbtr/E/q8w3xaxTdLpMUpwz5AQaOV6ug2Fxvd7KZ1SPnbj7ooL
 J+BRF33VDqJhTko1GvbXPsO5ANU3/R8Qq74P3uGGJnaQ7m3xk+3hqHgj+LzYOnWT
 hH9R3w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9qu9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 12:38:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so73261385a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782995883; x=1783600683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=smLWqVd0N182k9qV1zmjCM79F6wK7v+ooJhRl0ktel4=;
 b=LrFzKh+ChapOQcKubSoxRKRCvzf12rbwUGo5xN3pA6zht9zDHYdt4zGpMwRfGROL3K
 GhKisrzTLkZrJywKKpDTQRX4BCRSDpgqp0nqlpE81HXVTsZ2sl+RAhnMuChwwx4y5kRt
 5hvVRJ5rCeMia/KY0sPLKCKFI30xISfBMRSbmzmBFETq8nOiRxTXnpsbx6LTREmFMo/S
 EqryHM9gxE/Rr+w30i5idBx4Hzm401OS/c+yZSZGDv5gOCgxdhUL1Nrlqjsl6oPy+Hzw
 7AGJfBi3Z9ROUqaLoDE5rX2HpjR6HwEd4VYyISv+ziJqubnMD/hNMRh69gxvcsUdtaj9
 u7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995883; x=1783600683;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=smLWqVd0N182k9qV1zmjCM79F6wK7v+ooJhRl0ktel4=;
 b=rMww1/npQTT974KnWzFE1T90anwVpC7oV2MXQJnH2H3D2DkkOJVFOkj7y6gWt8q9aG
 cGRPdW4lTUedGe5K9gYukR85kGajIFltUB/qNXz0pJfk28GaY1iC7/24pO7XvC0391Bq
 akHyM/BgKZFYpK90V052RJRulpPOhLMlHnJO0kVpnrYgSqn6niHLFp7G9OeEAy3VDEnA
 /8rd8R4/cSrq2HqNsVmfXGHPTZMVB7jR6xFIscWHl4RRdqL7W+DLK2ieN2vUYjlPSPyA
 YhCoZ/fxnXgQ4SRV2dNveKFPL0+RIVu3e0ri9T7/mIjuh1qKTpOqLMJhP/yYWzd7sf03
 IFtA==
X-Gm-Message-State: AOJu0Yx2De8zsdm/n6CdIfalHSU8LAinGWXPLDHnwNOVpFpPjsN14RwL
 vg/d1aX5Hi2iXIsUmOpI0g+r/ErnHNuPJdQT2EqLv/zL/hli0CD3sOzVgXAOBXY0QTcNPa86UGz
 qzUbeIHkn1odQvCzpU6+wh3yO1q4IwexyJ8dC1sCQE5HsJrUwqIGLX6AAD4xIhD6vAw==
X-Gm-Gg: AfdE7ckaIzlSsg218Pr1D93RmUVMsmi2l8Dt1T7SekggpG8g3/XG7ZntxTb2A+rTQwQ
 +oqGGdkN4u/+qmMBrTym/6N0p5g7Ek9sgDHUHohAZAKgB9x5wuLRbZCQeoTf+lQU6I5jEnmjsmy
 nECt/JAXgCnkaI4/BHDg6T9cejB6C1f6nXkyXkZzvvxRZmcPlHK5Ms30Q/bm1SmUDUQPfmP9d5N
 qhH9msMcMa2wM/ECOFUpKZNmJJjnhWvTfrTa+UnRh80HtS47MEYupssiA7gbq1Tt6vOCkv3B57r
 cQIPZ9GALaFdc/O4bCpnNSMqMhVpN+bfXwf3BEU+mIioOZgyvWUzxsDLAUBKVT7nH0oLG2cCOsF
 nM+ejPfjidXcN012ydFjpaYw0TkLDHzMlSaqcnld+emJ35ZPlhfn4kvvUqVS2kw==
X-Received: by 2002:a05:620a:4149:b0:91e:df9f:7804 with SMTP id
 af79cd13be357-92e698364d6mr1333231085a.38.1782995882257; 
 Thu, 02 Jul 2026 05:38:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4149:b0:91e:df9f:7804 with SMTP id
 af79cd13be357-92e698364d6mr1333226185a.38.1782995881673; 
 Thu, 02 Jul 2026 05:38:01 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef11338sm125987745e9.1.2026.07.02.05.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 05:38:01 -0700 (PDT)
Message-ID: <77d5891c-de12-467e-8746-02fe43121e3e@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 34/54] hw/net/can/flexcan: NXP FlexCAN core emulation
Content-Language: en-US
To: qemu-devel@nongnu.org, =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?=
 <matyas.bobek@gmail.com>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
 <20260629120032.1645265-35-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Pavel Pisa <pisa@fel.cvut.cz>,
 Bernhard Beschow <shentey@gmail.com>
In-Reply-To: <20260629120032.1645265-35-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfX3o7P6LTCAnnR
 cPfW7SoFBxbVxd9Oh8X1sHJ8kVdjByCLzWl1A+8w9ZvrrVQIyXHEeJWoauKO4crp9cLjQ/7NyKS
 fYWVcqI83D56hrUKUYGEZab6bWdkRlnRH5qcGVxDEsCohmUVI+0Z3vAW5slAHnbudx1H2n5OsqH
 OKS2RNNVSUzRGgG+zC4B+AQuefuBmflxRbZQKCaJhaY/yZPfLhTEnNBDq2MucpE/XNrYv2COKZ7
 6g087Ocv3CSviteIS2LzRAHhoAea8Dv0V66yM+0jAMYFfWbof70JHsbA/QLrV9mKiMtAFq3TE1x
 Oqryin54SwUZJvSQHxUyIUBp9sdWc/La7a5WolMENaF6+1BOMO9T1Ie/yc2O2PZLmnOG2N0m+AV
 956d85bg3vxh9bPyh2VUhSVMTMZu9tvSaZmjnNubHwdF/4FY/UUy4t4r3bQXGyspyWb/zXDtWaM
 VkGFeR+c/1Z0GJr0gNg==
X-Proofpoint-ORIG-GUID: tMYPGrCbuAdDu_w4zC4GCk9kE78zcI-g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfX362ajqUzvYFX
 8YkQdKjPVW54xYVREBM8csZGHDVvrrsqpGtGvPZE4V2aFPexaSQwmvliqptYNPQTtFwcHgoAVTd
 l831IGltwXVfvUNIQQ+BPnOAK0Ts8Wg=
X-Proofpoint-GUID: tMYPGrCbuAdDu_w4zC4GCk9kE78zcI-g
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a465bab cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Hq8N7MYxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=HybH44qrNXEBDUc3y3IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=_dBiuRmKdN86EwZiHxcw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Matyáš,

On 29/6/26 14:00, Peter Maydell wrote:
> From: Matyáš Bobek <matyas.bobek@gmail.com>
> 
> Added the FlexCAN2 emulator implementation core, with
> CAN_FLEXCAN Kconfig flag and MAINTAINERS entry.
> 
> FlexCAN2 version can be found in i.MX6 SoCs and others.
> 
> More information about the implementation can be found in [1].
> 
> Some macro and struct defintions were borrowed from the Linux kernel.
> The original authors agreed with relicensing them to GPL-2.0-or-later on
> the qemu-devel mailing list.
> 
> [1] http://dspace.cvut.cz/bitstream/handle/10467/122654/F3-BP-2025-Bobek-Matyas-BP_Bobek_FlexCAN_final_4.pdf
> 
> Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
> Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
> Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
> Message-id: 03dc62ff8013bb946aab8f64e51638b810629529.1782140438.git.matyas.bobek@gmail.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS               |    8 +
>   hw/net/Kconfig            |    5 +
>   hw/net/can/flexcan.c      | 1396 +++++++++++++++++++++++++++++++++++++
>   hw/net/can/flexcan_regs.h |  197 ++++++
>   hw/net/can/meson.build    |    1 +
>   hw/net/can/trace-events   |   18 +
>   include/hw/net/flexcan.h  |  145 ++++
>   7 files changed, 1770 insertions(+)

This commit is huge, not easy to follow / review.

>   create mode 100644 hw/net/can/flexcan.c
>   create mode 100644 hw/net/can/flexcan_regs.h
>   create mode 100644 include/hw/net/flexcan.h


> diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
> new file mode 100644
> index 0000000000..1ea459d9f6
> --- /dev/null
> +++ b/hw/net/can/flexcan.c
> @@ -0,0 +1,1396 @@
> +/*
> + * QEMU model of the NXP FLEXCAN device.
> + *
> + * This implementation is based on the following reference manual:
> + * i.MX 6Dual/6Quad Applications Processor Reference Manual
> + * Document Number: IMX6DQRM, Rev. 6, 05/2020
> + *
> + * Copyright (c) 2025 Matyas Bobek <matyas.bobek@gmail.com>
> + *
> + * Based on CTU CAN FD emulation implemented by Jan Charvat.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/core/sysbus.h"
> +#include "qapi/error.h"
> +#include "hw/core/irq.h"
> +#include "migration/vmstate.h"
> +#include "net/can_emu.h"
> +#include "hw/core/qdev-properties.h"
> +#include "trace.h"
> +
> +#include "hw/net/flexcan.h"
> +#include "flexcan_regs.h"
> +#include "qemu/timer.h"


> +/**
> + * flexcan_get_bitrate() - Calculate CAN bitrate (in Hz)
> + * @s: FlexCAN device pointer
> + *
> + * The bitrate is determined by FlexCAN configuration in CTRL1 register,
> + * and CCM co
> + */
> +static uint32_t flexcan_get_bitrate(FlexcanState *s)
> +{
> +    uint32_t conf_presdiv = (s->regs.ctrl & FLEXCAN_CTRL_PRESDIV_MASK) >> 24;
> +    uint32_t conf_pseg1 = (s->regs.ctrl & FLEXCAN_CTRL_PSEG1_MASK) >> 19;
> +    uint32_t conf_pseg2 = (s->regs.ctrl & FLEXCAN_CTRL_PSEG2_MASK) >> 16;
> +    uint32_t conf_propseg = s->regs.ctrl & FLEXCAN_CTRL_PROPSEG_MASK;
> +
> +    /* N of time quanta for segments */
> +    uint32_t tseg1 = 2 + conf_pseg1 + conf_propseg;
> +    uint32_t tseg2 = 1 + conf_pseg2;
> +    uint32_t total_qpb = 1 + tseg1 + tseg2;
> +
> +    uint32_t pe_freq, s_freq, bitrate;
> +
> +    assert(s->ccm);

Instead of that deep buried late unexplained assertion crashing
when the guest is running, ...

> +
> +    /* s_freq: CAN clock from CCM divided by the prescaler */
> +    pe_freq = imx_ccm_get_clock_frequency(s->ccm, CLK_CAN);
> +    s_freq = pe_freq / (1 + conf_presdiv);
> +    bitrate = s_freq / total_qpb;
> +
> +    trace_flexcan_get_bitrate(DEVICE(s)->canonical_path, pe_freq,
> +                              1 + conf_presdiv, s_freq, tseg1, tseg2, total_qpb,
> +                              bitrate);
> +    return bitrate;
> +}
> +static void flexcan_init(Object *obj)
> +{
> +    FlexcanState *s = CAN_FLEXCAN(obj);
> +
> +    memory_region_init_io(
> +        &s->iomem, obj, &flexcan_ops, s, TYPE_CAN_FLEXCAN,
> +        offsetof(FlexcanRegs, _reserved6)
> +    );
> +}
> +
> +static void flexcan_realize(DeviceState *dev, Error **errp)
> +{
> +    FlexcanState *s = CAN_FLEXCAN(dev);
> +
> +    if (s->canbus) {
> +        if (flexcan_connect_to_bus(s, s->canbus) < 0) {
> +            error_setg(errp, "%s: flexcan_connect_to_bus failed",
> +                       dev->canonical_path);
> +            return;
> +        }
> +    }

... expose it as a link in [*] and check it is set here, returning
an error to the upper layer before starting emulation:

     if (!s->dma_mr) {
         error_setg(errp, TYPE_CAN_FLEXCAN " 'clock-control-module' "
                          "link not set");
         return;
     }

> +
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
> +    sysbus_init_irq(SYS_BUS_DEVICE(SYS_BUS_DEVICE(dev)), &s->irq);
> +}
> +
> +static const VMStateDescription vmstate_can = {
> +    .name = TYPE_CAN_FLEXCAN,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_INT64(timer_start, FlexcanState),
> +        VMSTATE_UINT32_ARRAY(regs_raw, FlexcanState, sizeof(FlexcanRegs) / 4),
> +        VMSTATE_INT32(locked_mbidx, FlexcanState),
> +        VMSTATE_INT32(smb_target_mbidx, FlexcanState),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static const Property flexcan_properties[] = {
> +    DEFINE_PROP_LINK("canbus", FlexcanState, canbus, TYPE_CAN_BUS,
> +                     CanBusState *),

[*] here:

        DEFINE_PROP_LINK("clock-control-module", FlexcanState, ccm,
                         TYPE_IMX_CCM, IMXCCMState *),

> +};
> +
> +static void flexcan_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.enter = flexcan_reset_enter;
> +    rc->phases.hold = flexcan_reset_hold;
> +    dc->realize = flexcan_realize;
> +    device_class_set_props(dc, flexcan_properties);
> +    dc->vmsd = &vmstate_can;
> +    dc->desc = "i.MX FLEXCAN Controller";
> +}
> +
> +static const TypeInfo flexcan_info = {
> +    .name          = TYPE_CAN_FLEXCAN,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(FlexcanState),
> +    .class_init    = flexcan_class_init,
> +    .instance_init = flexcan_init,
> +};


