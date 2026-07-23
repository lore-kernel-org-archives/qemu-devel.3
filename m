Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC11EC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn2xY-0004rQ-2C; Thu, 23 Jul 2026 19:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wn2xW-0004qu-HW
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 19:36:10 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wn2xV-0001by-2A
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 19:36:10 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-48a0ca07c38so707666b6e.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 16:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784849767; x=1785454567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ucm9U4/bhrDdmIqQqv/La0eBnJ5MPcmWIKvzF9wOrXE=;
 b=I/OdFkFwm3X+E925gWl7KRLjjMLe0D6811cZTnt7dAmt35D+MlH2Pj8VYpMaUxN3si
 BpJDHbSPdAB3p47ughcmLn49BRS1b9c2b7TD8gFF70LeuoTiMmjdFsB2Uc6g+B1mFFGZ
 opaA5n2qgByFkgg7HS++MGftNMdk4OfH5DFOspz7KRJVa5EzcgkYbiBQMO0w5F4jG4vr
 6lo7Bgc45sIyX91Ro69i9JafIyCLvkJJxCjfk2B0T73uqjtpFMusBH+a6K8Tqb2qxFXr
 pAbhRNDf3WBaZvu5plOoHuZXvKbGvspldYzyQgSxpw+9csqmSP6cTGo5jP2jkRj2ehXp
 edEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784849767; x=1785454567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ucm9U4/bhrDdmIqQqv/La0eBnJ5MPcmWIKvzF9wOrXE=;
 b=DzyR+w4PDP0p1d8SRfbko0SPfG8pg3UHa76qZ8bKhbHSgKFZNf3QuSjxctuL/s4Ek6
 +d3m0UsJQZwXKeTUEchL/4BNFbP8vPHfNWiytcYiWxrKlacISIOzUlzuXHs1+5ebMwst
 G7hrrTww8r4Ck8MrAsS4mRL8GcErVROH4JagKQYJtlaLo9yfD3SJgncqsvW6TQotx/SV
 cokvzL2RbIponjAwphkrtMsYMPKSSEKD+4/Aqr7RfZmYus07NnKL7JArIgctCQU56TX2
 wHL8TmGpeZdTLYdm4gtMPYGwXOYKXxrK2hlw5iYnoyw1Q1Oe99CmJDm5TJ0pfTGkjLSy
 hFKg==
X-Gm-Message-State: AOJu0Yx3qGEV1Sv6bA+cdsQat3SaP8m4XP9SxLp1QaHkS0R8ntRhIhuD
 4vg3FGhYDGPwuIUm21OQM9t4//9MLCWKo68XmmQUM5+T16s3wBT4QLa1i+vcrFt2
X-Gm-Gg: AR+sD11ugS7j4A69FmQf91DMgmGa04QcONymwnxYQTw15TYPFTpGwLo+bJ8yb4W5nfV
 CK8r2JwXnR6SPwFtv5aPWqh50XVocYyNiT5pfVZQBOePSb2R0E6HbI9Pmm53WNlRlj4QTT5on98
 yb4Jk1dSkUIoM/r+03oJmavb60QqhCBdJAtJAMDmWGJn4ZKQjFzup0OHvits3Y87ffxxoSWAlst
 7s6Far1GOsg0bu4FndYkc2XPiEoTWHGl1CDX77hFvx0eNBSxSINKUi8NXJJ+xe1hgbWUrx+r8kz
 dAQZtN+DpjWzWLNMNkq30e1EQ+jmPYR74vB0PEug6GYrLbL8ReRc1GZx3W94Elx3vJVe3dgAhCq
 V/wwYWjyz4MF+AGugAGztVnJt5cbChjaxM2zccD6gWMYVhOohhWPdTLglTFNdDf8CgmXO7t+n6s
 SabyUP1zuZ8nEyo0UKckimxEc=
X-Received: by 2002:a05:6808:14cd:b0:489:352c:5153 with SMTP id
 5614622812f47-4ab3544e31dmr2603583b6e.21.1784849767315; 
 Thu, 23 Jul 2026 16:36:07 -0700 (PDT)
Received: from HPE-2MQ6131DV6.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab248c6667sm3631997b6e.0.2026.07.23.16.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 16:36:06 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>, Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH 0/4] arm: add Cortex-M85, SSE-310, and mps3-an555
Date: Thu, 23 Jul 2026 18:36:01 -0500
Message-Id: <20260723233605.805-1-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch series adds Arm Cortex-M85 CPU support along with the arm
defined machines SSE-310 subsystem and mps3-an555 FPGA board.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>

Simon Xu (4):
  target/arm/tcg/cpu-v7m.c: add cortex-m85 model
  hw/arm/armsse: add Arm Corstone SSE-310
  hw/misc/iotkit-sysinfo: make sys_config2 configurable for SSE-310
  hw/arm/mps2-tz.c: add new mps3-an555 board

 docs/system/arm/mps2.rst         |   6 +-
 hw/arm/armsse.c                  | 229 ++++++++++++++++++++++++++++++-
 hw/arm/mps2-tz.c                 | 143 ++++++++++++++++++-
 hw/misc/iotkit-secctl.c          |  18 +++
 hw/misc/iotkit-sysctl.c          |  60 +++++++-
 hw/misc/iotkit-sysinfo.c         |  23 +++-
 include/hw/arm/armsse-version.h  |   2 +
 include/hw/arm/armsse.h          |   1 +
 include/hw/misc/iotkit-sysinfo.h |   2 +
 target/arm/tcg/cpu-v7m.c         |  41 ++++++
 10 files changed, 506 insertions(+), 19 deletions(-)

-- 
2.34.1


