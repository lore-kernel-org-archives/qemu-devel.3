Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD07CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ6EY-0008QU-Iu; Mon, 15 Jun 2026 08:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wZ6EU-0008PH-UY
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:16:02 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wZ6ES-0003WB-Ke
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:16:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so2775996f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781525758; x=1782130558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVoIwb+vhh8sM7msaYY87Ws0rtfErG1nVoKxO5ce55k=;
 b=kg/HNcUKYD3IGwp7cFuVy+PIKjofuejSvYjjaWSc8DSSB1ybgpvTypuQgRcvNO3Lu7
 oezntDmTCyO21zDwcygpPFUI6j8HEy9bCYZN+Yacp8P29w95VEQdrSZDOmIKeVJsgjqV
 8zXkS0MGADlEJ756ed2IGnNZiqIOdBKC1qWyBOU6SWCfokWHfGkEskKFlAdBsn6htoRg
 3FilwbbRN/3lVvIywZT995Qq/YroaWx6grCrc2zWps1ZwEjpc0YGKlnP22pi4XPpySZU
 9UhSTg3z7yW/iTcZd9NPgSHNWWwYHJf08AOCJ1gcz1+h9mQOuqCFJNE+Lw7Fm2IHBZR+
 uWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525758; x=1782130558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iVoIwb+vhh8sM7msaYY87Ws0rtfErG1nVoKxO5ce55k=;
 b=Q+Wx6nI/+0rSEAh8aliv7a7v0VFZCQb/9Y9Tam6PwFM8TIl/cqUOURPFiZPhjN/LGT
 dQtJgVGRZ019QKVLwqmtxR81nzOJzof9NF5K6F0wD9wucImPL1FFnJ7ZtNFzK5+9BsbG
 7rHkjqORUaoSwtSwYc4YOP3Lvsn+zKvEJiXIM09idOqLXXqLATsW8AycEgj7381QfdaR
 NP7RsaFA6ejXTL+e3NUBJVou/ARWP1o33p19nl6RtjDI/kkwL1La9YYVtpoF5hqr+57r
 jMy9vTT0zoBS4rWmOC5bYecpev4bVOTVgUilxmOzSrAK1Lj8pgh0yem2GK/HCCQ/FNbZ
 fCdQ==
X-Gm-Message-State: AOJu0YykhFVUCr11FmpV3UpKaJTyONwZ0N2vNp+OaE4M/J2c12EDf+6j
 FOcaSDPprisdSlzYNKSn9ejPqSVOBfEzzZNE8xeO5R3fJ4GK7jDY4Dx+N7OByySW
X-Gm-Gg: Acq92OGrYT6llP/lYu216QR7FxjpOle9RfaswSuZ6fGe2I7MQ9Yc1eDsqQwpnlx9KoD
 nJ8hxVzWCZWz+t1/QoZy2W7f1gK+oygI8CtPxtczTVdflsD39f8yk9n6xoYkw9+l7crYUK/0sLg
 LM05nXpo4fOunjzb1bYgHZKKnv3CXx6Lt2rFGD7+kDd/1Av8of0FI9/KfQu9hVSBVGMGNDHfWeb
 ShKX6Gjb9BAOk3YuT/7BVb8F+zLQxmH2DLK7qNhW5J1x2f2iH9MFWfinIblbXaQubV5BeOb6Vsu
 LtCy1mTWvaJEBjW+qScbX+Pw9K0h/c0PMpjcjpKEwKW55dNdfxNffeKrBAYDsjLtTqfQ6zMsq6k
 Ak65OhvxYXuvmfo9CHN+vcpPd1nXnrHLGjZ4qfgVE5taWUP8B6kKBKzA6xu+uRzhh2zG1/TeukO
 A68bBtCI8gyz7FsdpjY00nBEM6m5u0PBwzPJTZRMPyFEWAE2UcjF9Prg==
X-Received: by 2002:a05:600c:34c6:b0:490:3fa2:1b93 with SMTP id
 5b1f17b1804b1-492200768d2mr121180065e9.13.1781525758446; 
 Mon, 15 Jun 2026 05:15:58 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm338491345e9.0.2026.06.15.05.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:15:58 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrey Volkov <andrey@volkov.fr>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v5 7/7] docs/arm/sabrelite: Mention FlexCAN support
Date: Mon, 15 Jun 2026 14:15:07 +0200
Message-ID: <3949379687210a6026d3a4ff5d99413d38390b79.1781111270.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781111270.git.matyas.bobek@gmail.com>
References: <cover.1781111270.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wr1-x434.google.com
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

Also added example command line usage of the Sabrelite board
with FlexCAN controllers.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
---
 docs/system/arm/sabrelite.rst |  1 +
 docs/system/devices/can.rst   | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/docs/system/arm/sabrelite.rst b/docs/system/arm/sabrelite.rst
index 4ccb0560af..d3a3c01dd6 100644
--- a/docs/system/arm/sabrelite.rst
+++ b/docs/system/arm/sabrelite.rst
@@ -24,6 +24,7 @@ The SABRE Lite machine supports the following devices:
  * 4 SDHC storage controllers
  * 4 USB 2.0 host controllers
  * 5 ECSPI controllers
+ * 2 FlexCAN CAN controllers
  * 1 SST 25VF016B flash
 
 Please note above list is a complete superset the QEMU SABRE Lite machine can
diff --git a/docs/system/devices/can.rst b/docs/system/devices/can.rst
index 09121836fd..622f898952 100644
--- a/docs/system/devices/can.rst
+++ b/docs/system/devices/can.rst
@@ -173,6 +173,30 @@ The test can also be run the other way around, generating messages in the
 guest system and capturing them in the host system. Other combinations are
 also possible.
 
+Examples on how to use CAN emulation for FlexCAN on SabreLite board
+-------------------------------------------------------------------
+FlexCANs are connected to QEMU CAN buses by passing the bus IDs as machine
+properties:
+
+* property ``canbus0`` for connecting ``flexcan1``
+* property ``canbus1`` for connecting ``flexcan2``
+
+Note that upstream Linux SabreLite DTs have only a single FlexCAN (``flexcan1``)
+enabled.
+
+An example command to run QEMU emulating a Sabrelite development board
+with both FlexCANs connected to a single QEMU CAN bus (called ``qcan0``),
+bridged to host system ``can0`` interface::
+
+  qemu-system-arm -M sabrelite -smp 4 -m 1G \
+    -object can-bus,id=qcan0 \
+    -machine canbus0=qcan0 -machine canbus1=qcan0 \
+    -object can-host-socketcan,if=can0,canbus=qcan0,id=qcan0-socketcan \
+    -kernel ... -dtb ... -initrd ...
+
+Note that in the Linux guest, bitrate for the FlexCAN device is ignored,
+but needs to be set via the ``ip`` command.
+
 Links to other resources
 ------------------------
 
-- 
2.54.0


