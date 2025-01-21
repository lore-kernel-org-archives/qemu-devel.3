Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADA3C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBcY-0000ef-7b; Tue, 21 Jan 2025 05:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3pHiPZwYKChcG5GHFE3BB381.zB9D19H-01I18ABA3AH.BE3@flex--titusr.bounces.google.com>)
 id 1taBcQ-0000cR-IW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:36:26 -0500
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3pHiPZwYKChcG5GHFE3BB381.zB9D19H-01I18ABA3AH.BE3@flex--titusr.bounces.google.com>)
 id 1taBcN-0002Se-0h
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:36:25 -0500
Received: by mail-qt1-x84a.google.com with SMTP id
 d75a77b69052e-4679d6ef2f9so150374611cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 02:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1737455780; x=1738060580; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OMbO0p1M9omrKU79xN5rgRVktWMV80RU838b/dw3Qzk=;
 b=t6cBxEzWYic9Ji8Ja+QoC9qYDpEwStgbUE7Y1j32I8DWluTDMUIGOfDI1mrNVNXPY3
 vlP1JJTIKjtf79BzQBSHle1b5kgrpeCivWmn1sEtoqZIRmDnm4GH+8NXcljkNrN92Oxs
 BOo5TxzvQK1jOG/fgCYsPnM0gEhMXJ5EFIXKrLVVo79eBw+1KeAeEwJnolvuyQZnMlF5
 RMwj31DDuM0R+wTBSDFcg9y282JU+2tKWvUmRjq5Th+cdamMmVODC+5IUV+Yqhr94912
 7ubDnaYjaFpCIlZG197gfHNEUaa0ht2caoLc1ihuSvBQm3Scvsi6r24Oy2hfydnut9Qj
 XfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737455780; x=1738060580;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OMbO0p1M9omrKU79xN5rgRVktWMV80RU838b/dw3Qzk=;
 b=lnyeDnIFt35MmYA1OrLQY4j+TQjDYHWfr/Q8xaYBURReXabn1htmF1MRF56eB6gX1z
 0Kg6eDRfqgj8J15/jvSct2FMrkClvCgtolufFhNw6tbB045IU7yekUGwTRS27lL6HBDz
 yM0kAIQpNaey62P8i/bPJfxuLX0PxPCcHLpEDdFeYfsyQyv3dJG2bL5Vte1HtsJgcrIT
 R2hU1OXnPEC7n87119HY05WkN7LjO+qAGRU0AGGG0YKlBmyysxmlG03QJbEH2MnOj8LZ
 gygG4uTnY5pntRPmj+K2iVYap1OJXDsBzn/+C4afLgk7IlG7h1aoM1ZoIxTz67eq6fZD
 oW1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKIftzaCooNxxlntb/rY724jHTBq89VjDkoUEDuuuWa3Z1qq407HplKslnhT9V2t3Fz/KiTU/i2Ma4@nongnu.org
X-Gm-Message-State: AOJu0YwwD8pkaX5lf2HPMnGWGKWrl5ilkhHtqiLP5kifYn8YFdlOs681
 oljNCNBRR6GBZeVdEKyBtxZ0EpQ0ZMZhx3lckq9knB6bF/Vpq5N5XJHMz80gYWD2fcfciIBA7hc
 3vQ==
X-Google-Smtp-Source: AGHT+IGN5W8WGk7vBjoSq6LZyMwvXPwYmiDCj3FkQb6Lvg3li5DTqV5B3XqVJXK80TL3kkDCRuOW+PCBWJU=
X-Received: from qthh13.prod.google.com ([2002:ac8:584d:0:b0:467:5057:4372])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:24b:b0:46d:faa2:b6e0
 with SMTP id d75a77b69052e-46e12a6138emr274948591cf.18.1737455780235; Tue, 21
 Jan 2025 02:36:20 -0800 (PST)
Date: Tue, 21 Jan 2025 10:36:08 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250121103608.3056288-1-titusr@google.com>
Subject: [PATCH] hw/misc: i2c-echo: add tracing
From: Titus Rwantare <titusr@google.com>
To: minyard@acm.org, its@irrelevant.dk
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::84a;
 envelope-from=3pHiPZwYKChcG5GHFE3BB381.zB9D19H-01I18ABA3AH.BE3@flex--titusr.bounces.google.com;
 helo=mail-qt1-x84a.google.com
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

This has been useful when debugging when unsure if the guest is
generating i2c traffic.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/misc/i2c-echo.c   | 13 +++++++++++++
 hw/misc/trace-events |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
index 5ae3d0817e..06110e0f8e 100644
--- a/hw/misc/i2c-echo.c
+++ b/hw/misc/i2c-echo.c
@@ -13,6 +13,7 @@
 #include "qemu/main-loop.h"
 #include "block/aio.h"
 #include "hw/i2c/i2c.h"
+#include "trace.h"
 
 #define TYPE_I2C_ECHO "i2c-echo"
 OBJECT_DECLARE_SIMPLE_TYPE(I2CEchoState, I2C_ECHO)
@@ -80,11 +81,19 @@ static int i2c_echo_event(I2CSlave *s, enum i2c_event event)
     case I2C_START_RECV:
         state->pos = 0;
 
+        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_START_RECV");
         break;
 
     case I2C_START_SEND:
         state->pos = 0;
 
+        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_START_SEND");
+        break;
+
+    case I2C_START_SEND_ASYNC:
+        state->pos = 0;
+
+        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_START_SEND_ASYNC");
         break;
 
     case I2C_FINISH:
@@ -92,9 +101,11 @@ static int i2c_echo_event(I2CSlave *s, enum i2c_event event)
         state->state = I2C_ECHO_STATE_START_SEND;
         i2c_bus_master(state->bus, state->bh);
 
+        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_FINISH");
         break;
 
     case I2C_NACK:
+        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_NACK");
         break;
 
     default:
@@ -112,6 +123,7 @@ static uint8_t i2c_echo_recv(I2CSlave *s)
         return 0xff;
     }
 
+    trace_i2c_echo_recv(DEVICE(s)->canonical_path, state->data[state->pos]);
     return state->data[state->pos++];
 }
 
@@ -119,6 +131,7 @@ static int i2c_echo_send(I2CSlave *s, uint8_t data)
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


