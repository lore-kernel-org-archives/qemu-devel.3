Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1448BC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsCV-0001Sa-FV; Fri, 17 Jan 2025 14:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCU-0001Rw-MU
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCR-0002Aq-Rz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737142810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oL6dTYh2RuaJWRfVXT8oeGcsfRJVUnHMv7b65g9t8lI=;
 b=CWUojGwMbXVnstQ5SUF6I5ygG02h5NGsqqfKrMeL9oVn7A/dpznMzVvy2QDSuldJ0d+ThD
 y1kiRZ3KsLkDEb/KQkuHx3vo4PDyIiGTRdF88yeZGdcOpTXxleD+boRNdNA161ITGq1T/6
 lIDYK5OibwWu4SG4yuLHwnvorTBr7ec=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-MdPWBfylPpWVvZbcEi8J8A-1; Fri, 17 Jan 2025 14:40:07 -0500
X-MC-Unique: MdPWBfylPpWVvZbcEi8J8A-1
X-Mimecast-MFC-AGG-ID: MdPWBfylPpWVvZbcEi8J8A
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa6b904a886so210478666b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737142805; x=1737747605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oL6dTYh2RuaJWRfVXT8oeGcsfRJVUnHMv7b65g9t8lI=;
 b=X/Edrw7v5w8P3JfG+0/xecJbMWElZOPVloJDRFlA8NFxXSqEkDP6i+ZcZeeHyowlRV
 Xet6TCt1Da4R+eqrPtRK6Jz5XDOzfsFwrP9JOf40znSOOrzCYmMakWJeqZDHgo7xMDT5
 2Dl0MjB/pwQma1k3IA14H+LNhSJTNpIzovhtsSOpYTN+2Z2SZyW9eaWGqLTTlzG7d1sx
 Y/KV31ozEEY5XJXMMJtRqB45QSKuPsIEptOr01LpyONSYwMYXnGKK3Lbo+G1qMDiadji
 RmxAJ7I3XEASvVIxXNbOJJYm0hGgqxdcB1k88eD7yg7io5z9Wwtqk7M2TVWGj51/A/bL
 JAUA==
X-Gm-Message-State: AOJu0YzZu05zxpIZjAUKav+1YYfT/FfxLqmYYik/0YeJ9ODq8RfkB/RQ
 8wPUORs3pzUJGLPuCOX43Ds413+2TcEJ0xhRdQBhLHZFRRT2dDRrt0drU2ZBE2P8UUF3dCAa5NT
 CpgkP1YOIkc695NCZtxkLB6Uz+SXgSYQ+plixuUubL+T8cqq9OMXXOsMgWXhuzF1gvJwZlC4lNF
 oNghKAbaJQ5oJxtEtd/haSkqx1Gmk37iYj7F8WECA=
X-Gm-Gg: ASbGncukuSmjFhlwLmeloEb3H/7CgO0JbmkUtZ71dSNFrr5QI2xpdgPNIbcZEEhu4r9
 shU9Vs1f/juhzcesyIyHMzvMXUCzGuHtONdThTcMXnrYICayBRMgM3JhbQ3pKVBZJ7D4qe8O9Uw
 A9uV1CtA8z1oVsw8jyKrC/S9g4Nt4/G/dJcc5v2zJxPITOQxWmS2plFvh7aV5xrZ1S2EdOx1AOE
 XHMUIYNoL4aIzj4V0WTSDYtLtBFX+DahXxrUYQ7qfOTxID0FSPlNvJvkbh1Ng==
X-Received: by 2002:a17:906:4783:b0:aa6:3f93:fb99 with SMTP id
 a640c23a62f3a-ab38b3841e5mr384936366b.36.1737142805426; 
 Fri, 17 Jan 2025 11:40:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLBuBP70OXFnADQniFxop/Iejj77O7nKrcI4gYoTNBzUMbfLUHoSgnVW0jFBV892kB6ui8uQ==
X-Received: by 2002:a17:906:4783:b0:aa6:3f93:fb99 with SMTP id
 a640c23a62f3a-ab38b3841e5mr384934066b.36.1737142804891; 
 Fri, 17 Jan 2025 11:40:04 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f22457sm215552666b.114.2025.01.17.11.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 11:40:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [RFC PATCH 00/10] rust: remaining part of qdev bindings
Date: Fri, 17 Jan 2025 20:39:53 +0100
Message-ID: <20250117194003.1173231-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

This is what I have left for qdev bindings, including 1) reference
counting and object creation 2) clocks 3) Resettable 4) MemoryRegionOps.
I have no rush for this series, and I expect HPET to be merged before it.
The documentation is not yet complete (will be fixed) and the API is
limited to what is needed for pl011 (which I am not considering a bug,
since the QEMU API is so large), but I think it's already ready for an
initial review.

The most interesting part is perhaps the usage of the builder pattern
for MemoryRegionOps:

    static PL011_OPS: MemoryRegionOps<PL011State> = MemoryRegionOpsBuilder::<PL011State>::new()
        .read(&PL011State::read) 
        .write(&PL011State::write)   
        .native_endian()
        .impl_sizes(4, 4)
        .build();

The code is getting closer to the synopsis at
https://lists.nongnu.org/archive/html/qemu-rust/2024-12/msg00006.html,
except that it works (at least as far as CI is concerned) instead of just
compiling. :)  And since I'm citing it, a reminder that it may still be
worth asking your Rust questions as replies to that message.

You can find the code in the rust-next branch of
https://gitlab.com/bonzini/qemu/, where it passed CI.

Paolo

Paolo Bonzini (9):
  rust: qom: add reference counting functionality
  rust: qom: add object creation functionality
  rust: callbacks: allow passing optional callbacks as ()
  rust: qdev: add clock creation
  rust: qom: allow initializing interface vtables
  rust: qdev: make ObjectImpl a supertrait of DeviceImpl
  rust: qdev: switch from legacy reset to Resettable
  rust: bindings: add Sync markers to types referred to by
    MemoryRegionOps
  rust: bindings for MemoryRegionOps

Zhao Liu (1):
  rust: qemu-api: add sub-subclass to the integration tests

 meson.build                          |   1 +
 rust/hw/char/pl011/src/device.rs     |  88 ++++++++--------
 rust/hw/char/pl011/src/lib.rs        |   1 -
 rust/hw/char/pl011/src/memory_ops.rs |  36 -------
 rust/qemu-api/meson.build            |   1 +
 rust/qemu-api/src/bindings.rs        |  19 +++-
 rust/qemu-api/src/callbacks.rs       |  97 ++++++++++++++++++
 rust/qemu-api/src/irq.rs             |   3 +
 rust/qemu-api/src/lib.rs             |   1 +
 rust/qemu-api/src/memory.rs          | 191 +++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/prelude.rs         |   4 +
 rust/qemu-api/src/qdev.rs            | 188 +++++++++++++++++++++++++++++-----
 rust/qemu-api/src/qom.rs             | 181 ++++++++++++++++++++++++++++++++-
 rust/qemu-api/src/sysbus.rs          |   7 +-
 rust/qemu-api/src/vmstate.rs         |  10 +-
 rust/qemu-api/src/zeroable.rs        |  12 +++
 rust/qemu-api/tests/tests.rs         |  87 ++++++++++++----
 17 files changed, 793 insertions(+), 134 deletions(-)
 delete mode 100644 rust/hw/char/pl011/src/memory_ops.rs
 create mode 100644 rust/qemu-api/src/memory.rs

-- 
2.47.1


