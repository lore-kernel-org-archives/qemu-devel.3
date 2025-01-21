Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDC0C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBz3-0004eo-IN; Tue, 21 Jan 2025 05:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HX6PZwYKCpoNCNOMLAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--titusr.bounces.google.com>)
 id 1taBz0-0004Ok-My
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:59:46 -0500
Received: from mail-qv1-xf49.google.com ([2607:f8b0:4864:20::f49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HX6PZwYKCpoNCNOMLAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--titusr.bounces.google.com>)
 id 1taByy-0005IQ-Ke
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:59:46 -0500
Received: by mail-qv1-xf49.google.com with SMTP id
 6a1803df08f44-6d8f94518c9so126508306d6.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 02:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1737457181; x=1738061981; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UzR4VEhqh7U7JLvDc/M/DKVS4N7ahB3cXKMCv0bX05k=;
 b=jLOD8cd8eW/rJ/wyk4EZ1vKwhKvqh59SvXATIAeCx7kuXPxv6Xzei8Cfjdka9KIXv6
 v1fxinPpjPuTma1RcU1TAiLbYZVVdctnG3SYx9kHUUKj0Iwnh4JDrXNVebwiBvrFnpIJ
 H/Ve5Gn83i2g3d24zXX/jxlQecKovr75RdjF6f5LANCXYyeYgJpxiuZ2Pmj1xc5DVQo9
 6Mbh0iFbf8oSMPyTI857wJfiMKDvrGec+tVjBEVhnkDq1IlbbtnWFq4G+KULbjlk8SNc
 hsyE9lb90nRNNFIjfRCpQxscfsncB/dwbowCkfOWW5GyDoF3nLMcDDgAL9Lyzh+wC6rq
 AiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737457181; x=1738061981;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UzR4VEhqh7U7JLvDc/M/DKVS4N7ahB3cXKMCv0bX05k=;
 b=R7/a1oawVZGsrGgvIaBVGkZvK0pqThWTOs/jtMiaMZvnJQ9zv8G53TQ3d9mQYJ9grp
 w+pIp1hvobNQQ4Mq846tCuhKk1R4p+9o1/ycgNMdG8PUXwMiF6PjKXecMLn1L7uFet8t
 MobWMG4cCFeKTaO2k26krX33ZhznVA2sFfltS/uRicTPvsu7J8nzhhuu/Ad6pR4QCYgX
 d+YctknHAV1MVBEOGONOLlavmbUe9qPtZLeTIFXuNWs9eSdEwplEG1IkcPUAEbYBv1Jn
 kd3zVitp5yiE+FCjHOry/njhJ6qt5ILcEzl0JhC46VpbpEsWVpR8mhXX8Gvg8vJGGGn6
 OPxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYNhWuTPzvxTrkbbqaeHR74vtzmwwJjzE00V0jZgdYH9HvSVf+XDVuYrJ8HSQ7eIIatr6qKWsKQjTx@nongnu.org
X-Gm-Message-State: AOJu0Yy/U1mXxvH/uL6oLNFHn9BJYMUJ8HEbc7qGVEzFs2kkbuXvBcAx
 y/1SN85eJm1J93HfoZP8xbzsbLa9mcZJqTxG+r7MvUmzCmA4xyw60G0lugu0BqWCaf0rcosGs8A
 K5A==
X-Google-Smtp-Source: AGHT+IGaEl7LuPtDHmnDulL+HKfOef7kdiL4qCyCHrhOw9B0t/loYY6kfIBEigJbhIJNS9jV3y0h2XpNrcA=
X-Received: from qvbpf18.prod.google.com ([2002:a05:6214:4992:b0:6df:bb1d:906])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5c4b:0:b0:6d8:a7f7:c39d
 with SMTP id 6a1803df08f44-6e1b224bd4amr221494996d6.40.1737457181436; Tue, 21
 Jan 2025 02:59:41 -0800 (PST)
Date: Tue, 21 Jan 2025 10:59:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250121105935.3069035-1-titusr@google.com>
Subject: [PATCH v2] hw/misc: i2c-echo: add tracing
From: Titus Rwantare <titusr@google.com>
To: philmd@linaro.org, minyard@acm.org, its@irrelevant.dk
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f49;
 envelope-from=3HX6PZwYKCpoNCNOMLAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--titusr.bounces.google.com;
 helo=mail-qv1-xf49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This has been useful when debugging and unsure if the guest is
generating i2c traffic.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/misc/i2c-echo.c   | 8 ++++++++
 hw/misc/trace-events | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
index 5ae3d0817e..65d10029dc 100644
--- a/hw/misc/i2c-echo.c
+++ b/hw/misc/i2c-echo.c
@@ -13,6 +13,7 @@
 #include "qemu/main-loop.h"
 #include "block/aio.h"
 #include "hw/i2c/i2c.h"
+#include "trace.h"
 
 #define TYPE_I2C_ECHO "i2c-echo"
 OBJECT_DECLARE_SIMPLE_TYPE(I2CEchoState, I2C_ECHO)
@@ -80,11 +81,13 @@ static int i2c_echo_event(I2CSlave *s, enum i2c_event event)
     case I2C_START_RECV:
         state->pos = 0;
 
+        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_START_RECV");
         break;
 
     case I2C_START_SEND:
         state->pos = 0;
 
+        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_START_SEND");
         break;
 
     case I2C_FINISH:
@@ -92,12 +95,15 @@ static int i2c_echo_event(I2CSlave *s, enum i2c_event event)
         state->state = I2C_ECHO_STATE_START_SEND;
         i2c_bus_master(state->bus, state->bh);
 
+        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_FINISH");
         break;
 
     case I2C_NACK:
+        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_NACK");
         break;
 
     default:
+        trace_i2c_echo_event(DEVICE(s)->canonical_path, "UNHANDLED");
         return -1;
     }
 
@@ -112,6 +118,7 @@ static uint8_t i2c_echo_recv(I2CSlave *s)
         return 0xff;
     }
 
+    trace_i2c_echo_recv(DEVICE(s)->canonical_path, state->data[state->pos]);
     return state->data[state->pos++];
 }
 
@@ -119,6 +126,7 @@ static int i2c_echo_send(I2CSlave *s, uint8_t data)
 {
     I2CEchoState *state = I2C_ECHO(s);
 
+    trace_i2c_echo_send(DEVICE(s)->canonical_path, data);
     if (state->pos > 2) {
         return -1;
     }
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index cf1abe6928..d58dca2389 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -390,3 +390,8 @@ ivshmem_flat_read_write_mmr_invalid(uint64_t addr_offset) "No ivshmem register m
 ivshmem_flat_interrupt_invalid_peer(uint16_t peer_id) "Can't interrupt non-existing peer %u"
 ivshmem_flat_write_mmr(uint64_t addr_offset) "Write access at offset %"PRIu64
 ivshmem_flat_interrupt_peer(uint16_t peer_id, uint16_t vector_id) "Interrupting peer ID %u, vector %u..."
+
+#i2c-echo.c
+i2c_echo_event(const char *id, const char *event) "%s: %s"
+i2c_echo_recv(const char *id, uint8_t data) "%s: recv 0x%" PRIx8
+i2c_echo_send(const char *id, uint8_t data) "%s: send 0x%" PRIx8
-- 
2.48.0.rc2.279.g1de40edade-goog


