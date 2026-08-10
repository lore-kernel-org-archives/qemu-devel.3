Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EA5C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtY9U-0003zL-AW; Mon, 10 Aug 2026 18:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtY9T-0003z7-1F
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:07:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtY9R-0003Fu-9f
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:07:22 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXfUX3140859
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VHGyJhElQw1i8xdNNeyB79RzsOscDBkfglxRDTK2+Ec=; b=IcY/X7CgwE0VbsL9
 UK7dM0mSGdx54SbmqpKPEsd510xpbX1GAALrUCy375qY2IrQHqzq0iDhb56i4+eF
 Sd1s7GDZLMCvqtQ1ycvg3FQcIO1XQ9qI4Ci2peIDa78ePbamgPpQK7CkcGoN9Pb1
 +GYLFEIH8uKChl7qCB5MmP4+PC83ECjzj97Up/H/Gft7B3lUzGf94/pLmbzs9jdc
 Yyj7gzyoaPjqlh9vLx17jA71jLYqSz71rq9wNPU4hyHahwE2NnWlcPTABMrHF3jW
 MBBCNMiCmWnp2IUFsGqDm4F0t8yY6om1T7YmIM+//phPFEde7YiS8Xbo4N1O+got
 1iiBoQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyfs4kn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:07:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d28f8737eso46573201cf.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786399638; x=1787004438; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VHGyJhElQw1i8xdNNeyB79RzsOscDBkfglxRDTK2+Ec=;
 b=CKs9vly+/Oa/UZhZuDErTw6dGq9Q/xExO7k1M90mCh/6f+BMDA61JIf8tMkjR7tlp+
 9H7+2538Xw7IpyIi100fB5BBaw9VDguFIwIIBETX9YJWeAaYZhgLFAcwhxO5prNa7ida
 iHSEY+oVVwPsaFstc+NYNQFlMOjF8BguC6fif10SKRP/nVZpU4R5oTKva3LHklAz6VU/
 g8rYAQgiq601G3xuJMOgVO8EswEnX64u3eUe0MEQn03yIplCOdrmkDROEOQ5liPiINgs
 oDZVPwsNM5UZDLSu1xwByzhcDO79JbvirmLJCO0QaffYzjHfYbFf6cwetuAIvkamjfqz
 a4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786399638; x=1787004438;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VHGyJhElQw1i8xdNNeyB79RzsOscDBkfglxRDTK2+Ec=;
 b=M0eQZ0UdQIVeSgQtADBajVYPbn+zBx9QyMze//tcJ5nQGD+Oa0iZ1FFJkVgyYrihHl
 H2MPJMp1nLDxs2JCGA3tYeGRpC0U4UiXEX2stItpckF/5Do3n2O2EpwveXjnuv4KGcK+
 wXR3TDCsKKDPFZqepLIQqE3Y7dB0vCmskSXUQolr5jFtQsUdFlpk2cWnW2f+Wb/OtrmE
 jaWSGlOI2Q2gqdhSpYe5LxIDPwnMr7x3l8+yPT5Imnzo0s0dcVC+8R/Q66GKuNjoWnCL
 lZlw0ZISHxD1VOjBJbEbJyKOicavImul+AjEAVlWyfkeHZdxiefVXZ06MJzhhFgz9Vmu
 Z+0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RolzkgyS7Y9IaDvdhMfhfmUjGSgrKOr9wtqjwIkyVsB8V+b9AgL9Aw1meebA8WxsMU0OECx/Iolt5vv@nongnu.org
X-Gm-Message-State: AOJu0Yy3VNuKWyjgJm633+jF3YUh0+7Q4r2S/rg+qa4uBbr48Y2kkYez
 lrw5htTTS1BNg2FyRf3hEuQTdMlof+Ap3TiiYOVlnXQ3rMZtAVI9cLBFn7t6/OjHoER57xCShrK
 6Eo37ozZ1Koif9hgMhN0RB0AcpfAR33IU9KzOGbdyg4u2yf7QA38Zzjsm3Q==
X-Gm-Gg: AR+sD10RwDqmd6BGPwC2OhzlLzFibLjtwiTuKzTLJo+jAZAKDC8AdAPtqHbpnKohf4N
 VLrYpPkyc7xG1AzrxRFBGq5s3cGdR+mLKwxyxKI5c6WOSFTG1cXGdS6HqT+dBC2Gpb+0WlwEqk2
 svqG5nxgBDA8B1suLwk/Wl6jhT6vySD/vkCOwCUZltQqP18znSWRMVuSc5C5zEqU+Fl5GL4YSo4
 r4Ode7jv3eEPx1F5OsBFs5I1CZNoA5+1As7O4CwNzNUfx1d5+/64XI2T+jU4TBK9c2hXyhZ89DN
 oiv4Up26gO/Pw9jP0QLho6JiM6LgtYeU85b1hWwlxjrWNzr1RHgG3LF4V3Fe6JYEvce+cLdYXFK
 93C55/0VSajwYW6cXItBY4+EjjKrj6eoLr4lR7/W5
