Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FC5C5AD4E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 11:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsfL5-0005GP-Sf; Sat, 08 Aug 2026 07:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsfL4-0005GC-T0
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 07:35:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsfL0-0001dF-0O
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 07:35:42 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678AKGQ53694258
 for <qemu-devel@nongnu.org>; Sat, 8 Aug 2026 11:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WdrxlmJjVgfIAph4W4N9WxrzbagtBBD0X/gOBXpy/GI=; b=RFnnq6hpQ8oc5e40
 z71IPupi8XMxmDbfCqcqoIY5UIFId+HG86Azj72IRtXEo2yrMg9AsBPj49M93nQv
 ML48VLNex+NmG06DT0lGJnZkli0BGvRdxlutPSjkYsGfTzZeuw42CXSFU9CUWy6i
 +weLwp/I8Ok0kpNi6ZKuixsJrM4L90yeh8v14PX6DNiIhDD1kE2xpV31oRt1AwCm
 qgDIvatu+dgZlxmuLovSQ3LvQvg3aS7cXRZCbn5h/ti8+3aN4Cz2B2VB+J9kKRdj
 6vgy7KP86CV6WjkjKXBnBJfjO+sztVIY3vm1vIPUyDgf+sZ5V8mIr3t4lod3EU4Z
 iJOb/Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwush0syp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 11:35:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so32042085a.1
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 04:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786188933; x=1786793733; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WdrxlmJjVgfIAph4W4N9WxrzbagtBBD0X/gOBXpy/GI=;
 b=OVqFDHFj0NOjUivCboQJsfYF/T8vw6tslnJqHVAFjDSYhFCvOzxkXKtLUw9avqK85F
 ii7ST3L1A+bVi//t3LsyJtkmN6MjfwlkwOXOolpB+HbTHpy7g7P6Ua697l34seJjXggv
 zOLgTDpDksD5+yDW0CB5V2cAI8jDwzBnNi54K4s04/vMNzV5O0sf19dCrXToDeUrxRiE
 yJPh2eppRh4s8eZqhJkKGDrNkKVgPKEQpWXwSJnxcSYB6QCv+VNZmgg2ga0EezUBGBee
 Xb3PkriMzu+wkdZvFvoUwKOSnkn64v3kzTEo1ZeQ2FGGtUhfxHYfpsAo4CnECBBKECcn
 UMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786188933; x=1786793733;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WdrxlmJjVgfIAph4W4N9WxrzbagtBBD0X/gOBXpy/GI=;
 b=s6YF1xMFfTY8sf9E6772QJoOosXgtef/cHkrUw+pJnN5MO4G2WzdngEhKn/rhsg1G1
 nNLzl+QRzCQEXaOgt9/+ub5ImmSujWiu2s7BnxNMav1S5VwMwfbzL15HKIxDYP4O//dV
 tAmT3liv+oRfTzRWlKiRzjUYWSrWO1FQE1OxWRjzHrMhLAJOIn1eHZTyZx7eginQE8Jr
 t+omGki7H7Cf86VjKfiSuWqnkpJkwITmUve+m3fr1Nqg/m30BvPN3u5aM2YM6FoZuJ21
 btbalXgclLxC1i+WHTdFcREOlADJGfj0Y5qizzKcnc5a7Kz/wuTvnICga4DRYrG8Y9iH
 VH5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RprzhL/zbeYgsTdZwA9pw+sYfd2airdF2Np7E8tRb3DiEGxJbACalTtHsI7Q8k0/c0Dr/xP2eJZm1yt@nongnu.org
X-Gm-Message-State: AOJu0YxF3a62vHk8/b/5vaOWBqZTgIcpTkv3DlyGZlVOCR/a/cLi58aC
 NH+u7xIXpqQu/hxAbsFXGX/AwsiBNthyIWgDrpyQyFSNK83ln5NNvti5nXAKw1SN0Pdk/+Vvt6z
 uof5qlgKMCd2P61raFduIEBzlzoKJ1PJdmFCiPyQF47eGQO1kBhYSw8/kEg==
X-Gm-Gg: AR+sD13N7QlidaC+fYRAwL0WzRo8bWgmKZiwJ5BXp7g+KpJzok/5rhkNyJ8fxkoQpwb
 EsccGH32yd54cFgOEymRmDn7qH3rz7Xheue5Dix0CbkkXAfsIM7yNxdUWxX1QEaIPsdNbc7uCF6
 g7et2ztARpnWuUDEASaaSrBVHlmzuRR9101TsjYesJf4Y5VZdn2/mETEocy4c1P3zht7RuALbc1
 bR8xggasEQf7xJz3RP2F86cIbxr5Q3OU/ZpZCOEJr4R2vcJCGTc9SD+13EHyxlLxtJUWPEad4HC
 NK+Jp5i2lQbOjtPNm8FCnmV4WngziyGzZBLv6WTBcQBDqKDlz3tpZvY/8+SIhMTJhF9pHUcc0+c
 Sv5CTPRCvr/JAadO50c4XUJztrJ5fzFkvx0MP
X-Received: by 2002:a05:620a:1991:b0:921:ff36:3fae with SMTP id
 af79cd13be357-9367b56dd9emr426053085a.6.1786188932994; 
 Sat, 08 Aug 2026 04:35:32 -0700 (PDT)
X-Received: by 2002:a05:620a:1991:b0:921:ff36:3fae with SMTP id
 af79cd13be357-9367b56dd9emr426048085a.6.1786188932253; 
 Sat, 08 Aug 2026 04:35:32 -0700 (PDT)
Received: from [192.168.68.100] ([177.198.100.18])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e226895sm359749785a.23.2026.08.08.04.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Aug 2026 04:35:31 -0700 (PDT)
Message-ID: <ef563154-0274-468c-ad32-e156a24b8ec8@oss.qualcomm.com>
Date: Sat, 8 Aug 2026 08:35:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/char: add K230 DW 8250-compatible UART
To: WX Chen <wxchen0913@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
 <20260808-feat-k230-uart-v3-v3-1-d73b31f0034b@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260808-feat-k230-uart-v3-v3-1-d73b31f0034b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: H-l5xsxkE0n1J4vOOzqTmDlpZGFjQpN-
