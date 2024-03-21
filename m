Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C302C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 16:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnLTk-0007aa-35; Thu, 21 Mar 2024 12:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnLTd-0007Yi-9U
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:41:14 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnLTY-0006vk-P5
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:41:12 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56bc753f58eso1250163a12.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711039266; x=1711644066; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1c5pfsClmOJ8Doe6EgVON5gxkIKYiCXcYmDvoJErD3c=;
 b=PDDT88ItTMLrcOMMaRXnIBRHd4WCw1qDx2GLf+rDIg/19jxIJ8i1Umo8aKHeUyhmaT
 kOE4md8CRiQvQkcO3A2z1h875PrZjsUhgEGrKcdrV5tym8H0EXla4vjo3or1n4swn4DK
 D4vkGq4FLr/0xkrGhSTW+uzPJeA3dpFSU4hobP3wymmz8JJ47YkgZHDdqgZvL88oaJ6H
 sSeBQkEUUlXyVGLCBntdFuCcE3GA9zOlHiTixKd4G85VAOfP4mZLFH26C8RjaiBb5Jy2
 nWQ4Mgdt+VGR47/ZJaN6D3VcJF5kvXgxcxTAWm+hW31XRrSTUIk6Jqn+IlvL704yafPg
 JynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711039266; x=1711644066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1c5pfsClmOJ8Doe6EgVON5gxkIKYiCXcYmDvoJErD3c=;
 b=k81Q6uHh6BMfMVMg6uSyXgkTjIoZauAjpaqHApXiQJ3G5SVtXqayxfTgweNItVJeZI
 xwGkIBQETa3VvlVWsUILBeco5WI/EgJM1SnNs7t8RmTCby8+aSVWDZcPlITIHoQq77Jn
 FuEzQuKx/XBXHfFv5wPSsCT7PjkGn4rm4h6lS7S7Ot3QMwk20c/lGeqs6PH1KARELPFT
 507ksZt6CXmbkAXk5FGWRuZqzo594kreM0Vkop0eNCVFm5OBdS1yG3k/rYqxNIWlo5Ku
 KWZDWoYDXOHJlmWniI5HdKPd1/BRlrUJdfrFV4RofVK95omp9ENQz8J7t1IVKUpQuHs2
 CRrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhbprzNlK9gP1SMqPGRhqwgLgPaUwkkeqUM0BF4t1n82tith27+aJElqBXGWeOtYATPswocsmyVmItjEewo7+phx3HN20=
X-Gm-Message-State: AOJu0YzzcShkG+U7KtREibwipJkdzX4Y5j7KdfrkVs13r6UFDUDDFnYh
 dwf1R1XTBrRmBK18xU/dxolGDXkRXqKJ6YPCxV1LU6XE1Sn2899YtPfdo7P425GqJq2nBzRXrUZ
 SnVqml0rFamN/xrJQXoczI1HdQviJa5uOfWHejw==
X-Google-Smtp-Source: AGHT+IHvTp0KnUocP8uYKu54nlhGZx/uK5shT2UJtZT0TYn5EY4pP0sZiDBFtmCCV5UI/JKbYdDTscnZq5q8x7+MNYo=
X-Received: by 2002:a05:6402:4496:b0:568:ac09:4a5c with SMTP id
 er22-20020a056402449600b00568ac094a5cmr3971754edb.11.1711039266395; Thu, 21
 Mar 2024 09:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240321130812.2983113-1-ruanjinjie@huawei.com>
In-Reply-To: <20240321130812.2983113-1-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Mar 2024 16:40:54 +0000
Message-ID: <CAFEAcA_J662fz9HxTFhRkM9otdEbWCZW6fXoCi_5kfqn3hkDeQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 00/23] target/arm: Implement FEAT_NMI and
 FEAT_GICv3_NMI
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 21 Mar 2024 at 13:10, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> This patch set implements FEAT_NMI and FEAT_GICv3_NMI for armv8. These
> introduce support for a new category of interrupts in the architecture
> which we can use to provide NMI like functionality.
>
> There are two modes for using this FEAT_NMI. When PSTATE.ALLINT or
> PSTATE.SP & SCTLR_ELx.SCTLR_SPINTMASK is set, any entry to ELx causes all
> interrupts including those with superpriority to be masked on entry to ELn
> until the mask is explicitly removed by software or hardware. PSTATE.ALLINT
> can be managed by software using the new register control ALLINT.ALLINT.
> Independent controls are provided for this feature at each EL, usage at EL1
> should not disrupt EL2 or EL3.
>
> I have tested it with the following linux patches which try to support
> FEAT_NMI in linux kernel:
>
>         https://lore.kernel.org/linux-arm-kernel/Y4sH5qX5bK9xfEBp@lpieralisi/T/#mb4ba4a2c045bf72c10c2202c1dd1b82d3240dc88
>
> In the test, SGI, PPI and SPI interrupts can all be set to have super priority
> to be converted to a hardware NMI interrupt. The SGI is tested with kernel
> IPI as NMI framework, softlockup, hardlockup and kgdb test cases, and the PPI
> interrupt is tested with "perf top" command with hardware NMI enabled, and
> the SPI interrupt is tested with a custom test module, in which NMI interrupts
> can be received and sent normally.

It looks like your changes to the GIC have missed the handling
of NMIs in the active priority registers and the running
priority registers (both ICC and ICV versions). The way this
works is that the ICH_AP1R0 and ICC_AP1R0 registers get an
extra bit for NMI status in bit 63 (luckily we had the foresight
to make these struct fields be uint64_t). When we activate
an NMI IRQ, instead of setting the ICC_APR bit according to
its priority, we set the NMI bit instead. Similarly, on
deactivate we clear the NMI bit, not the priority-related bit.
The ICC_RPR register also has new bits in bit 63 and 62 for
whether there's an active NMI. On read of the RPR we figure
out the values for these bits based on the NMI bits in
ICC_AP1R_EL1S.NMI and ICC_AP1R_EL1NS.NMI (you might find the
pseudocode functions for ICC_RPR_EL1 in chapter 13 helpful to
look at here). The icc_highest_active_prio() likely also needs
changes to handle NMI. Similarly for all the ICV versions of
these registers and functions.

thanks
-- PMM

