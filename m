Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB47C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3aG-0006gz-Od; Thu, 08 May 2025 11:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uD3aE-0006gX-1L
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uD3aA-00058P-7a
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746719684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xOWXgj6DP0I/4qCJYEZQWU8RqfvbiWifHfS+aEUP/ek=;
 b=HbcT82EIXjVh4GxqIE8ip1t4gbzcbyMHykfb9TDErjpKBSk+/AzJdomcF6qsEXW54b/fjh
 HicZkXfZe+DOaUh1gaOBha4yJsYMz+JvDAP0jL4KC7TIqMb9neTBnaU9vwhAY2u/EpJFfY
 7kI7caJ3eeXjuTPP1WzSQP3dbOZOefo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-fEm-bmHMOnSTQ4d5um9Jaw-1; Thu, 08 May 2025 11:54:43 -0400
X-MC-Unique: fEm-bmHMOnSTQ4d5um9Jaw-1
X-Mimecast-MFC-AGG-ID: fEm-bmHMOnSTQ4d5um9Jaw_1746719682
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5fc348a53f5so923971a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 08:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746719682; x=1747324482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xOWXgj6DP0I/4qCJYEZQWU8RqfvbiWifHfS+aEUP/ek=;
 b=wGIKgJgzE39spEAsldHJHgnYuQszTbsvLgeEL0ZWcUqnAK1tspWjfZzXTBMPPIDgsy
 vLzCOxhX4FuML0QKzVQDn5LApJA91BimbTKU9OfhSKRhe2KccWNLFHLRonPcWeRMDGhO
 Zm4mMHN63bsx7T8gknbvPghGJZUpKvh1aAntSxiPqivyUG+fGjDV9GRREugZsZqOyQ+V
 A+74ePOY2t9AfSGH0SXoQGpBYyDZ71vTmzCbKPVEdVS/Itw6aaxTp+QKSLZJ2pJFDgbB
 sDBF745U88pro9SkjJZ41p+OSjE1YJ6/mskSW8u87hGRjwsJrnMyu53LeLG16Oe9fIfA
 87fA==
X-Gm-Message-State: AOJu0YxR+es9REURKksvxucpXwCBxDZ2n8O88jvAL8zyTlxGIKf0FlfG
 FO0YlNIyD+5cjmXck+w1qdPr6onltkU81fAINpoomLljF5GhFnBu9cfMUgGpGPbPoD8sUgjVEL2
 KcGDwA91/IqfIhJQR1mCmuQejNbFv65nuqqmyKLQ5MYheLwEa5Pb79b+LZ2XlShd7QiXgQzAVrN
 w/grrtU/zNxsrWrR+viH+fyR9HWKB7pWvbYQxX
X-Gm-Gg: ASbGncuasZTJlLEIXLJanMIjOpBcVpnfC5gO2T92sXrCQlkPOUHdWy3OBU66aAqV4HO
 WKxFwhPO0JxxRHNX7laagIvUALFAvoFpn3+DRoXdwGcJ5pbR4/jYoDeZMYa4SesCF5HSObv6DuB
 6f3MPb4BYSi9Qv6haoIKArLMNtpOG2ezvzXzp//onnLQVhYZ08UUh0YkqL3hqZB/hTDBcijZrIS
 znRqwwN/nGgIcwxQkqe0SHiciPJtnbm7gHDYw2x+KapdIqH+q/F1SW2Zzge2hlcOMCgn4ul7oVH
 B4pFIsUUkcsNzA==
X-Received: by 2002:a17:907:894b:b0:ace:3c0b:1947 with SMTP id
 a640c23a62f3a-ad218e75ff4mr22471366b.4.1746719681852; 
 Thu, 08 May 2025 08:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCKvCuJ5He+J8v8e4rOnfKXYubUMQD7NrL6Htpj99qkM+nX6cDnUZJh7TRN7+1mpPy29Z8OQ==
X-Received: by 2002:a17:907:894b:b0:ace:3c0b:1947 with SMTP id
 a640c23a62f3a-ad218e75ff4mr22468766b.4.1746719681327; 
 Thu, 08 May 2025 08:54:41 -0700 (PDT)
