Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB54BC9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYb8-0000uL-Gw; Sun, 18 Jan 2026 14:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYaP-0007SF-Vi
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:37:22 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYaN-0006uq-R3
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:37:21 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so19797485e9.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768765037; x=1769369837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xJrwc41uxCYz/xC20+DWRn+fpMS8ZaLDv1kHPjZTwY=;
 b=ehxT+NlipbYdIXzm82l6ndlfaKZbKzHC74YMLUZhQw+EVq0CrvNZ92i9gVHoyw9Bq/
 e4sVPqTC8iPcntdmFCAMToLHggsqFqqbA6BoPLv5jEMMcvO2Rri9Vzc01YPirB+CUyp4
 dmoBmMhMV6MkpeaGZ3q12XD1F1faj1tC1fPUDZn8swKUemaeYkJYjRIA4T7KiUVVfDIx
 BdCOmaAX5qNd/bvYjel/Icxs9pWxx1P1gII5trl+8+9/x2XdE/nEKcDE3L+x98VHJUjS
 Y7J65T6IBR1Np5ZOnhwFBYUXU4W1/1/eiMxd90gRT+B6h9KHXEutKAM+zrywO/3JnaVJ
 13sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768765037; x=1769369837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1xJrwc41uxCYz/xC20+DWRn+fpMS8ZaLDv1kHPjZTwY=;
 b=Wi+KbIKEDmvo/UhELBJ5JDqprffmuQbPzCQhqOjP5QAA8WNdMCke7w/JQJAaWuL82l
 AnrHBOVh5c6WZJ2b6JecMiQ0ARNNQpbX3QjFw4EQxalvXFnQVLR71yFHAwPvd98aGfX4
 sAZmvOYqPYuNBI2r/RYQ1kHhVmK/1cvLkzpLKDJECB13pXrWwZzpYW4T2D2RoX3sSkad
 BNGdCJcTckcOMhYewi2hxcVGs4V/r0DyY5EWnoDw2afF5KJhTtAvfdvMEEVr7i4gYBVs
 OPNgIrKWIs0A6rgB/oxwbFraVvZEQ7nAXiJYkesSaljTMdmwJmXUShmxlxznP/98QcFx
 oY+w==
X-Gm-Message-State: AOJu0YztTRjIKbRVChucbYigRVxMJrIoUwoW/ulfBz3FxbZ5OjkvNS7T
 rf6PFzAwEEC00S7rfyaIZpZgUGf7Ubh1ZXSmCH8t0j7KKRXLrUgFCbYGr244ZnkOoxQdfzKHV4/
 qnnS9BbQ=
X-Gm-Gg: AY/fxX71Xj9tS0FZuB/j8MUoJiLz96h8DKblN0hxU6ed9GEmoF7AT6VKcnYEK9iLuCz
 0ZMVtXOyfvLldDe18jGydvfY/VFhEKgJQ6L+O6qaNW/R5TQTRo5ToO2K1mcy68FIIXLf32mhZ2k
 JEExvE1Rk5F+VUTb8wo51PNClAEVCvsdn9L+hCWCuXAHtPuPPGfL72srJN/Jm6/OX+KqDM5pIUR
 aTc4Ca8wyeeJ35y+TSuSLsidLIrj4L1V410xjztLy9eRllaD2kQGAjcsuGtEJSKL1HPM9vzx/9F
 3A+40aTElWPOwLPAzAGuZ8ex2ksCd5fQMY8EL2y1wMWAKTXdJJDK6oiG6ZLUrNLdZAHcqLGAioY
 QmUmHbw9q5luuomHPix+2D3zQQYpljlZO0ni1TSaPfXq89UUmEaeDz9j/C/FBfdqOCZChiZyUOk
 o8HQBqlVJ3lv7gXvO2d0f4mArYYbl2xBKJcPB4hvn5624giEz+/mlA+DQYDDqX
X-Received: by 2002:a05:600c:354a:b0:479:3a86:dc1f with SMTP id
 5b1f17b1804b1-4801e3503c2mr98976395e9.37.1768765037458; 
 Sun, 18 Jan 2026 11:37:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2c1c6sm65357635e9.9.2026.01.18.11.37.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:37:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 18/18] system: Allow restricting the legacy
 DEVICE_NATIVE_ENDIAN definition
Date: Sun, 18 Jan 2026 20:35:08 +0100
Message-ID: <20260118193509.42923-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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


