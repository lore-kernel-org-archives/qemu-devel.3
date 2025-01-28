Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAB8C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmRL-0006kO-C4; Tue, 28 Jan 2025 09:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tcmRJ-0006kG-Mp
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:19:41 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tcmRH-0001sN-FZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:19:41 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so1100025466b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738073977; x=1738678777; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsTmgPpsSjepEzdtram4S36T+g0K5HUFC1C21Hh7yCw=;
 b=mtTAu/DKjBQ7303sfmzLalgQhMa0Kl9o6j6kQKGcnY1xOOIl6h6BM11i6jOcJL5Dm7
 uRd1u+nsaYWo7C2Xd6av9MgpYbPy/Dip/8+YL5gj99eXFve2OfMWvFVTI9tSmCy06zZJ
 X59O6tJS6EG7vnP/d+CGe02xtVd70hiIdxMTNVp7vHGC2xFV8PDBO2HNDJ6DiZStLRs/
 vE2iPGn1KAYubUCR4CZAkLLj9Rpjv+vv7A3WLLWKISXlD8Rxm/ACWXRGUIO3EOQa9NwJ
 aLBLxxNMq2qbS4fveJJ8bQ1kz+AhfUgFNyx8ch3nBUQzxpU5yJtTgOeD7YFc5Aug1MRg
 mqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738073977; x=1738678777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vsTmgPpsSjepEzdtram4S36T+g0K5HUFC1C21Hh7yCw=;
 b=JLF9HYEHMR1ebdW2Rg44mQG47PRD/v838uxnpI5nHxf2Lkzscqu5ytTMMJy+qE3pRe
 AVX8FhjEvtZj3FT13cG1qWaoGE8uVMskCJ/XqVWs2pRAKPOfW2MOKIk5PHoFMJk0bkQm
 IkHWHHS50K3tSHffK8eIdl9YSnsaVtwit5j2aZ5N8g598zUzsfWfI/gB+xu0/SAaO26S
 He14491tFggsS7j+YnaTFW9iF5earVefu1hN3yQxbp20hIz4SQ5QUDeAO8eXXWJj0pT0
 TQqQ/9/JGyS0rJ2cnty0epu1/GGgg9LF9lDPa4G7c2q72UMPY8tpbxWEVNxkgVuHj0Rj
 BQKw==
X-Gm-Message-State: AOJu0YyYJqLT+WmR6hRiPlG51qLvI2hT/6XZcfWTWRy+lY9sfbg7xz8/
 4KyxxSss1BcTDkNlm9iQeWUdyDQqghjtJ22v/u7EuPMZezMJeQaiDJw1ZVmLLOcqE3syNzSFNJl
 mhlMc4L2/Hze7b+gr+oFgBbtTyTRv0jc3
X-Gm-Gg: ASbGncvlFmk/w2oIXpqtrNdqR/r5mtXbeyrgWG3XG4fcZpEwwN8rcrMgxkmh8RJUlFX
 nPy49iGGqUQeYubrLv5GYtF+LMzn/jg9gFB4OmA9T5AEx9y8cQO/A8hno4lbpO9Lp0D0+lrM=
X-Google-Smtp-Source: AGHT+IEEmNHNx9G/00T78u3dl9z6bPn2fx1Q89wbMooHRnwnfEnnJQkasuhaSeVCc4eBd35Bf1p8x/KxyKdNv2Dv4Ag=
X-Received: by 2002:a17:907:6e8d:b0:aa6:7cf3:c6ef with SMTP id
 a640c23a62f3a-ab38b10d016mr4286173566b.15.1738073976473; Tue, 28 Jan 2025
 06:19:36 -0800 (PST)
MIME-Version: 1.0
References: <20250128112439.1225171-1-pbonzini@redhat.com>
In-Reply-To: <20250128112439.1225171-1-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 28 Jan 2025 09:19:24 -0500
X-Gm-Features: AWEUYZnuLuhbtGb8F-2UaxZRN2s9J8fD01u5FivPl867-GmDc7Dg1KcWvgMjm4c
Message-ID: <CAJSP0QWJ=qkA2Bzih7nGq5K=YrJRqUOt85RAGL=mj3MEjAW6ug@mail.gmail.com>
Subject: Re: [PULL 00/48] i386, rust changes for 2024-01-24
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 28, 2025 at 6:25=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> The following changes since commit d6430c17d7113d3c38480dc34e59d00b0504e2=
f7:
>
>   Merge tag 'pull-riscv-to-apply-20250119-1' of https://github.com/alista=
ir23/qemu into staging (2025-01-19 08:55:46 -0500)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 021d8e747907d4a2226557bf9885d4c0fa6abd8b:
>
>   rust: qemu-api: add sub-subclass to the integration tests (2025-01-28 1=
2:22:54 +0100)

CI is hitting the following failure (see default.log):

thread '<unnamed>' panicked at 'already borrowed',
rust/qemu-api/libqemu_api.rlib.p/structured/cell.rs:450:5
note: run with `RUST_BACKTRACE=3D1` environment variable to display a backt=
race
fatal runtime error: failed to initiate panic, error 5

