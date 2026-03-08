Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78482EA852F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMBQ-0008Kz-QD; Sun, 08 Mar 2026 18:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMBP-0008KV-8f
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:01:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMBL-0007E2-0m
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:01:05 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439c5cce2c6so4763658f8f.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773007261; x=1773612061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2J84YM58d5wAYHJfhdts335E5b4T3Nn+lhfBoecRIcI=;
 b=rvh3IIfRfvEnA/8VWX99g07AL09eJYjXKH8P0N70iNmxneHqaIrBCD7e4J02pukvNt
 vyReipq/34LTvoXRwo/pJEbQ9hukz/CNY+pRS/GAVv59JbFOGVHdY4YlEfdKzn7WzsIw
 dx7QCw1aXIqRIt0GojOCiEnDlyK6PwKhahl0X3VyX1pIK4YV+8SPeeDeeBWKKs9SqnA0
 SBdog2cVAaY2QimTvnKP4kQceHuqdihdQCIXG59ihZ2FM+iLqg9reNoDGpqGQ17AIaUt
 /U0RKzWa1nOgcBzbKfIYR/uBWK6esxLLDD3wOfiSkKisxf6wMlHeokXGcvPtKbsv8s9m
 gsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773007261; x=1773612061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2J84YM58d5wAYHJfhdts335E5b4T3Nn+lhfBoecRIcI=;
 b=nYMLRh3xQ4fGzbFAVGTVJN1lhQvAon+tos870aPb4AnDCZknB6tTqAVGl7hOcdMrEp
 Ey5NTczry5+dgMC/tCkZ9LYToqpumFr4DATYlpmToHBf4cVLiVhLlLph8TZlM1RVznGl
 oQOfCSFiIQ23/jtjWpFVPwZB8sF+akTNpkRFby9ii370rXY1JBJ1XlC6uR9JkIarQmCg
 dpUkpsVX6Gos/rERi4wAuooffZBYhwrryTQuT+0KcR+Edh6j9ude4D9pQv3Rd1r+0CHQ
 79c2/F71lIx2xHgEmcInltJ7IjwR9cwZf9gEjYIYc2Slahr91PfDmCixR1UEyq7f1dXy
 BIDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWOfgjXqecjdkUF+9RLwbLkFdwdCBX+mKJ+gCXY7iBWtAmIKH2+DhmTpZyhrWfPd0j//RoFyqiuCBm@nongnu.org
X-Gm-Message-State: AOJu0Yx4qq5ZwXtTbwy+jkQgdxbyR2WVVGxejcdSLU8ZgU7ckYCscnYr
 s5XyyCmIGrv8Y6HwQsgzEfyREE7C1rUvW55iDskAJWcwv6o8iGxEK/0u9OEuipVKJjY=
X-Gm-Gg: ATEYQzzf0hFeElwZw5mlW1NpR0W2Gd4fh9ncTvfzXs2gW3zYNW4djoeijPJMxStPzmC
 1PtkUTyfiiSBRdZkcgpjAB98SNBT4heTGVyd819aD+D19nXoW7d9IOk2YQ4ULe/+eJgAPILuwem
 aIqfFzVtVzWvAyScasWJxcShP6POp8N59dtf1sJscmaLr8Xt4NfbeEALzxA6gOZSq0V7ZQ3uMGX
 j3ZNj6RkMtSQ2YE/s2t3UdHS3o6IhsYYnKR1GxLMgeX8wTCoSKehEDfbtnRAfHDjrfZi8SsfiRY
 soHlfxWcTTgpWXgWi0Ya8DAc9ucVgIe42Hyba1tJjcilq74Dd4/xgscAzsgtHL1kJAhSVsJ0m+l
 xtrtPimNyEG6vkEKLKNDkihJymoQ8y2ZACzDqxZR58YHtYG/Gt53TXsgEoxnhqhlunfcSAFdgZi
 wRqI0YN54s5AHRPS8ck5/rgKU0Ge1qfTmno/SBo/n54l/OZaIM6UP1OPYXHZFlTWPWfA==
X-Received: by 2002:a05:6000:3113:b0:439:ba75:7dab with SMTP id
 ffacd0b85a97d-439da65450fmr16318525f8f.9.1773007260571; 
 Sun, 08 Mar 2026 15:01:00 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae45786sm23025769f8f.32.2026.03.08.15.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 15:00:59 -0700 (PDT)
Message-ID: <9266107a-b9c1-41e8-9040-3516fabb005a@linaro.org>
Date: Sun, 8 Mar 2026 23:00:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/xilinx_ethlite: Check for oversized TX packets
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20260303172718.437015-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260303172718.437015-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 3/3/26 18:27, Peter Maydell wrote:
> The xilinx_ethlite network device wasn't checking that the TX packet
> size set by the guest was within the size of its dual port RAM, with
> the effect that the guest could get it to read off the end of the RAM
> block.
> 
> Check the length.  There is no provision in this very simple device
> for reporting errors, so as with various RX errors we just report via
> tracepoint.
> 
> This lack of length check has been present since the device was first
> introduced, though the code implementing the tx path has changed
> somewhat since then.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3317
> Fixes: b43848a1005ce ("xilinx: Add ethlite emulation")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/trace-events     |  1 +
>   hw/net/xilinx_ethlite.c | 12 +++++++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)


> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index ba3acd4c77..75e6520569 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -162,9 +162,15 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
>           break;
>       case TX_CTRL:
>           if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
> -            qemu_send_packet(qemu_get_queue(s->nic),
> -                             txbuf_ptr(s, port_index),
> -                             s->port[port_index].reg.tx_len);
> +            uint32_t size = s->port[port_index].reg.tx_len;
> +
> +            if (size >= BUFSZ_MAX) {
> +                trace_ethlite_pkt_tx_size_too_big(size);
> +            } else {
> +                qemu_send_packet(qemu_get_queue(s->nic),
> +                                 txbuf_ptr(s, port_index),
> +                                 size);
> +            }
>               if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
>                   eth_pulse_irq(s);
>               }

Patch queued renaming @size -> @tx_size to prevent:

../hw/net/xilinx_ethlite.c: In function ‘port_tx_write’:
../hw/net/xilinx_ethlite.c:165:22: error: declaration of ‘size’ shadows 
a parameter [-Werror=shadow=compatible-local]
   165 |             uint32_t size = s->port[port_index].reg.tx_len;
       |                      ^~~~
../hw/net/xilinx_ethlite.c:151:40: note: shadowed declaration is here
   151 |                           unsigned int size)
       |                           ~~~~~~~~~~~~~^~~~


