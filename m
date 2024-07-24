Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746F2C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk7u-0000Ac-61; Wed, 24 Jul 2024 18:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7r-000073-Bf
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:23 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7n-0006Qi-MD
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:23 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-80a2939265cso12159639f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858776; x=1722463576;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PyflwMfaFV0K9q8t2Q4JEVgM00Cs9SXxuZPArzgWGaQ=;
 b=tpjiJ+1/3iQ6+/yZjqSMMBlsyXo3F2DNhO46Av8hL+P4plhVmsivPIlZFnwTnFqG5D
 8Vgce11TpiuD+qIaq17xLjFFLxjGX9UL3TArq7QMPs6rCs9RjmBWsFvRwfn1xtFl6f/R
 A6ZCzDgm2hCFNokoxBTS8tUnL3nr5uyd0SgWpKomiC5y3BEd9yHhYaPNAYx218B88UEI
 WP6UZX+uoOt3zEJjEIUC8VKZO16QRTwjs0TCp751jygj/ZMDYXNgDVHi58r57PobjgJu
 whx0S30nPPV13UIFlebtZaPgEitbktdroJns0LdVlxfNjLmM+tULQSNilPcnBfyeob6X
 Z3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858776; x=1722463576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PyflwMfaFV0K9q8t2Q4JEVgM00Cs9SXxuZPArzgWGaQ=;
 b=AtloCb49th/Ic8jZycT3FZX7rxSL1NpHDpFGXejPNQERxDo8uxRPmfh8I0PGxL1PaV
 9k7muUfh+B/OFjGuhP9ghOoZJdGzBwK5K5fBhaOh8vujJeD58G2fo9BEiLtjiBKtbfN+
 kqz4fo19WW+rXKm2GR4g7fIU3jWjZRqJzzd/cx+Jte8a8FSYWLizsmGLIgbgNQBWESzv
 5gRylkG/CTsbFi73c/24/bMEKwztjg3+dQSLWb5utBxWiXVuSAaqrB0BfjgkEhH1afJN
 OL2g8W4l9G9sykxe1XiMq5hRyUmiFgrTGHS3bJg84impQS7wd/X44rlY9IgHoPtCInNA
 MCjw==
X-Gm-Message-State: AOJu0YzyAF5gnUB9ZZWMSZTFoFpOx8ZuqAqOwhJJkjor0oP34sGfv809
 uabBtipe99kPVI1Z4jvR+BMBmrJHACgRItgBUQTSK8+3UD5iXmQhOJZQZamXwuXqA2QmreVTkeC
 537s=
X-Google-Smtp-Source: AGHT+IEWtIxxWxmA8bgjXzN1blSk5QnatxHX5byBnipSZCaVKfotWH39c16qx/uSvDNu79uAw7BtNA==
X-Received: by 2002:a05:6602:27cb:b0:7f6:82b2:909e with SMTP id
 ca18e2360f4ac-81f7e454d7fmr18546539f.2.1721858775974; 
 Wed, 24 Jul 2024 15:06:15 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:15 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>
Subject: [PULL 00/15] Bsd user for 9.1 patches
Date: Wed, 24 Jul 2024 16:04:33 -0600
Message-ID: <20240724220449.10398-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 3cce8bd4d737f2ca688bbdcb92cd5cc683245bbd:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-07-23 15:23:05 +1000)

are available in the Git repository at:

  git@gitlab.com:bsdimp/qemu.git tags/bsd-user-for-9.1-pull-request

for you to fetch changes up to ec018b76798e1196882ebcbf3df15e6d86ac9d7c:

  bsd-user: Add target.h for aarch64. (2024-07-24 16:02:07 -0600)

----------------------------------------------------------------
bsd-user: Misc changes for 9.1 (I hope)

V2: Add missing bsd-user/aarch64/target.h

This patch series includes two main sets of patches. To make it simple to
review, I've included the changes from my student which the later changes depend
on. I've included a change from Jessica and Doug as well. I've reviewed them,
but more eyes never hurt.

I've also included a number of 'touch up' patches needed either to get the
aarch64 building, or to implmement suggestions from prior review cycles. The
main one is what's charitably described as a kludge: force aarch64 to use 4k
pages. The qemu-project (and blitz branch) hasn't had the necessary changes to
bsd-user needed to support variable page size.

