Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46198CD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIW6Y-0006lx-Uq; Thu, 30 Apr 2026 14:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wIW68-0006Yp-KA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:26:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wIW5n-0005W4-5n
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:26:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso1128650f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777573586; x=1778178386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FqtVcPHAZflQMEOZzPUgTgk2Z8Mej9pLLjAUASB2WVY=;
 b=ii8JR5AXRl85MnsjQi6uBcI1ftpheW4nRmC8ODHeRvJ2GFE4nAo6QCFzTypzvM4cKl
 CXIB8ZJxZUNakHqQ60EwpOTjAgJapNlECxsR0v3G3FRt8jO9rS8tJpxni5oZ5hxiJYR2
 J7IfeZMOPW2FmfhhajowUoZolnzpmwBeBQBHj+yOVlOITr99+Z0pMe4+4MUpnFW9jndz
 OLplFNmET0OnXRvD/8ytueg9LMHgpShUTvq7igZNmmYHRj6uobDJF6WZfZkjsb04K0Tq
 HY3+6BVOK1moScMjWWgjEcVkjapCNdIu4hLijb73ECO+PncpayO+iKozjXoTrbIvWG7W
 eHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777573586; x=1778178386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FqtVcPHAZflQMEOZzPUgTgk2Z8Mej9pLLjAUASB2WVY=;
 b=NcQTEUfrKdXsjQhVNXCtlvqJJ3zTGbfOqFI/F5jugi92PmIgQGaQhQ1rQ+89wOg4/g
 Rn3HxENuMtA3D+nehE4iU7R5SG6oXSVyzheJk7BKHbgxtGmyYA8crrs3yCfJk0qJvviE
 aOldVkW5FlOgVPcb9rqz1prLMQ5QaaQL/DPdcUR1CkihCJHcP0HKHKl3tys012s7sq28
 ftVaBkrggMFQAt+CQk9XJOoRDXINUdVSP7K2/Tu20QCSarGLy0ZFx133xG93PVJORjpm
 gTtVkfARVe4SliX1ud7QQ2E1ArZp5zrCMyFd3gzjEmcdH3y6MMuUSykCZBDqAClmwDo1
 8eXg==
X-Gm-Message-State: AOJu0YyLqRLDUgF07bgztf0KKdXOUNTOBFsqUrWpBQI4E+FRAW+OCooh
 a0fxCncI5Dp410ekB7Z7q5XFi/mYkUMiO6SHODtVng6hjZePKksmhiVS1u/ymIvz
X-Gm-Gg: AeBDiesISdwqwKHvLkWGs9Yb9CxKX2lIZDgkm3rKe+YIOD7sE+AMeQii6yDHfV1dYQD
 Dki/xHnEZezsQ9/eJBFZM34V8JLEkyneCHh7ACAnSj/Qv67mHTTmCWjQb8DaKPg2p8hPi7JVLhI
 7hZ9E/Sphg6VH/0tOECUkkcK86FDHdmIU9qbO//X6FWxKG83rzfAzu10jAmMXcblb/skopxQ2bd
 LO8VVpnzVpcOSNvqsn/nicMS0LIU0vHAwdWu6Q0qM7mGSL7nPLJwA0rLqB6N656ugLxqw9k7dXP
 kK5mdqfHyATYGwu8ZCifYeWhB4flmD+J6bpPjuSJUhIcJ3NxUsIgnCeAME2T1+HlButRZie0Qj3
 6g0drWdidZP/KZ0a+5WHtzEhDrub56bvLtTDoOZUW5UwMw9O0twEd0z8bxKWCJJD3sJ3idZKxSy
 B7THmymFYi7UkvomMjpek6xeWEPzEJg4LOEgCFnbpmlc/YzqIb4+HncAyUpoJqkeCD
X-Received: by 2002:a05:6000:3107:b0:43f:dfb6:78e1 with SMTP id
 ffacd0b85a97d-4493d7f9984mr6672655f8f.8.1777573586049; 
 Thu, 30 Apr 2026 11:26:26 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c00sm14674925f8f.25.2026.04.30.11.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 11:26:25 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v3 7/7] docs/arm/sabrelite: Mention FlexCAN support
Date: Thu, 30 Apr 2026 20:26:09 +0200
Message-ID: <b9e833f68e4a4dfaf3a2102f1c8f439138e46612.1777571962.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777571962.git.matyas.bobek@gmail.com>
References: <cover.1777571962.git.matyas.bobek@gmail.com>
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
2.53.0


