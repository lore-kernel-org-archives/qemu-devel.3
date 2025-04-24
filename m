Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E467C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7txn-000060-KA; Thu, 24 Apr 2025 06:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7txl-00005q-SR
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:37:49 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7txi-0007xq-9Z
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:37:48 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-52403e39a23so761132e0c.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745491064; x=1746095864; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAEVWEmLTOEU56kvLjKHSQ1f5Ol333gCMXoh/MfEC14=;
 b=HbV5DalhaliRF1VmD3GSvB3v83YIKG5/4tIGCNHffPr5FtGz1IkEJe865ed2QVl2G+
 9XpLRGZeJJsCNk5+HnSWUMPwNNCaXxhDNTDwQH8qh1QICVe8MrLf9f1WZcYdanzdn6J9
 ED4MaWPrUkz40tY3SVFfY/1tibE0rUiNHpVSSzzUDuzmMh/bgw6e9OV29VFik9s4GAQN
 mAdRq6NoK93TyWeu6Bgi4zqd9kQfvo2BcFKgSKKNStMoq0FPQJmm++jOGjJ36FPBDkc5
 J/GE0YTxE+ySYcII+P0KyFQ4iJP5iKKy29n2Lh1lPNWBlXIenZTVPsf6CC5NZ62ZWTra
 8fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745491064; x=1746095864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fAEVWEmLTOEU56kvLjKHSQ1f5Ol333gCMXoh/MfEC14=;
 b=nn1ArHmMqLXH/v/MewOk0FNQC+ZbG7fgHmk1yqInfPOcYz0vorPcPgnhwIqnGZsHjl
 3gRqiSH76rNmTNUa9f74OUz1c4TaAWLYsoVoD5htg7Itp2ie47BQ5l9UCPMdhQswarNa
 wyL9MlEIMBM24+4w/b2ul2gGoV+rwgWY2bkihtaNv+qWLgVcPqq7rDuUEbSMxUwyI/XJ
 Izd7xOaFRQpmcn5sBfLrUgxYdZ2CKMKWenUW4t7dWWuUz8e7O+cxtRLHgVGBg8egfypj
 UJMupbESONkMN9rNknkxs0UXKKoEEqQKWzkDQs23AYmJP+QC8mAn/+UDGt+1doLkAQAa
 S6pw==
X-Gm-Message-State: AOJu0Yyxkuvwn+xV1KnitaQJa7KLnwmbgRqMn8MfT17qswwPhKCbk1yl
 HlQhEHu9BMsxfBcRgNmQgftNNP7j4tZ5WFBfzIXT5E0rohQW2ZK+1WH8KRtqJiJn2eA4o5gqP+b
 a0zJ0UzeUSz6XIQi/ZQ9x+wM/uNKS7Q==
X-Gm-Gg: ASbGncuIKcBMUeYOlvfB7XmTtlqEm/CgztmRIeeJ182uy7/XWLNlMhIig8uvbvYnTQn
 qqnkcTBYvbao09fd8AJs1GUwNLjrS8Qnta9BritTVZNCZnBGMYrOY2qdjyQAdhp11P0IDTk2AS+
 uGjrCB/KLNoHZvldXHeuIb4Cunm8DRTNhAfRAkYXHlRGq/7b7gDbj8Llz69ZF0uXc=
X-Google-Smtp-Source: AGHT+IHAWd44kJkein0kHYMU3A8Pz9n54OUUPo+q7GbXR8lJWxzue1OeUiQB8iXJF2xPPf9xI5xxUf/Kn/JoXWGJCtE=
X-Received: by 2002:a05:6102:d92:b0:4bb:c8e5:aa6d with SMTP id
 ada2fe7eead31-4d38f0e67acmr1412178137.17.1745491064529; Thu, 24 Apr 2025
 03:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250228102747.867770-1-pbonzini@redhat.com>
 <CABgObfYRp-TFLTw5K+Y7US4DM4U+dWagCTAWHXJYkbvkAaapHg@mail.gmail.com>
In-Reply-To: <CABgObfYRp-TFLTw5K+Y7US4DM4U+dWagCTAWHXJYkbvkAaapHg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 20:37:17 +1000
X-Gm-Features: ATxdqUFsbA2lbNWVq0Q7GJAZCNUcjVz4rf2Poc4m21h8w0tJ0RbOnASHMyHCzyY
Message-ID: <CAKmqyKMcwuCJty4FAZr_MATNoH05xNvdiQNtZraGuZYWKUgLNQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] target/riscv: declarative CPU definitions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Apr 17, 2025 at 11:42=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Hi Alistair,
>
> sorry for the stupid question=E2=80=94I am not sure whether you are going=
 to give reviewed-by to the remaining patches, and also whether you would l=
