Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10BECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Pu8-0000Nl-M4; Thu, 16 Oct 2025 11:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v9Pu6-0000NP-OX
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:28:34 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v9Pu0-0004uT-4w
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:28:34 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3c97709a4fbso241849fac.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1760628504; x=1761233304; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DNFEQAbx1C1OF6IR8cj3tKL3RTGxnKmq5qGnYuZu+4=;
 b=ZbzUoyQplLoZtJHdgfjb5HXEkBA1d4vR9aqs5IvV4Ww7eKK/rYDQE5Rzl21npo0HRN
 nzAJevHbnjB0+fenFoy2m3JOyni1nVIWyQ1EmvhmKyoRuoQCxquprzfpfnzetHgnihkc
 mGbbGXvtatB65oCPijAX81//rBLwuUjCEHLsB2vqueOaPqzeODbS9vtRyt+kJAQSquqn
 cnjEc73ztAcyzuhHWzJ3GwEPiSg9zdGS/LR6posAwbelFS0sQcboaibye6zR9l9zBn7x
 s+MmI6dM65G/NZdP5A2nDSDL4wJc5M/QxtGOm36aM1V7vvNiggKodbOJ1y57/ArU2gzu
 sSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760628504; x=1761233304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DNFEQAbx1C1OF6IR8cj3tKL3RTGxnKmq5qGnYuZu+4=;
 b=mECMJ4KaS/M5Jf/vBHCG80tRMjvcGmV3A3up+jl/yRyQ3RtfxHJMsViZoEPastdCHH
 gS4FkDD12Ovh25jObRiaVlqGwhUKLhh0GFuENqD6RrchIYDs6memCTdUREWH4k/jwv0k
 QDDSH6VDo8M/Y5/1bCTBwAwfWaNdi13n/geM5lVifxKp+8abmgD8rsNdpAyG0CvamUd7
 94ewsSztpxRXoH/jhpoJYI7F231UT4Efu1WEAKnVCCx8PtAlZdDGjdkGCVCDtPrQd7ON
 yx1wj3d5n7KeLSi2QXJwFfUO1Nyf00VoW0sHxvZCP8z/7wwWa4e5Kv6+ExBpwBFo15Ur
 dsig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUouniL9wH4vdkT/Zis5vKk7+HmFDBlZzgD4UBDI+JHIfHl6Id5+eqG0fSDQXwdgeFeJz9JKmb/vQiH@nongnu.org
X-Gm-Message-State: AOJu0Yzw9rTSrrQqdmXOmA9sVRucOjlMdyGSJMM1hjKOd6zs9+Bd2OEd
 47033TZTQ8JURXx4dqe2dPJaAQpBh2E1T6RIg73W5SrNYBRGJA3NcBjKCX+0cO63zPbycTFwWzI
 AuDRC0ThLGasd8u66zLhaTTaFNGHvk9rl6+OGbaLRUg==
X-Gm-Gg: ASbGncvcU/cmpIJoAUCdPvXXZxdicVXMXjKwnuevg+nczIViUrFZYJtcr1QK3NYvafl
 Fir2kK7hsvRHk/iZoE1ec0klrDWnz+34UV06p9iqykRkd50zYkW70uOQJIzjGBxqCWBO2LKaCdp
 b1kgGr53w1EM0MtAaWJzjfzXWwemNzRmzlOrGIgljvHFSJXCB/Z4iT6J1vItW1eBQasiM6668ia
 +U0g35dWCdzicsY9HvD8QXYFroLBCb7loiSJqIWNm/ffv6M5lwt5MMAPB1cK2FojIadt3vSKBJ/
 2O/ogJBMiN3BzxJiRIu+vVYmlTLykbhBHhV9fuRr6KKbU1NoBci0
X-Google-Smtp-Source: AGHT+IGQJNtX5pJqMjQ6g5EJ/rnfW0xs46zdjqTU0eX1YrmT9xPBRjxIgXo6S5OKS6a3iLDfUtbFy4TC8ymFuAjkR54=
X-Received: by 2002:a05:6870:64a3:b0:347:b473:5f58 with SMTP id
 586e51a60fabf-3c98cf023ccmr68583fac.1.1760628504379; Thu, 16 Oct 2025
 08:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <d6f9dfa368b2419998379ac9dd986a7b@huawei.com>
 <CAFEAcA8U_3zJsnHt2wxME3j8J83whzTNgP9vEvUGuWHe7KGaYA@mail.gmail.com>
 <e2b03da8f7514b57aef7d236be1dcb90@huawei.com>
 <CAFEAcA_KcvBOOc4nY6VMziSuh=YrcgbaNZhi3+M_kM01v97WtQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_KcvBOOc4nY6VMziSuh=YrcgbaNZhi3+M_kM01v97WtQ@mail.gmail.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Thu, 16 Oct 2025 15:28:11 +0000
