Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4D8C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 12:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp4sx-0000Xd-R3; Mon, 03 Mar 2025 07:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp4sU-0000UX-D6
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:26:36 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp4sQ-0007Go-Vo
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:26:33 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso1076506f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741004789; x=1741609589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wCNDAMKzWSCOn/BVS1TBOQlzVKtJ0BwoGBeM0Dv+Fg4=;
 b=cWzIpY9r2rNdiwOP3+ik+R3KtHokF1yySgrMePh6H/fcinHmM+nbwm+GWpOMuhADrM
 YmcdGhrcIs8e9U0hTMgvhzAqzRbvUHx54nUV2UmE2dJdtGKoYxtt3hHVCOkfBEIuAr0S
 JvEpNleo1KGDe1+urLoGZ1s/JKpf7d0VhIMtSeQw8+7U64OG2Ajcrnzacv87kSQsU2uv
 gGdR4da/5T10Y4a8HLsixr+E35DayLtbbKlgBhJVABorkiEewpXxpBAkHw7FkKKa1e/J
 Hfus6Pm3oZkd2qQzac+8qXq7h94/y2zWuAi4nvl1D41QBw0y6WU5BSWO4/C2ZNHtGtfv
 hnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741004789; x=1741609589;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wCNDAMKzWSCOn/BVS1TBOQlzVKtJ0BwoGBeM0Dv+Fg4=;
 b=wviRvN+Jy3p9hFJjveTZ5EkWg2ftQ+MBr8orX0wzeJNtJfiMwbFjO1mAAvDuVWQ3k5
 X9Z2+1aoVGL9Q5V10UniPVwsk12ZmuCzdm1MdPf/xwXtABNxAvmDO0kG1fTXIIsesbzK
 B5QuuoytrOBWGyTOjtR6UhTEXjKcasTRRWvGUON+K1/vtm+2PArc5QqxKHSYBLkr1/9c
 gjF3vnA4uTP+5LZ/RGvpvhChhVwhgYIHxcjFXa1GPreQGEVaWeE7vXGB8c3uWAKaZaPf
 pRtgku8Z/faaIt+5/gj4k3Q3US9xFTXyacmDGVmvki2s2pXsbOd49acnsy5MNGLLQtGl
 1s/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaRUcyUbrP6GaBFytVWgA9QjcmRj/f8PuWmMT6TvOpaHqFyyrwdBmeLMC9azkIjJ1WR5H6wVr/Gb9p@nongnu.org
X-Gm-Message-State: AOJu0Yz8XvPPc0UN/QncqNupW4M54qRa9wIKNm7i88kmQcQLLFZQSEhW
 FiEJHnfUIHn3rZjB4JrDdJJThXnSWQci1REIE91zW4OMM+ojtX8gtx99hzsH8Co8xhoRDdNLNQu
 23W0kEg==
X-Gm-Gg: ASbGncvKLpCKus0y2Omtt2dI/CRlZXjPcCBZV6OhZW4qucSn3acXPbesmNZHDe7CHq0
 LtoldBgGQ2/9EGdx8jtpI2eXpSGjxc58Uksg2IZsmnTbvTWlGn8H4e8aTLuB5d+HdWfoFmeTmCi
 hY5tVfJK7zKWc4Jpf38D8u4Z48wUdZ+sW3F5LBMNmhSRWwEMKIvoHPCBIC7KcToDyp0UZMQtKq1
 qL8DWB4xEwOTmEIH+shdcbR+92lb/zGQvE6JugBmWe0htUIFiSMZl9pg341Dc0uio6QYty3WQS3
 BKivP6VN/ycIFGtyRWGGCWFZEq5mRv5JQzWKPcWRH7DdaYVem4/EgFQ+9/vIwy02X4JSyQxvCFu
 b0mra3BmX9SMi
X-Google-Smtp-Source: AGHT+IEjZdK0X1TrH2QKbGt1lYS5zhUHB7SLTiKQf7Ivmgep0MyvgfzIcHRERjNMWCTxNOJo0ym/Ag==
X-Received: by 2002:a05:6000:184e:b0:38d:e6f4:5a88 with SMTP id
 ffacd0b85a97d-390ec7cd17cmr10718889f8f.12.1741004788630; 
 Mon, 03 Mar 2025 04:26:28 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc48f6d6bsm23561095e9.36.2025.03.03.04.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 04:26:27 -0800 (PST)
Message-ID: <3029782c-8d16-4428-9d6b-1c2fa8a7e755@linaro.org>
Date: Mon, 3 Mar 2025 13:26:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/intc: Add l2vic interrupt controller
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Damien Hedde <damien.hedde@dahe.fr>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-2-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250301172045.1295412-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Brian and Sid,

On 1/3/25 18:20, Brian Cain wrote:
> From: Sid Manning <sidneym@quicinc.com>
> 
> Co-authored-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Co-authored-by: Damien Hedde <damien.hedde@dahe.fr>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                    |   2 +
>   docs/devel/hexagon-l2vic.rst   |  59 +++++
>   docs/devel/index-internals.rst |   1 +
>   include/hw/intc/l2vic.h        |  37 +++
>   hw/intc/l2vic.c                | 417 +++++++++++++++++++++++++++++++++
>   hw/intc/Kconfig                |   3 +
>   hw/intc/meson.build            |   2 +
>   hw/intc/trace-events           |   4 +
>   8 files changed, 525 insertions(+)
>   create mode 100644 docs/devel/hexagon-l2vic.rst
>   create mode 100644 include/hw/intc/l2vic.h
>   create mode 100644 hw/intc/l2vic.c


