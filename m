Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923A7C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLOE-0007vZ-QA; Thu, 04 Jul 2024 08:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPLNl-0007r0-BH
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPLNZ-0002Oj-Fu
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:13 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42578fe58a6so3739525e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 05:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720095352; x=1720700152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/dq+SgYGDDs7RBqgqaNd2JkbYqtxXuJ1AcTEJkRSexg=;
 b=r1IRqZfjQc/9DlgGoHzChq7IseFp0Amc6wtmStmeVgRANdIv2uyY83p+/qoInlwVVu
 jybiBxrUIN+ALUexOcz7Rkg6zVPFm4VltlFneAH/sZSkW1QdwpUVeoWOIP+6KuN4mgQq
 pxj3E3MlUgX7CmuyJ+XffnBYx2S5H+UAd7JovNIqDIiQPnUEg+1ZaUWzSXyIk1ho3cNu
 3doCL4icoIVcmMh3Y/gqXwyFX+ldxFRZyZxPfK1uiJL9zC/j+HZcJLXkzEm4cIRJJIGi
 oTTnY3P33SFqKwScwmW3ksgRhalsJw5irQoR0bR139v5EJeh814QoPYebGscqr5ELGz1
 w+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720095352; x=1720700152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/dq+SgYGDDs7RBqgqaNd2JkbYqtxXuJ1AcTEJkRSexg=;
 b=Qw0b5KPHJ1+HnDOHxLRRaV5b5tZT/PVNYFx1nG4O/36YVadJ29nNUtqBGRPY0I2LAK
 1g046J2uaXPP33dk7UJkG/7+Aa0MXnqMQrs2DrvqovlRROgyBD0NDQ7vQ4jR+Nnbo5D/
 64erJTQdSrfoPKnnpXMYetg3DCkd+7iMI3+KJINYXDnjZtA+ictzs/FlL2qiHmWwQWRc
 Rz9x9FN/4YzdeapPb3AbjBmAd89reP2jSa/lhN8RsUv+pXy+dzWT8714gsEzs23zbZAi
 Jkg+d+jW4R9bNA7KtxVPUCsuQpZfCom5j5QHTxPzes/XEngI8+R6Ok3u++15vZ143OiC
 uLWQ==
X-Gm-Message-State: AOJu0YykflFjHC/DzYUuoEnV0fDJ/jBRxuBL+rbxP7EKnaxIbjq6P+Ex
 D4DkQ7vk54jAPSilGP8grbojWHz+HOHTaX6L64sg2fVa69xeQyQOs4rX/GoSvtFn7mNGp4tq7xz
 KZNk=
X-Google-Smtp-Source: AGHT+IFbaKbUYsHc+Q3ruwdxVhExqVAGgnnaQ/Q22MsWRYtaJqyJdMpn4551OoY1D5VmLS80A0dICw==
X-Received: by 2002:a05:600c:4254:b0:425:5f6d:2f3c with SMTP id
 5b1f17b1804b1-4264a469de1mr13618015e9.39.1720095352044; 
 Thu, 04 Jul 2024 05:15:52 -0700 (PDT)
Received: from localhost.localdomain (adsl-241.37.6.160.tellas.gr.
 [37.6.160.241]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm22471015e9.32.2024.07.04.05.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 05:15:51 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v4 0/7] Add Rust support, implement ARM PL011
Date: Thu,  4 Jul 2024 15:15:36 +0300
Message-ID: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Changes from v3->v4:
- Add rust-specific files to .gitattributes
- Added help text to scripts/cargo_wrapper.py arguments (thanks Stephan)
- Split bindings separate crate
- Add declarative macros for symbols exported to QEMU to said crate
- Lowered MSRV to 1.77.2
- Removed auto-download and install of bindgen-cli
- Fixed re-compilation of Rust objects in case they are missing from 
  filesystem
- Fixed optimized builds by adding #[used] (thanks Pierrick for the help 
  debugging this)

Also, Pierrick helped confirming it works on Windows with some 
windows-specific changes. I confirmed it works on macos by allowing 
bindgen to detect system paths for clang, which is a workaround and not 
a solution. However this series doesn't have the windows changes 
integrated.

Changes from v2->v3:
- Addressed minor mistakes (thanks Stefan)
- Setup supported version checks for cargo, rustc and bindgen (thanks 
  everyone who pointed it out / suggested it)
- Fixed problem with bindgen failing if certain system headers where 
  needed by defining an allowlist for headers instead of a blocklist for 
  what we don't want (thanks Alex Bennée for reporting it)
- Cleaned up bindgen target/dependendy definition in meson.build by 
  removing unnecessary bits

Changes from v1->v2:
- Create bindgen target first, then add commit for device (thanks 
  Pierrick)
