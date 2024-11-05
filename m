Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BEBD40CE0
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SfJ-00086f-My; Tue, 05 Nov 2024 18:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SfH-00086D-SC; Tue, 05 Nov 2024 18:08:48 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SfF-0000Rb-Sa; Tue, 05 Nov 2024 18:08:47 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso1573785e9.1; 
 Tue, 05 Nov 2024 15:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730848123; x=1731452923; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o1zBjMEjhJCCqdvpRfG9ZCkj9tCZC7qX4hRnDYwUYG0=;
 b=Z5exeWU3VX7JMbhyMSp3Kij+UTyajqXfiskSc2Qn1oan5r9ezJjELOQNiWT7hgz+5k
 VcD/THkiOexnJ/V3EUZgdL8EaXxFYgJ8RisUOhUw1oi0p1k/6fviKdU27KCNw7ob8dQA
 EguoChHHSjr/RwghoDHCETCwTMJKWnCkvm3Y2seYoQZVHy0qc0m7TxE4+CqQvxN0Rzd7
 pnqXwz8LGI4PDXDpky3qiR3Wb3+BN0ME/I7RF8e5DDzeDdSadCvZ4BD2KtsCV6XiVypu
 /vgp5ULYs9A3HNi/JFI5LitiufavmIFxmgoh9e5SSxSK+TS4M/yQeNbMNu3Zcfb2KTMi
 yDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730848123; x=1731452923;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1zBjMEjhJCCqdvpRfG9ZCkj9tCZC7qX4hRnDYwUYG0=;
 b=uUze/pffSu9/MakcFvqwua0YJY2ik/ymGd05TfgB/YT+WX45aqP1TEe3L0mh2ynP9N
 anP1ZKWVIQf/hJ2TTNVHItP0zkkFbXvXmSZWjDc68ziSn703XXW+BL0Alw/YZ2QAWKox
 m7/3g8Xqrve4p3MXjVVL9e2D9mNjWO6p1rNXSKKk312XP4AA5abVy44dvlYUGqX6JpAi
 vtOdvXfHaWqB2oC/dlqzqkXcIeZ8g493OGGNc2GJfLdcadbV96lvNU2phT0hYYn3Gf6x
 LyYRvNFI2hV3mLcP4MTEIZhI6pi2TpSscPkkuaAEmDv2s5IWuSZ+TKK8RvEUEs3VS5XM
 RHYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVB90mGbpf2ix2YxdxC5xs7JG5k+ysoepgetOImd5uA6dIrUKG1kqOb6SPMM21iVz8ZVSCfYDmxQ==@nongnu.org
X-Gm-Message-State: AOJu0YwyRefj+12clTKbvF4uD94y7u81ji7UX/CUJQ66COgEeCmss/FV
 PjFSLBGvIbgX4ft2rgxoqhdugylFCMX8tiCM1XqkhzD0cvqLrhSH
X-Google-Smtp-Source: AGHT+IHrmjeyQqfG6PSGkZI8KGt3ibZEEe+rLeVgSOiQ+Yq3yNFLyqIVHi+ywc3T/dD+8VuBFFTfAg==
X-Received: by 2002:a05:600c:4505:b0:431:416e:2603 with SMTP id
 5b1f17b1804b1-432a9a678f9mr3570955e9.3.1730848123417; 
 Tue, 05 Nov 2024 15:08:43 -0800 (PST)
Received: from gmail.com ([89.101.60.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6eb332sm1399035e9.40.2024.11.05.15.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 15:08:42 -0800 (PST)
Date: Wed, 6 Nov 2024 00:08:42 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 09/19] hw/intc/xilinx_intc: Only expect big-endian accesses
Message-ID: <ZyqletOJvt3nD_L4@zapote>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105130431.22564-10-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Nov 05, 2024 at 02:04:21PM +0100, Philippe Mathieu-Daudé wrote:
> Per the datasheet (reference added in file header, p.9)
> 'Programming Model' -> 'Register Data Types and Organization':
> 
>     "The XPS INTC registers are read as big-endian data"

Hi Phil,

Some of these devices exist in both big and little endian versions.
So far we've reused the same model by using DEVICE_NATIVE_ENDIAN.

Here's the little endian version:
https://docs.amd.com/v/u/en-US/ds747_axi_intc

Can we have add property to select the endianess?
For the Xilinx use-cases I think it may be a good idea to default it
to little endian and have the big-endian machines explicitly set it.

Cheers,
Edgar


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/intc/xilinx_intc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
> index 1762b34564e..71f743a1f14 100644
> --- a/hw/intc/xilinx_intc.c
> +++ b/hw/intc/xilinx_intc.c
> @@ -3,6 +3,9 @@
>   *
>   * Copyright (c) 2009 Edgar E. Iglesias.
>   *
> + * https://docs.amd.com/v/u/en-US/xps_intc
> + * DS572: LogiCORE IP XPS Interrupt Controller (v2.01a)
> + *
>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>   * of this software and associated documentation files (the "Software"), to deal
>   * in the Software without restriction, including without limitation the rights
> @@ -143,12 +146,20 @@ static void pic_write(void *opaque, hwaddr addr,
>  static const MemoryRegionOps pic_ops = {
>      .read = pic_read,
>      .write = pic_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    /* The XPS INTC registers are read as big-endian data. */
> +    .endianness = DEVICE_BIG_ENDIAN,
>      .impl = {
>          .min_access_size = 4,
>          .max_access_size = 4,
>      },
>      .valid = {
> +        /*
> +         * All XPS INTC registers are accessed through the PLB interface.
> +         * The base address for these registers is provided by the
> +         * configuration parameter, C_BASEADDR. Each register is 32 bits
> +         * although some bits may be unused and is accessed on a 4-byte
> +         * boundary offset from the base address.
> +         */
>          .min_access_size = 4,
>          .max_access_size = 4,
>      },
> -- 
> 2.45.2
> 

