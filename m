Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CACF1091904
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3IpL-00059s-AQ; Thu, 19 Mar 2026 15:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1w3Ip2-0004jJ-Ry
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:14:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1w3Iow-0000o8-Sq
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:14:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b49819938so684521f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773947650; x=1774552450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG34KLIz8Yh+mBr+AkPrQLstqlq/You8bypDWPVEkXk=;
 b=h1bNvzFuN+2chdsuzpRZFrJ9NT1JzG5a6744uqRXn1YPJ3ldHKUQf/+hezsAfjQdzI
 rkaVm9gugziHWTosH+NSz4UKkbPWJW46tUf+nRo6gJcWEsjSkRlg7+mZanNWhab1nhvj
 ktDPVP74CO0TgRljiwZI+yFgzOMKItig4G6J3XqimcauAEYj9cd73KlyqGpCin2Ihpgt
 BxtRVcHJhwbWO2ViymfhWxTbNEeDNdwAXoisE8DqMq2sBlrLntjXIBR0TzvmnggIlI7q
 ZUjSmJmO+KVjzLMZkeV0OXeNgUd5yebdoEP83hgy/DDwe051boPSdTc5rftG8gEuL2Rk
 ICpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947650; x=1774552450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lG34KLIz8Yh+mBr+AkPrQLstqlq/You8bypDWPVEkXk=;
 b=IDp6PqCgsB4MfIODXwqfDF1Nv3pS/HQL4Ly2+0z1It0Mqzv/B+J2w85h0W0o9S9ATd
 +1yDoU85FGUl7JMokWbgjDd0W1p1N03b+HyewUnuyv6sNoNfbsfdQEflQK3EeTXdyJxo
 lLbF9fOSiFYK7Z7aIzxAzz4EVIWsO7zsUXxsXGBtP9eXUtBhp3Ypod07QtVOVkP46AfB
 zGxiwEhHb4ths2dsIlEZmAEgVmTlmti3v/d/ksxjxr9TKo4ijOCXOu5dyQEmiqCTMu4Z
 T6Uts/BfP6pSw1ZVgzoCL2RVF/Nfn+KFB3AoawnbRWnPXZseQscJhdp5CIhAo3lXP17M
 5wmQ==
X-Gm-Message-State: AOJu0Yyg4Lgr9vN5cMzn8MZYMNT9k9kOcnXwRlPH//yEfUqTQYcTwqNQ
 hNcWbrcAzM1SIOk+LR0i1ToeKJL5e1h8Ou7RKE1csNplsDsuHkGwRxfyHaD/2fnf
X-Gm-Gg: ATEYQzyDNTGWVlVVL4898SgZyJKttdPhM3+scFcwcZd+ew0Tx/OwzpAuHr/ZNmP8Bnn
 xP+wuWpT/KXBWkaYFmrLjajcSUOJh3jZaxFstuIir8ObFf2n31pkhWOhHH4slwMgpAHdCI4qzJ+
 R7b+innwW+mSRUOA9HEmyv1Y+0nDavXj+ok/dRY07e/w2+GpBN4eUqLGABHx5IMkvE2TDnAkGy+
 tXRLEXxKh5bc7dGPUeb5kJgOO1ZCUV19CwOANnUGBW0Y89yqOY/b6/EYWhhQf/o32KGjaVzYUUW
 SCNLGQ809ZuSe8QIt+w+s3s6d6Sp887i6sf8tk+UVPqpfjOn31MPPYgYn0PdFo1sINyO5+blSoX
 mJGufKqw/RsTXFnBEWqcZzcS/Iz+YPWcjDKflL63NcjF6P4iAWkIWzioJirNs8pvvrxqHqjdKDc
 vZq6W+oKfP8vBpOSQe+VlFesDxHp+iasRI8Qf2FLMujEh1NpumEmCKWg==
X-Received: by 2002:a05:6000:2486:b0:43b:4e01:4aab with SMTP id
 ffacd0b85a97d-43b642812a5mr848909f8f.37.1773947650337; 
 Thu, 19 Mar 2026 12:14:10 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm635921f8f.32.2026.03.19.12.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 12:14:09 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v2 7/7] docs/arm/sabrelite: Mention FlexCAN support
Date: Thu, 19 Mar 2026 20:13:14 +0100
Message-ID: <278347c16b34c91499166d3c52ad9b2c1ce3266f.1773866323.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773866323.git.matyas.bobek@gmail.com>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Also added example command line usage of the Sabrelite board
with FlexCAN controllers.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
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
2.53.0


