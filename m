Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA96CCA5FE2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChPY-0003g8-87; Fri, 02 Oct 2026 13:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChPM-0003eK-PP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:50:57 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChPH-0007GU-Mv
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:50:55 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-34e0b5014e8so1570226eec.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963450; x=1791568250; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FZTlN64QVsUO2Oc2Rk0AfpagsIwmx7bVEeTsaSnN0Yo=;
 b=gZnvqxpmJWA+BZh7Ypcfkrvs5fD2QosAYCGMDXn5qPULczURyJWbBVBj2GbyBd1TAg
 PA9yb3uS9wfaYk85mU3kk8sXTwoxCg+JcawzF/kDVPDb2JnzXzq5q5UdxZngN+d+dImi
 L0S4FyG1Du6M5LI4jbhAzNuJNyEiy3NrNYAGYZRJSybN+aECz9ufbIi+/XPKiFOuY4S2
 9fRrCrg57u76XCZ97DYvCVLCOlLWBjbxTqYavsRw0JbHHUYMxOvypqYZuuJ2/batagiK
 t6WF/DKGJoK/XoWBBP3deiNMIp64wXWn1axBzrwtS9MB/2wM4YM7KAR7/ASawXqa6XTW
 6C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963450; x=1791568250;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FZTlN64QVsUO2Oc2Rk0AfpagsIwmx7bVEeTsaSnN0Yo=;
 b=SA36lzO4i761VpBWVz3GEQahmIhjQuaqBYoibonL5+2/nEUBLRUTAUJO8vdUbybhJH
 Lk9c7bs8ZdhXu9Q7mB8+Yna1fkH3w6B/R5i6DGiDKQCru6I8CTFgH4DuLYNeOIOlpSdy
 2Zed7FDvQkncJ6PxDsZAXmtkIMv+oKJjG4pDJ8OPGAxsOPOoSfAsNrAnvYh2W/E0y01m
 3dFUgIygzUkqw2XFrdYpfLgdJ0JKDtaTMLbRE4s6RQuE1i50ATUP0GJ8Xdy1ggB6N4Om
 z3a9BTHNwL1Qmp59MH3CuXX7/g4qFos/0eO+Z/s+H5UghEJqnrnVOOvPSS1hy0rtF36Z
 lphg==
X-Gm-Message-State: AFuF++n+g+zo3UWD+OeYYIdMmAT99umUsYGSFNh5dEeOliFY8czpmICP
 x/LevOQQ2jdVy+Tvmln8bEG2sF9Difin/FXnhGAEF3CuLjB09h8AyRD7+amN1Kyv67s=
X-Gm-Gg: AYBFou2g5oTA7jqglcbGSWp/hmWmMzcQTrVTz4o129gre7KDVdkfT7xryHK2ziJ1niJ
 unqGuRRfKM1DePW4tgQaIBBQe3wnjgT0ZPwu1JqCeXIgXkSOQ2+PrmrFG8dLxiuWyXSLhAQ4KNf
 Jma0riYWtEK5ou64xxAhJuA91FnnydYyIDraCh1q2ZuxqljD9HtEVoPV83Dahpk3HNFCLCe22Mo
 i6wdClMMZ6x7C2kx1plOPcenLOhrPDF6KqNzcpqvTVzkcdFuO+9y1YSJhWyU63bo/uqhhj0FRkz
 PJ2pMqtW+7C9k06gZI0Q4+ha1SRMyboTTY4XXzHGewTj6u8mvXVzwdwUaoqXMuwCGZmH/qi5v5L
 nRDbwL+vJnGXKykw8v7QszUdOz4xPXm4y1As1OOk367c+iWNm39Sn+LwUzymN3JnB82pYHiaPfO
 HB++TYmSIODmBJXueqBFwAUCPuDPNcJdebPbjlvojFODqsQdWRoTvwo+zLY2sILNs2wHAkHJbe3
 yzu7tc/O/nyIbHEdt6lvtauK+pooj8=
X-Received: by 2002:a05:7300:c5af:b0:34b:ab57:dd1b with SMTP id
 5a478bee46e88-34db6605d51mr6691097eec.15.1790963449409; 
 Fri, 02 Oct 2026 10:50:49 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:50:48 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Rolnik <mrolnik@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Helge Deller <deller@gmx.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 00/27] accel/tcg: share raise_excp across TCG targets
Date: Sat,  3 Oct 2026 01:50:08 +0800
Message-ID: <20261002175037.1747-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Many TCG targets copy the same two-line raise: set cs->exception_index and call
cpu_loop_exit_restore. They also copy DEF_HELPER_2(raise_exception, ...).
helper_raise_exception is a global C symbol, so a unified binary cannot keep
that name on more than one target.

