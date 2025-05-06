Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5FFC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrk-0003nb-Kc; Tue, 06 May 2025 08:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrQ-0003Nb-Mt
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:24 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrM-0003pp-O8
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:24 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so9860305a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536239; x=1747141039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UFjE6L84i2a3K/oGJog+4yJiix6X/UtL4ANXLscMNKY=;
 b=Fn/AQyV99TnWV9MRfPGJIztlpygYwEcwl5Zn9VurSLusPo4LnePTx3g9LsinHiD5tA
 soSmIMikkRVRHvIF2bogQH8A2/mvs3/ekvL5SXveOOpZPGRd5Ko6ODuf78Z8FCmTigRI
 VE9arrxamKXSyVMWvogHLrIRCaicr0tiawA7bI5RgG//dqqLnr+NgB/BYLsfX+taow4A
 XVu4YVA4O8jGn4nqgXexD2Ylss7fLVFBHCzqnGautlDpmjgWuu2RqoXSPYAK0HmtFhFA
 mik3BktQF4GsJsRMtkEJdIeu0eKiAIY30Wfnq7W+4aWMGE/GR+Rpg0SEFVVP2XLAJlfg
 yRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536239; x=1747141039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UFjE6L84i2a3K/oGJog+4yJiix6X/UtL4ANXLscMNKY=;
 b=CRCxLf7R40ywPuDxYlzjFRocg8JRWtFydkbueKXB98YItcGwATisJZ7NmhjzbIS34U
 ORhi4L92J+ZATbb6nzQL2UF172Pkh2ZnQk5tUWS/adEyw7SM+G/ob5vQvbMzVcEm85m5
 fN/5MCNXt39VIPrSF5xHuH2Ff7paPczUgRfq06nzrKraMUM4Uz7HQt7XtmXJ1SqSFQo6
 RQhBb5+Vbhs/3LqVp5vNju/S7fF3v+q87DPr2MoghcidWcM0r2LLWo7a8X36XpVp1Lpd
 ssBj5gwp1y3XbhNyPNb+4i9CJ5vFaWjZ6D/vD1QvoeBvw1wT0CT5h8Q7B41JofUVXUdF
 wIAA==
X-Gm-Message-State: AOJu0YwlgUGDGv/Tn75jhSLSylbme4fq3K1j5osCxjO4s5QLt+r2X7ia
 yJcSTMhM47pj53q7nXS/8C8BOkdFq7B0QRfvY5jv5q1rVkUMzAxm7d7UHusNDM0=
X-Gm-Gg: ASbGncsU2rZBsJ+RRnfluCTJnglsybVmUQ1sDFt2p6xVu2lCHnIS2Hlh88pEtjN4qne
 X00CR5iwv6KZnRn+yET/1gJzSgvYYzEbX8QVbZdbizD3e0a9A5e/bjTeEWafgshfnEGMDIPY6lO
 xDVzGum0dkHjoRHUvByc80ZdikiQRw6Vu49+036n/lojBRQ8wq6Q+iPHPQF9VRuSarThpylVvet
 alo1OJKb/hyoFKzMnNzfUuzT5ov9ECUACyEuvFyUPZ91FTJJINSLUFC+NDgsLwXVzi3KYbEIz1Q
 SBCxAXyqPntjxaOih2K/FZhlE6Ud2Cuw/V7cKZ5/HEY=
X-Google-Smtp-Source: AGHT+IHuiSIipYpZKVfjR1a4L3Fg175lWW2ugsK+KdsJF61ysQuGwylESp/y58ilmB2q0tiejcANjg==
X-Received: by 2002:a05:6402:26d5:b0:5e6:e842:f9d2 with SMTP id
 4fb4d7f45d1cf-5fab05e0922mr8977030a12.29.1746536238714; 
 Tue, 06 May 2025 05:57:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa777557aesm7474495a12.12.2025.05.06.05.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1A6AE5F8BD;
 Tue,  6 May 2025 13:57:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 00/14] Maintainer updates for May (testing, plugins,
 virtio-gpu)
Date: Tue,  6 May 2025 13:57:01 +0100
Message-Id: <20250506125715.232872-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now the tree is open here is the state of my current maintainer
queues. I've tagged the virtio-gpu changes as Cc: qemu-stable but
given how close to release we were it didn't seem worth rushing them
in for 10.0. I've included a MAINTAINERS patch just to make sure I can
route any more fixes until a more full time maintainer volunteers.

For v2
  - addressed various comments (see bellow --- in commits)
  - added Akihiko/Dmitry as virtio-gpu reviewers

The following still need review:

  MAINTAINERS: add Akihiko and Dmitry as reviewers
  MAINTAINERS: add myself to virtio-gpu for Odd Fixes
  tests/tcg: make aarch64 boot.S handle different starting modes
  tests/docker: expose $HOME/.cache/qemu as docker volume

Alex.

Alex Bennée (8):
  tests/docker: expose $HOME/.cache/qemu as docker volume
  gitlab: disable debug info on CI builds
  tests/tcg: make aarch64 boot.S handle different starting modes
  contrib/plugins: add a scaling factor to the ips arg
  contrib/plugins: allow setting of instructions per quantum
  MAINTAINERS: add myself to virtio-gpu for Odd Fixes
  MAINTAINERS: add Akihiko and Dmitry as reviewers
  hw/display: re-arrange memory region tracking

Dongwon Kim (1):
  ui/gtk-gl-area: Remove extra draw call in refresh

Manos Pitsidianakis (2):
  virtio-gpu: fix hang under TCG when unmapping blob
  virtio-gpu: refactor async blob unmapping

Nabih Estefan (1):
  Running with --enable-ubsan leads to a qtest failure

Peter Maydell (2):
  docs: Create a uniquelabel Sphinx extension
  docs: Use uniquelabel in qemu-block-drivers.rst.inc

 MAINTAINERS                               |   5 +-
 docs/about/emulation.rst                  |   4 +
 docs/conf.py                              |   1 +
 docs/devel/codebase.rst                   |   2 +-
 docs/sphinx/uniquelabel.py                |  74 ++++++++++++
 docs/system/qemu-block-drivers.rst.inc    |   2 +-
 include/system/memory.h                   |   1 +
 contrib/plugins/ips.c                     |  46 +++++++-
 hw/display/virtio-gpu-virgl.c             |  60 +++++-----
 tests/qtest/libqos/igb.c                  |   4 +-
 ui/gtk-gl-area.c                          |   1 -
 .gitlab-ci.d/buildtest-template.yml       |   1 +
 tests/docker/Makefile.include             |  10 +-
 tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
 tests/tcg/aarch64/system/boot.S           | 135 +++++++++++++++++++++-
 15 files changed, 309 insertions(+), 40 deletions(-)
 create mode 100644 docs/sphinx/uniquelabel.py

-- 
2.39.5


