Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC26C02189
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 09:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spOtC-0004U1-FP; Sat, 14 Sep 2024 05:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1spOt9-0004Sp-Go
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 05:16:19 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1spOt5-00049U-IW
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 05:16:19 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-49bc12c0041so867931137.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726305373; x=1726910173; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0q32Lrrni7s1PBSK1g7ZYQfn5WKYRKKqFFhRfjx+AYs=;
 b=HIW5gZZWuL2XbKU0ihpUdNtmVbx4aXxGcZOdtDeyVjwiLOftXafISZeqepM/CT8G37
 Sr7iK4geJleb/XUaIMlZ0op/cYNqkKQTufwmcORRhpjkCiIXnkRbPPVNpwFW1TvhShEn
 4Qn/hFB/X/LZKB+h0bmkWdLGNlawtPXFmyv8mpS2kZl91xOgW+A45dJtIWPgx3GJolzx
 +B5bNEgPadAdV3ng5vRaVc7eBna4NLJ3nyqqWU8R3/HgPCwKeyMy1hflsCSRtyzXJ6GS
 KpGjKCaDhZ4OGrBmzAhh+amtq0VpI2KDCgRqk8kvVfT5I1uZxBgLL3nUlN5pfCNNLaZt
 xRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726305373; x=1726910173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0q32Lrrni7s1PBSK1g7ZYQfn5WKYRKKqFFhRfjx+AYs=;
 b=lb1CpCwUl362K4g4th0EadM9hTEVo5ZhMppuZe6CdXd4IWp0/Fh1lojejo4rtf/0PY
 Isi73D9XpmCXCf38qr2z61cdu5Su/0DNwoJLp/hOF4eEq9ikqfdasdCIhL1L+rDiej+a
 L4XP2mOtRt3T/gb9k3IkV19f4a70/Cj0mMjXLfOnYDeXvYmbcnLyfobUDpRiZ+cmep++
 ZaQL31o6PmmgvV1kHJgC2N0LT3eQe2jsqty63C2u9MEguIdVGWoAG5ArgcSIfpqsEacO
 jfdU00R1/U8UiE+Qy2IXdGMX8L5pASzE7Mx46f9XTZJ5A+m84amyLOLbu1sMsLzGGl+g
 3kzQ==
X-Gm-Message-State: AOJu0YzUXDN4gHYyw92AtVHTz00SxQYwjl4oVetn62Tr2rdo2KEcDnzc
 X8pAsUFCMFJLx7AnnGLPaFB/xphNyRduWLSxxNfCNgX2rvjE6fLJ3L3pjr4t7xj9Q+uT+DMCB/t
 UKCxgYvfpQ3iq9/iQTa4KffUOqeQ=
X-Google-Smtp-Source: AGHT+IGJZbK7rxNJ3nPFrXJ2TA9DvJqfLuL9XxqJ0Fh2Og+Nusr71NhCUWP2SWzN5z0LKFLxtBYkNA3yGqiwtab+w9Y=
X-Received: by 2002:a05:6102:54a5:b0:49b:d526:219f with SMTP id
 ada2fe7eead31-49d414ac8c1mr8465426137.16.1726305373382; Sat, 14 Sep 2024
 02:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
 <CAFEAcA_W5bTcCmeAx+dB4+djcUHzjRH4GfBobaHot5VjE+x05g@mail.gmail.com>
In-Reply-To: <CAFEAcA_W5bTcCmeAx+dB4+djcUHzjRH4GfBobaHot5VjE+x05g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 14 Sep 2024 19:15:47 +1000
Message-ID: <CAKmqyKOFnajGSsKS2k=kYsB--uRjoCZZTv3QSxbEm40HK_k1jA@mail.gmail.com>
Subject: Re: [PULL 00/47] riscv-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>,
 Ajeet Singh <itachis6234@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

On Fri, Sep 13, 2024 at 8:37=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 12 Sept 2024 at 06:30, Alistair Francis <alistair23@gmail.com> wr=
ote:
> >
> > The following changes since commit a4eb31c678400472de0b4915b9154a7c20d8=
332f:
> >
> >   Merge tag 'pull-testing-gdbstub-oct-100924-1' of https://gitlab.com/s=
tsquad/qemu into staging (2024-09-11 13:17:29 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240=
912-1
> >
> > for you to fetch changes up to 90d5d3c1115399d8e27621efd69dfa74a35a4932=
:
> >
> >   hw/intc: riscv-imsic: Fix interrupt state updates. (2024-09-12 15:05:=
10 +1000)
> >
> > ----------------------------------------------------------------
> > RISC-V PR for 9.2
> >
> > * Add a property to set vl to ceil(AVL/2)
> > * Enable numamem testing for RISC-V
> > * Consider MISA bit choice in implied rule
> > * Fix the za64rs priv spec requirements
> > * Enable Bit Manip for OpenTitan Ibex CPU
> > * Fix the group bit setting of AIA with KVM
> > * Stop timer with infinite timecmp
> > * Add 'fcsr' register to QEMU log as a part of F extension
> > * Fix riscv64 build on musl libc
> > * Add preliminary textra trigger CSR functions
> > * RISC-V IOMMU support
> > * RISC-V bsd-user support
> > * Respect firmware ELF entry point
> > * Add Svvptc extension support
> > * Fix masking of rv32 physical address
> > * Fix linking problem with semihosting disabled
> > * Fix IMSIC interrupt state updates
>
> Hi; this fails to build on FreeBSD:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/7817823771

Ajeet do you mind looking at this failure and sending a new series with a f=
ix

Alistair

>
> In file included from ../bsd-user/elfload.c:31:
> In file included from ../bsd-user/freebsd/target_os_stack.h:24:
> ../bsd-user/riscv/target_arch_sigtramp.h:32:33: error: initializer
> element is not a compile-time constant
> 32 | /*2*/ const_le32(0x00050513 + (sigf_uc << 20)), /*addi a0,a0,sigf_uc=
*/
>    |                  ~~~~~~~~~~~^~~~~~~~~~~~~~~~~
> /tmp/cirrus-ci-build/include/qemu/bswap.h:168:26: note: expanded from
> macro 'const_le32'
> 168 | # define const_le32(_x) (_x)
>     |                          ^~
>
>
> and
>
> In file included from ../bsd-user/main.c:53:
> ../bsd-user/riscv/target_arch_cpu.h:126:13: error: call to undeclared
> function 'force_sig_fault'; ISO C99 and later do not support implicit
> function declarations [-Werror,-Wimplicit-function-declaration]
> 126 | force_sig_fault(signo, code, env->pc);
>     | ^
> ../bsd-user/riscv/target_arch_cpu.h:129:9: error: call to undeclared
> function 'process_pending_signals'; ISO C99 and later do not support
> implicit function declarations
> [-Werror,-Wimplicit-function-declaration]
> 129 | process_pending_signals(env);
>     | ^
> ../bsd-user/main.c:608:5: error: call to undeclared function
> 'signal_init'; ISO C99 and later do not support implicit function
> declarations [-Werror,-Wimplicit-function-declaration]
> 608 | signal_init();
>     | ^
> 3 errors generated.
>
> thanks
> -- PMM

