Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CAAD3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBCt-0003Cq-Ag; Mon, 29 Dec 2025 06:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBCZ-0003Bg-TP
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:14:19 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBCX-0005En-An
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:14:15 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b7eff205947so1268403566b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006851; x=1767611651; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZXSpZbIBiRNlI9Ms7ZRfHoH8jG4nxdpq/TMoG87oyk=;
 b=VlQHHw5FGf37BOWgnLqlXMxcEaTYg1s+LjPNMYakwqASbnfe69FgUxfavfUlZPObYY
 tXCICzhs06OGexFhHPhM41xkmU09tPT4wv88n18+OBss25H1CF4VoppvLwtwYrjQspdQ
 wObBviOwXAv5Oz5sEDs3HGUNBXfUMmyiOr+Num/HJON+zTbB/oTG/hWqFfLi4BBK2/4t
 kTn2qib7SCz1RzTXuGfUgu0hOqEj6nrvW4XLYjOQuumc/c7+NJpZfhm86O/19DyHuRT0
 iqX4w3D7FDVfjilpMF4DIZzlslB3SCXs3DrXw9aD3N0Keoi2xQePBjSJA/Ejg7txRp97
 eQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006851; x=1767611651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qZXSpZbIBiRNlI9Ms7ZRfHoH8jG4nxdpq/TMoG87oyk=;
 b=bms4ZuxaeRBptOCcipAAKbpG2EEzKVk6RMkwD/DEWXI6Fgav4CwoxjEcFuFWpUoLO9
 kVRmIeshr1oXJanffHaA5QBSlDuPoCiMwYbYyXflby9gObXmSyVatnNHzG+w1jAmOpji
 q3kur6m5eE1i6DTMxUJxCR7fZkr6zef3AfEqjkr3f1EgER6LFvSI3O3XYoszluTbhlgU
 qb4N148i5s8SJqH2cBawpmAJL3mwNZKh5ye6sVX4ySP9DbLU53sNjDvt7vwLUbiOuTkf
 qJwMSphAjjfiE6Ll6xBB0rMDLRq8xu5vUw71XzsQxl+ZNOKbGJj/8RzY0IWtlXNfCQZ7
 0nmw==
X-Gm-Message-State: AOJu0Yyy+ooUPW5oL6/tHLx40XSxAsgWDj0+vB+q53eQ2tbwisza8Yc8
 9/H8XanrJ7Z9fZw1GRUZkgbsxnzYLovRQ0O0IP+KvTBIatB8XKUrHQQqiRnhTQNU4TMDqCbsU/H
 +1ZuG/KCnPPaPjf2V1BdP6a+4eYaT/CTu5tV8RGc0Vg==
X-Gm-Gg: AY/fxX6CwGcqUdMwhKSscuxpgs45ejMaMdTPmui6AmJjp9O3ifSkkBMfVwpS0/ytR4F
 OZGsMqKuGmvTXm0zg7IBTQx+5tfesMYdiT8s1z1OhEsZQwY62Hah0jwNzlLM4/E8/xG+BglP7uo
 weuc52Lkt0xUJAyj1w9LIHv/vs/N7pENzf4qxTue/19UZYbUMB1vTCpMa4J6WWtYdas7A6I0lay
 F+5jCG1oGMCbaM9ro/CcbbYHsA0bzGD2WX3zeqe+6Q15TAS79TlFPrFO6Iyvie0qk4j4cVhg8zC
 nsuX0wTQxFj85EInXdiMD878p2w6VRu62rqP4Ds+J3PzHzX6IQ==
X-Google-Smtp-Source: AGHT+IFNhJ4ItD12jdf7r37YvE1qQ6/Ufntl12AsvqBwOndfM8dWlulC6Xla/i62lSHvzALRIKDD0ki1PGyv/kop5t4=
X-Received: by 2002:a17:906:cc5d:b0:b80:3fb7:102f with SMTP id
 a640c23a62f3a-b803fb724eemr2356480966b.28.1767006851420; Mon, 29 Dec 2025
 03:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-2-philmd@linaro.org>
In-Reply-To: <20251224162642.90857-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:13:45 +0200
X-Gm-Features: AQt7F2pXNBHU6z-vTD-O3tEcRepYoRsc4sNPSpqsPG6L4d3aXZu59FGXq7c_fcs
Message-ID: <CAAjaMXb-KuiMtBJ=kSBk6SjdF=rqzjmM4e3E6_1k22EyHQo46A@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] hw/sparc: Mark SPARC-specific peripherals as
 big-endian
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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

