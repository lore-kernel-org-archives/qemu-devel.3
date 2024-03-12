Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71896C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 07:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjwyO-0001wx-Ns; Tue, 12 Mar 2024 03:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rjwyM-0001wd-Qc
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:54:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rjwyL-0003cZ-8S
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:54:54 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e959d8bc0so1761472f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710230091; x=1710834891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aV8YuU7WEijoOBCxsiWGl1C9Vof5bYJZHCBIlqB4nFE=;
 b=wc/aipDithQuV6B19QxtMiaetolgNovLPd9Ytb/E2UZZlg53eu41Xuoo2yO+bfUwid
 vc2UooQkqb6FSNIjgBmJG5cJ0VHHX9NHNSlPwRBBSfD/fpI7zBUx7z876mcGBoTSZgmx
 GpZiQUgUmVVs98E3LZ+ez2YeXoMOdHyJTrRAx2/d1fnnqftFXz+pvav0I1bHM8NZFrIw
 nK90DeIVDM+xdrWVAd4aUhRO0Vih4+euHrToH1FQyhz/Djz6SMx2JNJT1zh0lo11V4T8
 8DvnAKQD2ya/8jLEJzvqtVJfg0mHWuNQL8R0yti2dVgdVffdNpah7sv/V8g4lvt8waGy
 ia5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710230091; x=1710834891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aV8YuU7WEijoOBCxsiWGl1C9Vof5bYJZHCBIlqB4nFE=;
 b=Gn8ijqCYeCRPw8/rROn5dW++61PClRnM81+TipGtzuxVPI/xBcL30Hiq1mhSMDokYt
 XCX64h8TBdNgVWkHtoBnXNnmE37sIX8kB2awHaghoBDB7fQll9d7EyBXrYVatj/x1y07
 MAZmrFo6IrLRw/exGWLY70VjqiMb07HpCR3etBy0OQwGBmX28q5AB5dZDv8dFmf2j8Wp
 OyZpOc7SeoCd0xm1W9w+JvrHVCXZzFTX+WFsWsmEJ01JAv7HTFZBgPzpcaJ4vvT6XB5z
 Mi2C2/IcQ7sdWGbDVodqzjQiPrXu6CEtPa5qG5Num7HPNK0VdhLatEp8y/0sOcZxpMxz
 CXNg==
X-Gm-Message-State: AOJu0YwGHjGW2Q0dgTbi8mfwxp/wd5DTBJTmmFIjAwS0JRuKnkTD1U8F
 AqlSouXnJ/iKYZHtY78laehk9zqJ5aZhAJxmt55M6T5t/2CKIanDkiyFohRPPCl2pVSS+ke6ctT
 SKDU=
X-Google-Smtp-Source: AGHT+IEfOnRoMseWTJFWLd+bYYiEjtdM5TbOjWRIhVhrL7q8PLvAqEMMAYWUSFz8+z3+XAeLZzg/eg==
X-Received: by 2002:adf:ea0f:0:b0:33e:7ae6:6f4a with SMTP id
 q15-20020adfea0f000000b0033e7ae66f4amr5993630wrm.23.1710230090697; 
 Tue, 12 Mar 2024 00:54:50 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u12-20020a5d6acc000000b0033e7a499deasm6108795wrw.109.2024.03.12.00.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:54:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 0/5] TCG plugins new inline operations
Date: Tue, 12 Mar 2024 11:54:23 +0400
Message-Id: <20240312075428.244210-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x434.google.com
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

Pierrick Bouvier (5):
  plugins: prepare introduction of new inline ops
  plugins: add new inline op STORE_U64
  tests/plugin/inline: add test for STORE_U64 inline op
  plugins: conditional callbacks
  tests/plugin/inline: add test for condition callback

 include/qemu/plugin.h        |  10 +-
 include/qemu/qemu-plugin.h   |  80 +++++++-
 plugins/plugin.h             |   9 +
 accel/tcg/plugin-gen.c       | 359 +++++++++++++++++++++++++++++++----
 plugins/api.c                |  76 +++++++-
 plugins/core.c               |  28 ++-
 tests/plugin/inline.c        | 130 ++++++++++++-
 plugins/qemu-plugins.symbols |   2 +
 8 files changed, 635 insertions(+), 59 deletions(-)

-- 
2.39.2


