Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE5AC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxiv-0005eF-2O; Tue, 27 May 2025 13:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxit-0005dA-C1
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxim-0006fn-Re
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748365450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+bQUtrj+W7/yWWbiG+VwobJE5SaWcMWQz69Z0fjaNGw=;
 b=Bw1DXiPbaXEgMUYyrUlUIoBwPgpXTxEiX10CW5lA9KoiG0xmYNribGXiW+H0N1u9J0bhZo
 dKBpDFZeWS6hwFmCx4S3tyE85gCmfX3vucXhI8clf/Ycaazuo/G6N7UXPkBb475Z/seQYR
 uVJd/f6l8iJt5hXl5KJYbSQ5vXQvl18=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-IIfqHFz-OJ2abhKWvCGUJw-1; Tue, 27 May 2025 13:04:08 -0400
X-MC-Unique: IIfqHFz-OJ2abhKWvCGUJw-1
X-Mimecast-MFC-AGG-ID: IIfqHFz-OJ2abhKWvCGUJw_1748365447
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad86c281f42so279032666b.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365446; x=1748970246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+bQUtrj+W7/yWWbiG+VwobJE5SaWcMWQz69Z0fjaNGw=;
 b=cUH/42kXfmGYyvA4+OqI1IKvbZwNTkzAf7yc4FZIA6gTY8QjaFNd7oCqSkygynXAAM
 OOLBrPXk4cBcoT5N/AW8A3VsHx/pjZm/TxhFnmZHH+5gKlT7QCO8ycTdbEUpCuWRk5lq
 HmzyBfrgEMZhi8wctJUU+875K7PZSIWMjLSWEJzzYmJtgVwrLVt28uQZRj3ToCeYyNdw
 t3Nc4rhmXbBFViYbuhA8bA2G1Q+JP/wPN7XjGPgZNyqIn6auywV4cmSb+atq+Uw0eZy5
 8yxqBJ2vaYuk+s0Mvk/6h+QWWFxhxeHiFFL0ncsg982Rfro4XSHjjPfyXRSS6Iah56u1
 5M4A==
X-Gm-Message-State: AOJu0YyZk00dKAaRWQEGdMJPPnuYMk6Nd5LdwQ27wbQgo053VFg1lcY9
 s8QOXxpwsqGYKFljsTBFvpEulBS3PWVOgKW2gWEVrxeg5xTvVNEcJlezyPCzXMYt/F3R8f0bAix
 gMM/km0xaJF3oK2vu+5czTCooF3VuFZbrxtpxDK4aM4ptFNtkxYs+1ThmNIb3f+hlqTG+BtTyzu
 TvefaAQYKV75YX0OXiNNFcy19tv8xmM1juAvTU1x4t
X-Gm-Gg: ASbGnct9Bq+yKLdb5duzjK+ZiwfbfX1sco2se1gO0EcVcl5TAs4NkDh6jh4FEvZO6yD
 m/uE4FhzWcuYnf6EqUdJvvLliE2EcMWA9AjyHaZA1Diqu5vs44LdrZCou59jSxA/dUvEdIYB73n
 heQ1vTVgKhmXwpCXBMRto6ACrpO7dA1P8Zz8ipoaPvEk2TItyyaXV+l6Bx3Bnink9brEj+tEmnS
 ElBciOWzUH7g5q0ACg+1iCIgScGcvC0bH0JSFR2FxPBesyMoEUmPRhI0J+imutOLWItZuqCzyV+
 oTIRgt5oo1+J2A==
X-Received: by 2002:a17:907:7207:b0:ad8:9428:6a35 with SMTP id
 a640c23a62f3a-ad894286cc0mr238406566b.7.1748365446342; 
 Tue, 27 May 2025 10:04:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr1la6R4qetkiI4EyZincW6nFrFxeMC0AvMwEURCq1x5KT7VBiS94H1KZeoBmetl0ZxoF/YQ==
X-Received: by 2002:a17:907:7207:b0:ad8:9428:6a35 with SMTP id
 a640c23a62f3a-ad894286cc0mr238400066b.7.1748365445782; 
 Tue, 27 May 2025 10:04:05 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad5b192cb0asm1097532966b.170.2025.05.27.10.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 10:04:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/6] rust: update build system for Meson 1.8.1
Date: Tue, 27 May 2025 19:03:58 +0200
Message-ID: <20250527170404.1580482-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Meson 1.7.0 and 1.8.0 include improved support for Rust, namely:
* support for "objects" in Rust executables
* support for doctest targets
* invoking clippy and rustdoc

Use it to remove BQL-related hacks, fix --enable-modules --enable-rust
and also simplify the Meson logic for building the qemu-api crate
(which may help splitting the crate, too).

Note that this does *not* yet require 1.8.1 for all of QEMU; the
requirement is only there if Rust is enabled.

Paolo

Supersedes: <20250405100603.253421-1-pbonzini@redhat.com>



Paolo Bonzini (6):
  meson: update to version 1.8.1
  rust: use "objects" for Rust executables as well
  build, dockerfiles: add support for detecting rustdoc
  rust: add qemu-api doctests to "meson test"
  rust: cell: remove support for running doctests with "cargo test
    --doc"
  rust: use native Meson support for clippy and rustdoc

 docs/devel/rust.rst                           |  12 ++++---
 configure                                     |  16 +++++++++
 meson.build                                   |   4 ++-
 .gitlab-ci.d/buildtest-template.yml           |   3 +-
 .gitlab-ci.d/buildtest.yml                    |  11 ++-----
 rust/clippy.toml => clippy.toml               |   0
 python/scripts/vendor.py                      |   4 +--
 python/wheels/meson-1.5.0-py3-none-any.whl    | Bin 959846 -> 0 bytes
 python/wheels/meson-1.8.1-py3-none-any.whl    | Bin 0 -> 1013001 bytes
 pythondeps.toml                               |   2 +-
 rust/Cargo.toml                               |   1 -
 rust/meson.build                              |  14 ++------
 rust/qemu-api/meson.build                     |  31 +++++++-----------
 rust/qemu-api/src/cell.rs                     |  22 +++++--------
 scripts/rust/rustc_args.py                    |   5 +--
 .../dockerfiles/fedora-rust-nightly.docker    |   2 ++
 tests/docker/dockerfiles/ubuntu2204.docker    |   1 +
 tests/lcitool/mappings.yml                    |   6 +++-
 tests/lcitool/refresh                         |   3 ++
 19 files changed, 69 insertions(+), 68 deletions(-)
 rename rust/clippy.toml => clippy.toml (100%)
 delete mode 100644 python/wheels/meson-1.5.0-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.8.1-py3-none-any.whl

-- 
2.49.0


