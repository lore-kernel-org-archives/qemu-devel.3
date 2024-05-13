Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB8BC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SsY-0007T7-Ha; Mon, 13 May 2024 06:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6SsE-0007PO-Lb; Mon, 13 May 2024 06:25:41 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6Srv-0000d8-HS; Mon, 13 May 2024 06:25:31 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4df8ea40b2bso1047441e0c.2; 
 Mon, 13 May 2024 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715595907; x=1716200707; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KI7c3nUCG8tvoPRR10lKSKPUTDE22S/poCKkROQ/+Tk=;
 b=OhEFAr5e83aJQ8tfGoPtB5fuRLog4b694hLjgz40U1o/fskX/f3c/jZjhIJCAOwpcV
 bedUajCsXP36/uS83Y9uUdW43LLgFMyt3cJrHQqX6x0L4xS2u9Wf3foau6TO6AT+4/G0
 N/S8V9yg6grxohDGRbZKTel+PCnx69HZffQ2Rd4AOLmesWrctHF4kn/BT30VgLoUhQw3
 V1ie6wHa46ewOLk470seGkmyIulUQA2cGugins4lGTcbOC60D5eJHORYwMcOKIWiI2WS
 b+Gty/UNP5oszUs2GUy7FtZg7j5GfTvx18yVXXwrSDKDrdT2/a7eV3aMnY1V6jSGVshB
 BUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715595907; x=1716200707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KI7c3nUCG8tvoPRR10lKSKPUTDE22S/poCKkROQ/+Tk=;
 b=nmo+yKMmH2CX4pbWsbPskCQ8TguqIGfCrwzFv6BeJiigBB5nN8r5QaX8s6RsLNla7k
 FATXLorRqHrkDq14L/ZbsNxf0ULZT1cQMitSDTAqzWwf+MYq3dZOLoprXmAxnJBUpTPg
 Y2jkmbp9K5SJiIcrL6Jjyjbe1idVUFDTmsgwvi3cmEsX5jPgMzINlfCxUnPjkDo3N3G/
 dverlemjasloDyfr9ozqoU9U9qbcskRtFmKzWi2zlNCdo6gJzCWMM0a1Hh89ExczoxU3
 rqcHjheTjAWRxBJRxyd7x1/xlxIm72laJyOFfgwokGF5anRkh1I04TwGL6gvdFWTc/17
 oR4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrGTUEMPn33QhgENIZdYtb54EA0TLytAW8jWo2OQya0YtOJhB24NZOahcOGp/Od6l7N85yisq3CPQ5vYe6vkpIFrzttuoGMw+nVGjVouCvDBr2Y8TWzxpQgjoYqg==
X-Gm-Message-State: AOJu0Ywvey8j8sQ1aDRinCxWWAXfG77avjSlFaXgcv1uNl7a5KBeYJiB
 CUrPlvywPt/PZ09IeJl4F/bEwXQeED2p0hSTb8vUfZ/JdxdxQrQ+U+oPrYKciafxOPaiYL7rRi5
 y1Y+f+jcWXA4JM9bklIw7Htqusfw=
X-Google-Smtp-Source: AGHT+IGLKWcRFUpeRNSuOaY9LssOa5WcisBI32RiZpPjWNA+QLlTcheTKl1bGxloTuxgjXMcQpaqLzsLcu1WpmwJLUc=
X-Received: by 2002:a05:6122:2a49:b0:4df:19c0:8702 with SMTP id
 71dfb90a1353d-4df88285831mr7345367e0c.1.1715595907409; Mon, 13 May 2024
 03:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <b732f7bd-53d2-4c66-9821-a5bd589f6c56@gmail.com>
