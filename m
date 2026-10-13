Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC0ACA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGbue-0006mZ-Qv; Tue, 13 Oct 2026 08:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1xGbud-0006mK-7w
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:47:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1xGbub-0008OF-5y
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:47:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so1759610f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1791895637; x=1792500437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W9tT6dfSVPDUN0HuSqWAy9SKFizm4ZlVWRmPymANcAg=;
 b=KzaRQZKpfdZ5Z/ulfhWZ7DzX/zxgq6MFIT0BxOML4dQnqAVpJWLwLI0BcQ52K5KYI6
 HgwEBkn9l8dnUf11D1dIxwel6E7S8PNi5UL4bSREOI0ITQf/rdTvPEorgsP0C8IJx7kT
 J1/FJjQK0MoOO8s+UWFTpORbSZd31jevAQZvQZ7tA4HSLhrLw2IUdJz7cTuJmQZ905mt
 OHiB2uxnDNjO4pvCGQzeV7CgD8jZWdlcnwlESAbAt5HS63o9frri9CMBtuV3fLNaqEZm
 4q8aMLf8aj2wMnozpz8q1wn6OALPxykj8eXTUfDdiLxgFd1BllYzpRQNc/GOx7gTfI5/
 7Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791895637; x=1792500437;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W9tT6dfSVPDUN0HuSqWAy9SKFizm4ZlVWRmPymANcAg=;
 b=GmrgtEuSyRtldWKETfgs8wSWsshFWyDU6KZjYCnoIYsrYAxMknszS4HeSVr06VCaQs
 qTHK6Fgt84ioeXrDviAOh9sgFNS5DtILgCyw6zK+kkfWPviSYf6c76iiAed3AIXS5Czr
 532QGcZIebdNMiSjXj6ZCbvZL3WEDbdXIN4bJlx6pgEfU3ycsWqoCAcpzyaNG5YkSpi1
 2dmzcCSbeO8HrIAlKctmHLvqHIZ0xwcW2wQ9QfpxesBsBVGUwml6L+8sxaXRww3fTr7k
 Hcc38vJNOjocblCMFKsUs+Tp6iAe1RFsOnHrPTUIUnJ0WcorbKaZj/eH3t/j651l/3gT
 FrGA==
X-Gm-Message-State: AFq9FYKK18++jbOGd7Y6LWeYUHxENJ5YKEG6qq4MCTVYmt3v1HyzDjkV
 stPo6gZe7eEtLiLd1Usx9fZ1XuoziDXnNkrncyV0RyKId0QESOCfR4spk5j5DvRsr0VmfdGCfOd
 UqB+Y
X-Gm-Gg: AYBFou2E/wG+ZM+Y2B2arBCed26t7bP1qaea4RQUUJnyw6E07zbUJbA/BOE/MC7h0Jx
 5GeS60im7FmoooYcOAZOO76ucPKBqtIWp4AiQl3IRDK4xEL7TsGc5CyMvp4R1yQ82IqeOtK/TSi
 PAhEk38SWLb0GnJObyxBms+9w7yvvwNAfpPDSDYPmef2z20iwjn0r49nYoHsS7zQVaI9Yx72CND
 NIDRh9JxPih1KJyLYWp3guGMvzXq8Y7hm/427u+oNM5ScRavXchP4uIynSkIrSmNrgJ1q7oLQCS
 6YY7pelMcSHyVjBaEBz+MVVVxbtSypa0enBh2V1SEn2X5or1v8f+tGfTiArgU60iPXl9FE2kxk6
 qu25u29hrPdleKoMPguuUMwT7ljqykZ9LjUGi8ZqkP/5m/lCX/bJU0ZLJzBD7O70mBtCb4vXNBd
 xc1qTx8c5/PPMW20a1tyojx/Ze1M8CmMkE3TUrTaR47IXOp1vm3jwkjylJm+iU/vKtuDmV8WRSk
 Teju3MNevcm+b0K3cRy6ZY=
X-Received: by 2002:adf:e19a:0:b0:486:f6dc:52c8 with SMTP id
 ffacd0b85a97d-48dbace511cmr21228204f8f.37.1791895636716; 
 Tue, 13 Oct 2026 05:47:16 -0700 (PDT)
Received: from localhost.localdomain ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ebbsm4768847f8f.45.2026.10.13.05.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 05:47:15 -0700 (PDT)
From: <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: eblot@meta.com, titusr@google.com, clg@kaod.org,
 Alexander Hansen <alexander.hansen@9elements.com>
Subject: [PATCH v8 0/5] initial support for yosemite 4
Date: Tue, 13 Oct 2026 14:46:44 +0200
Message-ID: <20261013124649.194808-1-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x435.google.com
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

From: Alexander Hansen <alexander.hansen@9elements.com>

compared to v7, there is now also partial support for PCA9544, which was
needed since it's apparently in front of the FRU eeproms [1]. Previous
versions of this series did not account for that because testing was
done with a downstream image which had patches still applied [2].

This updated version should line up with the dts [1] and work with an
unmodified yv4 image.

References:
[1] https://github.com/torvalds/linux/blob/24a19b953e2a3d0ea5a8c4951a0ab8f32720c907/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts#L597
[2] https://discordapp.com/channels/775381525260664832/867820390406422538/1541811213988528128

Alexander Hansen (5):
  hw/i2c: support PCA9544
  ast2600: yosemite4 initial support
  ast2600: yosemite4 functional test
  hw/sensor: MAX31790 support
  hw/sensor: support MAX11615

 MAINTAINERS                              |   2 +
 docs/system/arm/aspeed.rst               |   5 +-
 hw/arm/Kconfig                           |   2 +
 hw/arm/aspeed_ast2600_fby4.c             | 292 +++++++++++++
 hw/arm/meson.build                       |   1 +
 hw/i2c/i2c_mux_pca954x.c                 |  88 +++-
 hw/sensor/Kconfig                        |   8 +
 hw/sensor/max1161x.c                     | 314 ++++++++++++++
 hw/sensor/max31790.c                     | 508 +++++++++++++++++++++++
 hw/sensor/meson.build                    |   2 +
 hw/sensor/trace-events                   |  22 +
 include/hw/i2c/i2c_mux_pca954x.h         |   1 +
 include/hw/sensor/max1161x.h             |   7 +
 include/hw/sensor/max31790.h             |   7 +
 tests/functional/arm/meson.build         |   2 +
 tests/functional/arm/test_aspeed_fby4.py | 101 +++++
 16 files changed, 1349 insertions(+), 13 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2600_fby4.c
 create mode 100644 hw/sensor/max1161x.c
 create mode 100644 hw/sensor/max31790.c
 create mode 100644 include/hw/sensor/max1161x.h
 create mode 100644 include/hw/sensor/max31790.h
 create mode 100755 tests/functional/arm/test_aspeed_fby4.py

-- 
2.56.0


