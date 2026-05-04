Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE731FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJvZi-0000sH-DZ; Mon, 04 May 2026 11:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZg-0000rj-MH
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:12 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZe-0006Ac-Pd
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:12 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-50fbd79350dso41870421cf.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777909869; x=1778514669; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1vHhLgOpSSecB+GLDLvGOAClEqIf11/Ypr94iVBHfL0=;
 b=a9CuE2IVITIIX8kG7PzU4j85e5qRLbw4zoJoGxxVylaA+40Wi8crFaIp1I6DNrIEXJ
 cQyldm1+KPA/my3MESivXnD9fE+EPN4ibqn2zkj0QdY8lFmoBcK90DxJydNpul+b/H+f
 3nbh9LqdyowjbGdoxg/eH8rQj/Hsv5uPzZr/P9ZabIRLJTh1SgWwB5bNUKZC8sUQjjLH
 0U6vDPdRBLcZ4w0zI1slEBPfLn0w08LVZqES/a2f6a8JqmKVjdQqp0AZfFL3UUrqtP51
 H1HzBAOs1Tq5TdpdDVFdg2Mnyt9UISndcdB0nbF8neiphVAYmUajbgffFdLKBltrXJeX
 zuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777909869; x=1778514669;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vHhLgOpSSecB+GLDLvGOAClEqIf11/Ypr94iVBHfL0=;
 b=S8FaVsFZwBTF8MyGVGwAw1ANfTs0WnUOeg38Hk3gA/AavTcU0j/1AbtHw7cC5BHJvq
 kJNW2ixoNQrrtBI/TEV+0O6LwBMakDExsqoIPE7jq7qgGaqmniGoW232leoTlJHzhvbc
 QV2xYuH3TdrNPLyxe53X2jTg2tmDXHWtYT7YMWoarODFe08dlDYn/KNZ67yGGTKLyfG+
 ZCWI9ZIBpw5RB3Ud9QmIUVJ9b47xs+VqUdrGPR+0xU1p/1XhFzEAzYgZfPRPa+QYgRMX
 V//G98vaW2Ru3Ijsc1dY195NWcKVbiU9SaihVH8hSN0X61NGIq9E63xKFQo3tlcLVOEQ
 xN8A==
X-Gm-Message-State: AOJu0Yyfs+ETdGr62FgC4mfdm6vcrNhKE52zyYdEhbod8Y+cMlsqO5SI
 u7XiHM0RyAesaj6GOCeL9qNfhZe7FStpiSCBZ+pb3MnypPlWiEyKorhk
X-Gm-Gg: AeBDies5Cbv/579Vp5HkhgxN+i2YjyXj9D9JIkhC+yF2QZS8oswA6MBLA1yPZEvKe4S
 7fEA1iTaBErHIBBefZ/uzuqXWo1mcXvHuS1NMBZ9HAwrDpm/GiPqA8XmcS0nga/Ugnear45KE6a
 EqBEMJzPYqpLYab7mxI9Go1Nv4BIH1tdXmYgvpyZovmdi65D6BHoZvWpqDk419GaAzVHVaZ6JCB
 0WVTHT7pjAYk5escXDV52vI9AewIdvi7By7Ua8zeiCoVSMfuq22FlZRfWwczjeIOylyHfSqrtW2
 h/GxnZ9HsrFgtm2azJBwh4xTuogUl6KwJaqfup8/kjyYr+/WcT/rsBpuPd98I1JL7feW7X/qLKo
 CoQcGj7dpC73jEbBVopJEuh9/Ju7aN/KYcDqPFSeVsWRVd8nFaK0LA50QteoJ8wKubzmRkCwS5z
 eWchd067zCTE4PVHTq0+GiAduMyAU8Q1Eo9F1vJC+njeS3UZhHX2Q=
X-Received: by 2002:a05:622a:4d4a:b0:50d:a6a0:8f04 with SMTP id
 d75a77b69052e-5104bf9a9d0mr156063051cf.42.1777909868520; 
 Mon, 04 May 2026 08:51:08 -0700 (PDT)
