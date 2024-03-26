Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD05CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp60u-00056j-L5; Tue, 26 Mar 2024 08:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp60s-00055n-8n
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:34:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp60q-0000d3-L3
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:34:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4148f00fa66so5021585e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711456482; x=1712061282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=svUOsYaO6p9SY9abVfjJdsXNvOCTqKkw1oua4oYqZig=;
 b=BHio45ZAsoeaKjNRdxqWSZrWL42sXrZiKfx9Fhf9QXbR5Kj+QVh22SwEB0c57aZMol
 7o8tT/RRpuT0dVNKYHvqeohdkeFdocohjow7BN5c1DpRHMGGyh6syys0lc6v1kk6tCC6
 sjVVqdYbtdT4yrflI7Ytr/QbeZWGGesq74YiMafxGHJ4mjPDz8n7Lnl04rMwX0q0j4rU
 s+lTHtgKOS9AoXxzo8J+z3RiOpdCXDv3Gnfrt6OjhQTbIGXShYa5jnfakf0oLCG/bi6Y
 O4pFuAfB5FxdGs2wUW2doypp3CZRO6/NLQwBY/VT9qii7UO5d6FE09/0yVdX7zD6GRju
 d5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456482; x=1712061282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=svUOsYaO6p9SY9abVfjJdsXNvOCTqKkw1oua4oYqZig=;
 b=qjrhF0wlpTGk4/4waAtmU06hrfawL8on+tJ5K8+//6BZzqtSaPYOQ867HRa5KhLGfT
 x0NXE89O9ANfeFhTxH4xzn9JAqPtqTKmhjdrm++5pxg5akBUXjtOTGAU59z/ncUeHQVc
 iKy9UU0vr/B3YO0vtlnN9rOwEFNV8o2JGMDAEIYqC5lNz4sz0gzf6SmiZkDYxg2It02d
 W1PDt1/1LAfGKhyhG6FZ7VovZMiOzjPf2obmSUSf5agLxjTqRu83COPua4arOeJbo+05
 P10Gze0H5lbR4TzFkJ6JxFVyoJbEpLiqQ1jFgwbXMwtLGe/gQnbRoi7xlU1DpQaM8jV0
 DaIg==
X-Gm-Message-State: AOJu0YySabslcuY//JpnDkB2m3YTBt2STv7hSlfp4uAve2vMXVk5pR00
 idEACoX0qZmSqWwIwzvU3sYT9tUyhAsojpc7oD/HYWrIXa1zoGbfppxv+Nwzdn2JeV7BE0ZvKzu
 ajoU=
X-Google-Smtp-Source: AGHT+IFeO39Md14hAYeyibaCckZgJ17gWdFu5fyk5/2ZqTjKqDRiCiEG6d6U2q48tK6ZLhQA14ZU7w==
X-Received: by 2002:a05:600c:1c8d:b0:412:beee:36b3 with SMTP id
 k13-20020a05600c1c8d00b00412beee36b3mr9810309wms.7.1711456482258; 
 Tue, 26 Mar 2024 05:34:42 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 y19-20020a1c4b13000000b004148090cf85sm716317wma.0.2024.03.26.05.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 05:34:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 0/9] TCG plugins new inline operations
Date: Tue, 26 Mar 2024 16:34:17 +0400
Message-Id: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x335.google.com
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

NOTE: Two patches still need review

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


