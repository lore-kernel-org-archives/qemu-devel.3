Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC4EC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 18:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt9px-000899-72; Fri, 14 Mar 2025 14:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tt9pv-00088H-BT; Fri, 14 Mar 2025 14:32:47 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tt9ps-0007gp-Se; Fri, 14 Mar 2025 14:32:46 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso6283173a12.1; 
 Fri, 14 Mar 2025 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741977162; x=1742581962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAO3S/7q0ZinhoijfNeacj7mj7W5fG+tqzSOImMUvxo=;
 b=UBNy9Po5sRLFhbVUglPCpubKp09vhuv1+nJ+ere/bomrOcXaNM+nFaUaVefCrE1nrO
 gBVTfoQjKHTco6uR43XKxG9tdm24r6nb7Of2jHjiOiur6IUxer9qIgrCQOMpqQ24AMu7
 ve7FapXgTdQ0VGun9Sz3rKn8cIzy0rSplxhyGUK7jpDf1v6Viq0lY/HP969BcYTyX6aj
 faKSS+o8BrLjeVuocut0ikPHe3dsI6b53rw4a2yHLzK4dszTvijVMCcNgAUeaSAI0K91
 Z6YfH6DUXGjzKHhf+yE5jXeDytmQ5NHJP+84MT0/TsNOL6vaJztBU0GVGPaBO5nRQbOA
 8t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741977162; x=1742581962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAO3S/7q0ZinhoijfNeacj7mj7W5fG+tqzSOImMUvxo=;
 b=Arb7EsOwwvD7urKzMO/Z2r3o2ZpEutMNRQNkAh3rlxlOJnePbOS8DDOJWB30SpGV3v
 ZnND893zh/1VXcqq6Tl9PK82p/0/QbxztGp7ZxNqnYHPzSL8+xujMpygLdn8LoB9r7qI
 kah9szs5yhLenyOrQ2ApGyDEJZgmohfzUNRxG4HrAtSUcKhwUKbt7KpOKa7WO7dW0fwX
 Cp7pvSKHhr87zQurbTWuczO3qOOsDbtBdtb4e+9sFNUVKtrZcYm1z3wher16O6eIfzQC
 3q7ulb3Ae9RyM6Cga2P/bKuXPbFAs/6pIshugdVcceJnokpFbWtYJfeRn1VmeMXwk9sa
 j5wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH2rjkT6+FdO0fy0nQq+ncWD8kFF4fi5zWXIkVvnt01PXXnARCb96gixJ0hO7mf/Nt7fdMBfygmw==@nongnu.org
X-Gm-Message-State: AOJu0YxsRVwdVZPLZQcFwizf9oXAd0K2KGytoqfFojR8NfXjGH1ULRdl
 GnXjCgeU6UifEOqX/jWJfE3gz7Sd7Z6QEPgHalVCgkTDrQgwFFn1ptuDWA==
X-Gm-Gg: ASbGncvYqF666Uel2tL/rVowi1yTN/FSCPCTO1RgO1WdXZv10c2ueP3Wwcy6lKjgbou
 0JYIYaUYg9d9wzqZcTktHtrwFevCTgxhIl5SGHIfxvn7jbly180Muc1aRwEvT41V5uUbfE3rRlT
 EBD1HddaprH6w/rhmk4XotakUThSbKn9nIKzvK+taMFtHW2OAZERE6+bd+vYTCENThNCzIv4Cg1
 /4mcntBejYFX8+oNlq1W3rps2/Af3xrG16DdEw2+lA1Po2yJy36828YDzmKQba/9HYSHFZoBDzU
 r/cb+3mvCQa1RTaVimiYzkgD9T+yVoH4InBrqNlCTtFUhiLzHbLKeq6yNKWlCbNktr7m2yQffBS
 PYgSdyQxIHaXuxYdvoQ+apAf8eryXyA93dFtHRWvAWlgtq1vsb70Mp70/QuD8Si/2
X-Google-Smtp-Source: AGHT+IG7/egpgEfm6ICsM/9Q5G/MIXtrpNJDO6v7CeyBPYh3hDmkmS+wFzWo6BAMtZpH2y2sFCiFPg==
X-Received: by 2002:a17:907:178c:b0:ac2:b813:ac25 with SMTP id
 a640c23a62f3a-ac3123415b4mr880350066b.14.1741977161610; 
 Fri, 14 Mar 2025 11:32:41 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-1ac1-f400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1ac1:f400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f0ca7sm262104466b.60.2025.03.14.11.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 11:32:41 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 1/2] hw/arm/fsl-imx8mp: Derive struct FslImx8mpState from
 TYPE_SYS_BUS_DEVICE
Date: Fri, 14 Mar 2025 19:32:23 +0100
Message-ID: <20250314183224.21822-2-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314183224.21822-1-shentey@gmail.com>
References: <20250314183224.21822-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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

Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon machine
reset. It also makes the SoC implementation not user-creatable which can trigger
the following crash:

  $ ./qemu-system-aarch64  -M virt -device fsl-imx8mp
  **
  ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: assertion failed:
  (n < tcg_max_ctxs)
  Bail out! ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread:
  assertion failed: (n < tcg_max_ctxs)
  Aborted (core dumped)

Fixes: a4eefc69b237 "hw/arm: Add i.MX 8M Plus EVK board"
Reported-by: Thomas Huth <thuth@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx8mp.h | 3 ++-
 hw/arm/fsl-imx8mp.c         | 2 +-
 hw/arm/imx8mp-evk.c         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index bc97fc416e..22fdc0d67c 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -26,6 +26,7 @@
 #include "hw/timer/imx_gpt.h"
 #include "hw/usb/hcd-dwc3.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/sysbus.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -49,7 +50,7 @@ enum FslImx8mpConfiguration {
 };
 
 struct FslImx8mpState {
-    DeviceState    parent_obj;
+    SysBusDevice   parent_obj;
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
     GICv3State         gic;
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index c3f6da6322..82edf61082 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -702,7 +702,7 @@ static void fsl_imx8mp_class_init(ObjectClass *oc, void *data)
 static const TypeInfo fsl_imx8mp_types[] = {
     {
         .name = TYPE_FSL_IMX8MP,
-        .parent = TYPE_DEVICE,
+        .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(FslImx8mpState),
         .instance_init = fsl_imx8mp_init,
         .class_init = fsl_imx8mp_class_init,
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index e1a7892fd7..f17d5db466 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -37,7 +37,7 @@ static void imx8mp_evk_init(MachineState *machine)
     s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
-    qdev_realize(DEVICE(s), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
                                 machine->ram);
-- 
2.48.1


