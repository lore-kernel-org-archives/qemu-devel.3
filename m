Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E595606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IvEuyzmo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W+T/2C4W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNRw6-0002Iq-8j; Sun, 01 Nov 2026 04:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRw4-0002Co-E2
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:33:08 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRw2-0005pd-Ig
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:33:08 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18Kd6H4190591
 for <qemu-devel@nongnu.org>; Sun, 1 Nov 2026 09:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 04seKhopqFbaPMvs6tQiEl3D5kOnBHPW4x5I+FmlkdI=; b=IvEuyzmoUeCW1G2r
 NvubAJyEcrvjvH3aECotpi6WVqDvzL9p1SBG1tKHwcuIN/KF6WHAZAiaUBNO+G4F
 Lz6NRcYioR6665eOELo7cLZit1hO5INLtsws1OtAfW/tsSZeadnQWa7PYLi2A+vF
 cok0JGIgxiui2dZqrbyR9hfcEOyQwPIh3rksenzssH8e00xZbbDvD7QfMpF0zxFf
 9tF1wf7Mlyirwzy3YFmO+Vdody5hBGawYoBS/Db+PnCdbUu1q+7/H+QulnP1mXH0
 UH/aU+C2LtTeTwBs+RIaLt4NKvBKRFeptuoBYfLtrZV8FTR8wNUx9gQB1ClB9sUJ
 MzPKWw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nfu6kw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 09:33:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5337b591609so24098691cf.3
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 01:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793525585; x=1794130385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=04seKhopqFbaPMvs6tQiEl3D5kOnBHPW4x5I+FmlkdI=;
 b=W+T/2C4W8Ho7alL8ZmDlz5oUTJGpILa/FEKqHkle42rUHn3bziUd8g5eFYtXLKGEbF
 /s8SG5Z3bVYnGGvqKghv8IoXtaW1NuEMSeUe3B+/kWLGOjUZyGj8OM8rSjf7iKORbkh3
 LtDQexFSbnS5ZRnKeT8OgAI/cCHPhYP/wuyH3UkoLwz3MRJQXcc6Oh/TCLvm1XFCFeon
 Fsgy56SnEa98R4xTiPICIXjAfVzdcrPRBI59f9znJ3QLQHOZQRjBlYGbMsouT86TDdNQ
 8175tkGVNdwOM6c8tJbK7a2w5xrt1pIcz3981+VIRWadr7rn98W5WpAZhMYzQvoiP4Vo
 vPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793525585; x=1794130385;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=04seKhopqFbaPMvs6tQiEl3D5kOnBHPW4x5I+FmlkdI=;
 b=tBGiLkYbrsrqq6TB9HnkEjVI/a08PsNbeAU9TSG8fQuBvZZ/6R37M97bBGWSqkG2rU
 Lh8MBNyyvr6rRvvqyPEos4oll0TDQAjI3fmrUIRCg5/+JX7jqNkmd5EkIEn3UY1985Fh
 fXKIi17YqrpigDDdOvydH/iSGJy8Z5MU2TEYqaTE2tiHxi+BoalzZepcQL9XpHtxicfE
 GvPuVTeU62OE9AhDXbmacoQ+x4z0ad1oZkuvU465bUP/Jlea1Ig0IjaTTQlBcEUDG70L
 FxdtAO/TtNOOGDbgvxzbExBIcguiqB4RX3geUF4PEUEVI7sY58mrmSEMR5u1JRvB718K
 PHiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHC75NkkZbx1LNUhQnqKVCIehdVemMgh0ipFMyTmYhQOIYVbJm0wri9ieeF9z2ogCm+jn76UGZ3/Eu@nongnu.org
X-Gm-Message-State: AFq9FYIQklmJrkBSW8IhPvW5/Hzp6fGE1IK4Z2/7kb9dA+5K9iTwm7fe
 NiDMG+8rlP/f0T06GpcUifbo8Fwusv2oNoGvG6uDASkcn1KVifHYoyAZQ7ciphhRjKQCUOyy/CG
 AS0Rfe6O7Y20ENfzfaT0V8UD/ZPur0dJGQrBDnOuHd1oT2amY0dJUwDoVwA==
X-Gm-Gg: AYBFou1T+YAHyKf6Uxt1IpKsyfxEwsOIMgoCkWX97EW3kPMR7tA8UNbf5H+lQ1BxY5/
 YP378tuhy0KIIl1kJm56xvK1I3HfGdRAISFceWYRyZQh6q86q49IEpyE3h/oZwJVuxdC/qh7QWW
 0zNv6Z2GLdtISaL0vDYbjX9SVZkozeddos4eVk3vEQ5beQSJvUDo1rWnSRSybmpMajSTNYZkQuX
 do8/8Cx61ZuGwepLrzRPCR6rumpRd5qFxbQUWfGOYs4/OfMPiT/qGJMO8tfATiZzRMqDhKQ7jY9
 +M9AZU7WnhnGsznlOCtcsj6ogYLTS3pq/ZVgKV8ve2xL6/dfDuaF9fa3qfTcWxfK/fKk+RneCU0
 0RMMtc2YHECoYwN5PwjoMGzOyp/iALILkqB1yUG0TyzQmB0NkslSihqQcwKhzoQ2DZnu+2W2fQd
 3h8rztJvCK