This series adds two shared C exits and two shared TCG helpers, then converts
one target per commit. Joiners call gen_helper_raise_excp or
gen_helper_raise_excp_restore and drop the copied DEF. The shared helpers only
touch CPUState. Translate may store arch state (error_code, PC) first. A
callback that may pass a zero retaddr keeps the explicit cpu_loop_exit_restore
form. Guest trap numbers stay below 0x10000. TCG loop codes such as
EXCP_INTERRUPT start at 0x10000.

- Move helper_exit_atomic into cpu-exec-common.c with its DEF_HELPER, so the new
  helpers can sit beside it.
- Add cpu_raise_excp and cpu_raise_excp_restore next to cpu_loop_exit_restore.
  The first sets exception_index and exits without restoring guest state. The
  second restores from a nonzero retaddr, and skips restore when retaddr is 0.
- Add TCG raise_excp and raise_excp_restore beside those exits. raise_excp calls
  cpu_raise_excp. raise_excp_restore calls cpu_raise_excp_restore with GETPC().
  Each helper does one thing.
- Unify RX BRK and INT, then define RX and SH4 exception vectors and use them at
  the raise sites. Log the previously unnamed SH4 vectors. Join privilege and
  illegal on RX through raise_excp_restore, and BRK and INT through raise_excp.
  Join illegal, slot-illegal, and FPU-disable on SH4. Keep RX wait and SH4
  sleep, trapa, and exclusive.
- Drop HPPA helper_excp, then drop hppa_dynamic_excp. Convert the remaining
  joiners one arch per commit: m68k, or1k, microblaze, sparc, loongarch, s390x,
  xtensa, avr, arm exception_internal, mips, and ppc. Store error_code or PC in
  translate where needed, then call the shared helper. loongarch and the mips
  2-arg path use raise_excp_restore. C wrappers that only forward stay static
  inline.
- Reset Xtensa yield_needed in gen_yield before that conversion. Reuse the ppc
  error-aware NIP path before the ppc conversion. Call MIPS do_raise_exception
  directly from the FPU helpers before the MIPS conversion.
- Keep riscv and hexagon TCG raise_exception. riscv still decrements instret,
  and hexagon still logs, stores PC, and asserts. Their C exits call
  cpu_raise_excp_restore. Tricore raise_exception_sync, alpha excp, and i386
  raise_exception do not join.

v1: https://patchew.org/QEMU/20260918004225.827-1-luoyonggang@gmail.com/
v2: https://patchew.org/QEMU/20260928052051.251-1-luoyonggang@gmail.com/

Changes v2 -> v3:

- Replace cpu_loop_exit_excp with cpu_raise_excp and cpu_raise_excp_restore. The
  no-restore path has no retaddr argument. The restore path restores only when
  retaddr is nonzero.
- Split the HPPA conversion. Drop helper_excp, then drop hppa_dynamic_excp.
- Define RX and SH4 vectors in the commits that use them. Take Philippe's RX BRK
  and INT unification. Log the unnamed SH4 vectors in its own commit.
- Do not prefix riscv or hexagon TCG raise_exception. Keep their extra work in
  those helpers, and route the C exits through cpu_raise_excp_restore.
- Omit the alpha conversion. On microblaze, keep the MMU callback on
  cpu_loop_exit_restore when retaddr may be zero.

Changes v1 -> v2:

- Move helper_exit_atomic into cpu-exec-common.c. Split the restore flag into
  raise_excp and raise_excp_restore, and define both there.
- Drop the helper-gen nested-extern change.
- Shorten the cpu_loop_exit_excp comment. Drop the generic EXCP_INTERRUPT note
  on the RX and SH4 trap enums, and put those enums in their own commits.
- Split xtensa gen_yield and the ppc gen_exception_nip fold out of the
  conversion commits.
- Omit the i386 conversion, the rx, mips, and hexagon helper_wait renames, and
  the arm raise_exception rename.

Philippe Mathieu-Daudé (1):
  target/rx: Unify BRK and INT trap handling

