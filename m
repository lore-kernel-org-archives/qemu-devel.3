Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5E8C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trahp-0006cE-PG; Mon, 10 Mar 2025 06:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trahg-0006Ub-Gk
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:49:50 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trahd-0004wM-UW
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:49:47 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fbaa0582a6so35510827b3.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 03:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741603784; x=1742208584; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lPdgGObt3I9W5H3oCG0ujbSqzvoCHpdJpv7djxg/VTY=;
 b=mAm6IcypiywWxMzJSct1xCVvVVfSWy+P/kfRDLiMa1tRxjHyQobOjGMKs0UXyddazh
 d7S2gjQ8gyRFiJjR1iooZh50qzA4CBCjnrMAaZApYXHGg+ZUli1oY5TE8sE6LXIjks6M
 QVmlOrz0VK+hDuLveOFHvEKwROATcV4KqSCH3UksW5+c1axuCQ2vrhTQAqXYGFLm38MG
 k9LjgEvh8Kp/bctKTRzdiZ+VnsEDUXjUwNYcWzmcZxDlSNB1AuNHfhVqZjPdPGtArXvJ
 7QjHnntllOhuNg0uVsBPyZeoEsuBzJJU+v7IPyktwvwyN9Qjcg9o0QUr7+LcLjjSK7Dt
 Lmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741603784; x=1742208584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lPdgGObt3I9W5H3oCG0ujbSqzvoCHpdJpv7djxg/VTY=;
 b=bvHOXUctE6gGnBclZvz/TTmXs6LaJaAJQbe/04Nx0g0ApHAUyPyFcSwkm1gwQwxcux
 ZO2YGbEvCZ8eZHVXNqV/obR3149KMuxtT/VjOWND/tXdgqmygHeU99sqBCuxS506OkbF
 4N85EgLltMsFXAECmQKLj0qDMd9V1+QxVeiEtH6qdHHq9P4+/YqFNMebtq0bUt2wM2TT
 KpBGmXKtsxN/p+HMckKAQQ9sd1x7mEtEAmfABQCAeCx4Rw0Fu0bfpNKqSAkKwMwbgtr/
 A4MgG6LkGnqFjTI1HZQC0BVcGh2VNsOhGrb7Rif5ARGPlaasX7imW6c+lMxwehoD8M+L
 H0wg==
X-Gm-Message-State: AOJu0Yx6jaB5EJ61oCVVDTlrvleZfIIXiMcN7YY6kUlWcb7enFPv6W6c
 lY6dJHNiPQDBa3gbnxdCHUyBqmyJkIiGvG4gfcr+rwgYnXIQIRuBhRdpuuAiDzIu1U1HcqqZnYx
 X+5b7CVLNyH5y4V7HmF/PrW4zMjefPBAhQ4wBwA==
X-Gm-Gg: ASbGncuT9WJnLrciES0Hb69qQu8WmLyMtnhpkhZgnHdrjiXQ5pkCwN9W6ElQjk9+3Ae
 S7/Cha0yeHsunJhacNq88PqFHYD3RRMPhFUjiuJT71aOBHSSsA3OPPZSZNjLDA2NaW4w0uX7HV+
 HeThdebus2e/NFL6v0Od7ceD3MKa8=
X-Google-Smtp-Source: AGHT+IFxOTniQtNa/zwfV4kAdswht7O6AS0MIzFwYlsNnMlGfWu3+gJ6Gp3T8T9nXvsarNKl10dZJR3IRzpejU16EM0=
X-Received: by 2002:a05:6902:70f:b0:e60:915b:188 with SMTP id
 3f1490d57ef6-e636f7e9a04mr10189653276.18.1741603784612; Mon, 10 Mar 2025
 03:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca>
 <CAFEAcA9kED+fB1repp2+r-zMfZ_5ZeAkZq2ChyxjSUo1j5gAFQ@mail.gmail.com>
 <aef79501-b99f-4e84-b6fe-14dec1e030e6@csclub.uwaterloo.ca>
 <CAFEAcA9ht=T_XqKaKB-PaNK9joQFYgks37JHjqUO-qkaNe7YUQ@mail.gmail.com>
 <d714a7c2-2291-4a85-abcc-81648da1ef57@csclub.uwaterloo.ca>
 <CAFEAcA-9Nj9KrcPwoBBT88wK=NUPsorT71XbBbyLJYOemmkojQ@mail.gmail.com>
 <3660e47b-0f37-4e6d-8bbd-7d646eb67207@csclub.uwaterloo.ca>
In-Reply-To: <3660e47b-0f37-4e6d-8bbd-7d646eb67207@csclub.uwaterloo.ca>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Mar 2025 10:49:33 +0000
X-Gm-Features: AQ5f1JrK2AJr7PnVsjxXkms3FcAS4rRuyNa3gw_NEhUjC6t3NN5Lnc8cXvVU0Sc
Message-ID: <CAFEAcA87OntUbW+CnebWZirnrHw4ZwFwROeRs4qJd91O6B3U4w@mail.gmail.com>
Subject: Re: [PATCH] bcm2838: Add GIC-400 timer interupt connections
To: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 10 Mar 2025 at 06:29, Sourojeet Adhikari
<s23adhik@csclub.uwaterloo.ca> wrote:
>
> Hello,
>
> So far I've figured out that I need to add a member called SplitIRQ
> in the BCMSocPeripheralBaseState struct, which is of size defined
> by `BCM2835_NUM_SPLITTERS`. Then from what I can tell through
> reading through the codebase, I should do something similar to
> what happens in `exynos4210.c` in the `exynos4210_init_board_irqs`
> function?

QEMU qdev devices have a multiple-stage initialization process:
 (1) 'init', which in this case means calling object_initialize_child().
     In this case you should do this in raspi_peripherals_base_init(),
     where we do this for the other child devices of the common
     peripheral base object.
 (2) set properties (in this case the "num-lines" property, which
     needs to be set to 2). You do this in the parent object's 'realize'
     method, in this case bcm_soc_peripherals_common_realize().
     There are several different equivalent APIs to set a simple
     integer property; using qdev_prop_set_uint16() like the exynos
     code does is fine.
 (3) realize the device by calling qdev_realize(); this has to be
     done after all properties are set.
 (4) wire up the input and output GPIO lines (you want to wire up
     a GPIO only once the devices on both ends have been realized).
     For this case, in the bcm_soc_peripherals_common_realize()
     function we're going to wire up the the device's outbound
     IRQ to the input of the appropriate splitter, and connect
     output 0 of that splitter to the BCM2835_IC correct interrupt
     controller input.
 (5) The last bit of wiring, where we connect splitter output 1 to
     the correct GIC input, we do in bcm2838.c, and only after
     we've called 'realize' for both the bcm2835_peripherals object
     and the GIC object.

> Sorry for taking a while to get back and still having quite a few
> questions about this. Thank you for helping me out with writting
> this patch.

No worries; this stuff is all quite complicated and we don't
really document it very well.

thanks
-- PMM

