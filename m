Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B7ECED25B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 02:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy0LL-0007Dx-BK; Mon, 07 Oct 2024 22:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sy0LJ-0007DP-K2; Mon, 07 Oct 2024 22:52:57 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sy0LH-0000Zo-VW; Mon, 07 Oct 2024 22:52:57 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-84e857bc0feso2829939241.0; 
 Mon, 07 Oct 2024 19:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728355974; x=1728960774; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FX9JGiMDxOlwd/M6UUiIW5RV5yq4JFKHzR5ivOEV+I0=;
 b=g9THTMmXIvbZGKwHqhbSQhubRgcQf3S78MwERhJ78PdLZd5son8lU7dbH+46d35vIK
 CKC4oQoKsBiPd48KAQ3C5dqiKlXN8O58jejDCFejyuzgg1xGPZ11zHS+7XIVjkqXN4od
 Qp1QAfAxXwOWaPMIYy3rGf5JxFdV5lwN+mWFjvGX417p/Z8t+hvlsAGAiWAhRF/RA6iT
 bzEi5Tl+gohZzo0qIBs4ewOfadLyyCqlKuICd3l9Ce4lWbkx29qisjdpbrrr9WfqhOyj
 +oabq0CkQUxI31BYsarAtWFiwv6h2KeYBSX7JNApufdkfLCQayKGesSASK9camiSStr4
 TJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728355974; x=1728960774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FX9JGiMDxOlwd/M6UUiIW5RV5yq4JFKHzR5ivOEV+I0=;
 b=O6qsIpZLs6hwM8fFyYWhUjxeUQySduqJEdeI25brnl0UQMPq+6alG/VKhmphO8ZXPG
 Bt4uq0KNUn7wuc2crhx+0A/V2PnYvKBl8kKFVfsrZi6CVzfeJjjj9SQtjjGox/td0xjz
 nDSss3oxvmOVci44Sf0XXELkvbTvjS8n21f42Arb5tHPfUIE7slscKP2k8yBK9bENIPf
 /92B3vRyEJEeOHEH2rGE+hgc/f7nz8TTUL1L2p2SkkyhtsA6/s6FnE8FYJbXZckwc+Ga
 ISVhH9eDkf8ihwoqJWrnRmmg1QBK440lRrGFGDRUCgVeurixb1oEjuwZApDCcEQhRdxW
 VOrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlJ0PHTYjTnEv8JXG4eE5N+EJuL+8dZ4L//sfP8dnCK9kPcx9Gc8wfFMXnLJkY4TXBNuRVZQct+eWi@nongnu.org,
 AJvYcCX1T2qDotONP2Tkk58feioTQrz+fnqOhVvxImOp2PwNaOo5eAjxpht28SBg/2L0A0oGK0zf0DJcvqWpLA==@nongnu.org
X-Gm-Message-State: AOJu0YzP62iAq5459okIdU6cTDUVlH/svvjmpGqzAYd4vLN1SGqmGskp
 DmibQW7H1yy6mPYUX26zMn8q65JErLCgCT8SgoABGinKZxEnhmqqwxgvFnZST7v5u+MqfPriLaL
 LqMSb/HchFr21BuJjvtOcMXxh10Y=
X-Google-Smtp-Source: AGHT+IH63q7nW84ndmyAZxkrLkifyxhhuKMT4Xfu3nJn2Z6z/YUlMRJIaN3uc6n4CUNrwmK63GgnfJJ7UmZbmgyRXWU=
X-Received: by 2002:a05:6102:50a7:b0:4a3:c912:6707 with SMTP id
 ada2fe7eead31-4a43890a020mr1378611137.7.1728355973884; Mon, 07 Oct 2024
 19:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240910174747.148141-1-alexei.filippov@syntacore.com>
In-Reply-To: <20240910174747.148141-1-alexei.filippov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 12:52:27 +1000
Message-ID: <CAKmqyKPH33Lf5YdNrdHEQ9K0ZLrnJmvcGi9DjsP6gKNQZYAxaA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] target/riscv: Add support for machine specific
 pmu's events
To: Alexei Filippov <alexei.filippov@syntacore.com>,
 Atish Patra <atishp@rivosinc.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Wed, Sep 11, 2024 at 3:49=E2=80=AFAM Alexei Filippov
<alexei.filippov@syntacore.com> wrote:
>
> Following original patch [1] here's a patch with support of machine
> specific pmu events and PoC with initial support for sifive_u's HPM.

Thanks for the patch.

I'm hesitate to support these callback functions as I feel they
(callbacks in the CPU to the machine in general) are clunky.

I think the cover letter, code and commit messages need more details here.

First can you link to the exact spec you are trying to implement
(RISC-V has a habit of creating multiple "ratified" specs that are all
incompatible). It's really handy to point to the exact PDF in the
cover letter or commit message to just be really clear what you are
supporting.

Secondly, can you describe why this is useful? What is the point of
machine specific PMU events? Why do we want to support this in QEMU?

The callbacks should also have some documentation in the code base so
others can implement the functionality.

It might also be helpful to split this patch up a little bit more. A
quick read through and it seems like the patches could be a little
smaller, making it easier to review.

Finally, for the next version CC @Atish Patra  who has ended up being
the PMU person :)

Alistair

>
> =3D=3D Test scenarios =3D=3D
>
> So, I tested this patches on current Linux master with perf.
> something like `perf stat -e branch-misses perf bench mem memcpy` works
> just fine, also 'perf record -e branch-misses perf bench mem memcpy'
> collect samples just fine and `perf report` works.
>
> =3D=3D ToDos / Limitations =3D=3D
>
> Second patch is only inital sifive_u's HPM support, without any
> filtering, events combining features or differrent counting
> algorithm for different events. There are also no tests, but if you
> have any suggestions about where I need to look to implement them, please
> point me to.
>
> =3D=3D Changes since original patch =3D=3D
>
> - Rebased to current master
>
> [1] https://lore.kernel.org/all/20240625144643.34733-1-alexei.filippov@sy=
ntacore.com/
>
> Alexei Filippov (2):
>   target/riscv: Add support for machine specific pmu's events
>   hw/riscv/sifive_u.c: Add initial HPM support
>
>  hw/misc/meson.build            |   1 +
>  hw/misc/sifive_u_pmu.c         | 384 +++++++++++++++++++++++++++++++++
>  hw/riscv/sifive_u.c            |  14 ++
>  include/hw/misc/sifive_u_pmu.h |  24 +++
>  target/riscv/cpu.c             |  20 +-
>  target/riscv/cpu.h             |   9 +
>  target/riscv/csr.c             |  93 +++++---
>  target/riscv/pmu.c             | 138 ++++++------
>  target/riscv/pmu.h             |  19 +-
>  9 files changed, 599 insertions(+), 103 deletions(-)
>  create mode 100644 hw/misc/sifive_u_pmu.c
>  create mode 100644 include/hw/misc/sifive_u_pmu.h
>
> --
> 2.34.1
>
>

