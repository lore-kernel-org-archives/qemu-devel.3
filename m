Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51241C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 05:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ZxA-0007e8-PF; Fri, 04 Apr 2025 01:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0Zx8-0007dn-D5; Fri, 04 Apr 2025 01:50:54 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0Zx5-00066D-8Z; Fri, 04 Apr 2025 01:50:53 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-86d5a786c7cso800414241.2; 
 Thu, 03 Apr 2025 22:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743745849; x=1744350649; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WtapgEIMKAfUTHOqTamO2rJh5a/YNNNWDh0+/jvBVU=;
 b=YjwrR8BVWOQdS8qaMNCyU3bJRUEZSxhIY1utNZp4Df9cJj9E+e0xB/2jeoVvYpBGru
 zB0CFSnFJ5X3bySjN57EpX7PS5wQPGIauGytWbbEVzMXXCkNNhMhrHUw2Tycg9J+myCi
 lIHT+O8taKLk13Pkq1Jtlzau40oiBDPavvKyzMuDQj8Gbqg4lHqi95kGhCza003Pu0l3
 jQWEw0Q5vDM8ZnWl7E+QcD5MR6sjTh3gDkBb+tQ9JsCH5GBZplverjDICjcrcFWvMikY
 m//21B9tqV+hPmT2yWCuRJHk/Q3RNdv9ww/jE4GyQ3ukUno4Ijt3g+nIyOiz+AHz+amU
 daug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743745849; x=1744350649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WtapgEIMKAfUTHOqTamO2rJh5a/YNNNWDh0+/jvBVU=;
 b=mKV3raG0Y/wZa7qOpHEi68D5UaFS9OZkf9OdD8P+ZAYTRfV7TR7RRwsZ1wlZ0hmTr1
 AbSn/FTKjpaqwRQYoCAbo905rR9pYM3x43tjNjryCCE8D4r/SryHqUZDCpTyT+ln7KTa
 fwNzeYNzQQF/TA9yzhL+a8lKu3SrR6A76Zz/HVOBA4l7Z8E8Cuz1OFn3m8iom1NjS6Us
 p245Fhm4aYfX+EzrcluwdjO22nKJ/4HMuei+8fbdTPjzB9/YfaUncyIRHjnswllZFWrr
 655FCs+5RF7VogZ8DMW/ZxSwlv19lSUEKq2Y7WUlt6s0XWO4FgTLFJD9UTWdKAY0+PQ9
 CIdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaXYk8A3YT+z9xjNOs1PVLdAQ8f6Lzz6Odddo9PREQOZAa7DCNlL/DyeCTrMwvv7oR2URZo33gFTmv@nongnu.org,
 AJvYcCWA85C3PSvtvwIEi4TaUlNCXs5+AnIs1LwVDBpkg4MbX+PwRXbB7GgEVGkUwuT0iawcx6I6im0D1b+AQw==@nongnu.org
X-Gm-Message-State: AOJu0YxrVytPXZR7vc5M55LRm53Zyu3DODbEtXb0m/s1cnfHQV7t8x/M
 umSF83KVoiI39PhGz/lrg5sI8nM0OcTLZGZW+oiSpDeHjSsKICHL1gYm9bsFNlRz0vLobgK/aEX
 ieLWnwK2Rwv12fyfe3LqmIY32yJg=
X-Gm-Gg: ASbGncv2gfarkiK/ViqcU5Iko6qABh8lds2PmzOirDBSJ7XBWZJ/pWY0oN4iNasuhCS
 h7FRMfrGEm8tE/h267NfLRZhl47HA85M4XXQbLEhEXzfEJWW2AkKhP+dctQY87OoBrYzSGVEfSv
 zHbiI9jWieKAZZftJOee8Cu27xssnqxsl7mmxoK5mKCR97uHEBO3WDwq4j
X-Google-Smtp-Source: AGHT+IFPFkNdmDiKFS+m4/HrqBbOXrN0PilZ8235jYZXEXe/ZjptKeMBc9t5Pm4oykeBntM8yL5sp2W58PdSYc6Wl0U=
X-Received: by 2002:a05:6102:504c:b0:4b6:20a5:8a11 with SMTP id
 ada2fe7eead31-4c8553714eamr1395868137.1.1743745849472; Thu, 03 Apr 2025
 22:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250327130256.653357-1-dbarboza@ventanamicro.com>
 <19d7409d-35a0-486f-a626-9d382fb8a6bf@linaro.org>
In-Reply-To: <19d7409d-35a0-486f-a626-9d382fb8a6bf@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 15:50:23 +1000
X-Gm-Features: ATxdqUEnGno7frQwunVmNAoPrlM5NNfrq1RL-QvLjfm2QjuPJ6H1tVMREjICLnI
Message-ID: <CAKmqyKPsRvaVztUdPRwf5h90rVdT9MOrvQz_=WvoEj-bWoTWVg@mail.gmail.com>
Subject: Re: [PATCH for-10.1] hw/riscv: do not mark any machine as default
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Fri, Mar 28, 2025 at 2:16=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 27/3/25 14:02, Daniel Henrique Barboza wrote:
> > Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
> > made it default for qemu-system-riscv32/64. It was the first RISC-V
> > machine added in QEMU so setting it as default was sensible.
> >
> > Today we have 7 risc64 and 6 riscv32 machines and having 'spike' as
> > default machine is not intuitive. For example, [1] is a bug that was
> > opened with the 'virt' board in mind, but given that the user didn't
> > pass a '-machine' option, the user was using 'spike' without knowing.
> >
> > The QEMU archs that defines a default machine usually defines it as the
> > most used machine, e.g. PowerPC uses 'pseries' as default. So in theory
> > we could change the default to the 'virt' machine, but that would make
> > existing command lines that don't specify a machine option to act
> > weird: they would silently use 'virt' instead of 'spike'.
> >
> > Being explicit in the command line is desirable when we have a handful
> > of boards available, so remove the default machine setting from RISC-V
> > and make it obligatory to specify the board.
> >
> > After this patch we'll throw an error if no machine is specified:
> >
> > $ ./build/qemu-system-riscv64 --nographic qemu-system-riscv64: No
> > machine specified, and there is no default Use -machine help to list
> > supported machines
> >
> > 'spike' users that aren't specifying their machines in the command line
> > will be impacted and will need to add '-M spike' in their scripts.
> >
> > [1] https://gitlab.com/qemu-project/qemu/-/issues/2467
> >
> > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > ---
> >   hw/riscv/spike.c | 1 -
> >   1 file changed, 1 deletion(-)
>
> I'm in favor of this change, which I believe is the correct way to
> go, so:

Agreed

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> but I'd rather we follow the deprecation process. Up to the maintainer.

I agree, it is a breaking change, it would be nice to go through the
deprecation process in case people are expecting Spike to be the
default.

Alistair

>
>
>

