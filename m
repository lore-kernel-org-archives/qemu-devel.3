Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86093C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twR0W-0005yc-Fw; Sun, 23 Mar 2025 15:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twR0U-0005wD-38
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:29:14 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twR0S-0007kS-A4
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:29:13 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22401f4d35aso73915335ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742758151; x=1743362951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PnAmtE3n3/paQ0lzVCvVubbi6PO9bdEfhffrgZLoMMY=;
 b=xTB46ArbsMB8b6jUnd0o+VIkX2wukL0wqMhscYM8O9D93bt0aTfuGW+AWeMCK5NRHF
 S7akcjXGLyXpw8QyV4I3fpmpYcwaRAiLzUJ8G+HPfk+Agc2kYEsMQJ8DBau/8nTRqMHR
 6xbw8Nso603qYQwviQ57pG+024cn3QC6D42zrvWhmjagTAXV8TTTA3ZZ2nGQNfkLQnTt
 O7URuK3+QAbkiNJSGHe3pvefUYyQkmNR6QwfWYeJ8XUQfAAaakIvtNaGZhPqFtMXV12p
 PSQHWecmQeJSChuWjYwcF3ZoHUdcEvrVcSG66SUEvQOKK4QLVFfE+M+G1BpojE0wb6V/
 vQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742758151; x=1743362951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PnAmtE3n3/paQ0lzVCvVubbi6PO9bdEfhffrgZLoMMY=;
 b=Fw0bvHK/p0sG4JqB5q0Q6yRE3Vq8b2c0PD+lr0WY2SU8115r74dc5pvhoqPdxpnkK1
 5Te4SUKduCFC3kWoWQCcKEGOoNGhyfH80uAUJ1DSixvyRaFENHARcr0Bac7nbr6cdzvf
 gUzWrfRB8zwa22ARAUuaScCe9LDBJm/tzSatZzHWrP/lTxG4ba7x98tz3REjyP9hTPbP
 UZq0rdkY6tFEoA1LiZfS3E0FY1UOJ6oz/a6gAXzcBQo6Q8Ftu5K+Jh0x50HV/5SDc8dm
 Tg0Jqf0VR0fdZXaEbH4jUzY8npkSwpmmz2+IhuDNc8hbbler0aPXIVApMi+iRa0PQUkf
 F5WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNmGd7xm/6o6qJJdRM2UbxA1IDqnWNDZcQDDcWpUHs5HqwOQjQa8wWILdhUsHK6oIIjKnhZh51CiBJ@nongnu.org
X-Gm-Message-State: AOJu0Ywpqez9mO5wk43qFRMZ4k9JTuaWthtcSH4i4ImWTIXg0nx43iDC
 DeSJYW3WKUbqsWbLNmXQsuMbzzJzfxLHmasScRYZGvG8Gfqs7mN+1KTYQ72lleo=
X-Gm-Gg: ASbGncs4YAUVB+F54Zaz2XplUdrwLRY77UCCPMsHQTUh/nuFtn5SOvCpGMyN+SeTafj
 YN/OnXxv53+uoreGEmBAH1WuyJOzh8O4ko0rWkM8IrbbbaV1ynNJJm+5MQTwh9u3vG/jXUFhYNK
 lFqiea+dC/gE9w/V3m1ZT+IZe0faR0HVd2pjVjOi5U4Eb3B3/MPWNhxxWHPBPmMErPknK4ndbqr
 q0IqDYOgNyDM3zvOz6DyJ8wYBy7QXUFxsOfy4PwBVAp7RNsq/dw01slyuCgKHTwAWolZJ9GT8Ws
 6+4io1id4umUlmSvTjBeYfY3vuxSMHaTEagu7mR9O5Ep2HMJKNLe5vzBo96of0cEbbI1C+49BKC
 /BPyh+Off
