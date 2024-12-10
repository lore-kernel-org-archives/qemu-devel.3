Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3160DE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 10:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKxAz-0004tu-HZ; Tue, 10 Dec 2024 05:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKxAy-0004tb-JZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:09:08 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKxAw-0003fW-Sl
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:09:08 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa6413fc7c5so530552266b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 02:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733825345; x=1734430145; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JPdZXS11WAv8JNbXc9t5nA54ppVL6v0VIJHahgnNRRg=;
 b=H5cavqccKjKBSgRpOAgAXexRJY9XDvCnslfohcoISlf3xZnCbcQse43TrHg/SyCZDm
 qaRukGSIOcmnGIWNLxdYt0BREH6cCeoNVduY0xL1Whm328FqaG55ZdeVEylL4/8D+BlZ
 JiyONEK5ED89T9sop/HW7uXj3VO3qhcGzYGOhjIEHREpvNIQkMVeN6UyTIX8PbroOOSd
 kYiHylNNSjsnXNI7o1MWC9hAxP+TLhbagiMwi0N6gjP3RGH8V7iYDvIWwB4kXJKATuiS
 mimLuln+qaAkLM/gDy3CSnJoG1yHvnME4NUny+ik5G8oewEmYXwDFkxvR4BtorFq2MKA
 9f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733825345; x=1734430145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JPdZXS11WAv8JNbXc9t5nA54ppVL6v0VIJHahgnNRRg=;
 b=Hu94gGE55rrdZ5eU802+J3z8ZDZQpmAciJmWAZVz3zRxIjSs2CuuRs4WS8y9/tOqW9
 CqjhRXWejfyhVzXVBEBTG58y6l6tjh+x3p+6Y1L/rDm0bf2rlXyXLoKUln7mLoPwFJug
 ypzVDxtLXqryNqTyECw5iNJ8/xIkVdiavXKuA84/Y6gOcsYTzQeA2a1CpLX2v3ibf1xk
 bkl+zt/m/UmyjjdbrRWwgqMeIh20iTeYaTVSjVuAVEa80klU0NwlhFWpS04mGgN0titg
 OcmW/J0HoQLnMYqmQcy0k4Aurz7cfIuPf2DEzDTVxPVDXqXIBWDgojKa/KpEDIrD6bVq
 HHQw==
X-Gm-Message-State: AOJu0Yzzek/1eqQ51RfwLgN72ohxvLhSt04v6AEYR/hzHCxktmWF/J4d
 KsllUhtkVX5kG6UzhFKqXtTkWNe0z03ZMXxi03TineLxl1g7NTRCI/06ynGcZvJm5iBnoVWRLCN
 mQAgJpduohC8VVOvAkVF3/1tex305ythvylkRBM7oSNGhz8a4
X-Gm-Gg: ASbGncuzTf6LwHXruW3rPHBplCK0Nv0ssMlkLQqmkbPyW99dll5sI9nZFRbtWNs/J2j
 hV9JG/KG0hoyD/JJQG3R9bljKewIbHq/m0yUY
X-Google-Smtp-Source: AGHT+IH081EyIQjBQVQIXMAinm1S5xzBNNocvv2pj7HaPZdrYWNrCsEgymrI13ykUsIwXiu3S6xfyS6wdyj6u3PmEwM=
X-Received: by 2002:a05:6402:42c6:b0:5d0:ea4f:972f with SMTP id
 4fb4d7f45d1cf-5d4185060b8mr8354889a12.8.1733825344794; Tue, 10 Dec 2024
 02:09:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1733783500.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1733783500.git.pisa@cmp.felk.cvut.cz>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 10:08:53 +0000
Message-ID: <CAFEAcA9FcCr1Zz+N+QkZUC5q0o+02GRje6YqRQy5d6v55D0CgA@mail.gmail.com>
Subject: Re: [RFC/WIP 0/3] WIP CTU CAN FD IP core mapping to the platform bus
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Mon, 9 Dec 2024 at 23:33, Pavel Pisa <pisa@fel.cvut.cz> wrote:
> our CTU CAN FD IP core is used on many FPGA platforms
> and has been even tapeout on some other university
> and even prototypes of the massive production chips
> (support for that organized by our former student
> in his company).
>
> But actual QEMU emulation targets only PCI/PCIe mapping in
>
>   hw/net/can/ctucan_pci.c
>
> of the core in
>
>   hw/net/can/ctucan_core.c
>
> I would like to add support to map the core at fixed position for
> SoCs and command line controlled location for FPGA targets.

Command line instantiation of devices at command line
controlled addresses and with command line connection
of IRQ lines is basically something we do not
currently support. There is some prototype/design work
going on about generic "create a machine from
the command line" handling, which would inevitably
involve allowing the user to specify addresses and IRQ
lines. But I don't really want to see ad-hoc device-specific
additions of small parts of similar functionality.

If there's a SoC that QEMU models that has this CAN
controller, then it's the SoC model (written in C)
that defines where it is mapped in memory and what
IRQ lines it is wired up to.

thanks
-- PMM

