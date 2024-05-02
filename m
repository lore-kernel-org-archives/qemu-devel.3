Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B19FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 18:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2aro-0003C8-JC; Thu, 02 May 2024 14:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2arg-00039p-Eb
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:09:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2are-0003QA-Ca
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:09:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e5715a9ebdso69893485ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714673339; x=1715278139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eEKz2fdxb3Ho556vvKlYysLgP1Mh/cb34mGEE34PM3A=;
 b=H4Bgq4U6Qc/GpD9Pz23/PhQuD3NzBjCSgwFhclv+AauGQN4jxE1KOX05G4wdyk7npu
 9FjVWQUtmcS+3BnGOGGL4U6noUlUaT35xMLb24kPohaxw6MoKPgs9uPk+d5aZl44a26Z
 YlzbT6r1rAPKxDtjFeMLhx0ZgsgDV+YU0eYFLvYHyIvoySEYb63c0IFuPW2UXIIm5nbU
 aj+8Veup5Z6nWNPrQNcSfxeP5xQcK0ppC8qCEIiKaxhDnxfJn0v+N8pa3txUmpqUgJIp
 rfDKUiretq9uLbBg+44qggHPB4dI6YLGGjHx6uDY55VdPEUa/sV9nQuDEL5fgSfy4lOg
 5C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714673339; x=1715278139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eEKz2fdxb3Ho556vvKlYysLgP1Mh/cb34mGEE34PM3A=;
 b=wTiV1gK4s+EM+j/PAc1m1WqLaD7hl8bpQpvPNOJZITDqJXNR1RzOcxNS40AVAgBhu1
 60doFojdHPku6vgbPzv7NWHApKV/8M7z2+/lghBFBx8eYYjE/+ZApPFI8QWIQM+QiOJu
 knZ8Zm32ZKWeTYJ0qi7fBWfAjdZU+HLAeh4s7ONDptQe3BXisBpVISl5ZvigoTdNTx/5
 v+lh31Q99v+XNdQvlf8xxhi8nWYXMWGQQi8wENHrzYewKNFncEJEEobZNJJ4g3YvmtFe
 LxFi6YisrStzmvLvPILqzX0wnY0/1D3EmRfEXc2/JoDa6t6BrdPnOcjKEkuJi2wTehmB
 4iYQ==
X-Gm-Message-State: AOJu0Yzr0qreHjXj9HY9uq73A3chidsIa+RxDV21ZTD2nzKjl79e7rHn
 P1XKwRA1PDRUsfWJ+1pxsTSF8JwF+1XyoDFx4X3ZZRL4EqMz7oxQ/UI2vZiwT+HtrbaZyJ2i/f7
 nwRs=
X-Google-Smtp-Source: AGHT+IHx2YpOzGHvzwJbsQczCn52GRpr7jRkZzHnjSzUZc6RzAJ7UWHiyALc2a+JpokP1/koLtjdLw==
X-Received: by 2002:a17:902:d2c9:b0:1e4:cb0e:2988 with SMTP id
 n9-20020a170902d2c900b001e4cb0e2988mr504220plc.2.1714673339123; 
 Thu, 02 May 2024 11:08:59 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001ebd73f61fcsm1615605plg.121.2024.05.02.11.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 11:08:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 0/9] TCG plugins new inline operations
Date: Thu,  2 May 2024 11:08:38 -0700
Message-Id: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

v5
--

- rebase on top of master now that Richard's series was merged

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


