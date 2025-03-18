Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF37C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 15:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuYrf-0003kQ-S5; Tue, 18 Mar 2025 11:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuYrS-0003iQ-1L
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 11:28:11 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuYrQ-0002Hr-DK
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 11:28:09 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e60cab0f287so4296707276.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742311687; x=1742916487; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v7cPFDSthr33Q6tCh7ULaY+4IQO00JywDq8ExWVq/IE=;
 b=oGNhUIkrHjiBdtZM4D1ZqjP5eQH/8QlPsy3Q9gMd7+4AWXj/5NyPteC9cC8+OTuzKk
 ikBP7G0BxeOUddxS2QZDyRdeXoT5dKN/TYyZ4YTmn+FEsp+eHo2aTxnj5yw24x2chmWg
 P/O+Dx9rEVcngjhR5oCf2WnINTSVQWe4mgIyLWKEX8sGqBbw9/OLnBNOETgkU8SoaVoZ
 EcFseA2jYb7XVT49e6ckpbZ4mMKy3zcn1r0YFcBdH5GvK6EyaLFN6XuQ9YOyHdc151N1
 LKWEpQhpC4A40V8JOrIjUS7mW0KKjG6gnhk7aeE5Zu7joSlLp2Qb5d9Ja3ESzeUSO81B
 z9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311687; x=1742916487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v7cPFDSthr33Q6tCh7ULaY+4IQO00JywDq8ExWVq/IE=;
 b=IQmKuBMlkpbkC0lndnvX0/e6EGBSZ1Mr4RujC8eneP8BwlwRBA7vrbW8A0Ssm7ZQxP
 D4eJGAvDBZu8D4J7p1sZvRNC5S+GP47SkX1DzDvgK2t65BTpz37wliNcAyksV9FJEm59
 1VXBrTHc4FmEijXvUR9kRqB7R9jPMKQKAEPFn8XA1VUsJNbCl1DfV+GI5Iagf7gvUR+y
 CUXxJ4WENbDMfvYV1qNnQvd7iVR7VsQ5MAlj/l7H8bcq6ovzhCKJipmtfIawE7AJaYyG
 qugzQuu/OuqyOBDoq48eNY3RcpXO32hh/8auZnBuKnjDM4aD88RlUavKAKhbZq4DKWWw
 A86A==
X-Gm-Message-State: AOJu0YyWkhvyjAX4XW5JOiQpy99j8q02fybRn15FaJoIRRT/M9pteGpM
 lz9dl0FloVd325+zyEYYCug22RjJAxzPIf52UGUOcYBMK+ltVT/Q6a6o10kMYUXVPEagYjSTji9
 dQ/BjKDqLI6JEk7lGQT7v0gZspuuO2EwDe3SMQw==
X-Gm-Gg: ASbGncuF7vqNxcKuWqBFHvA9rOVIBB+KOuvWpaf0BHQLuadR/6US5IS+jr91Xt+djQK
 OOW7Ozeee8wcpokAp/IuprThL53GzVJadt9K1ZY70xkJA8hCLtnS3SygPnirD12HnlvxqQ1BEb3
 F4F7R0ufJtkAikQriAC4xOxytTh0g=
X-Google-Smtp-Source: AGHT+IHbYhPLA3PkyD0YUWpst6DTfYPiT93WR+6sBXtRP4NlkR1WeKfU57/bVyAxo50UAB0SRlFf2hnCi04QaFC5Y2I=
X-Received: by 2002:a05:6902:228e:b0:e63:d13e:80e3 with SMTP id
 3f1490d57ef6-e63f650e8d8mr19266542276.16.1742311687128; Tue, 18 Mar 2025
 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250314183224.21822-1-shentey@gmail.com>
 <20250314183224.21822-2-shentey@gmail.com>
In-Reply-To: <20250314183224.21822-2-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 15:27:55 +0000
X-Gm-Features: AQ5f1Jpc2pEfHze4iJx5dRfKEsiostFl3TcVa1Y1ouUt9gw1LWCCh3T4eVrSzNQ
Message-ID: <CAFEAcA8DPonw1+GsBJ079AfeSyO9=3B93P1yj3uLTBzF4uf0Ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/arm/fsl-imx8mp: Derive struct FslImx8mpState
 from TYPE_SYS_BUS_DEVICE
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Fri, 14 Mar 2025 at 18:32, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon machine
> reset. It also makes the SoC implementation not user-creatable which can trigger
> the following crash:
>
>   $ ./qemu-system-aarch64  -M virt -device fsl-imx8mp
>   **
>   ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: assertion failed:
>   (n < tcg_max_ctxs)
>   Bail out! ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread:
>   assertion failed: (n < tcg_max_ctxs)
>   Aborted (core dumped)

> diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> index c3f6da6322..82edf61082 100644
> --- a/hw/arm/fsl-imx8mp.c
> +++ b/hw/arm/fsl-imx8mp.c
> @@ -702,7 +702,7 @@ static void fsl_imx8mp_class_init(ObjectClass *oc, void *data)
>  static const TypeInfo fsl_imx8mp_types[] = {
>      {
>          .name = TYPE_FSL_IMX8MP,
> -        .parent = TYPE_DEVICE,
> +        .parent = TYPE_SYS_BUS_DEVICE,
>          .instance_size = sizeof(FslImx8mpState),
>          .instance_init = fsl_imx8mp_init,
>          .class_init = fsl_imx8mp_class_init,
> diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
> index e1a7892fd7..f17d5db466 100644
> --- a/hw/arm/imx8mp-evk.c
> +++ b/hw/arm/imx8mp-evk.c
> @@ -37,7 +37,7 @@ static void imx8mp_evk_init(MachineState *machine)
>      s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
>      object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
>      object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
> -    qdev_realize(DEVICE(s), NULL, &error_fatal);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);

You want sysbus_realize() here, not the _and_unref() variant,
because the device was created with object_initialize_child().

The pairing is:
 * object_initialize_child() + sysbus_realize() / qdev_realize()
 * qdev_new() + sysbus_realize_and_unref() / qdev_realize_and_unref()

(See the doc comment in include/hw/qdev-core.h for
qdev_realize_and_unref() for more detail.)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

