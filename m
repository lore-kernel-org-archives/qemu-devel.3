Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A814C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqT9-0007kK-Ki; Thu, 22 Jan 2026 03:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSx-000699-Dx
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:59 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSv-0005zX-Qt
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:59 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so558765f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072096; x=1769676896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5yfy4tTsPf7LLb72q4HUijUvyIYzC7km6s9NiBtIj+w=;
 b=vNIUc2ITDvhK0X5XtqSoH2q5FfmDJPFnIAq/IszvEmUF0FzmAmTZrwbaB+W1lyALjY
 mAQ7JnQ0/7GOKOOYEcF7FzS+fgm9Mfm8312fiIiPNFMeDPTgip9w34yFIz/omjVWYcTR
 ZNQatgWpXj/3csbkIbWM9NNYtqjetpSfgbVDV9btWvLSt94/DLtmvlyFCV96mfPue6bM
 Jm58BcQ7s9NvsaV1Z0ccYMzM0OVoqmmbGcKMShJdJBQWvNvf9MF8m1i3kRHtCB7e0Y7C
 ZJEF1kW/k7wSXyuyPMQ8nRF5sWsxGFPmJvJWXIFxOT5VSM8YxOdEWTxpkXtK295Jw8Dw
 53BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072096; x=1769676896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5yfy4tTsPf7LLb72q4HUijUvyIYzC7km6s9NiBtIj+w=;
 b=Cf95sJa4q7a3HuSwkld/ZvOSExoPZIttlqBtYLzFIi//CinE932IfI3wnL8GjFYOZp
 +kRBtrStylf1vIfqGwawGKX/RpADOsjxT2hK25163ntYSfmK+kJdHXsp4+p+KYd6jAve
 jFW2SWaI0+lY1MHtslSil+ITJ4/rG5Nvl+D377F5QHU0p4auwvYtbD8tDAm8tVpNXrs3
 M247GgoB7qPaRAHpuArLGT6SjoGcYiMJhR9yjXNiF784XL2p3y9P90xkf9AezxfKlyAy
 0XsMfnZdBFSqX3YkoVkPn5USe0OULEvsLjfIVjd0TOal6hbzf6XO+UwseX7WklDYHbhT
 zi/w==
X-Gm-Message-State: AOJu0Yzt5H8cMLjn/Z2xnWvG23R144Tw8q0v+dBTiEu3zzKYTQrUtrsc
 wI1y5BLGEWGd8/DRV1mFoXkaYl33ElJocOE3ucSsXAl5aDqS7z727qyaztnULwDlrQWr8beO9PR
 B5aZYYAg=
X-Gm-Gg: AZuq6aIXjVnBGMcMs3KvY7WrY0mCuUON6ogxsSydw08g0r2q9Lk3rIHildd086ECFAZ
 DprhoaIVjLYMLVgFssnOEV2oypSpbjgGR5B+0PQ/UElxTPNgVj8pEaKZyFkGleuYgduMoICQHP8
 vq02TgtklzDu66JCjgOvbBU1MRp5n+r3/TZ9r36I7aQbaYEC5G1dYVS2qDSQLlujkMuROmFhH5I
 DtH4YyVtRXF6Qx2evQEq0/j2HwL1TzW3Hr9C1pWECL2xIsvTWHefaBSmWpJu2NYJhCWrf9XphLV
 rGyFZujFBTujCtkIExptFXmhQSYzmwtrzaD0WtlbEanAd6dNJZiqZu2qORoXzE/xuTx6rUA730i
 J3umtw0vX65MGiqbirjl64p8P17i4m9+MPUq7fG1F7dtyO8K6xZ0vG4c/2O/gZUAssm4WJZU7tI
 5MXV6QXzuqVqE8szG8vzc9fy7ZtXx+4WXqvavokPWpRlcJXkXE8JUYWnSO0nIG
X-Received: by 2002:a05:6000:1ac7:b0:432:8667:51c7 with SMTP id
 ffacd0b85a97d-4358ff613c9mr14470806f8f.44.1769072095812; 
 Thu, 22 Jan 2026 00:54:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4359333b924sm16169363f8f.13.2026.01.22.00.54.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:54:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/31] system: Allow restricting the legacy
 DEVICE_NATIVE_ENDIAN definition
Date: Thu, 22 Jan 2026 09:52:41 +0100
Message-ID: <20260122085255.95035-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Guard the native endian definition we want to remove by surrounding
it with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
Assign values to the enumerators so they stay unchanged.

Once a target gets cleaned we'll set the definition in the target
config, then the target won't be able to use the legacy API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-21-philmd@linaro.org>
---
 include/system/memory.h  | 8 +++++---
 system/memory-internal.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 92028dc7a4e..8f8725ea2d5 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -27,9 +27,11 @@
 #include "qemu/rcu.h"
 
 enum device_endian {
-    DEVICE_NATIVE_ENDIAN,
-    DEVICE_BIG_ENDIAN,
-    DEVICE_LITTLE_ENDIAN,
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
+    DEVICE_NATIVE_ENDIAN = 0,
+#endif
+    DEVICE_BIG_ENDIAN = 1,
+    DEVICE_LITTLE_ENDIAN = 2,
 };
 
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 46f758fa7e4..5f0524756eb 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -41,9 +41,11 @@ void mtree_print_dispatch(struct AddressSpaceDispatch *d,
 /* returns true if end is big endian. */
 static inline bool devend_big_endian(enum device_endian end)
 {
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
     if (end == DEVICE_NATIVE_ENDIAN) {
         return target_big_endian();
     }
+#endif
     return end == DEVICE_BIG_ENDIAN;
 }
 
-- 
2.52.0


