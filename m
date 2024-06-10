Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CDEC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 10:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGcEQ-0006Rk-SY; Mon, 10 Jun 2024 06:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGcEO-0006PH-VY
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 06:26:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGcEN-0006RT-DO
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 06:26:28 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-579fa270e53so6198308a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 03:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718015185; x=1718619985; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B+0S2S3y/CMnhCnf/lsuxsN0Bi/akVzrpyE/1Oik1Ds=;
 b=rPSctzwCaMHm2w1FwGC77gd5hXgrks+gUQK4XBLHZqC8sUudbyYlmRUzUjtWz5ZaMa
 ES3raOtJPJZH+vFc1GPca5AIUIKvWCSEMEG7x3KLLN1cDQ2o/gZN6PR1VOvpuEzX7k0q
 vsnagYq7Y6DyyELwMYVJkAMW2zGu3WrqQXS6Klla4tShmpR1Bq0DvG1UPLOUInvJx2Fn
 5trBwpDfWJthUSlQPK5oT9StIXave2aOugfql+egEhiFB6CoN9AAU3tsvmUy+tOAp38G
 Gm4wRbfjqnaq7eQqpV7WQfJz6qDUE4bXfy/pgHruSVw8GXf0uJPFXbiLCDwTCunjbI9u
 W0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718015185; x=1718619985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+0S2S3y/CMnhCnf/lsuxsN0Bi/akVzrpyE/1Oik1Ds=;
 b=A6aZ815tlM7LzemkbFyhrJkUP65r8AzXo38adS8SnrtJQ0zFFOtRwepMMvAmSJUZMZ
 xrthRQBhlGtmby3wHn/xnfhp0XsvTFSs52TGR1ERfzfw3D44datkIq6AEOH+lWXPrJr5
 yYzG/NJij/OmmchSz0zlDoyaJwByiKUON9XEH1EcsTvDFgPHEOBwxOGI5NmVrGoVPXiX
 CYo4xUyfAAO3HkNWhDFwizlT6JOv0/OaLHT+3FnAblU7SKnxBhA2s1c2WLMedk46lQq1
 RHoOYJdMotWoPK5Y4ZN4sSsgUVY27EA/nBVphziW80/4z8juJguvcS3A8ALnkW7HHbQq
 vU/A==
X-Gm-Message-State: AOJu0YxJr2FlE0FwenbjKRTlYIDwADKDC0lnqwFcogjDVhdv1nGIR6XG
 ZW8TG7xwVRx9dt9qsRYOdlcOiTfSLDX5QLPcz4w2mv81kkw0Udl5IxGqNP72keEvSqXGhSkogOA
 E1BIxvrngtOItKynf/dSfXbZH9JDGlqJh0BFHLg==
X-Google-Smtp-Source: AGHT+IGVSLJRwYhNxC7xyEQyTGKnOVmSvnXSFyWsONQ9FIMeYxQzurJEo9u+dOUR1zE6nesvLbz0420hbExXWIbgWN0=
X-Received: by 2002:a50:8d1e:0:b0:57c:74b1:bf51 with SMTP id
 4fb4d7f45d1cf-57c74b1bfb2mr3461690a12.20.1718015185260; Mon, 10 Jun 2024
 03:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240610052906.4432-1-sebastian.huber@embedded-brains.de>
In-Reply-To: <20240610052906.4432-1-sebastian.huber@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2024 11:26:14 +0100
Message-ID: <CAFEAcA_ixDoJWMvDgkU++kaF4D51YtQFbEX8joexVCZ-J0Xndw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/xilinx_zynq: Fix IRQ/FIQ routing
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 10 Jun 2024 at 06:29, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> Fix the system bus interrupt line to CPU core assignment.
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> ---
>  hw/arm/xilinx_zynq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 7f7a3d23fb..c79661bbc1 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -252,10 +252,11 @@ static void zynq_init(MachineState *machine)
>      zynq_binfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
>      sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
>      for (n = 0; n < smp_cpus; n++) {
> +        /* See "hw/intc/arm_gic.h" for the IRQ line association */
>          DeviceState *cpudev = DEVICE(zynq_machine->cpu[n]);
> -        sysbus_connect_irq(busdev, (2 * n) + 0,
> +        sysbus_connect_irq(busdev, n,
>                             qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> -        sysbus_connect_irq(busdev, (2 * n) + 1,
> +        sysbus_connect_irq(busdev, smp_cpus + n,
>                             qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
>      }


Applied to target-arm.next, thanks.

-- PMM

