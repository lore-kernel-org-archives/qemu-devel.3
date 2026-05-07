Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38B3CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoVf-0007TX-Aj; Wed, 06 May 2026 22:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVT-0007Sk-TK
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:32 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVI-0000Uu-BG
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:23 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso316322a34.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121018; x=1778725818;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EnzoEPr3QxhvD1aDTlmf5NK83VKsWiLUIndD4TqQQR0=;
 b=V8ERwLLE+Qw1RVdRfBb+pvdje5BOI8TWXrvc71trIzWBwsf5uysvevJ0dYEalVpbQw
 tnoSlzuiAXalZS5jdMfk0l91hrLcv0viA7SzcFQriZPnghcUC3HT8iFpoNkAtutrp9vW
 OZwOagrphbkkIlLedm8bKVhlrF3jYBuQx+wJfzCQoS0l/wT/6NfQN/CL6HopKksfoQi9
 sTxyxgOd6FY0aefOG7fXMfcg88ewK4V6eDD5GKR8B9pPxkmCTtHi4Wry+IVoF0bsFrb0
 pAErDy15q7ZitaPXJaJDkOiw/+chwRvkvAiJxoTWNIyiV266eCmVd9ZmzihaD2W2L+YG
 Oi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121018; x=1778725818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnzoEPr3QxhvD1aDTlmf5NK83VKsWiLUIndD4TqQQR0=;
 b=tUhdJoR0TgzmLGzXwFZv3bd7LYxy5yCIMHAPJom50gfEdvxp+Rjvfv2/y18Ljp//Zc
 hwmp3d/Vzz3FIIm/CTwBwyghc3uM2fqkUxw48DUI/zvkdbZMRy/48hvsLLWimSK4SCv0
 5M/ouZ9HqBKSs0DrvGP7PoT3z1sR15pNQw5UjvNP8k8HsxpWKbN90BUp4BZhMUE0xoie
 XF3IpE+wAu4zDzra9DjWoGCc08JH5EL2J3SbPOVeTG7vttkZ7yKHZm0ELP7OW4HTWxcr
 4G0+toWh31VSqW89XvtWu5IK/DNsH6qAqsml9erVieYS4+BfOb1+NjSvcV7x9ubc0qzn
 IhzA==
X-Gm-Message-State: AOJu0Ywu5XUuGEjV5zPXqe+1z9UjGyXHN9tM9jd+zEuaH4KIMK557PgW
 P6AhjzaQF67nQ4vXM+LSl8o3VFEKmVm+id+dNtAQrvRIoksVkleL4bw8X1FVvvwcYHjsIsKxJcn
 MYqUt3VI=
X-Gm-Gg: AeBDieu3mZgn6DukACdE8SAfttm9E0k1/dNhGfUmE2p5HH+sszCXJTipsFZWg8KjMi2
 PNigINxRIGNhtoOqeIhHR4OJLDTtN5XQ+o4lyAeC9K92bwaWKG0JjOAwf0p6J8cYVKNaPINVkOB
 C3SMLMoEOMqz0BUQr2rRI9ldnddIhbdiRY81L1eDya1yXjH38JnraKHW8MjMw0h5hcjAcYIIM/O
 tUOz2SrnD85TvWKuzva64juPrt6bvzHAC1yre9N3ZU3ORStcCeyZZ5m52d+GbOy0fExJRY4kzE7
 BKSzD8jwKy54V+0YNLfK+Y2wN2bZUM3RdNM1xfPNpX9+xjCyVZNPHd+yJK3OTYDHD8driyx/gfb
 2d3p9SK5oIKr7SjiHRz8PMHxscij6jnx0+rP/1YnAZhCQ0qZpL8oOLW/sU6wjJnW0RmOX8wdUf9
 QbtLIU9ecIURaCZrHJeqqUnSNCxx9YFSg=
X-Received: by 2002:a05:6830:910:b0:7de:5612:d420 with SMTP id
 46e09a7af769-7e1df0fc604mr3642698a34.18.1778121018383; 
 Wed, 06 May 2026 19:30:18 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:17 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Kyle Evans <kevans@freebsd.org>
