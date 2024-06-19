Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FA8C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 20:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK1ha-00027f-TR; Wed, 19 Jun 2024 16:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sK1hY-00025z-6S
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:14:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sK1hU-0001Xs-1Z
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:14:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42172ed3597so1249615e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718828072; x=1719432872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i0gUORLGX8irBIGx/T6mM424PvPE0oZYbyFdZv7K4bE=;
 b=a2Te/cpGrqHU0N6W5ikkOUcUku4N20rZhWQQM/5zLbZAzK9AOeDvvUyx4CPRLUXGFk
 qH/d3fqPPRtp+olQStzefcdLzvItV9WPqajEExUmLphDwD/Od3KTBIswFYbUldWzsVaf
 bPslwSyfZX2pwX+RxpkLzPqs5BygyqWyS3OdgS2kDUiVEu3KU6Qim6RUstHWBz7VgKjK
 wOp038qp4wbhbavQijsraIoz1sW1obxi3nbR6Ta75inx9qt4w8Y6IPx/T+eTu1c1WikQ
 mcgGQhMZ8DdZop+//W+188gWbcBXeN8r0jgArfn807KglhC2VdYHAI2oh0/20vnjg2eZ
 JlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718828072; x=1719432872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i0gUORLGX8irBIGx/T6mM424PvPE0oZYbyFdZv7K4bE=;
 b=efCxzkIbGwiVMP3HJtFe/xUzsNBAk/uY8Cw19EgoBMRGMkT6CkObQUf+uxAAyudWrH
 RJIc+B6xdkU0s6kIaatLdEpB+wqSwjB+hAVFL/s+s1jHK4aSHgQ/MGcqvf6h4DvwrAWr
 0rOHUKLOrv4Iy5uFhG9hzo4bC+VIhbZ5El4ZMd71x3HQJZQo9nJuJ3tDsOF9R57etltK
 WrvZIcJx9lK+sXqoiaI4JIwGNyiBwOLP2xDIAfxS3aQ+o5xlkvEo3NmyaBooc+tv/jL+
 bLxN0l9VjDkx+m+qTk8d1i4nSsyC5UhlxoIviK1j1IANSEhSj2JDM18m+EmOrF1Gy8xb
 iigg==
X-Gm-Message-State: AOJu0YyiGrssqBjct98lviqrv4jsc4YeElsWey15wZljEfMoJgl8l8tW
 BprL6sbBKP2Wpnlj2fyFuBGn9BgFZVCCC8kBcWDkgVd+ELzDr9BLOvyFgWxmvX+CrUAPwi87Yx9
 /Jvk=
X-Google-Smtp-Source: AGHT+IE4A/mUFXkaaNBj95fbuEpzfeyTmJTs6gMoPG98mfpUOHoqA0TpAuZP9yI9cWzdzKZhwiF+yA==
X-Received: by 2002:a05:600c:1c28:b0:424:737c:80e8 with SMTP id
 5b1f17b1804b1-42474d148c4mr40172635e9.2.1718828072025; 
 Wed, 19 Jun 2024 13:14:32 -0700 (PDT)
Received: from localhost.localdomain (adsl-103.37.6.162.tellas.gr.
 [37.6.162.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247101aac6sm45623235e9.0.2024.06.19.13.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:14:31 -0700 (PDT)
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
Subject: [RFC PATCH v3 0/5] Implement ARM PL011 in Rust
Date: Wed, 19 Jun 2024 23:13:57 +0300
Message-ID: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

v2 was:
<rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>

v1 was:
<cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>

Patches can be found online at 
https://gitlab.com/epilys/rust-for-qemu/-/tags

Tag/refs:
- rust-pl011-rfc-v3
- rust-pl011-rfc-v2
- rust-pl011-rfc-v1

Manos Pitsidianakis (5):
  build-sys: Add rust feature option
  rust: add bindgen step as a meson dependency
  rust: add PL011 device model
  DO NOT MERGE: add rustdoc build for gitlab pages
  DO NOT MERGE: replace TYPE_PL011 with x-pl011-rust in arm virt machine

 .gitlab-ci.d/buildtest.yml     |  64 ++--
 MAINTAINERS                    |  15 +
 configure                      |  11 +
 hw/arm/virt.c                  |   4 +
 meson.build                    |  71 ++++
 meson_options.txt              |   4 +
 rust/.cargo/config.toml        |   2 +
 rust/.gitignore                |   3 +
 rust/meson.build               | 131 ++++++++
 rust/pl011/.gitignore          |   2 +
 rust/pl011/Cargo.lock          | 120 +++++++
 rust/pl011/Cargo.toml          |  66 ++++
 rust/pl011/README.md           |  42 +++
 rust/pl011/build.rs            |  44 +++
 rust/pl011/deny.toml           |  57 ++++
 rust/pl011/meson.build         |   7 +
 rust/pl011/rustfmt.toml        |   1 +
 rust/pl011/src/definitions.rs  |  95 ++++++
 rust/pl011/src/device.rs       | 531 ++++++++++++++++++++++++++++++
 rust/pl011/src/device_class.rs |  95 ++++++
 rust/pl011/src/generated.rs    |   5 +
 rust/pl011/src/lib.rs          | 581 +++++++++++++++++++++++++++++++++
 rust/pl011/src/memory_ops.rs   |  38 +++
 rust/rustfmt.toml              |   7 +
 rust/wrapper.h                 |  39 +++
 scripts/cargo_wrapper.py       | 289 ++++++++++++++++
 scripts/meson-buildoptions.sh  |   6 +
 27 files changed, 2311 insertions(+), 19 deletions(-)
 create mode 100644 rust/.cargo/config.toml
 create mode 100644 rust/.gitignore
 create mode 100644 rust/meson.build
 create mode 100644 rust/pl011/.gitignore
 create mode 100644 rust/pl011/Cargo.lock
 create mode 100644 rust/pl011/Cargo.toml
 create mode 100644 rust/pl011/README.md
 create mode 100644 rust/pl011/build.rs
 create mode 100644 rust/pl011/deny.toml
 create mode 100644 rust/pl011/meson.build
 create mode 120000 rust/pl011/rustfmt.toml
 create mode 100644 rust/pl011/src/definitions.rs
 create mode 100644 rust/pl011/src/device.rs
 create mode 100644 rust/pl011/src/device_class.rs
 create mode 100644 rust/pl011/src/generated.rs
 create mode 100644 rust/pl011/src/lib.rs
 create mode 100644 rust/pl011/src/memory_ops.rs
 create mode 100644 rust/rustfmt.toml
 create mode 100644 rust/wrapper.h
 create mode 100644 scripts/cargo_wrapper.py


base-commit: 01782d6b294f95bcde334386f0aaac593cd28c0d
-- 
γαῖα πυρί μιχθήτω


