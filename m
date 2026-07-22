Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B793EC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 20:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmdDL-0001CO-GO; Wed, 22 Jul 2026 16:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmdDH-0001BU-3i
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 16:06:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmdDD-0001ar-96
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 16:06:42 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MHqw771385274
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 20:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DPKq4vWpYyYTtsEI9qjIQakkUIDKJNXGujjWrUQ6pio=; b=RpWhUPbLWEz4TVuO
 zJ8IJVC9XhXRKgOOWiTe6QQLmWxmgXXmCLWs+IkMiy7PXL+XGlnRSEK8qwdBnYSG
 +PXz/t6NSl+s8CuTlZNfUFdmR/YTYJB/jyCu9QaBtc/GkbdgBagP/RRp8aRGMnKE
 MycKFaoPJOQXpHqkyt26XnMVA6pJ3TjzhRxrCEJEy9q1UIxr9CXZvuYX9V+sWxp3
 llOju9SVo9u57yuV8H5zcCb+Iwugro2nD1banJj3KJgNSFUZP4DhEBlIUtfNyTwN
 k3YGWc1T0K7YXhHh4ANvwEHhtqYRyOVLlUjiNlEyUJ91RxMw1rtuTNsDPoZTuIJJ
 18R9qQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2tx4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 20:06:36 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-907c59bd65aso8991696d6.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784750796; x=1785355596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DPKq4vWpYyYTtsEI9qjIQakkUIDKJNXGujjWrUQ6pio=;
 b=Y3OsSpyLnQM5cDZsfu71CwcWZ8UvOzjhd4qpohS5snH+SUiFtcUJBCSD9pqmwM3cu/
 diU9N9CZ0D+1ggztyXnO6Lnt0WFUVLykCSvy9Nz5mnsRG50Rrj4L2iebXYPwc9vUYntD
 6im3TDV9PjYQXKzVUDA9f+Uq73wN/lAh4xwlKzceBZj/S033d6sn0338crrKREhuzCuL
 OgHAXUVb3xj7KCivQCEK+X5tn6u/TL+WUzAwabqR/x2vY3+b2qKqI5UWDH0QpWtU2odE
 q40pzGvhj7BI8RETQdTBuMVvsq0sVGWHMA0FxFSOCQbtk7Yl5kw3RsPzL85v8+2Ec7Sr
 G7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784750796; x=1785355596;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DPKq4vWpYyYTtsEI9qjIQakkUIDKJNXGujjWrUQ6pio=;
 b=nvLYHLuZkSpTtQ/SEW//rszhmcu9N6caszBcPVgmFIRq9IsXCzC5dLXfo7KQeBgNBl
 tyE2Msa5JTn/vf69mWEtKliPfi/BVOsdCs/Aj8rj/nd6RzMEyJNIv8jPk+9Koz4VUw3s
 RFbMShUWwfWs7lubM6ZPpjd/n8CgPJcDkqQubifhmKOYJoldaL2uSQDrrXu9hbz1NN4q
 MJgdnLVquwx2rpXiPIZ2Y2FwkIspSauxsKiKmeIyERTJEAcvaWg14dBVhdBNRwJOkau9
 6CRWGwMofWj6WTtD2Wk/anuFvMIcVKRG/weviA9LedVFXo5BCkgcxBDi+RHdrIxBXD1d
 Y9Gg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpPzEdsNu2YgfzkkbwhInUMjp3D2LeIOeu39jX4jkG2nnsDq3I4VGGiiwlgzbA7KB9FiLHhn5Yzx/c@nongnu.org
X-Gm-Message-State: AOJu0YxwPbsvKuPyYdr84dH9tn9gbSENbe+bKhbtuwNj144GQvJ9BB3Z
 lBQnuWlPVM2ythijZO6m1PKe/R8rl4M4H9ju1XcrR8P/CB+xK7Df7jvcx49Dm39nYLr0Zvvb5JD
 LhmqlQRZyCcaygrVxd5b0T+SBAmQraQpy7TjHiI2rbKd20pv0GZUpbnnSsA==
X-Gm-Gg: AR+sD10SP3BgOib80V7hET2X/5SwwoFYTrJZYzEWlLCUrLTzUU0i6RX+pB+afd6LMtY
 WaLCa6SFx8KOjY+O9q1mjUmN1eVRhCSIfAz7vaTpqGQBYFQ7Iv6sWIr+wwhkk211/m3ILlQkXgY
 fDmQocn37bH0QTOksVOr2m9cp6N7hVp15SGhs3Op3kq/wffu8mO+Y83lmAXu4YJaM8dgjLpSg51
 8umh3SAyXTov3oXnqFvI901HKaFDl4EeS7m93LmquRNuRWnDMtbfT/nYTko/HKPgf/3wJpYAHUd
 pN1wlETMB8/6apzk7U9rSEuD/j5V2qnvhNpy+zECxFzWovH3z2OgiN8GJ+E/j2eNm9yinsYl4a5
 SwQwEKsxC40bmeQ2zMS/jte76Hb2K6tEcspW0/A==