X-Received: by 2002:a05:622a:a588:b0:52b:71dd:c930 with SMTP id
 d75a77b69052e-52d20a5a1c4mr268898551cf.38.1786399638464; 
 Mon, 10 Aug 2026 15:07:18 -0700 (PDT)
X-Received: by 2002:a05:622a:a588:b0:52b:71dd:c930 with SMTP id
 d75a77b69052e-52d20a5a1c4mr268897881cf.38.1786399637966; 
 Mon, 10 Aug 2026 15:07:17 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499740a490esm32950255e9.1.2026.08.10.15.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 15:07:17 -0700 (PDT)
Message-ID: <bcdb641c-b2ff-4f6a-a04b-27b1b3e8bf6b@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 00:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] hw/char: add TriCore ASCLIN UART controller
Content-Language: en-US
To: Parthiban Nallathambi <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 christoph.seitz@infineon.com, David Brenken <david.brenken@efs-auto.de>
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
 <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-5-1c39053e5e95@linumiz.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-5-1c39053e5e95@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Pb52tvo9Dws5JL6w7kIo4BwbnV-esU7D
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4NyBTYWx0ZWRfX2xglxz0fIqfT
 KNlApKRsYZMYcQI6FHgFPjXmz7O9FoDV8p+cP7I9TVNULU+OW0hrQBPKZ7C6HBJQAdbo8GXHf40
 FXbRZvo93njjbkTTC5LDVTZJHyAQhuE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4NyBTYWx0ZWRfX34u0Ed6GC9hg
 Fg5Cg8cRPm4nS5ITigRDnxOg+Fju5KFW4khUMSm186PW0xVDalHrhN3Afc0NACXttiJkcjjzoqr
 uJymTLv/JIf0XUrjALfK4agWSr6IDx1L4Z8wm9WS9TcVj62a1tg3pYl3VadTx6fZarmXikq/YZW
 /KA8vzCazBTZKwWyqcbJmx7o+qjTqIw2/bmqV8pHQPmX31TsAmJzn741bH5k1zAsQJxYtS0KjAZ
 lmoD6idIwBsOw4rq0WbSDJBdbgTKnUl0ac8ZbQNMW0KZj/Aq1/HWFHkiUGgX2ZggskG4+6GHTkd
 SdAz6UPoJ7VEjKoG2sLY3XRpTeBkv/JOAVj6Zcjssp5MwZyhegXoxxtp8r2U9oMrC/x8fRwj3K7
 E7PYNyrVd6d0RHg6YlkI0uCpohZ3feLPnk3O4XyHgKLcI+CBfjDOI+mZAWrfgaPUZPSyr4M1K0G
 +zHRPjKp5s3LXqiW3lQ==
X-Proofpoint-GUID: Pb52tvo9Dws5JL6w7kIo4BwbnV-esU7D
X-Authority-Analysis: v=2.4 cv=Zd4t8MVA c=1 sm=1 tr=0 ts=6a7a4b97 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=vU9dKmh3AAAA:8 a=EUspDBNiAAAA:8 a=r0bVYnQz3-FgjroSeqQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100187
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 31/5/26 11:30, Parthiban Nallathambi wrote:
> Model the ASCLIN in UART mode.  TX writes go to the chardev
> backend, RX fills a ring buffer.  FLAGS tracks FIFO status and
> three sysbus IRQ lines (TX, RX, ERR) are pulsed on flag edges.
> 
> Originally-by: David Brenken <david.brenken@efs-auto.de>
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>   hw/char/Kconfig                  |   3 +
>   hw/char/meson.build              |   1 +
>   hw/char/tricore_asclin.c         | 457 +++++++++++++++++++++++++++++++++++++++
>   include/hw/char/tricore_asclin.h |  89 ++++++++
>   4 files changed, 550 insertions(+)


 > diff --git a/hw/char/tricore_asclin.c b/hw/char/tricore_asclin.c

> +static void asclin_uart_event(void *opaque, QEMUChrEvent event)
> +{

Empty function body, is that necessary?

> +}