On Wed, Dec 24, 2025 at 6:26=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> These devices are only used by the SPARC target, which is
> only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_BIG_ENDIAN (besides, the
> DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
> using DEVICE_BIG_ENDIAN.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/audio/cs4231.c        |  2 +-
>  hw/char/grlib_apbuart.c  |  2 +-
>  hw/display/cg3.c         |  2 +-
>  hw/display/tcx.c         | 14 +++++++-------
>  hw/dma/sparc32_dma.c     |  2 +-
>  hw/intc/grlib_irqmp.c    |  2 +-
>  hw/intc/slavio_intctl.c  |  4 ++--
>  hw/misc/eccmemctl.c      |  2 +-
>  hw/misc/slavio_misc.c    | 16 ++++++++--------
>  hw/rtc/sun4v-rtc.c       |  2 +-
>  hw/timer/grlib_gptimer.c |  2 +-
>  hw/timer/slavio_timer.c  |  2 +-
>  12 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
> index 97cceb44d86..498cd2da704 100644
> --- a/hw/audio/cs4231.c
> +++ b/hw/audio/cs4231.c
> @@ -135,7 +135,7 @@ static void cs_mem_write(void *opaque, hwaddr addr,
>  static const MemoryRegionOps cs_mem_ops =3D {
>      .read =3D cs_mem_read,
>      .write =3D cs_mem_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>  };
>
>  static const VMStateDescription vmstate_cs4231 =3D {
> diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
> index b2d5a40bb4d..b9dafdc3e65 100644
> --- a/hw/char/grlib_apbuart.c
> +++ b/hw/char/grlib_apbuart.c
> @@ -242,7 +242,7 @@ static void grlib_apbuart_write(void *opaque, hwaddr =
addr,
>  static const MemoryRegionOps grlib_apbuart_ops =3D {
>      .write      =3D grlib_apbuart_write,
>      .read       =3D grlib_apbuart_read,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>  };
>
>  static void grlib_apbuart_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
> index daeef152174..ca04f0c9549 100644
> --- a/hw/display/cg3.c
> +++ b/hw/display/cg3.c
> @@ -265,7 +265,7 @@ static void cg3_reg_write(void *opaque, hwaddr addr, =
uint64_t val,
>  static const MemoryRegionOps cg3_reg_ops =3D {
>      .read =3D cg3_reg_read,
>      .write =3D cg3_reg_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 4,
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 4853c5e1424..ba31d9bf29b 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -452,7 +452,7 @@ static void tcx_dac_writel(void *opaque, hwaddr addr,=
 uint64_t val,
>  static const MemoryRegionOps tcx_dac_ops =3D {
>      .read =3D tcx_dac_readl,
>      .write =3D tcx_dac_writel,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> @@ -533,7 +533,7 @@ static void tcx_rstip_writel(void *opaque, hwaddr add=
r,
>  static const MemoryRegionOps tcx_stip_ops =3D {
>      .read =3D tcx_stip_readl,
>      .write =3D tcx_stip_writel,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .impl =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> @@ -547,7 +547,7 @@ static const MemoryRegionOps tcx_stip_ops =3D {
>  static const MemoryRegionOps tcx_rstip_ops =3D {
>      .read =3D tcx_stip_readl,
>      .write =3D tcx_rstip_writel,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .impl =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> @@ -633,7 +633,7 @@ static void tcx_rblit_writel(void *opaque, hwaddr add=
r,
>  static const MemoryRegionOps tcx_blit_ops =3D {
>      .read =3D tcx_blit_readl,
>      .write =3D tcx_blit_writel,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .impl =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> @@ -647,7 +647,7 @@ static const MemoryRegionOps tcx_blit_ops =3D {
>  static const MemoryRegionOps tcx_rblit_ops =3D {
>      .read =3D tcx_blit_readl,
>      .write =3D tcx_rblit_writel,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .impl =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> @@ -713,7 +713,7 @@ static void tcx_thc_writel(void *opaque, hwaddr addr,
>  static const MemoryRegionOps tcx_thc_ops =3D {
>      .read =3D tcx_thc_readl,
>      .write =3D tcx_thc_writel,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> @@ -734,7 +734,7 @@ static void tcx_dummy_writel(void *opaque, hwaddr add=
r,
>  static const MemoryRegionOps tcx_dummy_ops =3D {
>      .read =3D tcx_dummy_readl,
>      .write =3D tcx_dummy_writel,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index 60c23b69e5c..2b6836b55ec 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -230,7 +230,7 @@ static void dma_mem_write(void *opaque, hwaddr addr,
>  static const MemoryRegionOps dma_mem_ops =3D {
>      .read =3D dma_mem_read,
>      .write =3D dma_mem_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
> index e0f26466ba3..454f25b185c 100644
> --- a/hw/intc/grlib_irqmp.c
> +++ b/hw/intc/grlib_irqmp.c
> @@ -330,7 +330,7 @@ static void grlib_irqmp_write(void *opaque, hwaddr ad=
dr,
>  static const MemoryRegionOps grlib_irqmp_ops =3D {
>      .read =3D grlib_irqmp_read,
>      .write =3D grlib_irqmp_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
> index 00b80bb177c..6a7be888f24 100644
> --- a/hw/intc/slavio_intctl.c
> +++ b/hw/intc/slavio_intctl.c
> @@ -135,7 +135,7 @@ static void slavio_intctl_mem_writel(void *opaque, hw=
addr addr,
>  static const MemoryRegionOps slavio_intctl_mem_ops =3D {
>      .read =3D slavio_intctl_mem_readl,
>      .write =3D slavio_intctl_mem_writel,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> @@ -205,7 +205,7 @@ static void slavio_intctlm_mem_writel(void *opaque, h=
waddr addr,
>  static const MemoryRegionOps slavio_intctlm_mem_ops =3D {
>      .read =3D slavio_intctlm_mem_readl,
>      .write =3D slavio_intctlm_mem_writel,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
> index 81fc536131c..4af106dcaa0 100644
> --- a/hw/misc/eccmemctl.c
> +++ b/hw/misc/eccmemctl.c
> @@ -232,7 +232,7 @@ static uint64_t ecc_mem_read(void *opaque, hwaddr add=
r,
>  static const MemoryRegionOps ecc_mem_ops =3D {
>      .read =3D ecc_mem_read,
>      .write =3D ecc_mem_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
> index a034df3592f..aaca89de734 100644
> --- a/hw/misc/slavio_misc.c
> +++ b/hw/misc/slavio_misc.c
> @@ -147,7 +147,7 @@ static uint64_t slavio_cfg_mem_readb(void *opaque, hw=
addr addr,
>  static const MemoryRegionOps slavio_cfg_mem_ops =3D {
>      .read =3D slavio_cfg_mem_readb,
>      .write =3D slavio_cfg_mem_writeb,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 1,
> @@ -177,7 +177,7 @@ static uint64_t slavio_diag_mem_readb(void *opaque, h=
waddr addr,
>  static const MemoryRegionOps slavio_diag_mem_ops =3D {
>      .read =3D slavio_diag_mem_readb,
>      .write =3D slavio_diag_mem_writeb,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 1,
> @@ -207,7 +207,7 @@ static uint64_t slavio_mdm_mem_readb(void *opaque, hw=
addr addr,
>  static const MemoryRegionOps slavio_mdm_mem_ops =3D {
>      .read =3D slavio_mdm_mem_readb,
>      .write =3D slavio_mdm_mem_writeb,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 1,
> @@ -245,7 +245,7 @@ static uint64_t slavio_aux1_mem_readb(void *opaque, h=
waddr addr,
>  static const MemoryRegionOps slavio_aux1_mem_ops =3D {
>      .read =3D slavio_aux1_mem_readb,
>      .write =3D slavio_aux1_mem_writeb,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 1,
> @@ -282,7 +282,7 @@ static uint64_t slavio_aux2_mem_readb(void *opaque, h=
waddr addr,
>  static const MemoryRegionOps slavio_aux2_mem_ops =3D {
>      .read =3D slavio_aux2_mem_readb,
>      .write =3D slavio_aux2_mem_writeb,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 1,
> @@ -310,7 +310,7 @@ static uint64_t apc_mem_readb(void *opaque, hwaddr ad=
dr,
>  static const MemoryRegionOps apc_mem_ops =3D {
>      .read =3D apc_mem_readb,
>      .write =3D apc_mem_writeb,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 1,
> @@ -355,7 +355,7 @@ static void slavio_sysctrl_mem_writel(void *opaque, h=
waddr addr,
>  static const MemoryRegionOps slavio_sysctrl_mem_ops =3D {
>      .read =3D slavio_sysctrl_mem_readl,
>      .write =3D slavio_sysctrl_mem_writel,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> @@ -397,7 +397,7 @@ static void slavio_led_mem_writew(void *opaque, hwadd=
r addr,
>  static const MemoryRegionOps slavio_led_mem_ops =3D {
>      .read =3D slavio_led_mem_readw,
>      .write =3D slavio_led_mem_writew,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 2,
>          .max_access_size =3D 2,
> diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
> index 29e24ef6bed..e9e66c2b7c5 100644
> --- a/hw/rtc/sun4v-rtc.c
> +++ b/hw/rtc/sun4v-rtc.c
> @@ -49,7 +49,7 @@ static void sun4v_rtc_write(void *opaque, hwaddr addr,
>  static const MemoryRegionOps sun4v_rtc_ops =3D {
>      .read =3D sun4v_rtc_read,
>      .write =3D sun4v_rtc_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>  };
>
>  void sun4v_rtc_init(hwaddr addr)
> diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
> index 0e06fa09e99..dfe9264468c 100644
> --- a/hw/timer/grlib_gptimer.c
> +++ b/hw/timer/grlib_gptimer.c
> @@ -332,7 +332,7 @@ static void grlib_gptimer_write(void *opaque, hwaddr =
addr,
>  static const MemoryRegionOps grlib_gptimer_ops =3D {
>      .read =3D grlib_gptimer_read,
>      .write =3D grlib_gptimer_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
> index 3e071fbdb4c..81e6e55415d 100644
> --- a/hw/timer/slavio_timer.c
> +++ b/hw/timer/slavio_timer.c
> @@ -329,7 +329,7 @@ static void slavio_timer_mem_writel(void *opaque, hwa=
ddr addr,
>  static const MemoryRegionOps slavio_timer_mem_ops =3D {
>      .read =3D slavio_timer_mem_readl,
>      .write =3D slavio_timer_mem_writel,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 8,
> --
> 2.52.0
>