Sorry this is so late... Live has conspired to delay me.
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAABCgAdFiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmahejwACgkQbBzRKH2w
EQCXuQ/+Pj1Izmox/y9X1trn1T8KC7JdMtimdLiGMaS4C6+gcThXJkIB4l9ZStbV
7rI540mpqVf0KSRLYwc2/ATyhYU7Ffsz02WPn7Xn/NvmmITp4kjw9Z0gd7C7mPVq
fS8DJbTyFQDy5dO8FUKLaTfnlYQe+NCnL421t9wFkIrlEepFygRaBaJN5yWVoC+0
1Ob6dG+JEV5BmNguMufvvI3S7nEFEnSBGpNqW3ljrRHAZjdNhv8d9GBYbj1laR1r
HQ6r5+u4ZmKCuUbchS0jxGkug0DjuQC7iq+rQ/7fhLYLChkPZ4P2RxNv8ibzKjEV
wlTy5LaM+WZNzKWdcHfDFMomeSnnUkOOfAMipMney2jedEjTIwCFDnP4zCAuG83V
RbdXWfleP1rDto3AQ765pFneqm3+su2Dh4TKaTSnq6gd1eORJ2IL8dubCfcVwZCy
TofemXPWh0HX3kwlD9IB9rqplQZFL78TkQ47btftxinHCLCQOOHRDPVG0IahQPjo
pgK4yVH7WA7pWV2Xbo4ngG3sX5U1TyBCbfkkAwhq+P3gjnU8zxonx8Tk/qLeEDdH
KEypi/pkGFQKZY0wc/y4XM+XQh6E1l8gMaQ4gJWK1qlyVtUKM1BiNQ2lweohYzC8
p6WAfBQLPpzY4mDWfJMF6DsgObLwWmYbgKzuOtHgST1D/Ebk3Zo=
=RPuN
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Doug Rabson (1):
  bsd-user: Simplify the implementation of execve

Jessica Clarke (1):
  bsd-user: Sync fork_start/fork_end with linux-user

Stacey Son (6):
  bsd-user:Add CPU initialization and management functions
  bsd-user:Add AArch64 register handling and related functions
  bsd-user:Add ARM AArch64 signal handling support
  bsd-user:Add get_mcontext function for ARM AArch64
  bsd-user:Add set_mcontext function for ARM AArch64
  bsd-user:Add AArch64 improvements and signal handling functions

Warner Losh (7):
  bsd-user:Add ARM AArch64 support and capabilities
  bsd-user:Add setup_sigframe_arch function for ARM AArch64
  bsd-user: Hard wire aarch64 to be 4k pages only
  bsd-user: Define TARGET_SIGSTACK_ALIGN and use it to round stack
  bsd-user: Make compile for non-linux user-mode stuff
  bsd-user: Add aarch64 build to tree
  bsd-user: Add target.h for aarch64.

 bsd-user/aarch64/signal.c               | 137 +++++++++++++++++
 bsd-user/aarch64/target.h               |  20 +++
 bsd-user/aarch64/target_arch.h          |  29 ++++
 bsd-user/aarch64/target_arch_cpu.c      |  31 ++++
 bsd-user/aarch64/target_arch_cpu.h      | 189 ++++++++++++++++++++++++
 bsd-user/aarch64/target_arch_elf.h      | 163 ++++++++++++++++++++
 bsd-user/aarch64/target_arch_reg.h      |  56 +++++++
 bsd-user/aarch64/target_arch_signal.h   |  82 ++++++++++
 bsd-user/aarch64/target_arch_sigtramp.h |  48 ++++++
 bsd-user/aarch64/target_arch_sysarch.h  |  42 ++++++
 bsd-user/aarch64/target_arch_thread.h   |  61 ++++++++
 bsd-user/aarch64/target_arch_vmparam.h  |  74 ++++++++++
 bsd-user/aarch64/target_syscall.h       |  51 +++++++
 bsd-user/arm/target_arch_signal.h       |   2 +
 bsd-user/freebsd/os-proc.c              | 118 +--------------
 bsd-user/i386/target_arch_signal.h      |   2 +
 bsd-user/main.c                         |  44 ++----
 bsd-user/qemu.h                         |   3 +
 bsd-user/signal.c                       |   9 +-
 bsd-user/x86_64/target_arch_signal.h    |   2 +
 configs/targets/aarch64-bsd-user.mak    |   3 +
 target/arm/cpu-param.h                  |   4 +
 target/arm/gdbstub64.c                  |   4 +
 23 files changed, 1021 insertions(+), 153 deletions(-)
 create mode 100644 bsd-user/aarch64/signal.c
 create mode 100644 bsd-user/aarch64/target.h
 create mode 100644 bsd-user/aarch64/target_arch.h
 create mode 100644 bsd-user/aarch64/target_arch_cpu.c
 create mode 100644 bsd-user/aarch64/target_arch_cpu.h
 create mode 100644 bsd-user/aarch64/target_arch_elf.h
 create mode 100644 bsd-user/aarch64/target_arch_reg.h
 create mode 100644 bsd-user/aarch64/target_arch_signal.h
 create mode 100644 bsd-user/aarch64/target_arch_sigtramp.h
 create mode 100644 bsd-user/aarch64/target_arch_sysarch.h
 create mode 100644 bsd-user/aarch64/target_arch_thread.h
 create mode 100644 bsd-user/aarch64/target_arch_vmparam.h
 create mode 100644 bsd-user/aarch64/target_syscall.h
 create mode 100644 configs/targets/aarch64-bsd-user.mak

-- 
2.45.1


