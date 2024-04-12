Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C54C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDoR-0000RG-MR; Fri, 12 Apr 2024 06:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvDoP-0000Qn-Uz
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:07:13 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvDoJ-00027t-Lx
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:07:13 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e346224bdso627342a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712916425; x=1713521225; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CRq1VK8S0LEFDcUOe52ENFNImtSvO7NrWm3Uw1gqR4Q=;
 b=in/FYg+NCQRDFLJogW5NSSF/Ti9i8u/NQI7x8pPwPmwj/Ci4lsYCpVIOGogK8DpEkf
 qMf8LFcy/qqMnJJ2eDRb2Tauaz65hPVdFnxa1KhdHZtbkxH8rKuXN+UZM9PcgTxbgWZT
 lGLDVOMrjSYclfNjLXuA7BTH6GvvuUOGIZi54EEONcEH5oXTx3+b73J5BTtS6/rxwafQ
 VR9ptlYQkjv01wYEguTJz59pj4QJpfXeqtgFI+4hQGodkYNLd9J+ARF88uOTA7/z49Gp
 g/tMQmaRhU/+218whA+h0cxWI99WDQzRt4YAYeRpndtk9FQ1HoCK7gmQrDVzEOgzAH46
 4v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712916425; x=1713521225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CRq1VK8S0LEFDcUOe52ENFNImtSvO7NrWm3Uw1gqR4Q=;
 b=kSpv0he/xqK/Ok++sXyx94cnIeX2StE14W3skW4V6shjVCEm6sqVvxV9KBs2J0HA8Q
 B6gg45twbnZLNwLmbrKDuXbanT1KPephRZtNDHxxh9Va4ROJOMZXItfQf0W6IqTIGZrC
 1AWcPr42ZsQOsWlFyylpqSRQvSiKcMq82Hh4GkidKQXEsAtgEd+Az1w5AXS/SeoaX8DK
 AX11k9TFuxprx+9G4w4ji2+JPEKhPWqSyDn5Z6oHgbVMXhKSi8a7KyT9yDssY3a/hcmK
 UaYuYLbEBsO+8zsZGWF9rNzs+YPVoonXYOKiN+hSucQNmXJBRvPkaEVQHluhxemi9AtJ
 yl7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF98sx8VuRvOAlGiu8TRVC78wdwn50Am8UwzDhShJR4abl3JuLzUPaVxPjJJ09F2iU//+n1oL0QGdL9rlwRXlZT+oymOA=
X-Gm-Message-State: AOJu0YyLdyPqJziMXcs+Kyz/WlXCZR41YiSuGghUQVWDdDhxaWW7HyiJ
 YU8kbK7odOUb/2rfEux6qcg+zZp7wSOuwaJkyqg34wRy0WCGQ3+nmOVxudy+wurmPk+SgJwmHGa
 ahiSAgJI6jrT80ruf0HAz8bMAc3Sahka1EuNHf75cnnROL2op
X-Google-Smtp-Source: AGHT+IG3E6TyTVC4L/oAn+xXwRa38DWTAhJ+TGxyvDeWXq1rT8iidFEWU7Wafdf7X90VmtdW3p2S+92Mw2cOBUGV8x0=
X-Received: by 2002:a50:9e84:0:b0:56d:f979:8d82 with SMTP id
 a4-20020a509e84000000b0056df9798d82mr1430825edf.25.1712916425565; Fri, 12 Apr
 2024 03:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240412081328.11183-1-adiupina@astralinux.ru>
In-Reply-To: <20240412081328.11183-1-adiupina@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2024 11:06:54 +0100
Message-ID: <CAFEAcA9wfzpc74iA_2G-YbtQtwGCA9VPQuXagg-Q0FwC92tg+w@mail.gmail.com>
Subject: Re: [PATCH RFC] prevent overflow in
 xlnx_dpdma_desc_get_source_address()
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 12 Apr 2024 at 09:13, Alexandra Diupina <adiupina@astralinux.ru> wrote:
>
> Overflow can occur in a situation where desc->source_address
> has a maximum value (pow(2, 32) - 1), so add a cast to a
> larger type before the assignment.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: d3c6369a96 ("introduce xlnx-dpdma")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>  hw/dma/xlnx_dpdma.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
> index 1f5cd64ed1..224259225c 100644
> --- a/hw/dma/xlnx_dpdma.c
> +++ b/hw/dma/xlnx_dpdma.c
> @@ -175,24 +175,24 @@ static uint64_t xlnx_dpdma_desc_get_source_address(DPDMADescriptor *desc,
>
>      switch (frag) {
>      case 0:
> -        addr = desc->source_address
> -            + (extract32(desc->address_extension, 16, 12) << 20);
> +        addr = (uint64_t)(desc->source_address
> +            + (extract32(desc->address_extension, 16, 12) << 20));

Unless I'm confused, this cast doesn't help, because we
will have already done a 32-bit addition of desc->source_address
and the value from the address_extension part, so it doesn't
change the result.

If we want to do the addition at 64 bits then using extract64()
would be the simplest way to arrange for that.

However, I can't figure out what this code is trying to do and
make that line up with the data sheet; maybe this isn't the
right datasheet for this device?

https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/ADDR_EXT-Field

The datasheet suggests that we should take 32 bits of the address
from one field (here desc->source_address) and 16 bits of the
address from another (here desc->address_extension's high bits)
and combine them to make a 48 bit address. But this code is only
looking at 12 bits of the high 16 in address_extension, and it
doesn't shift them right enough to put them into bits [47:32]
of the final address.

Xilinx folks: what hardware is this modelling, and is it
really the right behaviour?

Also, this device looks like it has a host-endianness bug: the
DPDMADescriptor struct is read directly from guest memory in
dma_memory_read(), but the device never does anything to swap
the fields from guest memory order to host memory order. So
this is likely broken on big-endian hosts.

thanks
-- PMM