In-Reply-To: <b732f7bd-53d2-4c66-9821-a5bd589f6c56@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2024 20:24:41 +1000
Message-ID: <CAKmqyKM+2jhFdAL=3Z0De03hBFR6cn2xtVm3FrkPvn=U8tJLpg@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Pointer Masking update for Zjpm v1.0
To: liwei <liwei1518@gmail.com>
Cc: Alexey Baturo <baturo.alexey@gmail.com>, richard.henderson@linaro.org, 
 space.monkey.delivers@gmail.com, palmer@dabbelt.com, Alistair.Francis@wdc.com, 
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Sun, May 12, 2024 at 12:44=E2=80=AFAM liwei <liwei1518@gmail.com> wrote:
>
>
> On 2024/5/11 18:10, Alexey Baturo wrote:
> > From: Alexey Baturo <baturo.alexey@gmail.com>
> >
> > Hi,
> >
> > It looks like Pointer Masking spec has reached v1.0 and been frozen,
> > rebasing on riscv-to-apply.next branch and resubmitting patches.
>
> Hi, any change from v0.8 to v1.0?

Good question.

Also, this needs another rebase. Sorry, it seems to always have
conflicts. If you re-send I'll apply it right away

Alistair

>
> Regards,
>
> Weiwei Li
>
> >
> > Thanks.
> >
> > [v8]:
> > Rebasing patches on current qemu branch and resubmitting them.
> >
> >
> > [v7]:
> > I'm terribly sorry, but previous rebase went wrong and somehow I missed=
 it.
> > This time I double-checked rebased version.
> > This patch series is properly rebased on https://github.com/alistair23/=
qemu/tree/riscv-to-apply.next
> >
> > [v6]:
> > This patch series is rebased on https://github.com/alistair23/qemu/tree=
/riscv-to-apply.next
> >
> > [v5]:
> > This patch series targets Zjpm v0.8 extension.
> > The spec itself could be found here: https://github.com/riscv/riscv-j-e=
xtension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf
> > This patch series is updated after the suggested comments:
> > - add "x-" to the extension names to indicate experimental
> >
> > [v4]:
> > Patch series updated after the suggested comments:
> > - removed J-letter extension as it's unused
> > - renamed and fixed function to detect if address should be sign-extend=
ed
> > - zeroed unused context variables and moved computation logic to anothe=
r patch
> > - bumped pointer masking version_id and minimum_version_id by 1
> >
> > [v3]:
> > There patches are updated after Richard's comments:
> > - moved new tb flags to the end
> > - used tcg_gen_(s)extract to get the final address
> > - properly handle CONFIG_USER_ONLY
> >
> > [v2]:
> > As per Richard's suggestion I made pmm field part of tb_flags.
> > It allowed to get rid of global variable to store pmlen.
> > Also it allowed to simplify all the machinery around it.
> >
> > [v1]:
> > It looks like Zjpm v0.8 is almost frozen and we don't expect it change =
drastically anymore.
> > Compared to the original implementation with explicit base and mask CSR=
s, we now only have
> > several fixed options for number of masked bits which are set using exi=
sting CSRs.
> > The changes have been tested with handwritten assembly tests and LLVM H=
WASAN
> > test suite.
> >
> > Alexey Baturo (6):
> >    target/riscv: Remove obsolete pointer masking  extension code.
> >    target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
> >      of Zjpm v0.8
> >    target/riscv: Add helper functions to calculate current number of
> >      masked bits for pointer masking
> >    target/riscv: Add pointer masking tb flags
> >    target/riscv: Update address modify functions to take into account
> >      pointer masking
> >    target/riscv: Enable updates for pointer masking variables and thus
> >      enable pointer masking extension
> >
> >   target/riscv/cpu.c           |  21 +--
> >   target/riscv/cpu.h           |  46 +++--
> >   target/riscv/cpu_bits.h      |  90 +---------
> >   target/riscv/cpu_cfg.h       |   3 +
> >   target/riscv/cpu_helper.c    |  97 +++++-----
> >   target/riscv/csr.c           | 337 ++--------------------------------=
-
> >   target/riscv/machine.c       |  20 +--
> >   target/riscv/pmp.c           |  13 +-
> >   target/riscv/pmp.h           |  11 +-
> >   target/riscv/tcg/tcg-cpu.c   |   5 +-
> >   target/riscv/translate.c     |  46 ++---
> >   target/riscv/vector_helper.c |  15 +-
> >   12 files changed, 158 insertions(+), 546 deletions(-)
> >
>

