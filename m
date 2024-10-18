Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8ADD2FFFA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1p3o-0001K7-5E; Fri, 18 Oct 2024 11:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1p3n-0001Jx-6c
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:38:39 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1p3l-0000Tq-6q
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:38:38 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso3851859a12.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729265915; x=1729870715; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=22e+AwVFs/2jb6cCc5l+7cN5yNe3vbM4QSll7c09c2M=;
 b=gnbfBBRG2rWqcXYARhMZXR3PT3hMZif3oimJGvFL9w7fhbiLOt/FXO0VnVhg1uLlsF
 9NBfTmyU6dUUEWz2P/NmRzoG1Vjr5KrQtJUHaQ3J7NFl4XaNRdeRBs8NfWEDLE8fT4vh
 AswdshM4Tb3VfjrLQvwQpg11VrppLahF4B5NyvmuN5eUM2u6ulJL+EC0TCg+pAG4vV10
 4gHHMkcnySxnPBfToAPF4p6VMrcVTiefR2//S4pDGPAH/lue2P8988ruNfTSWe8yAax1
 IbapSa3SS1ilKb2H2xRdNpJRzcaWgLB27lUr1+zY61rodyHF6AdrkYAZIWyVM0sw6idb
 Z4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729265915; x=1729870715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22e+AwVFs/2jb6cCc5l+7cN5yNe3vbM4QSll7c09c2M=;
 b=jD4RPHFMGvd7xI+gPlczEIOzeo7PbGLL2esNOGZxl8wAvKiYxRFViGQ5EBapbrDTkJ
 5l2nb0FxoAyB7HBs1BKOK6BK1bd5z2tKYKwyzwSSdxMn7fPhf385IAjcM++EsBIteQIJ
 9U+ZfoZn3hi9HBFKIpMlhjZ2mAbb/chQ29/D0dyGADUyu3RdAZaKAYo2imnBhYLghk62
 0H2gwr9nL4OQJldeF9gnIS2Ml0s0v8SG5YTuBsAuUnHj6warEMSw9DIiZwa2/mIyYsdH
 ITLXRv+f0hgY9AAHcimVDjKzPZr5gXdknSNMQgLLtlo3NOOsUKkAim30slRmi3WhJM2F
 AQ9Q==
X-Gm-Message-State: AOJu0YxrrAY8F/lv5yIXcxR5n/zoJO4ibabZqo9Ik1LfeV0hALq/dpOV
 0rvkwiDrFioBXnXJa+9GM0hAa0yy0r0x0fv0cMl6uAsgHLccgvakJREVrfUqyrmPPCF7BgvxEWE
 ZP3ojR+6xnr2w8HTYHOMuNcEr5uUF2vJaf/H6rQ==
X-Google-Smtp-Source: AGHT+IHJFN7n/M+4xw87/t+z7MunTJ2de4TdTSnlcE3bDkWF4gTkAmp5S84vh1t+R8lEp3Sbb5ShXGJA//5ldTGc2sE=
X-Received: by 2002:a05:6402:2187:b0:5ca:efb:b87d with SMTP id
 4fb4d7f45d1cf-5ca0efbb8c5mr635284a12.15.1729265915138; Fri, 18 Oct 2024
 08:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241010173929.3910466-1-tavip@google.com>
In-Reply-To: <20241010173929.3910466-1-tavip@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 16:38:24 +0100
Message-ID: <CAFEAcA9X1bdtxRL9fm_rnw9ezMZSW6HaURfMsA4aLMSHM4fzdw@mail.gmail.com>
Subject: Re: [RFC PATCH] cli: add connect-gpios option
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, armbru@redhat.com, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 10 Oct 2024 at 18:39, Octavian Purdila <tavip@google.com> wrote:
>
> From: Valentin Ghita <valentinghita@google.com>
>
> Add option to allow for connecting device GPIOs. This is useful when
> adding a peripheral device from the command line which uses an
> interrupt.
>
> It takes the following options:
>
> * in-dev-path, out-dev-path - required, the device canonical object
>   path (e.g. /machine/peripheral-anon/device[0],
>   /machine/iotkit/cluster0/armv7m0) for the devices that should have
>   their in <-> out GPIOs connected
>
> * in-gpio-name, out-gpio-name - optional, the name of the GPIO list;
>   if not specified, the unnamed GPIO list is used
>
> * in-gpio-index, out-gpio-index - optional, the index in the GPIO list
>   that identifies the GPIO to be used; if not specified 0 (the first
>   GPIO in the list) is used
>
> Usage example:
>
>  # add the tmp105 sensor and connects its irq line to the CPU
>  qemu-system-arm \
>   --machine mps2-an505 \
>   --device tmp105,bus=/versatile_i2c/i2c,address=0x50 \
>   --connect-gpios out-dev-path=/machine/peripheral-anon/device[0],\
>     in-dev-path=/machine/iotkit/cluster0/armv7m0,in-gpio-index=100


This seems to be moving down the path towards "create and
wire up machines on the command line". We shouldn't
be doing that ad-hoc with one small commandline option
at a time, we should be doing it with a coherent plan.

I think Philippe will know the current intentions in this area.

thanks
-- PMM

