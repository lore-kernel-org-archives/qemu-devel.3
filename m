Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80330C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 16:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg5wI-0002i1-JW; Fri, 01 Mar 2024 11:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg5wG-0002g8-7d
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:40:48 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg5wE-0005xQ-P6
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:40:47 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-565a2c4cc1aso3536941a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 08:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709311244; x=1709916044; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R/nXBmX8e8uzDmEoRjdCz3NH1B7xvuvWUb7srSpPGDo=;
 b=S8V7dvnpa64edSGNdgmv18QhGHILciwCZ7t2vAtMLolL2/jHlshGkfMJVh3BD5BvWD
 KBGiiN9oRGDYbFB4ZW2DUxgkbpq2UXWH1P4xWGEHRLQTEFY/RmbcSZsqoKxVV61nPwgJ
 T4CNhZlr79E4dB5PGzIKjsCmDMlwGSaQGMXDudU9vbc0GwYPoSffW3Pp8Y6PIoM7jOmU
 TgAQQTbyi7LtdyJqtBis1jY6d5hrNvd3AMmlZ1NAVMc8x/zJ5Mk5h4dQPdkxmNUE+GLb
 u/Uf66yOn5M/Gz06eD1Txpzrl6eLthJdB/k2nedL+U/5KgKhUHwT3OWAtyaj9XqHeo8s
 2x8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709311244; x=1709916044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R/nXBmX8e8uzDmEoRjdCz3NH1B7xvuvWUb7srSpPGDo=;
 b=m9M0heIBzOfDGEEhBM6U06gjF4D827r/G+xnFsF+G4Vw8VJDNAAO/Q2fXf1QeJx+jh
 uOnUqv/JpGV4/te38SD4IQ4wla/G+eVo/w+++HwWUMJe+BpLo1Jg4E+qa8kKssdt+43K
 XcHcb1wT9FsFAOY6W5teLXrwkE+ANKmKtY0APBIgzGL0m6fJjIUFp2ojBfmAanpr5b7w
 WzD4yuNdnXbkKiB4Ly0+6BnaDrqSNV9OFGozQ1vBKSKYsBIKCTAGzoJwrP/r6A5ek22S
 fvzBCcZTJHP2kQrfFn+F9CqUck1z0UKOO182l9c+cw/afkQ80/bZjDXNxSxFhFYJdX49
 SYrg==
X-Gm-Message-State: AOJu0Yz/Cg7EB7PrOUD9fA4H8LHjnCG1J1ha78AZ2Bhz5ijho4IGKGZR
 MnKYOlU7rjlpjQaxvlqMwGerTUAp75kdSc/1gNLwsPiO0ZNwCN6IcQqoU6HwdJWXRJM8CLWy22U
 r8K5DfuGgIls95Z9IrAY7LbWuFtAYiMong2BKsg==
X-Google-Smtp-Source: AGHT+IFtY8AX1dSKMMXWyYFSAJnkp9IZi4ugQuUcvQyutqHW+qWXMKpi/LoCSGcSoIBKq+upD03VmpwduOIZmb8SC1M=
X-Received: by 2002:a50:c943:0:b0:566:bfd7:4c3b with SMTP id
 p3-20020a50c943000000b00566bfd74c3bmr1878148edh.30.1709311243805; Fri, 01 Mar
 2024 08:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20240227222227.74935-1-greg@gpanders.com>
In-Reply-To: <20240227222227.74935-1-greg@gpanders.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2024 16:40:32 +0000
Message-ID: <CAFEAcA-wrdUaH55ZmoCQAQ=zV=seaCo2hciXys_p4tKE08Tf3w@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: zynq_slcr: set SLC_RST bit in REBOOT_STATUS
 register
To: Gregory Anders <greg@gpanders.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 28 Feb 2024 at 01:40, Gregory Anders <greg@gpanders.com> wrote:
>
> When the CPU is reset using PSS_RST_CTRL in the SLCR, bit 19 in
> REBOOT_STATUS should be set.
>
> Refer to page 1602 of the Xilinx Zynq 7000 Technical Reference Manual.
>
> Signed-off-by: Gregory Anders <greg@gpanders.com>
> ---
>  hw/misc/zynq_slcr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
> index d2ac2e77f2..a8f1792bf6 100644
> --- a/hw/misc/zynq_slcr.c
> +++ b/hw/misc/zynq_slcr.c
> @@ -120,6 +120,7 @@ REG32(RS_AWDT_CTRL, 0x24c)
>  REG32(RST_REASON, 0x250)
>
>  REG32(REBOOT_STATUS, 0x258)
> +    FIELD(REBOOT_STATUS, SLC_RST, 19, 1)
>  REG32(BOOT_MODE, 0x25c)
>
>  REG32(APU_CTRL, 0x300)
> @@ -562,6 +563,7 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
>      switch (offset) {
>      case R_PSS_RST_CTRL:
>          if (FIELD_EX32(val, PSS_RST_CTRL, SOFT_RST)) {
> +            s->regs[R_REBOOT_STATUS] |= R_REBOOT_STATUS_SLC_RST_MASK;
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>          }
>          break;
> --

The manual also says that "This field is written by ROM code",
so as a model of the hardware should QEMU be writing it?

I've cc'd the Zynq maintainers for their opinion.

thanks
-- PMM

