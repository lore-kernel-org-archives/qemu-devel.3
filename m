Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BE9F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzczr-0005ky-K0; Mon, 09 Mar 2026 11:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzczP-0005EI-7p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzczN-0000se-JG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so21347415e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071868; x=1773676668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IzmpeICsmhHpjzqq103V8NsIYXc7xyq7TsCvvhiVxQY=;
 b=B6glUdxU6nqHySWDZaI/zBB52NzAaDREW6N1dSwEg/qy4Q/qDaX0HnOORO+W9FPTBt
 iq4vHddObCX+5bs7KtRmXjDvOxihQkNuUiXfuKzlmwQPrMajX5pEgeEz4JqPUz3jxp6M
 WMTdeh+8eHdHzUOtqrK1aDBw6VjyF/cOOa1qjvMmiC6OSyQQwTeV6DbcoqAQFmFi0hzS
 IQHJJanzBaqo/7yzXT+3TMGh0BO++gGPjmNB3aaUBaRtvs6rOLs/EezS6SBe8Flcg6J0
 JGPyG1OVm+v3PVGmXOyIdqS+TNRCfI3oj2hvI9OJ4KUMDomBV2yZ8PbT03bXmevbDweS
 uaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071868; x=1773676668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IzmpeICsmhHpjzqq103V8NsIYXc7xyq7TsCvvhiVxQY=;
 b=jnmHJ93Zmq6ng7Pkv0ZP1g8sP5m4oKO6Mii6BYcQJigVQIPHO2X83gRRYwzr2Jvgaz
 Dr0Ri63wTLxwTQkLPAxcTIW6g0ygmV1xmjQIrT4+q2hxEZkr0YSq3b55eP9zzTlssiBG
 KLQE1zb0iK9rtt4/KyUkSfiGfBPf7vyekXoIPLMGHGuqnmyQRBfkkapbHIv/9eOVdl0M
 iBl8BFQwJTJ0L7L2dNWj6Kib+Ge6LSIhS9g4vSLwcC8hQCpR3A+u5Pkiup3DGdegPTTr
 FEz3V8EneFIL/OK4DfN7Wr/KDv261S8lzwUq7VeJKxFpumSU5qKx8baKpnexBh8GCEfG
 XWAQ==
X-Gm-Message-State: AOJu0YwUsqRkDxMJL6gugaVEFiUeaMMNLAqFCCspdiube3YjkOcwGPxR
 ZtXPOOPIVdR7+Pq5zVh5TD7eP7UuZoXy6qHmzBBQT5yghWXbb9kVqtAzgeZ2CTGbDCPNYrc/Swf
 +Mp6WGJI=
X-Gm-Gg: ATEYQzxDkmSO1DhxO2Sso6mI03blAlzHIOulLSJLisL7UMnjNdj1Qh3/W9bdBDENypY
 Ze544TybOJFrDZepBEMRP3WHVoTLCz+Q7Upm83IJIzNBbIDL2uAAtQRSZd+R6d1qpyNbx2onzuX
 eyvQdT4NxtpGhcDBz4elVuYO4n8NBTQIZKtzLT42tfWWJvH3hk7bZhPNiB1pSaaemVXQPuhKTKO
 XdBppQ0mhdPGx+48d46polcHev5d8jZfjOov6i9RH2B1abbzUqHKB+081nbzSFtVGGLzQ1cgdSS
 sKe6Fo1kUxs0RhBPAAIb0asJX1WkGnG3BWDJzldECilzBkHTQMZdXdMHJ/TTWooJoJ+4NXxyhLJ
 X24fRg1y6BPMW3+WDbxiC/Lts41Ajvvpx5WBXh3iY+nLLgbVDBaw+t69A7Hx+ybq6dp4Mep/+DT
 WBpSe4zN4Fop+mL5s4fVADHiIB3zYR6ZFJuTcwPIj2TUbJ5cA1kBKXcMzHVCZQdK2N0Tcgi4E6
X-Received: by 2002:a05:600c:350e:b0:480:4a90:1afe with SMTP id
 5b1f17b1804b1-485269785afmr180533195e9.34.1773071867588; 
 Mon, 09 Mar 2026 08:57:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a9c293sm781845e9.10.2026.03.09.08.57.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:57:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/49] hw/misc/sifive_e_aon: Don't leak timer
