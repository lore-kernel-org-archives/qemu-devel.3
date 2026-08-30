Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1C4C61DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 05:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0YNa-0005At-2C; Sun, 30 Aug 2026 01:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1x0YNY-0005Al-Ma
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 01:46:52 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1x0YNX-0001RX-6x
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 01:46:52 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so2527269a12.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 22:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788068809; x=1788673609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PVHcQLcdz8NGU7N37B5+qw6VJnaEnt6x+iIyP/dx+aw=;
 b=q3Wh7rdkoOhFWqbB+mT4kxxtnLlQAvilaqn0Vk/p0xjU4jQoIeT5SIrZqtsZvLzzeu
 1LEwo+8V3V7L7VecksppByaqXD5leYmDPA2yOrafrpaX21fCeifO/SfEJcoSaZKtRR3a
 MHj4wHqX9E13+h4I4AUudjSoj6Mu/ozHYe/Zgdszo+IHHC7qsytjhfgUubVoEgt2wyMx
 uFXyh1nW6FT+Vs79bNqJs9I72YTsuqUi5HS9DR2jM7FuMTKH/ThhxgC4dN4EZa5P14F5
 JxTP07CeipH5L0tK8XGuAkiairNq+cyoWWNsa/bVGkKg/M1DSznSGLXSDj0bUdyl2Mrw
 jW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788068809; x=1788673609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PVHcQLcdz8NGU7N37B5+qw6VJnaEnt6x+iIyP/dx+aw=;
 b=EyF3lLoKnie5z1eBj8c1C4JFH6DfGnvpahtTox7PBUK0h/+h+S9OWLoV9RQnx0GrTi
 Q+6cgwYZXrDIFaukGUVvSBmbVlgSifGTvLMgGsqnFBzDr+wxe86owF1XBQWQMFB5tR0e
 U+6DRJY9mjIdel8pnYESBKZhm/0buZhaIacCxmk5YNoKTupRNFKRnXz2xvxWLie7fMtu
 naTjfggIK85ERetrtJTg6H2TYg6609lllI2AhvqnLgX2YfEvX8Trw3ZIPCscrkYg9SJC
 dYz1QFeN/uJE8+yFvTP8l+maquITPT1lHrF6JggM5c6Z+tU8qFqRKLGrAbYfxz/MZPWT
 GTZQ==
X-Gm-Message-State: AFuF++li0sTxRgJOwmT/x7tikFpa1vmYj9v6KJ9tZNkSmEPczWRe00NG
 fcmxEe79Zx8vbHN2rNbxLIZlp1Ml0b3Gk9/3qUTBo7fNutwKMdpSpqYcPa/aVe51T+ffJQ==
X-Gm-Gg: AR+sD12+Q9YwfJaNxqw99D9RFQWXza59XYewOpWgCTbK47B+g17kmnNDcw5wsVxk2xl
 T4iY9z9j1FgwObNb7FERsDCQKJJxh//OwkPISYtN9OlXySlEnUDNzHUQE/yhCvwoDrLRK16bxDa
 u5t416cOOnoiizVJv4TGF/fx/kiDzkTPLiC6jogIEOAWqiynzk7trT9ttaOsgVckzt5avywJ6kZ
 F2cTGPDA12WkaZNcTz/daC1d5x6xj7qt805dDJpZjuHxMbjubIwQbSC6lsMFESVMf30WNH3/tw4
 ZXLVwMvgOINZQOfGhYltT6i+3QbdnmoKO4Dv63K6ddp+/KUkfnpFfaZtrKTnjQN+ATcTykbHcLn
 GAavtlXwIMw9NnFaCWurBuW+5Zn3kqdRrmgpJQMvwIi2j9UDPmnnuTf1KR9OnVUf4nhqz0Yly5j
 VxVJT4+VHZ1RBfA9fGO56nslHg3HaW9GfrI2qmWWCKJuhc8f5JnftmZ+BLnZxquOrGRT2hCg==
X-Received: by 2002:a05:6a21:a09:b0:3b4:61f:1fec with SMTP id
 adf61e73a8af0-3d26668474amr34574012637.2.1788068808836; 
 Sat, 29 Aug 2026 22:46:48 -0700 (PDT)
Received: from colazcyASUSlaptop.localdomain ([2a09:bac5:636f:183c::26a:c4])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286fa5517fsm22878963eec.31.2026.08.29.22.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 22:46:48 -0700 (PDT)
From: Chengyang Zhu <colazcyg@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	Chengyang Zhu <colazcyg@gmail.com>
Subject: [PATCH RFC v4 0/1] the org.qemu.Display1.UIInfo interface design
Date: Sun, 30 Aug 2026 13:46:40 +0800
Message-ID: <20260830054641.45437-1-colazcyg@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=colazcyg@gmail.com; helo=mail-pg1-x534.google.com
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

Currently, the `SetUIInfo` method cannot set a refresh rate.
Simply adding a refresh_rate argument would break the method signature.

This patch adds the UIInfo interface containing
  * property `Supported` indicating whether console UI info is supported.
  * the method `Apply` taking a dictionary as input.
  * the method `Get` returning the current UI info as a dictionary.

Changes since v3:
  * switched back to the dictionary approach.

This patch needs further discussion on:
  * Updated/Changed signal as mentioned before in the v3 email thread.
  * necessary test suite to prevent dictionary schema deviating from QemuUIInfo.

Test results:
  * qemu:qtest-x86_64/dbus-display-test passed
  * qemu:qtest-x86_64/dbus-vmstate-test passed
  * qemu:qtest-x86_64/dbus-vnc-test SKIP
  * manually created a virtual machine
    and successfully set its refresh rate and resolution via `Apply`

Chengyang Zhu (1):
  ui/dbus: add org.qemu.Display1.UIInfo interface

 ui/dbus-console.c    | 106 +++++++++++++++++++++++++++++++++++++++++++
 ui/dbus-display1.xml |  50 ++++++++++++++++++++
 2 files changed, 156 insertions(+)

-- 
2.55.0


