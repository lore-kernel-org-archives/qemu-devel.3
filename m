Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC9CD68BFD
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 17:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFGbs-0003wd-0L; Sun, 24 Nov 2024 12:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFGbq-0003wQ-RC
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 12:41:22 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFGbp-0000Ih-7G
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 12:41:22 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa531a70416so94213666b.0
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 09:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732470079; x=1733074879; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rO/MGOgGuP6K1EnUID1C89nKEoZ1gj260NZVSMO6eFA=;
 b=HNE+IHpDFcxKxearrMjrp4uVy4J1VmwXZ5dHtLvhM2twJzMA1O3f5zeiBmkqIad/Mk
 /xMneIuDzjeehZtil4pI0YF3XPKiqnNdDrP6P1ezVu6QzUxKK877jbhjQ+9U6MBtVbu2
 60Y4pNjj9RlgZupRwa0QRnNk6HX1iPg5EtV0/6/kldFiXd1oKSsnAiaWdxjaor/KDeCY
 eQn0PlurfyDB7SLG5cE9iqhxR0ZwnL0ZTagyocxoohZRsrvpKzqIQVZoAreAyp93fP1P
 TFfj0gAP3AtQ4xihhbRFbwhqo5Gc5I/vn3JN5NL3uKukSm8jTc8KqRkKCvA3sMr3NIVD
 ax7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732470079; x=1733074879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rO/MGOgGuP6K1EnUID1C89nKEoZ1gj260NZVSMO6eFA=;
 b=wFb6geI/8YOltrtffJDJ0G0AnbSI/eTFTTFgnkKFtnC9ZPAbVlHTA/LSJpmAKuW6Zw
 QOSBF1qyD9lKkxrirbXXMzJtQZPSSAM8JGfYJOIWA98wB5JQob2DJEfg0pIqc/PyVAFQ
 sEJ9RsZKzaH8ygMvgsVAwG4+nlQe64t2H2g5vS+47iVs87ILDU4laUo7lQlZhL0vlGym
 wS6PN0krm5jxj1kflm73HNFqhvAcXe480boPDytlLIG6aw1iix9TpICVgfCfcB9PVlyd
 H16BuyHCYZZOT+qD7Q4T1MW3p6M/Q39r/CcW0M/08TT/UtdfuUwq3j8wT07gG5/cxUF/
 mzDQ==
X-Gm-Message-State: AOJu0YwgxWeLCAL+8GF2YghoG9rHjLw1srqShbevcLX3RvDB6IeBBKrd
 jtRuMR8bkjQZLMqDzWZ0CLGe5UXGCF87+xzapeYORA+XcuDNkKCj7bh7QM0cT9V6Yj1xTBRx64J
 TAOL//kw7QfjCk4mD5ZlUdt1ytXnbbBWnMdgqu+tAIg/z3IJl
X-Gm-Gg: ASbGnct507AjgLdMQzPAWHPjb08ChOBFTvwXuhGv0U5dmIz/t8bYJgDhxMRZrGagx4L
 ezwXjyKQHA7cl4GxsyGkoAtYAu2wj6kjN
X-Google-Smtp-Source: AGHT+IEm77Caugbfby/BmN4R1icH5FefiVNnh/B8WV8ABECQ9sYi8bf5CGrUuV9m8cUgo+N1CDO57eOgcphFnuz4mRI=
X-Received: by 2002:a05:6402:2554:b0:5cf:b9a0:3ad4 with SMTP id
 4fb4d7f45d1cf-5d0207db2c7mr13059029a12.33.1732470079125; Sun, 24 Nov 2024
 09:41:19 -0800 (PST)
MIME-Version: 1.0
References: <m2wmgsiudo.fsf@posteo.net>
In-Reply-To: <m2wmgsiudo.fsf@posteo.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 Nov 2024 17:41:08 +0000
Message-ID: <CAFEAcA_ROEC7UkEzZ5v7FKYHajhLVKZuMAtzA2M8_Fj7KSZO0A@mail.gmail.com>
Subject: Re: Onboarding QEMU Firmware Configuration to other machines
To: Anne Macedo <retpolanne@posteo.net>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Sun, 24 Nov 2024 at 14:24, Anne Macedo <retpolanne@posteo.net> wrote:
> How should one port fw_cfg to other QEMU machines?
>
> Context:
>
> - I found a possible bug on the Debian builds for Raspberry Pi 4 that is
>   only triggered when I try to launch it on QEMU;
>
> - I wrote an issue on systemd (I thought it had something to do with
>   logind) and they requested me to only fill bugs if they show up on the
>   upstream.
>
> - I tried baking systemd with mkosi =E2=80=93 however, to test with mkosi=
 and
>   qemu, it uses fw_cfg [1] which seems specific to the virt machine on
>   ARM.
>
> - Opened an issue [2] and started working on that [3]
>
> However, I still don't understand exactly how fw_cfg works. My current
> understanding is that it is a device that, when connected some memory
> mapping will happen on the guest so that it can access this memmap.
>
> TL;DR which steps should I take to onboard fw_cfg to machines such as
> raspi4b?

fw_cfg is a device that is intended for setups where the guest
knows it is running as a virtual machine. It provides a way
for the guest to ask for e.g. particular files like a kernel
for direct kernel boot, among other things. It's present on
the Arm "virt" machine and on the x86 PC machine.

It doesn't and should not exist on the raspi4b model, because
almost all QEMU machine types are supposed to model the real
hardware, which doesn't have a fw_cfg.

I'm not sure exactly what mkosi is or does, but if it's supposed to be
able to produce images that work with the raspberry pi then
it needs to not require fw_cfg to exist (because on a real
rpi it doesn't).

thanks
-- PMM