X-Received: by 2002:a05:6214:2301:b0:8ee:ff2e:c2f4 with SMTP id
 6a1803df08f44-907ca570e8emr4643076d6.17.1784750796047; 
 Wed, 22 Jul 2026 13:06:36 -0700 (PDT)
X-Received: by 2002:a05:6214:2301:b0:8ee:ff2e:c2f4 with SMTP id
 6a1803df08f44-907ca570e8emr4642246d6.17.1784750795259; 
 Wed, 22 Jul 2026 13:06:35 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba8d5434sm28672506d6.13.2026.07.22.13.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 13:06:34 -0700 (PDT)
Message-ID: <6bb7bd19-90a2-4757-bda7-909b06356725@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 17:06:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/misc: Add K230 DDR controller and PHY models
To: Junze Cao <caojunze424@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260716132423.931427-1-caojunze424@gmail.com>
 <20260716132423.931427-2-caojunze424@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716132423.931427-2-caojunze424@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE5OCBTYWx0ZWRfX7p+Q/Y356Gc9
 EEOtMZcNW5c0ZXQjFrhA7DlWIGBv2quMGR6thjKJAupKmSunvbaGI5+QwwEOILd2cfYJ4p5qtNB
 wW7YsCBOZ5HhETm7Q+rSTyszF8QT3GVQJwdxdxVUUTNzwWDPtb4dqIlONGpMRPos4jio+DrOwd8
 vW90F6YzqXKWoKJJVjBqdfFT8sl6psV/yZtPKvDjN4wB2h0ERqx7v8fqipfHrynR2r94Z7ON/L9
 wQ4yS+gwjWeae6l7G/mX96xn7G+Y/+ohM7kUO1F0Bt1zevi3aEfIxuKtw8ylnsuJrurCWTbF28q
 QUAKpM42S3rwZYrwUplwYAWGH3YKgn0phTUHDDUKK8NAizD4tEHiaYdwqpOROIkbTDY8faKxt7+
 HTCboIOD/kRaOJeFyaP83LmyTU7kWH/1kHIavkd/O0kM8h75h1F8H0mKpOKlCvE2HNLOm2+6nuH
 7/mySbabK/zyPXUxyAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE5OCBTYWx0ZWRfXzdRCCi7etKKI
 IR/+B20R1qiPZU77oXPrMwEe8wuZMJRL54yqO43b+tcx4j1vwwEmlDon6O2XUS1Cd3larrHzNQ5
 VCO9tAcoWUw6uLF9JkBA16y+NJrFFYs=
X-Proofpoint-GUID: 5w9kRLM9oWy6s_k8nO_MUdQmSGLkP8WX
X-Proofpoint-ORIG-GUID: 5w9kRLM9oWy6s_k8nO_MUdQmSGLkP8WX
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a6122cc cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=q4EFNMreg5iwqOsgGKsA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=H4N_Y-AU75W7NKDNhZlT:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220198
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

Hello,

