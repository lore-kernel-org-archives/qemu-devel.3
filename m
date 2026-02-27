Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C23FD5323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 09:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvuca-0007D3-OR; Fri, 27 Feb 2026 04:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vvucT-0007CC-VB
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:58:50 -0500
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vvucR-0002Dh-8C
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:58:49 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.219])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4fMkLB2Tl0z5vpd;
 Fri, 27 Feb 2026 09:58:41 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 10:58:41 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0024ce1041c-2dab-46f5-b21c-eca5be24f814,
 1764588C194503052958D0AAF3448E51E66CE866) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <8ff2169d-dadf-4eda-991e-e676c9ead0da@kaod.org>
Date: Fri, 27 Feb 2026 10:58:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/22] hw/i3c: Add Mock target
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>, Titus Rwantare <titusr@google.com>, Patrick Venture
 <venture@google.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <20260225021158.1586584-19-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260225021158.1586584-19-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG12EX1.mxp5.local (172.16.2.121) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 44c155cf-f5f1-48fd-a125-ca4f16080705
X-Ovh-Tracer-Id: 7696933242298141642
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFq7Apf8mCu58rokCP0U1v4Z8jzTG8NcVqCeaMm1xcvJI42yIrUX+n+1lkzsDH8mx/JXMdXNs40N0k9p1liXxdAv0a11x+UQDJBS/V7792mH8b+chIr1MHP+LvaTPjF4q2Z1UFJBWV7t/10m+kU8Dxh/ZBZ4zuhrxYUysl7VgrAhyhSw+Aln0/1MrLPNhuxT0S0Mv52cSgLs4GkkQYhLFOCcHWiOYaH9uosmjfFGelU82wYoJgTeBlpp9g03K+ES3UPMXE7xOoAebSwvCHK2/l5tuPN7w/CrED8Gvqo8s0qRUpDg7n0dRv5SAj5U0gGcMBWPn83mOtJ49JanmhS35VNrK3CUIpd1QhTsgYKbxFDEhnywFbDxFeOTtamni9pW8k0mwOXTXs/MjutNze+PgiLfBJdxgeiCfRb1sGb6xYmJitbbyM9sQ5pWv5/YPPzISaQxPLbxlcv/yRWCgCFcWvZTOXSpgMlqUzmCcBsh0jteVYK9G13/KEOa16ar8WH175Pr881zyYuQCQomotEPHN9VF5m1b0qUgNqogyHfts9k/aS4jGqECNCv8Qm9OH3obsI42FZd4Mguc/dGVVKhtSMo4PVwpcXjnDJOyED7j5gJmqKxF47wJC+Wjx3tHSTPca1WwHGtdpy+VOod9EUojGmo5ocJETfn/qgwRTyK+32Tg
DKIM-Signature: a=rsa-sha256; bh=b3CQy1BbQojhlMDBRS0pfrxruyzZNKNYIvyk5JDNbb4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1772186324; v=1;
 b=qDtgvk1QVbyziuwFih4WzI13+5wbOQWU3+IRN2/2pXxsmY/qwhfLDHCkuycJWSDnQ+V26bn3
 JIS2lOrFX94aWGbcMMPfU2mwoQCBtmIZyteHib2HuHmnT+nSW0DfyMds5rjVwSXr48OLp53KRmx
 zuA+a0AQEBvf7mPvgshtr61GzE5/ijs8uEUhhYm9kTwu4UslMwo5nuJepEB7hGWCA3v9qmJn+uF
 UeC15jtlVIxhnlJ45u9pFr+AyQHXUCLGyGzAXqAi6gXKu/8K7cuzjX2fNAa21rlCIWadjRfi70A
 fgoYGDWzyNiiswPws6TJESAgNWBo+yZHhMS2V3JxKfZyQ==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/25/26 03:12, Jamin Lin wrote:
