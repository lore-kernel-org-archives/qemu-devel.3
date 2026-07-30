Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AC8C55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLtb-00075O-C7; Thu, 30 Jul 2026 04:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtY-00073k-86
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:36 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtW-00017V-DC
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:35 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so186078366b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785399208; x=1786004008; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jBKQIYBks4m8yx8KK9EMA/CIm7c1I6hIP+IdxMcXqXQ=;
 b=XVlg8xLHWOQCabj0tnYZA8H8awiPL5lT3dcfzywaqZXmbTDra6sRHIewZFAlu44mmA
 gwbi2Aj70ufeVv+HCZY0vzepFAvRWcTocTfQaqnHHEOlkqAYs4bepkP6IrJNNNQwYuQ4
 fwunwBMqh7YJEdxyPMJh9VmEkyBRDGsc+4KtMxKiyHTdJ+7Rve3rQ1iKjQFzDf7q9/J4
 gjVDcSsNWlKY6H7xRQ7SpmK34Om8DsTDXtQ35UTUgE0PdDcJ6stfvQspbp6PimBf5/jA
 YGK7xiENkZGVrkVOg5Ed+E/VDtfSRWO0XE9EcJLnDlUYjXT7piI/0j5HeMGTMLNg4xlX
 OGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785399208; x=1786004008;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jBKQIYBks4m8yx8KK9EMA/CIm7c1I6hIP+IdxMcXqXQ=;
 b=Mr4x4Y4QAapnTt8tyPPaE70L8kb9b6G9c40xFAEcw1ht9VQ5QN4G50y3mf9FcG6GwR
 abP3FDYVWhu3hlYy50p0D6vFzvmxKkd3iIZyzLChbhknMbnhG0hNdNFaqOE9t8O/eDcF
 dEUebNXkieiCJwTegC0Rh/8UFjwLaw3YEqhHPtco9LQkY45aP4S2hR/QXoTmFnJzu8/5
 OUVReGFPiglQdORzglqnP5rgYa3eR/A0XMgViM+QkJ+kU/ZPP1nq3mkIp4gY3G55siT9
 GUQfQJFNnq5pBDGDUoeDO4c52EPBtdZH8VkHWWbQ8ybxw5hwfOS+Z8Mj9GpgWH9eoqY1
 y5RA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGDaimu7tMkZugyWZ//m/VPKp8pKlt8WR+bYpWDpTm7RD3vHMwhsPVWesLkrCI1SWGcHIR4GZlssmO@nongnu.org
X-Gm-Message-State: AOJu0YzaHz9mIfcW4wnNu0cmqJlqOzHOKmtiTZcctzv8ZVh8Mt5BygyU
 kdsp2YrfTMKa8NViXdcTCw6cWSSKeeww1h0yWYWU1FJdeiFo/IiYOFzw4ZsBVs3yXh4=
X-Gm-Gg: AR+sD116Ovqd4XQd6YUmuGfECflV5WvQXeY/wHxntMoUAQy+xmUGF4Ufi8JgdBhtwU0
 53ilxmRIC3FthzF+Gu4aVAps895DwTNaWb5P/WExYK5qZNOEcp7OJtCys00mx6uM77T9Tlvj30I
 BVGrfdAzOCMOVU/Nt+FVCGTYYOl6u0J8Xak8lWGoK9qRWpCvwNZ2hTJVx783P0ggpzugkfwLKWu
 28dWTEtejP+EQUF+N2g6moia0vS5oZsqVzFSNYl/JZ4SixTk43EzllfyTyRIX9y/nwk1zV+E8Gj
 lPZ1fc39wpRoWs01JrLJz01Oqx2W8W4nzQKgwPrQ8VDM25HOS6GiyrbII2ruwrdhCKnwKOEv0QQ
 i9OMXPbje36ZIvckfEzrH8eOGp0eEGxcoOQ7XJmXFMg7P6mdkR5dyGsNLU1M76IkVgUXdlypLwo
 PdIElVE4+vco4eUyAhDUEQnzGuWl9CUNce14DWHX0WkXLgYr6bsw==
X-Received: by 2002:a17:907:1c9b:b0:c0b:e9c1:93a7 with SMTP id
 a640c23a62f3a-c1fa55a960fmr90365666b.29.1785399208109; 
 Thu, 30 Jul 2026 01:13:28 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:871f:1fb4:356b:23d9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa857c8e1sm38373466b.19.2026.07.30.01.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:13:27 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 0/8] IDE patches
Date: Thu, 30 Jul 2026 10:13:16 +0200
Message-ID: <20260730081325.1816193-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=den@openvz.org; helo=mail-ej1-x635.google.com
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

The following changes since commit e1705a25aff35635c360bbaba4c2731d019a422a:

  Update version for v11.1.0-rc2 release (2026-07-29 06:16:08 -0400)

are available in the Git repository at:

  https://gitlab.com/dlunev/qemu tags/pull-ide-2026-07-30

for you to fetch changes up to 89d7cc4626bec53a6653a95489972d2400623e8f:

  tests/qtest/ahci: regression test for ATAPI read vs. drain (2026-07-30 09:16:45 +0200)

----------------------------------------------------------------
IDE patches

- fix a main-loop deadlock when an ATAPI PIO read spanning several
  sectors is in flight while a drain starts: the nested sector fetch
  was issued synchronously from inside the completion of the first
  read and queued behind the drain, which then never finished
- read the whole ATAPI elementary transfer in one asynchronous
  request instead, removing cd_read_sector_sync()
- extend the IDE/AHCI qtest coverage of ATAPI CD reads: parametrized
  read helper, multi-sector DMA, raw 2352-byte READ CD on both
  delivery paths, and a regression test for the deadlock above
- add myself as an IDE maintainer

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

----------------------------------------------------------------
Denis V. Lunev (8):
      MAINTAINERS: add myself to IDE maintainers
      tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
      tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
      tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
      tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
      tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
      hw/ide/atapi: read the whole elementary transfer asynchronously
      tests/qtest/ahci: regression test for ATAPI read vs. drain

 MAINTAINERS               |   1 +
 hw/ide/atapi.c            | 180 ++++++++++++++++++---------------------
 tests/qtest/ahci-test.c   | 134 +++++++++++++++++++++++++++++
 tests/qtest/ide-test.c    | 211 +++++++++++++++++++++++++++++-----------------
 tests/qtest/libqos/ahci.c |   5 ++
 tests/qtest/libqos/ahci.h |   2 +
 6 files changed, 361 insertions(+), 172 deletions(-)

--
2.53.0