Received: from [192.168.122.1] ([93.56.161.39])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219321c1dsm5336566b.38.2025.05.08.08.54.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 08:54:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2, part1 00/15] Rust changes for 2025-05-06
Date: Thu,  8 May 2025 17:54:39 +0200
Message-ID: <20250508155439.512349-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d2eab8:

  Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qemu into staging (2025-05-05 11:26:59 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 821ee1c31427a4e08af030469311c2d8ed96f1d1:

  docs: build-system: fix typo (2025-05-06 16:02:04 +0200)

----------------------------------------------------------------
* ci: enable RISC-V cross jobs
* rust: bump minimum supported version to 1.77
* rust: enable uninlined_format_args lint
* initial Emscripten support
* small fixes

----------------------------------------------------------------
Paolo Bonzini (15):
      lcitool: use newer Rust for Debian and Ubuntu
      meson, cargo: require Rust 1.77.0
      rust: use std::ffi instead of std::os::raw
      rust: let bilge use "let ... else"
      rust: qemu_api_macros: make pattern matching more readable and efficient
      rust: use MaybeUninit::zeroed() in const context
      rust: qom: fix TODO about zeroability of classes
      rust: enable clippy::ptr_cast_constness
      rust: remove offset_of replacement
      rust: replace c_str! with c"" literals
      docs: rust: update for newer minimum supported version
      target/i386/emulate: fix target_ulong format strings
      rust: clippy: enable uninlined_format_args lint
      ci: run RISC-V cross jobs by default
      docs: build-system: fix typo

 docs/about/build-platforms.rst                     |  11 +-
 docs/devel/build-system.rst                        |   2 +-
 docs/devel/rust.rst                                |  38 +----
 meson.build                                        |   6 +-
 target/i386/emulate/x86_decode.c                   |   2 +-
 target/i386/emulate/x86_emu.c                      |   2 +-
 .gitlab-ci.d/container-cross.yml                   |   3 -
 .gitlab-ci.d/crossbuilds.yml                       |   5 -
 rust/Cargo.lock                                    |   1 -
 rust/Cargo.toml                                    |   7 +-
 rust/clippy.toml                                   |   3 +-
 rust/hw/char/pl011/src/device.rs                   |   4 +-
 rust/hw/char/pl011/src/device_class.rs             |  13 +-
 rust/hw/char/pl011/src/lib.rs                      |   6 +-
 rust/hw/timer/hpet/src/fw_cfg.rs                   |   6 +-
 rust/hw/timer/hpet/src/hpet.rs                     |  28 ++--
 rust/hw/timer/hpet/src/lib.rs                      |   4 +-
 rust/qemu-api-macros/src/lib.rs                    | 123 ++++++---------
 rust/qemu-api/Cargo.toml                           |   3 -
 rust/qemu-api/build.rs                             |  11 +-
 rust/qemu-api/meson.build                          |   5 -
 rust/qemu-api/src/c_str.rs                         |  61 --------
 rust/qemu-api/src/cell.rs                          |   6 +-
 rust/qemu-api/src/chardev.rs                       |   5 +-
 rust/qemu-api/src/irq.rs                           |   6 +-
 rust/qemu-api/src/lib.rs                           |   7 +-
 rust/qemu-api/src/memory.rs                        |   3 +-
 rust/qemu-api/src/offset_of.rs                     | 168 ---------------------
 rust/qemu-api/src/qdev.rs                          |   9 +-
 rust/qemu-api/src/qom.rs                           |  14 +-
 rust/qemu-api/src/timer.rs                         |   4 +-
 rust/qemu-api/src/vmstate.rs                       |  14 +-
 rust/qemu-api/src/zeroable.rs                      | 106 +++----------
 rust/qemu-api/tests/tests.rs                       |  11 +-
 rust/qemu-api/tests/vmstate_tests.rs               |  27 ++--
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |   2 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |   2 +-
 subprojects/bilge-impl-0.2-rs.wrap                 |   1 -
 subprojects/packagefiles/bilge-impl-1.63.0.patch   |  45 ------
 tests/docker/dockerfiles/debian-amd64-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-i686-cross.docker  |   2 +-
 .../dockerfiles/debian-mips64el-cross.docker       |   2 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   2 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   2 +-
 tests/docker/dockerfiles/debian.docker             |   2 +-
 tests/docker/dockerfiles/ubuntu2204.docker         |   3 +-
 tests/lcitool/mappings.yml                         |   5 +
 tests/lcitool/refresh                              |   5 +-
 51 files changed, 183 insertions(+), 622 deletions(-)
 delete mode 100644 rust/qemu-api/src/c_str.rs
 delete mode 100644 rust/qemu-api/src/offset_of.rs
 delete mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch
-- 
2.49.0