> Adds a simple i3c device to be used for testing in lieu of a real
> device.
> 
> The mock target supports the following features:
> - A buffer that users can read and write to.
> - CCC support for commonly used CCCs when probing devices on an I3C bus.
> - IBI sending upon receiving a user-defined byte.
> 
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> Reviewed-by: Titus Rwantare <titusr@google.com>
> Reviewed-by: Patrick Venture <venture@google.com>
> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/i3c/mock-i3c-target.h |  52 ++++++
>   hw/i3c/mock-i3c-target.c         | 298 +++++++++++++++++++++++++++++++
>   hw/i3c/Kconfig                   |  10 ++
>   hw/i3c/meson.build               |   1 +
>   hw/i3c/trace-events              |  10 ++
>   5 files changed, 371 insertions(+)
>   create mode 100644 include/hw/i3c/mock-i3c-target.h
>   create mode 100644 hw/i3c/mock-i3c-target.c
> 
> diff --git a/include/hw/i3c/mock-i3c-target.h b/include/hw/i3c/mock-i3c-target.h
> new file mode 100644
> index 0000000000..8c6003ae8b
> --- /dev/null
> +++ b/include/hw/i3c/mock-i3c-target.h
> @@ -0,0 +1,52 @@
> +#ifndef MOCK_I3C_TARGET_H_
> +#define MOCK_I3C_TARGET_H_
> +
> +/*
> + * Mock I3C Device
> + *
> + * Copyright (c) 2025 Google LLC
> + *
> + * The mock I3C device can be thought of as a simple EEPROM. It has a buffer,
> + * and the pointer in the buffer is reset to 0 on an I3C STOP.
> + * To write to the buffer, issue a private write and send data.
> + * To read from the buffer, issue a private read.
> + *
> + * The mock target also supports sending target interrupt IBIs.
> + * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number, and
> + * send that number in a private transaction. The mock target will issue an IBI
> + * after 1 second.
> + *
> + * It also supports a handful of CCCs that are typically used when probing I3C
> + * devices.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/timer.h"
> +#include "hw/i3c/i3c.h"
> +
> +#define TYPE_MOCK_I3C_TARGET "mock-i3c-target"
> +OBJECT_DECLARE_SIMPLE_TYPE(MockI3cTargetState, MOCK_I3C_TARGET)
> +
> +struct MockI3cTargetState {
> +    I3CTarget parent_obj;
> +
> +    /* General device state */
> +    bool can_ibi;
> +    QEMUTimer qtimer;
> +    size_t p_buf;
> +    uint8_t *buf;
> +
> +    /* For Handing CCCs. */
> +    bool in_ccc;
> +    I3CCCC curr_ccc;
> +    uint8_t ccc_byte_offset;
> +
> +    struct {
> +        uint32_t buf_size;
> +        uint8_t ibi_magic;
> +    } cfg;
> +};
> +
> +#endif
> diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c
> new file mode 100644
> index 0000000000..875cd7c7d0
> --- /dev/null
> +++ b/hw/i3c/mock-i3c-target.c
> @@ -0,0 +1,298 @@
> +/*
> + * Mock I3C Device
> + *
> + * Copyright (c) 2025 Google LLC
> + *
> + * The mock I3C device can be thought of as a simple EEPROM. It has a buffer,
> + * and the pointer in the buffer is reset to 0 on an I3C STOP.
> + * To write to the buffer, issue a private write and send data.
> + * To read from the buffer, issue a private read.
> + *
> + * The mock target also supports sending target interrupt IBIs.
> + * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number, and
> + * send that number in a private transaction. The mock target will issue an IBI
> + * after 1 second.
> + *
> + * It also supports a handful of CCCs that are typically used when probing I3C
> + * devices.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "hw/i3c/i3c.h"
> +#include "hw/i3c/mock-i3c-target.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +
> +#define IBI_DELAY_NS (1 * 1000 * 1000)
> +
> +static uint32_t mock_i3c_target_rx(I3CTarget *i3c, uint8_t *data,
> +                                   uint32_t num_to_read)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +    uint32_t i;
> +
> +    /* Bounds check. */
> +    if (s->p_buf == s->cfg.buf_size) {
> +        return 0;
> +    }
> +
> +    for (i = 0; i < num_to_read; i++) {
> +        data[i] = s->buf[s->p_buf];
> +        trace_mock_i3c_target_rx(data[i]);
> +        s->p_buf++;
> +        if (s->p_buf == s->cfg.buf_size) {
> +            break;
> +        }
> +    }
> +
> +    /* Return the number of bytes we're sending to the controller. */
> +    return i;
> +}
> +
> +static void mock_i3c_target_ibi_timer_start(MockI3cTargetState *s)
> +{
> +    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    timer_mod(&s->qtimer, now + IBI_DELAY_NS);
> +}
> +
> +static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,
> +                              uint32_t num_to_send, uint32_t *num_sent)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +    int ret;
> +    uint32_t to_write;
> +
> +    if (s->cfg.ibi_magic && num_to_send == 1 && s->cfg.ibi_magic == *data) {
> +        mock_i3c_target_ibi_timer_start(s);
> +        return 0;
> +    }
> +
> +    /* Bounds check. */
> +    if (num_to_send + s->p_buf > s->cfg.buf_size) {
> +        to_write = s->cfg.buf_size - s->p_buf;
> +        ret = -1;
> +    } else {
> +        to_write = num_to_send;
> +        ret = 0;
> +    }
> +    for (uint32_t i = 0; i < to_write; i++) {
> +        trace_mock_i3c_target_tx(data[i]);
> +        s->buf[s->p_buf] = data[i];
> +        s->p_buf++;
> +    }
> +    return ret;
> +}
> +
> +static int mock_i3c_target_event(I3CTarget *i3c, enum I3CEvent event)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +
> +    trace_mock_i3c_target_event(event);
> +    if (event == I3C_STOP) {
> +        s->in_ccc = false;
> +        s->curr_ccc = 0;
> +        s->ccc_byte_offset = 0;
> +        s->p_buf = 0;
> +    }
> +
> +    return 0;
> +}
> +
> +static int mock_i3c_target_handle_ccc_read(I3CTarget *i3c, uint8_t *data,
> +                                           uint32_t num_to_read,
> +                                           uint32_t *num_read)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +
> +    switch (s->curr_ccc) {
> +    case I3C_CCCD_GETMXDS:
> +        /* Default data rate for I3C. */
> +        while (s->ccc_byte_offset < num_to_read) {
> +            if (s->ccc_byte_offset >= 2) {
> +                break;
> +            }
> +            data[s->ccc_byte_offset] = 0;
> +            *num_read = s->ccc_byte_offset;
> +            s->ccc_byte_offset++;
> +        }
> +        break;
> +    case I3C_CCCD_GETCAPS:
> +        /* Support I3C version 1.1.x, no other features. */
> +        while (s->ccc_byte_offset < num_to_read) {
> +            if (s->ccc_byte_offset >= 2) {
> +                break;
> +            }
> +            if (s->ccc_byte_offset == 0) {
> +                data[s->ccc_byte_offset] = 0;
> +            } else {
> +                data[s->ccc_byte_offset] = 0x01;
> +            }
> +            *num_read = s->ccc_byte_offset;
> +            s->ccc_byte_offset++;
> +        }
> +        break;
> +    case I3C_CCCD_GETMWL:
> +    case I3C_CCCD_GETMRL:
> +        /* MWL/MRL is MSB first. */
> +        while (s->ccc_byte_offset < num_to_read) {
> +            if (s->ccc_byte_offset >= 2) {
> +                break;
> +            }
> +            data[s->ccc_byte_offset] = (s->cfg.buf_size &
> +                                        (0xff00 >> (s->ccc_byte_offset * 8))) >>
> +                                        (8 - (s->ccc_byte_offset * 8));

This is difficult to read ...

C.



> +            s->ccc_byte_offset++;
> +            *num_read = num_to_read;
> +        }
> +        break;
> +    case I3C_CCC_ENTDAA:
> +    case I3C_CCCD_GETPID:
> +    case I3C_CCCD_GETBCR:
> +    case I3C_CCCD_GETDCR:
> +        /* Nothing to do. */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_ccc);
> +        return -1;
> +    }
> +
> +    trace_mock_i3c_target_handle_ccc_read(*num_read, num_to_read);
> +    return 0;
> +}
> +
> +static int mock_i3c_target_handle_ccc_write(I3CTarget *i3c, const uint8_t *data,
> +                                            uint32_t num_to_send,
> +                                            uint32_t *num_sent)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +
> +    if (!s->curr_ccc) {
> +        s->in_ccc = true;
> +        s->curr_ccc = *data;
> +        trace_mock_i3c_target_new_ccc(s->curr_ccc);
> +    }
> +
> +    *num_sent = 1;
> +    switch (s->curr_ccc) {
> +    case I3C_CCC_ENEC:
> +    case I3C_CCCD_ENEC:
> +        s->can_ibi = true;
> +        break;
> +    case I3C_CCC_DISEC:
> +    case I3C_CCCD_DISEC:
> +        s->can_ibi = false;
> +        break;
> +    case I3C_CCC_ENTDAA:
> +    case I3C_CCC_SETAASA:
> +    case I3C_CCC_RSTDAA:
> +    case I3C_CCCD_SETDASA:
> +    case I3C_CCCD_GETPID:
> +    case I3C_CCCD_GETBCR:
> +    case I3C_CCCD_GETDCR:
> +    case I3C_CCCD_GETMWL:
> +    case I3C_CCCD_GETMRL:
> +    case I3C_CCCD_GETMXDS:
> +    case I3C_CCCD_GETCAPS:
> +        /* Nothing to do. */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_ccc);
> +        return -1;
> +    }
> +
> +    trace_mock_i3c_target_handle_ccc_write(*num_sent, num_to_send);
> +    return 0;
> +}
> +
> +static void mock_i3c_target_do_ibi(MockI3cTargetState *s)
> +{
> +    if (!s->can_ibi) {
> +        return;
> +    }
> +
> +    trace_mock_i3c_target_do_ibi(s->parent_obj.address, true);
> +    int nack = i3c_target_send_ibi(&s->parent_obj, s->parent_obj.address,
> +                                   /*is_recv=*/true);
> +    /* Getting NACKed isn't necessarily an error, just print it out. */
> +    if (nack) {
> +        trace_mock_i3c_target_do_ibi_nack("sending");
> +    }
> +    nack = i3c_target_ibi_finish(&s->parent_obj, 0x00);
> +    if (nack) {
> +        trace_mock_i3c_target_do_ibi_nack("finishing");
> +    }
> +}
> +
> +static void mock_i3c_target_timer_elapsed(void *opaque)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(opaque);
> +    timer_del(&s->qtimer);
> +    mock_i3c_target_do_ibi(s);
> +}
> +
> +static void mock_i3c_target_reset(I3CTarget *i3c)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +    s->can_ibi = false;
> +}
> +
> +static void mock_i3c_target_realize(DeviceState *dev, Error **errp)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(dev);
> +    s->buf = g_new0(uint8_t, s->cfg.buf_size);
> +    mock_i3c_target_reset(&s->parent_obj);
> +}
> +
> +static void mock_i3c_target_init(Object *obj)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(obj);
> +    s->can_ibi = false;
> +
> +    /* For IBIs. */
> +    timer_init_ns(&s->qtimer, QEMU_CLOCK_VIRTUAL, mock_i3c_target_timer_elapsed,
> +                  s);
> +}
> +
> +static const Property remote_i3c_props[] = {
> +    /* The size of the internal buffer. */
> +    DEFINE_PROP_UINT32("buf-size", MockI3cTargetState, cfg.buf_size, 0x100),
> +    /*
> +     * If the mock target receives this number, it will issue an IBI after
> +     * 1 second. Disabled if the IBI magic number is 0.
> +     */
> +    DEFINE_PROP_UINT8("ibi-magic-num", MockI3cTargetState, cfg.ibi_magic, 0x00),
> +};
> +
> +static void mock_i3c_target_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I3CTargetClass *k = I3C_TARGET_CLASS(klass);
> +
> +    dc->realize = mock_i3c_target_realize;
> +    k->event = mock_i3c_target_event;
> +    k->recv = mock_i3c_target_rx;
> +    k->send = mock_i3c_target_tx;
> +    k->handle_ccc_read = mock_i3c_target_handle_ccc_read;
> +    k->handle_ccc_write = mock_i3c_target_handle_ccc_write;
> +
> +    device_class_set_props(dc, remote_i3c_props);
> +}
> +
> +static const TypeInfo mock_i3c_target_types[] = {
> +    {
> +        .name          = TYPE_MOCK_I3C_TARGET,
> +        .parent        = TYPE_I3C_TARGET,
> +        .instance_size = sizeof(MockI3cTargetState),
> +        .instance_init = mock_i3c_target_init,
> +        .class_init    = mock_i3c_target_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(mock_i3c_target_types)
> +
> diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig
> index ecec77d6fc..d5c6d4049b 100644
> --- a/hw/i3c/Kconfig
> +++ b/hw/i3c/Kconfig
> @@ -3,3 +3,13 @@ config I3C
>   
>   config DW_I3C
>       bool
> +
> +config I3C_DEVICES
> +    # Device group for i3c devices which can reasonably be user-plugged to any
> +    # board's i3c bus.
> +    bool
> +
> +config MOCK_I3C_TARGET
> +    bool
> +    select I3C
> +    default y if I3C_DEVICES
> diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build
> index 83d75e7d5c..e614b18712 100644
> --- a/hw/i3c/meson.build
> +++ b/hw/i3c/meson.build
> @@ -2,4 +2,5 @@ i3c_ss = ss.source_set()
>   i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))
>   i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
>   i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))
> +i3c_ss.add(when: 'CONFIG_MOCK_I3C_TARGET', if_true: files('mock-i3c-target.c'))
>   system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)
> diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
> index 39f33d9a50..9e58edec99 100644
> --- a/hw/i3c/trace-events
> +++ b/hw/i3c/trace-events
> @@ -36,3 +36,13 @@ legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx8
>   legacy_i2c_send(uint8_t byte) "Legacy I2C send 0x%" PRIx8
>   legacy_i2c_start_transfer(uint8_t address, bool is_recv) "Legacy I2C START with address 0x%" PRIx8 " is_recv=%d"
>   legacy_i2c_end_transfer(void) "Legacy I2C STOP"
> +
> +# mock-target.c
> +mock_i3c_target_rx(uint8_t byte) "I3C mock target read 0x%" PRIx8
> +mock_i3c_target_tx(uint8_t byte) "I3C mock target write 0x%" PRIx8
> +mock_i3c_target_event(uint8_t event) "I3C mock target event 0x%" PRIx8
> +mock_i3c_target_handle_ccc_read(uint32_t num_read, uint32_t num_to_read) "I3C mock target read %" PRId32 "/%" PRId32 " bytes"
> +mock_i3c_target_new_ccc(uint8_t ccc) "I3C mock target handle CCC 0x%" PRIx8
> +mock_i3c_target_handle_ccc_write(uint32_t num_sent, uint32_t num_to_send) "I3C mock target send %" PRId32 "/%" PRId32 " bytes"
> +mock_i3c_target_do_ibi(uint8_t address, bool is_recv) "I3C mock target IBI with address 0x%" PRIx8 " RnW=%d"
> +mock_i3c_target_do_ibi_nack(const char *reason) "NACKed from controller when %s target interrupt"


