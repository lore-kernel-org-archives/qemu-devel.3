Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FDCECE57A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 13:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snHhq-0002r9-Vk; Sun, 08 Sep 2024 09:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1snHho-0002pY-I0
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 09:11:52 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1snHhl-0000f8-Rq
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 09:11:51 -0400
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-5c3d2f9f896so3499961a12.1
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 06:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725801108; x=1726405908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IBW/q/Ttr5sT0my1us7dTOBDb0sfTk6WHz5U+LOxdM4=;
 b=soNCqGBxYGxi39LhLkaP7LLfePRoziVNToimjB4yeKnDRIFhLHCPysCpPXrAnxfPTm
 V/tqEcuyTD9XmnkTBX8UUCmDX4+J6qCc480uA/NR1AbD9xR9D/DVrTbf3w+BGKRZWDNW
 tOiObkpL0U42sb7J3qggbQtuA+xnb7iYr6Y8qNvMZtB9aZ6Z3EeG1LyFGDyoaNjd9/ck
 +fejQQyyhVi03sqMoSfvpmiI0Nh2K9wZLXkQIuMyDeG1n7t0Sgqk8BemesKPMCvnsP5n
 TuetVV4IJiFriuRMlnpNEI01dOLe8kLfLhY85mIL+5mlQ0vdIJkZpimY6z1FSvOhaEAG
 qztg==
X-Gm-Message-State: AOJu0Yyit6LZTLA0AV+gJ6X4ORGBfOihbw4IdoI5W+uLv9tEiP9HUQGp
 C5CS7JJOELlUlU/ZhhRLjwRaRt+UTiLaALuOb31PY1pOelyFylFw/ULi7w==
X-Google-Smtp-Source: AGHT+IGnCggh+MgXy/WgAOMuHvppkdriKLZzfujFbzpHnZJyHSuv677oAoTygQ8IJc11bdHxGQQzNA==
X-Received: by 2002:a05:6402:2106:b0:5c2:4d9f:60c with SMTP id
 4fb4d7f45d1cf-5c3e95354a0mr4201382a12.7.1725801107483; 
 Sun, 08 Sep 2024 06:11:47 -0700 (PDT)
Received: from fedora.. (ip-109-43-115-52.web.vodafone.de. [109.43.115.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd5212asm1842418a12.57.2024.09.08.06.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2024 06:11:46 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/3] m68k patches
Date: Sun,  8 Sep 2024 15:11:25 +0200
Message-ID: <20240908131128.19384-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.44; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f44.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

 Hi!

The following changes since commit 1581a0bc928d61230ed6e43bcb83f2f6737d0bc0:

  Merge tag 'pull-ufs-20240906' of https://gitlab.com/jeuk20.kim/qemu into staging (2024-09-06 15:27:43 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2024-09-08

for you to fetch changes up to df827aace663fdd9c432e2ff76fb13d20cbc0ca4:

  hw/nubus/nubus-device: Range check 'slot' property (2024-09-08 11:49:49 +0200)

----------------------------------------------------------------
* Fix Coverity issues in mcf5208evb and nubus machines
* Add URLs for mcf5208evb datasheets

----------------------------------------------------------------

Peter Maydell (3):
  hw/m68k/mcf5208: Avoid shifting off end of integer
  hw/m68k/mcf5208: Add URLs for datasheets
  hw/nubus/nubus-device: Range check 'slot' property

 hw/m68k/mcf5208.c       | 10 +++++++++-
 hw/nubus/nubus-device.c |  7 +++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.46.0


