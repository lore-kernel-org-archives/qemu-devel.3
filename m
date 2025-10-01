Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B90CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rbf-0003lB-Pc; Wed, 01 Oct 2025 03:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rbd-0003kf-CA
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rbP-0002WS-BT
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f9S7vytCzebLk3hg+XmrJ0xjGE99hVn95bmJltJsB9I=;
 b=h5gt7IxbRBz8hBjtYY55K3JY1Bf8w7bsqRAeZz9JN9EFPoX6n6eWGIJvWNWgsE6Hp0fHdB
 b81CvK0OvDiyxvS9jSBEPvEgPexzeiW5nOOeuV2kYOLxgHhGCNmXV9cbJGzlaFxwXKrA1W
 djOpjYp0MlsqJPaBBcRdafN5OGL3nWg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-zRQ4cEWlNaaS3XYHFJ9EWA-1; Wed, 01 Oct 2025 03:50:11 -0400
X-MC-Unique: zRQ4cEWlNaaS3XYHFJ9EWA-1
X-Mimecast-MFC-AGG-ID: zRQ4cEWlNaaS3XYHFJ9EWA_1759305011
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3d21b18e8fso227256366b.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305010; x=1759909810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f9S7vytCzebLk3hg+XmrJ0xjGE99hVn95bmJltJsB9I=;
 b=oGvtT+7u7kEYiIPhgeSEU6HnPDIwdFbYQVcBJPTxcfUvnoYmf958upscwA9VK/ELym
 YSyo5Dog/8rcAaMvkjtbRcxuSUhQTZ7XReKlcRDutL+BWJJJtbfnCvY/YM9DWo7qyO6I
 HkBDynnG84vPCGKHkWmwFiHk/v1dSNQoAAUU02dJ/82w5C4AVbi4I2YxAIPZetlT/jpL
 SVDiaGuj8cDr8KsUM+vwZXKLHvi/1ze5UVyVFbk2GuB+jbu3KCwUcxnwMehpl43k1Xnz
 EDIR7/3Ob5Vhtxy3DlCpEb6KUUBM2smKXOpo9rdYmn3e9y4QAI+5uLaVjeu808MF+YKp
 zD2g==
X-Gm-Message-State: AOJu0Ywgy1tW9ZhFQZzgvCGFXWs5tmTSm9Icait5WDXfm+nSu7yt3FCs
 iV4+QcmZexeVE6NNGqm90rvj+mlj//oybnGYV8iqnZHt8Azf6ecZsKiPQ2FF//wkcdpxEYAJhaz
 UWNXMsKb4aLV6FhbpiBX2eTHWmDyETTA5hbVbgXImzLsCwHi0m0/lqFgv1cINstDDxUFv8jxIEF
 NUXGcyEbC3MWKzlJ2HGKlCl+81w+oT5wnCLhTgRgCm
X-Gm-Gg: ASbGncvovaE+PomLf3SfTtR75m52Mn8vVx42Cl+bNumtDNcr4OAlZdTlurm7heqViKE
 Z0LEO4tNTopV4FHUQq2JmdtDnpmbxpHO21gXj0+52rHyCLZy5NmpnE2z/wmTCpJ28cT3W2kS5DH
 B2+eyxnmFle/mKcT1uzT/vsVmgk106K3HISbfzunKdE7JWrm3rBt0bi0puDIWUT00MxjSG1aZNH
 Ms+e2WFu3jVWLjvBBTrVzjOOh+VnhZlhv6x19a/Vu5IXj+AFYoP6uoAgMfgAFKFjQVyOAhAZUze
 n0U1CjXWe6FneS9Z+zK9puIVYmT2JczWZJ2hXbrKai0pyuDS2wDl51Jq4oUNsqbUhvt14dMczAw
 SkHvPbEwogYeorC8RagtBS1sPE5qPjpLhBrQ0Nvys1dKU3lJgNyI=
