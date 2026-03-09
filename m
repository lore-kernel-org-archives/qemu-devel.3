Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF327FCA198
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzien-00033Q-Tk; Mon, 09 Mar 2026 18:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzied-00030t-Ga
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:47 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzieb-0004Vk-13
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:46 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-798578e2918so111752057b3.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093643; x=1773698443; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N4Wwfj/vVoMg5oUUWgpXbRqS+o+g7cmoUtXUPT1Fpug=;
 b=e8I8LYOMWcAPd34iRL4u+tNwLVR+9ykolS4UMuKIXzKk+A2RMxzpgo6ojVvdBvMdMU
 2o1Hh+DAF89tRubbE1YIUY+BXuqbtgwjv0FJhc7oY34EYgLKt3eSOLFTTjL1sad4hRtD
 /1yZKSAoIOw82Pdk8nuocg8gnnPyaxq37N2kuzBuw5CwcriQj6eUsbfYczD7dudMoPYL
 7SdVpahRr4cfHQKXFXvjWZ5sU0RXvB32JHYDbNMlk1/qQwqGI6qr8hBmUyB/i0IiO2WQ
 zsecmXL+o8r+CIrixBLxE9RKLViA0qWfQP/5vc8xUvWUxCs1s+2nGiFlkqZ4P8UkL8Jb
 n7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093643; x=1773698443;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4Wwfj/vVoMg5oUUWgpXbRqS+o+g7cmoUtXUPT1Fpug=;
 b=tF+0G0NWgGVpmEi1pd76laxIcZuLQ58yUcWuuptwqb7n2asRjpgGrGgotONaFRI2LZ
 fJI+HpC1S75EzoQGHRg5m64ekpLuXUgrlqMqhr6bG74igqyxZsfRMTb4Ie/GgdGb6gTA
 Kc7yLfI2101RX0wg09lCrx6VwAONP21xXEqd3J7Jp/gINQln1KY50i/wrv2S4TGIJxyr
 mdVH5gdsAGlEufycQTnC66Q/ubmyrPdRaKhudMyPuCGTCpaiJJ6QCYofbVHk3yqC/9B8
 qQ5X2gBz1RrQoN0g/EXgj85q9dOqN8N40psc4L+QKgbj3yrxy8g4rYE9aAXLb8wbukNL
 ydag==
X-Gm-Message-State: AOJu0YxaCTOB29fwYghGCrkdmHn7pJQBf0J/0jLRq8CoaK+CSP7tpUAU
 FC4jOqM8PDzFr6grPwhe8u8fTCaQFlrWzfeWL94AQT1PKH2icCFN1Kap
X-Gm-Gg: ATEYQzyImNDNWrnnTgef0+HJpZjKOAfm5NazNc3VEGREO8E7qwvrsf1l1c3xcT6B27o
 zokrdmSJE5TbewhyuctN0lNhK7VWcNfSw1EpUJmpz/MEwWln1o+NXTLMSi4IXA0kVEaLte1ru9T
 Ac41vAarRSrR/2SmyBRJWl5MTd6c8kZ900ecRGh3WcRXgiasKZkd/evweb7DXOevTMQKsf7VDs1
 JbGGOpFqFP2tB/aAzZCXrVuMk5OrWFm4m2fmNg107o3PKXqf0Bv1xBvw/qZFWlhbHOYUG4ogIjq
 rZ1DbliZpG6Wlxw0wN/n7MOcRegHPOJtCHtoQj95JMzABapmBf4rWqfyo4T/23d0KCsis/2jo2a
 5Ulzs3ESL8JpJMwDGO5UL8KF5flwiTZXKbCuU8eoxSG+TIao8yVOKeJDehBZmM9Q/cBjNfX+Zxx
 bRQLw08RPTvN1QloN15qaIWxZYz10Z5EAyoW0=
X-Received: by 2002:a05:690c:a:b0:798:6d23:17d3 with SMTP id
 00721157ae682-798dd7d130dmr117696157b3.61.1773093643351; 
 Mon, 09 Mar 2026 15:00:43 -0700 (PDT)