Subject: [PULL 00/25] Bsd user 2026 05 patches
Date: Wed,  6 May 2026 20:28:02 -0600
Message-ID: <20260507022827.44499-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32d.google.com
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

The following changes since commit ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-05-01 14:41:49 -0400)

are available in the Git repository at:

  git@gitlab.com:bsdimp/qemu-from-official.git tags/bsd-user-2026-05-pull-request

for you to fetch changes up to d21201257aa736ed5f80732f59a60a8b2e8f567f:

  bsd-user: Add call to do_bsd_ioctl and add bsd-ioctl.c to the build (2026-05-06 20:20:37 -0600)

----------------------------------------------------------------
bsd-user May 2026 pull request

Three patch series were reviewed during the code freeze and are finally ready to
head into the tree.

(1) Use SPDX identifiers in most places. This makes it easier for me to upstream
since I can do almost all of the files in the forked tree and not have it be an
issue each time I add a new file.

(2) Per discussions in the review, copy thunk.c to bsd-user from linux-user. We
will use this in the third set of patches, ioctls. All that changed is the
copyright header. This file has style problems, but fixing them would be a worse
problem than the style issues since we share it with linux-user and want to
track changes there. In the future we may actually share, but for now this was
the compromise.

(3) All the ioctls that bsd-user supports in FreeBSD. This uses the thunk.c code
to translate back and forth between host and target. A number of pedantic
changes were made against the blitz branch upstream and were discovered or
highlighted by claude code.

I used claude to extract all the ioctl code from the blitz branch for
upstreaming. I had it review the code and fixed the problems it found (though
one was a false positive). I've not tagged these as Assisted-by: since that part
of our policy is in flux. No creative output of claude was applied here, though
it also suggested the commit messages (that I rewrote in large part, but
vestiges of the original remain). To be clear: Claude didn't write any of
the actual code.
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAABCgAdFiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmn7+HkACgkQbBzRKH2w
EQBseRAAn4RqHJDLLdFpyfspFPOr8Etjmq6MdJ3MXtDauyOWE2IIY1bBsr5a81Ko
VjG3zpZ3kOE6eQsCKIHHUEljtrfej3kdrvfdMI5d0Qtk4YQSU3rN2Tz6CRNIQNRb
xALkkvsKY0AxP1xzdldUMCR2oO0AT1u0NC7aPpiKbg8Z4wUujDcaPXnNkun6xoRw
ysELRm3G1zyvIw0WX3LUrcxYel+O4cXoF1Fzi3ZLSyryeKOBXTQG/uA7+9YJUyLx
wsrl++bACCDHwkwnuFiIvg+ZkBiMfkVHz6SLRcMfVjwmAfRuPukvjB8ZZBXRLT94
zeG+R9t4zCRKC8Cka4AsYUyceHfgj/kdNkEd7u5rJHVHSUsfQAbWywRRhjOyO4Ad
3nzKOCJ68e4bu3FOc7ih2pcrS71/zxR1HWa2FgwPOntrDaagCbugfSepZ5bJewvW
rBqujzgLV7B5fNDUAaYP+HnYr/qu6oaJZ4APalubBu+/Y++P1KBzfsiNSoFLHTzU
XFsGB0ktMbVJtqMfQKNBJlsd8XrRguhRvrujwBAKJxUt1XIS7lJfYQIN1sn2pfBe
evUsHsp978u1BR58rwEMRJeYxLIZe+Q6T3JJNXhwC+WsWZvjdLo2Xta78HcudC0R
z1FnH99jlUFpgHiySQUMR/6FYPBxRMQ4dPa4hgLVKYOSyN4GguI=
=L844
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Stacey Son (19):
  bsd-user: ioctl: add common definitions
  bsd-user: Add FreeBSD tty ioctl definitions
  bsd-user: Add FreeBSD file I/O ioctl definitions
  bsd-user: Add FreeBSD socket ioctl definitions
  bsd-user: Add FreeBSD cryptodev ioctl definitions
  bsd-user: Add FreeBSD disk ioctl definitions
  bsd-user: Add FreeBSD IPv6 ioctl definitions
  bsd-user: Add FreeBSD ioctl type definitions
  bsd-user: Add FreeBSD ioctl command table
  bsd-user: Add bsd-ioctl.h header
  bsd-user: Add target_sockaddr and safe_ioctl to syscall_defs.h
  bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
  bsd-user: Add log_unsupported_ioctl function
  bsd-user: Add do_ioctl_unsupported function
  bsd-user: Add target_to_host_sockaddr_in6 function
  bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
  bsd-user: Add do_bsd_ioctl main function
  bsd-user: Add init_bsd_ioctl function
  bsd-user: Add call to do_bsd_ioctl and add bsd-ioctl.c to the build

