Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97061091911
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Im6-0000c1-6j; Thu, 19 Mar 2026 15:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Im1-0000KD-3b
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:11:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Ilz-0008VQ-0N
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:11:12 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso1272702f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773947469; x=1774552269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8aNR9y2E9n4ZOiMZCdLhmicb9NfofciJCxllCBGqfg=;
 b=jiGSIUuM3Tm+S/sjUWoBD6JgoQ3WNHdTUhBYWgpHu3vK/aUBtid/nNNFXEAVwvhZVM
 MWIqaKrXED1u2N72bjWlPcZbzOSeV8dbxvwkHfJ0QuR5vqgzoXgulLkltHYeZHMSQAfl
 XkKXO7Ax5tJMXaZHRI3Rz9++TW2BJhD4y7g6L0/Pi5ljPoW59J4nIMj8WE4RpsWKhilf
 fsKgg7SfjUBReAd+DdZ0ixus9m1SSiAw70s0b14OfoRLlL0HB0W561ZdnCTQYVWujdTk
 6qCqr2iqCw/i0MrYACe8sOAq0nXBGO2uV1i0dHnLgFKy+a66iCniu+RSFwJ6actfZhmk
 1KNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947469; x=1774552269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z8aNR9y2E9n4ZOiMZCdLhmicb9NfofciJCxllCBGqfg=;
 b=XqVe8df5CotdpHoGCgI95rTzowrS5TgoFcKfmz4Em7jObDA/XOI+WmPS9fi7Qsp596
 P8Ncq/xeZKFXrDIQ19aRViVz2A9a875EHDMQD6+L4wGaFhghI82ZrSpuFb64d+4HS8CI
 5lLp6wLM4Me4R48ohKp9yuRpqiS4n2JuID3BEZSFBZTOOGMryZjW/lLiWjOFnv2inTP2
 nXqgbEj0TmVpPyJM/Sh6n5b7fLQEgOB7GrrNja5oTq2v6H3XYgdV26tloLjh3pqgZlRq
 NzoGHXVRRSI1itemaXLx6sHvxUXIYLPVVWVKLSBvd60NemEV2cfOo7lSA/I16Z4dnv0R
 hfRg==
X-Gm-Message-State: AOJu0YwCM0sFZJ1b7utnz0ChH05wUF1fhOdK8IltA+nO2qLTWawW4FM4
 +yf0USX1Y6OgmS8bKNDjH1rdD71ks14utnUYO8BqCwpKNH28fh+wcsT6vMsXh3aJTaU08WQeGA4
 QLiZewWw=
X-Gm-Gg: ATEYQzxR0gZPelREIf7H/m0iER7dcn2iL1GeNlZA805IXeH6U1clO0R+JzqqW6lK+qr
 LOl3+OmkdeDBfUUBphIukI4oZ95dYbTT7Y0uxVFugLW/o1zecbawYUlndssMkSrEWTgAmOXjuNV
 iT897cFpg72TUrBTCIRfyv8wdSyfPBVrDbZ8ql7CCoOkyHg747C64AGp2Y9xOF8CXEyOtbeQxMP
 jkDNJT1IjEv2c5tN1X5eu/9T7+MVu1TNJmBF+g4a2BCOSWQ/MfDMDMVTAdySFiBl1M1M73qML4p
 96ANbXnIUvvu/5EoS0GQdJciIY6esHf+pNM1s0Cqf1XR4kWrgOzCl4NqHjO8xTOcjUafN/tlKWQ
 0A8dUG6OVCRL5dALsJkBiFx0Aa716gznNfegb4r2HPEXGWZOBOCB+ELTs12ZD0zlIvkQYFDBu5E
 zUSmq4Yk+XDb9XPRlqN+DtmAu/ViDFDmkdQGRY/icON2wAf79r8pANbvMNT3awzDS4yVRbVpeb
X-Received: by 2002:a05:6000:4013:b0:439:c2b6:d5d8 with SMTP id
 ffacd0b85a97d-43b64278337mr793064f8f.36.1773947468809; 
 Thu, 19 Mar 2026 12:11:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470380asm637590f8f.24.2026.03.19.12.11.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 12:11:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 7/8] system/memory: Constify various AddressSpace
 arguments (access)
