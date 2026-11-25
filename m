Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E9A606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SK5MSv8x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW8S8-0006W2-G5; Wed, 25 Nov 2026 03:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xW8S2-0006VH-Ci
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:34:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xW8Rw-0005xB-PJ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:33:59 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so39024935e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 00:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795595635; x=1796200435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z6FrUQVWcZ8Tf+M/yB2yRcJMe+53iifRD7hiQeXpC/o=;
 b=SK5MSv8xiK2jB+AfQECMpqBeOGuk9a7pMxrAaXpdx7FBWGfa8aIckpp/TD/F96OrXG
 Cu5Ugl10y91KeSz3mxUrDyoEU8ID+xLRiO1A9pSN+Wq1weoCSTU7G9cxS9iANVGF1Yvh
 2JO5j/TJq0X7YaPjs338VUGHtCTz/J2ayQYmQO/iOy589zcQPPnxWFaGEUp52TMEoDrr
 FLId4HHDXp0xPFj6mvJE0gtvG0vHJdlCCgU3D3GhRVb/RUrADRlKXCi1AxpH7sgF5lCi
 z77leuY9Nv3t83VCiDQ3EL48IssTH1aoicEC0R6J3RzOhONIg5BbtwdQGu1L2oE16hD6
 3TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795595635; x=1796200435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z6FrUQVWcZ8Tf+M/yB2yRcJMe+53iifRD7hiQeXpC/o=;
 b=X5dRwjRLU+ia0QTXh0aG2WSVmdjln6YStGzMbigX8S4bw68McTagPtExviog1N6wBl
 Mw/gWS9ueUzGnfBo5gZgzwFT38gMtgC/4QGEZTI65VJJQUdVgzcJsNq3KlKL6vdlnNwy
 OmYDyq8E/J1quuylqq8RplQiHQ8hiFQnilBprAlAmwK12FVy2qahsUN//qJAbYmkV2iC
 uh410LM/5kQ+YiO4n0HMyLWcBfFMyH7GqW6bJjSSwHxcNRW79GU7PfmBJwZeOO4zoIKK
 KDTNjFSw8kaDOXQQDqqUUwfzUOvSiU1DF01Aft5uPOCYaxOONmBZx5gX3KEa0X4jedoS
 RaMA==
X-Forwarded-Encrypted: i=1;
 AL+hErHnW6/ZlDqhajq8/6Lx+K0l9wL8KOnJdHClWVwKhjoE5KbSgtrvWBBqn3pkFUipeJO/WSSXvRmqMUfz@nongnu.org
X-Gm-Message-State: APuU4Z9D19Ptnhi/TNI2k0Rw9sf6Rkqef+3kwmz/PCc+ZHYjUwErbzGp
 bu05XyfCtT06F1uAGpU/v5BZqxAUwG3fjrnxI77dBZxu2YnR1sAZ9D0i
X-Gm-Gg: AZFdTZcwG5rSwIHYC2FxazccYRG5sxmn/ThJHXSwOXy3t4sQMX5Q0geDc9fmap/C1uw
 pnydxCaOdrwqjad+qri1/o1NcmVUaz70M+BSqoUlpDP27xgzRElBf4nvXERvMT8EOU5Q0T12Wfl
 4A1YF+tv06O/lrnXCsHPfPHqmtMDnseUjyJp1HjYLBVBUDY4wRu53SUee76eF8cMxCncrfbPQJX
 1nBkrsXgQXs4TnhqxzzyWF1Omp791ZQJmcH205Ro+nEiqOBkd9gi3c1WEorfzkgwBgkPlp3lWMY
 yy15FwA9IJjU5adX0Y47gwDujJy6kzFQaKVWJtOAyhLQh3K1jJX1zc3qNqhVKImX5viXZUsu2aq
 2Da5HnmQYcYIlE9fTP7rx/+HJfze9cOGbN1UOv+59CO2k0KDjpFwZDji+eijL7J037MhCquE24o
 F7zz57AsY+G8rP2OafEf/HWym5goWEjipxTurTkVIZVxA+fPzr/Gl6j14L4qGArdJAmEAq91Pvq
 66EoERLzO9mKGgCLzg9BPMGHTYc1FfYu40NNUl4yIGI++xmzKk8yXjC/2FhBuGo6XyPC7LcLBfi
 reAcRAnXilVaIvWDo0NIWJmcwoj0KkR9AVgkLvHwZZHfMkXbBK/QxACcSXLkHEo0IJq393DQQLL
 8iqQUWMUovUoYGCh43E4uOdAG
X-Received: by 2002:a05:600c:820d:b0:4bb:6cef:d14b with SMTP id
 5b1f17b1804b1-4bb887c34f1mr352708385e9.2.1795595635209; 
 Wed, 25 Nov 2026 00:33:55 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm689837675e9.13.2026.11.25.00.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 00:33:54 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, qemu-devel@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH 0/2] hw/net/can/sja1000: fix receive FIFO corruption
Date: Wed, 25 Nov 2026 13:33:48 +0500
Message-ID: <20261125083350.331457-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Hi,

This series fixes SJA1000 PeliCAN FIFO corruption for received RTR
frames.  RTR frames carry a DLC but no payload; storing DLC bytes in the
byte-oriented receive FIFO made the subsequent release operation consume
the wrong amount of data and misalign the next frame.

The production change is isolated in patch 1.  It also resets the
receive write pointer during hardware and software reset so that the
FIFO pointers are consistent with the reset byte and frame counters.

Patch 2 contains only the Kvaser PCI qtest and its MAINTAINERS entry.
It is kept separate so it can be considered or used for validation
independently of the production fix.

The qtest covers standard and extended RTR frames followed by data
frames, as well as hardware and software reset recovery.  All three
cases pass on an aarch64 host using qemu-system-x86_64:

  - /x86_64/kvaser-pci/rtr-fifo
  - /x86_64/kvaser-pci/reset-fifo
  - /x86_64/kvaser-pci/software-reset-fifo

Thanks,
Haseeb

Haseeb Ashraf (2):
  hw/net/can/sja1000: fix receive FIFO corruption
  tests/qtest: add SJA1000 receive FIFO coverage

 MAINTAINERS                   |   1 +
 hw/net/can/can_sja1000.c      |   4 +
 tests/qtest/kvaser-pci-test.c | 195 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   1 +
 4 files changed, 201 insertions(+)
 create mode 100644 tests/qtest/kvaser-pci-test.c

-- 
2.34.1