https://gitlab.com/qemu-project/qemu/-/jobs/8972076251/artifacts/browse/bui=
ld/tests/functional/arm/test_arm_tuxrun.TuxRunArmTest.test_armv7be/

Do you want to include a patch that sets RUST_BACKTRACE=3D1 in the test
environment so the backtrace is captured in the logs?

Thanks,
Stefan

>
> ----------------------------------------------------------------
> * target/i386: optimize string instructions
> * target/i386: new Sierra Forest and Clearwater Forest models
> * rust: type-safe vmstate implementation
> * rust: use interior mutability for PL011
> * rust: clean ups
> * memtxattrs: remove usage of bitfields from MEMTXATTRS_UNSPECIFIED
>
> ----------------------------------------------------------------
> Paolo Bonzini (37):
>       rust: pl011: fix repr(C) for PL011Class
>       target/i386: inline gen_jcc into sole caller
>       target/i386: remove trailing 1 from gen_{j, cmov, set}cc1
>       target/i386: unify REP and REPZ/REPNZ generation
>       target/i386: unify choice between single and repeated string instru=
ctions
>       target/i386: reorganize ops emitted by do_gen_rep, drop repz_opt
>       target/i386: tcg: move gen_set/reset_* earlier in the file
>       target/i386: fix RF handling for string instructions
>       target/i386: make cc_op handling more explicit for repeated string =
instructions.
>       target/i386: do not use gen_op_jz_ecx for repeated string operation=
s
>       target/i386: optimize CX handling in repeated string operations
>       target/i386: execute multiple REP/REPZ iterations without leaving T=
B
>       target/i386: pull computation of string update value out of loop
>       target/i386: extract common bits of gen_repz/gen_repz_nz
>       target/i386: avoid using s->tmp0 for add to implicit registers
>       rust: vmstate: add new type safe implementation
>       rust: vmstate: implement VMState for non-leaf types
>       rust: vmstate: add varray support to vmstate_of!
>       rust: vmstate: implement Zeroable for VMStateField
>       rust: vmstate: implement VMState for scalar types
>       rust: vmstate: add public utility macros to implement VMState
>       rust: qemu_api: add vmstate_struct
>       rust: pl011: switch vmstate to new-style macros
>       rust: vmstate: remove translation of C vmstate macros
>       rust: vmstate: make order of parameters consistent in vmstate_clock
>       rust: prefer NonNull::new to assertions
>       rust: pl011: remove unnecessary "extern crate"
>       rust: pl011: hide unnecessarily "pub" items from outside pl011::dev=
ice
>       rust: pl011: extract conversion to RegisterOffset
>       rust: pl011: extract CharBackend receive logic into a separate func=
tion
>       rust: pl011: pull interrupt updates out of read/write ops
>       rust: pl011: extract PL011Registers
>       rust: pl011: wrap registers with BqlRefCell
>       rust: pl011: remove duplicate definitions
>       rust: pl011: pull device-specific code out of MemoryRegionOps callb=
acks
>       rust: pl011: drop use of ControlFlow
>       rust: qdev: make reset take a shared reference
>
> Tao Su (4):
>       target/i386: Introduce SierraForest-v2 model
>       target/i386: Export BHI_NO bit to guests
>       target/i386: Add new CPU model ClearwaterForest
>       docs: Add GNR, SRF and CWF CPU models
>
> Zhao Liu (7):
>       stub: Fix build failure with --enable-user --disable-system --enabl=
e-tools
>       rust/qdev: Make REALIZE safe
>       rust/pl011: Avoid bindings::*
>       memattrs: Convert unspecified member to bool
>       memattrs: Check the size of MemTxAttrs
>       rust/zeroable: Implement Zeroable with const_zero macro
>       rust: qemu-api: add sub-subclass to the integration tests
>
>  docs/system/cpu-models-x86.rst.inc     |  50 ++-
>  include/exec/memattrs.h                |  21 +-
>  target/i386/cpu.h                      |  33 +-
>  target/i386/cpu.c                      | 156 +++++++-
>  target/i386/tcg/translate.c            | 363 ++++++++++-------
>  target/i386/tcg/emit.c.inc             |  55 +--
>  rust/hw/char/pl011/src/device.rs       | 509 +++++++++++++-----------
>  rust/hw/char/pl011/src/device_class.rs |  73 ++--
>  rust/hw/char/pl011/src/lib.rs          |  69 ++--
>  rust/hw/char/pl011/src/memory_ops.rs   |  25 +-
>  rust/qemu-api/src/prelude.rs           |   2 +
>  rust/qemu-api/src/qdev.rs              |  16 +-
>  rust/qemu-api/src/qom.rs               |  21 +-
>  rust/qemu-api/src/vmstate.rs           | 700 +++++++++++++++++++++------=
------
>  rust/qemu-api/src/zeroable.rs          | 118 +++---
>  rust/qemu-api/tests/tests.rs           |  56 ++-
>  stubs/meson.build                      |   4 +-
>  17 files changed, 1416 insertions(+), 855 deletions(-)
> --
> 2.48.1
>
>

