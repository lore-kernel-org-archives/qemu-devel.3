Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2DBC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 11:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcjiE-0005nZ-0n; Tue, 28 Jan 2025 06:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tcji9-0005n3-Br
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:24:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tcji4-0006eJ-GO
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738063486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sXun+BuNSmS6vLqheuJ1peCxPRnYxa0W2XVrNFXr0dY=;
 b=G04h7aHiFFzp4gEWa5POuPGKE400A06aPd7zlwKSZJcoVU+v2e0zG0eNOFdJVB8gVwxOR/
 UiW4RgpCiWpgoQTpPyIzTDuTE4QXFM9yp9SccwxuozZWXtGXmwLiKSbCyj9uItTjcy++KR
 1l0oBbgLDYjRxIgeh48WETiB4RLSmwI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-YTKmpQC6NrOYHEl9qIXKdQ-1; Tue, 28 Jan 2025 06:24:43 -0500
X-MC-Unique: YTKmpQC6NrOYHEl9qIXKdQ-1
X-Mimecast-MFC-AGG-ID: YTKmpQC6NrOYHEl9qIXKdQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436379713baso25748085e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 03:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738063481; x=1738668281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sXun+BuNSmS6vLqheuJ1peCxPRnYxa0W2XVrNFXr0dY=;
 b=Er05YT7Dft8gY5g1hOOnOLY5NFj6Zm9ZA3v3Ch5V3mcy5Z2w/U4PquAp8v3bYtO7Mb
 yhUgnariT+FamzCzJwNAjSF7hjICEuf8nQIetkf2YHb4HF15hyU1K47yeoPm7HBckypd
 CgLrj7Nm+gTbYalUZvf/z/+POTTdVItWpbCtF9bOwzfOjD2iU+pkglXKxifkBDmB32wz
 QYadhOejY67/Xrl6mj7uK057pvXMWZHCxajfz83YNZ4ULh6ZfY14rcdSTXqQNZoli9ym
 BSw6FQnXsLhSrSTnYCnzaXgDcYCGxos9+GrohFWPrXKGsIA75812Hpue/jwrWH5eDsIZ
 +pMQ==
X-Gm-Message-State: AOJu0YzKLjVjEoU9QWYthakRt5MhnfyIEUpihYu0qNrYzSWudR6K/qRR
 ZRhl3qygyvndcD0VYxExZ+i5ayKSL41T3gx4es7kU1yTXh0gqZqEiAqrWDze+V2TYCzEqmFiloZ
 /Faqf+pHHJxS76L0yTHpKAyxqULUO6nmJsENEaglgiRW4peMhtrZ0s0pbnllvSYWB2K1j12aI5h
 g9WaS5kgiPFdg+4fw9wStiwMhwzr++DdfnPPwaOoQ=
X-Gm-Gg: ASbGnct+yh0CVCtaSvFiD+NVu2OS2Q/ga8auEAlN/Gzkfda7xAB89W5s5nAvMI1489i
 45UK+KZr+TuItAO9OfJsYvhsew9C46dGAQjzRZac0yITXYwR3vjxYv6RAFAj6uBuUBAVOIqh6lQ
 0lnw1WwiOw6IAzSh/nHWO1eeJ3OTWEibivzAHupSFkAEi+bFwyc6kzqgL8Ye5gZ2d9BJ2fkcCFe
 +c9azXk8s5KIhgDXVu4ynIGYsMtuVEBfCriZcwT0cMjwIXkaY+aIcPNw5OVUYc2ArtIFyowYaCM
 5EfRkTH+
X-Received: by 2002:a05:600c:34d0:b0:434:fbda:1f44 with SMTP id
 5b1f17b1804b1-4389142e805mr376751555e9.19.1738063481601; 
 Tue, 28 Jan 2025 03:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW4kAPIjBU9W0JJKT/sZDUlo5lnTRx9fas8Bo69zO7VVzG00plxyq9ca6q9vvfyM9Mwv7epQ==
X-Received: by 2002:a05:600c:34d0:b0:434:fbda:1f44 with SMTP id
 5b1f17b1804b1-4389142e805mr376751295e9.19.1738063481100; 
 Tue, 28 Jan 2025 03:24:41 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48a94asm166013425e9.23.2025.01.28.03.24.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 03:24:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/48] i386, rust changes for 2024-01-24
Date: Tue, 28 Jan 2025 12:24:38 +0100
Message-ID: <20250128112439.1225171-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit d6430c17d7113d3c38480dc34e59d00b0504e2f7:

  Merge tag 'pull-riscv-to-apply-20250119-1' of https://github.com/alistair23/qemu into staging (2025-01-19 08:55:46 -0500)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 021d8e747907d4a2226557bf9885d4c0fa6abd8b:

  rust: qemu-api: add sub-subclass to the integration tests (2025-01-28 12:22:54 +0100)

