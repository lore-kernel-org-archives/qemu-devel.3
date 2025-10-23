Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15A8CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBttC-0006No-0l; Thu, 23 Oct 2025 07:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtt9-0006JH-Jd
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtt7-0002ek-I6
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:51 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-471193a9d9eso7909205e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220427; x=1761825227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksRzEOXsw7/qT6nxPgIci4xbN2jOFu95y2T7RO0BwU4=;
 b=WpF15k2SyaVgSbx2/ESlRjKNToVzvaAANQhE8d/iqBCV5uWcwMHai97Mu1dt6gtnw+
 U6NqhSwQemwJlr5Gfs4SMWrBs4vPASyXzNQny6NgyN/hhfbjq8Uzlls4OoKB5n7IHh+4
 Le7swcFnx6+MExOfNMs7yFgTg2w28ayv41B7n9KnHPCFcn7iBxBoR6Lf48Bn7Oain6wH
 kLds+cBJ17Da8NKfG8QYqYx38BPRqtHDZG+QSEE3OFG/Ok6AnxSapbCmfw/2H/cwr4lj
 1hm9job3dPAo9lRaHEu9z1wAjqHts1p+9y627GDlnYmnTeBOMWWEOFiZZDSZGWcv6jKz
 K2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220427; x=1761825227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ksRzEOXsw7/qT6nxPgIci4xbN2jOFu95y2T7RO0BwU4=;
 b=BLP5/RqDiBZiUBZ1pBagCmeLy2TQbHrgtdc4Ar7Ddbt5qUjeBSyGPYo6QE9KYxwQco
 wizv1FhDXTD95Tbqb/Wc2v8Q6LpPWYZnMXjQWN5HvvRBPAzYKmKanQizRyrgbwUmAnF3
 jrq3cfWpoP7pmLnVjnN+/KtcEkKeCpRxpNPBwBy/9otEOF6QsbxGtvDL+elYHGT0QKp9
 VgIKFW70BsHTqquMH0bIpaXMhCExnxvsVNjU4Bfs64+hEw3UNJ2Vh0jMAoaE0S6qlT8k
 Vv/rYcHBswq4Sjnp1xyh9FoxHROEbH5tmEJ1pJqECkM6H07uduRGsdJUu2xOc7Gj7Ip7
 lwqg==
X-Gm-Message-State: AOJu0YwTSBCkAsnkNzpNPx1yzXSu3rgiNaJM/S7Ljvq5eCVQJPPhowd0
 5ZylWc1XRFtThA5H6q4bohZDBukx2BsUceePUeoLDHNLc6KwzprQSieMisdRUGTraRVJuEw9eJV
 KzWpkbWs=
X-Gm-Gg: ASbGncvEJcDR9THu+8kFXwxbv8Yo/K98/CCZ2bbABFkN3WCq+VLE85VoK5SOWfr8w4d
 MBwFFbrR+ADaAmBnRTFXprmcstNj0sZDhSViWoViSAFMiDUoxxf01wnUJ+0b6HACQ7EvQkQwNb/
 r6ssT6jlrQpecx9V3Xv+x1OkOXeikZSGLwmIYRhX8G0P7jizDp44QSnhPYkilFNP1nrQYa/NeU9
 C1vpUqZlxHEiza/m0/KB00DDUbCJaL0JyMmJIvfHCMmVdqsgM659CZCX7RxzhHyfgn9nicsylYU
 +SWdBF4ATQxK/Dx/PZmqIAuUhUq5yJdrzwdIz0tQL/H83ZxuSm6Trz1X/G1YxdM+016CrNYGM8A
 neIAgi2h08nT2jTS36ArZC/EeyJDA/R1Ogik+PBFE7+wKd5ykgEbUv6XhO3zspMw8rrJAE1aWTE
 +t6aJ3FLxHrD7lB7PaGi7v0EIY1s/1F1ClbxjPVOnAPGaVDsQbW8KKBpfBI+l3
X-Google-Smtp-Source: AGHT+IHnaCVjtUWUAaXIHvDzg+vAp/gJUckpHD+CDTGKlI34zNdNqoNOsIx7k+eYph5Os6YS7RSHZg==
X-Received: by 2002:a05:600c:608a:b0:46f:b42e:e397 with SMTP id
 5b1f17b1804b1-4711792cd70mr162423305e9.40.1761220427410; 
 Thu, 23 Oct 2025 04:53:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf15498sm40025825e9.12.2025.10.23.04.53.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:53:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 37/58] accel/hvf: Simplify hvf_log_*
Date: Thu, 23 Oct 2025 13:52:48 +0200
Message-ID: <20251023115311.6944-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Rely on the AddressSpace and MemoryRegion structures
rather than hvf_slot.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h |  3 ---
 accel/hvf/hvf-all.c      | 40 ++++++++++------------------------------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 5a57691885f..ee7ab689f45 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -24,9 +24,6 @@ typedef hv_vcpu_t hvf_vcpuid;
 typedef hv_vcpuid_t hvf_vcpuid;
 #endif
 
-/* hvf_slot flags */
-#define HVF_SLOT_LOG (1 << 0)
-
 typedef struct hvf_slot {
     uint64_t start;
     uint64_t size;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index e13abddbd9c..1be419652e0 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -200,45 +200,24 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     }
 }
 
-static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
-{
-    hvf_slot *slot;
-
-    slot = hvf_find_overlap_slot(
-            section->offset_within_address_space,
-            int128_get64(section->size));
-
-    /* protect region against writes; begin tracking it */
-    if (on) {
-        slot->flags |= HVF_SLOT_LOG;
-        hv_vm_protect((uintptr_t)slot->start, (size_t)slot->size,
-                      HV_MEMORY_READ | HV_MEMORY_EXEC);
-    /* stop tracking region*/
-    } else {
-        slot->flags &= ~HVF_SLOT_LOG;
-        hv_vm_protect((uintptr_t)slot->start, (size_t)slot->size,
-                      HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
-    }
-}
-
 static void hvf_log_start(MemoryListener *listener,
                           MemoryRegionSection *section, int old, int new)
 {
-    if (old != 0) {
-        return;
+    assert(new != 0);
+    if (old == 0) {
+        hvf_protect_clean_range(section->offset_within_address_space,
+                                int128_get64(section->size));
     }
-
-    hvf_set_dirty_tracking(section, 1);
 }
 
 static void hvf_log_stop(MemoryListener *listener,
                          MemoryRegionSection *section, int old, int new)
 {
-    if (new != 0) {
-        return;
+    assert(old != 0);
+    if (new == 0) {
+        hvf_unprotect_dirty_range(section->offset_within_address_space,
+                                  int128_get64(section->size));
     }
-
-    hvf_set_dirty_tracking(section, 0);
 }
 
 static void hvf_log_sync(MemoryListener *listener,
@@ -248,7 +227,8 @@ static void hvf_log_sync(MemoryListener *listener,
      * sync of dirty pages is handled elsewhere; just make sure we keep
      * tracking the region.
      */
-    hvf_set_dirty_tracking(section, 1);
+    hvf_protect_clean_range(section->offset_within_address_space,
+                            int128_get64(section->size));
 }
 
 static void hvf_region_add(MemoryListener *listener,
-- 
2.51.0


