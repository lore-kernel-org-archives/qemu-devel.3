Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A91AC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 19:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbOzn-0006SM-Hs; Fri, 24 Jan 2025 14:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tbOzm-0006R7-2c
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:05:34 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tbOzj-0006tj-St
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:05:33 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so4676302a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 11:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737745530; x=1738350330; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JFekHD2EvuCMT8dZzvPyg9+AkZ1/H7sjt0Lq8q0Anf8=;
 b=Bvjg3fzJgMDvZ1J6HzMrXoijNQtftmrZtghxivlXGcBFqEfCPi6BJk8sO5+uXC4uIT
 x2yhMr/sXCclmSG+3VdCFQrAdZBTogDE6kWGlxIZrgaRNedp5hvfThIErfk7EHi4Whyk
 8E/cnBrpXQBbQ4fvYykblvlsfv4pALUDW54JfWmD0ZL99C4dJswaIKpeVT+GJ+pX7gd0
 CCPpgzf142Y8m2lTeE2JF7knZ8OuKVtnF86xtHSiZkqVhtC/k/cCeyhqcO2z4rxChh35
 5THkBAACChIDVD3JQTQJVm2bkKRcpvfl/V6nuqkvvQU5sM1JHWB5H9u8/aci0kB4HtAq
 TZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737745530; x=1738350330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JFekHD2EvuCMT8dZzvPyg9+AkZ1/H7sjt0Lq8q0Anf8=;
 b=S3aCB0THlr/K9M3WHtZE8HzFlSC1oxvNJWrgtsa9S9HjhOFcdhSuirDpMEoxA34Tew
 LhHyMOYfn6Dni/OZ9n6YyDM2fvTl3pIUeGrV6GldtYIYd/rlSlphjcQsDzaXXdkrYCrh
 JV8JTi8SXIYdqKnqNbxqh8nlMBDFFj/H7yMXkDoji5rGbWOkQkXcoltfeEsWpOUCTRQY
 mIgeBy5qMVkeTHJFpb0Zs17QZ3NspXmoOvMdfbsthhdQ5DJ6Dlqmd4Hvz0aZahZi+OME
 dUG0PLY0wBjC7UGGQz4aWsu4vhIBynKfYNcae8CPP1m/3QQzFqVHl9LCxDAl/LdaT4+m
 tmLQ==
X-Gm-Message-State: AOJu0Yz5Dpy3w29q3R6Y6ke7yiTFOt6b9klviRfba7WnA/HIKrtvAt/9
 aE2/ozSCKUE+OUSy1sGy6KzooSWGb39aqG+Ag4mr2C/MqJXGWMWKaIeVd5mU3q4Q5YqOT0wMFS7
 nkAz0S3daGcCL5Qig5x5gnGrHLRo=
X-Gm-Gg: ASbGncvsrSDbwlDYxZIEkTSRkw5EjyceYhgBtyelajxgxoT/mVJ/ufiOEh3S3FCHTVr
 oc/zJUXjrzHk9+9Eopr5t/R/i/VKE6E4InXWzJUsOk+yr+IAdrteuAL4W1irX
X-Google-Smtp-Source: AGHT+IE/ZFfWTHM16JF/GDbbRs+OsH4MyLL+w8ONpNmgPR4dYn+h0xAsuQFbgj9U8kxB+Fy74bb9IthbRYSNpICnOKo=
X-Received: by 2002:a05:6402:1d52:b0:5dc:1289:7f1c with SMTP id
 4fb4d7f45d1cf-5dc1289800bmr5862680a12.29.1737745529531; Fri, 24 Jan 2025
 11:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20250124094442.13207-1-pbonzini@redhat.com>
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 24 Jan 2025 14:05:17 -0500
X-Gm-Features: AWEUYZnvEbMiByAYeIW-jdRuaBlk7OpwisWbYvAnieGtOARQEFqPj_bJYUL9-DY
Message-ID: <CAJSP0QXMO8WX1iPKqqfTK7LyDX1kWmgaSbDBVfE6V8go7Vr5WA@mail.gmail.com>
Subject: Re: [PULL 00/48] i386, rust changes for 2024-01-24
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
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

