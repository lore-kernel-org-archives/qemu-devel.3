Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B91C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyE5-0000U5-Iz; Fri, 31 Jan 2025 16:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyE3-0000Kk-Jg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyE1-0007u4-Rh
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:55 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso17494065e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357612; x=1738962412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yx9zBwtSy3gGrxCYpvjzpuUDny+fjTYjt9csPoUwmf4=;
 b=zxFO5hAcp8+5j6jTtmzp+r+tmo7gGDIrLQv9AZjeV24YCX+kQ+5Cof1vyoV4fPxCSx
 nai6Rk3/+wBYUdn1HpxoUICcAw+eMMQZvkCuH9SNj4x35LVs/GRirVTpgPuPr9LCAOKj
 PUBN+aE2bdIqmBI28yBnZ2QN9B/fHgPG0yQe6yMwqGVOehdK/o1HIw8pzhymt4vPvpu0
 k+DXOxrHVCZZasIvRv18+M2ExKYrlf3esmU6FIlwb+MkSr2YA6PIIzr4X7OTZCz4jL5q
 TExAuF/5iPgDXjSupQMsUzedfsmS1qVW3aTLDQk/2pEjcyLQwV9/GY8BagU72E2ubInN
 WI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357612; x=1738962412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yx9zBwtSy3gGrxCYpvjzpuUDny+fjTYjt9csPoUwmf4=;
 b=iU3heIAfneJAh7b2T8v/+h0tyV4SmyB5L2Lkq0lPVqmP1eN7lXt86oyl+OR2etVu0u
 xA9TD5vXvOJuNw80MzNZdirlU9uqOh6kMs/HgQma6L2Ou8qiUis7Hr/pLDinRXmZuYqa
 r6BOKSiUAttpINLszf4i1qITDt6wErOJ45S/7CbXjnHQv9ZTvzLJthxxmU5dJ7EBqjS3
 hMhbMktZRZpiPt5U4y89iH/VjunqXNR0i/rfOrqbVcpy+XiD6tP+y3r6FvYRWbi7qsBW
 bgRT0BlYRqvi3kOPqRvVUIayxN0e3/Cc8hByQZwO4M8pORBbBY3mZNNaGhT1kn2MnmKQ
 5Oow==
X-Gm-Message-State: AOJu0YwDC2PNJoYdUB52b/IjXIBsGjvX0vKVtjDBG6oNCge69fK/a96k
 /s3Go9hZBKOf6E9k3BodiUPfUIu8S1njNu3eGE5rFu78Plhz4xnG+ZXSSaKZLDqpS6gIyVusnJx
 PBDQ=
X-Gm-Gg: ASbGncunFVGq/CfLV+tcZC2rE1gyii5BpLb1wqldv6pkXrMIHQejYHgN12vNeSaG3I5
 EtdIQxhtInCsGPNbFuNopRFVBG+WUElaCeIFimzWEC5tkfaI1gmUzpXJxl9N6R0RbhDcZ5HKQLL
 Hbprrqadh2sXpVG6HkJ0cCBsSJxjlENxy+8OgrPfQN5MaEVdnTAz9LY6i0et82ALKC20WZ3vTyo
 DDNuwjf6vkEqewVuvuBttVNVTCJNWWXhM16lx4AUkIHpHz5pS2pijIqfpUEUszYAgrzX1UK+Jom
 BnSRevuuIy2uFXLnP3tqYWpz/wk7lJ8feFFShBMRco1LCqVPQpUtONYVPk4m9wzEZw==
X-Google-Smtp-Source: AGHT+IFtmVu8oi+o//GaboNDYBJNnpaB/ubHIhDTYcuTLDK1cG+ltJZD3LhM9GLPvE6TbYDaBrNyuQ==
X-Received: by 2002:a05:600c:1d27:b0:436:5fc9:30ba with SMTP id
 5b1f17b1804b1-438dc429771mr122794815e9.29.1738357611713; 
 Fri, 31 Jan 2025 13:06:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc26b15sm102018555e9.11.2025.01.31.13.06.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Titus Rwantare <titusr@google.com>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/36] hw/misc/i2c-echo: add tracing
Date: Fri, 31 Jan 2025 22:05:01 +0100
Message-ID: <20250131210520.85874-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Titus Rwantare <titusr@google.com>

This has been useful when debugging and unsure if the guest is
generating i2c traffic.

Signed-off-by: Titus Rwantare <titusr@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250121105935.3069035-1-titusr@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/i2c-echo.c   | 8 ++++++++
 hw/misc/trace-events | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
index 5ae3d0817ea..65d10029dc7 100644
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
index cf1abe69285..b35b0e77f7d 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -390,3 +390,8 @@ ivshmem_flat_read_write_mmr_invalid(uint64_t addr_offset) "No ivshmem register m
 ivshmem_flat_interrupt_invalid_peer(uint16_t peer_id) "Can't interrupt non-existing peer %u"
 ivshmem_flat_write_mmr(uint64_t addr_offset) "Write access at offset %"PRIu64
 ivshmem_flat_interrupt_peer(uint16_t peer_id, uint16_t vector_id) "Interrupting peer ID %u, vector %u..."
+
+# i2c-echo.c
+i2c_echo_event(const char *id, const char *event) "%s: %s"
+i2c_echo_recv(const char *id, uint8_t data) "%s: recv 0x%02" PRIx8
+i2c_echo_send(const char *id, uint8_t data) "%s: send 0x%02" PRIx8
-- 
2.47.1


