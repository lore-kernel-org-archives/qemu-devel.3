Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5327EC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 21:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2dmH-0008KW-Et; Thu, 02 May 2024 17:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmF-0008J0-Sp
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:39 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmE-0002nx-56
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:39 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-36c0ef5f7ebso37791035ab.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714684535; x=1715289335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4oV0Bq5JAyOVtAmAE/+atb+/0axiHuyH+IUkyLsJWWY=;
 b=ATavs0YOPqU33wc56JB5XSkJmqlkRQ6i0b9hjHucRvPDyTaczLO5qco5YTsQfX1O8n
 6WunhNwNNqSBiI48rYmo8XR5E7WN8eV8M8boAXGfesyh1aUns2253YhC4TxaP99j0yH+
 e252Aa2QWpSqmyt+RWtqnwUGrSRyY5iccHKBRaKn5U2TlBND9tu7gm6qfMXrfUecPiX0
 8Hfau/R0HRa8remln+SyBQBaJW83Kb/d6Vs3tJi1Gs+MZAzGqbiMGocmrgUmZ9O8k7yo
 fZkSaWSDrsLPBQlNDDptA5yJaSRg8be5pb5Qcef3v5Gs0aE8v8Y9B5+edeiEtdOLkdRj
 T1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714684535; x=1715289335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4oV0Bq5JAyOVtAmAE/+atb+/0axiHuyH+IUkyLsJWWY=;
 b=cj/yLqG+H6U2DtyDZY+KnbJpPkwIku6OZDfyIpFaA572S0/RHSMkgHdDJdrO9nzxy6
 0mWO0ZIU0ICDLpFjh9t0egfcNIobjXrpTkqSAZQz+RXXd+jcFnwnsRBrxT9J433erpU2
 8xC44UoO/HAtETJKI1PU0RdGTWyCKgYZ3DdcRsJMCOPewwM4ur1BdXmwbovRHA7Wgcha
 CdQUWryFXdPIUQuH2WaMmJE98gqgkEw3xnT6PoN72sTxdpmB+FXuaUn25OvTxodqf14/
 CCficdELlLKcdGhKrEMEWA8/vPrscAJbrXSz4BvAx5FImRIaFLYferY6Qx+9nCH38B+P
 CR5w==
X-Gm-Message-State: AOJu0YwlhIc07rP3sNf9KvruH4XuRwcgaBXRI9aYPMNMLJKwyjPTjvJY
 TrlQUE4U/bEc0Pqr6hU7GU/OeOFVEP461kCwPaPXmKxM0lEf+7H055q2VDg6fz7FWjD2ZFvGhe7
 Mjrc=
X-Google-Smtp-Source: AGHT+IEK0CdH4M0GOajsJW6kTiVAew+rJKliu7dAVz/+t3tkhC35dkQdByhF+vjkf8i9goqx+9Fi9A==
X-Received: by 2002:a92:cd8b:0:b0:36a:ff3a:f135 with SMTP id
 r11-20020a92cd8b000000b0036aff3af135mr1240394ilb.15.1714684535596; 
 Thu, 02 May 2024 14:15:35 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a63f24e000000b0060063c4be3bsm1700915pgk.14.2024.05.02.14.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 14:15:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 0/9] TCG plugins new inline operations
Date: Thu,  2 May 2024 14:15:13 -0700
Message-Id: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-il1-x132.google.com
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

This series implement two new operations for plugins:
- Store inline allows to write a specific value to a scoreboard.
- Conditional callback executes a callback only when a given condition is true.
  The condition is evaluated inline.

It's possible to mix various inline operations (add, store) with conditional
callbacks, allowing efficient "trap" based counters.

It builds on top of new scoreboard API, introduced in the previous series.

v2
--

- fixed issue with udata not being passed to conditional callback
- added specific test for this in tests/plugin/inline.c (udata was NULL before).

v3
--

- rebased on top of "plugins: Rewrite plugin code generation":
  20240316015720.3661236-1-richard.henderson@linaro.org
- single pass code generation
- small cleanups for code generation

v4
--

- remove op field from qemu_plugin_inline_cb
- use tcg_constant_i64 to load immediate value to store

v5
--

- rebase on top of master now that Richard's series was merged

v6
--

- more elaborated commit messages

Pierrick Bouvier (9):
  plugins: prepare introduction of new inline ops
  plugins: extract generate ptr for qemu_plugin_u64
  plugins: add new inline op STORE_U64
  tests/plugin/inline: add test for STORE_U64 inline op
  plugins: conditional callbacks
  tests/plugin/inline: add test for conditional callback
  plugins: distinct types for callbacks
  plugins: extract cpu_index generate
  plugins: remove op from qemu_plugin_inline_cb

 include/qemu/plugin.h        |  42 +++++++----
 include/qemu/qemu-plugin.h   |  80 ++++++++++++++++++++-
 plugins/plugin.h             |  12 +++-
 accel/tcg/plugin-gen.c       | 136 +++++++++++++++++++++++++++--------
 plugins/api.c                |  39 ++++++++++
 plugins/core.c               | 109 ++++++++++++++++++++--------
 tests/plugin/inline.c        | 130 +++++++++++++++++++++++++++++++--
 plugins/qemu-plugins.symbols |   2 +
 8 files changed, 466 insertions(+), 84 deletions(-)

-- 
2.39.2


