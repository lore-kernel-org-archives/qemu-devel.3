Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8206ACAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzybL-0007F3-43; Sat, 20 Sep 2025 10:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybJ-0007ET-Gg
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybG-0005Pw-Ds
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758378605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RXUdmalvHm+5/GVcC2GTT1297p4snx3KOMpnEPeu9zw=;
 b=QT1CjjmXC8ggrB/22mJmHI5oiDKQqZAiNJuC2QRiP3mG3mVakfwqwnZgRAzVtuH7wb4VzX
 7w6/N5YPVgZbhYGXPbhgslePHSeiuLIzj9o8X3i671+HsjV/VesIVv4Ej9F0K9CQxsW0l+
 OVY2VkmpD4UeuGYMdXl7ZATxjzOnL5E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-HQuA5YxqMQu6Y_L_mxcEFg-1; Sat, 20 Sep 2025 10:30:02 -0400
X-MC-Unique: HQuA5YxqMQu6Y_L_mxcEFg-1
X-Mimecast-MFC-AGG-ID: HQuA5YxqMQu6Y_L_mxcEFg_1758378602
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45e037fd142so29436365e9.3
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 07:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758378601; x=1758983401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RXUdmalvHm+5/GVcC2GTT1297p4snx3KOMpnEPeu9zw=;
 b=KhLAZ8zPKtHW5+FyaggP/cOu0dlNPDB4j7OTUwLC/seu2Cp7wYgnSDotvrMJNAGSnX
 cLT+7tC/JTzsG3FrgKVV1s5SlZ+9xClF4pXu3WXUzJPgsfyieOLLpaWRPwBJb4PVf8GJ
 20+V/siIBb4oYUs+Fo1L5iSJSIm09HBgnh/PcyyD0GUSh26wx90oxYePvtzfEJCtfqwh
 H/xvxoQF9++6EL+xkwnME2F4jb0eHO0pog6ftinofnHcD2jhd/a+bGdoB65t3Pxr9xE5
 +LfaD1A1jnvS/+QgrXAXMOO4xxvbRpxqwgiOg1CYRluh/KWOHDdnvibD0IvseBSN1i4r
 YtUw==
X-Gm-Message-State: AOJu0YweiWCfyA14XrH+v/sMA3jqY4EOBMYVSri41TlC5bHbgCtMfLeB
 eY/OdpFnqGbmDvsC01Nr5rJyyQYxooKsRApVjeOlOzGtDNmZ+iJu/Q7oIadaqVL4ux9oI9/vnKW
 xHFi266nGS8oVf0AyaO3OwKwe17jNF5tgOlg9i1GTXhl0ba0X0bx7jt28EdmXbuLY245RvV27Oi
 vzP0W0lP1GG/mOWjD0XQBE8E8vxjRoAKFeyhxX9I36
X-Gm-Gg: ASbGncuK9VQdD61YrYTJFKAr++bDgqc06Zo7A7GlA+JUXyiPmM+///5U9cTYkv+V91a
 xyMV2kzlKbHrWeV31h723uuZ6zc8eki+KRiH0jhy9QlAy4dnzd31lGMoasCFwzwu8wo40Vs9Hrw
 8bR5DJkWmVbeSUIPqgsX+WkAq4x6Fd5fkfxF9gK5xLLlzMO9qsrNcL1fIUDKV33dkA8zgW4Kiuf
 9HCdzCfgIoQRurlRhLoOhRJmBhAZhXsVpQ+py2Q073vH7mc3UAQWUKnSmezskMAtKVpiWOxEM9r
 BcaSAFl6BuwzSorCBdz4+kvQsCvqFDH92SWxNLYqWkRJYibivkoo7bGL5qYNvi7jG1EW2MIkgxQ
 ss3TWlctRkSjorP2KrRPlmCNsa899ZUkY3n/nSGYotfc=
X-Received: by 2002:a05:600c:3b26:b0:45d:d6fc:24f7 with SMTP id
 5b1f17b1804b1-467eaa86ec8mr52767775e9.32.1758378600758; 
 Sat, 20 Sep 2025 07:30:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCrUkp3V8CjdTu4EsyiVArwCL6I/AP7qbQj/vHr08l9AjYtRZnxN+l1Ek4Cd/kIiDgh7qnOQ==
X-Received: by 2002:a05:600c:3b26:b0:45d:d6fc:24f7 with SMTP id
 5b1f17b1804b1-467eaa86ec8mr52767635e9.32.1758378600259; 
 Sat, 20 Sep 2025 07:30:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f0e28c83d6sm6447154f8f.56.2025.09.20.07.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:29:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, zhao1.liu@intel.com, manos.pitsidianakis@linaro.org
Subject: [RFC PATCH 0/7] rust: migration: add high-level migration wrappers
Date: Sat, 20 Sep 2025 16:29:51 +0200
Message-ID: <20250920142958.181910-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
at KVM Forum.  The concepts are also discussed at
https://lore.kernel.org/qemu-devel/8076a298-1cd9-4c90-a64c-f65004753975@redhat.com/T/

The wrappers (should) make it possible to easily implement migration of
thread-safe devices.  I say "should" because, even though there are tests
included in the series, they are anything but "battle tested".  The first
device to use this will be HPET.

This is an interesting step in enabling usage of Rust in QEMU; instead of
just wrapping existing C APIs, it provides a new interface that deals
better with unique features of the Rust language.  In other words,
something like Migratable<> and ToMigrationState might hypothetically
exist even if QEMU was written in Rust from scratch.

Paolo


Paolo Bonzini (7):
  rust: bql: add BqlRefCell::get_mut()
  rust: move VMState from bql to migration
  rust: migration: extract vmstate_fields_ref
  rust: migration: add high-level migration wrappers
  rust: qemu-macros: add ToMigrationState derive macro
  rust: migration: implement ToMigrationState for Timer
  rust: migration: implement ToMigrationState as part of
    impl_vmstate_bitsized

 rust/Cargo.lock                         |   5 +-
 rust/bql/Cargo.toml                     |   3 -
 rust/bql/meson.build                    |   1 -
 rust/bql/src/cell.rs                    |  25 +-
 rust/meson.build                        |   2 +-
 rust/migration/Cargo.toml               |   2 +
 rust/migration/meson.build              |   7 +-
 rust/migration/src/lib.rs               |   5 +
 rust/migration/src/migratable.rs        | 469 ++++++++++++++++++++++++
 rust/migration/src/vmstate.rs           |  44 ++-
 rust/qemu-macros/src/lib.rs             |  88 +++++
 rust/qemu-macros/src/migration_state.rs | 296 +++++++++++++++
 rust/qemu-macros/src/tests.rs           | 112 +++++-
 13 files changed, 1034 insertions(+), 25 deletions(-)
 create mode 100644 rust/migration/src/migratable.rs
 create mode 100644 rust/qemu-macros/src/migration_state.rs

-- 
2.51.0


