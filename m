Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250B5FCA16D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfSa-0007KI-Pt; Mon, 09 Mar 2026 14:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzfSY-0007It-Rm
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:36:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzfSW-0003Wc-2J
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:36:06 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439afc58ac7so9317117f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773081360; x=1773686160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frENE9FJEJIJp1aKXCLyQE1na5fHvR5E0RLXQsidK/I=;
 b=FVuB7hI1I9L+alt7sXJTJ9gJNjJxDciSFG7wenIx+3mB9B+klRT94CXN5ylh3BhHwe
 NW7FNE1pdyFxT+T/gQfJUWBFu/6KPJs/6C4R7ZVwePMTTDiqE0VhoEE202zxoKXLDNoK
 7s1QYNoU+TITdb6G336hEHVXe2KFmLnqwfeVSQFwqQb9qEO1v5A0JuqfO9PVsYkNI4zc
 zyWHkqcrBqpWK35RpTir8qjKGmmWYeV384shvz2/HBfOrTelSsilUzA0y1pbw4Wjfttt
 WO2LghoLLgnwrKypvuPYnDlmM+NygfUKSMgaLsm3Kwbh4FLV+mPCooFVQHydTLzLHfBL
 GXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773081360; x=1773686160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=frENE9FJEJIJp1aKXCLyQE1na5fHvR5E0RLXQsidK/I=;
 b=O3dmhisBP6xigB7cHr0XZTZQVVN4OWc8FPH2qXdo0yz4amoUI/+OnZAFWdSfukL7Xy
 2H6YUEaKllQI3r2rOlZnxfBLZZyPOgn8uzhtq3eRXsXx+mg8nBoBJjiHZ3hifjohXOWr
 QbQ9KPR1iZDlpEYw7GOX5/rhb7sgELRyMGxwyLBPbAYEegxNl49YtERDZKfd+ziqFwlf
 0bdp3O50hcmaRvaxJR7ckhkbCRkUCtoKZVD5qE2mHkhU0fjkTrff/mmLFTjQOskxEV4T
 TFnCxQVeR5RCZW0XRw46nqJlGrB4y0aID7A8sLKYwQ1TffLFoQEXPZgpN4P/oFZB/v4N
 Kt2A==
X-Gm-Message-State: AOJu0YxtjiKVe/MTUembgSvZCKmgDnuN38rwMGjOJ1r0XhHXxHOOeUTT
 lmcBuJWTrMRvBixYECYFnhLKyAHy2DjrLVl8l35G9NRDKBkZbCU+pD/2xgtBGkj34hAIu4s0WFU
 BcfM3qKo=
X-Gm-Gg: ATEYQzyJkwqRSCee4KEM/9aGBJnhQUkqttluoiJr9c6Q3UxyTN+KYF52nus8rCvaUUl
 bXWZQ1uYdMURAFjrEaGz9dG8M4/4c1fyYNtWP3UsWK8cJKhyjbd4HHWNq/azcK3+/MdpW2FwPDU
 hFBpLgfFpPtokvaK5Nb1W+K4uPkv7bu5Ol8oGHr9Xo6bwXT+xP5VxsrQN1dU9Pm+TXSVMi4zXDe
 Hu/1oDTxKXpsrZtwThhtP8JvCNBXnv0ed5dy49cHk+G7P+ArBQvRd5LCexFnURRgjGa5LWggkCy
 DwjE0y0mRM7KFEBb623PgCO4oN3BbQnBcnzr+07nHcrhGRYIPducuhLliR4cfBXLMU362VesMz+
 nAqHeAOHMUO/lejn5+aRtgWaWKKyYaDq7g39V3+7XUcc8TvjIuUSUDO7aU/cmC9s6VC91jeueET
 9DIhL3/5YmHp9IUsgKLH7B81tbxNOme8h3U9RxI/yxBKFLhJkW0nkaCyzE4FnFzWfrdenAFDGx
X-Received: by 2002:a05:6000:2681:b0:439:be4e:6e58 with SMTP id
 ffacd0b85a97d-439da891d17mr20945001f8f.47.1773081360467; 
 Mon, 09 Mar 2026 11:36:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad977f8sm28487057f8f.9.2026.03.09.11.35.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 11:35:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 3/4] system/xen: Constify various MemoryRegion arguments