Received: from [172.26.74.149] ([185.213.193.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7990a54ba7csm5218437b3.19.2026.03.09.15.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:00:42 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Subject: [PATCH v4 00/13] target/arm: add support for MTE4
Date: Mon, 09 Mar 2026 17:59:32 -0400
Message-Id: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13M0Q6CIBTG8VdpXEfjHBGkq96jdUF6ULbUJo7Vn
 O8eutpYlx+c339hgSZPgZ0PC5so+uDHIQ15PLC6s0NL3DdpMxRYAgjDHdmZ9zNJrrQUVqUPqgq
 W7p8TOf/aW9db2p0P8zi993SE7fVbAcgqEbjgGsmVtUOtnLm0vfWPUz32bKtEzKXKJSZprAbEu
 3ZWq39Z/KQSIMpcFklWyorGGHJIMpfrun4A9TmS/hYBAAA=
X-Change-ID: 20251109-feat-mte4-6740a6202e83
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773093641; l=4230;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=YLsTBmR+T6Im8vWta8XT7OnA29TU8u5HBdzDlapLc0Q=;
 b=wmoPsQsgI5zV1geQjd6uMOxdelz45Ng7kQ0eMmLP0SmuQtbYxUp7cQmj2JdOw6IIa6vg2CQn7
 0mLUfenGNWIArM0uASNQOOe3cA6A6azIFc0hQPojKPThnr9xbzEfoDe
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=brookmangabriel@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series implements ARM's Enhanced Memory Tagging Extension
(MTE4). MTE4 implies the presence of several subfeatures:
FEAT_MTE_CANONICAL_TAGS, FEAT_MTE_TAGGED_FAR, FEAT_MTE_STORE_ONLY,
FEAT_MTE_NO_ADDRESS_TAGS, and FEAT_MTE_PERM, none of which are
currently implemented in QEMU. This patch implements all five.

Testing:
  - Included for FAR and STORE_ONLY.
  - The MTE_CANONICAL/NAT test from the previous email, modified so
    MTE_CANONICAL is enabled in user mode.
  - A bare-metal testsuite that sets up page tables for S1 and S2
    translation, to test the Tagged NoTagAccess fault.
  - The bare-metal testsuite also was used to test LDGM and similar
    instructions not permitted in user-mode.
  - The bare-metal testsuite also was used to test the mtx related
    patches.

Thanks,
Gabriel Brookman

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3116
Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
Changes in v4:
- MTX now interacts with PAuth.
- Canonical tag checking only takes place in canonically tagged regions
- MTX bits enable tag checking
- MTX bits are placed in MTEDESC for access in mte_check helper
- Separate feature bits are used to delineate each feature
- PRCTL functions renamed and refactored as per Richard's suggestion
- Link to v3: https://lore.kernel.org/qemu-devel/20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com

Changes in v3:
- Added prctl for MTE_STORE_ONLY to linux-user
- mte_check is no longer generated on read when STORE_ONLY enabled
- Implemented LDGM instruction
- Removed "long" datatype as per Richard's suggestion
- Implemented masking for VA range checks when MTX bit enabled
- Implemented MTE_PERM, with NoTagAccess attribute
- Removed user-mode test for MTE_CANONICAL, since can't enable in
  user-mode.
- Removed TBI from mte_check generation logic
- Link to v2: https://lore.kernel.org/qemu-devel/20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com

Changes in v2:
- Added tests for STORE_ONLY.
- Refined commit messages.
- Added FEAT_MTE_CANONICAL_TAGS and FEAT_MTE_NO_ADDRESS_TAGS + tests.
- fixed TCSO bit macro names.
- Link to v1: https://lore.kernel.org/qemu-devel/20251111-feat-mte4-v1-0-72ef5cf276f9@gmail.com

---
Gabriel Brookman (13):
      target/arm: implement MTE_PERM
      target/arm: add TCSO bitmasks to SCTLR
      target/arm: mte_check unemitted on STORE_ONLY load
      linux-user: add MTE_STORE_ONLY to prctl
      target/arm: tag check emitted when MTX and not TBI
      target/arm: add canonical tag check logic
      target/arm: ldg on canonical tag loads the tag
      target/arm: storing to canonical tag faults
      target/arm: with MTX, no tag bit bounds check
      target/arm: with MTX, tag is not a part of PAuth
      docs: add MTE4 features to docs
      tests/tcg: add test for MTE FAR
      tests/tcg: add test for MTE_STORE_ONLY

 docs/system/arm/emulation.rst        |   5 ++
 linux-user/aarch64/mte_user_helper.c |  11 ++-
 linux-user/aarch64/mte_user_helper.h |  14 +--
 linux-user/aarch64/target_prctl.h    |   6 +-
 target/arm/cpu-features.h            |  15 ++++
 target/arm/cpu.h                     |   5 ++
 target/arm/gdbstub64.c               |   2 +-
 target/arm/helper.c                  |  36 ++++++--
 target/arm/internals.h               |  47 +++++++++-
 target/arm/ptw.c                     |  53 +++++++++--
 target/arm/tcg/cpu64.c               |   8 ++
 target/arm/tcg/helper-a64.c          |   9 +-
 target/arm/tcg/hflags.c              |  25 +++++-
 target/arm/tcg/mte_helper.c          | 164 ++++++++++++++++++++++++++++++++++-
 target/arm/tcg/pauth_helper.c        |  14 ++-
 target/arm/tcg/translate-a64.c       |  15 +++-
 target/arm/tcg/translate.h           |   3 +
 tests/tcg/aarch64/Makefile.target    |   2 +-
 tests/tcg/aarch64/mte-10.c           |  49 +++++++++++
 tests/tcg/aarch64/mte-9.c            |  48 ++++++++++
 tests/tcg/aarch64/mte.h              |   7 +-
 21 files changed, 497 insertions(+), 41 deletions(-)
---
base-commit: de61484ec39f418e5c0d4603017695f9ffb8fe24
change-id: 20251109-feat-mte4-6740a6202e83

Best regards,
-- 
Gabriel Brookman <brookmangabriel@gmail.com>


