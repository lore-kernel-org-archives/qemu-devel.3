Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8C9C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 11:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td6Ei-0000cO-Jp; Wed, 29 Jan 2025 06:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td6Ef-0000c5-G8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 06:27:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td6Ec-0005gF-8Y
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 06:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738150069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RFGKx7fNwMx3/m9xdG5XVmiMSfV0enmTqZXUYtCbWs0=;
 b=MAoRymPCe3NKbegdSfdx7q1xpzt0uszCQOksHzSAb91MkvG97xIDmKObjuwH/05pv/uJvy
 8M4Bf5Vaolh1pyRQGlbvo5YDKehC7ji7LNn6whQZ3yynKWxpwlTpU5jMbWMuosxAsqbBgi
 WJCDuYjMyfVZoQb//lbjrqrWsm4Q3ZU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-u2pTqat1NP-dGhEz74t9xg-1; Wed, 29 Jan 2025 06:27:47 -0500
X-MC-Unique: u2pTqat1NP-dGhEz74t9xg-1
X-Mimecast-MFC-AGG-ID: u2pTqat1NP-dGhEz74t9xg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436225d4389so2889055e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 03:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738150066; x=1738754866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RFGKx7fNwMx3/m9xdG5XVmiMSfV0enmTqZXUYtCbWs0=;
 b=Yj2ZXacncCdX3rP0UlMlnafIkS5bxeKTFffh+j8mX1WX8c6fmWdirDwQUMacQTrER0
 plj9FBWY1hO/9PB8J2B1ijzARK8jk2dKwzqQ6JDk/6W+HNSQc791hS1M0aUbL7dTYbJe
 Bpd+Q6hd3b1HoHjcZHrztkpYvmIRZFBaUQj/T+Fx8+h3F49hpX/Ic8EQu4Bj/lJla/PT
 7DPzyR8XFUlaYUHzTS1kuQTehmcjAsrdEDUijrp2A4fDBPTU9iQ9Cuwdyk4XnXk9tBqo
 KL7bphi5zeekNNZ3lVAYtOuM4v9O/IE4bbkLSyn5LsWdm2S3zZoPDMdokRL0ap7hCCim
 aoqg==
X-Gm-Message-State: AOJu0YwS+GWpRUF4qGvbtz7B7+NAPTYvG9egN+3OOOh7vJx7G0/kJ6uy
 Wzi0JDIkJZwPGwt76V4qNJLCGJRZJhbiJa32lQNFOGyCyVTA9bMLHr14+Q228Y6irlCpQmDJEhG
 DZo6pRE1Gsc35eV14zQeek775GL9vb8PoYETjyqERPjVNtjyoTjqy4FcNgmn1ShQCuAP19ler2y
 7pbDvVDOdSfDYvDyjqPzqlVvFyDtflYWQlzIii1hA=
X-Gm-Gg: ASbGncvC7EL1B2nsUOm9j6zKVZTe4OgB7nD7dFMqTd89BMeQkR+o3Oiy8X2YUcKwR6b
 KxT/v1kKyLRzUWUmhTowg4nsdmPTX4AmnfatjQFj7MVmcONlmm8H9Bejcsmzm/k2rKOjaYDKDo+
 5r4tqtdVMxIqBsnXJ3xvalt6vfP8i5CwJ+HueYWf6fmOb+TIaN8BEYuLMu+aDt+VEk0GjYEdqVp
 mXEvy1UWEnlA7Xa+hcdpIWntjEfFLJx9x9afvQ82GviutFM0F0FbtHLm6m7yF8MJa4Tqzb2DWC0
 R2k81A==
X-Received: by 2002:a05:600c:458f:b0:434:fa73:a906 with SMTP id
 5b1f17b1804b1-438dbe8dc87mr23606725e9.4.1738150065871; 
 Wed, 29 Jan 2025 03:27:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1ho/H/0dSll2Hu7tIq8TI4vtbJpfJMREW5Rb458TqybDjNo4nBcTRnMsqUX8n6Ik/ILeSng==
X-Received: by 2002:a05:600c:458f:b0:434:fa73:a906 with SMTP id
 5b1f17b1804b1-438dbe8dc87mr23606515e9.4.1738150065349; 
 Wed, 29 Jan 2025 03:27:45 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc11c40sm20693855e9.1.2025.01.29.03.27.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 03:27:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/49] i386, Rust changes for 2025-01-24
Date: Wed, 29 Jan 2025 12:27:41 +0100
Message-ID: <20250129112743.1348764-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

for you to fetch changes up to 3b36ee720288ba17962a17b305243ea34100e1f3:

  gitlab-ci: include full Rust backtraces in test runs (2025-01-29 09:37:50 +0100)

----------------------------------------------------------------
* target/i386: optimize string instructions
* target/i386: new Sierra Forest and Clearwater Forest models
* rust: type-safe vmstate implementation
* rust: use interior mutability for PL011
* rust: clean ups
* memtxattrs: remove usage of bitfields from MEMTXATTRS_UNSPECIFIED
* gitlab-ci: enable Rust backtraces

----------------------------------------------------------------
v2->v3: drop PL011Registers borrow before calling PL011State::update()
        include full Rust backtraces in test runs

Paolo Bonzini (38):
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
      gitlab-ci: include full Rust backtraces in test runs

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
 .gitlab-ci.d/buildtest-template.yml    |   1 +
 rust/hw/char/pl011/src/device.rs       | 515 +++++++++++++-----------
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
 18 files changed, 1423 insertions(+), 855 deletions(-)
-- 
2.48.1


