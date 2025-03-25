Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503B3C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwQe-0007Rv-Sp; Tue, 25 Mar 2025 01:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOC-00042K-Pg
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:50 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOA-0005zA-Vm
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:48 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so8530606a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878786; x=1743483586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pArVD1rsNNhsePjAEu6qC315uMjwLbUtwsk4rPFCwig=;
 b=OYy0vqFofkJcA9HlmudXJA+8bLkC8IV+62ewJTxv8ZDXsUdFOSLk5CHaKZi7xJAgYv
 Z3yN584xmQWpi8k9jvkQZmit4lhmXBIA2gqOt/Q9fSOlK62CDczj0TjdnP9okAHGoOVE
 ku2x4o7ntASixzsUCGzDK7grClzXEYGY+RUDSRKaf1r/ZxMZ7BL/9pR4/3JP+thx8xHw
 4j/p26BCWulIiIDYsoDp6w5U5oP0XNPv0R9VVSLY6d9gFHcOxFdOu1lOieRkh3kyjT/2
 uifI4e0Is4VpIygvMkvBXtP8wSVmMbbshWGd6YiayV+U9o9/4VQhzc2XQtuXTb4IXxlA
 knPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878786; x=1743483586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pArVD1rsNNhsePjAEu6qC315uMjwLbUtwsk4rPFCwig=;
 b=dpP8VaAZBwpS/goZ+dd8D2b5zbBIR0XOyfVksrPq7tLTDzthqy8BJKM4nLt3/ZpDq+
 xgKC7IYXELKI1R7NhH9CYKVa0jX9Fw6eQR4C+uBfqUUAifHRWUo4wotPbK/GNzfByJKi
 LEwTyKD6vdjd8dFNw/DJQiEzxdEN0iObOhS/LlUP9GLkeuWrM/NuPA+YEdnm7uuBla1o
 kkdRLpgEYzRqXH8XkATNb6a6Q7vbqAFpDldso23T4KOb38nVFHy1W5DTpU45UKfrXLU2
 BAYXid39F8zyXn8XtF0c/vzGufNBISLNJiLmGTa+2v7om4EN8tz+Zc9AekJnGsry9A6R
 JLaw==
X-Gm-Message-State: AOJu0YwSVDnhp2/lJUbr2q5SQ3xNa29uBC7wcmVpsMBIKoDuP8DSz4c3
 EP/0ycqBPB2KVREBkO4X8LUQ9fOjBafGzLZW4okPGNZfXnLjXhQt151BCqtVxvx7mr1xnxza5JU
 8
X-Gm-Gg: ASbGncvutYtOmElhyKNQHAhQ+Wk9dVGwiNBeNyIanQwVowHfA30+rrO59PNZIuZ6IkV
 cJtKb4B1uBFBvls5ZEG9XGNT8JvfjS6cFbzGHM9zpLXxeuVi2Z9/8Bp9eKWOr1dmnzhwsWw7uyH
 I19LlWbd147FfMpU+iFpzVLTHpeNmA/GRznIF6/Gmbo1KX9voRiY3CfyXVtzMCn9SLzHK5tjj6f
 369u3lKLbxaHN0XGO/kbO/1+AV+d2+/tXMBJ2uNluiFH68ldZwPSRfpl37dyor2Nv5/x8zgQ5Ai
 /X4mvYthOgq/8zOxftJyqsspb/ANk+LJZZ1eHC4X8+7o
X-Google-Smtp-Source: AGHT+IGR/KzZA1+eUmHk6ei4WiiUVCtTEYWPQAWgs9sRPdujUcwem0sIhUGOyH56NiEPvMBjKDnRdw==
X-Received: by 2002:a17:90b:2b8b:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-3030feaa4b2mr29857443a91.17.1742878785454; 
 Mon, 24 Mar 2025 21:59:45 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 25/29] hw/arm/armv7m: prepare compilation unit to be common
Date: Mon, 24 Mar 2025 21:59:10 -0700
Message-Id: <20250325045915.994760-26-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/armv7m.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 98a69846119..854498ac51c 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -140,7 +140,7 @@ static MemTxResult v7m_sysreg_ns_write(void *opaque, hwaddr addr,
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
         return memory_region_dispatch_write(mr, addr, value,
-                                            size_memop(size) | MO_TE, attrs);
+                                            size_memop(size) | MO_LE, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -160,7 +160,7 @@ static MemTxResult v7m_sysreg_ns_read(void *opaque, hwaddr addr,
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
         return memory_region_dispatch_read(mr, addr, data,
-                                           size_memop(size) | MO_TE, attrs);
+                                           size_memop(size) | MO_LE, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -187,7 +187,7 @@ static MemTxResult v7m_systick_write(void *opaque, hwaddr addr,
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
     return memory_region_dispatch_write(mr, addr, value,
-                                        size_memop(size) | MO_TE, attrs);
+                                        size_memop(size) | MO_LE, attrs);
 }
 
 static MemTxResult v7m_systick_read(void *opaque, hwaddr addr,
@@ -199,7 +199,7 @@ static MemTxResult v7m_systick_read(void *opaque, hwaddr addr,
 
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
-    return memory_region_dispatch_read(mr, addr, data, size_memop(size) | MO_TE,
+    return memory_region_dispatch_read(mr, addr, data, size_memop(size) | MO_LE,
                                        attrs);
 }
 
-- 
2.39.5


