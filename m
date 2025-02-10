Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1617C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPS3-0006mT-TS; Mon, 10 Feb 2025 03:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRa-0006FR-5W
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRY-000463-Lm
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739177223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQ0MnOK6J5ZbAzCKF9M2npVZxNDGBf3t+YvQ1I+4pxw=;
 b=ao+mf3UkEzbFIytoaVbkEMHSMZEyTQbrEvcme5ExogSLq5GFXR1Q1TnOG68Gz8nx6xETxw
 iVSuTTaIhBjEOmqWmBUWysMLBmL89aAE33YJZ2CCaAmaGB6tE9dwU4960SoPWCJemfC3hN
 +C7TxwDeDnk60xae89TyInmt2/FU9VY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-R-vXS_8ANPehTpXlYoclaQ-1; Mon, 10 Feb 2025 03:47:02 -0500
X-MC-Unique: R-vXS_8ANPehTpXlYoclaQ-1
X-Mimecast-MFC-AGG-ID: R-vXS_8ANPehTpXlYoclaQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dc88ed7caso1682617f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739177221; x=1739782021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQ0MnOK6J5ZbAzCKF9M2npVZxNDGBf3t+YvQ1I+4pxw=;
 b=nk2esi3F3p41CITANzB7Xiy2+v2Kl5omWiECeTXP3y6IiXjdHnxroSAsSlQRcIhtwG
 ZFmEgw9avGr+a3QFM+/phX5jLvuReoi9HlysKbPRNkhUazYPuJGLDK+iqDk9vgZJGayx
 gxi2yoKwH/WDhTjABvrwbzPVVsIwbwJC/+nCLdUXez4XU8sfGNhkyu1QlU74kKr81zY/
 KmcqMD4pwvy0XPT7cIFnkJfIq2G9q3w9qnSgoC9Wplv5TNhzF2Der40UKd+Upzn+4aq4
 g9hTq7P+F+aQbzcVzfri2YgZiyHSGxII5pXfFNpwGLelYeDP4KV+S09DBM5lHyCZMLES
 qKMg==
X-Gm-Message-State: AOJu0YyB0bWzSUZcq4C6G3vol7kCbD9HpvVZnVhB0xq3QjEqJsQuJue7
 Q7fRn11iCu7CizfM4QCxLEatm6D3hxUJX+AgvkWP2FAlFRZ5Xo3kGdVv1Rzt5iS+RxGeCQurH/3
 gIV6Pix3t50SENe4e0qrVlmDf9Ia7Y6uJGmrwaXMEGO3VqGn5cX8mVG2HkshHtBa/iqlGP6OkDa
 TOZvJ6Z1nMyOgbqECkt37GVbMxXpIj+dOC
X-Gm-Gg: ASbGncuGCjE43/9NxPw2wlpoSfX0ZyQJPLuAT26zWtxDvIi3ok3JFFxTWc7V3VrpUyj
 rI1F7gNpO8wShmRCIZLZvmyDB9ApvqNx7YDYtcZf5mW3PdS4sjYeJaKKMIiZUJPS9cTF7xuTbLU
 LuP8dyN/hDt0Lo+CiSbEaS1PsKa6BQZtWsM8XgtfoP/ClL6xgko05+qNtKJE8nPnbmy3S5NWSaT
 udMzPFOOx74kQLXbnRCzZKa2pyoBnuIn2ygAAewhkmgLX0Kyh+dc0y+idwXc3b4tXsc7t7CeLjS
 RQbdSCuuOHno1vO/odVLKQCUrruoGM4m47W9VRlG3O+rWo8W9vqHms2AJ1xZeSc7XA==
X-Received: by 2002:a05:6000:402b:b0:385:fa26:f0d9 with SMTP id
 ffacd0b85a97d-38dc89171f9mr8997774f8f.0.1739177221143; 
 Mon, 10 Feb 2025 00:47:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj24jp8vFAi9fkmfq+B8t3F/keE4RoVAcDIib9pUwgs828Kh+Xu8VCxsS74eYzU4OsxjUygw==
X-Received: by 2002:a05:6000:402b:b0:385:fa26:f0d9 with SMTP id
 ffacd0b85a97d-38dc89171f9mr8997741f8f.0.1739177220687; 
 Mon, 10 Feb 2025 00:47:00 -0800 (PST)
Received: from localhost
 (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de.
 [2003:cb:c734:b800:12c4:65cd:348a:aee6])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38dd3fc7ee5sm6353911f8f.39.2025.02.10.00.46.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:46:59 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: [PATCH v3 3/7] physmem: factor out direct access check into
 memory_region_supports_direct_access()
Date: Mon, 10 Feb 2025 09:46:44 +0100
Message-ID: <20250210084648.33798-4-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210084648.33798-1-david@redhat.com>
References: <20250210084648.33798-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let's factor the complete "directly accessible" check independent of
the "write" condition out so we can reuse it next.

We can now split up the checks RAM and ROMD check, so we really only check
for RAM DEVICE in case of RAM -- ROM DEVICE is neither RAM not RAM DEVICE.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index cb35c38402..4e2cf95ab6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2995,10 +2995,13 @@ MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
 int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
 bool prepare_mmio_access(MemoryRegion *mr);
 
-static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
+static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
 {
     /* ROM DEVICE regions only allow direct access if in ROMD mode. */
-    if (!memory_region_is_ram(mr) && !memory_region_is_romd(mr)) {
+    if (memory_region_is_romd(mr)) {
+        return true;
+    }
+    if (!memory_region_is_ram(mr)) {
         return false;
     }
     /*
@@ -3006,7 +3009,12 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
      * be MMIO and access using mempy can be wrong (e.g., using instructions not
      * intended for MMIO access). So we treat this as IO.
      */
-    if (memory_region_is_ram_device(mr)) {
+    return !memory_region_is_ram_device(mr);
+}
+
+static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
+{
+    if (!memory_region_supports_direct_access(mr)) {
         return false;
     }
     if (is_write) {
-- 
2.48.1


