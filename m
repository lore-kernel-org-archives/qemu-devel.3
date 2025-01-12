Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EE6E7719F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6He-0007Xu-Gx; Sun, 12 Jan 2025 17:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Hc-0007XD-OP
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:12 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Ha-0006Qe-JR
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:12 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso26169995e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720289; x=1737325089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJHT3s1ONSG5jZqV20HBUz7r39y/ubJFRV+s022Q61U=;
 b=GqsvR3HwWXDC7h9h1NKSOBlBWIxm+tVCIWqb3/Ysp58EBYIbR+tHj6SYo4iruOvIAR
 IsaDMaeFofLSvDJ6Rc6A/IJiEtIBijxNY1sXGjd5D8tQFHJ6zuqoFrk+SXQsllghITjZ
 Ad98IWN07geL4ayJlFDd31eVnSIApvh2rRAys9uee3NaljYKAmDOTpmM/0u0oPxiWup3
 rIkBrDyqq4ACqzMUjt0PwPVhI+i6OyIB36+5BT/9VIC3+6mTEPJhAut0HzGBXv7I3J7m
 RX7GLDU9lFJaNiGDFs2Ue4ymadXGbFbQngYl/ZoSlocb1wYDwLf/ajefC6lJr62D0GZS
 hmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720289; x=1737325089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJHT3s1ONSG5jZqV20HBUz7r39y/ubJFRV+s022Q61U=;
 b=XOXH983vV2LqJSz2zLKzj6jXb/z+hGw2x5md83WGngDWZD3MXjjT3oLSZeF8cxfhDs
 JfIyTxstYxvZGBNZCLNHv5xruqUn2tfP4BJduuPdVz4XcVlMunogOiRvlZJc+0UQqZgi
 l3TBn0jFaRUEK61PvWtMUlaZdkJ4IouzJ0INGxAT9VL5AxHtVPT54fKAirMa8T8To6nP
 YReIEhAEiUkSQupc1cZzvbMRBiNofQxvjojdVo/PLG6JoLUbRhEvWbJXP9gzIFPYW8Fe
 7+GlwzkYXB5cWJAZzplRmKrzQ0lrNdvDtozgg1UF1dTeBGUw1JHGFIC7XTrY35N7NWMs
 o35A==
X-Gm-Message-State: AOJu0Yz2QAMDd+5jjDWwLT6FaXAiKD+YEO0PQU3KacmSR2icqZu9WHL0
 bAA+2T9Nzc3ubJq1qeWH6HTr9ZtwMIjT3Ifykf3MuJxicODUDAQwG1+AcXo/f61SGA6n6xqVU1u
 qIm4=
X-Gm-Gg: ASbGncuJEyg/7SDW+VIDUg6ydzmmIYfr5i0IDPPhp+0SHllw1Z6l49/TP40BAgHfgn5
 I0oU1Hwkd/GQu1BNZF7xPOzrOhu/q3lFe2j9qmvpUwQzVM5h+itQxOqulI3bdLsFRUy0MyHlgZu
 7okHMb7V6LzWyS3d/vIm+gvTGghyqGaMtSu++Tp4Cei/uC2U4IVm+gpgdsSm76xH8epCjCYXLHP
 67ooqsTN8IfCPPkfNGnC4OLws20/ddmsScOexJm6NAveYHIHjndB4dz1eV1Eu1j5FdOPWDgoq+x
 AMdJFGR63BwHyZNYem8bkc+gLEmKrds=
X-Google-Smtp-Source: AGHT+IFQk9S1CwP0aBwxgo560lMzsbQFN2ZVbdvEwGb3M4UnthJPz5UIe3gorJzdYbOywTT4S6V+rg==
X-Received: by 2002:a05:600c:1ca9:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-436e2551d7bmr178901185e9.0.1736720288857; 
 Sun, 12 Jan 2025 14:18:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e6251asm127625035e9.40.2025.01.12.14.18.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 08/49] hw/net/xilinx_ethlite: Map MDIO registers (as
 unimplemented)
Date: Sun, 12 Jan 2025 23:16:44 +0100
Message-ID: <20250112221726.30206-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Rather than handling the MDIO registers as RAM, map them
as unimplemented I/O within the device MR.

The memory flat view becomes:

  (qemu) info mtree -f
  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, i/o): xlnx.xps-ethernetlite
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-0000000081001fff (prio 0, i/o): xlnx.xps-ethernetlite @00000000000007f4

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20241112181044.92193-7-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 88ab331acce..442467abeb8 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -28,15 +28,18 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 #include "exec/tswap.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/misc/unimp.h"
 #include "net/net.h"
 #include "trace.h"
 
 #define R_TX_BUF0     0
 #define BUFSZ_MAX      0x07e4
+#define A_MDIO_BASE    0x07e4
 #define R_TX_LEN0     (0x07f4 / 4)
 #define R_TX_GIE0     (0x07f8 / 4)
 #define R_TX_CTRL0    (0x07fc / 4)
@@ -72,6 +75,7 @@ struct XlnxXpsEthLite
     uint32_t c_rx_pingpong;
     unsigned int port_index; /* dual port RAM index */
 
+    UnimplementedDeviceState mdio;
     uint32_t regs[R_MAX];
 };
 
@@ -232,6 +236,14 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
+    object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");
+    qdev_prop_set_uint64(DEVICE(&s->mdio), "size", 4 * 4);
+    sysbus_realize(SYS_BUS_DEVICE(&s->mdio), &error_fatal);
+    memory_region_add_subregion(&s->mmio, A_MDIO_BASE,
+                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
+
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id,
-- 
2.47.1


