Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA85CC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 17:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rniFw-0004nF-6g; Fri, 22 Mar 2024 13:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rniFf-0004il-ES
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 13:00:22 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rniFd-0000t3-Mn
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 13:00:19 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56bdf81706aso1448265a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711126815; x=1711731615; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iE62b2MvnUchjiU4D7F5hdula6uxp4z74Xnn1rbHTbw=;
 b=jkdqZ82iWD/487XNau5oHtrXE8cGv9DvT+6Mvay/mqBQ7rXUFfLr8hUquC/Ue+Shfe
 hnDaOvL2wxzxwbqBXUgTZ68Z1UVKL7DcPbh78xwDrJ/47c5tVYmNzSfR0Zcn/e7XOKt+
 7SDK/OWMa+UBtiSAZgYXW2ouv3UEtTYVAZMYzsiIUADtNK+Ol2vD6Rg1MKTd7GrmEVYi
 9u3Xf9Jt6QgXkFNFszmN521uqtbBotBjpDJIhDCKQRddnQrlGgBgzlS1yOGfHapTWT1t
 1sBzCIkCEyk32JszdO9UW6X5Zsc358ZIZsfZUfP4AMVQFrq/aUbjTTrUqcdgtguse0r9
 JOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711126815; x=1711731615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iE62b2MvnUchjiU4D7F5hdula6uxp4z74Xnn1rbHTbw=;
 b=nYRIlngsXgBEPPH8ZiJOmCGQjZk3O+/DrdgiSUr6N/VuwlMrlwVUW8khWpxZk8EQ0e
 9s4+p0iz02WPEbiMt1cqjU1t6GNM55+AhxpCcBauQf94gsNBsrugfAQ8v7F+d6/DU2KD
 5EmhqJPjpU6+6tdFSObaXps0Sjkq7YnTLbtmIU0Iy906RfTMJ/pT0KNUtr3Bri/oxRTF
 f9t5enPSTqPV2SbiivcY/DOTXL/jfqFHbaa4XNd5RZ8Z++8wKPbley/oC+uRLVAbpfoJ
 S3GaMPCw924DIqVDta6Fotn402uKzwCCSI0JTwvWudUph/OrTL230Hx9L+mX6FyNLjZG
 ysuA==
X-Gm-Message-State: AOJu0Yy2DgcBHH+sXFRwsqoBi0J2TZTtufMvLIO2GUOh83uJ+4g2N14Y
 ImeEroUKAbXZlWGjHmNqyiBiIWUfxtAuo8w2T5iDkGz7uN3A+xRV+Cm+aBXZzvl+Iwd+S8r3oNY
 evzpwnts5lCeCUtsUycTRC55SGlkM96Jv6bR92Q==
X-Google-Smtp-Source: AGHT+IGKW9Oo9XMKUMnoAnSL0q1fuzw+xlBmD1IOVOJrk2BdVJQbrJ22dBmZ7xGVZoSGLjqRaDo5eGQWYiqZA9E7cLY=
X-Received: by 2002:a50:a402:0:b0:567:3ed0:47ec with SMTP id
 u2-20020a50a402000000b005673ed047ecmr70558edb.23.1711126815415; Fri, 22 Mar
 2024 10:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240320202100.820228-1-balbi@kernel.org>
 <20240320202100.820228-2-balbi@kernel.org>
In-Reply-To: <20240320202100.820228-2-balbi@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 17:00:04 +0000
Message-ID: <CAFEAcA_37PUFoyKF=grHOEzDvMGws8NXpH+eNyLSCyq4Cz+0Cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/arm: Add support for stm32g000 SoC family
To: Felipe Balbi <balbi@kernel.org>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 20 Mar 2024 at 20:21, Felipe Balbi <balbi@kernel.org> wrote:
>
> Minimal support with USARTs and SPIs working. This SoC will be used to
> create and nucleo-g071rb board.
>
> Signed-off-by: Felipe Balbi <balbi@kernel.org>
> ---
>
> Changes since v1:
>     - Convert tabs to spaces (checkpatch.pl)
>     - Correct lines longer than 80 characters (checkpatch.pl)
>     - Correct num-prio-bits (Samuel Tardieu)
>     - Correct num-irqs (Found reviewing RM0444)



> +static void stm32g000_soc_initfn(Object *obj)
> +{
> +    STM32G000State *s = STM32G000_SOC(obj);
> +    int i;
> +
> +    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
> +
> +    for (i = 0; i < STM_NUM_USARTS; i++) {
> +        object_initialize_child(obj, "usart[*]", &s->usart[i],
> +                                TYPE_STM32F2XX_USART);
> +    }
> +

I was just prompted by another patchset on my review queue
to look a bit more carefully at the USART section of the
datasheet, and I think that TYPE_STM32F2XX_USART is not
the correct UART type for this SoC. That UART type has its
registers in the order SR, DR, BRR, CR1, CR2, CR3, GTPR.
The G0x0 SoC describes a UART with more registers, in a
different order (CR1, CR2, CR3, BRR, GTPR, RTOR, RQR,
ISR, ICR, RDR, TDR, PRESC). That's more like the device
that this patchset adds:

https://patchew.org/QEMU/20240317103918.44375-1-arnaud.minier@telecom-paris.fr/

though I haven't tried to cross-check all these reference
manuals to see if it is identical or merely quite close...

thanks
-- PMM

