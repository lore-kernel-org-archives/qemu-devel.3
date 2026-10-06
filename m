Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B242CCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAy-0006i2-VM; Wed, 07 Oct 2026 04:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIQP-0003hJ-Gg
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:34:56 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIQD-00081e-OV
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:34:28 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a9bd4db6ccso4848459a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791344050; x=1791948850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b00qIVQjxzUez6mivBhAzHlvEuKBA7PieDHBj92W3ss=;
 b=RMABze1R3NQyc5onlebOSo2fB/n7TOPj6Q6/o9FMGSrH4L1KaGi9Z19Fbq9dcsWfvV
 4UY+vfxifgSjO28L/4xDvmkdql/398lJgSjpE7F1Q3IOfWIVMFkGpP/tBzWKMi6LJORG
 ywm9u5uvoUZipiO/0Csml8h/L45cnwhDbTLYdDhWZwr4viRbVXKWBupEpxOADRep9XMT
 AWQe7dfpzkkrXaqWYh7dw+Xo2lnfYXwPwrUOeyTiMr3DlbDS3Iic8SL2QupKCjU80CXL
 Ekh9pUh/kRA1to3/RtMIq+o74Ah4SyiJ34rEZovuCK/5Wv6XtMNuwsQvmvS9C5EsqUWK
 5IoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791344050; x=1791948850;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b00qIVQjxzUez6mivBhAzHlvEuKBA7PieDHBj92W3ss=;
 b=swhMuOj1gH1vygCdORRH8VLAH5m1b6Ub68bEwSW+a/Rs5hVzkNEoG+nFwc40gEKplF
 VK5IfMIjIE7vLvKJnSNsxGD57xRWM2Tyiu6LnlNe9vaTznlFlskSyixDjXcxUz6yy0Vy
 eZnw9q6L5t09OzjPW4RQPTjgNb9IL/94t63QH0Hhrb4+fwIVdrp+i2PypsaEsmzN7NH7
 AHUlbl3WOjvaawdXSK1we4bKohxyOX49PloAK9oPZ8zFVT7t2GgE8s22+4CU+DpYk3Z2
 ftjWOmND+POj7+s8ulxEK0TDzRQ3iqM/1s0xItaXChF6F+fAHBAgOPo+81M4zrr8qBU7
 bKdg==
X-Gm-Message-State: AFq9FYLOqxy9tqape2zXogVejZr2hFY6p5wMHRhCOExbzCYlkvw810rT
 fhFmIDHMCJPoelEdPAUqcoRSPi9cRi3TpY/BaRuNUXq1VKrNf6MQsHkzn1YvKw==
X-Gm-Gg: AYBFou3pPOQ3f1/K8vCASZacyypzjwKoCD/wIcSwN8sg+z52in3Vs7Ekagik4wiW80c
 UdYKIvivyv5siYG0zGIvKe2W/D1v2nvranV9eDE8da3hhB/BNd3YN/WZLCvREVb+aLFnik1dyAE
 f3Uj5od+avgD5Ri/H5vyYKwxo90lmfXCwtWDUVZzo6vM9BzvtuPNQwezArjT0fe/t/gzhQV+Nk2
 qCOFZWgoaPTezLoWNsrhc0wWlybrovg/jzKjLm/wUS1OLzsTZFp/LI7ahEm7wcpmiBjcYP2i34W
 hpfsZIwGL+Q64UqUn58LBfBe/DjByXCKiRTzgOAIuCoLuRMiqA6xWcm/Y5DAS+el6wkhOgb2mCW
 K/dLPjAxZrYBlFwKkTOn2bmF4JNwXBMe6ozRD5nGWWgAKflUDNn9enB+3tYv9OZCYBFT9GlorWA
 KDS0pu55bI+M7fEZokjA4fSVq/gmfPMNeQXWWZPf2s6RjReUh6GPPmi8dOeDtb+HhlaRqPPQ4G/
 NOP8tVNy/AxMBYPs41inftjeh2yDzz0LzgGHA==
X-Received: by 2002:a05:6000:29ce:b0:48c:67d6:a87a with SMTP id
 ffacd0b85a97d-48c67d6a90amr2803641f8f.32.1791275728163; 
 Tue, 06 Oct 2026 01:35:28 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:27 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 07/31] hw/arm/sabrelite: Have 4 CPUs and 1 GiB of RAM by
 default
Date: Tue,  6 Oct 2026 10:34:19 +0200
Message-ID: <20261006083445.30362-8-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
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

Having four CPUs and 1 GiB of RAM matches real hardware. Fix the machine
defaults to make its use more ergonomic and less error-prone. Also
reflect this in the board documentation.

To reproduce the old default behavior for e.g. migration purposes,
`-smp 1 -m 128M` needs to be passed on the command line.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/sabrelite.rst | 4 ++--
 hw/arm/sabrelite.c            | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/sabrelite.rst b/docs/system/arm/sabrelite.rst
index d3a3c01dd6..b8ac9548f5 100644
--- a/docs/system/arm/sabrelite.rst
+++ b/docs/system/arm/sabrelite.rst
@@ -55,7 +55,7 @@ To boot the newly built Linux kernel in QEMU with the SABRE Lite machine, use:
 
 .. code-block:: bash
 
-  $ qemu-system-arm -M sabrelite -smp 4 -m 1G \
+  $ qemu-system-arm -M sabrelite \
       -display none -serial null -serial stdio \
       -kernel arch/arm/boot/zImage \
       -dtb arch/arm/boot/dts/imx6q-sabrelite.dtb \
@@ -89,7 +89,7 @@ the -kernel argument, along with an SD card image with rootfs:
 
 .. code-block:: bash
 
-  $ qemu-system-arm -M sabrelite -smp 4 -m 1G \
+  $ qemu-system-arm -M sabrelite \
       -display none -serial null -serial stdio \
       -kernel u-boot
 
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 05dfabd937..34f302f83c 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -17,6 +17,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "system/qtest.h"
 
 struct SabreliteMachineState {
@@ -139,7 +140,9 @@ static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)";
     mc->init = sabrelite_init;
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
+    mc->default_cpus = FSL_IMX6_NUM_CPUS;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sabrelite.ram";
     mc->auto_create_sdcard = true;
 }
-- 
2.56.0