Date: Mon,  9 Mar 2026 19:35:34 +0100
Message-ID: <20260309183536.88976-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309183536.88976-1-philmd@linaro.org>
References: <20260309183536.88976-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Mark the MemoryRegion structure const when is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/xen-mapcache.h | 2 +-
 include/system/xen.h          | 6 +++---
 hw/xen/xen-hvm-common.c       | 8 ++++----
 hw/xen/xen-mapcache.c         | 2 +-
 hw/xen/xen_stubs.c            | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/system/xen-mapcache.h b/include/system/xen-mapcache.h
index c46190dd0ce..114d1929c80 100644
--- a/include/system/xen-mapcache.h
+++ b/include/system/xen-mapcache.h
@@ -16,7 +16,7 @@ typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
 bool xen_map_cache_enabled(void);
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
-uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
+uint8_t *xen_map_cache(const MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
                        ram_addr_t ram_addr_offset,
                        uint8_t lock, bool dma,
                        bool is_write);
diff --git a/include/system/xen.h b/include/system/xen.h
index 9a7c53f2838..43b857e4d15 100644
--- a/include/system/xen.h
+++ b/include/system/xen.h
@@ -30,7 +30,7 @@ extern bool xen_allowed;
 
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                   struct MemoryRegion *mr, Error **errp);
-bool xen_mr_is_memory(MemoryRegion *mr);
-bool xen_mr_is_grants(MemoryRegion *mr);
+                   const MemoryRegion *mr, Error **errp);
+bool xen_mr_is_memory(const MemoryRegion *mr);
+bool xen_mr_is_grants(const MemoryRegion *mr);
 #endif
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index eb7f6270a0d..62d88804c43 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -23,19 +23,19 @@
 MemoryRegion xen_memory, xen_grants;
 
 /* Check for any kind of xen memory, foreign mappings or grants.  */
-bool xen_mr_is_memory(MemoryRegion *mr)
+bool xen_mr_is_memory(const MemoryRegion *mr)
 {
     return mr == &xen_memory || mr == &xen_grants;
 }
 
 /* Check specifically for grants.  */
-bool xen_mr_is_grants(MemoryRegion *mr)
+bool xen_mr_is_grants(const MemoryRegion *mr)
 {
     return mr == &xen_grants;
 }
 
-void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
-                   Error **errp)
+void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
+                   const MemoryRegion *mr, Error **errp)
 {
     unsigned target_page_bits = qemu_target_page_bits();
     unsigned long nr_pfn;
diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index a3c162cd4c6..85cf0cf359c 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -460,7 +460,7 @@ tryagain:
     return mc->last_entry->vaddr_base + address_offset;
 }
 
-uint8_t *xen_map_cache(MemoryRegion *mr,
+uint8_t *xen_map_cache(const MemoryRegion *mr,
                        hwaddr phys_addr, hwaddr size,
                        ram_addr_t ram_addr_offset,
                        uint8_t lock, bool dma,
diff --git a/hw/xen/xen_stubs.c b/hw/xen/xen_stubs.c
index a39efb5062d..f830768d998 100644
--- a/hw/xen/xen_stubs.c
+++ b/hw/xen/xen_stubs.c
@@ -19,12 +19,12 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 }
 
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                   struct MemoryRegion *mr, Error **errp)
+                   const MemoryRegion *mr, Error **errp)
 {
     g_assert_not_reached();
 }
 
-bool xen_mr_is_memory(MemoryRegion *mr)
+bool xen_mr_is_memory(const MemoryRegion *mr)
 {
     g_assert_not_reached();
 }
@@ -44,7 +44,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     g_assert_not_reached();
 }
 
-uint8_t *xen_map_cache(MemoryRegion *mr,
+uint8_t *xen_map_cache(const MemoryRegion *mr,
                        hwaddr phys_addr,
                        hwaddr size,
                        ram_addr_t ram_addr_offset,
-- 
2.53.0