Yonggang Luo (26):
  accel/tcg: move helper_exit_atomic next to cpu_loop_exit_atomic
  accel/tcg: add cpu_raise_excp and cpu_raise_excp_restore helpers
  accel/tcg: add raise_excp and raise_excp_restore generator helpers
  target/rx: Define exception vector constants
  target/sh4: Define exception vector constants
  target/hppa: remove helper_excp
  target/hppa: remove hppa_dynamic_excp
  target/rx: convert raises to raise_excp
  target/sh4: log all exception vector names
  target/sh4: convert raises to raise_excp
  target/s390x: convert exception to raise_excp
  target/m68k: convert raises to raise_excp
  target/or1k: convert exception to raise_excp
  target/microblaze: convert raise_exception to raise_excp
  target/sparc: convert raise_exception to raise_excp
  target/loongarch: convert raise_exception to raise_excp
  target/hexagon: reuse cpu_raise_excp_restore
  target/xtensa: reset yield state in the icount path
  target/xtensa: convert exception to raise_excp
  target/avr: convert debug/break/sleep to raise_excp
  target/arm: convert exception_internal to raise_excp
  target/riscv: use cpu_raise_excp_restore for exception exits
  target/mips: call do_raise_exception directly
  target/mips: use shared TCG exception helpers
  target/ppc: reuse the error-aware NIP exception path
  target/ppc: use shared helpers for translated exceptions

 accel/tcg/cpu-exec-common.c        | 35 +++++++++++++++
 accel/tcg/cpu-exec-common.h        |  4 ++
 accel/tcg/tcg-runtime.c            |  8 ----
 accel/tcg/tcg-runtime.h            |  2 -
 include/accel/tcg/cpu-loop.h       | 22 +++++++++
 include/exec/helper-gen-common.h   |  4 ++
 include/exec/helper-proto-common.h |  4 ++
 target/arm/tcg/helper-defs.h       |  1 -
 target/arm/tcg/m_helper.c          |  3 +-
 target/arm/tcg/op_helper.c         | 33 +++-----------
 target/arm/tcg/translate.c         |  2 +-
 target/avr/helper.c                | 24 ----------
 target/avr/helper.h                |  3 --
 target/avr/translate.c             |  4 +-
 target/hexagon/internal.h          | 10 ++++-
 target/hexagon/op_helper.c         |  5 +--
 target/hppa/cpu.h                  |  1 -
 target/hppa/fpu_helper.c           |  3 +-
 target/hppa/helper.h               |  2 -
 target/hppa/op_helper.c            | 18 +-------
 target/hppa/sys_helper.c           |  5 ++-
 target/hppa/translate.c            |  2 +-
 target/loongarch/internals.h       | 12 +++--
 target/loongarch/tcg/helper.h      |  2 -
 target/loongarch/tcg/op_helper.c   |  6 ---
 target/loongarch/tcg/tcg_cpu.c     | 10 ++---
 target/loongarch/tcg/translate.c   |  2 +-
 target/m68k/helper.c               | 12 +----
 target/m68k/helper.h               |  1 -
 target/m68k/op_helper.c            | 19 --------
 target/m68k/translate.c            |  2 +-
 target/microblaze/helper.h         |  2 -
 target/microblaze/op_helper.c      | 19 ++------
 target/microblaze/translate.c      |  2 +-
 target/mips/cpu.h                  |  2 +-
 target/mips/helper.h               |  4 --
 target/mips/tcg/exception.c        | 27 +----------
 target/mips/tcg/fpu_helper.c       |  6 +--
 target/mips/tcg/translate.c        |  9 ++--
 target/or1k/exception.c            | 31 -------------
 target/or1k/exception.h            |  7 ++-
 target/or1k/exception_helper.c     | 13 +-----
 target/or1k/helper.h               |  1 -
 target/or1k/meson.build            |  1 -
 target/or1k/translate.c            |  2 +-
 target/ppc/cpu.h                   |  5 +--
 target/ppc/helper.h                |  2 -
 target/ppc/internal.h              |  9 ++++
 target/ppc/misc_helper.c           |  1 +
 target/ppc/tcg-excp_helper.c       | 21 ---------
 target/ppc/timebase_helper.c       |  1 +
 target/ppc/translate.c             | 20 +++------
 target/riscv/tcg/op_helper.c       |  3 +-
 target/rx/cpu.h                    | 13 ++++++
 target/rx/helper.c                 | 21 ++++-----
 target/rx/helper.h                 |  5 ---
 target/rx/op_helper.c              | 44 +-----------------
 target/rx/translate.c              | 28 ++++++------
 target/s390x/helper.h              |  1 -
 target/s390x/tcg/mem_helper.c      |  2 +-
 target/s390x/tcg/misc_helper.c     | 10 -----
 target/s390x/tcg/translate.c       |  2 +-
 target/sh4/cpu.h                   | 21 +++++++++
 target/sh4/helper.c                | 72 +++++++++++++++++-------------
 target/sh4/helper.h                |  4 --
 target/sh4/op_helper.c             | 40 +++--------------
 target/sh4/translate.c             | 12 +++--
 target/sparc/helper.c              | 21 ++-------
 target/sparc/helper.h              |  2 -
 target/sparc/translate.c           |  6 +--
 target/xtensa/cpu.h                |  2 +-
 target/xtensa/exc_helper.c         | 17 ++-----
 target/xtensa/helper.h             |  1 -
 target/xtensa/translate.c          |  8 ++--
 target/xtensa/win_helper.c         | 13 +++---
 75 files changed, 300 insertions(+), 494 deletions(-)
 create mode 100644 accel/tcg/cpu-exec-common.h
 delete mode 100644 target/or1k/exception.c

-- 
2.52.0.windows.1