Warner Losh (6):
  bsd-user: Switch to SPDX-License-Expression
  bsd-user: Add syscall header generator for FreeBSD
  bsd-user: Delete sbrk and sstk system calls.
  bsd-user: Create os-syscall.h
  bsd-user: Switch to generated syscall_nr.h
  bsd-user: Copy linux-user/thunk.c to bsd-user

 bsd-user/aarch64/signal.c               |  15 +-
 bsd-user/aarch64/target_arch.h          |  16 +-
 bsd-user/aarch64/target_arch_cpu.c      |  15 +-
 bsd-user/aarch64/target_arch_cpu.h      |  18 +-
 bsd-user/aarch64/target_arch_elf.h      |  14 +-
 bsd-user/aarch64/target_arch_reg.h      |  19 +-
 bsd-user/aarch64/target_arch_signal.h   |  16 +-
 bsd-user/aarch64/target_arch_sigtramp.h |  16 +-
 bsd-user/aarch64/target_arch_sysarch.h  |  16 +-
 bsd-user/aarch64/target_arch_thread.h   |  16 +-
 bsd-user/aarch64/target_arch_vmparam.h  |  16 +-
 bsd-user/aarch64/target_syscall.h       |  16 +-
 bsd-user/arm/signal.c                   |  18 +-
 bsd-user/arm/target_arch.h              |  16 +-
 bsd-user/arm/target_arch_cpu.c          |  18 +-
 bsd-user/arm/target_arch_cpu.h          |  18 +-
 bsd-user/arm/target_arch_elf.h          |  18 +-
 bsd-user/arm/target_arch_reg.h          |  18 +-
 bsd-user/arm/target_arch_signal.h       |  18 +-
 bsd-user/arm/target_arch_sigtramp.h     |  18 +-
 bsd-user/arm/target_arch_sysarch.h      |  18 +-
 bsd-user/arm/target_arch_thread.h       |  18 +-
 bsd-user/arm/target_arch_vmparam.h      |  18 +-
 bsd-user/arm/target_syscall.h           |  18 +-
 bsd-user/bsd-file.h                     |  18 +-
 bsd-user/bsd-ioctl.c                    | 436 ++++++++++++++++++++
 bsd-user/bsd-ioctl.h                    |  14 +
 bsd-user/bsd-mem.c                      |  17 +-
 bsd-user/bsd-mem.h                      |  30 +-
 bsd-user/bsd-proc.c                     |  17 +-
 bsd-user/bsd-proc.h                     |  17 +-
 bsd-user/freebsd/meson.build            |  10 +-
 bsd-user/freebsd/os-ioctl-cmds.h        | 149 +++++++
 bsd-user/freebsd/os-ioctl-cryptodev.h   |  84 ++++
 bsd-user/freebsd/os-ioctl-disk.h        |  52 +++
 bsd-user/freebsd/os-ioctl-filio.h       |  34 ++
 bsd-user/freebsd/os-ioctl-in6_var.h     | 226 +++++++++++
 bsd-user/freebsd/os-ioctl-ioccom.h      |  43 ++
 bsd-user/freebsd/os-ioctl-sockio.h      | 246 +++++++++++
 bsd-user/freebsd/os-ioctl-ttycom.h      | 239 +++++++++++
 bsd-user/freebsd/os-ioctl-types.h       | 109 +++++
 bsd-user/freebsd/os-misc.h              |  18 +-
 bsd-user/freebsd/os-proc.c              |  17 +-
 bsd-user/freebsd/os-proc.h              |  18 +-
 bsd-user/freebsd/os-stat.c              |  17 +-
 bsd-user/freebsd/os-stat.h              |  18 +-
 bsd-user/freebsd/os-strace.h            |  19 +-
 bsd-user/freebsd/os-syscall.c           |  17 +-
 bsd-user/freebsd/os-syscall.h           |  21 +
 bsd-user/freebsd/scripts/syscallhdr.sh  |   9 +
 bsd-user/freebsd/strace.list            |   4 +
 bsd-user/freebsd/syscall_nr.h           | 515 ------------------------
 bsd-user/freebsd/target_os_elf.h        |  18 +-
 bsd-user/freebsd/target_os_siginfo.h    |  18 +-
 bsd-user/freebsd/target_os_signal.h     |   7 +
 bsd-user/freebsd/target_os_stack.h      |  18 +-
 bsd-user/freebsd/target_os_thread.h     |  18 +-
 bsd-user/freebsd/target_os_user.h       |  18 +-
 bsd-user/freebsd/target_os_vmparam.h    |  18 +-
 bsd-user/i386/signal.c                  |  17 +-
 bsd-user/i386/target_arch.h             |  16 +-
 bsd-user/i386/target_arch_cpu.c         |  17 +-
 bsd-user/i386/target_arch_cpu.h         |  17 +-
 bsd-user/i386/target_arch_elf.h         |  18 +-
 bsd-user/i386/target_arch_reg.h         |  19 +-
 bsd-user/i386/target_arch_signal.h      |  16 +-
 bsd-user/i386/target_arch_sigtramp.h    |  16 +-
 bsd-user/i386/target_arch_sysarch.h     |  18 +-
 bsd-user/i386/target_arch_thread.h      |  18 +-
 bsd-user/i386/target_arch_vmparam.h     |  18 +-
 bsd-user/i386/target_syscall.h          |  16 +-
 bsd-user/meson.build                    |   2 +
 bsd-user/qemu-bsd.h                     |  18 +-
 bsd-user/syscall_defs.h                 |  50 +--
 bsd-user/thunk.c                        | 470 +++++++++++++++++++++
 bsd-user/x86_64/signal.c                |  16 +-
 bsd-user/x86_64/target_arch.h           |  16 +-
 bsd-user/x86_64/target_arch_cpu.c       |  17 +-
 bsd-user/x86_64/target_arch_cpu.h       |  17 +-
 bsd-user/x86_64/target_arch_elf.h       |  18 +-
 bsd-user/x86_64/target_arch_reg.h       |  19 +-
 bsd-user/x86_64/target_arch_signal.h    |  17 +-
 bsd-user/x86_64/target_arch_sigtramp.h  |  17 +-
 bsd-user/x86_64/target_arch_sysarch.h   |  17 +-
 bsd-user/x86_64/target_arch_thread.h    |  18 +-
 bsd-user/x86_64/target_arch_vmparam.h   |  18 +-
 bsd-user/x86_64/target_syscall.h        |  16 +-
 87 files changed, 2362 insertions(+), 1526 deletions(-)
 create mode 100644 bsd-user/bsd-ioctl.c
 create mode 100644 bsd-user/bsd-ioctl.h
 create mode 100644 bsd-user/freebsd/os-ioctl-cmds.h
 create mode 100644 bsd-user/freebsd/os-ioctl-cryptodev.h
 create mode 100644 bsd-user/freebsd/os-ioctl-disk.h
 create mode 100644 bsd-user/freebsd/os-ioctl-filio.h
 create mode 100644 bsd-user/freebsd/os-ioctl-in6_var.h
 create mode 100644 bsd-user/freebsd/os-ioctl-ioccom.h
 create mode 100644 bsd-user/freebsd/os-ioctl-sockio.h
 create mode 100644 bsd-user/freebsd/os-ioctl-ttycom.h
 create mode 100644 bsd-user/freebsd/os-ioctl-types.h
 create mode 100644 bsd-user/freebsd/os-syscall.h
 create mode 100644 bsd-user/freebsd/scripts/syscallhdr.sh
 delete mode 100644 bsd-user/freebsd/syscall_nr.h
 create mode 100644 bsd-user/thunk.c

-- 
2.52.0