X-Received: by 2002:a17:907:86a6:b0:b45:b078:c52f with SMTP id
 a640c23a62f3a-b46e68109c1mr300030566b.61.1759305008888; 
 Wed, 01 Oct 2025 00:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7nDLxkGnJoUx76mA0McSoERv/o28MDRpnc0cVWSKYDgxNMn/yhCIAGuvujfcGyb65njJRpw==
X-Received: by 2002:a17:907:86a6:b0:b45:b078:c52f with SMTP id
 a640c23a62f3a-b46e68109c1mr300019566b.61.1759305006858; 
 Wed, 01 Oct 2025 00:50:06 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3ca6592cadsm723132666b.31.2025.10.01.00.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:50:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 00/11] rust: migration: add high-level migration wrappers
Date: Wed,  1 Oct 2025 09:49:54 +0200
Message-ID: <20251001075005.1041833-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This series adds high-level wrappers to handle migration state; they consist
of a Migratable<> type that implements the snapshotting technique mentioned
in Zhao and my KVM Forum presentation.

The wrappers (should) make it possible to easily implement migration of
thread-safe devices.  I say "should" because, even though there are tests
included in the series, they are anything but "battle tested"; for this
reason they are marked as "proof of concept" in docs/devel/rust.rst.
The first device to use this will be HPET.

This is an interesting step in enabling usage of Rust in QEMU; instead of
just wrapping existing C APIs, it provides a new interface that deals
better with unique features of the Rust language.  In other words,
something like Migratable<> and ToMigrationState might hypothetically
exist even if QEMU was written in Rust from scratch.

Paolo


RFC->v1:

new patches
- rust: migration: do not pass raw pointer to VMStateDescription::fields
- rust: migration: do not store raw pointers into VMStateSubsectionsWrapper
- rust: migration: validate termination of subsection arrays
- timer: constify some functions

changes
- use UnsafeCell::get_mut()
- add and use Timer::expire_time_ns()
- small reordering of the implementations of ToMigrationState/ToMigrationStateShared
- list migration::migratable in docs/devel/rust.rst


Paolo Bonzini (11):
  rust: bql: add BqlRefCell::get_mut()
  rust: migration: do not pass raw pointer to VMStateDescription::fields
  rust: migration: do not store raw pointers into
    VMStateSubsectionsWrapper
  rust: migration: validate termination of subsection arrays
  rust: migration: extract vmstate_fields_ref
  rust: move VMState from bql to migration
  rust: migration: add high-level migration wrappers
  rust: qemu-macros: add ToMigrationState derive macro
  timer: constify some functions
  rust: migration: implement ToMigrationState for Timer
  rust: migration: implement ToMigrationState as part of
    impl_vmstate_bitsized

 docs/devel/rust.rst                     |   1 +
 include/qemu/timer.h                    |   6 +-
 util/qemu-timer.c                       |   8 +-
 rust/Cargo.lock                         |   5 +-
 rust/bql/Cargo.toml                     |   3 -
 rust/bql/meson.build                    |   1 -
 rust/bql/src/cell.rs                    |  23 +-
 rust/meson.build                        |   2 +-
 rust/migration/Cargo.toml               |   2 +
 rust/migration/meson.build              |   7 +-
 rust/migration/src/lib.rs               |   5 +
 rust/migration/src/migratable.rs        | 473 ++++++++++++++++++++++++
 rust/migration/src/vmstate.rs           |  85 +++--
 rust/qemu-macros/src/lib.rs             |  88 +++++
 rust/qemu-macros/src/migration_state.rs | 296 +++++++++++++++
 rust/qemu-macros/src/tests.rs           | 112 +++++-
 rust/util/src/timer.rs                  |  10 +-
 17 files changed, 1071 insertions(+), 56 deletions(-)
 create mode 100644 rust/migration/src/migratable.rs
 create mode 100644 rust/qemu-macros/src/migration_state.rs

-- 
2.51.0


