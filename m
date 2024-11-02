Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D0EE677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 12:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7DhK-0004Kn-1A; Sat, 02 Nov 2024 08:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7DhE-0004Jq-CV; Sat, 02 Nov 2024 08:57:40 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7DhC-0003Wg-EQ; Sat, 02 Nov 2024 08:57:40 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso377488466b.3; 
 Sat, 02 Nov 2024 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730552256; x=1731157056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RofW2EIjov9NM+DmNgmgHQcOhXHENpAoqGCKcsDoaPk=;
 b=XQntati3nOx2bcielvksFNuRW41mcpvjcgR3/8XvPB2uwJ+dxZ7hvIZiObB9JzhRWU
 O7PR31zyalhLhLO1A4yB3tzMS3v56hgAgcZ5PYZR7toYHnTc0imFmDxmiJ9t9EHf46ij
 keeFHy4FozczopQ1Z3DFtxE/WXTZy14YoiRvMxERqAmAcxignMsFbdySXdg2gm+NnGuS
 Hm/+qjsYgYLMCqz+2atPRvHEcDvm7nsbxiyH8g/MXEpUAz5yrnk49uDr8fDu42Ll9TZT
 B2PdaPhLO+q7U5UMwq8yA9OUV2JsGI3Wx37BTkWV0F+yiq9zAvlkz1vyJAWu0s0P7qQj
 VTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730552256; x=1731157056;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RofW2EIjov9NM+DmNgmgHQcOhXHENpAoqGCKcsDoaPk=;
 b=oqQiCpg4csBaNhROaGnJJbzUyNj/DeE3NuvNJFm0V/SX5hmPBmFjIO+zUzsoItfWQM
 VCIqJFvxkh2IKcCpIEr7TeAjYeBctqSd1+/xkCTe+NbXGrBIIo4c0g84AWzJnqIHkLf9
 qAlqp6MDRAjmqY3uFD3ATl8VxOEaME/RwkPyeedC6MR422nAl70llz5Us27rlv6x4Cfq
 g+GhdMA0BpGkzj56zZsSq/J9i0od+z4W+o5dX0qCLlo2D/VpBXtfvuP7IUr+jC3wx762
 ESMgHW56XLyA37hAymdxl+E/683jiTexucQbOW/ylPTVV/07paeanYLEHMzlnVie/aBe
 NQPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU151vSuMJUKWH2E8Od/z4YUF+TOUXPuTJnSmPVomP7LUtTSvnS2fpuh4MTBdWVJxozbyEfxKfSBA==@nongnu.org
X-Gm-Message-State: AOJu0Yz5dJMKclD3imSOUuT4aZLouY307eXfy95aU7O8UQR4rMOpzShc
 PFS0iQal/0KohMnKDK3cb501/zJJdYQtlWjV2n7jfdybcMCsT2OH6ZA08Q==
X-Google-Smtp-Source: AGHT+IE0kjnkiy1gtZVrrDn1fUm+MmKJN59sOv2lS5S5nCE5fsFDnzSiNiaxJxWwrtUSNvCuVEKjLQ==
X-Received: by 2002:a17:906:6a28:b0:a9a:e9c:1d8d with SMTP id
 a640c23a62f3a-a9de5ed2633mr2508064766b.17.1730552255369; 
 Sat, 02 Nov 2024 05:57:35 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e566846a7sm305836666b.206.2024.11.02.05.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 05:57:34 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 0/5] Consolidate lan9118 phy implementations
Date: Sat,  2 Nov 2024 13:57:19 +0100
Message-ID: <20241102125724.532843-1-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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
Testing done:=0D
* Run my usual sabrelite load and verify that network works.=0D
* Build and run Buildroot's qemu_arm_vexpress_defconfig which includes lan9=
118=0D
  and check on serial console that IP address gets assigned.=0D
=0D
v3:=0D
* Don't add SOFT reset, use device-specific method instead (Peter)=0D
* Reuse MII constants for MII_ANLPAR register which was previously missed=0D
* Fix off-by-one error in MII_ANLPAR register which prevented MII constants=
 to=0D
  be reused=0D
=0D
v2:=0D
* QOM'ify + mention boards whose migratability will be broken (Peter)=0D
=0D
Bernhard Beschow (5):=0D
  hw/net/lan9118: Extract lan9118_phy=0D
  hw/net/lan9118_phy: Reuse in imx_fec and consolidate implementations=0D
  hw/net/lan9118_phy: Fix off-by-one error in MII_ANLPAR register=0D
  hw/net/lan9118_phy: Reuse MII constants=0D
  hw/net/lan9118_phy: Add missing 100 mbps full duplex advertisement=0D
=0D
 include/hw/net/imx_fec.h     |   9 +-=0D
 include/hw/net/lan9118_phy.h |  37 ++++++=0D
 include/hw/net/mii.h         |   6 +=0D
 hw/net/imx_fec.c             | 146 +++--------------------=0D
 hw/net/lan9118.c             | 137 ++++-----------------=0D
 hw/net/lan9118_phy.c         | 222 +++++++++++++++++++++++++++++++++++=0D
 hw/net/Kconfig               |   5 +=0D
 hw/net/meson.build           |   1 +=0D
 hw/net/trace-events          |  10 +-=0D
 9 files changed, 318 insertions(+), 255 deletions(-)=0D
 create mode 100644 include/hw/net/lan9118_phy.h=0D
 create mode 100644 hw/net/lan9118_phy.c=0D
=0D
-- =0D
2.47.0=0D
=0D

