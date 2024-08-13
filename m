Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E7AC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduWt-0005Kw-MQ; Tue, 13 Aug 2024 12:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sduWs-0005Jr-1B
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:37:50 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sduWq-0007GY-3x
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:37:49 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5bb477e3a6dso5499130a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723567066; x=1724171866; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ADK5vny9w0impG7qHucxN7MHTEAdHWKKjNYcf6oRsLc=;
 b=JO6tORQHw+eJ3SlUpDHfPlVAdFzr9I8o9bpWeu0zHH0xUbXBFOSXxxYaxj7ZONtEVd
 LS4LilBb7GrDSr8dVuaHHfK8SU5NDiUMl1uU+HKknGO6WXQ0XCJUmMAL253e6MIpQyrR
 FOW3T8+5a1JpI+0oDb/2lBanvd3h82n+BLOJbv3QPMgXgMuSE6ifb1Ye0zo3UmEXDxJ+
 lWfB/JHAwnetmeWRNIw9iHfmyDDxukEfPlY5CPVP0VBSGnbdb54XKjhRyh2ipjs0nwhW
 CNbqrU5s/9kajSZ8CI8n++nbFI9rOKC1elTRmeR/RjwH9JXI4hZJtNC2nY8FyJod399u
 RS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567066; x=1724171866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ADK5vny9w0impG7qHucxN7MHTEAdHWKKjNYcf6oRsLc=;
 b=HkHyYode+NDQ05dbnUCbDMBQYGfAbqBBMq+AWUfpEyVa/9Qa4C5NsPlUrC43KWMo3U
 EaMdlAK7GgwDORn5A4MyW8NhzsN7+T0N/ivrGT0yAofkIeeRzUvPnemKUKj3PLJiDmHT
 QHhdGW5zX1YRt17OITDfdsHOM5EEbtAUIixI17g/kbZri+bA9IS1YzDY67FIQ1AEGLUq
 7hgcaXwaHfHcOhxm+VhDgo/yQb3vSKkG1nV3LO6Oxv+VjI4sC3o+8an0ysH2fCju0kjv
 ZIwjY+EEfRE8k9NdftfyFw6B1LcRnKRhOiojkTkMGR5in8AYcBuu94bQfV2FzOZ/kYjw
 1oBQ==
X-Gm-Message-State: AOJu0Yz6ZujzJC97aXRHutV5n3cGmSeODETiINwZxXFQ0ZjUmRUZMiP9
 FbMa0tbrqwS8bMCeC6YTalgRa+k2w3387xJtQSNGzX++M34++fDgq2LtCJk68mJ494bHUjaopf2
 DL2adPQUne1cGX7Q3qHWSz3jdj4/oNCqAIEmw5A==
X-Google-Smtp-Source: AGHT+IHriKRJDNTrMNfjtsl5/pacsFGH/70BdWg32GB6DElMX41bsIBEqvGvqlK6CVAqV+DFN0SiXI+IMrWKkwg9t4g=
X-Received: by 2002:a05:6402:518d:b0:5be:9c38:79b1 with SMTP id
 4fb4d7f45d1cf-5bea1c74df2mr72402a12.16.1723567066007; Tue, 13 Aug 2024
 09:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240813153922.311788-1-jmarcin@redhat.com>
 <20240813153922.311788-3-jmarcin@redhat.com>
In-Reply-To: <20240813153922.311788-3-jmarcin@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Aug 2024 17:37:33 +0100
Message-ID: <CAFEAcA9BWOkSmNh_b7HcNgfD429L1iLrjYTHWBJKDP2dJYCjCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] reset: Add RESET_TYPE_WAKEUP
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 13 Aug 2024 at 16:39, Juraj Marcin <jmarcin@redhat.com> wrote:
>
> Some devices need to distinguish cold start reset from waking up from a
> suspended state. This patch adds new value to the enum, and updates the
> i386 wakeup method to use this new reset type.
>
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  docs/devel/reset.rst    | 8 ++++++++
>  hw/i386/pc.c            | 2 +-
>  include/hw/resettable.h | 2 ++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
> index 9746a4e8a0..a7c9467313 100644
> --- a/docs/devel/reset.rst
> +++ b/docs/devel/reset.rst
> @@ -44,6 +44,14 @@ The Resettable interface handles reset types with an enum ``ResetType``:
>    value on each cold reset, such as RNG seed information, and which they
>    must not reinitialize on a snapshot-load reset.
>
> +``RESET_TYPE_WAKEUP``
> +  This type is called for a reset when the system is being woken-up from a
> +  suspended state using the ``qemu_system_wakeup()`` function. If the machine
> +  needs to reset its devices in its ``MachineClass::wakeup()`` method, this
> +  reset type should be used, so devices can differentiate system wake-up from
> +  other reset types. For example, a virtio-mem device must not unplug its
> +  memory during wake-up as that would clear the guest RAM.
> +
>  Devices which implement reset methods must treat any unknown ``ResetType``
>  as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount of
>  existing code we need to change if we add more types in future.
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ccb9731c91..49efd0a997 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1716,7 +1716,7 @@ static void pc_machine_reset(MachineState *machine, ResetType type)
>  static void pc_machine_wakeup(MachineState *machine)
>  {
>      cpu_synchronize_all_states();
> -    pc_machine_reset(machine, RESET_TYPE_COLD);
> +    pc_machine_reset(machine, RESET_TYPE_WAKEUP);
>      cpu_synchronize_all_post_reset();
>  }

I'm happy (following discussion in the previous thread)
that 'wakeup' is the right reset event to be using here.
But looking at the existing code for qemu_system_wakeup()
something seems odd here. qemu_system_wakeup() calls
the MachineClass::wakeup method if it's set, and does
nothing if it's not. The PC implementation of that calls
pc_machine_reset(), which does a qemu_devices_reset(),
which does a complete three-phase reset of the system.
But if the machine doesn't implement wakeup then we
never reset the system at all.

Shouldn't qemu_system_wakeup() do a qemu_devices_reset()
if there's no MachineClass::wakeup, in a similar way to
how qemu_system_reset() does a qemu_devices_reset()
if there's no MachineClass::reset method ? Having the
wakeup event be "sometimes this will do a RESET_TYPE_WAKEUP
but sometimes it won't" doesn't seem right to me...

thanks
-- PMM