----------------------------------------------------------------
* target/i386: optimize string instructions
* target/i386: new Sierra Forest and Clearwater Forest models
* rust: type-safe vmstate implementation
* rust: use interior mutability for PL011
* rust: clean ups
* memtxattrs: remove usage of bitfields from MEMTXATTRS_UNSPECIFIED

----------------------------------------------------------------
Paolo Bonzini (37):
      rust: pl011: fix repr(C) for PL011Class
      target/i386: inline gen_jcc into sole caller
      target/i386: remove trailing 1 from gen_{j, cmov, set}cc1
      target/i386: unify REP and REPZ/REPNZ generation
      target/i386: unify choice between single and repeated string instructions
      target/i386: reorganize ops emitted by do_gen_rep, drop repz_opt
      target/i386: tcg: move gen_set/reset_* earlier in the file
      target/i386: fix RF handling for string instructions
      target/i386: make cc_op handling more explicit for repeated string instructions.
      target/i386: do not use gen_op_jz_ecx for repeated string operations
      target/i386: optimize CX handling in repeated string operations
      target/i386: execute multiple REP/REPZ iterations without leaving TB
      target/i386: pull computation of string update value out of loop
      target/i386: extract common bits of gen_repz/gen_repz_nz
      target/i386: avoid using s->tmp0 for add to implicit registers
      rust: vmstate: add new type safe implementation
      rust: vmstate: implement VMState for non-leaf types
      rust: vmstate: add varray support to vmstate_of!
      rust: vmstate: implement Zeroable for VMStateField
      rust: vmstate: implement VMState for scalar types
      rust: vmstate: add public utility macros to implement VMState
      rust: qemu_api: add vmstate_struct
      rust: pl011: switch vmstate to new-style macros
      rust: vmstate: remove translation of C vmstate macros
      rust: vmstate: make order of parameters consistent in vmstate_clock
      rust: prefer NonNull::new to assertions
      rust: pl011: remove unnecessary "extern crate"
      rust: pl011: hide unnecessarily "pub" items from outside pl011::device
      rust: pl011: extract conversion to RegisterOffset
      rust: pl011: extract CharBackend receive logic into a separate function
      rust: pl011: pull interrupt updates out of read/write ops
      rust: pl011: extract PL011Registers
      rust: pl011: wrap registers with BqlRefCell
      rust: pl011: remove duplicate definitions
      rust: pl011: pull device-specific code out of MemoryRegionOps callbacks
      rust: pl011: drop use of ControlFlow
      rust: qdev: make reset take a shared reference

Tao Su (4):
      target/i386: Introduce SierraForest-v2 model
      target/i386: Export BHI_NO bit to guests
      target/i386: Add new CPU model ClearwaterForest
      docs: Add GNR, SRF and CWF CPU models

Zhao Liu (7):
      stub: Fix build failure with --enable-user --disable-system --enable-tools
      rust/qdev: Make REALIZE safe
      rust/pl011: Avoid bindings::*
      memattrs: Convert unspecified member to bool
      memattrs: Check the size of MemTxAttrs
      rust/zeroable: Implement Zeroable with const_zero macro
      rust: qemu-api: add sub-subclass to the integration tests

 docs/system/cpu-models-x86.rst.inc     |  50 ++-
 include/exec/memattrs.h                |  21 +-
 target/i386/cpu.h                      |  33 +-
 target/i386/cpu.c                      | 156 +++++++-
 target/i386/tcg/translate.c            | 363 ++++++++++-------
 target/i386/tcg/emit.c.inc             |  55 +--
 rust/hw/char/pl011/src/device.rs       | 509 +++++++++++++-----------
 rust/hw/char/pl011/src/device_class.rs |  73 ++--
 rust/hw/char/pl011/src/lib.rs          |  69 ++--
 rust/hw/char/pl011/src/memory_ops.rs   |  25 +-
 rust/qemu-api/src/prelude.rs           |   2 +
 rust/qemu-api/src/qdev.rs              |  16 +-
 rust/qemu-api/src/qom.rs               |  21 +-
 rust/qemu-api/src/vmstate.rs           | 700 +++++++++++++++++++++------------
 rust/qemu-api/src/zeroable.rs          | 118 +++---
 rust/qemu-api/tests/tests.rs           |  56 ++-
 stubs/meson.build                      |   4 +-
 17 files changed, 1416 insertions(+), 855 deletions(-)
-- 
2.48.1


