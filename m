Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30B3C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFE-0006HP-Jp; Fri, 24 Jan 2025 04:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFC-0006F8-Tm
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:44:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGF8-0003dZ-K5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LMbthOyayBn3XGkD2O0QW0vI87UoOUTJPuUpIWH4a00=;
 b=P6rubBJd5ce6f1FisFatRGQpR9PCWXLkMXwLFS5uHiVrnlDwPml0Ln8D4llxIhB7LhXQG0
 aMzSz0G3dp2JmN/XayeG/rEG1k/nmZBKs9htN0R+/eMN9S1tRnCTeGRQM0/7d6ifrpPk0k
 M3dif0kMS/TPBN7m+VB3Lbx/GyjYyHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Bb_YWTbRNr6FXDHaL0fJNg-1; Fri, 24 Jan 2025 04:44:46 -0500
X-MC-Unique: Bb_YWTbRNr6FXDHaL0fJNg-1
X-Mimecast-MFC-AGG-ID: Bb_YWTbRNr6FXDHaL0fJNg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so13347045e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711885; x=1738316685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LMbthOyayBn3XGkD2O0QW0vI87UoOUTJPuUpIWH4a00=;
 b=INHtoRLSpqcyGmhgnwkVuRRJP98ARWXIC8f781d8tw2T+MuIUP9O6ojaHrZkUBBn3t
 y1+mUXRxjj7AImyDyiPYULaqhkEjOzCJjgfrgXzcyeUIO2VPRI1I57v1E5CC+HXrIXbq
 PXTpbnsFrF9ciuba/nGFRPXwIY0Z/FdOvGRykeXYziIthuhecDxhmRsVC1DvgziBlxTX
 tFtzXrQjfuRuIS1eBDom44phdwKd73YEJH/gu39QWfhKhPYg3FMvZ+irkUBsOh5QQBYJ
 /ijLgabvJdl+0ynnWzXlyvzr7pb2cHTv66zEdKcBzZC5JSogA1jlLrl1yYsslnCZKQ4P
 VOsw==
X-Gm-Message-State: AOJu0YxpWElpOthNtQ1+T/NggAumOm9deVQuwvj5VY5Izpn6WnP43Zsw
 jM3pYU+Jx6GASdlKYPIsuveQqPCIEv7xjO7GdxR75XYpqNr5tA/KpoCAuw+C4GioTdL6Wa4/04r
 TIssque89Ax0QBES3NuZVxfkO2qiLFl4na74KJ88CxwoCs+Q35ujuWuDNkw+bEs/DkyCByoNylC
 5fPFgE/itFANyZGE+X+ADN5jaHzeptF9jrd0XVurc=
X-Gm-Gg: ASbGncuCQH/Up6/T02pgiiYmWErbOByeoXHztzlWcb5n8w6y7KWJYzFGBLDUr2WK3m1
 wfYH5KIg3aW881wKo/LL98z2hep0U82AHOWuqBsMvalqwP1HBUYM7/TP5+bhYPWUJff2Ej5GSiU
 nVQIJDFaQZO1mQeuNHfV21cAk8vFwYE3XKkb1V4dA3K6WNlXhyA4xLvMnFWv6Y+NhTJW379Pd9Z
 vUjltIf1bsmSs1CA8iQ7i6J7pReESZ+jHrdeNxxz6Dt+HpRUmm8fAQAAULgBvH1bHGFIj/d1A==
X-Received: by 2002:a05:600c:5027:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-43891430ed1mr267536565e9.29.1737711884898; 
 Fri, 24 Jan 2025 01:44:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzHDlwhXx/wkak/IGLEBcnia0UFMfTNufavXwJa5l4Do3eZa/wXcEvj6Ytz2hFmkzWSEfQRQ==
X-Received: by 2002:a05:600c:5027:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-43891430ed1mr267536195e9.29.1737711884271; 
 Fri, 24 Jan 2025 01:44:44 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd57325csm20112735e9.34.2025.01.24.01.44.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:44:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/48] i386, rust changes for 2024-01-24
Date: Fri, 24 Jan 2025 10:43:54 +0100
Message-ID: <20250124094442.13207-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

for you to fetch changes up to 9feb68638e504c91b59e745b94423e8536abfd03:

  rust: qemu-api: add sub-subclass to the integration tests (2025-01-23 19:07:39 +0100)

----------------------------------------------------------------
* target/i386: optimize string instructions
* target/i386: new Sierra Forest and Clearwater Forest models
* rust: type-safe vmstate implementation
* rust: use interior mutability for PL011
* rust: clean ups
* memtxattrs: remove usage of bitfields from MEMTXATTRS_UNSPECIFIED

----------------------------------------------------------------
Paolo Bonzini (39):
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
      rust/zeroable: Implement Zeroable with const_zero macro
      rust: qemu-api: add sub-subclass to the integration tests

Tao Su (4):
      target/i386: Introduce SierraForest-v2 model
      target/i386: Export BHI_NO bit to guests
      target/i386: Add new CPU model ClearwaterForest
      docs: Add GNR, SRF and CWF CPU models

Zhao Liu (5):
      stub: Fix build failure with --enable-user --disable-system --enable-tools
      rust/qdev: Make REALIZE safe
      rust/pl011: Avoid bindings::*
      memattrs: Convert unspecified member to bool
      memattrs: Check the size of MemTxAttrs

 docs/system/cpu-models-x86.rst.inc     |  50 ++-
 include/exec/memattrs.h                |  21 +-
 target/i386/cpu.h                      |  33 +-
 target/i386/cpu.c                      | 156 +++++++-
 target/i386/tcg/translate.c            | 363 ++++++++++-------
 target/i386/tcg/emit.c.inc             |  55 +--
 rust/hw/char/pl011/src/device.rs       | 489 +++++++++++++----------
 rust/hw/char/pl011/src/device_class.rs |  73 ++--
 rust/hw/char/pl011/src/lib.rs          |  67 ++--
 rust/hw/char/pl011/src/memory_ops.rs   |  25 +-
 rust/qemu-api/src/prelude.rs           |   2 +
 rust/qemu-api/src/qdev.rs              |  16 +-
 rust/qemu-api/src/qom.rs               |  21 +-
 rust/qemu-api/src/vmstate.rs           | 700 +++++++++++++++++++++------------
 rust/qemu-api/src/zeroable.rs          | 118 +++---
 rust/qemu-api/tests/tests.rs           |  56 ++-
 stubs/meson.build                      |   4 +-
 17 files changed, 1403 insertions(+), 846 deletions(-)
-- 
2.48.1