ike me to submit the PR for this or not.

Sorry, just getting through a backlog. I have reviewed and applied the patc=
hes

Alistair

>
> Thanks in advance
>
> Paolo
>
> Il ven 28 feb 2025, 11:27 Paolo Bonzini <pbonzini@redhat.com> ha scritto:
>>
>> As in v1, what I really wanted to achieve was removing RISC-V's
>> use of .instance_post_init; that's because RISC-V operate with an
>> opposite conception of .instance_post_init compared to everyone
>> else: RISC-V wants to register properties there, whereas x86 and
>> hw/pci-bridge/pcie_root_port.c want to set them.  While it's possible
>> to move RISC-V's code to instance_init, the others have to run after
>> global properties have been set by device_post_init().
>>
>> The way to get there is to make CPU definitions entirely declarative.
>> Previously, multiple instance_init functions each override the propertie=
s
>> that were set by the superclass, and the code used a mix of subclassing
>> and direct invocation of other functions.  Now, instead, after .class_in=
it
>> all the settings for each model are available in a RISCVCPUDef struct,
>> and the result is copied into the RISCVCPU at .instance_init time.
>> This is done with a single function that starts from the parent's
>> RISCVCPUDef and applies the delta stored in the CPU's class_data.
>>
>> Apart from the small reduction in line count, one advantage is that
>> more validation of the models can be done unconditionally at startup,
>> instead of happening dynamically if a CPU model is chosen.
>>
>> Based-on: <20250218165757.554178-1-pbonzini@redhat.com>
>>
>> Paolo
>>
>> v1->v2:
>> - merged "remove target/riscv: remove unused macro DEFINE_CPU"
>> - max SATP mode refactoring moved to its own series
>> - included a couple of Philippe's patches from his "const class_data" se=
ries
>> - RISCVCPUDef initializers all declared as const
>>
>> Paolo Bonzini (20):
>>   target/riscv: introduce RISCVCPUDef
>>   target/riscv: store RISCVCPUDef struct directly in the class
>>   target/riscv: merge riscv_cpu_class_init with the class_base function
>>   target/riscv: move RISCVCPUConfig fields to a header file
>>   target/riscv: add more RISCVCPUDef fields
>>   target/riscv: convert abstract CPU classes to RISCVCPUDef
>>   target/riscv: do not make RISCVCPUConfig fields conditional
>>   target/riscv: convert profile CPU models to RISCVCPUDef
>>   target/riscv: convert bare CPU models to RISCVCPUDef
>>   target/riscv: convert dynamic CPU models to RISCVCPUDef
>>   target/riscv: convert SiFive E CPU models to RISCVCPUDef
>>   target/riscv: convert ibex CPU models to RISCVCPUDef
>>   target/riscv: convert SiFive U models to RISCVCPUDef
>>   target/riscv: th: make CSR insertion test a bit more intuitive
>>   target/riscv: generalize custom CSR functionality
>>   target/riscv: convert TT C906 to RISCVCPUDef
>>   target/riscv: convert TT Ascalon to RISCVCPUDef
>>   target/riscv: convert Ventana V1 to RISCVCPUDef
>>   target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
>>   target/riscv: remove .instance_post_init
>>
>> Philippe Mathieu-Daud=C3=A9 (2):
>>   target/riscv: Declare RISCVCPUClass::misa_mxl_max as RISCVMXL
>>   target/riscv: Convert misa_mxl_max using GLib macros
>>
>>  target/riscv/cpu-qom.h            |   2 +
>>  target/riscv/cpu.h                |  27 +-
>>  target/riscv/cpu_cfg.h            | 160 +-----
>>  target/riscv/cpu_cfg_fields.h.inc | 165 ++++++
>>  hw/riscv/boot.c                   |   2 +-
>>  target/riscv/cpu.c                | 909 ++++++++++++++----------------
>>  target/riscv/csr.c                |   2 +-
>>  target/riscv/gdbstub.c            |   6 +-
>>  target/riscv/kvm/kvm-cpu.c        |  23 +-
>>  target/riscv/machine.c            |   6 +-
>>  target/riscv/tcg/tcg-cpu.c        |  10 +-
>>  target/riscv/th_csr.c             |  30 +-
>>  target/riscv/translate.c          |   2 +-
>>  13 files changed, 632 insertions(+), 712 deletions(-)
>>  create mode 100644 target/riscv/cpu_cfg_fields.h.inc
>>
>> --
>> 2.48.1