Date: Thu, 19 Mar 2026 20:10:16 +0100
Message-ID: <20260319191017.12636-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319191017.12636-1-philmd@linaro.org>
References: <20260319191017.12636-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Mark the AddressSpace structure const when it is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h | 19 ++++++++++---------
 system/physmem.c        | 16 +++++++++-------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 4c013593cae..564b94f1448 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2698,7 +2698,7 @@ void address_space_remove_listeners(const AddressSpace *as);
  * @len: the number of bytes to read or write
  * @is_write: indicates the transfer direction
  */
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_rw(const AddressSpace *as, hwaddr addr,
                              MemTxAttrs attrs, void *buf,
                              hwaddr len, bool is_write);
 
@@ -2715,7 +2715,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
  * @buf: buffer with the data transferred
  * @len: the number of bytes to write
  */
-MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_write(const AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
                                 const void *buf, hwaddr len);
 
@@ -2741,7 +2741,7 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
  * @buf: buffer with the data transferred
  * @len: the number of bytes to write
  */
-MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_write_rom(const AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
                                     const void *buf, hwaddr len);
 
@@ -2768,17 +2768,18 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 
 #define SUFFIX
 #define ARG1         as
-#define ARG1_DECL    AddressSpace *as
+#define ARG1_DECL    const AddressSpace *as
 #include "system/memory_ldst.h.inc"
 
 #ifndef TARGET_NOT_USING_LEGACY_LDST_PHYS_API
 #define SUFFIX
 #define ARG1         as
-#define ARG1_DECL    AddressSpace *as
+#define ARG1_DECL    const AddressSpace *as
 #include "system/memory_ldst_phys.h.inc"
 #endif
 
-void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len);
+void address_space_flush_icache_range(const AddressSpace *as,
+                                      hwaddr addr, hwaddr len);
 
 /* address_space_get_iotlb_entry: translate an address into an IOTLB
  * entry. Should be called from an RCU critical section.
@@ -2898,7 +2899,7 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
 void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
 
 /* Internal functions, part of the implementation of address_space_read.  */
-MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read_full(const AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, void *buf, hwaddr len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *buf,
@@ -2953,7 +2954,7 @@ static inline bool memory_access_is_direct(const MemoryRegion *mr,
  * @len: length of the data transferred
  */
 static inline __attribute__((__always_inline__))
-MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read(const AddressSpace *as, hwaddr addr,
                                MemTxAttrs attrs, void *buf,
                                hwaddr len)
 {
@@ -2996,7 +2997,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
  * @len: the number of bytes to fill with the constant byte
  * @attrs: memory transaction attributes
  */
-MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_set(const AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
 /* Coalesced MMIO regions are areas where write operations can be reordered.
diff --git a/system/physmem.c b/system/physmem.c
index b7280e74aa2..8327b7c3de1 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3424,7 +3424,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
                                   mr_addr, l, mr);
 }
 
-MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read_full(const AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, void *buf, hwaddr len)
 {
     MemTxResult result = MEMTX_OK;
@@ -3439,7 +3439,7 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
     return result;
 }
 
-MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_write(const AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
                                 const void *buf, hwaddr len)
 {
@@ -3455,7 +3455,8 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
     return result;
 }
 
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
+MemTxResult address_space_rw(const AddressSpace *as,
+                             hwaddr addr, MemTxAttrs attrs,
                              void *buf, hwaddr len, bool is_write)
 {
     if (is_write) {
@@ -3465,7 +3466,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
     }
 }
 
-MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_set(const AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs)
 {
 #define FILLBUF_SIZE 512
@@ -3497,7 +3498,7 @@ void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
 }
 
 /* used for ROM loading : can write in RAM and ROM */
-MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_write_rom(const AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
                                     const void *buf, hwaddr len)
 {
@@ -3522,7 +3523,8 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
     return MEMTX_OK;
 }
 
-void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len)
+void address_space_flush_icache_range(const AddressSpace *as,
+                                      hwaddr addr, hwaddr len)
 {
     /*
      * This function should do the same thing as an icache flush that was
@@ -3828,7 +3830,7 @@ void cpu_physical_memory_unmap(void *buffer, hwaddr len,
     return address_space_unmap(&address_space_memory, buffer, len, is_write, access_len);
 }
 
-#define ARG1_DECL                AddressSpace *as
+#define ARG1_DECL                const AddressSpace *as
 #define ARG1                     as
 #define SUFFIX
 #define TRANSLATE(...)           address_space_translate(as, __VA_ARGS__)
-- 
2.53.0