> diff --git a/hw/intc/l2vic.c b/hw/intc/l2vic.c
> new file mode 100644
> index 0000000000..9df6575214
> --- /dev/null
> +++ b/hw/intc/l2vic.c
> @@ -0,0 +1,417 @@
> +/*
> + * QEMU L2VIC Interrupt Controller
> + *
> + * Arm PrimeCell PL190 Vector Interrupt Controller was used as a reference.
> + * Copyright(c) 2020-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/irq.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/intc/l2vic.h"
> +#include "trace.h"
> +
> +#define L2VICA(s, n) (s[(n) >> 2])
> +
> +#define TYPE_L2VIC "l2vic"
> +#define L2VIC(obj) OBJECT_CHECK(L2VICState, (obj), TYPE_L2VIC)

Why not use OBJECT_DECLARE_SIMPLE_TYPE()?

> +
> +#define SLICE_MAX (L2VIC_INTERRUPT_MAX / 32)
> +
> +typedef struct L2VICState {
> +    SysBusDevice parent_obj;
> +
> +    QemuMutex active;
> +    MemoryRegion iomem;
> +    MemoryRegion fast_iomem;
> +    uint32_t level;
> +    /*
> +     * offset 0:vid group 0 etc, 10 bits in each group
> +     * are used:
> +     */
> +    uint32_t vid_group[4];
> +    uint32_t vid0;
> +    /* Clear Status of Active Edge interrupt, not used: */
> +    uint32_t int_clear[SLICE_MAX] QEMU_ALIGNED(16);
> +    /* Enable interrupt source */
> +    uint32_t int_enable[SLICE_MAX] QEMU_ALIGNED(16);
> +    /* Clear (set to 0) corresponding bit in int_enable */
> +    uint32_t int_enable_clear;
> +    /* Set (to 1) corresponding bit in int_enable */
> +    uint32_t int_enable_set;
> +    /* Present for debugging, not used */
> +    uint32_t int_pending[SLICE_MAX] QEMU_ALIGNED(16);
> +    /* Generate an interrupt */
> +    uint32_t int_soft;
> +    /* Which enabled interrupt is active */
> +    uint32_t int_status[SLICE_MAX] QEMU_ALIGNED(16);
> +    /* Edge or Level interrupt */
> +    uint32_t int_type[SLICE_MAX] QEMU_ALIGNED(16);
> +    /* L2 interrupt group 0-3 0x600-0x7FF */
> +    uint32_t int_group_n0[SLICE_MAX] QEMU_ALIGNED(16);
> +    uint32_t int_group_n1[SLICE_MAX] QEMU_ALIGNED(16);
> +    uint32_t int_group_n2[SLICE_MAX] QEMU_ALIGNED(16);
> +    uint32_t int_group_n3[SLICE_MAX] QEMU_ALIGNED(16);
> +    qemu_irq irq[8];
> +} L2VICState;

OBJECT_DECLARE_SIMPLE_TYPE(L2VICState, L2VIC)


> +static inline bool vid_active(L2VICState *s)
> +
> +{
> +    /* scan all 1024 bits in int_status arrary */
> +    const int size = sizeof(s->int_status) * CHAR_BIT;
> +    const int active_irq = find_first_bit((unsigned long *)s->int_status, size);

Maybe this file could leverage the 32-bit bitops.h API:

$ git grep bit32\( include/qemu/bitops.h
include/qemu/bitops.h:38: * - Bits stored in an array of 'uint32_t': 
set_bit32(), clear_bit32(), etc
include/qemu/bitops.h:270:static inline void set_bit32(long nr, uint32_t 
*addr)
include/qemu/bitops.h:296:static inline void clear_bit32(long nr, 
uint32_t *addr)
include/qemu/bitops.h:322:static inline void change_bit32(long nr, 
uint32_t *addr)
include/qemu/bitops.h:335:static inline int test_and_set_bit32(long nr, 
uint32_t *addr)
include/qemu/bitops.h:350:static inline int test_and_clear_bit32(long 
nr, uint32_t *addr)
include/qemu/bitops.h:365:static inline int test_and_change_bit32(long 
nr, uint32_t *addr)
include/qemu/bitops.h:380:static inline int test_bit32(long nr, const 
uint32_t *addr)

> +    return ((active_irq != size)) ? true : false;
> +}
> +
> +static bool l2vic_update(L2VICState *s, int irq)
> +{
> +    if (vid_active(s)) {
> +        return true;
> +    }
> +
> +    bool pending = test_bit(irq, (unsigned long *)s->int_pending);
> +    bool enable = test_bit(irq, (unsigned long *)s->int_enable);
> +    if (pending && enable) {
> +        int vid = get_vid(s, irq);
> +        set_bit(irq, (unsigned long *)s->int_status);
> +        clear_bit(irq, (unsigned long *)s->int_pending);
> +        clear_bit(irq, (unsigned long *)s->int_enable);
> +        /* ensure the irq line goes low after going high */
> +        s->vid0 = irq;
> +        s->vid_group[get_vid(s, irq)] = irq;
> +
> +        /* already low: now call pulse */
> +        /*     pulse: calls qemu_upper() and then qemu_lower()) */
> +        qemu_irq_pulse(s->irq[vid + 2]);
> +        trace_l2vic_delivered(irq, vid);
> +        return true;
> +    }
> +    return false;
> +}


