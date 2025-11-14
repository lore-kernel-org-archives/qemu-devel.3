Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CD9CEACC9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK050-0000yl-T1; Fri, 14 Nov 2025 15:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK02j-00078P-SQ
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:19 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK02h-0004zC-Rr
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:13 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b2dc17965so1975415f8f.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763150710; x=1763755510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0L1rNSBbDA68/IWNXBGkYS13/51Kd8iUuA26ASfqQc=;
 b=KwhLblhxCN6WChJuKN1Au8lVHH7bFpVE/aLP3yRVoKgJ84ByrsUHKimVOU9FxLrab5
 0eZ+FlA7DavzIDluQZTnfUlQbndG0fYXVX7m3F2Iv9cFeYQHb+DMGNFEtgj4NLAYzAr/
 ipUVNqGCG6MKbuL1XomnKq5y8sqMfJO6uw2q/zmFWWoEJP6wyX2jAIB0qonKIs7W9XEF
 kyJmuwdk4B5lxTt7U9cnilQ+UXIMKuabgSsY50lfH7UaGyMtP62MlXkkdCnHFYpZ/Nc6
 mrrxovi9oVBDhQBwCUcnStIFIrNWShwtDSNkH0U5Iut6QtFrUgARuc6GVY8LKZeWiGOp
 TBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763150710; x=1763755510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J0L1rNSBbDA68/IWNXBGkYS13/51Kd8iUuA26ASfqQc=;
 b=AsQW12ucYZnwhtTO+ft9xRFmbdrF4nWLqE+JXtd0YBaKcPzGdCEwWoO+f3WLILRXup
 ShOxSPbQgd7gnycxuvSco+wqzwOuLn6ZK6+79iyCWkfBVRlqEJMfE3aR2QxodErbP2FR
 k8qQtwdbtzWoUW9bkWZUDR89QhLq99LMVhkZ6Ihbq0qcIP6VM3C4nayAUHNmNtcUPGmp
 DYkQ524Reh5oOEkOkjh1IIq1d1NLzmRMssqgAbsIFsnzb2WSp91bth80DvbapN10a2NC
 iiONFehNIN4hgX16jkU1EtLfKgU+EuZG4kXziW0J2x8hCuNcV/f+2HEs9phP6C2IFHS0
 seiQ==
X-Gm-Message-State: AOJu0Yz0HLcCKof3VrgMIvKqNNp7dRq5uYjdB1Bd4W/ieDbwABBSu4Ft
 Gzve0eJNgBcyJ06V+50VCEAspbaCRjGyiAsWRytCJXUuxHEv+iSFsZJfcxJ0f2rwPWL/qXyLhRq
 7jUKjKWS18g==
X-Gm-Gg: ASbGncv/t9aQn1K16URlM3SfvhqtGPTmEbJUI5vkwXSqIL3pJvGt7joLeNpOq8f7eAG
 26R3WTswyNUP/+Go/zJt25Nr0qKNipKfvLFU/moV4UfoU9lD7wLTiVwVtrat1962n8UUP7ZZ2HM
 y7I6za5KYw/yD+TdHUMlewWJWS37BQrSNQtTgwEolw0mT6vj8XEh0ciNh1MqBvaT29W0LGLRqpF
 fUdUcOKmhlLbZMoo9RdhD8D/H1NW/l/M/bMVbcMYh0Bs+ahbn0hARWcZAVQEePajXx/RjcG2kst
 cAuB3GVtv+e96OljQOh4HmEvR8rKFw4TAYMp7EXMjd3baPJ/KS6bOsWd5OR2i6GuZaoLOsY7YuC
 p5mnUJfnu1F3/IkJpQDdR0seiwTcGu86Nhy45ae41b0+UObHFwUS3UvpVSPPoFrTcEeDyX7jDOB
 +w7MgiRMn53g0o2THlUyEZ4dB1D/p5rYZE2zujGz5IemIM0v6eHQ==
X-Google-Smtp-Source: AGHT+IH9++UghT7X6TWmgQQDj8uViVogW81843lmyUpf5bakcr9SDWJjIwDBT+ZBb/wKPM503kpBQw==
X-Received: by 2002:a05:6000:2601:b0:42b:3d9d:c605 with SMTP id
 ffacd0b85a97d-42b5938f92fmr3950582f8f.49.1763150709726; 
 Fri, 14 Nov 2025 12:05:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b8a0sm11926516f8f.25.2025.11.14.12.05.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Nov 2025 12:05:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 06/19] accel/hvf: Simplify hvf_log_*
Date: Fri, 14 Nov 2025 21:04:08 +0100
Message-ID: <20251114200422.4280-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114200422.4280-1-philmd@linaro.org>
References: <20251114200422.4280-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index cb029e4dd4b..601e63c7f9a 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -204,45 +204,24 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
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
@@ -252,7 +231,8 @@ static void hvf_log_sync(MemoryListener *listener,
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


