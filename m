Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E85C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJwj-00015Z-SW; Tue, 23 Jul 2024 14:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwY-00012M-D9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:08:59 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwW-0001Ax-7n
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:08:58 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso25954745ab.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721758134; x=1722362934;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/rRuBYD6EDQKCK7AkPTJnkZIiqeHYwg0IQiC71/6mmw=;
 b=BFTjIoaE7HNXpltjEcx+HNQFc9XuyvJtSFUTEMJBktPcEJKS19Q9Elu5yCEk7nqepd
 3Xtc8G+4A18zB7DJ57nP3riL2VjiaRcHMGBneVbDhKjxwHcyaqwM9MaYw0QRb8YrYdKd
 MkpxSBN1c6hZPPjEz1KByVtDxpsQhy4zIjLuhkB3w6tTVENELWJmXO5H1TAXM5EBhqt9
 rKzVQdD91PNkoYPWSNJ4bldn3XUfLZe3IaZ5rgHi/Hy+2LF7qdfGt/knhZXhMHtZr/sz
 LE3pV0baJtWrFDbHTYetcxLonT5Eg1qlrN57fjkZbcb2+fu3n8Z7HFVe8DBdferet9Wv
 bONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758134; x=1722362934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/rRuBYD6EDQKCK7AkPTJnkZIiqeHYwg0IQiC71/6mmw=;
 b=O1oht0FL+BZYbq2tpl7NnGPOGVx3G6zFhIOo1m4J1HHgGwuf8hkABCK/2ZPNCHT0nG
 ad5aM7soqiqH8z0ZJg4U1CWn91Y71UiO/hfg0gQsJHCQ+HP8k9udP7A+5RyV12yIANHM
 qXC4QZCOwSSXRxiCEsjJFAbKZ0GsCZU4e85pKbXcP6zzLLRd1DFUs+LBBB9A19FuGZB4
 2Vy9fSyeZBFY0+Wam90Y/jMniVPnmuNe1YcoMTG/GtfM4M6DJYqccdbTokc4+cgTO48B
 SADt+yJBm//+lA0Ol6qNqGyozqJh9nsKqPmFfnncJYQWgptSXaDvQbR+0a5vEQoqmY0D
 B3Mg==
X-Gm-Message-State: AOJu0YxykWBFb5avANyeLOU9SAfZrYW+x+h5SKXPMB5VKyxkTsmEldG7
 H8mN0J07ViDEpIav6HxhYbxBQ+JpKg/6vo9YtlQuFaFeq8hwesy+9VelTRwSj62txzY4lw90PnU
 Xf0w=
X-Google-Smtp-Source: AGHT+IHZyi4Jm4lLUzdYWb9zCT0MvmL4t5DV2g8ymXbzMomW7ekO0s6VPvpLwhr/Fs0b94h8jnQPIQ==
X-Received: by 2002:a05:6e02:15c8:b0:375:e93b:7c8c with SMTP id
 e9e14a558f8ab-39a16c536f8mr9409185ab.12.1721758134126; 
 Tue, 23 Jul 2024 11:08:54 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a2827csm33361775ab.53.2024.07.23.11.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:08:53 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org
Subject: [PULL 00/14] Bsd user for 9.1 patches
Date: Tue, 23 Jul 2024 12:07:11 -0600
Message-ID: <20240723180725.99114-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12e;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12e.google.com
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

for you to fetch changes up to afdb6be1bd8528395af65a087bd668bf7a42ab99:

  bsd-user: Add aarch64 build to tree (2024-07-23 10:56:30 -0600)

----------------------------------------------------------------
bsd-user: Misc changes for 9.1 (I hope)

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

iQIzBAABCgAdFiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmaf8RUACgkQbBzRKH2w
EQAnYA/9F6NbHwV8C6c5zxiKR2PIXvER21khu+c3wwCMgm+Sy4yEIJxtX+L0St1I
7L4MkgSByeOJmAmw1h0xbWY4IGmTC0ylnyPLq4WIKHP2XnGgs2zYx/CWpEs20QWH
bORg7KXpmTsK3Ag0ilQHTH7HspW3xhZGia4C0uaxYU+E3nns04Mp/TFzbLxq1VfP
xJ8DKjVS39StoBjaWlkKN4TnmD1eXPl4WC+9aElVZJX5DicJHN2Cz3sjIZppJOFg
AXBdeKUXBh5o2oxxRxIv5P/wUROl5NuOpEzE80Ed3B4okbzXdIbsYA07t+UlcoXk
2YMEWfzPmH8nveD5w8T3YtVAlzEJMjWgVeFZg43lT+aHktX3ixstQUkumzAm3A1Z
1TsXtP4D4ZRgeH991V+ZbA/2D0mxg03Z5kldw+jcoYUkjQNOMEy/i0ewNPhX4V/d
l+YIeoxXEu06/v+ibjzL3/WMEvSofYw9nK3/BNGE9rfsNh8tKTFh8Ro+i6wQgKBB
XOgQeuv+X1nwQ1xeZvl8uunFxN5yJqTyw2O6JN6z+3xnPMnBGz8yvkipdQPv5yRg
GJEau8H0C9xesaCtURwNX0AC9BrZpoZ8/5zuLE9MGyyXuoN6jBkt/k6z+e4EL1j5
x7Ezp+srEhlG+g+yozgeDIk3W0YdCPDwBNKDvzwSuNS5prLMrg8=
=Bdnq
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

Warner Losh (6):
  bsd-user:Add ARM AArch64 support and capabilities
  bsd-user:Add setup_sigframe_arch function for ARM AArch64
  bsd-user: Hard wire aarch64 to be 4k pages only
  bsd-user: Define TARGET_SIGSTACK_ALIGN and use it to round stack
  bsd-user: Make compile for non-linux user-mode stuff
  bsd-user: Add aarch64 build to tree

 bsd-user/aarch64/signal.c               | 137 +++++++++++++++++
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
 22 files changed, 1001 insertions(+), 153 deletions(-)
 create mode 100644 bsd-user/aarch64/signal.c
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