Received: from [192.168.1.164] ([2600:1009:a021:c665:5296:905f:3e4a:eb90])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040931552sm99599011cf.12.2026.05.04.08.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 08:51:07 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Subject: [PATCH v5 00/15] target/arm: add support for MTE4
Date: Mon, 04 May 2026 11:50:33 -0400
Message-Id: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13P3W7CMAwF4FdBuV5Q4vwRrngPtAuvdUqklaK2i
 kBV330GDS3r5bH9HcmLmGjMNInjbhEjlTzl4crBfexEc8FrRzK3nAUocFqrKBPhLPuZrPTBKvS
 8oIMRfH8bKeX7q+v8yfmSp3kYH6/qop/T3xatq5aipZIBKLkmQfApnroe8/e+GXrxbClQS19LY
 BkxaICvkDD4rTRv6ZVWrpaG5cGjamOkBGS30v5J8+/nYlm2iEmZ4Pj3tpbruv4AKRvEEFABAAA
 =
X-Change-ID: 20251109-feat-mte4-6740a6202e83
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909867; l=5358;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=vkM8MTwAC7Qh0VqBIvcRvwtzVXpQlBcOPy5g2DnK9Xk=;
 b=NdxR7soFVnAv2MRyhSNqm/QYxwg1zpS6z4pMbBt4sloJfICyX/UY3NAXrqM01xN0WquxruE3d
 eWW4NM7QnokAlV7tOddo0UkZX+xJER43lH7ukX0c+0wZgUAW4Ddd0ZR
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
  - The MTE_CANONICAL/NAT test from v2, modified so MTE_CANONICAL is
    enabled in user mode (removed from tree in v3).
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
Changes in v5:
- MTX check feature split into three commits as per Richard's suggestion
- MTX passed down to instruction helpers in a new argument
- allocation_tag_mem_probe checks for probe in MTEPERM case
- tbi helper combined into tbi_or_mtx_helper
- MTX checks added to sme and sve functions
- bug with type conversion in LDGM helper fixed
- fixed multi-page tag-check bug and multi-page ST2G bug
- removed erroneous changes to _stub functions
- reorganized PAuth & MTX interactions to make them more readable
- Link to v4: https://lore.kernel.org/qemu-devel/20260309-feat-mte4-v4-0-daaf0375620d@gmail.com

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

To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Helge Deller <deller@gmx.de>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

---
Gabriel Brookman (15):
      target/arm: implement MTE_PERM
      target/arm: add TCSO bitmasks to SCTLR
      target/arm: mte_check unemitted on STORE_ONLY load
      linux-user: add MTE_STORE_ONLY to prctl
      target/arm: emit tag check when MTX without TBI
      target/arm: add MTX to MTEDESC and DisasContext
      target/arm: add canonical tag check, mtx helpers
      target/arm: add canonical MTE check logic
      target/arm: load on canonical tag loads ext bits
      target/arm: fault on tag store to canonical tag
      target/arm: skip tag bit bounds check if MTX is on
      target/arm: tag is not a part of PAuth with MTX
      docs: add MTE4 features to docs
      tests/tcg: add test for MTE FAR
      tests/tcg: add test for MTE_STORE_ONLY

 docs/system/arm/emulation.rst        |   5 +
 linux-user/aarch64/mte_user_helper.c |  11 ++-
 linux-user/aarch64/mte_user_helper.h |  14 ++-
 linux-user/aarch64/target_prctl.h    |   6 +-
 target/arm/cpu-features.h            |  15 +++
 target/arm/cpu.h                     |   5 +
 target/arm/gdbstub64.c               |   2 +-
 target/arm/helper.c                  |  36 +++++--
 target/arm/internals.h               |  40 ++++++--
 target/arm/ptw.c                     |  54 +++++++++--
 target/arm/tcg/cpu64.c               |   8 ++
 target/arm/tcg/helper-a64-defs.h     |  16 ++--
 target/arm/tcg/helper-a64.c          |   7 +-
 target/arm/tcg/hflags.c              |  25 ++++-
 target/arm/tcg/mte_helper.c          | 176 ++++++++++++++++++++++++++++++-----
 target/arm/tcg/pauth_helper.c        |  18 +++-
 target/arm/tcg/sme_helper.c          |   4 +-
 target/arm/tcg/sve_helper.c          |   6 +-
 target/arm/tcg/translate-a64.c       |  45 ++++++---
 target/arm/tcg/translate.h           |   3 +
 tests/tcg/aarch64/Makefile.target    |   2 +-
 tests/tcg/aarch64/mte-10.c           |  49 ++++++++++
 tests/tcg/aarch64/mte-9.c            |  48 ++++++++++
 tests/tcg/aarch64/mte.h              |   7 +-
 24 files changed, 512 insertions(+), 90 deletions(-)
---
base-commit: 3d626609ccae61a2e552bccd59c7a0931bab8261
change-id: 20251109-feat-mte4-6740a6202e83

Best regards,
--  
Gabriel Brookman <brookmangabriel@gmail.com>


