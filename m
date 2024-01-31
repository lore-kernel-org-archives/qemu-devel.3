Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1384DC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 00:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUySV-00073O-CM; Tue, 30 Jan 2024 19:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3EpS5ZQwKClUAxy541FG12xA3BB381.zB9D19H-01I18ABA3AH.BE3@flex--nabihestefan.bounces.google.com>)
 id 1rUyST-00072A-MY
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 19:28:05 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3EpS5ZQwKClUAxy541FG12xA3BB381.zB9D19H-01I18ABA3AH.BE3@flex--nabihestefan.bounces.google.com>)
 id 1rUySR-0004II-W8
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 19:28:05 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6040d838ad7so377857b3.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 16:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706660882; x=1707265682; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=f40XfUUTa/tJMFfses+Lto4m+MDT9EIZ8dnUNgZSxqQ=;
 b=E5aeAYuJnRq639wuvUc/PEWsM+NIcgc5FIGenyQ98irtGpR82UlvonlNPV6yEOkCZ/
 jOuLRmgjSJLEvMcEIi8XmppvP4WDIbi8slt0p/rcM1SfHxS6HOxdJRvnY2AsnM/BzQs2
 LEqM0hqvtnaEK1nMGS/poUoF9bhFcdn5mpLKxv8AnV2oA6VLz7rbwx5rJj/2gJgM8BEh
 c2kZxQQgyD0GR48sjwiabgDtvTn0jrtrWayzgjWnmZIt9NSe+p7s/XExZZqLYVWlaaA7
 Li3ygGLrWmAuiqvzSMjdPZqFmdaBpXkJunKwMJLuKVuq6aIhlkJnkKmYWBCOjxsEL0ke
 qZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706660882; x=1707265682;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f40XfUUTa/tJMFfses+Lto4m+MDT9EIZ8dnUNgZSxqQ=;
 b=boTVhXea/K5a01g86n0B0zqiTTksxD4w/a4rSMdCKQu0HYHUG5Fnq1xZKu+vA7dbKf
 nrn+o3fPYG0D0IxUmrF4cezVqaicKgpW04IpteifJXzhDZjH5x350zUgkWuovsBDLDAP
 cYbYTJqnJcPyLgbw5SZtydUCN6S39WbX1t35qXVT/NenmcnG6rkVYIgiP3et6eQSOaQx
 B/ekO5R18nrPf6NKuQ8ko8d2EJE8UdSlrJm1xRFiyImOGVli9mZKr7OG3IXDrVrSJamb
 iScb+LB3vfxMs27CE0C+ZsiRL3TbfsP0gK6cI4w4IOfxoQKUT29MzXPFLtQyys8ue8mI
 yN7Q==
X-Gm-Message-State: AOJu0YzOoZdhRCeswnSGhPET4MumMrmyrHLSJQvMiTC1mhvbZdodVSqG
 xF0aqqA/p2nH+JWUsIKVySumkfsn9+4BWT8jtjnvu7ozujVKa/jee/HEL/RH0CL5m0bTj1leCB1
 YrjNRtmWf+w0a0M+8S9VvZ2wjJA==
X-Google-Smtp-Source: AGHT+IHdnzxTMnzlX5SaOtG8PEhS/LydgtP3fHmRiF3/RTeUqUQNsOSTJzd1wgT6HAYGVRRoAD23RmLczXZC6VyJLpM=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:690c:397:b0:5f9:abfe:243c with
 SMTP id bh23-20020a05690c039700b005f9abfe243cmr195847ywb.3.1706660882676;
 Tue, 30 Jan 2024 16:28:02 -0800 (PST)
Date: Wed, 31 Jan 2024 00:27:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240131002800.989285-1-nabihestefan@google.com>
Subject: [PATCH v16 0/6] Implementation of GMAC Networking Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3EpS5ZQwKClUAxy541FG12xA3BB381.zB9D19H-01I18ABA3AH.BE3@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

[Changes since v15]

Dropped PCI MBox patches. They were presenting a lot of problems with endianness and are not directly related to the GMAC. Breaking them apart to debug separately and let the GMAC itself be upstreamed faster.

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

Hao Wu (2):
  hw/net: Add NPCMXXX GMAC device
  hw/arm: Add GMAC devices to NPCM7XX SoC

Nabih Estefan Diaz (4):
  tests/qtest: Creating qtest for GMAC Module
  hw/net: GMAC Rx Implementation
  hw/net: GMAC Tx Implementation
  tests/qtest: Adding PCS Module test to GMAC Qtest

 hw/arm/npcm7xx.c             |  37 +-
 hw/net/meson.build           |   2 +-
 hw/net/npcm_gmac.c           | 942 +++++++++++++++++++++++++++++++++++
 hw/net/trace-events          |  19 +
 include/hw/arm/npcm7xx.h     |   2 +
 include/hw/net/npcm_gmac.h   | 343 +++++++++++++
 tests/qtest/meson.build      |   1 +
 tests/qtest/npcm_gmac-test.c | 344 +++++++++++++
 8 files changed, 1687 insertions(+), 3 deletions(-)
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 tests/qtest/npcm_gmac-test.c

-- 
2.43.0.429.g432eaa2c6b-goog