X-Received: by 2002:a05:622a:2b4b:b0:535:c88:8f1 with SMTP id
 d75a77b69052e-542b6d5eb3amr117132671cf.41.1793525584503; 
 Sun, 01 Nov 2026 01:33:04 -0800 (PST)
X-Received: by 2002:a05:622a:2b4b:b0:535:c88:8f1 with SMTP id
 d75a77b69052e-542b6d5eb3amr117132371cf.41.1793525583880; 
 Sun, 01 Nov 2026 01:33:03 -0800 (PST)
Received: from [192.168.68.102] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54312a5943csm57239701cf.24.2026.11.01.01.33.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 01:33:03 -0800 (PST)
Message-ID: <21037e7d-a1f9-460b-a6bf-4031a045728e@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 06:33:00 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/27] hw/riscv: sifive_u: Use the shared SiFive L2
 cache controller
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
References: <20261014012323.322790-1-bin.meng@processmission.com>
 <20261014012323.322790-8-bin.meng@processmission.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014012323.322790-8-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfXz7dyKlDHFAuS
 CxDKc0QmGL6SeigrKeCtqQsf56ppog6SpMmMBd32DTyZfOWahbq0Ivy/bsWbvwIes4oYTb69tmt
 mymvuBrIQmIZHr3PZn9ckohSt9FwLCQ=
X-Proofpoint-GUID: 2gNXB4W6NgeTXMA6diZznRDW80bMemMx
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae70751 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=q3K8DOYYDC0vxjoJZ6QA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: 2gNXB4W6NgeTXMA6diZznRDW80bMemMx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfXwY0iHirfmGyK
 iUALqSa6mBfAAmw6IIC/gS5HjBMCpKFCU+ypXUA3RJ2zCW/X2Ty9fi4YQ0jmddI8EGyhZ2olCB/
 pfPp2nAx8ZdCu7Xs1gs5u3txyTCiGbcQFo7sUBnzY4gsKOmDlKrfDhjScKr7cRfd/Z0xlw9X95g
 mNGDmY/BwKct3ewXbR+gtuPQaFMcf8UCn+B/87kNzPEIyZsbTbpb2a3ZX30Yd+TxiIN32QRAmXW
 /mA1QOrqSyFW6cv93nt543blxIXzZXtNmXWY7WXZ73j5VnXsTylhrs2hGr0xzkA/Ic3Iq1VnDbB
 /Z6TOKRQEkPBLddXssRHZZl3doVHrcGGTv9GOfx5QeyvgRoY1kup9bz0iYUJcCNcOabZIxaxsz/
 +9hC9dZ7bSIb0oh4g8tLYb4ErE2QmxwtTNIvN5FyRXQBlV7gK9lt2xjkOBe7woPb3bB8NaJj/XV
 xDiYjKMqEyVpti5/31Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> FU540 and PolarFire use the same L2 configuration and way-control
