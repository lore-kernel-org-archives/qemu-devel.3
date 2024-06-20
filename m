Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD8BC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHl2-0004mJ-2a; Thu, 20 Jun 2024 09:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cosocaf@gmail.com>) id 1sKEO7-0000ol-Ns
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:47:27 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cosocaf@gmail.com>) id 1sKEO6-0003zz-7g
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:47:27 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f4a0050b9aso5646105ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718876844; x=1719481644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0SWsQ+P9qcIwkDeO8cToOuTdDu6RLHW2I8drvdyHOUQ=;
 b=mtoif6vDy2C+lGg5lXA8sOsYk3TLCxPxXZPqRve8SfmlSDQCD1Dcky5j4/GW6hcsT3
 qnrpUwSSCS/cELZ621nB+q+FcGbVZufQZze/uyBlezELqt8tlTi675nyTuKCCAErHcry
 FcjSUJAli3QrC6qfr07a7DtWzNg2x633/ADFdMj9MZCfBitrXqtKxn8sPWBi8nsOsH0X
 GD2mxVw9aGZWT9+tPWr6Qs0Uw989ECgYAKkgeDj5ipbe7wcR5DTI2sChmYqJnjg/mFA3
 2fu555eSuOEb4kAkLSBxST6AHWwRj/TiLiarSHayHmCDF0IJwEi/pAoGvkYcmqBPrvtl
 NrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718876844; x=1719481644;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0SWsQ+P9qcIwkDeO8cToOuTdDu6RLHW2I8drvdyHOUQ=;
 b=u3dl9GoxmguuY2nppR+WGY81aNINdCC9vWl1WOCwea0hIbUhUjiKGwzWazEBeZpE7g
 4ZUCYEtzbL2QO7WXeASmDLLLMRUmuAs/55395lVRrmXKeSjOMnTddjEUHgfThS46K15r
 GTRia0yS1o/MyqQ62Uz99ysqFto+uunkw5JHFAoUZwW6AE6hm7jlijYGc82J28PiuvOk
 JH3EWPWWsQ883+I2ZpRrKNB8OBTT6NnfSesR/4TlHg4Bnbn0mDcFQiAchdBoWUefSMp4
 tKR63c+q72TN0G10kcSEvEkV6sVdib1IdJOkhoD5C+NB1ucO+N4pmJGdeH4yBZxyd1GI
 4zCg==
X-Gm-Message-State: AOJu0YzuoaJaJcYDW/+OjfCewSqPnIdDMUnxXDRLPCKYZjovXJqd9zBu
 Wvq2pHasrVpPrVS0ZD9IIzGurjugt9UD+4ir7wY0F5nVEnOWmVmpvp0EoiGM
X-Google-Smtp-Source: AGHT+IEx7j3hxYnmxH2dvgGRg3pgdpjkUXhCBYY/MLGjTrmFPDyK66tMBlNlLrx1koU0MU53/MOZJQ==
X-Received: by 2002:a17:902:eccc:b0:1f7:42de:e7e5 with SMTP id
 d9443c01a7336-1f9aa45a7d2mr62982465ad.45.1718876844249; 
 Thu, 20 Jun 2024 02:47:24 -0700 (PDT)
Received: from localhost.localdomain (KD175132079186.ppp-bb.dion.ne.jp.
 [175.132.79.186]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f993deb126sm49350585ad.219.2024.06.20.02.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 02:47:23 -0700 (PDT)
From: Shota Imamura <cosocaf@gmail.com>
To: qemu-devel@nongnu.org
Cc: Shota Imamura <cosocaf@gmail.com>
Subject: [PATCH 0/2] Implement dirty ring for pre-copy migration
Date: Thu, 20 Jun 2024 18:47:12 +0900
Message-Id: <20240620094714.871727-1-cosocaf@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=cosocaf@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Jun 2024 09:23:07 -0400
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

This patch series introduces the dirty ring as an additional method for
dirty tracking, alongside the existing dirty bitmap.

Shota Imamura (2):
  migration: Implement dirty ring
  qtest/migration: Add dirty ring tests

 accel/kvm/kvm-all.c            |  36 ++++++++-
 include/exec/ram_addr.h        | 131 +++++++++++++++++++++++++++++++--
 include/exec/ramlist.h         |  48 ++++++++++++
 include/migration/misc.h       |   4 +-
 include/qemu/bitops.h          |  23 ++++++
 migration/migration-hmp-cmds.c |   2 +
 migration/migration.c          |  27 ++++++-
 migration/migration.h          |   6 ++
 migration/ram.c                | 127 ++++++++++++++++++++++++++++----
 qemu-options.hx                |  29 ++++++++
 system/physmem.c               | 128 +++++++++++++++++++++++++++++++-
 system/vl.c                    |  63 +++++++++++++++-
 tests/qtest/migration-test.c   |  78 ++++++++++++++++++--
 13 files changed, 667 insertions(+), 35 deletions(-)

-- 
2.34.1


