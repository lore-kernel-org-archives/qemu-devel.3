Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB70C27C53
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 01:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHZCV-0005Xe-62; Wed, 12 Jun 2024 21:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sHZCU-0005XE-Gb
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 21:24:26 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sHZCS-0007Qq-1N
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 21:24:26 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4ecfa40a778so132527e0c.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 18:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718241862; x=1718846662; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+9fhbaKyi/gKD8M+vEAuB7KrOsgtG6SSl4lqPHdloaA=;
 b=JCu0HDZ6w6m5JQlvAU6Qy9Oe+ESqKDei2C7m4YzQNPbKZ7nKtDSbC0g5wX0Ua8H3Hz
 zWFlgYjcYLkJbxejpBRnV5liy5XxT7fLilIXOze3LDKA52Re0XuVbhQ7Aw71UyrVc7//
 JqO2NKKpSMEiH+GFIneQodPqSJoDjcqlBPVbtJJ2Ol9J0k9v6Snz+/Ln2iGDXFKJ8F4H
 pVCvk9MFP/dROTSJGGZW9MO/xohXFqprxfdvdWtdmu4bCbe5XYM3n7Zxan4GMPfgn7k0
 wF91/nNtGCsAEh/Nq2RZxEVx6J4YYLjXFgxpm+EazgsS4MoalmlG1d7tUqYQObDFOlfa
 om6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718241862; x=1718846662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+9fhbaKyi/gKD8M+vEAuB7KrOsgtG6SSl4lqPHdloaA=;
 b=vw00bzOcA5sRpf1HGzGKNzXtUuRIRdFCU8txjHa3JYOTxoB3FNY8LgrQMtYLq1DCJV
 lgXhNEF3F/yjmU5p5B8a4rxfbTTuNmvVeWRPICi0s2ilwKFjr3NPkdGYxdm+fpBHNK9M
 Hj4owpfihlobAZQ/jQXqxA21jxdwopHFQdL6aEZgZTMPsNDM8z0SnzKC12wNVp8Xd13X
 NsKIXyG4lkb4gMYuodWX/mSOxHDquxb6NqktIj52P58AMCVIZmaykMwK0ROCAWZnpJNn
 l94yheEBRXJAkeioakI3P6nS6v+gj0lQSFyLRVPVKleurHafFByaiMOO5tFJh4oni8cH
 8wxA==
X-Gm-Message-State: AOJu0Yx5M0+tx1UURwyRV8iagF9Ne7KTOGLbQrmq22hPEkJMvkYvrT02
 NkXNPmf7vSW/CpgEJwjOt5s0YfUNR67t5/U3vFkvxCHD7JIuaoVhq2ceBgnajqVvhKAlEGQ0KLN
 MUOamc/87Xh3cBvrQMYfI4oZm/abkb7aHFVKlkg==
X-Google-Smtp-Source: AGHT+IFa2K043a72Xk67gN/xHAziWu8EIpwYb9CYlBRMXlniZI2baAQTd2T0t2qfXv9kgLB5sZ1keL1a61D1RerN+jo=
X-Received: by 2002:ac5:cd47:0:b0:4ec:ef78:d753 with SMTP id
 71dfb90a1353d-4ed07f474d8mr3299129e0c.14.1718241862316; Wed, 12 Jun 2024
 18:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240604071540.18138-1-fea.wang@sifive.com>
 <20240604071540.18138-3-fea.wang@sifive.com>
 <3a919e08-fcce-48d5-b609-cc97cd3ff22b@linaro.org>
In-Reply-To: <3a919e08-fcce-48d5-b609-cc97cd3ff22b@linaro.org>
From: Fea Wang <fea.wang@sifive.com>
Date: Thu, 13 Jun 2024 09:24:11 +0800
Message-ID: <CAKhCfsfarBTCud3Bo8e3viNxQMLT0X+xQSpPACMyPFgOECB-8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/dma: Add a trace log for a description loading
 failure
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Frank Chang <frank.chang@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000d796f8061abb5bbf"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=fea.wang@sifive.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000d796f8061abb5bbf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure, I will fix it in the next patch series.
Thank you

Sincerely,
Fea

On Mon, Jun 10, 2024 at 7:49=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Fea,
>
> On 4/6/24 09:15, Fea.Wang wrote:
> > Due to a description loading failure, adding a trace log makes observin=
g
> > the DMA behavior easy.
> >
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > ---
> >   hw/dma/trace-events    | 3 +++
> >   hw/dma/xilinx_axidma.c | 3 +++
> >   2 files changed, 6 insertions(+)
>
>
> > +# xilinx_axidma.c
> > +xilinx_axidma_loading_desc_fail(uint32_t res) "error:%d"
>
> Unsigned format is "%u".
>
> Regards,
>
> Phil.
>

--000000000000d796f8061abb5bbf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sure, I will fix it in the next patch series.</div><d=
iv>Thank you</div><div><br></div><div>Sincerely,</div><div>Fea</div></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon,=
 Jun 10, 2024 at 7:49=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D=
"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi Fea,<br>
<br>
On 4/6/24 09:15, Fea.Wang wrote:<br>
&gt; Due to a description loading failure, adding a trace log makes observi=
ng<br>
&gt; the DMA behavior easy.<br>
&gt; <br>
&gt; Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@am=
d.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/dma/trace-events=C2=A0 =C2=A0 | 3 +++<br>
&gt;=C2=A0 =C2=A0hw/dma/xilinx_axidma.c | 3 +++<br>
&gt;=C2=A0 =C2=A02 files changed, 6 insertions(+)<br>
<br>
<br>
&gt; +# xilinx_axidma.c<br>
&gt; +xilinx_axidma_loading_desc_fail(uint32_t res) &quot;error:%d&quot;<br=
>
<br>
Unsigned format is &quot;%u&quot;.<br>
<br>
Regards,<br>
<br>
Phil.<br>
</blockquote></div>

--000000000000d796f8061abb5bbf--

