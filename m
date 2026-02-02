Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51D9E7FDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3cI-0005SK-Gv; Mon, 02 Feb 2026 18:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cG-0005Ry-9v
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:00 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cC-0004sD-D1
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:45:59 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so48036025e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 15:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770075953; x=1770680753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XepInsAn8KIIqptWPiPLQxHWzVTDYX1qxVh8fOK+0d4=;
 b=l1WR9JC7ozn7/GF/hD4IXYNQNuPr5VtEPHMKFNCKjxjBPAuY+g0Z16XODZSNDrfPIE
 zwUhVie95Mqj35nj4Er066/L/wwqEVluwb4DeyzvNF/p1C/O87+2OD4RtQFt2fDLu5iA
 weK1sXPohHZDt5bevdwaS022o7q1V7Ly+W5XCcv2hp6sFNK4J+2KRkgNgSXrXAOMiAXu
 S1kZAICvod51YiPUXe21CySyuiNds6jQPSYCiyyesQH0mFkQAMzceQPqlJM8HfI4thDN
 KKHnBPiAWI4wYBpm8iyQ84soqpL8DFRT4EHmVuaMKLSZzmghEolpiYrW2/kCzjK6Zi6f
 NyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770075953; x=1770680753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XepInsAn8KIIqptWPiPLQxHWzVTDYX1qxVh8fOK+0d4=;
 b=q178UEMUUxaP3N7LPdI2NjB9hRit+xGaulgCRHg0tu8PdPHQ2kUORxBPo8gpos6Go4
 4yKHwvgUN1SUax2ghAlNTZFT69Z7dzLXYCZgd5oCrHzUpGY1SiXfN1sK7vI47dBum/1D
 VYm7CU2PES4ZEREA4Pz1hfCaPBQ/gzQdKQ4llSTos8BpP2n8L5VLF7nk3EIEm4u0ki6G
 byu53lIEAPPfnrSDV8pwOORN5hrx+kjSeqCIB4+uOstI4O2bi6okNB/leI0NtSfxRzGf
 NJy4Lma2Dv1amkM47mYR15Y6xhM9hWaGlW9B1h33IUAcadyu/hrhXd4W96nan8HuIGq5
 kyUQ==
X-Gm-Message-State: AOJu0Yz6PzEQVZVJAWhJmPMnDjkgHRB+QN7rwGIev0Q1Vh2M/+2aTnjA
 3Y9acScGNxtJDMDSjzctMDGzR+a3aHTtDNux8QTn7Mf6hTcDITmBONExUiPWtIwAXfKuZAMs94L
 GfrJ0xWw=
X-Gm-Gg: AZuq6aLRKwnaUEzLbKMCy+OfBspySaWIe01e6uz+/Td1RNRwePpJiEcPKuiQYwoJvnE
 5ewZ1HCRLHRouZ81t306gE95zEzL36ZA9Axo8Lz2mKl6+DcwYdrECd43Ur0SD/zSDOmRNp1Z3vJ
 GIvLkUYyV46eWgIYI8YsSXrE9hDftkdr5XNnYebx/NYCchEvCb8zUr7N7rQgcAoCQl1EH/Hlrda
 YIOq6ZmL5rKon4b30+LyN0tAe9Q0i/JKgZb2OvN4Spnn3x8clYieqpoKtA88aI3089Enz/cP0O5
 A8x8SVx8z8dGoalxGTEFRPKXAxCrjpCVrljKD+p2/gMUmCEu6mmL2/0BsuWjE9WG6qs3j8OWYSu
 1HrRnom5LXL6XWO3cp3LLoXqkpjPCeZj0wrM7uUTeArQ+tW1j7goFfQNaFpY0D+K8gPpBzSB9TB
 OMPBtG34VHn+gQ8OztTOqZjsya4RaKpXl+lTejvPDuk1GPPEOcqHErAHuzkYhNxdDxpN7f0Dw=
X-Received: by 2002:a05:600c:1da8:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-482db493ff1mr189319665e9.3.1770075952788; 
 Mon, 02 Feb 2026 15:45:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e04a082dsm106223555e9.3.2026.02.02.15.45.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 15:45:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] target/alpha: Remove unnecessary target_ulong uses
Date: Tue,  3 Feb 2026 00:45:42 +0100
Message-ID: <20260202234550.34156-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Replace target_ulong -> uint64_t / vaddr / hwaddr
and TCGv -> TCGv_i64.

Philippe Mathieu-Daudé (7):
  target/alpha: Avoid target-specific migration headers in machine.c
  target/alpha: Build system units in common source set
  target/alpha: Replace target_ulong -> uint64_t in gdb_write_register()
  target/alpha: Do not use target_ulong for trap arguments
  target/alpha: Do not use target_ulong for page table entries / indexes
  target/alpha: Remove target_ulong uses in get_physical_address()
  target/alpha: Expand TCGv type for 64-bit target

 target/alpha/gdbstub.c   |   2 +-
 target/alpha/helper.c    |  17 +--
 target/alpha/machine.c   |   3 +-
 target/alpha/translate.c | 228 ++++++++++++++++++++-------------------
 target/alpha/meson.build |   2 +-
 5 files changed, 129 insertions(+), 123 deletions(-)

-- 
2.52.0


