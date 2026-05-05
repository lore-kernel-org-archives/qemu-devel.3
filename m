Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C24CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 15:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKHxF-0007lk-53; Tue, 05 May 2026 11:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wKHx4-0007XH-Gt
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:44:50 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wKHx2-0002dP-Jo
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:44:50 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so3225032f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1777995886; x=1778600686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nwpYM3ZywroNlA3PkFf0iUzTLgIBaVHXt1diCW15zXM=;
 b=XPJ+VBLjxJDRIL21UiiL4tAvyy3qFYOTeeBQpc0WV4KrB2uiSlWjvddl7zLbfQGs87
 +xOTcs0RUZpQbA/rUYWu2YRClcXLMyxZfgs3J2WtBm9S+wrdP2liEVbO41zjyrkzCQKN
 /kZ5L3j/SX9L91lcBu0HN39G9Vq2j2zDBVkbtTFIO8I/ZADs91g9N9GjOMdSzt6iHBye
 L5kH7lP90P1q9FEf8kxCU+pDV4QlQma8fn3CIURu7MCgLktcXJ8QygYok7PDB2z9ufDs
 4psLtc78mxzVydV+FyIjWrr32Y3QpT7PVltzzvI8d/IIsKZnjleSyBrVmqCnDZ6aBmYQ
 6E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777995886; x=1778600686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwpYM3ZywroNlA3PkFf0iUzTLgIBaVHXt1diCW15zXM=;
 b=UCMJfUqSV1d4J3RNY+M0t7ulDcV+shEw2l9HXsb/EDidIcRiSktQdVS83fcwZZe+yB
 hvtGpt/NJFAPPXA30NyniMf7SwBvxbTQ/k+ZZY+C3Um4dEi93V0CjEL4HVFQBJSgFrz1
 Wc+i/yRkEL5hJOOBCLziWas9udx9u3Sfpgb8RFMczANS8nSh3JVCFVveMLx8hRDMw00G
 hHPhd/dVBe0nT5VOJfJLdj1gh4bk///7A9s3phdqQrHFJch2Va2/TDR0MuuI36f8aJsj
 MIyA/P2QIRu7mLhPY87Ow1Btb4CbzV6lwJ2lnwOCoENyuLvSUKggWGGvoLoLI7UsjHRt
 0qzw==
X-Gm-Message-State: AOJu0YwLOeWjGi5D/wrHDm1pui4RqQ6bab7y1ZNdLAF9276uD5qx07oX
 X4SqNSGE1UktdZzNwow7AqJI2G5gw6ZRIjMCZgOLaQGFXw/iBkBpStpJzBTyDSs+2p2kGbYAqbU
 c5WLAr4E=
X-Gm-Gg: AeBDiesfPTO2KzCgCjuqggGA6FgitrCqRnNW4JBkCMdvyHCA6MM7U1AsOy5NBXST+ZK
 B/BwMgvVEDsh+MsD4yj6G/JjmZMvF3Lc8bWyXkGlmAqGnXydndXs6pJPhtC5QPRYDxHc2mBvNUe
 bDy0FYOySDO0m/XkbSgYZL/89SSfCUbGyfZgLomeyUmxCjfuvI2aEbnKQoVkQo1ErMY4oG0+sMw
 i6WxqDW7dtxnBSFDKmyzplCe2r0LWTcWbPOVrxNHt+Wng9OM/LGJWRPL8kPFQnUtqHtrwXwUsvr
 nNzqBkzXQ+RBgoEUyyuKOEW5AwfUjTa6nnuhqRB1W+QNAEWHReJidMFNS4tkbywTIALQnl4HIm1
 HsTnLgv6qroOIOYlSXpzz64TkI63aWt+oULSAsYRSU4Emcf9UjmQdWM5vm6QciGjivSKY4xUJYd
 q46KFvI9QnyDq8LDAgpSq9X9TddwwqGxTd/1Jb4vZAxCgECG0OY91SGA8=
X-Received: by 2002:a05:6000:61e:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-44bb63f2960mr26277328f8f.38.1777995885687; 
 Tue, 05 May 2026 08:44:45 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02abbsm5255305f8f.18.2026.05.05.08.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 08:44:45 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>
Subject: [PATCH v2 0/4] initial support for yosemite v4
Date: Tue,  5 May 2026 17:42:54 +0200
Message-ID: <20260505154410.230969-1-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x42a.google.com
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

Add initial and incomplete support for yosemite v4 BMC-side emulation.

As part of this effort 3 new sensor ICs are added.

Alexander Hansen (4):
  hw/sensor: MAX31790 support
  hw/sensor: support MAX11615
  hw/sensor: support Texas Instruments ADC128D818
  ast2600: yosemite4 initial support

 hw/arm/Kconfig                           |   3 +
 hw/arm/aspeed_ast2600_fby4.c             | 289 +++++++++++++
 hw/arm/meson.build                       |   1 +
 hw/sensor/Kconfig                        |  12 +
 hw/sensor/adc128d818.c                   | 414 +++++++++++++++++++
 hw/sensor/max11615.c                     | 202 +++++++++
 hw/sensor/max31790.c                     | 499 +++++++++++++++++++++++
 hw/sensor/meson.build                    |   3 +
 hw/sensor/trace-events                   |  24 ++
 include/hw/sensor/adc128d818.h           |  20 +
 include/hw/sensor/max11615.h             |  20 +
 include/hw/sensor/max31790.h             |   7 +
 tests/functional/arm/meson.build         |   2 +
 tests/functional/arm/test_aspeed_fby4.py |  44 ++
 14 files changed, 1540 insertions(+)
 create mode 100644 hw/arm/aspeed_ast2600_fby4.c
 create mode 100644 hw/sensor/adc128d818.c
 create mode 100644 hw/sensor/max11615.c
 create mode 100644 hw/sensor/max31790.c
 create mode 100644 include/hw/sensor/adc128d818.h
 create mode 100644 include/hw/sensor/max11615.h
 create mode 100644 include/hw/sensor/max31790.h
 create mode 100755 tests/functional/arm/test_aspeed_fby4.py

-- 
2.54.0