- Create a special named generated.rs for each target as compilation 
  would fail if more than one targets were defined. The generated.rs 
  target names would clash.
- Add more descriptive commit messages
- Update MAINTAINERS
- Cleanup patch order for better review, hopefully


Manos Pitsidianakis (7):
  build-sys: Add rust feature option
  rust: add bindgen step as a meson dependency
  rust: add crate to expose bindings and interfaces
  rust: add PL011 device model
  .gitattributes: add Rust diff and merge attributes
  DO NOT MERGE: add rustdoc build for gitlab pages
  DO NOT MERGE: replace TYPE_PL011 with x-pl011-rust in arm virt machine

 .gitattributes                    |   3 +
 .gitlab-ci.d/buildtest.yml        |  64 +++-
 MAINTAINERS                       |  20 ++
 configure                         |  11 +
 hw/arm/virt.c                     |   4 +
 meson.build                       |  72 ++++
 meson_options.txt                 |   5 +
 rust/.cargo/config.toml           |   2 +
 rust/.gitignore                   |   3 +
 rust/meson.build                  | 114 ++++++
 rust/pl011/.gitignore             |   2 +
 rust/pl011/Cargo.lock             | 125 +++++++
 rust/pl011/Cargo.toml             |  67 ++++
 rust/pl011/README.md              |  31 ++
 rust/pl011/deny.toml              |  57 +++
 rust/pl011/meson.build            |   7 +
 rust/pl011/rustfmt.toml           |   1 +
 rust/pl011/src/definitions.rs     |  39 +++
 rust/pl011/src/device.rs          | 509 +++++++++++++++++++++++++++
 rust/pl011/src/device_class.rs    |  48 +++
 rust/pl011/src/lib.rs             | 556 ++++++++++++++++++++++++++++++
 rust/pl011/src/memory_ops.rs      |  45 +++
 rust/qemu-api/.gitignore          |   2 +
 rust/qemu-api/Cargo.lock          |   7 +
 rust/qemu-api/Cargo.toml          |  59 ++++
 rust/qemu-api/README.md           |  17 +
 rust/qemu-api/build.rs            |  48 +++
 rust/qemu-api/deny.toml           |  57 +++
 rust/qemu-api/meson.build         |   0
 rust/qemu-api/rustfmt.toml        |   1 +
 rust/qemu-api/src/bindings.rs     |   8 +
 rust/qemu-api/src/definitions.rs  | 112 ++++++
 rust/qemu-api/src/device_class.rs | 131 +++++++
 rust/qemu-api/src/lib.rs          |  29 ++
 rust/qemu-api/src/tests.rs        |  48 +++
 rust/rustfmt.toml                 |   7 +
 rust/wrapper.h                    |  39 +++
 scripts/cargo_wrapper.py          | 288 ++++++++++++++++
 scripts/meson-buildoptions.sh     |   6 +
 39 files changed, 2625 insertions(+), 19 deletions(-)
 create mode 100644 rust/.cargo/config.toml
 create mode 100644 rust/.gitignore
 create mode 100644 rust/meson.build
 create mode 100644 rust/pl011/.gitignore
 create mode 100644 rust/pl011/Cargo.lock
 create mode 100644 rust/pl011/Cargo.toml
 create mode 100644 rust/pl011/README.md
 create mode 100644 rust/pl011/deny.toml
 create mode 100644 rust/pl011/meson.build
 create mode 120000 rust/pl011/rustfmt.toml
 create mode 100644 rust/pl011/src/definitions.rs
 create mode 100644 rust/pl011/src/device.rs
 create mode 100644 rust/pl011/src/device_class.rs
 create mode 100644 rust/pl011/src/lib.rs
 create mode 100644 rust/pl011/src/memory_ops.rs
 create mode 100644 rust/qemu-api/.gitignore
 create mode 100644 rust/qemu-api/Cargo.lock
 create mode 100644 rust/qemu-api/Cargo.toml
 create mode 100644 rust/qemu-api/README.md
 create mode 100644 rust/qemu-api/build.rs
 create mode 100644 rust/qemu-api/deny.toml
 create mode 100644 rust/qemu-api/meson.build
 create mode 120000 rust/qemu-api/rustfmt.toml
 create mode 100644 rust/qemu-api/src/bindings.rs
 create mode 100644 rust/qemu-api/src/definitions.rs
 create mode 100644 rust/qemu-api/src/device_class.rs
 create mode 100644 rust/qemu-api/src/lib.rs
 create mode 100644 rust/qemu-api/src/tests.rs
 create mode 100644 rust/rustfmt.toml
 create mode 100644 rust/wrapper.h
 create mode 100644 scripts/cargo_wrapper.py


base-commit: 7914bda497f07965f15a91905cd7ed9eaf1c1092
-- 
γαῖα πυρί μιχθήτω


