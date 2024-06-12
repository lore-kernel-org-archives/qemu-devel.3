Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F760C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNPM-0005Xh-LM; Wed, 12 Jun 2024 08:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sHNPL-0005Uq-4g
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:48:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sHNPI-0005tR-Eb
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:48:54 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a44c2ce80so2926029a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718196531; x=1718801331; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJKu1EI5WiRS6emBcQ8li8fqo56Fg1wL9feC7WT0qL0=;
 b=sjjODgjJTzJsfQxaHF92wunFkKDI5KTDr9BwlPzhPeOR+Sok00O9si15/mDoOcc2XH
 jXz/KlMG2R13NTztwgAHxIanKjYkKC3X1X5+CfF8JiCXLPEzb4iIP4PbAJhmEUgVyOYQ
 VB5AxC1rB6PrJVG9FsvQ/VXc/vn7lt7imMwxkx16ugJ2LbnspixAuJQNxT9F6Jqn2Rcj
 3gZj9yqApzZJbC5zx9whcfDxa4zXqIEr0V8yRU9XeHRWICy6Hsv6p2m4hrhkJMXEUR0v
 bzyBlFWFlkOjFimzMwHoSrdUqyCedIlH1w8VUi435p7/yN8bdJKFAlcahD5pL8XS5bLJ
 ereg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718196531; x=1718801331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJKu1EI5WiRS6emBcQ8li8fqo56Fg1wL9feC7WT0qL0=;
 b=hSPc5r1IQjQ/d5pZ/QeQHjCVJSuQxwzni41UuuIG5JPxbWJnzjXPLheHL9hLmipRm+
 J6srt7nfrf3q9jp5xGS4XpjCMO23XlsN/GVX1ix2ND5J5Dx+HUYDXNaN7cEMcrfT4wIg
 lJSqz60r7WZKX+eGznirB8qgvRJ4Q5k8fgE12FVQTuDY7vjMQS1h+t7XVisSaYgEUOP4
 b1CZjqHXwBZn7fqD9h+IIpZ2qrTWBLLIWbK7Smnyb0qxEe2fbq92cPOz7xh9EQvsypf/
 iPAR+OUp4gtyWSLuHlpS45/AOkt5PFPRDFv7xLXch5XEuFXeoAsWS2NMMQd9t2Te3I95
 EMzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFImk22WJUUZH3Aa+rMBbRJfCpvEZpYPbaLJuWKI0s0XIukulaqfI0tnTMDmJe7UubmWDuRh/qYmJKpiZjTpsspajkxp4=
X-Gm-Message-State: AOJu0Ywb3NHGVcs0z43hSQS1rFuxU8tIUE0oUpnD8k3N/ixuvQ1PE8Cz
 wFm37D1nnrL6uP2M7EnzaWUxGIrvw1IX53QrUAx5d9dtv2/Hpo0xImOV+dbeQ0siM4A/8hl+mWp
 ZD9MJlVa4Mv3kq1fd12EebNhzoyVcagHEQMAkbg==
X-Google-Smtp-Source: AGHT+IFkfptB1IveV9NnJWiFFjm8RIM0P9MFqWCDaFuQo4cmENpVGJDMLPV6v4t/sKPEnnHXGFa53G/xBQCnMwUcC9k=
X-Received: by 2002:a50:aa9d:0:b0:57a:2a46:701 with SMTP id
 4fb4d7f45d1cf-57ca9769334mr1164669a12.19.1718196530638; Wed, 12 Jun 2024
 05:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240612020506.307793-1-zhenyzha@redhat.com>
 <69649622-e52c-4d24-809b-3d8a97786a69@linaro.org>
In-Reply-To: <69649622-e52c-4d24-809b-3d8a97786a69@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Jun 2024 13:48:37 +0100
Message-ID: <CAFEAcA9wEjONgLfTObNYwJbwn5Gs1BDJiDivc9PEwmfOeZW6ww@mail.gmail.com>
Subject: Re: [PATCH v3] hw/arm/virt: Avoid unexpected warning from Linux guest
 on host with Fujitsu CPUs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Zhenyu Zhang <zhenyzha@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 robin.murphy@arm.com, Jonathan.Cameron@huawei.com, gshan@redhat.com, 
 eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com, ddutile@redhat.com, 
 shahuang@redhat.com, qemu-riscv <qemu-riscv@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Song Gao <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 12 Jun 2024 at 13:33, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Zhenyu,
>
> On 12/6/24 04:05, Zhenyu Zhang wrote:
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 3c93c0c0a6..3cefac6d43 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -271,6 +271,17 @@ static void create_fdt(VirtMachineState *vms)
> >       qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
> >       qemu_fdt_setprop_string(fdt, "/", "model", "linux,dummy-virt");
> >
> > +    /*
> > +     * For QEMU, all DMA is coherent. Advertising this in the root nod=
e
> > +     * has two benefits:
> > +     *
> > +     * - It avoids potential bugs where we forget to mark a DMA
> > +     *   capable device as being dma-coherent
> > +     * - It avoids spurious warnings from the Linux kernel about
> > +     *   devices which can't do DMA at all
> > +     */
> > +    qemu_fdt_setprop(fdt, "/", "dma-coherent", NULL, 0);
>
> OK, but why restrict that to the Aarch64 virt machine?
> Shouldn't advertise this generically in create_device_tree()?
> Or otherwise at least in the other virt machines?

create_device_tree() creates an empty device tree, not one
with stuff in it. It seems reasonable to me for this property
on the root to be set in the same place we set other properties
of the root node.

thanks
-- PMM

