Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16E8C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOFUx-00086U-2k; Mon, 01 Jul 2024 07:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOFU6-0007wZ-FI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:46:26 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOFTx-0008Gg-DU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:46:11 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57d2fc03740so173303a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719834354; x=1720439154; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiO0s+uzFWd+yJ74WL4erzUe6A12ZMxbgR44q/NNRls=;
 b=I9CqYODKvErPGKd+W22VWD0iiFNpwoRfyJ9U9l0uBqF09EEs/BcUMqP59I3APk5rGs
 U651lfw43DdsxbXEYG0NYbTReD3kilOjh2mRdSxoah006oq73lmPs1S3uk7twkOo7AkM
 b1LpEb/e/1EkgCBKxfvDYi60tGkH/w7hdwipTXYicAMha85i0JbOgxiMitSAJsXSNyfe
 gpMnzH8ILJmONYhZAR+rn//phSLB80LrzwxvN1OjyaV5oi3EWunXs1YX3jAgCHjr1Do0
 6J7q79Wu5WdETEnGkAzPz6vuZdtu3/q1pGL2xWgI6q8GQ43ClIg46IN7992GUQYQe7G/
 h+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719834354; x=1720439154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WiO0s+uzFWd+yJ74WL4erzUe6A12ZMxbgR44q/NNRls=;
 b=gGJwHVG1mfJ6KmbpZ6DaSDmxe+wfKllHXyk0wUOvNDzUw4M37DKJ9x21umTMWm4sKh
 eHH4wzNC4S8qRGTWrf03QQTnpOOU7ZZL0oobaGWSaU7h/ZJ6VuBm2LPK3r+mDOtbmWYd
 tr67lYxGxMA673RA8plSX1eehlN3L0cwgqO95kF/t9dyDoGDdLCusDB7g8AiIAXFBUIJ
 +F0Dbhvd/PVa2GxryM38NBtGvkgh/JvIvzjOaYDypPf/YmE2SoShfu4IvwNN0EHZtkPv
 sGdLP1I5pXB1S9xSzHU2nU99BZbycPFmS1T6BWnB9iVYTkHtu/346xTWW2Do07OGVsEM
 FLew==
X-Gm-Message-State: AOJu0Yynrk/SMn8qI+ns4dCevissVeIlj0Qat41mlfQLJOAEqg1P2EZ3
 /ZFaxDYfe6hbnZ9brygFzGndA/rRjykpDGjm/L9kXFyn7EYWF77PzJ2TKeoecMkwr2bfTtkZ4bl
 rKPfM3YHlQBWwxLrUEmGEkYwGBeVutAwO99je7hv4M8SPVLNQ
X-Google-Smtp-Source: AGHT+IGZJMRvhpdLSC5nmdQKQQjmmx60nb0Av7byBfzYWiWUcpXsge6WvvqJIC2oGbCSiQRfA4+H1XQ4P7s6j3PtuCU=
X-Received: by 2002:a05:6402:430b:b0:57c:74ea:8d24 with SMTP id
 4fb4d7f45d1cf-5879f59c5b7mr3401054a12.18.1719834354362; Mon, 01 Jul 2024
 04:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240629104454.366283-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240629104454.366283-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 12:45:42 +0100
Message-ID: <CAFEAcA9qZJbma3TNWf1hw3gndUYOkE5XsOgtf65jsDcg9pP7dA@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Fix STM32L4x5 SYSCFG irq line 15 state
 assumption
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, 29 Jun 2024 at 11:46, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> The QTest `test_irq_pin_multiplexer` makes the assumption that the
> reset state of irq line 15 is low, which is false since STM32L4x5 GPIO
> was implemented (the reset state of pin GPIOA15 is high because there's
> pull-up and it results in the irq line 15 also being high at reset).
>
> It wasn't triggering an error because `test_interrupt` was mistakenly
> "resetting" the line low.
>
> This commit corrects these two mistakes by :
> - not setting the line low in `test_interrupt`
> - using an irq line in `test_irq_pin_multiplexer` which is low at reset
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---



Applied to target-arm.next, thanks.

-- PMM

