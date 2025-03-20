Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71D4C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOSi-0007ZD-RC; Thu, 20 Mar 2025 18:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOQ2-0002nF-Sc
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:21 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPR-0007D5-5w
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2235189adaeso25865265ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509837; x=1743114637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+1+7CiGx+iAiQeBUt37G0/UwWZT/ijcOCdLS2QJIME=;
 b=WmOrKb23+aANrdMD90rT6KF0adQ2xJ7AoDGzZzknIHglOVOdQvKzeI7flpFV+pUMbi
 9dNXMsOFC2ZHhKfJgfCQODG8QDHCKGkzoMWXawrrc2Z+Mo1vo5zbL9iqxzV5Ibj/blot
 wUwdEhhtbNP0gVLQRkHj/u0IdYPBPeYfrV7PKkI1IR+erNeIBGJiHK2xSB8NO25fhLD6
 wJUOqbcOrXaKCpOy9Weo6klnwyk3muF/SpgYVGU3cqjpptqjGeQ9Kp6NHS3sMqQbWJqd
 CrEfJXf2iXf0qA4Kdoyc/Fgly7ugl3D0hxEjnFOFyElR5tr4w2/5Ob03cplYSM49Djq2
 1v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509837; x=1743114637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+1+7CiGx+iAiQeBUt37G0/UwWZT/ijcOCdLS2QJIME=;
 b=VxfEgYIE5EplWlm8CWZUaeOtywQG5Kjh7srR1tQK0fH+xeJJsXD76eQ65CNac4Yz5X
 TKMJyLhPzfl7lRi36ZozLE2ZAqKrGCc9VRxk471Jxq2QPmw6EUwzS+tIE3DwD9tATept
 FVcSHkVPfFjoX3AOHmXYnR7glc7fvUZwB/mQ/ApPJk+anf/4Wp46TEJhtWYZp939l4ul
 UgUgUtcCUsM515iKqGhDRbVdqclO8uoJRhr5XT0VZfn7UPu18UqvubUJFFepllCoFJKF
 W1gl6EhPTfMoFyYwSh5Dju8UMu0OeXXAPVA1fzh3FqZ1KVbbCsle6B8t6bSs1YGW02j2
 hp1w==
X-Gm-Message-State: AOJu0YwR62N413pdTfD5upt18Kf+BgFN0fvHbn9lAiSooM1ZQyNflSqt
 fZ1aoDE2V11x5nPO7XJ1cXolO3TGgNbWU72U9fv8RJVe87kPYFclV4nAXsxEL7vXD+UE/pKjHBC
 R
X-Gm-Gg: ASbGncuFggw2BIcOfxpla9tpS+d4VIYIqUZ49mv/wsRL47eO5ym3TVE7jEpkw/xjQql
 q/Z+0ctEJ52k+8mHei36zRi8hiq5SSYzdxJzb2Dx8UA74CRB8iLQXpj39rXH/mrf5ldmej9+DRu
 XutZZlctToWvetJoWnmCtJssKRbM/Rqjhe8BD2NsmnVDyxuadtfgyr9j+fKLCCKShFPmeupwe46
 3CH56ICsf+kzvPSCN/xC70jon+S5FShvD66UOEE1OEb16n/lcgQ9SJQo9ToumCXl4QjavLXu+6L
 dPudqfZrDMcTpjOPgIvMNq+uCP9P74juNvovdMsRJSWm
X-Google-Smtp-Source: AGHT+IG0L9vR3TvEwtKsOTQ+jVnK9o/DeH5SAcVF5sO9ApBZUM8ybqvtvKZgXXJTYhMOle1B9x9PXA==
X-Received: by 2002:a17:902:c411:b0:216:4676:dfb5 with SMTP id
 d9443c01a7336-22780af524fmr17603635ad.21.1742509837102; 
 Thu, 20 Mar 2025 15:30:37 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 26/30] hw/arm/armv7m: prepare compilation unit to be common
Date: Thu, 20 Mar 2025 15:29:58 -0700
Message-Id: <20250320223002.2915728-27-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/armv7m.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 98a69846119..c367c2dcb99 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -139,8 +139,9 @@ static MemTxResult v7m_sysreg_ns_write(void *opaque, hwaddr addr,
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
+        MemOp end = target_words_bigendian() ? MO_BE : MO_LE;
         return memory_region_dispatch_write(mr, addr, value,
-                                            size_memop(size) | MO_TE, attrs);
+                                            size_memop(size) | end, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -159,8 +160,9 @@ static MemTxResult v7m_sysreg_ns_read(void *opaque, hwaddr addr,
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
+        MemOp end = target_words_bigendian() ? MO_BE : MO_LE;
         return memory_region_dispatch_read(mr, addr, data,
-                                           size_memop(size) | MO_TE, attrs);
+                                           size_memop(size) | end, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -186,8 +188,9 @@ static MemTxResult v7m_systick_write(void *opaque, hwaddr addr,
 
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
+    MemOp end = target_words_bigendian() ? MO_BE : MO_LE;
     return memory_region_dispatch_write(mr, addr, value,
-                                        size_memop(size) | MO_TE, attrs);
+                                        size_memop(size) | end, attrs);
 }
 
 static MemTxResult v7m_systick_read(void *opaque, hwaddr addr,
@@ -199,7 +202,8 @@ static MemTxResult v7m_systick_read(void *opaque, hwaddr addr,
 
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
-    return memory_region_dispatch_read(mr, addr, data, size_memop(size) | MO_TE,
+    MemOp end = target_words_bigendian() ? MO_BE : MO_LE;
+    return memory_region_dispatch_read(mr, addr, data, size_memop(size) | end,
                                        attrs);
 }
 
-- 
2.39.5


