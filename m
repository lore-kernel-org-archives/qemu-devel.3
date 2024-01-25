Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E82BC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5cn-00024u-Ox; Thu, 25 Jan 2024 14:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3urmyZQwKCi0WJKRQNbcNOJWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--nabihestefan.bounces.google.com>)
 id 1rT5ck-00023t-Cp
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:42:55 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3urmyZQwKCi0WJKRQNbcNOJWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--nabihestefan.bounces.google.com>)
 id 1rT5ci-00059l-No
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:42:54 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5efb07ddb0fso1338847b3.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 11:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706211770; x=1706816570; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RE/3JoHzY0ENC2M39RmHGWz5L8Hwbqcg5HsGR6P7uBc=;
 b=zyhcGROYu7VHToIjf+92ipmOJ5GUarF+NqIpuaiwVFAJgaANyVo0yedtL4/doRWolK
 IwxHfP5Pyb3vEmWsTfMtmEmP4ce41WKTbuQUlLTC9ddX8XnbxvtXPjYcHi8ML04wB4TQ
 Zj7FypgKZQC1Iw+HRvXCuHidA5bspXCdbPV5wb5HFZ0B5m9FLjHxhK990EcDQBGNrR3a
 du1XcCl8Eyn0C+fNjjqVIbLzfOuNWlh1lZuoosqCSW75pPJnQgSn95j4fGLQpsCg+f60
 J4D3MdsmqEGzUSdftq8Tx3HYnqrkYry8Ugs5zrjRSUjyvhYIRe+FLwO/3pCcdF2cPMX3
 D8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706211770; x=1706816570;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RE/3JoHzY0ENC2M39RmHGWz5L8Hwbqcg5HsGR6P7uBc=;
 b=sZof+hbIYupbblh1Ld34NNwAjmiWmyzda2ohJR+xnD+K1/X3H4M/Eht2shfvfStowh
 B+dF6gENVE8cS+MSzMmakZ9fp6/i/NUaoE9Xw2rnWiPRAg7vlqImCpdrWfXtvFh7TeEe
 +TKachN+gj8F/K/e1cNBjbMpTlwdpo0BhmpKDijVc/Cu/gJsYAaNXi88NCuTUeXDZNne
 lXNfDZxno/nsa+5SmVzElY+A4SCRkTlPbPunyPePmc4lx7WKFw/85yGgiafaYOXBzIVO
 0nJ1QgDKngkeDAzBBpq6eKfRRnGwgqBWBcWNugdIqKSF8nFe9DdTaL/1O4U+Qks5REVx
 xWbQ==
X-Gm-Message-State: AOJu0Yyeb5IcyxHz2EgrTshnQbgI5lmJpPKMyVU7e6OKUgEoApfffyEb
 UPzoQklDVDA1s/SqhkSRQ6AwiX5Zz789Dzqb2UZ3O5PcK95i/rXjNO7IhVT67eTuxQfyaRKjygc
 P7dKe0VrMrdeajzwYZQJFagaB9A==
X-Google-Smtp-Source: AGHT+IFcsIwlrvdMCKg66IYCaRmQ/Z7fV0JC6qVYW53VZ4iBaSM80vWPwvYHjD1oD+OeErz3+IUd3IcMOuVlT0GAEB4=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:1b8b:b0:dc2:2847:b34a with
 SMTP id ei11-20020a0569021b8b00b00dc22847b34amr36088ybb.9.1706211770356; Thu,
 25 Jan 2024 11:42:50 -0800 (PST)
Date: Thu, 25 Jan 2024 19:42:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125194247.1589037-1-nabihestefan@google.com>
Subject: [PATCH v15 0/9] Implementation of NPI Mailbox and GMAC Networking
 Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3urmyZQwKCi0WJKRQNbcNOJWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Nabih Estefan Diaz <nabihestefan@google.com>

[Changes since v14]
Expanded comment on chardev device and fixed comment formatting

[Changes since v13]
Added a couple clarifying comments and documentation about chardev
device expected protocol for ease of review.

[Changes since v12]
Fix errors found when testing in big-endian host.

[Changes since v11]
Branch couldn't be merged with master because of issues in patchset 6.
Fixed.

[Changes since v10]
Fixed macOS build issue. Changed imports to not be linux-specific.

[Changes since v9]
More cleanup and fixes based on suggestions from Peter Maydell
(peter.maydell@linaro.org) suggestions.

[Changes since v8]
Suggestions and Fixes from Peter Maydell (peter.maydell@linaro.org),
also cleaned up changes so nothing is deleted in a later patch that was
added in an earlier patch. Patch count decresed by 1 because this cleanup
led to one of the patches being irrelevant.

[Changes since v7]
Fixed patch 4 declaration of new NIC based on comments by Peter Maydell
(peter.maydell@linaro.org)

[Changes since v6]
Remove the Change-Ids from the commit messages.

[Changes since v5]
Undid remove of some qtests that seem to have been caused by a merge
conflict.

[Changes since v4]
Added Signed-off-by tag and fixed patch 4 commit message as suggested by
Peter Maydell (peter.maydell@linaro.org)

[Changes since v3]
Fixed comments from Hao Wu (wuhaotsh@google.com)

[Changes since v2]
Fixed bugs related to the RC functionality of the GMAC. Added and
squashed patches related to that.

[Changes since v1]
Fixed some errors in formatting.
Fixed a merge error that I didn't see in v1.
Removed Nuvoton 8xx references since that is a separate patch set.

[Original Cover]
Creates NPI Mailbox Module with data verification for read and write (internal and external),
wiring to the Nuvoton SoC, and QTests.

Also creates the GMAC Networking Module. Implements read and write functionalities with cooresponding descriptors
and registers. Also includes QTests for the different functionalities.

Hao Wu (5):
  hw/misc: Add Nuvoton's PCI Mailbox Module
  hw/arm: Add PCI mailbox module to Nuvoton SoC
  hw/misc: Add qtest for NPCM7xx PCI Mailbox
  hw/net: Add NPCMXXX GMAC device
  hw/arm: Add GMAC devices to NPCM7XX SoC

Nabih Estefan Diaz (4):
  tests/qtest: Creating qtest for GMAC Module
  hw/net: GMAC Rx Implementation
  hw/net: GMAC Tx Implementation
  tests/qtest: Adding PCS Module test to GMAC Qtest

 docs/specs/pci_mbox_chardev.rst     | 159 +++++
 docs/system/arm/nuvoton.rst         |   2 +
 hw/arm/npcm7xx.c                    |  53 +-
 hw/misc/meson.build                 |   1 +
 hw/misc/npcm7xx_pci_mbox.c          | 335 ++++++++++
 hw/misc/trace-events                |   5 +
 hw/net/meson.build                  |   2 +-
 hw/net/npcm_gmac.c                  | 939 ++++++++++++++++++++++++++++
 hw/net/trace-events                 |  19 +
 include/hw/arm/npcm7xx.h            |   4 +
 include/hw/misc/npcm7xx_pci_mbox.h  |  81 +++
 include/hw/net/npcm_gmac.h          | 340 ++++++++++
 tests/qtest/meson.build             |   2 +
 tests/qtest/npcm7xx_pci_mbox-test.c | 242 +++++++
 tests/qtest/npcm_gmac-test.c        | 341 ++++++++++
 15 files changed, 2521 insertions(+), 4 deletions(-)
 create mode 100644 docs/specs/pci_mbox_chardev.rst
 create mode 100644 hw/misc/npcm7xx_pci_mbox.c
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
 create mode 100644 tests/qtest/npcm_gmac-test.c

-- 
2.43.0.429.g432eaa2c6b-goog


