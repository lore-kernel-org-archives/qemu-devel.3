Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9013E68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQh-0003do-QD; Thu, 31 Oct 2024 00:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQe-0003bT-Uc
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:00 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQc-0004pL-CM
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:04:59 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e2dc61bc41so372645a91.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347496; x=1730952296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LIqRYMniRHSpc4jxRLdABFuGNlRPDwzw9GuJDNkhcRs=;
 b=dv2TOKsbRyLtmnQwN+rCn+xvon0AIKmlrc8M2/U3tSpldd0To9Ez6t1DHaHAgm/U2G
 9xPVsyJ/qQ8De8QGyvNkWe0msiud41dvTLzPV25QTQcDCJK+82IsWvltJc0IIqINVwnw
 NWmOLIK0kKL3cbWrezDXvPRhoFCAVLClBdlksX/Rl42WIEqD0g4vedemOZfTm4njtoCu
 KAsErnuu6uDB8BD6Ar7pDO6YnCrc0OprdtrzjSx0XifDmSFT/o1lT3ANQyEpV7g3zTJH
 ZFQiP0C74a9iAyyv1kmZbhuGkTlUxD1Y7SqE2v9a10z1kJDGC0HStvTFp8tW+zP/f1Pg
 8e8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347497; x=1730952297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LIqRYMniRHSpc4jxRLdABFuGNlRPDwzw9GuJDNkhcRs=;
 b=Bj1/JCedOFZRP+i4aWnvc4dFWYxRq9ztjQoIV5QnQHIa/uKGc1aBW57gNdEu/LzBqz
 wjzXiNwNED6LmtQUF4XtvQsi1pLqqIMM++FxITY/E4lo65JV2YKvkKEOX/iCnXLhmQwg
 FRQyOMxJSBVAgYqcNJ+47ILZdYFLwLVuwX0gQuBW9XnmDqpof2mR6i/oWTAfBsyfO8y9
 abhruDtBc0vMSuuRxNW6dD9teaWGttrzd7LO/IuYcdL9HBhyaCfLvGTzq0STXwxqBJKF
 5Er8JAe0iSBnPCPbTwFyWwIAr5WjA1I7h+G/JDL6I/DBUQOJpGbnoCaqp/+v/OhtX2v7
 iASg==
X-Gm-Message-State: AOJu0YyDR7IUMcT3sCzY4iE/xNCttylLLcFNVnem+G5X9SRO1swIWtmt
 PA7uzQcSAUnYZZ+Qn42eWSgSTBoJfkvg2zqV6thkGZFl9wnWkzlBu2J0zJGjEm7hbWwhguU8tGk
 FNg8OAQ==
X-Google-Smtp-Source: AGHT+IEx/enbsSncgD3k2F4sNV+xavjywTPy2Pi+MDfNhAeb5O5v7M2rUt1urELEHLGVAZaesBi/hw==
X-Received: by 2002:a17:90b:3e84:b0:2e2:b719:d581 with SMTP id
 98e67ed59e1d1-2e8f0f53db8mr20061860a91.5.1730347496436; 
 Wed, 30 Oct 2024 21:04:56 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:04:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 00/12] Enable building plugins on Windows with Clang
Date: Wed, 30 Oct 2024 21:04:14 -0700
Message-Id: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

For now, it was only possible to build plugins using GCC on Windows. However,
windows-aarch64 only supports Clang.

The first patches (already posted and normally pulled) are fixes and
prerequisite to build plugins with meson. They are integrated here because it's
not possible to have two based-on in the cover letter.

Then, we fix compilation warnings on Windows.
After that, we can enable linking with Clang on Windows.

Finally, we enhanced the plugin symbols export list (automatically generated,
and not a static file), and we report some of the information we discovered on
the path in the documentation.

Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and aarch64
hosts.

Pierrick Bouvier (12):
  scripts: remove erroneous file that breaks git clone on Windows
  contrib/plugins/cflow: fix warning
  meson: build contrib/plugins with meson
  contrib/plugins: remove Makefile for contrib/plugins
  qga: fix -Wsometimes-uninitialized windows warning
  qga: fix missing static and prototypes windows warnings
  win32: use compiler option instead of attribute gcc_struct
  plugins: enable linking with clang/lld
  plugins: add missing export for qemu_plugin_num_vcpus
  plugins: detect qemu plugin API symbols from header
  plugins: eradicate qemu-plugins.symbols static file
  docs: add information on how to setup build environments

 MAINTAINERS                               |   1 +
 docs/about/build-platforms.rst            |   4 +-
 docs/devel/build-system.rst               | 100 ++++++++++++++++++++++
 configure                                 |  18 ----
 Makefile                                  |  10 ---
 meson.build                               |  14 ++-
 include/qemu/compiler.h                   |   7 +-
 include/qemu/qemu-plugin.h                |   1 +
 subprojects/libvhost-user/libvhost-user.h |   6 +-
 contrib/plugins/cflow.c                   |   6 +-
 qga/commands-windows-ssh.c                |   2 +-
 contrib/plugins/Makefile                  |  87 -------------------
 contrib/plugins/meson.build               |  28 ++++++
 plugins/meson.build                       |  36 ++++++--
 plugins/qemu-plugins.symbols              |  59 -------------
 qga/vss-win32/install.cpp                 |   6 +-
 qga/vss-win32/provider.cpp                |   5 +-
 qga/vss-win32/requester.cpp               |   8 +-
 scripts/meson-buildoptions.               |   0
 scripts/qemu-plugin-symbols.py            |  45 ++++++++++
 tests/tcg/plugins/meson.build             |   3 +-
 21 files changed, 238 insertions(+), 208 deletions(-)
 delete mode 100644 contrib/plugins/Makefile
 create mode 100644 contrib/plugins/meson.build
 delete mode 100644 plugins/qemu-plugins.symbols
 delete mode 100644 scripts/meson-buildoptions.
 create mode 100755 scripts/qemu-plugin-symbols.py

-- 
2.39.5