X-Google-Smtp-Source: AGHT+IHhpB3aRRBvUNs1iJcgRmDfGzmnOHPpyNLwpQfZOeU+obhVJxFhxXQ0Gu/SEvcE09tL6vTwmA==
X-Received: by 2002:a17:902:ebc9:b0:220:c63b:d93c with SMTP id
 d9443c01a7336-22780e234c5mr155026135ad.44.1742758150853; 
 Sun, 23 Mar 2025 12:29:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611c8c2sm6366198b3a.107.2025.03.23.12.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:29:10 -0700 (PDT)
Message-ID: <587270a8-6758-4c24-9d1b-911d754ce1e3@linaro.org>
Date: Sun, 23 Mar 2025 12:29:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/30] exec/cpu-all: remove exec/target_page include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-11-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/s390x/ipl.h                      | 1 +
>   include/exec/cpu-all.h              | 3 ---
>   include/exec/exec-all.h             | 1 +
>   include/exec/tlb-flags.h            | 1 +
>   linux-user/sparc/target_syscall.h   | 2 ++
>   hw/alpha/dp264.c                    | 1 +
>   hw/arm/boot.c                       | 1 +
>   hw/arm/smmuv3.c                     | 1 +
>   hw/hppa/machine.c                   | 1 +
>   hw/i386/multiboot.c                 | 1 +
>   hw/i386/pc.c                        | 1 +
>   hw/i386/pc_sysfw_ovmf.c             | 1 +
>   hw/i386/vapic.c                     | 1 +
>   hw/loongarch/virt.c                 | 1 +
>   hw/m68k/q800.c                      | 1 +
>   hw/m68k/virt.c                      | 1 +
>   hw/openrisc/boot.c                  | 1 +
>   hw/pci-host/astro.c                 | 1 +
>   hw/ppc/e500.c                       | 1 +
>   hw/ppc/mac_newworld.c               | 1 +
>   hw/ppc/mac_oldworld.c               | 1 +
>   hw/ppc/ppc_booke.c                  | 1 +
>   hw/ppc/prep.c                       | 1 +
>   hw/ppc/spapr_hcall.c                | 1 +
>   hw/riscv/riscv-iommu-pci.c          | 1 +
>   hw/riscv/riscv-iommu.c              | 1 +
>   hw/s390x/s390-pci-bus.c             | 1 +
>   hw/s390x/s390-pci-inst.c            | 1 +
>   hw/s390x/s390-skeys.c               | 1 +
>   hw/sparc/sun4m.c                    | 1 +
>   hw/sparc64/sun4u.c                  | 1 +
>   monitor/hmp-cmds-target.c           | 1 +
>   target/alpha/helper.c               | 1 +
>   target/arm/gdbstub64.c              | 1 +
>   target/arm/tcg/tlb-insns.c          | 1 +
>   target/avr/helper.c                 | 1 +
>   target/hexagon/translate.c          | 1 +
>   target/i386/helper.c                | 1 +
>   target/i386/hvf/hvf.c               | 1 +
>   target/i386/kvm/hyperv.c            | 1 +
>   target/i386/kvm/kvm.c               | 1 +
>   target/i386/kvm/xen-emu.c           | 1 +
>   target/i386/sev.c                   | 1 +
>   target/loongarch/cpu_helper.c       | 1 +
>   target/loongarch/tcg/translate.c    | 1 +
>   target/microblaze/helper.c          | 1 +
>   target/microblaze/mmu.c             | 1 +
>   target/mips/tcg/system/cp0_helper.c | 1 +
>   target/mips/tcg/translate.c         | 1 +
>   target/openrisc/mmu.c               | 1 +
>   target/riscv/pmp.c                  | 1 +
>   target/rx/cpu.c                     | 1 +
>   target/s390x/helper.c               | 1 +
>   target/s390x/ioinst.c               | 1 +
>   target/tricore/helper.c             | 1 +
>   target/xtensa/helper.c              | 1 +
>   target/xtensa/xtensa-semi.c         | 1 +
>   57 files changed, 57 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

