Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE44C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZntk-0000PF-44; Tue, 13 Feb 2024 03:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnth-0000O5-QI
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:09 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZntf-0000hg-20
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:09 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-410c804e933so15073135e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 00:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707811925; x=1708416725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SNdTU2HlcU5s/z0+DB1v8IvSjqtCtnO33Hovm2ZRDRI=;
 b=jrTJd1y0UofU/Cyckn8d6gfeJ9WI3AyZ4531Cyi/cREb/kIvzdv5n5XqYyHx99HBKP
 IW3tKJP0Gg5VEmuDFJf6+m8Vefils3FJZppYWGzg4PCpYEKagIt8WOUxYYolaemBKK+0
 8E4bLvTHRIws9wR088RXD1cosH/LypSnChcuQLYESmfe1vUCYMCUCH/reMrxbi6YL/0g
 3RrHQWvV0QZZGBO5njgsn2OLFpRxNevjAkabC7dBJhhBPyw+MvJ/j6qucqfvw2uGGmx3
 ZI7wMwEMQGzdWYbDULkv0JzwaLV4JzpPZOef/yZo8mxrnQJ7dQhP4AqkbDstg3D1AGfM
 4ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707811925; x=1708416725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SNdTU2HlcU5s/z0+DB1v8IvSjqtCtnO33Hovm2ZRDRI=;
 b=PMp6xmEt0civXq+Fsc/eYCCyIeeGwLOjpphZ11NPSjzeHCn0IkycBSx/v7ucS7k+UG
 0RHPGYWrY+gBhDa6fWjpPPwGqxHPfD9BafRVLrPKjZZm/e1PD3xj5t0Al3MslxJ+s0qY
 h/XruzWb5MEzEo64ULKgjUiZcxgXVu9Wk88I/GX+y+X/XtT/dyliOAJwi1VBvZLxBocw
 pRdZLWRCZHG8gjerVC6n5xT6caJrGcl8NhiKRE34kybiJK/BbkX+yHHlVk3zkztDZMg1
 Zj5sPUfKZoD5paL4ZP9/2Y9Ju9H9Vlt06QvnMGUjay4MdWNBHVVoqZTR2pLI2x8JAhNa
 AmbA==
X-Gm-Message-State: AOJu0Yxgpoi4slbsTVfaU4uCJ7A8Frd5QteFuXXtZ1W6ttFCsD/B/Jzv
 B5mZ0oq/m+HAw2aTPnolhDxN10VMbxYdU1oWAgOnXs7d/Q9D8A0/6mJmYnwn7FTCKvtYbq6e8Iz
 o
X-Google-Smtp-Source: AGHT+IErYvGS/TOlD26uNe6u+vDsFpKpcoqX7Szq0/AlPxktXD6cFutM/M4S/Btgzy7NEELn7Wi2ug==
X-Received: by 2002:a05:600c:35d6:b0:410:bb99:af83 with SMTP id
 r22-20020a05600c35d600b00410bb99af83mr4869569wmq.23.1707811925007; 
 Tue, 13 Feb 2024 00:12:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVjyWtWroj3K6+6Zu0pzKH2TyHoGYRVKhqorsEmjbCZW7clzgCibkXPWOTS8EmzF0xQNv4sgJBWbnBDHB+OAEqIEOS5enI6IZsO/KNpC/HY2NVlFTwiIU/lupgySWWVcEcvOnmJ7ynG28tlHzLJ+F40R9jhBSH1y5UauBEr6BwDXXyZauc2p/iueLMWCD+QCiuc3SZFiNlPXZUGkY3JnPrvyk+E2P75Qxuazzkx7qRdrZFTShMb2BFFhUEt6xmOqjdyTPyZZrbqGbQ+QzEvwPLtrLsWiCo=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 jz15-20020a05600c580f00b004101f27737asm10808681wmb.29.2024.02.13.00.12.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 00:12:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] hw/ide/ahci: Housekeeping
Date: Tue, 13 Feb 2024 09:11:51 +0100
Message-ID: <20240213081201.78951-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

- Split 'ahci.h' as sysbus / pci
- Inline ahci_get_num_ports()
- Directly use AHCIState::ports instead of SysbusAHCIState::num_ports

Philippe Mathieu-Daudé (9):
  hw/i386/q35: Use DEVICE() cast macro with PCIDevice object
  hw/ide/ahci: Expose AHCIPCIState structure
  hw/ide/ahci: Rename AHCI PCI function as 'pdev'
  hw/ide/ahci: Inline ahci_get_num_ports()
  hw/ide/ahci: Pass AHCI context to ahci_ide_create_devs()
  hw/ide/ahci: Convert AHCIState::ports to unsigned
  hw/ide/ahci: Do not pass 'ports' argument to ahci_realize()
  hw/ide/ahci: Remove SysbusAHCIState::num_ports field
  hw/ide/ahci: Move SysBus definitions to 'ahci-sysbus.h'

 hw/ide/ahci_internal.h         | 10 +--------
 include/hw/arm/allwinner-a10.h |  2 +-
 include/hw/arm/allwinner-r40.h |  2 +-
 include/hw/arm/xlnx-zynqmp.h   |  2 +-
 include/hw/ide/ahci-pci.h      | 22 ++++++++++++++++++++
 include/hw/ide/ahci-sysbus.h   | 35 +++++++++++++++++++++++++++++++
 include/hw/ide/ahci.h          | 38 +++-------------------------------
 hw/arm/highbank.c              |  2 +-
 hw/arm/sbsa-ref.c              |  1 +
 hw/i386/pc_q35.c               | 19 ++++++++++-------
 hw/ide/ahci-allwinner.c        |  3 +--
 hw/ide/ahci.c                  | 29 +++++++++-----------------
 hw/ide/ich.c                   |  4 +++-
 hw/mips/boston.c               | 14 +++++++------
 14 files changed, 99 insertions(+), 84 deletions(-)
 create mode 100644 include/hw/ide/ahci-pci.h
 create mode 100644 include/hw/ide/ahci-sysbus.h

-- 
2.41.0