X-Authority-Analysis: v=2.4 cv=GvpyPE1C c=1 sm=1 tr=0 ts=6a771486 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=el0UrXJS4K3zujXh0Vdy/w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=e57ZSKXAAAAA:20 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=lNoFMfNfQlBgztPqUukA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: H-l5xsxkE0n1J4vOOzqTmDlpZGFjQpN-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDA5NyBTYWx0ZWRfX8pE0REwxNyA8
 rW4bCRbIu7kXu1OHDkH1tqlaJPBAZTzwmurkfeKa5eCRg+ChEpDlu65XrAlefnHVG98GGeU0JSC
 Q0DZyLEMnwcEmF4vBN3QeNcx6Sc2KxhTGxF1oynXNgLsqoGJjQL8Ov9ZNkS4lb2sFEE1/JZ3mb6
 nHzqHKRBfaTmjAaKOw/ICgY8m6s2EJdefB/7aYqXboIQs8dq6zgYiGc1XLnTO68Zl5jwI9MrkPf
 +YtY8V0LbGiur4kHnjEWWYXPMBGcC7gz3RYktoZKrskUINuBZdRbYeFV/rm9IcTNNQc4q415aeg
 OkapIU82Rw5ysPurypTTM2Glrfgdyj87sw3JOeEBToCUCW4xiDBKmd+ZK0O5CnKn80BKVONoTWq
 9SWDmKPk10loPMPvKXIknqd0gjE5CFTFXtV4iDeiX2viiw4xKEalFDMNyr3BM8Rk8vS+zuOfQS6
 AFjhIwKrISOzgzZmCOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDA5NyBTYWx0ZWRfX84vgktCuv9bX
 uphvboA1fn5HZp0x77qB/QjnV1PFhlIRNMysccA1GzF506oQC+r263qOVpzkYFDI/F+pDRGuqeM
 5hAU+24bPy5XlgpaSu37h9W2sKgfp30=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080097
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



