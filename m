Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2DCCFB43C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxBql-0002hL-Kt; Sat, 05 Oct 2024 16:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxBqj-0002gK-H4; Sat, 05 Oct 2024 16:58:01 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxBqi-0006mQ-2S; Sat, 05 Oct 2024 16:58:01 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c87ab540b3so7609311a12.1; 
 Sat, 05 Oct 2024 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728161878; x=1728766678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DwS0wSAR5yQLLfUjWr7LO2EUxGhBio7zzDZUus0P7LY=;
 b=RKaqON0DSLhlAtsmaqqo9iiYR5dSU+FYxrdZmMM3ah/YURbbUtIx68Bi50y9rkmbYL
 2xLyoGEaeMPSBVoeMif7Zsicw+st/hKw4hYqzQGXq3u+VTz2hh5grdqcQPo5iRZJURYj
 9B4pP1gBu2fegMYAyECq0OzKhc1irrL2VNSLgu9X3ZFaGhJ37C2e73TKPEVAbPD/JNbc
 jRWTQ7ZhK6HBNCaBXQueDBJ7HiZV7QU3wzyhet1+5is9AlSAoQIPsh5XjaAbdTHixIO+
 bWGNXwGPAGlXNmkaFccMXBylxmOtt6k/lZdWLhsogulVcJCIxx3lc+QBIT0FcCEs8MuQ
 YyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728161878; x=1728766678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DwS0wSAR5yQLLfUjWr7LO2EUxGhBio7zzDZUus0P7LY=;
 b=JGHN7exPs6qmebgddTINhhTzcpEQrlbq/Ty8+zy5tbKJDyDnXjnKtpPMm9hIGvMnrt
 EcUGWGUgZUOTB4Yg841c6xoQVoucyMUSOOHpSrjrlfAtW5fBNcPuk6AzoMrBTnCsVhhE
 ehYB82z4bb4ZCLKHtsyTd739rOSs9MZUokVc4Hc3uS8XU4jgVpa8iTH2LOObR8x/nsIZ
 HCjWeTAQr2CFt18Ccbzbc2kZkJ9oCwMsqSm6SFBju4kuG5RqS3Q9T6st8JnznggVTlrj
 z/oh2F80kHdNIy0oOvJ1sRcU9VBDd+UKjqyIKo3X0OvMNuix2TMeD3VSbBt/ByMkT353
 pV3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxogvYvVz8oTuro1DINu2/jVPCc3X0YHAdz2/+Kpp4hBR7QqGbvTmhnZXOc3RDFqCa+SHail8mcA==@nongnu.org
X-Gm-Message-State: AOJu0YyzoopT6TtXsp+e9W13uPIZ2FLRaV4t8/9dZ1ISHuM7HXaZUhbZ
 WpyplsXhA+/qZ6cEfpFfRabRrtVDn947Ef1PS97MduyxS8GbSNKu1YqtDQ==
X-Google-Smtp-Source: AGHT+IHe1AREJF5XrDZLGtpI4OuqmF5+6sH1uj4E5ddFmH0I8kYV/78eo4vWR2WA5Tsp3vN0fb+WKw==
X-Received: by 2002:a17:906:730c:b0:a8d:592d:f56 with SMTP id
 a640c23a62f3a-a990a23cb93mr915210166b.31.1728161877427; 
 Sat, 05 Oct 2024 13:57:57 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a993f40d542sm105804966b.157.2024.10.05.13.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:57:57 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/4] Consolidate lan9118 phy implementations
Date: Sat,  5 Oct 2024 22:57:44 +0200
Message-ID: <20241005205748.29203-1-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

hw/net/imx_fec and hw/net/lan9118 implement the same Ethernet PHY with simi=
lar=0D
but not quite the same code. This series consolidates the implementations i=
nto=0D
one to fix code duplication. It then continues to make the code more readab=
le by=0D
reusing some existing constants.=0D
=0D
Having a dedicated module for the PHY allows it to be reused in even furthe=
r=0D
device models.=0D
=0D
Bernhard Beschow (4):=0D
  hw/net/lan9118: Extract lan9118_phy=0D
  hw/net/lan9118_phy: Reuse in imx_fec and consolidate implementations=0D
  hw/net/lan9118_phy: Reuse MII constants=0D
  hw/net/lan9118_phy: Add missing 100 mbps full duplex advertisement=0D
=0D
 include/hw/net/imx_fec.h     |   7 +-=0D
 include/hw/net/lan9118_phy.h |  31 +++++++=0D
 include/hw/net/mii.h         |   6 ++=0D
 hw/net/imx_fec.c             | 141 +++--------------------------=0D
 hw/net/lan9118.c             | 133 +++++----------------------=0D
 hw/net/lan9118_phy.c         | 168 +++++++++++++++++++++++++++++++++++=0D
 hw/net/Kconfig               |   5 ++=0D
 hw/net/meson.build           |   1 +=0D
 hw/net/trace-events          |  10 ++-=0D
 9 files changed, 254 insertions(+), 248 deletions(-)=0D
 create mode 100644 include/hw/net/lan9118_phy.h=0D
 create mode 100644 hw/net/lan9118_phy.c=0D
=0D
-- =0D
2.46.2=0D
=0D

