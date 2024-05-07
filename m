Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D259C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4KDc-0001Oz-Eh; Tue, 07 May 2024 08:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4KD4-0001BW-P7; Tue, 07 May 2024 08:46:22 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4KCm-0007AO-6t; Tue, 07 May 2024 08:46:02 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f44b5e7f07so2182756b3a.2; 
 Tue, 07 May 2024 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715085957; x=1715690757; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iz0r9uwhYBTyTENWYg3IdUNatsrXw1RhGAmBIg8pzIw=;
 b=DPbaLwhrf/AgpH2DPGSeVsNh12PUb2Y56v9GMuKlqOOyq2mIuNoAgm6w9oBFG+avjD
 5j/YcpP+sXLfQPWZ13ijVWk4Nf4mMmMO9lrMdm0rKEqjJuFZttFRYpRmzEy6TaP9ze4L
 o1K9t18bmzRkg7mkWqIFODoG61BjKF5Z+zrKWgzBN34X9hJn2Mm3JD/auJ8Zpnk5+l3I
 2QMJQH21GkUZcfk/jFpB33FBnp2tMerojrJ7fShZq7+W/QvTWhLz7wIVJUud58VTQ5ek
 GYObAmcLobvpAuWHkp+QgejlA0xZtHGW4+gNcRA/9Z1VDh4CsV0xCA5LIXF6Ohwsl2MO
 ynlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715085957; x=1715690757;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iz0r9uwhYBTyTENWYg3IdUNatsrXw1RhGAmBIg8pzIw=;
 b=PL5p8LovfW7ZR4BCMtlMhmJzXcHb7dD0w12oNifXZ5Egz4HPJn+ruUnLUl1WrphufE
 f9EK8juO6drKAWC1pFVmIhs8uiHDrYxDlNhGe495OU6Qv32ewKyo5kfkJHqzogaZBmNO
 ERkrWq+dEFbL98wU+rXfR+BQ+mKfGDzAS24EUPJ4hahq1deOzh1/v3KuxTLfhs7+xF5p
 QI3YE340Aadk4Xh1d18ylKCvbidsHLBE/YaNVpVsZybZ4P4lO5ThfFFjCfrstUAb6pjz
 bCyhPIJFzoDaiXyabtkdv5IfOfxVkvim1lwowy0DgL9plwfXCsxw3wlD08lcwV+Kl58a
 2mzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmqxIPAn8o/wcGwD0+NL4efQliMBKxW45I/GA8BGzyag3SNDiI6HE4/WrYModzn4rW6bvZ/93AXfmCwBAnrx0b67GOWrOGWi8fuRTVySlnaltA9lDrli8in2c=
X-Gm-Message-State: AOJu0YyDt0QTIdPriKlLHNGbgJiz7sWOS07haDED5K0Y34nPIME6wHat
 UTBM8mOOw5g7VKBuZ7RSzm/JRsSwgapN5dpxd2qhFDpT1dW+ys9JMpSuog==
X-Google-Smtp-Source: AGHT+IG413nMo11lPUbXgqULWkT4434NzLVGlfuwKKq/6LZ49qN+OyUitM4F5U4NQ9Q+LGOgqVI3yQ==
X-Received: by 2002:a05:6a21:3a85:b0:1a7:9cf6:6044 with SMTP id
 zv5-20020a056a213a8500b001a79cf66044mr12939515pzb.27.1715085957431; 
 Tue, 07 May 2024 05:45:57 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 fj36-20020a056a003a2400b006e72c8ece23sm9332041pfb.191.2024.05.07.05.45.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:45:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 22:45:52 +1000