> interface, with different master counts. The `sifive_u` machine
> currently leaves L2CC unimplemented and exposes L2-LIM as fixed
> RAM without WayEnable control.
> 
> Instantiate the shared SiFive L2CC with 21 masters and a modeled
> 2 MiB Zero window.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - New
> 
>   docs/system/riscv/sifive_u.rst |  2 +-
>   include/hw/riscv/sifive_u.h    |  3 +++
>   hw/riscv/sifive_u.c            | 30 +++++++++++++-----------------
>   hw/riscv/Kconfig               |  1 +
>   4 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/docs/system/riscv/sifive_u.rst b/docs/system/riscv/sifive_u.rst
> index 0e4dcf3e70..e91853ffe2 100644
> --- a/docs/system/riscv/sifive_u.rst
> +++ b/docs/system/riscv/sifive_u.rst
> @@ -14,7 +14,7 @@ The ``sifive_u`` machine supports the following devices:
>   * Core Local Interruptor (CLINT)
>   * Platform-Level Interrupt Controller (PLIC)
>   * Power, Reset, Clock, Interrupt (PRCI)
> -* L2 Loosely Integrated Memory (L2-LIM)
> +* L2 cache controller, including L2-LIM and L2-Zero windows
>   * DDR memory controller
>   * 2 UARTs
>   * 1 GEM Ethernet controller
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index aed966a62d..be5e6232ce 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -28,6 +28,7 @@
>   #include "hw/gpio/sifive_gpio.h"
>   #include "hw/misc/sifive_u_otp.h"
>   #include "hw/misc/sifive_u_prci.h"
> +#include "hw/misc/sifive_l2cc.h"
>   #include "hw/ssi/sifive_spi.h"
>   #include "hw/timer/sifive_pwm.h"
>   
> @@ -45,6 +46,7 @@ typedef struct SiFiveUSoCState {
>       RISCVHartArrayState e_cpus;
>       RISCVHartArrayState u_cpus;
>       DeviceState *plic;
> +    SiFiveL2CCState l2cc;
>       SiFiveUPRCIState prci;
>       SIFIVEGPIOState gpio;
>       SiFiveUOTPState otp;
> @@ -82,6 +84,7 @@ enum {
>       SIFIVE_U_DEV_L2CC,
>       SIFIVE_U_DEV_PDMA,
>       SIFIVE_U_DEV_L2LIM,
> +    SIFIVE_U_DEV_L2ZERO,
>       SIFIVE_U_DEV_PLIC,
>       SIFIVE_U_DEV_PRCI,
>       SIFIVE_U_DEV_UART0,
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 1ac0d1bbd9..3603cc2aa2 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -73,6 +73,7 @@ static const MemMapEntry sifive_u_memmap[] = {
>       [SIFIVE_U_DEV_L2CC] =     {  0x2010000,     0x1000 },
>       [SIFIVE_U_DEV_PDMA] =     {  0x3000000,   0x100000 },
>       [SIFIVE_U_DEV_L2LIM] =    {  0x8000000,   0x200000 },
> +    [SIFIVE_U_DEV_L2ZERO] =   {  0xa000000,   0x200000 },
>       [SIFIVE_U_DEV_PLIC] =     {  0xc000000,  0x4000000 },
>       [SIFIVE_U_DEV_PRCI] =     { 0x10000000,     0x1000 },
>       [SIFIVE_U_DEV_UART0] =    { 0x10010000,     0x1000 },
> @@ -715,6 +716,10 @@ static void sifive_u_soc_instance_init(Object *obj)
>       object_initialize_child(obj, "gem", &s->gem, TYPE_CADENCE_GEM);
>       object_initialize_child(obj, "gpio", &s->gpio, TYPE_SIFIVE_GPIO);
>       object_initialize_child(obj, "pdma", &s->dma, TYPE_SIFIVE_PDMA);
> +    object_initialize_child(obj, "l2-cache-controller", &s->l2cc,
> +                            TYPE_SIFIVE_L2CC);
> +    qdev_prop_set_uint64(DEVICE(&s->l2cc), "zero-size",
> +                         sifive_u_memmap[SIFIVE_U_DEV_L2ZERO].size);
>       object_initialize_child(obj, "spi0", &s->spi0, TYPE_SIFIVE_SPI);
>       object_initialize_child(obj, "spi2", &s->spi2, TYPE_SIFIVE_SPI);
>       object_initialize_child(obj, "pwm0", &s->pwm[0], TYPE_SIFIVE_PWM);
> @@ -728,7 +733,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>       const MemMapEntry *memmap = sifive_u_memmap;
>       MemoryRegion *system_memory = get_system_memory();
>       MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> -    MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
>       char *plic_hart_config;
>       int i, j;
>   
> @@ -754,19 +758,14 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_MROM].base,
>                                   mask_rom);
>   
> -    /*
> -     * Add L2-LIM at reset size.
> -     * This should be reduced in size as the L2 Cache Controller WayEnable
> -     * register is incremented. Unfortunately I don't see a nice (or any) way
> -     * to handle reducing or blocking out the L2 LIM while still allowing it
> -     * be re returned to all enabled after a reset. For the time being, just
> -     * leave it enabled all the time. This won't break anything, but will be
> -     * too generous to misbehaving guests.
> -     */
> -    memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
> -                           memmap[SIFIVE_U_DEV_L2LIM].size, &error_fatal);
> -    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_L2LIM].base,
> -                                l2lim_mem);
> +    /* L2 cache controller, LIM, and Zero windows */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->l2cc), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_REGS,
> +                    memmap[SIFIVE_U_DEV_L2CC].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_LIM,
> +                    memmap[SIFIVE_U_DEV_L2LIM].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_ZERO,
> +                    memmap[SIFIVE_U_DEV_L2ZERO].base);
>   
>       /* create PLIC hart topology configuration string */
>       plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
> @@ -868,9 +867,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>       create_unimplemented_device("riscv.sifive.u.dmc",
>           memmap[SIFIVE_U_DEV_DMC].base, memmap[SIFIVE_U_DEV_DMC].size);
>   
> -    create_unimplemented_device("riscv.sifive.u.l2cc",
> -        memmap[SIFIVE_U_DEV_L2CC].base, memmap[SIFIVE_U_DEV_L2CC].size);
> -
>       sysbus_realize(SYS_BUS_DEVICE(&s->spi0), errp);
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi0), 0,
>                       memmap[SIFIVE_U_DEV_QSPI0].base);
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 46a499f70f..b2b816de6a 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -99,6 +99,7 @@ config SIFIVE_U
>       select CPU_CLUSTER
>       select DEVICE_TREE
>       select RISCV_ACLINT
> +    select SIFIVE_L2CC
>       select SIFIVE_GPIO
>       select SIFIVE_PDMA
>       select SIFIVE_PLIC