X-Gm-Features: AS18NWCwwf5F56J04_scWPeqYWWc1CyVnW4MQrQYMZ74UX8yBOj6xCDdcJcviD8
Message-ID: <CAJ7pxeaCeSPAzjqnhVG6VkQyX3Vx82yvb-ex1ya+j7pFjFOekg@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oa1-x2f.google.com
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

Hi Peter,

On Thu, Oct 16, 2025 at 12:46=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Thu, 16 Oct 2025 at 12:13, Salil Mehta <salil.mehta@huawei.com> wrote:
> >
> > Hi Peter,
> > > > Above changes assume that the driver's configured value of the
> > > > ICC_CTLR_EL1 system register is the same as the default value. I've
> > > > verified that this currently the case. However, it safe to assume t=
hat
> > > > this will remain true in the future as well?
> > >
> > > I don't understand what you mean here. We read the kernel's ICC_CTLR_=
EL1
> > > at VM startup, when we know it will be the reset value, because we ha=
ven't
> > > run any VCPUs yet.
> >
> >
> > System register fetches its value from ICH_VMCR_EL2 and ICH_VTR_EL2.
> > In specific, EOIMode, PMHE and CBPR fields of ICC_CTLR_EL1 are from
> > the VMCR register. Later gets configured when driver gets loaded and ag=
ain
> > re-configured in context to each CPU ON request(via in-kernel  CPU Hotp=
lug
> > state machine; CPUHP_AP_IRQ_GIC_STARTING). This configures the VMCR
> > again and again. Although, the value as of now is same.
> >
> > You might want to check gic_cpu_sys_reg_init() in irq-gic-v3.c
>
> I'm afraid I still don't understand what you mean here. This is
> all the guest writing to the GIC registers as it starts up, right?
> That has no influence at all on what the reset value of the emulated
> hardware should be. (This is the same as on real hardware:
> it doesn't matter what the OS writes to registers when it is
> running; when the hardware resets it resets to the reset value.)

For context, the gic_cpu_init() function is invoked from two paths in
the kernel: first from gic_init_bases() when the GICv3 driver is
initially loaded on the boot CPU, and later from gic_starting_cpu()
during each CPU online transition in the hotplug state machine.

The hotplug path wires up

CPUHP_AP_IRQ_GIC_STARTING -> gic_starting_cpu

in gic_smp_init(). On every CPU online event this leads to:

gic_starting_cpu() -> gic_cpu_init() -> gic_cpu_sys_reg_init()

which reprograms the CPU-interface system registers on that CPU,
including ICC_CTLR_EL1 (fields EOIMode, PMHE, CBPR).

The following dump stack from a guest hotplug event shows this
sequence clearly:

echo 1 > /sys/devices/system/cpu/cpu1/online
[   39.287402] gic_cpu_sys_reg_init+0x4c/0x294
[   39.287406] gic_cpu_init.part.0+0xc0/0x114
[   39.287409] gic_starting_cpu+0x24/0x8c
[   39.287412] cpuhp_invoke_callback+0x104/0x20c
[   39.287419] notify_cpu_starting+0x80/0xac
[   39.287421] secondary_start_kernel+0xdc/0x15c


As a result, ICC_CTLR_EL1 is at its architectural reset value at
VM realize (before any vCPU runs), but it is guest-configured
after the driver runs and again on each later CPU online event.

Although it looks safe in practice from the way EOIMode, CBPR,
and PMHE fields are currently programmed by the guest, the
eventual value always depends on what the guest writes into
VMCR each time it configures the CPU interface during a
CPU_ON sequence. Given that, would it still be correct for
QEMU to treat the realize-time ICC_CTLR_EL1 value as a
persistent runtime value rather than just a reset template?

Since cpu_reset() will also be invoked for every CPU_ON in QEMU,
is there even a remote possibility that a guest GIC driver (Linux or
otherwise) might alter these field configurations across successive
CPU_ON/OFF cycles?

>
> We want to know what value the kernel gives to this register when
> the GIC is in a freshly reset state when no guest code has run.
> That should be the value that it has here, when we read it on realize.

But when PSCI CPU_ON is being handled entirely in the kernel
i.e. no hotplug patches are present and hence no SMCC Hypercall
exit exists then we will always use driver updated VMCR fields (I think).
In the current case even along with the hotplug patches they are the
same but in *future* will they be?

I do understand what you and Marc discussed and pointed out that,
"The reset value is indeed cast in stone once the GIC has been created."
https://lore.kernel.org/lkml/864is2x6z9.wl-maz@kernel.org/


Best regards
Salil.