> diff --git a/include/hw/char/tricore_asclin.h b/include/hw/char/tricore_asclin.h
> new file mode 100644
> index 0000000000..b142515c50
> --- /dev/null
> +++ b/include/hw/char/tricore_asclin.h
> @@ -0,0 +1,89 @@
> +/*
> + * TriCore ASCLIN (Asynchronous/Synchronous Interface) UART controller
> + *
> + * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
> + * Copyright (c) 2024 Siemens AG
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_TRICORE_ASCLIN_H
> +#define HW_TRICORE_ASCLIN_H
> +
> +#include "chardev/char-fe.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +/* FLAGS register bits */
> +#define ASCLIN_FLAGS_TH     (1u << 0)
> +#define ASCLIN_FLAGS_TR     (1u << 1)
> +#define ASCLIN_FLAGS_RH     (1u << 2)
> +#define ASCLIN_FLAGS_RR     (1u << 3)
> +#define ASCLIN_FLAGS_FED    (1u << 5)
> +#define ASCLIN_FLAGS_RED    (1u << 6)
> +#define ASCLIN_FLAGS_PE     (1u << 16)
> +#define ASCLIN_FLAGS_TC     (1u << 17)
> +#define ASCLIN_FLAGS_FE     (1u << 18)
> +#define ASCLIN_FLAGS_HT     (1u << 19)
> +#define ASCLIN_FLAGS_RT     (1u << 20)
> +#define ASCLIN_FLAGS_BD     (1u << 21)
> +#define ASCLIN_FLAGS_LP     (1u << 22)
> +#define ASCLIN_FLAGS_LA     (1u << 23)
> +#define ASCLIN_FLAGS_LC     (1u << 24)
> +#define ASCLIN_FLAGS_CE     (1u << 25)
> +#define ASCLIN_FLAGS_RFO    (1u << 26)
> +#define ASCLIN_FLAGS_RFU    (1u << 27)
> +#define ASCLIN_FLAGS_RFL    (1u << 28)
> +#define ASCLIN_FLAGS_TFO    (1u << 30)
> +#define ASCLIN_FLAGS_TFL    (1u << 31)
> +
> +/* RXFIFOCON bits */
> +#define ASCLIN_RXFIFOCON_FLUSH  0x1
> +#define ASCLIN_RXFIFOCON_ENI    0x2
> +
> +/* Interrupt line grouping masks */
> +#define ASCLIN_TX_INT_MASK  (ASCLIN_FLAGS_TH | ASCLIN_FLAGS_TR | \
> +                             ASCLIN_FLAGS_TFL)
> +#define ASCLIN_RX_INT_MASK  (ASCLIN_FLAGS_RH | ASCLIN_FLAGS_RR | \
> +                             ASCLIN_FLAGS_RFL)
> +#define ASCLIN_ERR_INT_MASK (ASCLIN_FLAGS_FED | ASCLIN_FLAGS_RED | \
> +                             ASCLIN_FLAGS_PE  | ASCLIN_FLAGS_TC  | \
> +                             ASCLIN_FLAGS_FE  | ASCLIN_FLAGS_HT  | \
> +                             ASCLIN_FLAGS_RT  | ASCLIN_FLAGS_BD  | \
> +                             ASCLIN_FLAGS_LP  | ASCLIN_FLAGS_LA  | \
> +                             ASCLIN_FLAGS_LC  | ASCLIN_FLAGS_CE  | \
> +                             ASCLIN_FLAGS_RFO | ASCLIN_FLAGS_RFU | \
> +                             ASCLIN_FLAGS_TFO)

No need to expose the flags / masks, we can keep them in the source file.

> +
> +/* FIFO depth and FILL field position in TX/RXFIFOCON */
> +#define ASCLIN_HW_FIFO_DEPTH    16
> +#define ASCLIN_FILL_SHIFT       16
> +#define ASCLIN_FILL_MASK        (0x1fu << ASCLIN_FILL_SHIFT)
> +
> +#define ASCLIN_R_MAX        21
> +#define ASCLIN_RX_BUF_SIZE  8192
> +
> +#define TYPE_TRICORE_ASCLIN "tricore_asclin"
> +OBJECT_DECLARE_SIMPLE_TYPE(TriCoreASCLINState, TRICORE_ASCLIN)
> +
> +struct TriCoreASCLINState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/

We don't use those private/public comments.

> +    MemoryRegion iomem;
> +    CharFrontend chr;
> +    qemu_irq irq_rx;
> +    qemu_irq irq_tx;
> +    qemu_irq irq_err;
> +
> +    guint watch_tag;
> +    uint32_t regs[ASCLIN_R_MAX];
> +    uint32_t txbuf;
> +
> +    uint8_t rxbuf[ASCLIN_RX_BUF_SIZE];
> +    uint32_t rx_wridx;
> +    uint32_t rx_rdidx;
> +};
> +
> +#endif

For QDev modelling:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