On 7/16/2026 10:24 AM, Junze Cao wrote:
> The K230 SDK U-Boot SPL programs K230 DDRC CFG and K230 DDR PHY
> registers before DRAM can be used.
> 
> Add separate SysBus devices for both register ranges. Model controller
> reset values, DFI and software-update handshakes. For the PHY, model
> register ownership, the training mailbox, and DFI completion.
> 
> Include migration state for both devices.
> 
> Signed-off-by: Junze Cao <caojunze424@gmail.com>
> ---
>   MAINTAINERS                |   2 +
>   hw/misc/k230_ddr.c         | 544 +++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build        |   1 +
>   include/hw/misc/k230_ddr.h |  59 ++++
>   4 files changed, 606 insertions(+)
>   create mode 100644 hw/misc/k230_ddr.c
>   create mode 100644 include/hw/misc/k230_ddr.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecb8cfdc41..1cb3ef6c02 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1826,8 +1826,10 @@ M: Chao Liu <chao.liu@processmission.com>
>   L: qemu-riscv@nongnu.org
>   S: Maintained
>   F: docs/system/riscv/k230.rst
> +F: hw/misc/k230_ddr.c
>   F: hw/riscv/k230.c
>   F: hw/watchdog/k230_wdt.c
> +F: include/hw/misc/k230_ddr.h
>   F: include/hw/riscv/k230.h
>   F: include/hw/watchdog/k230_wdt.h
>   F: tests/functional/riscv64/test_k230.py
> diff --git a/hw/misc/k230_ddr.c b/hw/misc/k230_ddr.c
> new file mode 100644
> index 0000000000..9ff2714e34
> --- /dev/null
> +++ b/hw/misc/k230_ddr.c
> @@ -0,0 +1,544 @@
> +/*
> + * Kendryte K230 DDR controller and PHY models
> + *
> + * Models the K230 DDRC CFG registers and K230 DDR PHY registers exercised
> + * by the K230 SDK U-Boot SPL.
> + *
> + * Copyright (c) 2026 Junze Cao <caojunze424@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "migration/vmstate.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/core/resettable.h"
> +#include "hw/misc/k230_ddr.h"
> +
> +/* DDRC CFG registers */
> +
> +enum K230DDRCOperatingMode {
> +    K230_DDRC_MODE_INIT = 0,
> +    K230_DDRC_MODE_NORMAL = 1,
> +};
> +
> +REG32(K230_DDRC_MSTR, 0x000)
> +
> +REG32(K230_DDRC_STAT, 0x004)
> +    FIELD(K230_DDRC_STAT, OPERATING_MODE, 0, 3)
> +
> +REG32(K230_DDRC_PWRCTL, 0x030)
> +
> +REG32(K230_DDRC_RFSHCTL0, 0x050)
> +
> +REG32(K230_DDRC_RFSHTMG, 0x064)
> +
> +REG32(K230_DDRC_RFSHTMG1, 0x068)
> +
> +REG32(K230_DDRC_INIT0, 0x0d0)
> +
> +REG32(K230_DDRC_INIT2, 0x0d8)
> +
> +REG32(K230_DDRC_INIT3, 0x0dc)
> +
> +REG32(K230_DDRC_INIT5, 0x0e4)
> +
> +REG32(K230_DDRC_DRAMTMG0, 0x100)
> +#define R_K230_DDRC_DRAMTMG(index) \
> +    (R_K230_DDRC_DRAMTMG0 + (index))
> +
> +REG32(K230_DDRC_ZQCTL0, 0x180)
> +
> +REG32(K230_DDRC_ZQCTL1, 0x184)
> +
> +REG32(K230_DDRC_ZQCTL2, 0x188)
> +
> +REG32(K230_DDRC_ZQSTAT, 0x18c)
> +
> +REG32(K230_DDRC_DFITMG0, 0x190)
> +
> +REG32(K230_DDRC_DFITMG1, 0x194)
> +
> +REG32(K230_DDRC_DFIUPD0, 0x1a0)
> +
> +REG32(K230_DDRC_DFIUPD1, 0x1a4)
> +
> +REG32(K230_DDRC_DFIUPD2, 0x1a8)
> +
> +REG32(K230_DDRC_DFIMISC, 0x1b0)
> +    FIELD(K230_DDRC_DFIMISC, DFI_INIT_COMPLETE_EN, 0, 1)
> +    FIELD(K230_DDRC_DFIMISC, DFI_INIT_START, 5, 1)
> +
> +REG32(K230_DDRC_DFITMG2, 0x1b4)
> +
> +REG32(K230_DDRC_DFISTAT, 0x1bc)
> +    FIELD(K230_DDRC_DFISTAT, DFI_INIT_COMPLETE, 0, 1)
> +
> +REG32(K230_DDRC_ODTCFG, 0x240)
> +
> +REG32(K230_DDRC_SWCTL, 0x320)
> +    FIELD(K230_DDRC_SWCTL, SW_DONE, 0, 1)
> +
> +REG32(K230_DDRC_SWSTAT, 0x324)
> +    FIELD(K230_DDRC_SWSTAT, SW_DONE_ACK, 0, 1)
> +
> +static const uint32_t k230_ddrc_reset_values[K230_DDRC_REG_COUNT] = {
> +    [R_K230_DDRC_MSTR]      = 0x01040000,
> +    [R_K230_DDRC_RFSHCTL0]  = 0x00210000,
> +    [R_K230_DDRC_RFSHTMG]   = 0x0062008c,
> +    [R_K230_DDRC_RFSHTMG1]  = 0x0000008c,
> +    [R_K230_DDRC_INIT0]     = 0x0002004e,
> +    [R_K230_DDRC_INIT3]     = 0x00000510,
> +    [R_K230_DDRC_INIT5]     = 0x00100000,
> +    [R_K230_DDRC_DRAMTMG(0)]  = 0x0f101b0f,
> +    [R_K230_DDRC_DRAMTMG(1)]  = 0x00080414,
> +    [R_K230_DDRC_DRAMTMG(2)]  = 0x0305060d,
> +    [R_K230_DDRC_DRAMTMG(3)]  = 0x00004000,
> +    [R_K230_DDRC_DRAMTMG(4)]  = 0x05040405,
> +    [R_K230_DDRC_DRAMTMG(5)]  = 0x05050403,
> +    [R_K230_DDRC_DRAMTMG(6)]  = 0x02020005,
> +    [R_K230_DDRC_DRAMTMG(7)]  = 0x00000202,
> +    [R_K230_DDRC_DRAMTMG(8)]  = 0x03034405,
> +    [R_K230_DDRC_DRAMTMG(9)]  = 0x0004040d,
> +    [R_K230_DDRC_DRAMTMG(10)] = 0x001c180a,
> +    [R_K230_DDRC_DRAMTMG(11)] = 0x440c021c,
> +    [R_K230_DDRC_DRAMTMG(12)] = 0x00020610,
> +    [R_K230_DDRC_DRAMTMG(13)] = 0x1c200004,
> +    [R_K230_DDRC_DRAMTMG(14)] = 0x000000a0,
> +    [R_K230_DDRC_DRAMTMG(16)] = 0x05100404,
> +    [R_K230_DDRC_ZQCTL0]    = 0x02000040,
> +    [R_K230_DDRC_ZQCTL1]    = 0x02000100,
> +    [R_K230_DDRC_DFITMG0]   = 0x07020002,
> +    [R_K230_DDRC_DFITMG1]   = 0x00000404,
> +    [R_K230_DDRC_DFIUPD0]   = 0x00400003,
> +    [R_K230_DDRC_DFIUPD1]   = 0x00010001,
> +    [R_K230_DDRC_DFIUPD2]   = 0x80000000,
> +    [R_K230_DDRC_DFIMISC]   = 0x00000001,
> +    [R_K230_DDRC_DFITMG2]   = 0x00000202,
> +    [R_K230_DDRC_ODTCFG]    = 0x04000400,
> +    [R_K230_DDRC_SWCTL]     = 0x00000001,
> +    [R_K230_DDRC_SWSTAT]    = 0x00000001,
> +};
> +
> +/* K230 DDR PHY CSRs use byte offset = CSR index * 4. */
> +#define K230_DDR_PHY_CSR_OFFSET(index) ((index) * 4)
> +#define K230_DDR_PHY_MASTER_CSR(reg) \
> +    K230_DDR_PHY_CSR_OFFSET(0x20000 + (reg))
> +#define K230_DDR_PHY_APBONLY_CSR(reg) \
> +    K230_DDR_PHY_CSR_OFFSET(0xd0000 + (reg))
> +
> +#define K230_DDR_PHY_ATX_IMPEDANCE_RESET UINT32_C(0x03ff)
> +
> +REG32(K230_DDR_PHY_MICRO_CONT_MUX_SEL,
> +      K230_DDR_PHY_APBONLY_CSR(0x000))
> +    FIELD(K230_DDR_PHY_MICRO_CONT_MUX_SEL, MICRO_CONT_MUX_SEL, 0, 1)
> +
> +REG32(K230_DDR_PHY_TRAINING_STATUS,
> +      K230_DDR_PHY_APBONLY_CSR(0x004))
> +    FIELD(K230_DDR_PHY_TRAINING_STATUS, MAILBOX_EMPTY, 0, 1)
> +
> +REG32(K230_DDR_PHY_TRAINING_ACK,
> +      K230_DDR_PHY_APBONLY_CSR(0x031))
> +
> +REG32(K230_DDR_PHY_TRAINING_MESSAGE,
> +      K230_DDR_PHY_APBONLY_CSR(0x032))
> +
> +REG32(K230_DDR_PHY_TRAINING_TRIGGER,
> +      K230_DDR_PHY_APBONLY_CSR(0x099))
> +
> +#define K230_DDR_PHY_TX_IMPEDANCE_CTRL1_RESET UINT32_C(0x0fff)
> +
> +REG32(K230_DDR_PHY_DFI_INIT_COMPLETE,
> +      K230_DDR_PHY_MASTER_CSR(0x0f9))
> +    FIELD(K230_DDR_PHY_DFI_INIT_COMPLETE, DFI_INIT_COMPLETE, 0, 1)
> +
> +REG32(K230_DDR_PHY_VREF_IN_GLOBAL,
> +      K230_DDR_PHY_MASTER_CSR(0x0b2))
> +#define K230_DDR_PHY_VREF_IN_GLOBAL_RESET UINT32_C(0x0200)
> +
> +static void k230_ddr_cfg_update_state(K230DDRCfgState *s)
> +{
> +    bool dfi_complete = false;
> +    unsigned int operating_mode = K230_DDRC_MODE_INIT;
> +
> +    if (s->phy) {
> +        dfi_complete = FIELD_EX32(s->phy->dfi_init_complete,
> +                                  K230_DDR_PHY_DFI_INIT_COMPLETE,
> +                                  DFI_INIT_COMPLETE);
> +    }
> +
> +    ARRAY_FIELD_DP32(s->regs, K230_DDRC_DFISTAT,
> +                     DFI_INIT_COMPLETE, dfi_complete);
> +    ARRAY_FIELD_DP32(s->regs, K230_DDRC_SWSTAT, SW_DONE_ACK,
> +                     ARRAY_FIELD_EX32(s->regs, K230_DDRC_SWCTL, SW_DONE));
> +
> +    if (dfi_complete &&
> +        ARRAY_FIELD_EX32(s->regs, K230_DDRC_DFIMISC,
> +                         DFI_INIT_COMPLETE_EN)) {
> +        s->initialized = true;
> +    }
> +
> +    if (s->initialized) {
> +        operating_mode = K230_DDRC_MODE_NORMAL;
> +    }
> +
> +    ARRAY_FIELD_DP32(s->regs, K230_DDRC_STAT,
> +                     OPERATING_MODE, operating_mode);
> +}
> +
> +static uint64_t k230_ddr_cfg_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    K230DDRCfgState *s = opaque;
> +    uint64_t value = 0;
> +
> +    if (addr < K230_DDRC_REG_SIZE) {
> +        k230_ddr_cfg_update_state(s);
> +        value = s->regs[addr / sizeof(uint32_t)];
> +    }
> +
> +    return value;
> +}
> +
> +static void k230_ddr_cfg_write(void *opaque, hwaddr addr, uint64_t value,
> +                               unsigned int size)
> +{
> +    K230DDRCfgState *s = opaque;
> +    uint32_t val = value;
> +
> +    if (addr >= K230_DDRC_REG_SIZE) {
> +        return;
> +    }
> +
> +    switch (addr) {
> +    case A_K230_DDRC_STAT:
> +    case A_K230_DDRC_DFISTAT:
> +    case A_K230_DDRC_ZQSTAT:
> +    case A_K230_DDRC_SWSTAT:
> +        return;
> +    case A_K230_DDRC_PWRCTL:
> +        s->regs[R_K230_DDRC_PWRCTL] = val & MAKE_64BIT_MASK(0, 9);
> +        break;
> +    case A_K230_DDRC_ZQCTL2:
> +        /* ZQ reset completes immediately and the W1S bit self-clears. */
> +        s->regs[R_K230_DDRC_ZQCTL2] = 0;
> +        s->regs[R_K230_DDRC_ZQSTAT] = 0;
> +        break;
> +    case A_K230_DDRC_DFIMISC:
> +        s->regs[R_K230_DDRC_DFIMISC] =
> +            val & (MAKE_64BIT_MASK(0, 6) | MAKE_64BIT_MASK(8, 5));
> +        if (s->phy && s->phy->training_complete &&
> +            FIELD_EX32(val, K230_DDRC_DFIMISC, DFI_INIT_START)) {
> +            s->phy->dfi_init_complete = FIELD_DP32(
> +                s->phy->dfi_init_complete,
> +                K230_DDR_PHY_DFI_INIT_COMPLETE, DFI_INIT_COMPLETE, 1);
> +        }
> +        break;
> +    case A_K230_DDRC_SWCTL:
> +        s->regs[R_K230_DDRC_SWCTL] =
> +            val & R_K230_DDRC_SWCTL_SW_DONE_MASK;
> +        break;
> +    default:
> +        s->regs[addr / sizeof(uint32_t)] = val;
> +        break;
> +    }
> +
> +    k230_ddr_cfg_update_state(s);
> +}
> +
> +static bool k230_ddr_phy_decode_anib(hwaddr addr, unsigned int *anib)
> +{
> +    uint32_t csr = addr / sizeof(uint32_t);
> +
> +    if ((csr & 0xfff) != 0x043) {
> +        return false;
> +    }
> +
> +    *anib = csr >> 12;
> +    return *anib < K230_DDR_PHY_ANIB_COUNT;
> +}
> +
> +static bool k230_ddr_phy_decode_dbyte(hwaddr addr, uint32_t reg,
> +                                     unsigned int *dbyte,
> +                                     unsigned int *nibble)
> +{
> +    uint32_t csr = addr / sizeof(uint32_t);
> +    uint32_t block_offset;
> +
> +    if (csr < 0x10000) {
> +        return false;
> +    }
> +
> +    csr -= 0x10000;
> +    *dbyte = csr >> 12;
> +    if (*dbyte >= K230_DDR_PHY_DBYTE_COUNT) {
> +        return false;
> +    }
> +
> +    block_offset = csr & 0xfff;
> +    *nibble = block_offset >> 8;
> +    return *nibble < K230_DDR_PHY_NIBBLES_PER_DBYTE &&
> +           (block_offset & 0xff) == reg;
> +}
> +
> +static uint64_t k230_ddr_phy_read(void *opaque, hwaddr addr,
> +                                  unsigned int size)
> +{
> +    K230DDRPhyState *s = opaque;
> +    unsigned int dbyte;
> +    unsigned int nibble;
> +    unsigned int anib;
> +    uint64_t value = 0;
> +
> +    switch (addr) {
> +    case A_K230_DDR_PHY_MICRO_CONT_MUX_SEL:
> +        value = s->micro_cont_mux_sel;
> +        break;
> +    case A_K230_DDR_PHY_TRAINING_STATUS:
> +        value = s->mailbox_message_pending ? 0 :
> +                R_K230_DDR_PHY_TRAINING_STATUS_MAILBOX_EMPTY_MASK;
> +        break;
> +    case A_K230_DDR_PHY_TRAINING_MESSAGE:
> +        value = s->training_complete ? 0x07 : 0;
> +        break;
> +    case A_K230_DDR_PHY_TRAINING_ACK:
> +    case A_K230_DDR_PHY_TRAINING_TRIGGER:
> +        break;
> +    case A_K230_DDR_PHY_DFI_INIT_COMPLETE:
> +        value = s->dfi_init_complete;
> +        break;
> +    case A_K230_DDR_PHY_VREF_IN_GLOBAL:
> +        value = s->vref_in_global;
> +        break;
> +    default:
> +        if (k230_ddr_phy_decode_anib(addr, &anib)) {
> +            value = s->atx_impedance[anib];
> +        } else if (k230_ddr_phy_decode_dbyte(addr, 0x049,
> +                                            &dbyte, &nibble)) {
> +            value = s->tx_impedance_ctrl1[dbyte][nibble];
> +        } else if (k230_ddr_phy_decode_dbyte(addr, 0x04d,
> +                                            &dbyte, &nibble)) {
> +            value = s->tx_odt_drv_stren[dbyte][nibble];
> +        }
> +        break;

Be aware that there's no guarantee (at least semantically in the code) that
you'll hit any of these ifs, i.e. it's possible that 'value' won't be set by
any of these.  If this the intended behavior then it's fine.

If there's an expectation that some of these will return 'true' and value will
always be defined, I advise adding a qemu_log() recording that 'value' will be
returned 0.  If this is really something that shouldn't happen you can even use
g_assert_not_reached() to error out.


Everything else LGTM.


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>



> +    }
> +
> +    return value;
> +}
> +
> +static void k230_ddr_phy_write(void *opaque, hwaddr addr, uint64_t value,
> +                               unsigned int size)
> +{
> +    K230DDRPhyState *s = opaque;
> +    uint16_t val = value;
> +    unsigned int dbyte;
> +    unsigned int nibble;
> +    unsigned int anib;
> +
> +    switch (addr) {
> +    case A_K230_DDR_PHY_MICRO_CONT_MUX_SEL:
> +        s->micro_cont_mux_sel =
> +            val & R_K230_DDR_PHY_MICRO_CONT_MUX_SEL_MICRO_CONT_MUX_SEL_MASK;
> +        return;
> +    case A_K230_DDR_PHY_TRAINING_STATUS:
> +    case A_K230_DDR_PHY_TRAINING_MESSAGE:
> +        return;
> +    case A_K230_DDR_PHY_TRAINING_ACK:
> +        if (val == 0) {
> +            s->mailbox_message_pending = false;
> +        }
> +        return;
> +    case A_K230_DDR_PHY_TRAINING_TRIGGER:
> +        if (val != 0) {
> +            s->training_trigger_seen = true;
> +        } else if (s->training_trigger_seen) {
> +            /* Abstract the loaded firmware run to its final mailbox message. */
> +            s->training_trigger_seen = false;
> +            s->training_complete = true;
> +            s->mailbox_message_pending = true;
> +        }
> +        return;
> +    default:
> +        break;
> +    }
> +
> +    if (FIELD_EX32(s->micro_cont_mux_sel,
> +                   K230_DDR_PHY_MICRO_CONT_MUX_SEL,
> +                   MICRO_CONT_MUX_SEL)) {
> +        return;
> +    }
> +
> +    switch (addr) {
> +    case A_K230_DDR_PHY_DFI_INIT_COMPLETE:
> +        s->dfi_init_complete =
> +            val & R_K230_DDR_PHY_DFI_INIT_COMPLETE_DFI_INIT_COMPLETE_MASK;
> +        return;
> +    case A_K230_DDR_PHY_VREF_IN_GLOBAL:
> +        s->vref_in_global = val & UINT16_C(0x7fff);
> +        return;
> +    default:
> +        break;
> +    }
> +
> +    if (k230_ddr_phy_decode_anib(addr, &anib)) {
> +        s->atx_impedance[anib] = val & UINT16_C(0x03ff);
> +        return;
> +    }
> +
> +    if (k230_ddr_phy_decode_dbyte(addr, 0x049, &dbyte, &nibble)) {
> +        s->tx_impedance_ctrl1[dbyte][nibble] = val & UINT16_C(0x0fff);
> +        return;
> +    }
> +
> +    if (k230_ddr_phy_decode_dbyte(addr, 0x04d, &dbyte, &nibble)) {
> +        s->tx_odt_drv_stren[dbyte][nibble] = val & UINT16_C(0x0fff);
> +    }
> +}
> +
> +static const MemoryRegionOps k230_ddr_cfg_ops = {
> +    .read = k230_ddr_cfg_read,
> +    .write = k230_ddr_cfg_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static const MemoryRegionOps k230_ddr_phy_ops = {
> +    .read = k230_ddr_phy_read,
> +    .write = k230_ddr_phy_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void k230_ddr_cfg_init(Object *obj)
> +{
> +    K230DDRCfgState *s = K230_DDR_CFG(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &k230_ddr_cfg_ops, s,
> +                          "k230-ddr-cfg", K230_DDRC_MMIO_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static void k230_ddr_phy_init(Object *obj)
> +{
> +    K230DDRPhyState *s = K230_DDR_PHY(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &k230_ddr_phy_ops, s,
> +                          "k230-ddr-phy", K230_DDR_PHY_MMIO_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static void k230_ddr_cfg_reset_enter(Object *obj, ResetType type)
> +{
> +    K230DDRCfgState *s = K230_DDR_CFG(obj);
> +
> +    s->initialized = false;
> +    memcpy(s->regs, k230_ddrc_reset_values, sizeof(s->regs));
> +}
> +
> +static void k230_ddr_phy_reset_enter(Object *obj, ResetType type)
> +{
> +    K230DDRPhyState *s = K230_DDR_PHY(obj);
> +    unsigned int dbyte;
> +    unsigned int nibble;
> +    unsigned int anib;
> +
> +    memset(s->tx_odt_drv_stren, 0, sizeof(s->tx_odt_drv_stren));
> +
> +    for (anib = 0; anib < ARRAY_SIZE(s->atx_impedance); anib++) {
> +        s->atx_impedance[anib] = K230_DDR_PHY_ATX_IMPEDANCE_RESET;
> +    }
> +
> +    for (dbyte = 0; dbyte < ARRAY_SIZE(s->tx_impedance_ctrl1); dbyte++) {
> +        for (nibble = 0;
> +             nibble < ARRAY_SIZE(s->tx_impedance_ctrl1[dbyte]); nibble++) {
> +            s->tx_impedance_ctrl1[dbyte][nibble] =
> +                K230_DDR_PHY_TX_IMPEDANCE_CTRL1_RESET;
> +        }
> +    }
> +
> +    s->dfi_init_complete = 0;
> +    s->vref_in_global = K230_DDR_PHY_VREF_IN_GLOBAL_RESET;
> +    s->micro_cont_mux_sel = 0;
> +    s->training_trigger_seen = false;
> +    s->training_complete = false;
> +    s->mailbox_message_pending = false;
> +}
> +
> +static const VMStateDescription vmstate_k230_ddr_cfg = {
> +    .name = "k230-ddr-cfg",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, K230DDRCfgState, K230_DDRC_REG_COUNT),
> +        VMSTATE_BOOL(initialized, K230DDRCfgState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_k230_ddr_phy = {
> +    .name = "k230-ddr-phy",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT16_ARRAY(atx_impedance, K230DDRPhyState,
> +                             K230_DDR_PHY_ANIB_COUNT),
> +        VMSTATE_UINT16_2DARRAY(tx_impedance_ctrl1, K230DDRPhyState,
> +                               K230_DDR_PHY_DBYTE_COUNT,
> +                               K230_DDR_PHY_NIBBLES_PER_DBYTE),
> +        VMSTATE_UINT16_2DARRAY(tx_odt_drv_stren, K230DDRPhyState,
> +                               K230_DDR_PHY_DBYTE_COUNT,
> +                               K230_DDR_PHY_NIBBLES_PER_DBYTE),
> +        VMSTATE_UINT16(dfi_init_complete, K230DDRPhyState),
> +        VMSTATE_UINT16(vref_in_global, K230DDRPhyState),
> +        VMSTATE_UINT16(micro_cont_mux_sel, K230DDRPhyState),
> +        VMSTATE_BOOL(training_trigger_seen, K230DDRPhyState),
> +        VMSTATE_BOOL(training_complete, K230DDRPhyState),
> +        VMSTATE_BOOL(mailbox_message_pending, K230DDRPhyState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void k230_ddr_cfg_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.enter = k230_ddr_cfg_reset_enter;
> +    dc->vmsd = &vmstate_k230_ddr_cfg;
> +}
> +
> +static void k230_ddr_phy_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.enter = k230_ddr_phy_reset_enter;
> +    dc->vmsd = &vmstate_k230_ddr_phy;
> +}
> +
> +static const TypeInfo k230_ddr_types[] = {
> +    {
> +        .name = TYPE_K230_DDR_CFG,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(K230DDRCfgState),
> +        .instance_init = k230_ddr_cfg_init,
> +        .class_init = k230_ddr_cfg_class_init,
> +    },
> +    {
> +        .name = TYPE_K230_DDR_PHY,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(K230DDRPhyState),
> +        .instance_init = k230_ddr_phy_init,
> +        .class_init = k230_ddr_phy_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(k230_ddr_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 23265f6035..6d5e2b2647 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -28,6 +28,7 @@ system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
>   system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
>   
>   # RISC-V devices
> +system_ss.add(when: 'CONFIG_K230', if_true: files('k230_ddr.c'))
>   system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
>   system_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
>   system_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
> diff --git a/include/hw/misc/k230_ddr.h b/include/hw/misc/k230_ddr.h
> new file mode 100644
> index 0000000000..d912e8e1b0
> --- /dev/null
> +++ b/include/hw/misc/k230_ddr.h
> @@ -0,0 +1,59 @@
> +/*
> + * Kendryte K230 DDR controller and PHY models
> + *
> + * Device state and type declarations for the K230 DDRC CFG and K230 DDR PHY
> + * registers.
> + *
> + * Copyright (c) 2026 Junze Cao <caojunze424@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_K230_DDR_H
> +#define HW_MISC_K230_DDR_H
> +
> +#include "hw/core/sysbus.h"
> +
> +#define K230_DDRC_MMIO_SIZE    0x02000000
> +#define K230_DDR_PHY_MMIO_SIZE 0x00400000
> +
> +#define K230_DDRC_REG_SIZE  0x328
> +#define K230_DDRC_REG_COUNT (K230_DDRC_REG_SIZE / sizeof(uint32_t))
> +
> +#define K230_DDR_PHY_ANIB_COUNT             10
> +#define K230_DDR_PHY_DBYTE_COUNT             4
> +#define K230_DDR_PHY_NIBBLES_PER_DBYTE       2
> +
> +#define TYPE_K230_DDR_CFG "riscv.k230.ddr-cfg"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230DDRCfgState, K230_DDR_CFG)
> +
> +#define TYPE_K230_DDR_PHY "riscv.k230.ddr-phy"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230DDRPhyState, K230_DDR_PHY)
> +
> +struct K230DDRCfgState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    K230DDRPhyState *phy;
> +    uint32_t regs[K230_DDRC_REG_COUNT];
> +    bool initialized;
> +};
> +
> +struct K230DDRPhyState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    uint16_t atx_impedance[K230_DDR_PHY_ANIB_COUNT];
> +    uint16_t tx_impedance_ctrl1[K230_DDR_PHY_DBYTE_COUNT]
> +                                [K230_DDR_PHY_NIBBLES_PER_DBYTE];
> +    uint16_t tx_odt_drv_stren[K230_DDR_PHY_DBYTE_COUNT]
> +                             [K230_DDR_PHY_NIBBLES_PER_DBYTE];
> +    uint16_t dfi_init_complete;
> +    uint16_t vref_in_global;
> +    uint16_t micro_cont_mux_sel;
> +    bool training_trigger_seen;
> +    bool training_complete;
> +    bool mailbox_message_pending;
> +};
> +
> +#endif


