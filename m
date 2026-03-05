Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1628F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGtF-0001Ox-PG; Thu, 05 Mar 2026 17:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsz-00017P-HB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:37 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsy-0002IW-4Z
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:37 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48371119eacso101042325e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748574; x=1773353374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfHZMVt3w+CNCstm9dcEqkFY9F06DbEsvAYeYDdgYzI=;
 b=k4WXf/5HA09mBG6VleDQlftXYW2gCjpAyGy6eVuqAG/Lpv5iv+0m4JUqN2n2whVR4u
 MDkQ3ssiIJgasSTNB1OeKVl6oXi5seE8jUnc5NCs7qbZ5b1gxjm6d3J7lNVfJjac9bB8
 wOoJoP2FA5lOCwp89TcF2xlnOAEURHGZymZlGM9HlHHFpRBC/yzMUzWRN5ctZtIsPcK8
 kkSBYEC+S+p95uMzVnfC7mbGk8/EeuyUJSof9GJBY/FY2Pf5XrlJSgAQgkowzgxeQMiE
 ObwpVPTDcEDEoHAHkYxP8wbRasqAbDolR1ZiunSyoJsI1PB35PPp1XRWHBNl63a8sD32
 fJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748574; x=1773353374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mfHZMVt3w+CNCstm9dcEqkFY9F06DbEsvAYeYDdgYzI=;
 b=ZZ06to+Z4wfZTceoXJsCC6/AS4eeSmQdZ3TsFl4WByah3vhpHkNkeBieXp9+L1TGVz
 1qoZT/D482bq8VS/an6JBSi+8ffu4i95Ti8VucnZM1uodhKAuJXlxYoOZXOkQVDjOA9z
 UnvNYWkwvEYD9ZshO5bUXxvwKAbJwEaCmbOXSusuzCaAOf3cDBEbBjLinBoQPpiiU4KD
 iHBnqMuBITTNLY1YWBhIbH9jJTcVostyVHtEQBgCZh5toi6lTkpTmfOD9grvi+qx4B8+
 X8lN6jo6COVSBDKeFP05s+XLSjNLz6lndfsHGu+Ek9g+ZmQIimB3leSNlgSqkZV0WaKA
 WygA==
X-Gm-Message-State: AOJu0Yy0udQlff7iirxYwMUsQOoSs+AfNE7HiAbi8mt3f+a/V9A325+y
 c6w70sKhgrMl54UDrC74UzlbBoIo0ijMtOVCU5qeBPZs3IkojSu1nh9gE0WLdg==
X-Gm-Gg: ATEYQzxFTJxBHhRCdh2nIT2Qq7cx/g0OcQhClbrUICjAOwPvjj4pvy3anoFGQD8pouu
 56PxMLAklOo5o/HKCue11DI5H7ssGethr2i1a7Si8F+RdEjXwa2Ce8V1g+gBu7KK7gJIGRzTkVv
 iCFl4KMiVagZT65+D8QxqkA3hJnU00IHtph6kQ5he1ihBOvIoHh8lLs+BvGDHJ0sa4VQ0kEUVUI
 IfdIu/hZtcBBSQ/4kkDopKA3indXo4SJIaIg+N1Me73bC7mSh15tbc8O0bRKRSlrv9EtabJyZLt
 HX1WqAK0QcuYaS97a52gV8+q+GyHwvhIgj/KtgRWIow2dyDZWgKE1EqK1ufDaTPIItSwgL+lCof
 d4u0Zk4xZqvcAvkszZeAEMPei2U+G5OR5+e9KtdOceTnCx9n/QUVfXi0yzppTmUTbssvRuBdEeD
 d07iJCMCnPISB+6YWfm44hGsbhfCtME+tm1dWG7LD+fUUYk2+RMVilLMd/r44jTMZKSQJxisPJP
 yLCB8ovCs81HClPDHPOdj/U5FtyVxbDfP8SUO3dhr0tnIE=
X-Received: by 2002:a05:600c:1f88:b0:480:4a90:1afe with SMTP id
 5b1f17b1804b1-4852360e3d2mr18066675e9.34.1772748574239; 
 Thu, 05 Mar 2026 14:09:34 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:33 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 11/14] hw/char/serial: Avoid implicit conversion when
 tracing
Date: Thu,  5 Mar 2026 23:09:08 +0100
Message-ID: <20260305220911.131508-12-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
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

On 64 bit targets, the MemoryRegion API passes an address and a value as
uint64_t, so use that for tracing. Keep the uint8_t for reading since
this is what the device model produces. On targets with less than 64
bits, uint64_t is wide enough to avoid narrowing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/trace-events b/hw/char/trace-events
index 9e74be2c14..a3fcc77287 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -5,8 +5,8 @@ parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s]
 parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
 
 # serial.c
-serial_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
-serial_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
+serial_read(uint64_t addr, uint8_t value) "[0x%02" PRIx64 "] -> 0x%02" PRIx8
+serial_write(uint64_t addr, uint64_t value) "[0x%02" PRIx64 "] <- 0x%02" PRIx64
 serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop_bits) "baudrate=%"PRIu64" parity='%c' data=%d stop=%d"
 
 # virtio-serial-bus.c
-- 
2.53.0