Date: Mon,  9 Mar 2026 16:52:18 +0100
Message-ID: <20260309155219.62400-49-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The sifive_e_aon watchdog creates a timer with timer_new_ns() in its
instance_init method, but does not free it in instance_finalize.
This means that QMP introspection of the device leaks it:

Direct leak of 48 byte in 1 object allocated from:
    #0  in calloc
    #1  in g_malloc0
    #2  in timer_new_full /home/pm215/qemu/include/qemu/timer.h:520:21
    #3  in timer_new /home/pm215/qemu/include/qemu/timer.h:543:12
    #4  in timer_new_ns /home/pm215/qemu/include/qemu/timer.h:563:12
    #5  in sifive_e_aon_init /home/pm215/qemu/build/san/../../hw/misc/sifive_e_aon.c:286:21
    #6  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
    #7  in object_initialize /home/pm215/qemu/build/san/../../qom/object.c:578:5
    #8  in object_initialize_child_with_propsv /home/pm215/qemu/build/san/../../qom/object.c:608:5
    #9  in object_initialize_child_with_props /home/pm215/qemu/build/san/../../qom/object.c:591:10
    #10  in object_initialize_child_internal /home/pm215/qemu/build/san/../../qom/object.c:645:5
    #11  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
    #12  in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
    #13  in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11

Allocating a separate QEMUTimer with timer_new() is not the preferred
interface (per the comments in include/qemu/timer.h); switch to an
inline struct initialized with timer_init(), which we can clean up
with timer_del() in finalize.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260309095129.1406506-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/sifive_e_aon.h |  2 +-
 hw/misc/sifive_e_aon.c         | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/hw/misc/sifive_e_aon.h b/include/hw/misc/sifive_e_aon.h
index efa2c3023f6..e907aa7869d 100644
--- a/include/hw/misc/sifive_e_aon.h
+++ b/include/hw/misc/sifive_e_aon.h
@@ -46,7 +46,7 @@ struct SiFiveEAONState {
     MemoryRegion mmio;
 
     /*< watchdog timer >*/
-    QEMUTimer *wdog_timer;
+    QEMUTimer wdog_timer;
     qemu_irq wdog_irq;
     uint64_t wdog_restart_time;
     uint64_t wdogclk_freq;
diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
index 0e82ae3758b..e78f4f56725 100644
--- a/hw/misc/sifive_e_aon.c
+++ b/hw/misc/sifive_e_aon.c
@@ -94,9 +94,9 @@ static void sifive_e_aon_wdt_update_state(SiFiveEAONState *r)
         next += muldiv64((r->wdogcmp0 - wdogs) <<
                          FIELD_EX32(r->wdogcfg, AON_WDT_WDOGCFG, SCALE),
                          NANOSECONDS_PER_SECOND, r->wdogclk_freq);
-        timer_mod(r->wdog_timer, next);
+        timer_mod(&r->wdog_timer, next);
     } else {
-        timer_mod(r->wdog_timer, INT64_MAX);
+        timer_mod(&r->wdog_timer, INT64_MAX);
     }
 }
 
@@ -283,12 +283,19 @@ static void sifive_e_aon_init(Object *obj)
     sysbus_init_mmio(sbd, &r->mmio);
 
     /* watchdog timer */
-    r->wdog_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                 sifive_e_aon_wdt_expired_cb, r);
+    timer_init_ns(&r->wdog_timer, QEMU_CLOCK_VIRTUAL,
+                  sifive_e_aon_wdt_expired_cb, r);
     r->wdogclk_freq = SIFIVE_E_LFCLK_DEFAULT_FREQ;
     sysbus_init_irq(sbd, &r->wdog_irq);
 }
 
+static void sifive_e_aon_finalize(Object *obj)
+{
+    SiFiveEAONState *r = SIFIVE_E_AON(obj);
+
+    timer_del(&r->wdog_timer);
+}
+
 static const Property sifive_e_aon_properties[] = {
     DEFINE_PROP_UINT64("wdogclk-frequency", SiFiveEAONState, wdogclk_freq,
                        SIFIVE_E_LFCLK_DEFAULT_FREQ),
@@ -307,6 +314,7 @@ static const TypeInfo sifive_e_aon_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SiFiveEAONState),
     .instance_init = sifive_e_aon_init,
+    .instance_finalize = sifive_e_aon_finalize,
     .class_init    = sifive_e_aon_class_init,
 };
 
-- 
2.53.0