On Fri, 24 Jan 2025 at 04:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit d6430c17d7113d3c38480dc34e59d00b0504e2f7:
>
>   Merge tag 'pull-riscv-to-apply-20250119-1' of https://github.com/alistair23/qemu into staging (2025-01-19 08:55:46 -0500)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 9feb68638e504c91b59e745b94423e8536abfd03:
>
>   rust: qemu-api: add sub-subclass to the integration tests (2025-01-23 19:07:39 +0100)
>
> ----------------------------------------------------------------
> * target/i386: optimize string instructions
> * target/i386: new Sierra Forest and Clearwater Forest models
> * rust: type-safe vmstate implementation
> * rust: use interior mutability for PL011
> * rust: clean ups
> * memtxattrs: remove usage of bitfields from MEMTXATTRS_UNSPECIFIED

Hi Paolo,
Please take a look at this failure and send a v2 pull request, if necessary:

thread '<unnamed>' panicked at 'already borrowed',
rust/qemu-api/libqemu_api.rlib.p/structured/cell.rs:450:5
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
fatal runtime error: failed to initiate panic, error 5

https://gitlab.com/qemu-project/qemu/-/jobs/8946857796

Thanks,
Stefan

>
> ----------------------------------------------------------------
> Paolo Bonzini (39):
>       rust: pl011: fix repr(C) for PL011Class
>       target/i386: inline gen_jcc into sole caller
>       target/i386: remove trailing 1 from gen_{j, cmov, set}cc1
>       target/i386: unify REP and REPZ/REPNZ generation
>       target/i386: unify choice between single and repeated string instructions
>       target/i386: reorganize ops emitted by do_gen_rep, drop repz_opt
>       target/i386: tcg: move gen_set/reset_* earlier in the file
>       target/i386: fix RF handling for string instructions
>       target/i386: make cc_op handling more explicit for repeated string instructions.
>       target/i386: do not use gen_op_jz_ecx for repeated string operations
>       target/i386: optimize CX handling in repeated string operations
>       target/i386: execute multiple REP/REPZ iterations without leaving TB
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
>       rust: pl011: hide unnecessarily "pub" items from outside pl011::device
>       rust: pl011: extract conversion to RegisterOffset
>       rust: pl011: extract CharBackend receive logic into a separate function
>       rust: pl011: pull interrupt updates out of read/write ops
>       rust: pl011: extract PL011Registers
>       rust: pl011: wrap registers with BqlRefCell
>       rust: pl011: remove duplicate definitions
>       rust: pl011: pull device-specific code out of MemoryRegionOps callbacks
>       rust: pl011: drop use of ControlFlow
>       rust: qdev: make reset take a shared reference
>       rust/zeroable: Implement Zeroable with const_zero macro
>       rust: qemu-api: add sub-subclass to the integration tests
>
> Tao Su (4):
>       target/i386: Introduce SierraForest-v2 model
>       target/i386: Export BHI_NO bit to guests
>       target/i386: Add new CPU model ClearwaterForest
>       docs: Add GNR, SRF and CWF CPU models
>
> Zhao Liu (5):
>       stub: Fix build failure with --enable-user --disable-system --enable-tools
>       rust/qdev: Make REALIZE safe
>       rust/pl011: Avoid bindings::*
>       memattrs: Convert unspecified member to bool
>       memattrs: Check the size of MemTxAttrs
>
>  docs/system/cpu-models-x86.rst.inc     |  50 ++-
>  include/exec/memattrs.h                |  21 +-
>  target/i386/cpu.h                      |  33 +-
>  target/i386/cpu.c                      | 156 +++++++-
>  target/i386/tcg/translate.c            | 363 ++++++++++-------
>  target/i386/tcg/emit.c.inc             |  55 +--
>  rust/hw/char/pl011/src/device.rs       | 489 +++++++++++++----------
>  rust/hw/char/pl011/src/device_class.rs |  73 ++--
>  rust/hw/char/pl011/src/lib.rs          |  67 ++--
>  rust/hw/char/pl011/src/memory_ops.rs   |  25 +-
>  rust/qemu-api/src/prelude.rs           |   2 +
>  rust/qemu-api/src/qdev.rs              |  16 +-
>  rust/qemu-api/src/qom.rs               |  21 +-
>  rust/qemu-api/src/vmstate.rs           | 700 +++++++++++++++++++++------------
>  rust/qemu-api/src/zeroable.rs          | 118 +++---
>  rust/qemu-api/tests/tests.rs           |  56 ++-
>  stubs/meson.build                      |   4 +-
>  17 files changed, 1403 insertions(+), 846 deletions(-)
> --
> 2.48.1
>
>

