Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689C9D2F352
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 18:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfjAC-0004T4-At; Tue, 13 Jan 2026 13:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfj9y-0004Q0-Am
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:30:30 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfj9w-00028G-Li
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:30:30 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79276cef7beso30536147b3.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 10:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768329026; x=1768933826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taZ7BUP7QZtM0k5fqd+s0oR+IkuwSLbucA5+I6GacLs=;
 b=tMzKanUQP/W381S5jgDaCGqKoOXMukL+/++TSt4qAMCDLN76kVN2gusRHU87bknfwJ
 3OJY76kTivP7v/1/zPdHKVznFqATRSbIinxWrY+LkF88IUAS6nAEXXKODUOQGm4mV79t
 heoacnuupRCGSHXJKY8NAAWnb+VK8XsrQtUMZY7SL4kiYOKy1bWsVbfndDQSXzERvUPe
 ZKs73o9YYrNTJETvmPasKTiFkRjoGENhbUMgad2yR/UEUsN1qxsk/9kD5m2Qa3lZDHy6
 QQYMZVYnbUhDL1xl56QfPfU4m9f/5DGEBnjTHt4OAgFv/dtiK8IQvnyI61Bxpjl1DF1A
 lQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768329026; x=1768933826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=taZ7BUP7QZtM0k5fqd+s0oR+IkuwSLbucA5+I6GacLs=;
 b=fHl8gmGC0XAm9Bcl9HNuPLzWsmfyH68fTgTFpD2ZZcbI9YOz2M6rS/TUek+azEHBHH
 ZQLOPYqWmR13yr6W/3PIZmCmnMRe9e1tkdEQRX1CYHKLshhe40o9RXOMl92eGFIDftEp
 y7en7wUZ4lRhgF6r/q/N+abKyQO98dOruhAvLilhuM8QeD1o3OFqbAhTNeyDJK04P9DQ
 wbmlSGvxPLuMRN5Zb4bctY4B0Hmi/tKfDO6dI/EzrYP3y7hadJLj9Qs+3aG4ztNLrfPI
 5ALCPQ/jBic6cL/euPw5Oe0M/tjTrmBDBLLtFDXr9gx52tvyMxHg7hMW8pj0KeqHdk9D
 YmuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5nd6shfidmgfzdM4muiKncUW7x4LFxL8zRfDk9VCHh1zrXDwXyQ1XmU/xMKOXGKEylZGH/bOBN7oM@nongnu.org
X-Gm-Message-State: AOJu0YyF0BHlY8N5UX9R6E3AfWeqcawf4JBom6sZ+RBuSZLXRDrJ58sz
 EOzKrJazxrl2RjP5WMW85H5LRNvRuWVXV65TEGO3OI398puhisenwQ4x5JkJmYcg8u2/bcn91RR
 GwVfqrb5QDhHrIgNv/LWa3jKMyhWexzO1e6qohBgc2A==
X-Gm-Gg: AY/fxX4ifeiT9dhWl/q+6R5wqXwDbGM8FLpmq73F04cjupA/nbUjHWJlwZPhqGusJoF
 oqxL8Xx9n4K9WWgNXJSEsPZFWur2cpgCN+tC0D1mA4ZywOSN7+gEt7xdjwyfXiOfAboFJyVMSDv
 XOhxnwGntLv1klmVDtVQdbdwK4HVTiQN8MhhmU3ykX3cV0GWYYaSkAiKt5brw5Qk91XzJVgHZjH
 LfK0z7uePZucJ6hQwdioWswKLTAF47CfUzLlCGo2PUl0g4Xzlv0wZulH2h4Tm30OrcIHaWBVUA/
 YH5qmEMoBhS9MosxxyZdMdY=
X-Received: by 2002:a05:690e:d5a:b0:646:7c08:62d1 with SMTP id
 956f58d0204a3-64901b2f5a3mr128852d50.84.1768329026227; Tue, 13 Jan 2026
 10:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-5-alex.bennee@linaro.org>
 <CAFEAcA_Y_fTBo_0qg4Lm+7WrMdEown=-RrHHjcsKKE6WRX3eRw@mail.gmail.com>
 <b2c72aef-4a60-76af-4cd8-dd3142e46d2a@eik.bme.hu>
In-Reply-To: <b2c72aef-4a60-76af-4cd8-dd3142e46d2a@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jan 2026 18:30:13 +0000
X-Gm-Features: AZwV_QhDP20C_RHTCmRI9xlV6sFdSUUfd50VwRAsPMP_nyKxHVL_dY4Y-9SwM4c
Message-ID: <CAFEAcA9b8hnZ24+XMyXxVVV5ZEVZUFbMmR678hJ0eWqdi1r0Fg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/12] hw/m68k: register a mcf5208evb_cpu_reset handler
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 13 Jan 2026 at 18:08, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Tue, 13 Jan 2026, Peter Maydell wrote:
> > On Thu, 8 Jan 2026 at 14:34, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >>
> >> It looks like allowing a -kernel to override any firmware setting is
> >> intentional.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>  hw/m68k/mcf5208.c | 25 +++++++++++++++++++------
> >>  1 file changed, 19 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> >> index c6d1c5fae9f..5680d516a23 100644
> >> --- a/hw/m68k/mcf5208.c
> >> +++ b/hw/m68k/mcf5208.c
> >> @@ -27,6 +27,7 @@
> >>  #include "qemu/timer.h"
> >>  #include "hw/core/ptimer.h"
> >>  #include "system/system.h"
> >> +#include "system/reset.h"
> >>  #include "system/qtest.h"
> >>  #include "net/net.h"
> >>  #include "hw/core/boards.h"
> >> @@ -274,6 +275,20 @@ static void mcf_fec_init(MemoryRegion *sysmem, hw=
addr base, qemu_irq *irqs)
> >>      memory_region_add_subregion(sysmem, base, sysbus_mmio_get_region(=
s, 0));
> >>  }
> >>
> >> +static void mcf5208evb_cpu_reset(void *opaque)
> >> +{
> >> +    M68kCPU *cpu =3D opaque;
> >> +    CPUM68KState *env =3D &cpu->env;
> >> +    CPUState *cs =3D CPU(cpu);
> >> +
> >> +    cpu_reset(cs);
> >> +    /* Initialize CPU registers.  */
> >> +    env->vbr =3D 0;
> >> +    /* TODO: Configure BARs.  */
> >> +    env->aregs[7] =3D ldl_phys(cs->as, 0);
> >> +    env->pc =3D env->reset_pc;
> >> +}
> >
> > It looks from my quick skim of the m68k manual like
> > "on reset, initial PC is read from offset 4, initial
> > SP is read from offset 0" is part of the architected
> > CPU reset, not board-specific. Maybe we should model
> > that inside the CPU reset method? Compare M-profile
> > Arm, which does basically the same thing in
> > arm_cpu_reset_hold().
> >
> > (I really need to look again at whether we can move
> > that to the reset_exit phase now and drop the awkward
> > "maybe we need to look at a rom blob" special casing.)
>
> Real machines usually have a way to remap ROM to address 0 on reset
> shadowing RAM and then the firmware flips the bits needed to set up the
> memory map with RAM at 0 and ROM at somewhere higher up but the way to do
> it is different for each board. Maybe in QEMU we don't bother to model
> this and have this special case instead to simplify things and be able to
> start from the final ROM address without needing to model this ROM remap
> thing. So modeling real CPU behaviour might make board models more
> complex.

To me it looks like we are already modelling "load SP
and PC from memory", we're just doing it in each
board model rather than in the CPU model for some reason...

-- PMM

