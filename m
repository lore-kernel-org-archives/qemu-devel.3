Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF913C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 13:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riwwv-0005cQ-3m; Sat, 09 Mar 2024 08:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1riwwt-0005bG-B4
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:41:15 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1riwwr-0004cd-G0
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:41:15 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-567bac94719so1971916a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 05:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709991670; x=1710596470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dulj40ayDF45vlir3cYjirF1h2M73oM2DWpOGZboE14=;
 b=Wd0GEs1ad0751UoOsCrKUdCc517UkLCpxGdZmXouAjKMLEmrn6u0V1DXUm5FAufUBF
 O0dLF0w/1Fk6b3kYpUCiuI92uBP8MTcP8iWuQb5yOvCIqsYR661TddrCwn20Rp4Z8DIY
 vNk3HVW2u5eU/aaFjzorfLdEfzpj3Jr5Em+0+uBlSboZkhDy9mI8qnhrZsOkw/pJ2xZi
 JIXF5kElv72pnjrX8GXXV0EUax9/9Bxh8RAL1Oh3RHlewe+/M+0WhovATDcUfmhcBg3M
 LhmX0HDST3SxCIvTSo0teAgSRPYA7iBdKWJt3IC5zOEWQ8NRGIl0t/2jjJd2qSqE/1hI
 jU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709991670; x=1710596470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dulj40ayDF45vlir3cYjirF1h2M73oM2DWpOGZboE14=;
 b=gsryIB0ZaDpmsG/DuiHww0I/AgDvGfXNmpkgnJC3mTDI+knJsaKPg3DX2vvkLRGyd2
 UCpiuBtamP1yHfmzomROuhclwGJILIg1HP+T9vr46RA87v5LDRiNdHl32eB5gA5x0SBz
 tvgeJaOaHlP7o4Ce8R0AQStnHcAAy7t5AnvRb+qN7InXCcAW7fGQG8YTcCr/5NjRrUMb
 pTvlO07GdiFvcSFu8hPdp09/GlfPuD9E0fboStzPmIlQn1CP8/W1hiJ2qHfn4aAUQoF+
 HqtgFLzR/0/TmJTckJNWIpeIFIuqpXlA7aN7frfRaH5qDrlNnyPO1t2XOYK8IpqweYhI
 5VFg==
X-Gm-Message-State: AOJu0Ywj+eKf2JGdqV2wSWzSt4R3h2X/LYmrdfIEkvxHjub+ZoLvX3Hh
 AY+Q7vDLdO8uZS/wyZvOA6jxqe5W1rkQQTsWb+ydbJ9OUSLo+8kTNUEnABse
X-Google-Smtp-Source: AGHT+IEO2xuHetm402eRD3DRkRiS4Wyhwqpf67gCN3luprEsiHe2qPimPrjXxBt7iuYIbn6K3jCSpw==
X-Received: by 2002:a50:ab13:0:b0:566:f60:1b0 with SMTP id
 s19-20020a50ab13000000b005660f6001b0mr1382422edc.11.1709991670151; 
 Sat, 09 Mar 2024 05:41:10 -0800 (PST)
Received: from archlinux.. (dynamic-078-054-250-034.78.54.pool.telefonica.de.
 [78.54.250.34]) by smtp.gmail.com with ESMTPSA id
 b2-20020aa7c902000000b00564e489ce9asm906157edt.12.2024.03.09.05.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 05:41:09 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/2] Make PAMMemoryRegion less Intel-specific
Date: Sat,  9 Mar 2024 14:40:54 +0100
Message-ID: <20240309134056.1605-1-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series makes pam_update() more self-contained by removing some Intel=0D
assumptions. As a result, the purpose of PAMMemoryRegion becomes clearer an=
d, as=0D
a side effect, makes it reusable for northbridges other than Intel, e.g. VI=
A.=0D
=0D
Testing done:=0D
* `make check`=0D
* `make check-avocado`=0D
* This series is sent from a VM implementing this series.=0D
=0D
Bernhard Beschow (2):=0D
  hw/pci-host/pam: Free PAMMemoryRegion from Intel-specific bit handling=0D
  hw/pci-host/pam: Remove northbridge-specific PAM_REGIONS_COUNT=0D
=0D
 include/hw/pci-host/i440fx.h |  4 +++-=0D
 include/hw/pci-host/pam.h    |  9 +++------=0D
 include/hw/pci-host/q35.h    |  4 +++-=0D
 hw/pci-host/i440fx.c         |  7 +++++--=0D
 hw/pci-host/pam.c            | 14 +++++++-------=0D
 hw/pci-host/q35.c            |  7 ++++---=0D
 6 files changed, 25 insertions(+), 20 deletions(-)=0D
=0D
-- =0D
2.44.0=0D
=0D