On 8/7/2026 11:32 PM, WX Chen wrote:
> Implement a K230 SoC DesignWare 8250-compatible UART controller model for
> QEMU, capable of running the Linux 8250_dw driver and providing an
> interactive shell.
> 
> Implemented:
>    - Standard 16550 registers (RBR/THR/DLL, IER/DLH, IIR/FCR, LCR, MCR,
>      LSR, MSR, SCR) and DesignWare-specific registers (USR, TFL, RFL, SRR,
>      SRTS, SBCR, SDMAM, SFE, SRT, STET, HTX, CPR, UCV, CTR)
>    - DLAB switching; 32-byte TX/RX FIFO; synchronous transmit with
>      backpressure handling
>    - Loopback mode; chardev BREAK routed to LSR.BI/FE via CHR_EVENT_BREAK
>    - Four-level prioritized interrupt scheme (ELSI / RX Data / Timeout /
>      THRE), with edge-triggered THRE
>    - RX Character Timeout interrupt (IID=0xc) with 4-char-time timer that
>      tracks the programmed divisor latch
>    - Busy Detect interrupt (IID=0x7): LCR (and its shadow SBCR) writes
>      while USR.BUSY=1 are rejected and raise IID=0x7, cleared by reading
>      USR; USR.BUSY reflects TX-not-empty / RX-data-ready
>    - Shadow registers alias their underlying fields
>    - SRR (UR/RFR/XFR) self-clearing software reset
> 
> Not implemented:
>    - RS485 transceiver control (TCR/DE_EN/RE_EN/DET/TAT)
>    - 9-bit multidrop (LCR_EXT/RAR/TAR)
>    - Fractional baud rate (DLF)
>    - Auto Flow Control (MCR.AFCE)
>    - IrDA SIR mode (MCR.SIRE)
>    - Low-power divisor latch (LPDLL/LPDLH)
>    - FIFO access test mode (FAR/TFR/RFW)
>    - DMA Software Acknowledge (DMASA)
> 
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/char/Kconfig             |   3 +
>   hw/char/k230_uart.c         | 816 ++++++++++++++++++++++++++++++++++++++++++++
>   hw/char/meson.build         |   1 +
>   include/hw/char/k230_uart.h | 198 +++++++++++
>   4 files changed, 1018 insertions(+)
> 
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 020c0a84bb6e5f11cc7d532a7999ade23505a1ba..bd000f7127e7881dabac191c81b2bcf66f549250 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -91,6 +91,9 @@ config GOLDFISH_TTY
>   config SHAKTI_UART
>       bool
>   
> +config K230_UART
> +    bool
> +
>   config IP_OCTAL_232
>       bool
>       default y
> diff --git a/hw/char/k230_uart.c b/hw/char/k230_uart.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..7d83a04aaf3129f2908ea97adb805cfca9f13095
> --- /dev/null
> +++ b/hw/char/k230_uart.c
> @@ -0,0 +1,816 @@
> +/*
> + * K230 UART
> + *
> + * Copyright (c) 2026 WX Chen <wxchen0913@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/char/k230_uart.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/qdev-properties-system.h"
> +#include "migration/vmstate.h"
> +#include "qemu/module.h"
> +#include "qemu/timer.h"
> +#include "qemu/host-utils.h"
> +#include "system/memory.h"
> +
> +/* Serial clock from the K230 DT "clock-frequency" property (50 MHz). */
> +#define K230_UART_SCLK_HZ   50000000ull
> +
> +static void k230_uart_xmit(K230UartState *s);
> +static void k230_uart_update_all(K230UartState *s);
> +static uint64_t k230_uart_read_rbr(K230UartState *s);
> +static void k230_uart_push_rx_byte(K230UartState *s, uint8_t ch);
> +static void k230_uart_reset_hold(Object *obj, ResetType type);
> +
> +/* ---- interrupt line ---- */
> +
> +/*
> + * RX FIFO trigger level. When rx_count reaches this,
> + * the RX Data Available interrupt (IID=0x4) fires.
> + */
> +static uint32_t k230_uart_rx_trigger_level(const K230UartState *s)
> +{
> +    if (!FIELD_EX32(s->fcr, FCR, FIFOE)) {
> +        return 1;  /* non-FIFO mode: 1 byte */
> +    }
> +    switch (FIELD_EX32(s->fcr, FCR, RT)) {
> +    case 0:  return 1;
> +    case 1:  return K230_UART_FIFO_DEPTH / 4;
> +    case 2:  return K230_UART_FIFO_DEPTH / 2;
> +    case 3:  return K230_UART_FIFO_DEPTH - 2;
> +    default: return 1;
> +    }
> +}
> +
> +static bool k230_uart_rx_line_status_int(const K230UartState *s)
> +{
> +    return FIELD_EX32(s->ier, IER, ELSI) &&
> +        (FIELD_EX32(s->lsr, LSR, OE) || FIELD_EX32(s->lsr, LSR, PE) ||
> +         FIELD_EX32(s->lsr, LSR, FE) || FIELD_EX32(s->lsr, LSR, BI));
> +}
> +
> +static void k230_uart_update_irq(K230UartState *s)
> +{
> +    bool irq = false;
> +    uint32_t rx_itl = k230_uart_rx_trigger_level(s);
> +
> +    /* RX trigger level > 1 */
> +    if (FIELD_EX32(s->ier, IER, ERBFI) &&
> +        (s->rx_count >= rx_itl || s->timeout_ipending)) {
> +        irq = true;
> +    }
> +    /* Transmit Holding Register Empty Interrupt */
> +    if (FIELD_EX32(s->ier, IER, ETBEI) && s->thr_ipending) {
> +        irq = true;
> +    }
> +    /* Receiver Line Status Interrupt */
> +    if (k230_uart_rx_line_status_int(s)) {
> +        irq = true;
> +    }
> +    /* Busy detect interrupt (DW-specific, no IER gate). */
> +    if (s->busy_ipending) {
> +        irq = true;
> +    }
> +    qemu_set_irq(s->irq, irq ? 1 : 0);
> +}
> +
> +/* ---- FIFO reset ---- */
> +
> +static void k230_uart_fifo_reset(K230UartState *s, bool rx, bool tx)
> +{
> +    if (rx) {
> +        s->rx_head = s->rx_tail = s->rx_count = 0;
> +        s->lsr = FIELD_DP32(s->lsr, LSR, DR, 0);
> +        s->timeout_ipending = 0;
> +        timer_del(&s->rx_timeout);
> +    }
> +    if (tx) {
> +        s->tx_head = s->tx_tail = s->tx_count = 0;
> +        s->lsr = FIELD_DP32(s->lsr, LSR, THRE, 1);
> +        s->lsr = FIELD_DP32(s->lsr, LSR, TEMT, 1);
> +        s->thr_ipending = 1;
> +    }
> +    k230_uart_update_all(s);
> +}
> +
> +/* ---- transmit ---- */
> +
> +static gboolean k230_uart_chr_can_write(void *do_not_use, GIOCondition cond,
> +                                        void *opaque)
> +{
> +    K230UartState *s = K230_UART(opaque);
> +    if (!s->htx) {
> +        k230_uart_xmit(s);
> +    }
> +    return G_SOURCE_REMOVE;
> +}
> +
> +/* ---- baud / char-transmit time ---- */
> +
> +/*
> + * Recompute the per-character transmit time from the current divisor latch:
> + *
> + *   baud    = sclk / (16 * divisor)
> + *   char_ns = 10 * 16 * divisor * 1e9 / sclk     (10 = 8N1 start+data+stop)
> + *
> + * Drives the RX timeout interrupt (IID=0xc), which fires after 4 char times.
> + * divisor == 0 means "unprogrammed": keep the previous (reset default) value.
> + */
> +static void k230_uart_update_char_time(K230UartState *s)
> +{
> +    uint32_t divisor = ((uint32_t)s->dlh << 8) | s->dll;
> +    if (divisor == 0) {
> +        return;
> +    }
> +    s->char_transmit_time = muldiv64(10ull * 16 * divisor,
> +                                     NANOSECONDS_PER_SECOND,
> +                                     K230_UART_SCLK_HZ);
> +}
> +
> +/* Send all characters in THR or TX-FIFO into char backend */
> +static void k230_uart_xmit(K230UartState *s)
> +{
> +    int ret;
> +
> +    if (s->tx_count == 0 || s->htx) {
> +        return;
> +    }
> +
> +    while (s->tx_count > 0) {
> +        uint8_t ch = (uint8_t)s->tx_fifo[s->tx_tail];
> +
> +        if (FIELD_EX32(s->mcr, MCR, LOOPBACK)) {
> +            /* Go to RX fifo */
> +            k230_uart_push_rx_byte(s, ch);
> +            ret = 1;
> +        } else {
> +            /* Go to char backend */
> +            ret = qemu_chr_fe_write(&s->chr, &ch, 1);
> +        }
> +        if (ret < 0) {
> +            /* Wait for backend to be accessible then call the callback */
> +            qemu_chr_fe_add_watch(&s->chr, G_IO_OUT,
> +                                  k230_uart_chr_can_write, s);
> +            break;
> +        }
> +
> +        s->tx_tail = (s->tx_tail + 1) % K230_UART_FIFO_DEPTH;
> +        s->tx_count--;
> +    }
> +
> +    s->lsr = FIELD_DP32(s->lsr, LSR, TEMT, (s->tx_count == 0) ? 1 : 0);
> +    k230_uart_update_all(s);
> +}
> +
> +/* ---- RX timeout ---- */
> +
> +/* Character timeout callback */
> +static void k230_uart_rx_timeout(void *opaque)
> +{
> +    K230UartState *s = K230_UART(opaque);
> +    if (s->rx_count > 0) {
> +        s->timeout_ipending = 1;
> +        k230_uart_update_all(s);
> +    }
> +}
> +
> +/* ---- receive ---- */
> +
> +/* Push a byte to rxfifo(when FIFO_EN is set) or RBR(FIFO_EN not set). */
> +static void k230_uart_push_rx_byte(K230UartState *s, uint8_t ch)
> +{
> +    bool fifo_en = FIELD_EX32(s->fcr, FCR, FIFOE);
> +    uint16_t capacity = fifo_en ? K230_UART_FIFO_DEPTH : 1;
> +
> +    if (s->rx_count < capacity) {
> +        s->rx_fifo[s->rx_head] = ch;
> +        s->rx_head = (s->rx_head + 1) % K230_UART_FIFO_DEPTH;
> +        s->rx_count++;
> +        s->lsr = FIELD_DP32(s->lsr, LSR, DR, 1);
> +        timer_mod(&s->rx_timeout,
> +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
> +                  + 4 * s->char_transmit_time);
> +    } else {
> +        s->lsr = FIELD_DP32(s->lsr, LSR, OE, 1);
> +    }
> +    k230_uart_update_all(s);
> +}
> +
> +/* ---- derived register recomputation ---- */
> +
> +static void k230_uart_update_thre(K230UartState *s)
> +{
> +    bool should_set = (s->tx_count == 0);
> +    if (FIELD_EX32(s->ier, IER, PTIME)
> +        && FIELD_EX32(s->fcr, FCR, FIFOE)) {
> +        uint8_t tet = FIELD_EX32(s->fcr, FCR, TET);
> +        uint16_t threshold;
> +        switch (tet) {
> +        case 0x0:
> +            threshold = 0;
> +            break;
> +        case 0x1:
> +            threshold = 2;
> +            break;
> +        case 0x2:
> +            threshold = K230_UART_FIFO_DEPTH / 4;
> +            break;
> +        case 0x3:
> +            threshold = K230_UART_FIFO_DEPTH / 2;
> +            break;
> +        default:
> +            threshold = 0;
> +            break;
> +        }
> +        should_set = (s->tx_count <= threshold);
> +    }
> +
> +    uint8_t old_thre = FIELD_EX32(s->lsr, LSR, THRE);
> +    s->lsr = FIELD_DP32(s->lsr, LSR, THRE, should_set ? 1 : 0);
> +
> +    /* Edge trigger */
> +    if (should_set && !old_thre) {
> +        s->thr_ipending = 1;
> +    }
> +}
> +
> +static bool k230_uart_is_busy(const K230UartState *s)
> +{
> +    return !FIELD_EX32(s->lsr, LSR, TEMT) || FIELD_EX32(s->lsr, LSR, DR);
> +}
> +
> +static void k230_uart_update_usr(K230UartState *s)
> +{
> +    bool fifo_en = FIELD_EX32(s->fcr, FCR, FIFOE);
> +    uint16_t capacity = fifo_en ? K230_UART_FIFO_DEPTH : 1;
> +
> +    s->usr = 0;
> +    if (k230_uart_is_busy(s)) {
> +        s->usr = FIELD_DP32(s->usr, USR, BUSY, 1);
> +    }
> +    s->usr = FIELD_DP32(s->usr, USR, TFNF, s->tx_count < capacity ? 1 : 0);
> +    s->usr = FIELD_DP32(s->usr, USR, TFE, s->tx_count == 0 ? 1 : 0);
> +    s->usr = FIELD_DP32(s->usr, USR, RFNE, s->rx_count != 0 ? 1 : 0);
> +    s->usr = FIELD_DP32(s->usr, USR, RFF, s->rx_count == capacity ? 1 : 0);
> +}
> +
> +static void k230_uart_update_iir(K230UartState *s)
> +{
> +    s->iir = 0;
> +    /* Indicate whether FIFO is enabled or not */
> +    if (FIELD_EX32(s->fcr, FCR, FIFOE)) {
> +        s->iir = FIELD_DP32(s->iir, IIR, FIFOSE, 0x3);
> +    }
> +
> +    if (k230_uart_rx_line_status_int(s)) {
> +        /* Receiver Line Status Interrupt */
> +        s->iir = FIELD_DP32(s->iir, IIR, IID, 0x6);
> +    } else if (FIELD_EX32(s->ier, IER, ERBFI) &&
> +               (s->rx_count >= k230_uart_rx_trigger_level(s))) {
> +        /* Receiver Data Available Interrupt */
> +        s->iir = FIELD_DP32(s->iir, IIR, IID, 0x4);
> +    } else if (FIELD_EX32(s->ier, IER, ERBFI) && s->timeout_ipending) {
> +        /* Character timeout interrupt */
> +        s->iir = FIELD_DP32(s->iir, IIR, IID, 0xc);
> +    } else if (FIELD_EX32(s->ier, IER, ETBEI) && s->thr_ipending) {
> +        /* THR Empty Interrupt */
> +        s->iir = FIELD_DP32(s->iir, IIR, IID, 0x2);
> +    } else if (s->busy_ipending) {
> +        /* Busy detect: LCR written while USR.BUSY=1 (DW-specific) */
> +        s->iir = FIELD_DP32(s->iir, IIR, IID, 0x7);
> +    } else {
> +        s->iir = FIELD_DP32(s->iir, IIR, IID, 0x1);
> +    }
> +}
> +
> +
> +static void k230_uart_update_msr(K230UartState *s)
> +{
> +    uint8_t old_status = s->msr & 0xf0;
> +    uint8_t new_status;
> +
> +    if (FIELD_EX32(s->mcr, MCR, LOOPBACK)) {
> +        /*
> +         * Standard 16550 loopback mapping:
> +         * DTR -> DSR, RTS -> CTS, OUT1 -> RI, OUT2 -> DCD
> +         */
> +        new_status = 0;
> +        if (FIELD_EX32(s->mcr, MCR, RTS)) {
> +            new_status |= 0x10; /* CTS */
> +        }
> +        if (FIELD_EX32(s->mcr, MCR, DTR)) {
> +            new_status |= 0x20; /* DSR */
> +        }
> +        if (FIELD_EX32(s->mcr, MCR, OUT1)) {
> +            new_status |= 0x40; /* RI  */
> +        }
> +        if (FIELD_EX32(s->mcr, MCR, OUT2)) {
> +            new_status |= 0x80; /* DCD */
> +        }
> +    } else {
> +        /* No real modem: report CTS/DSR/DCD as active (ready) */
> +        new_status = 0xb0; /* CTS | DSR | DCD */
> +    }
> +
> +    /* Accumulate delta bits on status changes */
> +    uint8_t deltas = s->msr & 0x0f;
> +    uint8_t changes = old_status ^ new_status;
> +    if (changes & 0x10) {
> +        deltas |= 0x01; /* DCTS */
> +    }
> +    if (changes & 0x20) {
> +        deltas |= 0x02; /* DDSR */
> +    }
> +    if ((old_status & 0x40) && !(new_status & 0x40)) {
> +        deltas |= 0x04; /* TERI */
> +    }
> +    if (changes & 0x80) {
> +        deltas |= 0x08; /* DDCD */
> +    }
> +
> +    s->msr = new_status | deltas;
> +}
> +
> +static void k230_uart_update_all(K230UartState *s)
> +{
> +    k230_uart_update_thre(s);
> +    k230_uart_update_usr(s);
> +    k230_uart_update_iir(s);
> +    k230_uart_update_irq(s);
> +}
> +
> +/* ---- MMIO read ---- */
> +
> +static uint64_t k230_uart_read_rbr(K230UartState *s)
> +{
> +    uint64_t ret = 0;
> +
> +    if (s->rx_count > 0) {
> +        ret = s->rx_fifo[s->rx_tail];
> +        s->rx_tail = (s->rx_tail + 1) % K230_UART_FIFO_DEPTH;
> +        s->rx_count--;
> +        s->timeout_ipending = 0;
> +        if (s->rx_count == 0) {
> +            s->lsr = FIELD_DP32(s->lsr, LSR, DR, 0);
> +            timer_del(&s->rx_timeout);
> +        } else {
> +            timer_mod(&s->rx_timeout,
> +                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
> +                      + 4 * s->char_transmit_time);
> +        }
> +        qemu_chr_fe_accept_input(&s->chr);
> +    }
> +
> +    if (!FIELD_EX32(s->ier, IER, ELCOLR)) {
> +        s->lsr = FIELD_DP32(s->lsr, LSR, OE, 0);
> +        s->lsr = FIELD_DP32(s->lsr, LSR, PE, 0);
> +        s->lsr = FIELD_DP32(s->lsr, LSR, FE, 0);
> +        s->lsr = FIELD_DP32(s->lsr, LSR, BI, 0);
> +    }
> +
> +    k230_uart_update_all(s);
> +    return ret;
> +}
> +
> +static uint64_t k230_uart_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    K230UartState *s = K230_UART(opaque);
> +    uint64_t ret = 0;
> +
> +    switch (addr >> 2) {
> +    case R_RBR_DLL_THR:
> +        if (FIELD_EX32(s->lcr, LCR, DLAB)) {
> +            /* DLL accessible only when not busy. */
> +            ret = !k230_uart_is_busy(s) ? s->dll : 0;
> +        } else {
> +            ret = k230_uart_read_rbr(s);
> +        }
> +        break;
> +    case R_IER_DLH:
> +        if (FIELD_EX32(s->lcr, LCR, DLAB)) {
> +            /* DLH accessible only when not busy. */
> +            ret = !k230_uart_is_busy(s) ? s->dlh : 0;
> +        } else {
> +            /* IER */
> +            ret = s->ier;
> +        }
> +        break;
> +    case R_IIR:
> +        ret = s->iir;
> +        if (FIELD_EX32(s->iir, IIR, IID) == 0x2) {
> +            s->thr_ipending = 0;
> +            k230_uart_update_all(s);
> +        }
> +        break;
> +    case R_LCR:
> +        ret = s->lcr;
> +        break;
> +    case R_LSR:
> +        ret = s->lsr;
> +        /* Clear OE PE FE and Break Interrupt status bits */
> +        s->lsr = FIELD_DP32(s->lsr, LSR, OE, 0);
> +        s->lsr = FIELD_DP32(s->lsr, LSR, PE, 0);
> +        s->lsr = FIELD_DP32(s->lsr, LSR, FE, 0);
> +        s->lsr = FIELD_DP32(s->lsr, LSR, BI, 0);
> +        k230_uart_update_all(s);
> +        break;
> +    case R_MCR:
> +        ret = s->mcr;
> +        break;
> +    case R_MSR:
> +        ret = s->msr;
> +        s->msr &= 0xf0; /* clear delta bits on read */
> +        break;
> +    case R_SCR:
> +        ret = s->scr;
> +        break;
> +
> +    /* Shadow registers: aliases of standard registers. */
> +    case R_SRTS:
> +        ret = FIELD_EX32(s->mcr, MCR, RTS);
> +        break;
> +    case R_SBCR:
> +        ret = FIELD_EX32(s->lcr, LCR, BC);
> +        break;
> +    case R_SDMAM:
> +        ret = FIELD_EX32(s->fcr, FCR, DMAM);
> +        break;
> +    case R_SFE:
> +        ret = FIELD_EX32(s->fcr, FCR, FIFOE);
> +        break;
> +    case R_SRT:
> +        ret = FIELD_EX32(s->fcr, FCR, RT);
> +        break;
> +    case R_STET:
> +        ret = FIELD_EX32(s->fcr, FCR, TET);
> +        break;
> +    case R_HTX:
> +        ret = s->htx;
> +        break;
> +
> +    case R_CPR:
> +        ret = K230_UART_R_CPR;
> +        break;
> +    case R_UCV:
> +        ret = K230_UART_R_UCV;
> +        break;
> +    case R_DLF:
> +        ret = 0;
> +        break;
> +    case R_USR:
> +        ret = s->usr;
> +        /* Reading USR clears the busy-detect interrupt. */
> +        if (s->busy_ipending) {
> +            s->busy_ipending = 0;
> +            k230_uart_update_all(s);
> +        }
> +        break;
> +    case R_TFL:
> +        /* Transmit FIFO Level: number of bytes in TX FIFO. */
> +        ret = s->tx_count;
> +        break;
> +    case R_RFL:
> +        /* Receive FIFO Level: number of bytes in RX FIFO. */
> +        ret = s->rx_count;
> +        break;
> +    case R_CTR:
> +        /* Component Type Register: fixed ID. */
> +        ret = K230_UART_CTR_VALUE;
> +        break;
> +    default:
> +        ret = 0;
> +        break;
> +    }
> +    return ret;
> +}
> +
> +/* ---- MMIO write ---- */
> +
> +static void k230_uart_write(void *opaque, hwaddr addr,
> +                                uint64_t val64, unsigned int size)
> +{
> +    K230UartState *s = K230_UART(opaque);
> +    uint32_t val = (uint32_t)val64;
> +    uint32_t offset = addr >> 2;
> +
> +    switch (offset) {
> +    case R_RBR_DLL_THR:
> +        if (FIELD_EX32(s->lcr, LCR, DLAB)) {
> +            /* DLL writable only when not busy. */
> +            if (!k230_uart_is_busy(s)) {
> +                s->dll = val & 0xff;
> +                k230_uart_update_char_time(s);
> +            }
> +        } else {
> +            bool fifo_en = FIELD_EX32(s->fcr, FCR, FIFOE);
> +            uint16_t capacity = fifo_en ? K230_UART_FIFO_DEPTH : 1;
> +            if (s->tx_count < capacity) {
> +                s->tx_fifo[s->tx_head] = val & 0xff;
> +                s->tx_head = (s->tx_head + 1) % K230_UART_FIFO_DEPTH;
> +                s->tx_count++;
> +            } else if (!fifo_en) {
> +                s->tx_fifo[s->tx_tail] = val & 0xff;
> +            }
> +            s->lsr = FIELD_DP32(s->lsr, LSR, THRE, 0);
> +            s->thr_ipending = 0;
> +            s->lsr = FIELD_DP32(s->lsr, LSR, TEMT, 0);
> +            k230_uart_xmit(s);
> +        }
> +        break;
> +    case R_IER_DLH:
> +        if (FIELD_EX32(s->lcr, LCR, DLAB)) {
> +            /* DLH writable only when not busy. */
> +            if (!k230_uart_is_busy(s)) {
> +                s->dlh = val & 0xff;
> +                k230_uart_update_char_time(s);
> +            }
> +        } else {
> +            uint8_t old_etbei = FIELD_EX32(s->ier, IER, ETBEI);
> +            s->ier = FIELD_DP32(s->ier, IER, ERBFI,
> +                                FIELD_EX32(val, IER, ERBFI));
> +            s->ier = FIELD_DP32(s->ier, IER, ETBEI,
> +                                FIELD_EX32(val, IER, ETBEI));
> +            s->ier = FIELD_DP32(s->ier, IER, ELSI,
> +                                FIELD_EX32(val, IER, ELSI));
> +            s->ier = FIELD_DP32(s->ier, IER, EDSSI,
> +                                FIELD_EX32(val, IER, EDSSI));
> +            s->ier = FIELD_DP32(s->ier, IER, ELCOLR,
> +                                FIELD_EX32(val, IER, ELCOLR));
> +            s->ier = FIELD_DP32(s->ier, IER, PTIME,
> +                                FIELD_EX32(val, IER, PTIME));
> +            if (!old_etbei && FIELD_EX32(s->ier, IER, ETBEI)
> +                && FIELD_EX32(s->lsr, LSR, THRE)) {
> +                s->thr_ipending = 1;
> +            }
> +        }
> +        break;
> +    case R_FCR:
> +        if ((val ^ s->fcr) & R_FCR_FIFOE_MASK) {
> +            val |= R_FCR_RFIFOR_MASK | R_FCR_XFIFOR_MASK;
> +        }
> +        s->fcr = FIELD_DP32(s->fcr, FCR, FIFOE,
> +                            FIELD_EX32(val, FCR, FIFOE));
> +        s->fcr = FIELD_DP32(s->fcr, FCR, DMAM,
> +                            FIELD_EX32(val, FCR, DMAM));
> +        s->fcr = FIELD_DP32(s->fcr, FCR, RT,
> +                            FIELD_EX32(val, FCR, RT));
> +        s->fcr = FIELD_DP32(s->fcr, FCR, TET,
> +                            FIELD_EX32(val, FCR, TET));
> +        if (FIELD_EX32(val, FCR, RFIFOR)) {
> +            k230_uart_fifo_reset(s, true, false);
> +        }
> +        if (FIELD_EX32(val, FCR, XFIFOR)) {
> +            k230_uart_fifo_reset(s, false, true);
> +        }
> +        break;
> +    case R_LCR:
> +        /*
> +         * LCR is writable only when USR.BUSY == 0.  A write while busy is
> +         * ignored and triggers the busy-detect interrupt (IID=0x7), which is
> +         * cleared by reading USR.  The 8250_dw driver detects this via
> +         * dw8250_check_lcr() and retries after draining the FIFOs.
> +         */
> +        if (k230_uart_is_busy(s)) {
> +            s->busy_ipending = 1;
> +        } else {
> +            s->lcr = val & 0xff;
> +        }
> +        break;
> +    case R_MCR:
> +        /*
> +         * K230 advertises AFCE_MODE=0 and SIR_MODE=0 in CPR, so MCR[5:6]
> +         * (AFCE/SIRE) are read-only 0.  MCR[7] is reserved and also 0.
> +         */
> +        s->mcr = val & 0x1f;
> +        k230_uart_update_msr(s);
> +        break;
> +    case R_SCR:
> +        s->scr = val & 0xff;
> +        break;
> +
> +    /*
> +     * Shadow registers: aliases of standard register fields.
> +     * They let software update a single bit without read-modify-write on the
> +     * original register.  SBCR shadows LCR[6] (BC), which is gated by the
> +     * busy-detect logic just like a direct LCR write.
> +     */
> +    case R_SRTS:
> +        s->mcr = FIELD_DP32(s->mcr, MCR, RTS, val & 0x1);
> +        k230_uart_update_msr(s);
> +        break;
> +    case R_SBCR:
> +        if (k230_uart_is_busy(s)) {
> +            s->busy_ipending = 1;
> +        } else {
> +            s->lcr = FIELD_DP32(s->lcr, LCR, BC, val & 0x1);
> +        }
> +        break;
> +    case R_SDMAM:
> +        s->fcr = FIELD_DP32(s->fcr, FCR, DMAM, val & 0x1);
> +        break;
> +    case R_SFE:
> +        /* Shadow of FCR[0]; changing FIFOE resets both FIFOs */
> +        if ((s->fcr ^ val) & R_FCR_FIFOE_MASK) {
> +            k230_uart_fifo_reset(s, true, true);
> +        }
> +        s->fcr = FIELD_DP32(s->fcr, FCR, FIFOE, val & 0x1);
> +        break;
> +    case R_SRT:
> +        s->fcr = FIELD_DP32(s->fcr, FCR, RT, val & 0x3);
> +        break;
> +    case R_STET:
> +        s->fcr = FIELD_DP32(s->fcr, FCR, TET, val & 0x3);
> +        break;
> +    case R_HTX:
> +        s->htx = val & 0x1;
> +        /* Clearing HTX resumes transmission of any buffered TX data. */
> +        if (!s->htx) {
> +            k230_uart_xmit(s);
> +        }
> +        break;
> +
> +    case R_SRR:
> +        if (FIELD_EX32(val, SRR, UR)) {
> +            device_cold_reset(DEVICE(s));
> +            return;
> +        }
> +        if (FIELD_EX32(val, SRR, RFR)) {
> +            k230_uart_fifo_reset(s, true, false);
> +        }
> +        if (FIELD_EX32(val, SRR, XFR)) {
> +            k230_uart_fifo_reset(s, false, true);
> +        }
> +        break;
> +
> +    default:
> +        break;
> +    }
> +    k230_uart_update_all(s);
> +}
> +
> +/* ---- device lifecycle ---- */
> +
> +static const MemoryRegionOps k230_uart_ops = {
> +    .read = k230_uart_read,
> +    .write = k230_uart_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl.min_access_size = 4,
> +    .impl.max_access_size = 4,
> +};
> +
> +static void k230_uart_init(Object *obj)
> +{
> +    K230UartState *s = K230_UART(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &k230_uart_ops, s,
> +                          TYPE_K230_UART, 0x100);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +static int k230_uart_can_receive(void *opaque)
> +{
> +    K230UartState *s = K230_UART(opaque);
> +    return K230_UART_FIFO_DEPTH - s->rx_count;
> +}
> +
> +static void k230_uart_receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    K230UartState *s = K230_UART(opaque);
> +    for (int i = 0; i < size; i++) {
> +        k230_uart_push_rx_byte(s, buf[i]);
> +    }
> +}
> +
> +static void k230_uart_event(void *opaque, QEMUChrEvent event)
> +{
> +    K230UartState *s = K230_UART(opaque);
> +
> +    if (event == CHR_EVENT_BREAK) {
> +        k230_uart_push_rx_byte(s, 0);
> +        s->lsr = FIELD_DP32(s->lsr, LSR, BI, 1);
> +        s->lsr = FIELD_DP32(s->lsr, LSR, FE, 1);
> +        k230_uart_update_all(s);
> +    }
> +}
> +
> +static void k230_uart_reset_hold(Object *obj, ResetType type)
> +{
> +    K230UartState *s = K230_UART(obj);
> +    s->lcr = 0;
> +    s->fcr = 0;
> +    s->ier = 0;
> +    s->mcr = 0;
> +    s->scr = 0;
> +    s->dll = 0;
> +    s->dlh = 0;
> +    s->lsr = 0x60;
> +    s->msr = 0xb0;
> +
> +    s->rx_head = s->rx_tail = s->rx_count = 0;
> +    s->tx_head = s->tx_tail = s->tx_count = 0;
> +    s->htx = 0;
> +
> +    qemu_set_irq(s->irq, 0);
> +
> +    s->thr_ipending = 0;
> +    s->timeout_ipending = 0;
> +    s->busy_ipending = 0;
> +    timer_del(&s->rx_timeout);
> +    /* Default to 115200 baud until the driver programs the divisor latch. */
> +    s->char_transmit_time = (NANOSECONDS_PER_SECOND / 115200) * 10;
> +
> +    k230_uart_update_all(s);
> +}
> +
> +static void k230_uart_realize(DeviceState *dev, Error **errp)
> +{
> +    K230UartState *s = K230_UART(dev);
> +    qemu_chr_fe_set_handlers(&s->chr, k230_uart_can_receive,
> +                             k230_uart_receive, k230_uart_event,
> +                             NULL, s, NULL, true);
> +
> +    timer_init_ns(&s->rx_timeout, QEMU_CLOCK_VIRTUAL,
> +                  k230_uart_rx_timeout, s);
> +}
> +
> +static int k230_uart_post_load(void *opaque, int version_id)
> +{
> +    K230UartState *s = K230_UART(opaque);
> +
> +    /*
> +     * iir and usr are derived from the saved state; recompute them after
> +     * migration so the device is consistent.
> +     */
> +    k230_uart_update_all(s);
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_k230_uart = {
> +    .name = "k230.uart",
> +    .version_id = 2,
> +    .minimum_version_id = 1,
> +    .post_load = k230_uart_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8(lcr,   K230UartState),
> +        VMSTATE_UINT8(fcr,   K230UartState),
> +        VMSTATE_UINT8(ier,   K230UartState),
> +        VMSTATE_UINT8(dll,   K230UartState),
> +        VMSTATE_UINT8(dlh,   K230UartState),
> +        VMSTATE_UINT8(mcr,   K230UartState),
> +        VMSTATE_UINT8(lsr,   K230UartState),
> +        VMSTATE_UINT8(msr,   K230UartState),
> +        VMSTATE_UINT8(scr,   K230UartState),
> +        VMSTATE_UINT8(htx,   K230UartState),
> +        VMSTATE_UINT16_ARRAY(rx_fifo, K230UartState,
> +                             K230_UART_FIFO_DEPTH),
> +        VMSTATE_UINT16_ARRAY(tx_fifo, K230UartState,
> +                             K230_UART_FIFO_DEPTH),
> +        VMSTATE_UINT32(rx_head, K230UartState),
> +        VMSTATE_UINT32(rx_tail, K230UartState),
> +        VMSTATE_UINT32(rx_count, K230UartState),
> +        VMSTATE_UINT32(tx_head, K230UartState),
> +        VMSTATE_UINT32(tx_tail, K230UartState),
> +        VMSTATE_UINT32(tx_count, K230UartState),
> +        VMSTATE_UINT8(thr_ipending, K230UartState),
> +        VMSTATE_UINT8(timeout_ipending, K230UartState),
> +        VMSTATE_UINT8(busy_ipending, K230UartState),
> +        VMSTATE_UINT64(char_transmit_time, K230UartState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const Property k230_uart_properties[] = {
> +    DEFINE_PROP_CHR("chardev", K230UartState, chr),
> +};
> +
> +static void k230_uart_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = k230_uart_realize;
> +    rc->phases.hold = k230_uart_reset_hold;
> +    dc->vmsd = &vmstate_k230_uart;
> +    dc->desc = "K230 UART (16550-compatible)";
> +    device_class_set_props(dc, k230_uart_properties);
> +}
> +
> +static const TypeInfo k230_uart_info = {
> +    .name = TYPE_K230_UART,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230UartState),
> +    .instance_init = k230_uart_init,
> +    .class_init = k230_uart_class_init
> +};
> +
> +static void k230_uart_register_types(void)
> +{
> +    type_register_static(&k230_uart_info);
> +}
> +
> +type_init(k230_uart_register_types)
> diff --git a/hw/char/meson.build b/hw/char/meson.build
> index fc3d7ee506fcf8eb1219f6af9689fd90573861c9..23d8ede3f031f80d1b519bf49beac9d23502e2cb 100644
> --- a/hw/char/meson.build
> +++ b/hw/char/meson.build
> @@ -38,6 +38,7 @@ system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_usart.c'
>   system_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
>   system_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
>   system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
> +system_ss.add(when: 'CONFIG_K230', if_true: files('k230_uart.c'))
>   
>   specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
>   specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
> diff --git a/include/hw/char/k230_uart.h b/include/hw/char/k230_uart.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..049dcd341d3e81c861ce50bf68195d3c0e12cb40
> --- /dev/null
> +++ b/include/hw/char/k230_uart.h
> @@ -0,0 +1,198 @@
> +/*
> + * K230 UART device
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * Register semantics cross-checked against the SDK Linux driver
> + * src/little/linux/drivers/tty/serial/8250/8250_dw.c in
> + * https://github.com/kendryte/k230_sdk (compatible "snps,dw-apb-uart").
> + *
> + * Copyright (c) 2026 WX Chen <wxchen0913@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_K230_UART_H
> +#define HW_K230_UART_H
> +
> +#include "hw/core/sysbus.h"
> +#include "chardev/char-fe.h"
> +#include "hw/core/registerfields.h"
> +#include "qom/object.h"
> +
> +REG32(RBR_DLL_THR, 0x00)
> +REG32(IER_DLH, 0x04)
> +REG32(IER, 0x04)
> +    FIELD(IER, ERBFI, 0, 1)
> +    FIELD(IER, ETBEI, 1, 1)
> +    FIELD(IER, ELSI, 2, 1)
> +    FIELD(IER, EDSSI, 3, 1)
> +    FIELD(IER, ELCOLR, 4, 1)
> +    FIELD(IER, PTIME, 7, 1)
> +REG32(FCR, 0x08)
> +    FIELD(FCR, FIFOE, 0, 1)
> +    FIELD(FCR, RFIFOR, 1, 1)
> +    FIELD(FCR, XFIFOR, 2, 1)
> +    FIELD(FCR, DMAM, 3, 1)
> +    FIELD(FCR, TET, 4, 2)
> +    FIELD(FCR, RT, 6, 2)
> +REG32(IIR, 0x08)
> +    FIELD(IIR, IID, 0, 4)
> +    FIELD(IIR, FIFOSE, 6, 2)
> +REG32(LCR, 0x0c)
> +    FIELD(LCR, DLS, 0, 2)
> +    FIELD(LCR, STOP, 2, 1)
> +    FIELD(LCR, PEN, 3, 1)
> +    FIELD(LCR, EPS, 4, 1)
> +    FIELD(LCR, SP, 5, 1)
> +    FIELD(LCR, BC, 6, 1)
> +    FIELD(LCR, DLAB, 7, 1)
> +REG32(MCR, 0x10)
> +    FIELD(MCR, DTR, 0, 1)
> +    FIELD(MCR, RTS, 1, 1)
> +    FIELD(MCR, OUT1, 2, 1)
> +    FIELD(MCR, OUT2, 3, 1)
> +    FIELD(MCR, LOOPBACK, 4, 1)
> +    FIELD(MCR, AFCE, 5, 1)
> +    FIELD(MCR, SIRE, 6, 1)
> +REG32(LSR, 0x14)
> +    FIELD(LSR, DR, 0, 1)
> +    FIELD(LSR, OE, 1, 1)
> +    FIELD(LSR, PE, 2, 1)
> +    FIELD(LSR, FE, 3, 1)
> +    FIELD(LSR, BI, 4, 1)
> +    FIELD(LSR, THRE, 5, 1)
> +    FIELD(LSR, TEMT, 6, 1)
> +    FIELD(LSR, RFE, 7, 1)
> +    FIELD(LSR, ADDR_RSVD, 8, 1)
> +REG32(MSR, 0x18)
> +    FIELD(MSR, DCTS, 0, 1)
> +    FIELD(MSR, DDSR, 1, 1)
> +    FIELD(MSR, TERI, 2, 1)
> +    FIELD(MSR, DDCD, 3, 1)
> +    FIELD(MSR, CTS, 4, 1)
> +    FIELD(MSR, DSR, 5, 1)
> +    FIELD(MSR, RI, 6, 1)
> +    FIELD(MSR, DCD, 7, 1)
> +REG32(RFW, 0x78)
> +    FIELD(RFW, RFWD, 0, 8)
> +    FIELD(RFW, RFPE, 8, 1)
> +    FIELD(RFW, RFFE, 9, 1)
> +REG32(USR, 0x7c)
> +    FIELD(USR, BUSY, 0, 1)
> +    FIELD(USR, TFNF, 1, 1)
> +    FIELD(USR, TFE, 2, 1)
> +    FIELD(USR, RFNE, 3, 1)
> +    FIELD(USR, RFF, 4, 1)
> +REG32(TFL, 0x80)
> +    FIELD(TFL, TFL, 0, 5)
> +REG32(RFL, 0x84)
> +    FIELD(RFL, RFL, 0, 5)
> +REG32(SRR, 0x88)
> +    FIELD(SRR, UR, 0, 1)
> +    FIELD(SRR, RFR, 1, 1)
> +    FIELD(SRR, XFR, 2, 1)
> +REG32(SRTS, 0x8c)
> +    FIELD(SRTS, SRTS, 0, 1)
> +REG32(SBCR, 0x90)
> +    FIELD(SBCR, SBCB, 0, 1)
> +REG32(SDMAM, 0x94)
> +    FIELD(SDMAM, SDMAM, 0, 1)
> +REG32(SFE, 0x98)
> +    FIELD(SFE, SFE, 0, 1)
> +REG32(SRT, 0x9c)
> +    FIELD(SRT, SRT, 0, 2)
> +REG32(STET, 0xa0)
> +    FIELD(STET, STET, 0, 2)
> +REG32(HTX, 0xa4)
> +    FIELD(HTX, HTX, 0, 1)
> +REG32(TCR, 0xac)
> +    FIELD(TCR, RS485_EN, 0, 1)
> +    FIELD(TCR, RE_POL, 1, 1)
> +    FIELD(TCR, DE_POL, 2, 1)
> +    FIELD(TCR, XFER_MODE, 3, 2)
> +REG32(SCR, 0x1c)
> +REG32(DLF, 0xc0)
> +REG32(CPR, 0xf4)
> +REG32(UCV, 0xf8)
> +REG32(CTR, 0xfc)
> +
> +/* peripheral ID 0x44570110 ("DW\x01\x10").  Read-only. */
> +#define K230_UART_CTR_VALUE  0x44570110u
> +#define K230_UART_16550_COMPATIBLE    0
> +#define K230_UART_FIFO_DEPTH          32
> +
> +/* CPR */
> +#define K230_UART_APB_DATA_WIDTH      2      /* CPR[1:0]  - 32-bit APB       */
> +#define K230_UART_AFCE_MODE           0      /* CPR[4]    - not implemented */
> +#define K230_UART_THRE_MODE           1      /* CPR[5]    - implemented     */
> +#define K230_UART_SIR_MODE            0      /* CPR[6]    - not implemented */
> +#define K230_UART_SIR_LP_MODE         0      /* CPR[7]    - not implemented */
> +#define K230_UART_ADDITIONAL_FEATURES 1      /* CPR[8]    - UCV/CTR present */
> +#define K230_UART_FIFO_ACCESS         0      /* CPR[9]    - not implemented */
> +#define K230_UART_FIFO_STAT           1      /* CPR[10]   - TFL/RFL present */
> +#define K230_UART_SHADOW              1      /* CPR[11]   - shadow regs     */
> +#define K230_UART_ADD_ENCODED_PARAMS  1      /* CPR[12]   - CPR present     */
> +#define K230_UART_DMA_EXTRA           0      /* CPR[13]   - not implemented */
> +#define K230_UART_FIFO_MODE           0x2    /* CPR[23:16] - 32-byte FIFO   */
> +
> +/* CPR read-only value, assembled from the fields above. */
> +#define K230_UART_R_CPR \
> +    ((uint32_t)(K230_UART_APB_DATA_WIDTH          << 0)   | \
> +                 (K230_UART_AFCE_MODE               << 4)  | \
> +                 (K230_UART_THRE_MODE               << 5)  | \
> +                 (K230_UART_SIR_MODE                << 6)  | \
> +                 (K230_UART_SIR_LP_MODE             << 7)  | \
> +                 (K230_UART_ADDITIONAL_FEATURES     << 8)  | \
> +                 (K230_UART_FIFO_ACCESS             << 9)  | \
> +                 (K230_UART_FIFO_STAT               << 10) | \
> +                 (K230_UART_SHADOW                  << 11) | \
> +                 (K230_UART_ADD_ENCODED_PARAMS      << 12) | \
> +                 (K230_UART_DMA_EXTRA               << 13) | \
> +                 (K230_UART_FIFO_MODE               << 16))
> +
> +/* UCV: ASCII "4.0a" = 0x34 0x2e 0x30 0x61 */
> +#define K230_UART_R_UCV  0x342e3061u
> +
> +#define TYPE_K230_UART "k230-uart"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230UartState, K230_UART)
> +struct K230UartState {
> +    SysBusDevice parent_obj;
> +    MemoryRegion mmio;
> +
> +    /* Standard 16550 registers */
> +    uint8_t  dll;       /* Divisor Latch Low,               offset 0x00 */
> +    uint8_t  ier;       /* Interrupt Enable,                offset 0x04 */
> +    uint8_t  dlh;       /* Divisor Latch High,              offset 0x04 */
> +    uint8_t  fcr;       /* FIFO Control,                    offset 0x08 */
> +    uint8_t  iir;       /* Interrupt Identification,        offset 0x08 */
> +    uint8_t  lcr;       /* Line Control,                    offset 0x0c */
> +    uint8_t  mcr;       /* Modem Control,                   offset 0x10 */
> +    uint8_t  lsr;       /* Line Status,                     offset 0x14 */
> +    uint8_t  msr;       /* Modem Status,                    offset 0x18 */
> +    uint8_t  scr;       /* Scratchpad,                      offset 0x1c */
> +
> +    /* DesignWare-specific registers */
> +    uint8_t  usr;       /* UART Status,                     offset 0x7c */
> +    uint8_t  htx;       /* Halt TX,                         offset 0xa4 */
> +
> +    /* Internal interrupt state. */
> +    uint8_t  thr_ipending;       /* THR empty (IID=0x2) pending     */
> +    uint8_t  timeout_ipending;   /* RX FIFO timeout (IID=0xc)       */
> +    uint8_t  busy_ipending;      /* busy detect (IID=0x7) pending   */
> +
> +    /* FIFO */
> +    uint16_t rx_fifo[K230_UART_FIFO_DEPTH];
> +    uint32_t rx_head, rx_tail, rx_count;
> +    uint16_t tx_fifo[K230_UART_FIFO_DEPTH];
> +    uint32_t tx_head, tx_tail, tx_count;
> +
> +    uint64_t char_transmit_time;
> +
> +    CharFrontend chr;
> +    qemu_irq    irq;
> +    QEMUTimer rx_timeout;
> +};
> +
> +#endif
> 