Message-Id: <D13F89JFC1G4.2FJHXLMJWYYCC@gmail.com>
Subject: Re: [PATCH v2 00/28] Misc PPC exception and BookE MMU clean ups
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> This series does some further clean up mostly around BookE MMU to
> untangle it from other MMU models. It also contains some other changes
> that I've come up with while working on this. The first 3 patches are
> from the last exception handling clean up series that were dropped due
> to some error on CI but I'm not sure if that was because of some CI
> infrastructure problem or some problem with the patches as the error
> did not make much sense. So these patches are only rebased now, I made
> no other change to them until the issue is understood better. The rest
> are new patches I've added since tha last series. Please review.

Not CI infrastructure as far as I could tell it's upstream gitlab.
But I could not figure out how to reproduce at the time... I ended
up running out of time to look too closely though.

I think I won't take the first 2, yes arguably the CPU does execute
the sc instruction, but it's actually a good rule for the exception
handler to be invoked with the nip that caused the exception, and
SRR0/1 to be set by the handler according to semantics.

Thanks,
Nick

>
> v2:
> - Fix user mode issue in patch 1 by keeping old behaviour for user mode
> - Add some more MMU clean up patches
>
> Regards,
> BALATON Zoltan
>
> BALATON Zoltan (28):
>   target/ppc: Fix gen_sc to use correct nip
>   target/ppc: Move patching nip from exception handler to helper_scv
>   target/ppc: Simplify syscall exception handlers
>   target/ppc: Remove unused helper
>   target/ppc/mmu_common.c: Move calculation of a value closer to its
>     usage
>   target/ppc/mmu_common.c: Move calculation of a value closer to its
>     usage
>   target/ppc/mmu_common.c: Remove unneeded local variable
>   target/ppc/mmu_common.c: Simplify checking for real mode
>   target/ppc/mmu_common.c: Drop cases for unimplemented MPC8xx MMU
>   target/ppc/mmu_common.c: Introduce mmu6xx_get_physical_address()
>   target/ppc/mmu_common.c: Rename get_bat_6xx_tlb()
>   target/ppc/mmu_common.c: Split out BookE cases before checking real
>     mode
>   target/ppc/mmu_common.c: Split off real mode cases in
>     get_physical_address_wtlb()
>   target/ppc/mmu_common.c: Inline and remove check_physical()
>   target/ppc/mmu_common.c: Simplify mmubooke_get_physical_address()
>   target/ppc/mmu_common.c: Simplify mmubooke206_get_physical_address()
>   target/ppc/mmu_common.c: Fix misindented qemu_log_mask() calls
>   target/ppc/mmu_common.c: Deindent ppc_jumbo_xlate()
>   target/ppc/mmu_common.c: Replace hard coded constants in
>     ppc_jumbo_xlate()
>   target/ppc/mmu_common.c: Make get_physical_address_wtlb() static
>   target/ppc: Move mmu_ctx_t definition to mmu_common.c
>   target/ppc: Remove ppc_hash32_pp_prot() and reuse common function
>   target/ppc/mmu_common.c: Split off BookE handling from
>     ppc_jumbo_xlate()
>   target/ppc/mmu_common.c: Remove BookE handling from
>     get_physical_address_wtlb()
>   target/ppc/mmu_common.c: Simplify ppc_booke_xlate()
>   target/ppc/mmu_common.c: Move BookE MMU functions together
>   target/ppc: Remove id_tlbs flag from CPU env
>   target/ppc: Split off common 4xx TLB init
>
>  hw/ppc/pegasos2.c        |   2 +-
>  target/ppc/cpu.h         |   1 -
>  target/ppc/cpu_init.c    |  65 ++--
>  target/ppc/excp_helper.c |  67 +---
>  target/ppc/helper.h      |   2 -
>  target/ppc/helper_regs.c |   1 -
>  target/ppc/internal.h    |  19 +-
>  target/ppc/mmu-hash32.c  |  47 +--
>  target/ppc/mmu_common.c  | 792 +++++++++++++++++++--------------------
>  target/ppc/mmu_helper.c  |  36 +-
>  target/ppc/translate.c   |  21 +-
>  11 files changed, 438 insertions(+), 615 deletions(-)


